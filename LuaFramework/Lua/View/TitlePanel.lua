local transform;
local gameObject;

TitlePanel = {};
local this = TitlePanel;

--启动事件--
function TitlePanel.Awake(obj)
	gameObject = obj;
	transform = obj.transform;

	this.InitPanel();
	logWarn("Awake lua--->>"..gameObject.name);
end

--初始化面板--
function TitlePanel.InitPanel()
    this.playBtn = transform:Find("playBtn").gameObject;
	this.quitBtn = transform:Find("quitBtn").gameObject;
	this.loginPanel=transform:Find("Login").gameObject;
	this.usernameInput=this.loginPanel.transform:Find("usernameInput").gameObject;
	this.passwordInput=this.loginPanel.transform:Find("passwordInput").gameObject;
	this.signBtn=this.loginPanel.transform:Find("signBtn").gameObject;
	this.loginBtn=this.loginPanel.transform:Find("loginBtn").gameObject;
	this.closeBtn=this.loginPanel.transform:Find("closeBtn").gameObject;
end

--单击事件--
function TitlePanel.OnDestroy()
	logWarn("OnDestroy---->>>");
end
