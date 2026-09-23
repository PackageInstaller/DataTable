local this = {
	id = nil,
	cfgid = 0,
	type = 0,
	finish_ids = nil,
	is_get = false,
}

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end

function this:InitData(sTaskInfo)
	self.id = sTaskInfo.id
	self.cfgid = sTaskInfo.cfgid
	self.type = sTaskInfo.type
	self.finish_ids = sTaskInfo.finish_ids
	self.is_get = sTaskInfo.is_get
	self.state = sTaskInfo.state
	self.rewards = sTaskInfo.rewards
	self.cfg = MissionMgr:GetCfg(self:GetType(), self:GetCfgID())
end

function this:Refresh()
	self.sortIndex = nil
end
---------------------------base

function this:GetState()
	return self.state
end

function this:GetID()
	return self.id
end

function this:GetCfgID()
	return self.cfgid	
end

function this:GetCfg()
	return self.cfg
end

function this:GetType()
	return self.type or 1
end

function this:IsGet()
	if(self:IsFinish()) then
		return(self.is_get and self.is_get == BoolType.Yes) or false
	end
	return false
end

function this:IsFinish()
	return(self.state and self.state == eTaskState.Finish) or false
end

--真实获得
function this:GetRewards()
	return self.rewards
end

--展示用
function this:GetJAwardId()
	if(self.jAwardIds == nil) then
		self.jAwardId = {}
		if(self.cfg and self.cfg.jAwardId) then
			for i, v in ipairs(self.cfg.jAwardId) do
				table.insert(self.jAwardId, {id = v[1], num = v[2], type = v[3]})
			end
		end
	end
	return self.jAwardId
end

function this:GetJumpID()
	return self.cfg and self.cfg.nTransferPath or nil
end

--获取基金任务id
function this:GetFundId()
	return self.cfg and self.cfg.fundId
end
--------------------------set
function this:SetIsGet(is_get)
	self.is_get = is_get
end

---------------------------else 
function this:GetLineStr()
	local lines = {"yellow_glow", "orange_glow", "blue_glow", "blue_glow", "orange_glow"}
	return self:GetType() <= #lines and lines[self:GetType()] or lines[1]
end

function this:GetName()
	return self.cfg and self.cfg.sName or ""
end

function this:GetDesc()
	return self.cfg and self.cfg.sDescription or ""
end

function this:GetFinishIDs()
	return self.finish_ids
end

--是否单一条件任务
function this:IsSingle()
	local finish_ids = self:GetFinishIDs()
	if(finish_ids == nil or #finish_ids == 1) then
		return true
	end
	return false
end

function this:GetCnt()
	if(self.finish_ids) then
		if(#self.finish_ids > 1) then
			for i, v in ipairs(self.finish_ids) do
				local cfg = Cfgs.CfgTaskFinishVal:GetByID(v.id)
				if(cfg and v.num < cfg.nVal1) then
					return 0
				end
			end
			return 1
		else
			return self.finish_ids[1].num
		end
	else
		return 1
	end
end

function this:GetMaxCnt()
	local finish_ids = self:GetFinishIDs()
	if(finish_ids and #finish_ids == 1) then
		local finishCfg = Cfgs.CfgTaskFinishVal:GetByID(finish_ids[1].id)
		if(finishCfg) then
			return finishCfg.nVal1
		end
	end
	return 1
end

--排序index
function this:GetSortIndex()
	if(self.sortIndex == nil) then
		if(self:IsGet()) then
			self.sortIndex = 0
		elseif(self:IsFinish()) then
			self.sortIndex = 1000
		elseif(self.cfg and self.cfg.index)then
			self.sortIndex = 1000 - self.cfg.index
		else
			self.sortIndex = 100 - self:GetType()
		end
	end
	return self.sortIndex
end

--是否已开启
function this:CheckIsOpen()
	if(self.cfg and self.cfg.nOpenLevel~=nil and PlayerClient:GetLv() < self.cfg.nOpenLevel) then
		return false
	end
	return true
end

function this:IsDW()
	if(self.type == eTaskType.Daily or self.type == eTaskType.Weekly) then
		return true
	end
	return false
end

function this:GetStarCount()
	return self.cfg.nStar or 0
end

function this:GetIcon()
	return self.cfg.icon or "1"
end

function this:GetGroup()
	return self.cfg.nGroup
end

--七日或阶段任务天数
function this:GetIndex()
	if self.type == eTaskType.Seven then
		return self.cfg and self.cfg.nDay
	elseif self.type == eTaskType.Guide then
		return self.cfg and self.cfg.nStage
	elseif self.type == eTaskType.NewYear then
		return self.cfg and self.cfg.nStage
	end
	return nil
end

function this:GetFinishCfg()
	if(self.finish_ids) then
		return Cfgs.CfgTaskFinishVal:GetByID(self.finish_ids[1].id)
	end
	return nil
end

return this 