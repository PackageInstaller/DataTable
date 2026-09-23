
--世界boss入口界面
local endTime = nil
local panels = {}
local nextRecoiveTime = nil  --下次恢复时间


function Awake()
	-- body
end

function OnInit()
	UIUtil:AddTop2("WorldBossMenu", gameObject, function()view:Close()end)
	
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.WorldBoss_List, RefreshPanel)
	eventMgr:AddListener(EventType.WorldBoss_Enter, EWorldBossEnter)
	eventMgr:AddListener(EventType.WorldBoss_Start,	RefreshPanel)
	eventMgr:AddListener(EventType.WorldBoss_Over,	RefreshPanel)
	eventMgr:AddListener(EventType.WorldBoss_Damage, EDamage)
	eventMgr:AddListener(EventType.WorldBoss_UpdateHP, function()
		local bossData = WorldBossMgr:GetData()
		if(bossData and not bossData.isApply) then
			RefreshPanel()
		end
	end)
end

function OnDestroy()
	eventMgr:ClearListener()
	--离开进程
	local bossData = WorldBossMgr:GetData()
	if(bossData and bossData.state == eBossState.Apply or bossData.state == eBossState.Fighting) then
		WorldBossMgr:LeaveBoss()
	end
	ReleaseCSComRefs()
end

function OnOpen()
	InitTP()
	SetTime()
	local bossData = WorldBossMgr:GetData()
	if(bossData) then	
		--进入进程
		if(bossData.state == eBossState.Apply or bossData.state == eBossState.Fighting) then
			WorldBossMgr:ChangeLineToBoss()
		end
		RefreshPanel()
	else
		WorldBossMgr:GetBossActivityInfo() --不存在boss数据
	end
end

function Update()
	if(endTime and TimeUtil:GetTime() >= endTime) then
		endTime = nil
		view:Close()	
		return
	end
	
	--tp恢复
	if(nextRecoiveTime) then
		if(TimeUtil:GetTime() > nextRecoiveTime) then
			InitTP()
		else
			SetTPAndTime()
		end
	end
end

--boos消失时间
function SetTime()
	local _bossIsActive, _bossStartTime, _bossEndTime = WorldBossMgr:CheckIsActive()
	endTime = _bossEndTime
end

function RefreshPanel()
	for i, v in pairs(panels) do
		CSAPI.SetGOActive(v.gameObject, false)
	end
	--是否在时间段内
	local bossData = WorldBossMgr:GetData()
	if(bossData and bossData.isApply) then
		if(bossData.state == eBossState.Apply) then
			--已报名
			CreatePanel("WorldBossApply")
		elseif(bossData.state == eBossState.Fighting) then
			--战斗中
			CreatePanel("WorldBossFighting")
		end
	else
		--未报名
		CreatePanel("WorldBossEnter")
	end
end

function CreatePanel(panelName)
	local panel = panels[panelName]
	if(panel) then
		CSAPI.SetGOActive(panel.gameObject, true)
		panel.Refresh()
	else
		ResUtil:CreateUIGOAsync("WorldBoss/" .. panelName, child, function(go)
			panels[panelName] = ComUtil.GetLuaTable(go)	
			panels[panelName].Refresh()
		end)
	end
end

--报名回调
function EWorldBossEnter()
	local bossData = WorldBossMgr:GetData()
	if(bossData and bossData.isApply) then
		RefreshPanel(bossData.state)
	else
		LogError("报名失败")
	end
end

function EDamage()
	local damage = WorldBossMgr:GetDamage()
	Log("个人伤害值：" .. damage)
end

--刷新当前tp和恢复时间
function InitTP()
	maxTP,nextRecoiveTime = WorldBossMgr:GetTpAndNextTime()
	SetTPCount()
	SetTPAndTime()
end

function SetTPCount()
	for i = 1, 3 do
		CSAPI.SetGOActive(this["tpItem" .. i], maxTP >= i)
	end
end

--倒计时
function SetTPAndTime()
	local _time = nextRecoiveTime and TimeUtil:GetTimeStr(nextRecoiveTime - TimeUtil:GetTime()) or "00:00:00"
	CSAPI.SetText(txtTime, "恢复剩余时间：" .. _time)
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
child=nil;
tpItem1=nil;
tpItem2=nil;
tpItem3=nil;
txtTime=nil;
view=nil;
end
----#End#----