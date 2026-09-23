local cfgid = 1
local curIndex = 0
local isInvite = false

function Awake()
	tab = ComUtil.GetCom(tabs, "CTab")
	tab:AddSelChangedCallBack(OnTabChanged)
end

function OnInit()
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.TeamBoss_Over, function()
		view:Close()
	end)
end

function OnDestroy()
	eventMgr:ClearListener()
	ReleaseCSComRefs()
end


function OnOpen()
	tab.selIndex = 0
	SetInfos()
	SetSwitch()
end

function OnTabChanged(_index)
	curIndex = _index
end

function SetInfos()
	local cfg = Cfgs.CfgTeamBoss:GetByID(cfgid)
	for i = 1, 3 do
		CSAPI.SetText(this["txtNormal" .. i .. "2"], cfg.infos[i].hard)
		CSAPI.SetText(this["txtNormal" .. i .. "2"], string.format("推荐等级：%s", cfg.infos[i].rLv))
	end
end

function SetSwitch()
	local x = isInvite and - 38 or 38
	CSAPI.SetAnchor(switch, x, 0, 0)
end

function OnClickSwitch()
	isInvite = not isInvite
	SetSwitch()
end

function OnClickCreate()
	TeamBoss:RoomCreate(cfgid, curIndex + 1, isInvite)
	
	view:Close()
end	

function OnClickMask()
	view:Close()
end 
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
tabs=nil;
item1=nil;
txtNormal11=nil;
txtNormal12=nil;
item1=nil;
txtNormal21=nil;
txtNormal22=nil;
item1=nil;
txtNormal31=nil;
txtNormal32=nil;
btnCreate=nil;
switch=nil;
view=nil;
end
----#End#----