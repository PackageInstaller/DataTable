-- chunkname: @IQIGame\\Module\\TaskSystem\\TaskSystemData.lua

local TaskSystemData = {
	isAllowJump = false,
	status = 0,
	isStateRefresh = false,
	weightEasy = {
		underwayNoJump = 2,
		yetGetAward = 4,
		underwayHasJump = 3,
		canGetAward = 1
	},
	statusEasy = {
		yetFinish = 2,
		underway = 1,
		yetGetAward = 3
	}
}

function TaskSystemData.New()
	local o = Clone(TaskSystemData)

	return o
end

function TaskSystemData:Initialize(TaskPOD)
	self.BaseData = self:GetDefaultBaseCid(TaskPOD.cid)

	if self.BaseData == nil then
		logError("请检查任务配置cid为空    " .. TaskPOD.cid)
	end

	self.cfgTaskConfig = CfgTaskTable[TaskPOD.cid]

	if self.cfgTaskConfig == nil then
		logError("TaskSystemData:Initialize:  无法在Task表中找到 ID={0} 的数据段.", TaskPOD.cid)
	end

	self.cid = TaskPOD.cid
	self.type = self.BaseData.Type
	self.extendType = self.cfgTaskConfig.TypeExtend
	self.completeTime = TaskPOD.completeTime
	self.count = TaskPOD.count

	if self.oldschedule and self.status then
		if self.oldschedule ~= TaskPOD.schedule or self.status ~= TaskPOD.status then
			self.isStateRefresh = true
		else
			self.isStateRefresh = false
		end
	end

	self.status = TaskPOD.status

	if self.type == Constant.ExtendTaskType.Daily_Activity or self.type == Constant.ExtendTaskType.Weekly_Activity then
		if self.BaseData.PreposeID ~= 0 then
			local preposeConfig = self:GetDefaultBaseCid(self.BaseData.PreposeID)

			self.needSchedule = self.BaseData.NeedSchedule - preposeConfig.NeedSchedule
		else
			self.needSchedule = self.BaseData.NeedSchedule
		end

		self.oldschedule = TaskPOD.schedule
		self.schedule = TaskPOD.schedule

		if self.schedule >= self.BaseData.NeedSchedule then
			self.schedule = self.needSchedule
		elseif self.schedule > 0 then
			self.schedule = self.needSchedule - (self.BaseData.NeedSchedule - self.schedule)
		end
	else
		self.schedule = TaskPOD.schedule
		self.needSchedule = self.BaseData.NeedSchedule
		self.oldschedule = TaskPOD.schedule
	end

	if self.status == 1 and self.schedule == self.needSchedule or self.status > 1 and self.schedule ~= self.needSchedule and self.count < 1 then
		logError("有任务异常请检查，任务id  " .. self.cid .. "   任务状态  " .. self.status .. "  任务当前进度  " .. self.schedule .. "  任务需要总进度  " .. self.needSchedule)
	end

	self.isAllowJump = self.BaseData.JumpType == 0

	if self.status == self.statusEasy.underway then
		if self.isAllowJump == true then
			self.sortWeight = self.weightEasy.underwayHasJump
		else
			self.sortWeight = self.weightEasy.underwayNoJump
		end
	elseif self.status == self.statusEasy.yetFinish then
		self.sortWeight = self.weightEasy.canGetAward
	elseif self.status == self.statusEasy.yetGetAward then
		self.sortWeight = self.weightEasy.yetGetAward
	end
end

function TaskSystemData:GetDefaultBaseCid(cid)
	local curItemBaseData

	for _, v in pairsCfg(CfgTaskTable) do
		if v.Id == cid then
			curItemBaseData = v

			break
		end
	end

	return curItemBaseData
end

function TaskSystemData:GetTypeExtend(cfgTaskConfig)
	if cfgTaskConfig ~= nil then
		local typeCount = #cfgTaskConfig.TypeExtend

		if typeCount == 2 then
			return cfgTaskConfig.TypeExtend[1], cfgTaskConfig.TypeExtend[2]
		elseif typeCount == 1 then
			return cfgTaskConfig.TypeExtend[1], nil
		end
	end

	return nil, nil
end

return TaskSystemData
