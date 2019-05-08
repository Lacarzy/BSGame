local transform;
local gameObject;

ShopPanel = {};
local this = ShopPanel;

--启动事件--
function ShopPanel.Awake(obj)
	gameObject = obj;
	transform = obj.transform;

	this.InitPanel();
	logWarn("Awake lua--->>"..gameObject.name);
end

--初始化面板--
function ShopPanel.InitPanel()
    this.backBtn = transform:Find("backBtn").gameObject;
    this.coinNum=transform:Find("coinNum").gameObject;
    this.listContent=transform:Find("playerList/Viewport/Content").gameObject;
	this.cell=this.listContent.transform:Find("cell").gameObject;
	this.sureBuy=transform:Find("sureBuy").gameObject;
	this.okBtn=this.sureBuy.transform:Find("yesbtn").gameObject;
	this.noBtn=this.sureBuy.transform:Find("nobtn").gameObject;
	this.cost=this.sureBuy.transform:Find("cost").gameObject;
end

--单击事件--
function MainPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
end
