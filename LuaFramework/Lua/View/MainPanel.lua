local transform;
local gameObject;

MainPanel = {};
local this = MainPanel;

--启动事件--
function MainPanel.Awake(obj)
	gameObject = obj;
	transform = obj.transform;

	this.InitPanel();
	logWarn("Awake lua--->>"..gameObject.name);
end

--初始化面板--
function MainPanel.InitPanel()
    this.playerName = transform:Find("playerName").gameObject;
    this.shopBtn = transform:Find("shopBtn").gameObject;
    this.coinNum=transform:Find("coinNum").gameObject;
    this.pvpBtn=transform:Find("pvpBtn").gameObject;
    this.pveBtn=transform:Find("pveBtn").gameObject;
    this.playerImg=transform:Find("playerImg").gameObject;
    this.chatBlock=transform:Find("chatBlock").gameObject;
    this.chatBtn=this.chatBlock.transform:Find("chatBtn").gameObject;
    this.sendBtn=this.chatBlock.transform:Find("sendBtn").gameObject;
    this.listContent=this.chatBlock.transform:Find("chatlist/Viewport/Content").gameObject;
    this.chatcell=this.listContent.transform:Find("cell").gameObject;
    this.chatInput=this.chatBlock.transform:Find("chatInput").gameObject;
end

--单击事件--
function MainPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
end
