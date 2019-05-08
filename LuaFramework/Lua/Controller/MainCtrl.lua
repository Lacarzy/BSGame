MainCtrl = {};
local this = MainCtrl;

local transform;
local gameObject;
local main;
local chat;

--构建函数--
function MainCtrl.New()
	logWarn("MainCtrl.New--->>");
	return this;
end

function MainCtrl.Awake()
	logWarn("MainCtrl.Awake--->>");
	panelMgr:CreatePanel('Main', this.OnCreate);
end

--启动事件--
function MainCtrl.OnCreate(obj)
    gameObject = obj;
    transform = obj.transform;
    main=transform:GetComponent('LuaBehaviour');
    main:AddClick(MainPanel.shopBtn, this.OnClickShop);
    main:AddClick(MainPanel.pvpBtn,this.OnClickPvp);
    main:AddClick(MainPanel.pveBtn,this.OnClickPve);
    MainPanel.playerName:GetComponent("Text").text=MyPlayer.playerName;
    MainPanel.coinNum:GetComponent("Text").text=tostring(MyPlayer.coin);
    local assetname="driver"..tostring(MyPlayer.nowUseShape);
    setImg(MainPanel.playerImg,"createplayer_asset",assetname);
    chat=0;--0代表关闭聊天面板
    main:AddClick(MainPanel.chatBtn,this.OnClickChat);
    main:AddClick(MainPanel.sendBtn,this.OnClickSend);
end

function MainCtrl.OnClickChat()
    -- body
    if chat==0 then
        MainPanel.chatBlock:GetComponent("Animation"):Play("showBlock");
        chat=1;
    else
        MainPanel.chatBlock:GetComponent("Animation"):Play("hideBlock");
        chat=0;
    end
end

function MainCtrl.OnClickSend()
    -- body
    local message=MainPanel.chatInput:GetComponent("InputField").text;
    if message==nil or message=="" then
        TipsCtrl.SetText("不能发送空消息");
    else
        local go = newObject(MainPanel.chatcell);
        go:SetActive(true);
        go.transform:SetParent(MainPanel.listContent.transform);
        go.transform.localScale = Vector3.one;
        go.transform.localPosition = Vector3.zero;
        local ctext=go.transform:Find("Text").gameObject;
        ctext:GetComponent("Text").text="我:"..message;
        this.ChatMsgTos(message);
    end
end

--发送聊天协议到服务端
function MainCtrl.ChatMsgTos(message)
    local chatmsg = allpb_pb.TipsMessage();
    chatmsg.tips = message;
    local msg = chatmsg:SerializeToString();
    ----------------------------------------------------------------
    local buffer = ByteBuffer.New();
    buffer:WriteShort(Protocal.ChatMsg);
    buffer:WriteByte(ProtocalType.PB_LUA);
    buffer:WriteBuffer(msg);
    networkMgr:SendMessage(buffer);
end

function MainCtrl.HandleChatMsg(buffer)
    -- body
    local data = buffer:ReadBuffer();  
    local msg = allpb_pb.TipsMessage();
    msg:ParseFromString(data);
    local chattext=msg.tips;
    local go = newObject(MainPanel.chatcell);
    go:SetActive(true);
    go.transform:SetParent(MainPanel.listContent.transform);
    go.transform.localScale = Vector3.one;
    go.transform.localPosition = Vector3.zero;
    local ctext=go.transform:Find("Text").gameObject;
    ctext:GetComponent("Text").text=chattext;
end

function MainCtrl.OnClickShop(go)
    -- body
    OpenPanel(CtrlNames.Shop);
end

function MainCtrl.OnClickPvp(go)
    -- body
    logError("pvp按钮被点击");
end

function MainCtrl.OnClickPve(go)
    -- body
    logError("pve按钮被点击");
end

--单击事件--
function MainCtrl.OnClick(go)
	destroy(gameObject);
end

--关闭事件--
function MainCtrl.Close()
    panelMgr:ClosePanel(CtrlNames.Main);
end