local runTime = false
local endTime = 0
local timer = 0

function OnInit()
	UIUtil:AddTop2("WorldBossApply", gameObject, function()view:Close()end)
	
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.WorldBoss_RoleList, SetList)
end

function OnDestroy()
	eventMgr:ClearListener()
	ReleaseCSComRefs()
end

function Refresh()
	SetTime()
	SetList()
end

function OnDisable()
	runTime = false
end

function Update()
	if(runTime and endTime > 0) then
		if(TimeUtil:GetTime() - timer > 0.2) then
			timer = TimeUtil:GetTime()
			SetTimeDesc()
		end
	end
end

--玩家列表
function SetList()
	local list = WorldBossMgr:GetData().list
	CSAPI.SetText(txtList, "参战列表: " .. #list .. "/" .. g_BossRoomMaxCount)
	--todo
end

function SetTime()
	local data = WorldBossMgr:GetData()
	endTime = data.nCreateTime + g_BossRoomWaitTime - 1
	SetTimeDesc()
	timer = TimeUtil:GetTime()
	runTime = true
end

function SetTimeDesc()
	local needTime = endTime - TimeUtil:GetTime()
	CSAPI.SetText(txtTime, "等待剩余：" ..(needTime < 0 and 0 or math.floor(needTime)))
	if(needTime <= 0) then
		runTime = false
	end
end 
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
sv=nil;
txtTime=nil;
txtList=nil;
view=nil;
end
----#End#----