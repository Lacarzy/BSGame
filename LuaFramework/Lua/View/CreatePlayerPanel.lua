local transform;
local gameObject;

CreatePlayerPanel = {};
local this = CreatePlayerPanel;

--启动事件--
function CreatePlayerPanel.Awake(obj)
	gameObject = obj;
	transform = obj.transform;

	this.InitPanel();
	logWarn("Awake lua--->>"..gameObject.name);
end

--初始化面板--
function CreatePlayerPanel.InitPanel()
    this.playerNameInput = transform:Find("playerNameInput").gameObject;
    this.selectBtn = transform:Find("selectBtn").gameObject;
    this.listContent=transform:Find("playerList/Viewport/Content").gameObject;
    this.cell=this.listContent.transform:Find("cell").gameObject;
end

--单击事件--
function CreatePlayerPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
end
