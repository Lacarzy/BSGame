TipsCtrl = {};
local this = TipsCtrl;

local transform;
local gameObject;
local tips;

--构建函数--
function TipsCtrl.New()
	logWarn("TipsCtrl.New--->>");
	return this;
end

function TipsCtrl.Awake()
	logWarn("TipsCtrl.Awake--->>");
	panelMgr:CreatePanel('Tips', this.OnCreate);
end

--启动事件--
function TipsCtrl.OnCreate(obj)
    gameObject = obj;
    transform = obj.transform;
    tips=transform:GetComponent('LuaBehaviour');
    tips:AddClick(TipsPanel.quitBtn, this.Close);
    logWarn("Start lua--->>"..gameObject.name);
    gameObject:SetActive(false);
end

--设置Tips内容
function TipsCtrl.SetText(arg)
    TipsPanel.Message:GetComponent("Text").text=arg;
    gameObject:SetActive(true);
end

--单击事件--
function TipsCtrl.OnClick(go)
	destroy(gameObject);
end

--关闭事件--
function TipsCtrl.Close()
    gameObject:SetActive(false);
    --panelMgr:ClosePanel(CtrlNames.Tips);
end

function TipsCtrl.HandleSeverMsg(buffer)
    local data = buffer:ReadBuffer();  
    local msg = allpb_pb.TipsMessage();
    msg:ParseFromString(data);
	this.SetText(msg.tips);
end