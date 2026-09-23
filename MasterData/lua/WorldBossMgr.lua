--世界boss
local this = MgrRegister("WorldBossMgr")

function this:Init()
	self:Clear()
	self:GetBossActivityInfo()
end

function this:Clear()
	self.data = nil
	self.curHP = 0
	self.nDamage = 0
end

function this:GetData()
	return self.data
end
function this:GetDamage()
	return self.nDamage
end

--是否有活动，开启时间和结束时间
function this:CheckIsActive()
	if(self.data) then
		local cfg = Cfgs.cfgWorldBoss:GetByID(self.data.nConfigID)
		if(cfg) then
			local startTime = TimeUtil:GetTimeHMS(TimeUtil:GetTime(), "%Y-%m-%d") .. " " .. cfg.nDailyBeginTime
			startTime = TimeUtil:GetTimeStampBySplit(startTime)--GCalHelp:GetTimeStampBySplit(startTime)
			local endTime = TimeUtil:GetTimeHMS(TimeUtil:GetTime(), "%Y-%m-%d") .. " " .. cfg.nDailyEndTime
			endTime = TimeUtil:GetTimeStampBySplit(endTime)--GCalHelp:GetTimeStampBySplit(endTime)
			return true, startTime, endTime
		end
	end
	return false, 0, 0
end

--退出战斗，返回演习界面
function this:Quit()
	SceneLoader:Load("MajorCity", function()
		CSAPI.OpenView("WorldBossMenu")
	end)
end

--获取boss列表
function this:GetBossActivityInfo()
	local proto = {"FightProtocol:GetBossActivityInfo", {}}
	NetMgr.net:Send(proto)
	
end
function this:GetBossActivityInfoRet(proto)
	self.data = proto.list and proto.list[1] or nil
	EventMgr.Dispatch(EventType.WorldBoss_List)
end

--boss报名
function this:EnterBoss()
	if(self.data) then
		local proto = {"FightProtocol:EnterBoss", {nConfigID = self.data.nConfigID}}
		NetMgr.net:Send(proto)	
	end
end
function this:EnterBossRet(proto)
	if(self.data) then
		for k, v in pairs(proto) do
			self.data[k] = v
		end
	else
		self.data = proto
	end
	EventMgr.Dispatch(EventType.WorldBoss_Enter)
end

--等待结束
function this:OnBossStart(proto)
	if(proto.bossUUID == self.data.bossUUID) then
		self.data.state = eBossState.Fighting  -- 战斗阶段
		EventMgr.Dispatch(EventType.WorldBoss_Start)
	else
		LogError("boss id 不对应")
	end
end

--boss死亡+结算
function this:OnBossOver(proto)
	if(proto.winner ~= 0) then
		self.data.isApply = false
	end	
	-- if(proto) then
	-- 	local data = {bIsWin = true, result = proto, armyType = RealArmyType.WorldBoss}
	-- 	FightActionMgr:Push(FightActionMgr:Apply(FightActionType.FightEnd, data))
	-- end
	FightOverTool.OnBossOver(proto)
	EventMgr.Dispatch(EventType.WorldBoss_Over)
end

--进入战斗
function this:EnterBossFight(_nTeamIndex, _nCastTP)
	local proto = {"FightProtocol:EnterBossFight", {bossUUID = self.data.bossUUID, nTeamIndex = _nTeamIndex, nCastTP = _nCastTP}}
	NetMgr.net:Send(proto);	
end

--更新血量
function this:UpdateBossHp(proto)
	if(self.data and self.data.bossUUID == proto.bossUUID) then
		self.data.hp = proto.hp or 0
		self.data.state = proto.state
		if(self.data.hp <= 0 or self.data.state ~= eBossState.Fighting) then
			self.data.hp = 0
			self.data.isApply = false
		end
	end
	EventMgr.Dispatch(EventType.WorldBoss_UpdateHP)
end

--获取个人伤害量
function this:GetBossDamage()
	local proto = {"FightProtocol:GetBossDamage", {nConfigID = self.data.nConfigID}}
	NetMgr.net:Send(proto)
end
function this:GetBossDamageRet(proto)
	self.nDamage = proto.nDamage
	EventMgr.Dispatch(EventType.WorldBoss_Damage)
end

--获取boss血量
function this:GetBossHP()
	local proto = {"FightProtocol:GetBossHP", {bossUUID = self.data.bossUUID}}
	NetMgr.net:Send(proto)
end

function this:GetBossHPRet(proto)
	if(proto.hp and self.data) then
		self.data.hp = proto.hp and proto.hp or self.data.hp
		self.data.maxhp = proto.maxhp and proto.maxhp or self.data.maxhp
		self.data.state = proto.state
		if(self.data.hp <= 0) then
			self.data.hp = 0
			self.data.isApply = false
		end
		EventMgr.Dispatch(EventType.WorldBoss_UpdateHP)
	end
end

--切换到boss进程
function this:ChangeLineToBoss()
	local proto = {"FightProtocol:ChangeLineToBoss", {serverID = self.data.serverID}}
	NetMgr.net:Send(proto)
end

--离开进程
function this:LeaveBoss()
	local proto = {"FightProtocol:LeaveBoss", {}}
	NetMgr.net:Send(proto)
end

function this:AddBossList(proto)
	if(self.data) then
		self.data.list = self.data.list or {}
		table.insert(self.data.list, proto)
	end
	EventMgr.Dispatch(EventType.WorldBoss_RoleList)
end

--退出战斗，返回演习界面
function this:Quit()
	SceneLoader:Load("MajorCity", function()
		CSAPI.OpenView("WorldBossMenu")
	end)
end

--当前tp和下次刷新时间
function this:GetTpAndNextTime()
	local nextRecoiveTime = nil
	local maxTP = PlayerClient:GetTP()
	local tpBeginTime = PlayerClient:GetTPBeginTime()
	if(maxTP >= g_TPMax) then
		maxTP = g_TPMax
		nextRecoiveTime = nil
	else
		while(maxTP < g_TPMax) and(TimeUtil:GetTime() - g_TPRecoverTime > tpBeginTime) do
			maxTP = maxTP + 1
			tpBeginTime = tpBeginTime + g_TPRecoverTime
		end
		if(maxTP < g_TPMax) then
			PlayerClient:GetTP(maxTP)
			PlayerClient:GetTPBeginTime(tpBeginTime)
			nextRecoiveTime = tpBeginTime + g_TPRecoverTime
		else
			nextRecoiveTime = nil
		end
	end
	return maxTP, nextRecoiveTime
end

return this 