-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesswaken/model/GoddessWakenModel.lua

module("logic.extensions.goddesswaken.model.GoddessWakenModel", package.seeall)

local GoddessWakenModel = class("GoddessWakenModel", BaseModel)

function GoddessWakenModel:onInit()
	self:onReset()
end

function GoddessWakenModel:onReset()
	self._activityId = checknumber(GoddessWakenConfig.instance:getConstValue("ACTIVITYID"))
	self._goddessInfoList = {}
	self._taskInfoList = {}
end

function GoddessWakenModel:onGoddessWakenGetInfo(msg)
	self._goddessInfoList = GameUtil.pbToTable(msg.goddessInfoList) or {}
	self._taskInfoList = GameUtil.pbToTable(msg.taskInfoList) or {}
end

function GoddessWakenModel:onGoddessWakenInjectPower(msg)
	for i, v in ipairs(self._goddessInfoList) do
		if msg.goddessId == v.goddessId then
			v.injectNum = msg.curPowerNum

			break
		end
	end
end

function GoddessWakenModel:onGoddessWakenGainTaskPrize(msg)
	for i, v in ipairs(self._taskInfoList) do
		if msg.taskId == v.taskId then
			v.hasGainPrize = true

			break
		end
	end
end

function GoddessWakenModel:onGoddessWakenGainProgressPrize(msg)
	for i, v in ipairs(self._goddessInfoList) do
		if msg.goddessId == v.goddessId then
			v.prizeGainState[msg.prizeId] = true
		end
	end
end

function GoddessWakenModel:getActivityId()
	return self._activityId
end

function GoddessWakenModel:getPetPlanId()
	local cfg = GoddessWakenConfig.instance:getActivityCfg(self._activityId)

	if cfg then
		return cfg.petPlanId
	end

	return 0
end

function GoddessWakenModel:getTaskPlanId()
	local cfg = GoddessWakenConfig.instance:getActivityCfg(self._activityId)

	if cfg then
		return cfg.taskPlanId
	end

	return 0
end

function GoddessWakenModel:isTaskFinished(taskId, maxProgress)
	for i, v in ipairs(self._taskInfoList) do
		if v.taskId == taskId then
			return maxProgress <= v.curProgress
		end
	end

	return false
end

function GoddessWakenModel:isTaskPrizeGained(taskId)
	for i, v in ipairs(self._taskInfoList) do
		if v.taskId == taskId then
			return v.hasGainPrize
		end
	end

	return false
end

function GoddessWakenModel:curTaskProgress(taskId)
	for i, v in ipairs(self._taskInfoList) do
		if v.taskId == taskId then
			return v.curProgress
		end
	end

	return 0
end

function GoddessWakenModel:getCurInjectProgress(goddessId)
	for i, v in ipairs(self._goddessInfoList) do
		if v.goddessId == goddessId then
			return v.injectNum
		end
	end

	return 0
end

function GoddessWakenModel:isInjectRewardGeted(goddessId, qualityId)
	for i, v in ipairs(self._goddessInfoList) do
		if goddessId == v.goddessId then
			return v.prizeGainState[qualityId]
		end
	end
end

function GoddessWakenModel:isTaskRewardCanGet()
	local taskPlanId = self:getTaskPlanId()
	local isCanGet = false

	for i, v in ipairs(self._taskInfoList) do
		local cfg = GoddessWakenConfig.instance:getTaskCfg(taskPlanId, v.taskId)

		isCanGet = false

		if (cfg and GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) or nil) and not v.hasGainPrize and v.curProgress >= cfg.maxProgress then
			return true
		end
	end

	return false
end

function GoddessWakenModel:isInjectRewardCanGet(goddessId)
	local petPlanId = self:getPetPlanId()

	for i, v in ipairs(self._goddessInfoList) do
		if v.goddessId == goddessId then
			local cfg = GoddessWakenConfig.instance:getPetCfg(petPlanId, v.goddessId)

			if cfg and cfg.skinId > 0 then
				local cfgPlanList = GoddessWakenConfig.instance:getPlanList(cfg.qualityPlanId)

				for k, cfgPlan in ipairs(cfgPlanList) do
					if v.injectNum < cfgPlan.progress then
						return false
					elseif not v.prizeGainState[cfgPlan.qualityId] then
						return true
					end
				end
			end

			return false
		end
	end

	return false
end

function GoddessWakenModel:isShowDailyRedPoint()
	local isClicked = GameUtil.getUserDayData(ViewName.GoddessWakenView)
	local isActive = RedPointModel.instance:isActive(RedPointModel.ID_GODDESSWAKEN_EXIST_REWARD)

	return not isClicked and isActive
end

function GoddessWakenModel:markDailyRedPoint()
	GameUtil.saveUserDayData(ViewName.GoddessWakenView, true)
end

GoddessWakenModel.instance = GoddessWakenModel.New()

return GoddessWakenModel
