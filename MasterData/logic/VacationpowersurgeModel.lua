-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vacationpowersurge/model/VacationpowersurgeModel.lua

module("logic.extensions.vacationpowersurge.view.VacationpowersurgeModel", package.seeall)

local VacationpowersurgeModel = class("VacationpowersurgeModel", BaseModel)

function VacationpowersurgeModel:ctor()
	return
end

function VacationpowersurgeModel:onInit()
	self:onReset()
end

function VacationpowersurgeModel:onReset()
	self._activitType = GameEnum.ActivityType.Vacationpowersurge
	self._activityInfos = {}
end

function VacationpowersurgeModel:setActInfos(infos)
	self._activityInfos = infos
end

function VacationpowersurgeModel:getActInfos()
	return self._activityInfos
end

function VacationpowersurgeModel:gainTaskPrizeRes(activityId, taskId)
	local acfg = VacationpowersurgeConfig.instance:getActCfg(activityId)
	local taskCfg = VacationpowersurgeConfig.instance:getTaskCfg(acfg.taskPlanId, taskId)

	for _, v in ipairs(self._activityInfos) do
		if v.activityId == activityId then
			if v.taskInfos then
				for _, v0 in pairs(v.taskInfos) do
					if v0.taskId == taskId then
						v0.hasGainPrize = true
					end
				end
			end

			v.totalScore = v.totalScore + taskCfg.score
		end
	end
end

function VacationpowersurgeModel:notifyTaskInfos(msg)
	local oldActInfo = false

	for _, v in ipairs(self._activityInfos) do
		if v.activityId == msg.activityId then
			oldActInfo = v

			break
		end
	end

	if not oldActInfo then
		VacationPowerSurgeAgent.instance:sendPM_VacationPowerSurgeGetInfoReq()
	else
		local oldInfos = {}

		for _, oinfo in ipairs(oldActInfo.taskInfos) do
			oldInfos[oinfo.taskId] = oinfo
		end

		for i, v in ipairs(msg.taskInfos) do
			if oldInfos[v.taskId] then
				oldInfos[v.taskId].curProgress = v.curProgress
				oldInfos[v.taskId].hasGainPrize = v.hasGainPrize
			else
				table.insert(oldActInfo.taskInfos, v)
			end
		end
	end
end

function VacationpowersurgeModel:onePassRes(activityId, taskId)
	local acfg = VacationpowersurgeConfig.instance:getActCfg(activityId)
	local taskCfgs = VacationpowersurgeConfig.instance:getTaskCfgs(acfg.taskPlanId)

	for i, v in ipairs(taskCfgs) do
		if v.id == taskId then
			for _, info in ipairs(self._activityInfos) do
				if info.activityId == activityId then
					info.totalScore = info.totalScore + v.score

					break
				end
			end

			break
		end
	end
end

function VacationpowersurgeModel:gainProgressPrizeRes(activityId, id)
	for _, info in ipairs(self._activityInfos) do
		if info.activityId == activityId then
			table.insert(info.hasGainProgessPrize, id)

			break
		end
	end
end

function VacationpowersurgeModel:checkRedDot()
	return self:_checkTaskRewardDot() or self:_checkProgressRewardDot()
end

function VacationpowersurgeModel:_checkTaskRewardDot()
	local acfgs = VacationpowersurgeConfig.instance:getActCfgs()

	for k, v in pairs(acfgs) do
		if self:checkTaskRewardDotByActId(v.activityId) then
			return true
		end
	end

	return false
end

function VacationpowersurgeModel:checkTaskRewardDotByActId(activityId)
	if ActivityDefineController.instance:isInActivityTimeById(self._activitType, activityId) then
		local acfg = VacationpowersurgeConfig.instance:getActCfg(activityId)

		for _, v in ipairs(self._activityInfos) do
			if v.activityId == activityId then
				for _, info in ipairs(v.taskInfos) do
					if not info.hasGainPrize then
						local taskCfg = VacationpowersurgeConfig.instance:getTaskCfg(acfg.taskPlanId, info.taskId)

						if info.curProgress >= taskCfg.maxProgress then
							return true
						end
					end
				end
			end
		end
	end

	return false
end

function VacationpowersurgeModel:_checkProgressRewardDot()
	local acfgs = VacationpowersurgeConfig.instance:getActCfgs()

	for k, v in pairs(acfgs) do
		if self:checkProgressRewardDotByActId(v.activityId) then
			return true
		end
	end

	return false
end

function VacationpowersurgeModel:checkProgressRewardDotByActId(activityId)
	if ActivityDefineController.instance:isInActivityTimeById(self._activitType, activityId) then
		local acfg = VacationpowersurgeConfig.instance:getActCfg(activityId)

		for _, v in ipairs(self._activityInfos) do
			if v.activityId == activityId then
				local hasGetId = {}

				for _, id in ipairs(v.hasGainProgessPrize) do
					hasGetId[id] = true
				end

				local pcfgs = VacationpowersurgeConfig.instance:getProgressPlanCfgs(acfg.progressPlanId)

				for _, pcfg in pairs(pcfgs) do
					if not hasGetId[pcfg.id] and v.totalScore >= pcfg.needScore then
						return true
					end
				end
			end
		end
	end

	return false
end

VacationpowersurgeModel.instance = VacationpowersurgeModel.New()

return VacationpowersurgeModel
