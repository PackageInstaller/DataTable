-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/config/RecallTaskConfig.lua

module("logic.extensions.recalltask.config.RecallTaskConfig", package.seeall)

local RecallTaskConfig = class("RecallTaskConfig", BaseConfig)

function RecallTaskConfig:onInit()
	RecallTaskConfig.super.onInit(self)

	self._activityCfgs = nil
	self._prizeAllCfgs = nil
	self._taskAllCfgs = nil
end

function RecallTaskConfig:getNames()
	return {
		"regress_invite_activity",
		"regress_invite_prize",
		"regress_invite_task"
	}
end

function RecallTaskConfig:handleConfig(name, content)
	if name == "regress_invite_activity" then
		self._activityCfgs = content
	elseif name == "regress_invite_prize" then
		self._prizeAllCfgs = content
	elseif name == "regress_invite_task" then
		self._taskAllCfgs = content
	end
end

function RecallTaskConfig:getRecallActivityCfg(actId)
	if self._activityCfgs == nil or self._activityCfgs[actId] == nil then
		return
	end

	return self._activityCfgs[actId]
end

function RecallTaskConfig:getRecallPrizeCfgs(planId)
	if self._prizeAllCfgs == nil or self._prizeAllCfgs[planId] == nil then
		return
	end

	return self._prizeAllCfgs[planId]
end

function RecallTaskConfig:getRecallTaskCfgs(planId, taskId)
	if self._taskAllCfgs == nil or self._taskAllCfgs[planId] == nil then
		return
	end

	local list = self._taskAllCfgs[planId]

	if checknumber(taskId) <= 0 or list[taskId] == nil then
		return list
	end

	return list[taskId]
end

function RecallTaskConfig:getOpenActivityId()
	if self._activityCfgs == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(RecallTaskModel.instance.openActivityType)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			RecallTaskModel.instance.openActivityId = item.activityId

			return item.activityId
		end
	end

	return -3
end

function RecallTaskConfig:getRecallShopsCfgs(num)
	local actiId = self:getOpenActivityId()

	if checknumber(actiId) <= 0 then
		return
	end

	local actiType = RecallTaskModel.instance.openActivityType
	local allCfgs = ActivityshopConfig.instance:getActivityShopCfgWithPage(actiType, actiId)

	if allCfgs == nil or allCfgs[num] == nil then
		return
	end

	local cfg = ActivityshopConfig.instance:getActivityShopPageCfg(actiType, actiId, num)

	return allCfgs[num], cfg.name
end

RecallTaskConfig.instance = RecallTaskConfig.New()

return RecallTaskConfig
