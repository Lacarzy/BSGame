
require "Common/define"
require "Common/protocal"
require "Common/functions"
Event = require 'events'

require "3rd/pblua/allpb_pb"
require "3rd/pbc/protobuf"

local sproto = require "3rd/sproto/sproto"
local core = require "sproto.core"
local print_r = require "3rd/sproto/print_r"

Network = {};
local this = Network;

local transform;
local gameObject;
local islogging = false;

function Network.Start() 
    logWarn("Network.Start!!");
    Event.AddListener(Protocal.Connect, this.OnConnect); 
    Event.AddListener(Protocal.Message, this.OnMessage); 
    Event.AddListener(Protocal.CommonTips,TipsCtrl.HandleSeverMsg);
    Event.AddListener(Protocal.Exception, this.OnException); 
    Event.AddListener(Protocal.Disconnect, this.OnDisconnect); 
    Event.AddListener(Protocal.Login,this.OnLoginMsg);
    Event.AddListener(Protocal.CreatePlayer,this.OnCreatePlayerMsg);
    Event.AddListener(Protocal.UseShape,ShopCtrl.HandleUseMsg);
    Event.AddListener(Protocal.BuyShape,ShopCtrl.HandleBuyMsg);
    Event.AddListener(Protocal.ChatMsg,MainCtrl.HandleChatMsg);
end

--登陆回调
function Network.OnLoginMsg(buffer)
    local data = buffer:ReadBuffer();
    local msg = allpb_pb.LoginResponse();
    msg:ParseFromString(data);
    if msg.succ==1 then

        logError("Msg解析成功");
        --local playerinfo=allpb_pb.PlayerInfo();
        MyPlayer=msg.playerInfo;
        if MyPlayer.playerId == 0 then
             --创建角色加载
            OpenPanel(CtrlNames.CreatePlayer);
        else
            OpenPanel(CtrlNames.Main);
        end
    end
end

--创建角色回调
function Network.OnCreatePlayerMsg(buffer)
    -- body
    local data = buffer:ReadBuffer();
    local msg = allpb_pb.LoginResponse();
    msg:ParseFromString(data);
    if msg.succ==1 then
        MyPlayer=msg.playerInfo;
        OpenPanel(CtrlNames.Main);
    end
end

--Socket消息--
function Network.OnSocket(key, data)
    Event.Brocast(tostring(key), data);
end

--当连接建立时--
function Network.OnConnect() 
    logWarn("Game Server connected!!");
end

--异常断线--
function Network.OnException() 
    islogging = false; 
    NetManager:SendConnect();
   	logError("OnException------->>>>");
end

--连接中断，或者被踢掉--
function Network.OnDisconnect() 
    islogging = false; 
    logError("OnDisconnect------->>>>");
end

--登录返回--
function Network.OnMessage(buffer) 
	if TestProtoType == ProtocalType.BINARY then
		this.TestLoginBinary(buffer);
	end
	if TestProtoType == ProtocalType.PB_LUA then
		this.TestLoginPblua(buffer);
	end
	if TestProtoType == ProtocalType.PBC then
		this.TestLoginPbc(buffer);
	end
	if TestProtoType == ProtocalType.SPROTO then
		this.TestLoginSproto(buffer);
	end
	----------------------------------------------------
    local ctrl = CtrlManager.GetCtrl(CtrlNames.Message);
    if ctrl ~= nil then
        ctrl:Awake();
    end
    logWarn('OnMessage-------->>>');
end

--二进制登录--
function Network.TestLoginBinary(buffer)
	local protocal = buffer:ReadByte();
	local str = buffer:ReadString();
	log('TestLoginBinary: protocal:>'..protocal..' str:>'..str);
end

--PBLUA登录--
function Network.TestLoginPblua(buffer)
    logError("消息到达lua层登陆");
	--local protocal = buffer:ReadShort(); 
    local data = buffer:ReadBuffer();
    
    local msg = allpb_pb.LoginResponse();
    msg:ParseFromString(data);
	log("msg:"..msg.id);
end

--PBC登录--
function Network.TestLoginPbc(buffer)
	local protocal = buffer:ReadByte();
	local data = buffer:ReadBuffer();

    local path = Util.DataPath.."lua/3rd/pbc/addressbook.pb";

    local addr = io.open(path, "rb")
    local buffer = addr:read "*a"
    addr:close()
    protobuf.register(buffer)
    local decode = protobuf.decode("tutorial.Person" , data)

    print(decode.name)
    print(decode.id)
    for _,v in ipairs(decode.phone) do
        print("\t"..v.number, v.type)
    end
	log('TestLoginPbc: protocal:>'..protocal);
end

--SPROTO登录--
function Network.TestLoginSproto(buffer)
	local protocal = buffer:ReadByte();
	local code = buffer:ReadBuffer();

    local sp = sproto.parse [[
    .Person {
        name 0 : string
        id 1 : integer
        email 2 : string

        .PhoneNumber {
            number 0 : string
            type 1 : integer
        }

        phone 3 : *PhoneNumber
    }

    .AddressBook {
        person 0 : *Person(id)
        others 1 : *Person
    }
    ]]
    local addr = sp:decode("AddressBook", code)
    print_r(addr)
	log('TestLoginSproto: protocal:>'..protocal);
end

--卸载网络监听--
function Network.Unload()
    Event.RemoveListener(Protocal.Connect);
    Event.RemoveListener(Protocal.Message);
    Event.RemoveListener(Protocal.Exception);
    Event.RemoveListener(Protocal.Disconnect);
    logWarn('Unload Network...');
end