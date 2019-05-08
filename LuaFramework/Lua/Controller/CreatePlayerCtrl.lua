CreatePlayerCtrl = {};
local this = CreatePlayerCtrl;

local transform;
local gameObject;
local createPlayer;
local playerlist;

--构建函数--
function CreatePlayerCtrl.New()
	logWarn("CreatePlayerCtrl.New--->>");
	return this;
end

function CreatePlayerCtrl.Awake()
	logWarn("CreatePlayerCtrl.Awake--->>");
	panelMgr:CreatePanel('CreatePlayer', this.OnCreate);
end

--启动事件--
function CreatePlayerCtrl.OnCreate(obj)
    gameObject = obj;
    transform = obj.transform;
    createPlayer=transform:GetComponent('LuaBehaviour');
    createPlayer:AddClick(CreatePlayerPanel.selectBtn,this.OnClickSelect);
    logWarn("Start lua--->>"..gameObject.name);
    playerlist={};
    local count = 10; 
	local parent = CreatePlayerPanel.listContent;
	for i = 1, count do
		local go = newObject(CreatePlayerPanel.cell);
		go.name =tostring(i);
		go.transform:SetParent(parent.transform);
		go.transform.localScale = Vector3.one;
		go.transform.localPosition = Vector3.zero;
        createPlayer:AddClick(go, this.OnPlayerItemClick);
        go:SetActive(true);
	    local playerImg = go.transform:Find("playerImg").gameObject;
        local assetname="driver"..tostring(i);
        setImg(playerImg,"createplayer_asset",assetname);
        playerlist[i]=go;
	end
end

function CreatePlayerCtrl.OnPlayerItemClick(go)
    -- body
    for i=1,10 do
        playerlist[i].transform:Find("beSelectedImg").gameObject:SetActive(false);
    end
    go.transform:Find("beSelectedImg").gameObject:SetActive(true);
    MyPlayer.nowUseShape=tonumber(go.name);
end

function CreatePlayerCtrl.OnClickSelect()
    -- body
    local playername = CreatePlayerPanel.playerNameInput:GetComponent("InputField").text;
    if playername=="" or playername==nil then
        TipsCtrl.SetText("角色名不能为空");
    else
        MyPlayer.playerName=playername;
        this.CreatePlayerTos();
    end
end

--发送创建角色协议到服务端
function CreatePlayerCtrl.CreatePlayerTos()
    local playerInfo = allpb_pb.PlayerInfo();
    playerInfo=MyPlayer;
    local msg = playerInfo:SerializeToString();
    ----------------------------------------------------------------
    local buffer = ByteBuffer.New();
    buffer:WriteShort(Protocal.CreatePlayer);
    buffer:WriteByte(ProtocalType.PB_LUA);
    buffer:WriteBuffer(msg);
    networkMgr:SendMessage(buffer);
end

--单击事件--
function CreatePlayerCtrl.OnClick(go)
	destroy(gameObject);
end

--关闭事件--
function CreatePlayerCtrl.Close()
    panelMgr:ClosePanel(CtrlNames.CreatePlayer);
end