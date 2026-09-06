-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/config/GoddessGloryConfig.lua

module("logic.extensions.goddessglory.config.GoddessGloryConfig", package.seeall)

local GoddessGloryConfig = class("GoddessGloryConfig", BaseConfig)

function GoddessGloryConfig:getNames()
	return {
		"goddess_glory_params",
		"goddess_glory_stage",
		"goddess_glory_challenge_event",
		"goddess_glory_monster",
		"goddess_glory_creeps",
		"goddess_glory_support_pet",
		"goddess_glory_task",
		"goddess_glory_buff",
		"goddess_glory_weekly_task"
	}
end

function GoddessGloryConfig:handleConfig(name, content)
	if name == "goddess_glory_params" then
		self._gloryParamsConfig = content
	elseif name == "goddess_glory_stage" then
		self._stagesConfig = content
	elseif name == "goddess_glory_challenge_event" then
		self._eventsConfig = content
	elseif name == "goddess_glory_monster" then
		self._monstersConfig = content
	elseif name == "goddess_glory_creeps" then
		self._creepsConfig = content
	elseif name == "goddess_glory_support_pet" then
		self._petsConfig = content
	elseif name == "goddess_glory_task" then
		self._tasksConfig = content
	elseif name == "goddess_glory_buff" then
		self._buffConfig = content
	elseif name == "goddess_glory_weekly_task" then
		self._weeklyTasksConfig = content
	end
end

function GoddessGloryConfig:getParamString(key)
	local val = self._gloryParamsConfig[key]

	if val then
		return val.value
	end
end

function GoddessGloryConfig:getParamInt(key)
	local val = self:getParamString(key)

	return checknumber(val)
end

function GoddessGloryConfig:getStageCos(challengeId)
	return self._stagesConfig[challengeId]
end

function GoddessGloryConfig:getStageCo(challengeId, stageId)
	return self._stagesConfig[challengeId][stageId]
end

function GoddessGloryConfig:getEventCo(evtId)
	return self._eventsConfig[evtId]
end

function GoddessGloryConfig:getTaskCo(planId, typeId, taskId)
	return self._tasksConfig[planId][typeId][taskId]
end

function GoddessGloryConfig:getTaskCoList(planId, typeId)
	return self._tasksConfig[planId][typeId]
end

function GoddessGloryConfig:getSupportPetCo(petId)
	return self._petsConfig[petId]
end

function GoddessGloryConfig:getCreepCo(id)
	return self._creepsConfig[id]
end

function GoddessGloryConfig:getMonsterCo(id)
	return self._monstersConfig[id]
end

function GoddessGloryConfig:getBuffCo(id)
	return self._buffConfig[id]
end

function GoddessGloryConfig:getWeeklyTaskCo(id, typeId, taskId)
	return self._weeklyTasksConfig[id][typeId][taskId]
end

function GoddessGloryConfig:getWeeklyTaskCoList(challengeId, typeId)
	return self._weeklyTasksConfig[challengeId][typeId]
end

GoddessGloryConfig.instance = GoddessGloryConfig.New()

return GoddessGloryConfig
