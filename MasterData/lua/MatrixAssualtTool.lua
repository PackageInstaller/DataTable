--基地突袭管理
MatrixAssualtTool = {}
local this = MatrixAssualtTool

this.datas = nil   --突袭数据
this.isRun = false --突袭中

--突袭开始
function this:AssualtStart(proto)
	self.datas = proto
	self.isRun = true
	EventMgr.Dispatch(EventType.Matrix_Assualt)
end

--突袭结束
function this:AssualtStop(proto)
	self.datas = proto
	self.isRun = false
	EventMgr.Dispatch(EventType.Matrix_Assualt)
end

--突袭数据更新(登陆获取)
function this:AssualtInfoRet(info)
	self.datas = info
	self.isRun = info.running
end

--攻击
function this:Attack(_id, _index)
	CSAPI.OpenView("TeamConfirm", {
		id = _id,
		index = _index,
	}, TeamConfirmOpenType.Matrix)
end

--反击突袭返回(奖励由服务器弹出)
function this:AssualtAttackRet(proto)
	if(proto.bIsWin and self.datas) then
		--未打败移除
		self.datas.wIds = self.datas.wIds or {}
		for i, v in pairs(self.datas.wIds) do
			if(i == proto.id) then
				for k, m in ipairs(v) do
					if(m == proto.index) then
						table.remove(v, k)
						break
					end
				end
			end
		end
		--已打败添加
		self.datas.fIds = self.datas.fIds or {}
		self.datas.fIds[proto.id] = self.datas.fIds[proto.id] or {}
		local isAdd = false
		for i, v in ipairs(self.datas.fIds[proto.id]) do
			if(v == proto.index) then
				isAdd = true
				break
			end
		end
		if(not isAdd) then
			table.insert(self.datas.fIds[proto.id], proto.index)
		end
	end
	--结算界面数据封装
	self.rewards = proto.rewards
	-- local _data = {bIsWin = proto.bIsWin, result = proto, armyType = RealArmyType.Matrix}
	-- if(proto.isForceOver) then
	-- 	FightActionMgr:Surrender(_data)
	-- else
	-- 	FightActionMgr:Push(FightActionMgr:Apply(FightActionType.FightEnd, _data))
	-- end
	FightOverTool.AssualtAttackRet(proto)
end

--战斗结束进入基地时弹出奖励
function this:ShowRewards()
	MatrixMgr:SetIsAttack(false)
	if(self.rewards and #self.rewards > 0) then
		local datas = {}
		table.copy(self.rewards, datas)
		self.rewards = nil
		UIUtil:OpenReward( {datas})
	end
end


----------------------------------------------------------------------////get
function this:GetIsRun()
	return self.isRun
end

--是否在突袭时间段,离突袭结束剩余时间
function this:CheckIsRun()
	-- if(self:GetIsRun()) then
	-- 	return true
	-- end
	local baseTime = nil
	local lv = MatrixMgr:GetWarningLv()
	local cfg = Cfgs.CfgBAssault:GetByID(lv)
	if(cfg and cfg.openTimes) then
		local timeData = TimeUtil:GetTimeHMS(TimeUtil:GetTime(), "*t")
		for i, v in ipairs(cfg.openTimes) do
			for k, m in ipairs(v) do
				if(v[1] <= timeData.hour and timeData.hour < v[2]) then
					baseTime =(v[2] - timeData.hour - 1) * 3600 +(59 - timeData.min) * 60 +(60 - timeData.sec)
					break
				end
			end
			if(baseTime ~= nil) then
				break
			end
		end
	end
	local isIn = false
	if(baseTime ~= nil) then
		isIn = true
	end
	return isIn, baseTime
end

function this:GetData()
	return self.datas
end

function this:GetMonSterIndexs(_buildId)
	if(self.datas and self.datas.wIds) then
		for i, v in pairs(self.datas.wIds) do
			if(i == _buildId) then
				return v
			end
		end
	end
	return nil
end

return this 