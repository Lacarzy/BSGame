
CtrlNames = {
	Prompt = "Prompt",
	Message = "Message",
	Title = "Title",
	Tips="Tips",
	CreatePlayer="CreatePlayer",
	Main="Main",
	Shop="Shop",
}

PanelNames = {
	"PromptPanel",	
	"MessagePanel",
	"TitlePanel",
	"TipsPanel",
	"CreatePlayerPanel",
	"MainPanel",
	"ShopPanel",
}

--协议类型--
ProtocalType = {
	BINARY = 0,
	PB_LUA = 1,
	PBC = 2,
	SPROTO = 3,
}
--当前使用的协议类型--
TestProtoType = ProtocalType.PB_LUA;

Util = LuaFramework.Util;
AppConst = LuaFramework.AppConst;
LuaHelper = LuaFramework.LuaHelper;
ByteBuffer = LuaFramework.ByteBuffer;

resMgr = LuaHelper.GetResManager();
panelMgr = LuaHelper.GetPanelManager();
soundMgr = LuaHelper.GetSoundManager();
networkMgr = LuaHelper.GetNetManager();

WWW = UnityEngine.WWW;
GameObject = UnityEngine.GameObject;