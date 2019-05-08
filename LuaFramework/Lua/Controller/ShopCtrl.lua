ShopCtrl = {};
local this = ShopCtrl;

local transform;
local gameObject;
local shop;
local shoplist;
local wantbuyshape;
local havedshape;

--构建函数--
function ShopCtrl.New()
	logWarn("ShopCtrl.New--->>");
	return this;
end

function ShopCtrl.Awake()
	logWarn("ShopCtrl.Awake--->>");
	panelMgr:CreatePanel('Shop', this.OnCreate);
end

--启动事件--
function ShopCtrl.OnCreate(obj)
    gameObject = obj;
    transform = obj.transform;
    shop=transform:GetComponent('LuaBehaviour');
    logWarn("Start lua--->>"..gameObject.name);
    ShopPanel.coinNum:GetComponent("Text").text=tostring(MyPlayer.coin);
    shop:AddClick(ShopPanel.backBtn,this.OnClickBack);
    shop:AddClick(ShopPanel.okBtn,this.OnClickSureBuy);
    shop:AddClick(ShopPanel.noBtn,this.OnClickCancel);
    shoplist={};
    this.RefreshList();
end

function ShopCtrl.OnClickSureBuy()
    -- body
    if MyPlayer.coin<wantbuyshape*50+300 then
        TipsCtrl.SetText("金币不足");
    else
        this.BuyShapeTos();
    end
    ShopPanel.sureBuy:SetActive(false);
end

function ShopCtrl.OnClickCancel()
    -- body
    ShopPanel.sureBuy:SetActive(false);
end

function ShopCtrl.OnClickBack()
    -- body
    OpenPanel(CtrlNames.Main);
end

function ShopCtrl.RefreshList()
    -- body
    -- for i=1,#shoplist do
    --     destroy(shoplist[i]);
    -- end
    local count = 10; 
	local parent = ShopPanel.listContent;
    for i = 1, count do
		local go = newObject(ShopPanel.cell);
		go.name =tostring(i);
		go.transform:SetParent(parent.transform);
		go.transform.localScale = Vector3.one;
		go.transform.localPosition = Vector3.zero;
        go:SetActive(true);
	    local playerImg = go.transform:Find("playerImg").gameObject;
        local assetname="driver"..tostring(i);
        setImg(playerImg,"createplayer_asset",assetname);
        shoplist[i]=go;
        local nowuse=go.transform:Find("nowuse").gameObject;
        local nohave=go.transform:Find("nohave").gameObject;
        local have=go.transform:Find("have").gameObject;
        local useBtn=have.transform:Find("useBtn").gameObject;
        useBtn.name="useBtn"..tostring(i);
        shop:AddClick(useBtn,this.OnClickUse);
        local buyBtn=nohave.transform:Find("buyBtn").gameObject;
        buyBtn.name="buyBtn"..tostring(i);
        local cost=nohave.transform:Find("cost").gameObject;
        cost:GetComponent("Text").text=tostring(i*50+300);
        shop:AddClick(buyBtn, this.OnClickBuy);
        while true do
            -- body
            --使用while+break模仿continue;
            if i==MyPlayer.nowUseShape then
                -- body
                nowuse:SetActive(true);
                nohave:SetActive(false); 
                have:SetActive(false);
                break;
            elseif true then
                -- body
                for k=1,#MyPlayer.allShape do
                    havedshape=0;
                    if MyPlayer.allShape[k]==i then
                        -- body
                        nowuse:SetActive(false);
                        nohave:SetActive(false); 
                        have:SetActive(true);                
                        havedshape=1;
                        break;
                    end
                end
                if havedshape==1 then
                    break;
                else
                    nowuse:SetActive(false);
                    nohave:SetActive(true); 
                    have:SetActive(false);               
                    break;
                end
            end
        end
	end
end

function ShopCtrl.OnClickUse(go)
    -- body
    logError("要使用的是"..go.transform.parent.parent.name);
    local useShape=tonumber(go.transform.parent.parent.name);
    this.UseShapeTos(useShape);
end

function ShopCtrl.OnClickBuy(go)
    -- body
    wantbuyshape=tonumber(go.transform.parent.parent.name);
    ShopPanel.sureBuy:SetActive(true);
    ShopPanel.cost:GetComponent("Text").text=tostring(wantbuyshape*50+300);

end


--发送使用协议到服务端
function ShopCtrl.UseShapeTos(useshape)
    local UseShape = allpb_pb.UseShapeRequest();
    UseShape.shape=useshape;
    local msg = UseShape:SerializeToString();
    ----------------------------------------------------------------
    local buffer = ByteBuffer.New();
    buffer:WriteShort(Protocal.UseShape);
    buffer:WriteByte(ProtocalType.PB_LUA);
    buffer:WriteBuffer(msg);
    networkMgr:SendMessage(buffer);
end

--发送购买协议到服务端
function ShopCtrl.BuyShapeTos()
    local BuyShape = allpb_pb.BuyShapeRequest();
    BuyShape.shape=wantbuyshape;
    local msg = BuyShape:SerializeToString();
    ----------------------------------------------------------------
    local buffer = ByteBuffer.New();
    buffer:WriteShort(Protocal.BuyShape);
    buffer:WriteByte(ProtocalType.PB_LUA);
    buffer:WriteBuffer(msg);
    networkMgr:SendMessage(buffer);
end

function ShopCtrl.HandleUseMsg(buffer)
    -- body
    local data = buffer:ReadBuffer();  
    local msg = allpb_pb.UseShapeResponse();
    msg:ParseFromString(data);
    if msg.succ==1 then
       shoplist[MyPlayer.nowUseShape].transform:Find("nowuse").gameObject:SetActive(false);
       shoplist[MyPlayer.nowUseShape].transform:Find("have").gameObject:SetActive(true);
       MyPlayer.nowUseShape=msg.nowUseShape;
       shoplist[MyPlayer.nowUseShape].transform:Find("nowuse").gameObject:SetActive(true);
       shoplist[MyPlayer.nowUseShape].transform:Find("have").gameObject:SetActive(false);
    end
end

function ShopCtrl.HandleBuyMsg(buffer)
    -- body
    local data = buffer:ReadBuffer();  
    local msg = allpb_pb.BuyShapeResponse();
    msg:ParseFromString(data);
    if msg.succ==1 then
       shoplist[wantbuyshape].transform:Find("nohave").gameObject:SetActive(false);
       shoplist[wantbuyshape].transform:Find("have").gameObject:SetActive(true);
       MyPlayer=msg.playerInfo;
       ShopPanel.coinNum:GetComponent("Text").text=tostring(MyPlayer.coin);
    end
end


--单击事件--
function ShopCtrl.OnClick(go)
	destroy(gameObject);
end

--关闭事件--
function ShopCtrl.Close()
    panelMgr:ClosePanel(CtrlNames.Shop);
end