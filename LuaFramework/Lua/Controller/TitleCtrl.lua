require "Common/define"

require "3rd/pblua/allpb_pb"
require "3rd/pbc/protobuf"

local sproto = require "3rd/sproto/sproto"
local core = require "sproto.core"
local print_r = require "3rd/sproto/print_r"

TitleCtrl = {};
local this = TitleCtrl;

local transform;
local gameObject;
local title;

--构建函数--
function TitleCtrl.New()
	logWarn("TitleCtrl.New--->>");
	return this;
end

function TitleCtrl.Awake()
	logWarn("TitleCtrl.Awake--->>");
	panelMgr:CreatePanel('Title', this.OnCreate);
end

--启动事件--
function TitleCtrl.OnCreate(obj)
	gameObject = obj;
	title = gameObject:GetComponent('LuaBehaviour');
	title:AddClick(TitlePanel.playBtn, this.OnClickPlayBtn);
	logWarn("Start lua--->>"..gameObject.name);
	TitlePanel.loginPanel:SetActive(false);
	title:AddClick(TitlePanel.signBtn,this.OnClickSignBtn);
	title:AddClick(TitlePanel.closeBtn,this.OnClickCloseBtn);
	title:AddClick(TitlePanel.loginBtn,this.OnClickLoginBtn);
end

--单击事件--
function TitleCtrl.OnClickPlayBtn(go)
	TitlePanel.loginPanel:SetActive(true);
end

function TitleCtrl.OnClickSignBtn()
	local username = TitlePanel.usernameInput:GetComponent("InputField").text;
	local password = TitlePanel.passwordInput:GetComponent("InputField").text;
	logError(username.."    "..password);
	this.SignTos(username,password);
end

function TitleCtrl.OnClickCloseBtn()
	TitlePanel.loginPanel:SetActive(false);
	TitlePanel.usernameInput:GetComponent("InputField").text="";
	TitlePanel.passwordInput:GetComponent("InputField").text="";
	logError("关闭监听");
end

function TitleCtrl.OnClickLoginBtn()
	local username = TitlePanel.usernameInput:GetComponent("InputField").text;
	local password = TitlePanel.passwordInput:GetComponent("InputField").text;
	logError(username.."    "..password);
	this.LoginTos(username,password);
end

--关闭事件--
function TitleCtrl.Close()
	panelMgr:ClosePanel(CtrlNames.Title);
end

--发送登陆协议到服务端
function TitleCtrl.LoginTos(username,password)
    local login = allpb_pb.LoginRequest();
    login.username = username;
    login.password = password;
    local msg = login:SerializeToString();
    ----------------------------------------------------------------
    local buffer = ByteBuffer.New();
    buffer:WriteShort(Protocal.Login);
    buffer:WriteByte(ProtocalType.PB_LUA);
    buffer:WriteBuffer(msg);
    networkMgr:SendMessage(buffer);
end

--发送注册协议到服务端
function TitleCtrl.SignTos(username,password)
    local login = allpb_pb.LoginRequest();
    login.username = username;
    login.password = password;
    local msg = login:SerializeToString();
    ----------------------------------------------------------------
    local buffer = ByteBuffer.New();
    buffer:WriteShort(Protocal.Sign);
    buffer:WriteByte(ProtocalType.PB_LUA);
    buffer:WriteBuffer(msg);
    networkMgr:SendMessage(buffer);
end
