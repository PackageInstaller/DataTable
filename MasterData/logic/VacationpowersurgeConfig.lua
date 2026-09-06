-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vacationpowersurge/config/VacationpowersurgeConfig.lua

module("logic.extensions.vacationpowersurge.config.VacationpowersurgeConfig", package.seeall)

local VacationpowersurgeConfig = class("VacationpowersurgeConfig", BaseConfig)

function VacationpowersurgeConfig:onInit()
	return
end

function VacationpowersurgeConfig:getNames()
	return {
		"vacation_power_surge_activity",
		"vacation_power_surge_task",
		"vacation_power_surge_progress"
	}
end

function VacationpowersurgeConfig:handleConfig(name, content)
	if name == "vacation_power_surge_activity" then
		self._vacation_power_surge_activity = content
	elseif name == "vacation_power_surge_task" then
		self._vacation_power_surge_task = content
	elseif name == "vacation_power_surge_progress" then
		self._vacation_power_surge_progress = content
	end
end

function VacationpowersurgeConfig:getActCfgs()
	return self._vacation_power_surge_activity.dataList
end

function VacationpowersurgeConfig:getActCfg(activityId)
	return self._vacation_power_surge_activity[activityId]
end

function VacationpowersurgeConfig:getTaskCfgs(taskPlanId)
	local tempList = self._vacation_power_surge_task[taskPlanId]
	local list = {}

	for k, v in pairs(tempList) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.id < b.id
	end)

	return list
end

function VacationpowersurgeConfig:getTaskCfg(taskPlanId, taskId)
	return self._vacation_power_surge_task[taskPlanId][taskId]
end

function VacationpowersurgeConfig:getProgressPlanCfgs(progressPlanId)
	return self._vacation_power_surge_progress[progressPlanId]
end

VacationpowersurgeConfig.instance = VacationpowersurgeConfig.New()

return VacationpowersurgeConfig
