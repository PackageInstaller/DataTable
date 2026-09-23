--战斗界面
local curTP = 1              --选择了几点TP
local refreshHP = false
local curTime = 0

function Awake()
	CSAPI.SetGOActive(tpParent, false)
end

function OnInit()
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.WorldBoss_UpdateHP, SetHP)
end

function OnDestroy()
	eventMgr:ClearListener()
	ReleaseCSComRefs()
end

function Refresh()
	SetSelectTP()
	SetHP()
	
	--10秒刷新一次血量
	curTime = Time.time - 10
	refreshHP = true
end

function Update()
	if(refreshHP and Time.time >(curTime + 10)) then
		curTime = Time.time
		WorldBossMgr:GetBossHP()
	end
end

function SetSelectTP()
	CSAPI.SetText(txtCurTP, "TP-" .. curTP)
end

function SetHP()
	local data = WorldBossMgr:GetData()
	CSAPI.SetText(txtHP, data.hp .. "/" .. data.maxhp)
end

function OnClickReward()
	WorldBossMgr:GetBossDamage()
end

--开始战斗
function OnClickStart()
	--if(maxTP > 0) then
		WorldBossMgr:EnterBossFight(1, curTP)
	--end
end

function OnClickSelectTP()
	CSAPI.SetGOActive(tpParent, true)
end
function OnClickTPParent()
	CSAPI.SetGOActive(tpParent, false)
end

function OnClickTP1()
	ClickTP(1)
end
function OnClickTP2()
	ClickTP(2)
end
function OnClickTP3()
	ClickTP(3)
end
function ClickTP(num)
	if(maxTP >= num) then
		curTP = num
		SetSelectTP()
		OnClickTPParent()
	else
		Tips.ShowTips("TP不足")
	end
end 
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
txtCurTP=nil;
HPFill=nil;
txtHP=nil;
btnTeam=nil;
txtRight2=nil;
itemGridD=nil;
tpParent=nil;
view=nil;
end
----#End#----