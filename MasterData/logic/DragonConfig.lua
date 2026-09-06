-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/config/DragonConfig.lua

module("logic.extensions.lottery.config.DragonConfig", package.seeall)

local DragonConfig = class("DragonConfig", BaseConfig)

function DragonConfig:onInit()
	DragonConfig.super.onInit(self)

	self._activityCfgs = nil
	self._poolAllCfgs = nil
	self._prizeAllCfgs = nil
	self._taskAllCfgs = nil
end

function DragonConfig:getNames()
	return {
		"god_lottery",
		"god_lottery_pool",
		"god_lottery_prize",
		"god_lottery_task",
		"god_lottery_task_plan",
		"god_lottery_progress_prize",
		"god_lottery_common_plan"
	}
end

function DragonConfig:handleConfig(name, content)
	if name == "god_lottery" then
		self._activityCfgs = self._activityCfgs or {}
		self._activityCfgs[1] = content
	elseif name == "god_lottery_pool" then
		self._poolAllCfgs = content
	elseif name == "god_lottery_prize" then
		self._prizeAllCfgs = content
	elseif name == "god_lottery_task" then
		self._activityCfgs = self._activityCfgs or {}
		self._activityCfgs[2] = content
	elseif name == "god_lottery_task_plan" then
		self:_setTaskAllCfgs(content.dataList)
	elseif name == "god_lottery_progress_prize" then
		self._prizeProgressCfgs = content
	elseif name == "god_lottery_common_plan" then
		self._god_lottery_common_plan = content
	end
end

function DragonConfig:getOpenDragonActivityId()
	if self._activityCfgs == nil or self._activityCfgs[1] == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(DragonModel.instance.dragonActType)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end
	end

	return -3
end

function DragonConfig:getOpenTaskActivityId()
	if self._activityCfgs == nil or self._activityCfgs[2] == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(116)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(item.activityId) then
			return item.activityId
		end
	end

	return -3
end

function DragonConfig:getOpenDragonActivity(actId)
	if self._activityCfgs == nil or self._activityCfgs[1] == nil then
		return -1
	end

	return not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(actId)
end

function DragonConfig:getDragonActivityCfg(actId)
	if self._activityCfgs == nil or self._activityCfgs[1] == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(DragonModel.instance.dragonActType)

	for _, item in pairs(cfgs) do
		if actId == item.activityId then
			return item
		end
	end

	return nil
end

function DragonConfig:getActivityCfg(actId, isTask)
	local num = isTask and 2 or 1

	if self._activityCfgs == nil or self._activityCfgs[num] == nil then
		return
	end

	local list = self._activityCfgs[num]

	return list[checknumber(actId)]
end

function DragonConfig:getDragonPoolCfg(poolId)
	poolId = checknumber(poolId)

	if self._poolAllCfgs == nil or self._poolAllCfgs[poolId] == nil then
		return
	end

	return self._poolAllCfgs[poolId]
end

function DragonConfig:getDragonPrizeCfgs(planId)
	planId = checknumber(planId)

	if self._prizeAllCfgs == nil or self._prizeAllCfgs[planId] == nil then
		return
	end

	return self._prizeAllCfgs[planId]
end

function DragonConfig:getDragonPrizeCfgsById(planId, id)
	planId = checknumber(planId)

	if self._prizeAllCfgs == nil or self._prizeAllCfgs[planId] == nil then
		return nil
	end

	return self._prizeAllCfgs[planId][id]
end

function DragonConfig:getDragonTaskCfgs(planId)
	planId = checknumber(planId)

	if self._taskAllCfgs == nil or self._taskAllCfgs[planId] == nil then
		return
	end

	return self._taskAllCfgs[planId]
end

function DragonConfig:_setTaskAllCfgs(list)
	self._taskAllCfgs = {}

	if list == nil then
		return
	end

	for _, cfg in pairs(list) do
		if cfg and cfg.taskPlanId and not string.nilorempty(cfg.prize) then
			if self._taskAllCfgs[cfg.taskPlanId] == nil then
				self._taskAllCfgs[cfg.taskPlanId] = {}
			end

			table.insert(self._taskAllCfgs[cfg.taskPlanId], cfg)
		end
	end
end

function DragonConfig:getDragonProgressCfgs(planId)
	planId = checknumber(planId)

	return self._prizeProgressCfgs[planId]
end

function DragonConfig:getPlanCfgById(planId, id)
	if self._god_lottery_common_plan[planId] then
		return self._god_lottery_common_plan[planId][id]
	end

	return {}
end

function DragonConfig:getPlanCfg(planId)
	if self._god_lottery_common_plan[planId] then
		return self._god_lottery_common_plan[planId]
	end

	return {}
end

DragonConfig.instance = DragonConfig.New()

return DragonConfig
