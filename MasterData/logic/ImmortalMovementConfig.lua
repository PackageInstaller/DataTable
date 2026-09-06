-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/config/ImmortalMovementConfig.lua

module("logic.extensions.immortalmovement.config.ImmortalMovementConfig", package.seeall)

local ImmortalMovementConfig = class("ImmortalMovementConfig", BaseConfig)

function ImmortalMovementConfig:getNames()
	return {
		"immortal_movement_creeps",
		"immortal_movement_activity",
		"immortal_movement_support_pet",
		"immortal_movement_note",
		"immortal_movement_master",
		"immortal_movement_score",
		"immortal_movement_stage",
		"immortal_movement_story"
	}
end

function ImmortalMovementConfig:handleConfig(name, content)
	if name == "immortal_movement_creeps" then
		self._immortal_movement_creeps = content
	elseif name == "immortal_movement_activity" then
		self._immortal_movement_activity = content
	elseif name == "immortal_movement_support_pet" then
		self._immortal_movement_support_pet = content

		self:_handlerSupportPetCfg()
	elseif name == "immortal_movement_note" then
		self._immortal_movement_note = content
	elseif name == "immortal_movement_master" then
		self._immortal_movement_master = content
	elseif name == "immortal_movement_score" then
		self._immortal_movement_score = content
	elseif name == "immortal_movement_stage" then
		self._immortal_movement_stage = content
	elseif name == "immortal_movement_story" then
		self._immortal_movement_story = content
	end
end

function ImmortalMovementConfig:getActCfgById(actId)
	return self._immortal_movement_activity[actId]
end

function ImmortalMovementConfig:getCreepCfgs(creepsMasterId)
	return self._immortal_movement_creeps[creepsMasterId]
end

function ImmortalMovementConfig:getTeamCfg(creepsMasterId)
	return self._immortal_movement_master[creepsMasterId]
end

function ImmortalMovementConfig:_handlerSupportPetCfg(creepsMasterId)
	self._immortal_movement_support_petlist = {}

	for i, v in ipairs(self._immortal_movement_support_pet.dataList) do
		if not self._immortal_movement_support_petlist[v.activityId] then
			table.insert(self._immortal_movement_support_petlist[v.activityId], v)

			self._immortal_movement_support_petlist[v.activityId] = self._immortal_movement_support_petlist[v.activityId]
		end
	end
end

function ImmortalMovementConfig:getSupportPetCfgs(actId)
	return self._immortal_movement_support_petlist[actId]
end

function ImmortalMovementConfig:getStoryCfgs(actId)
	return self._immortal_movement_story[actId]
end

function ImmortalMovementConfig:getGroupCfgs(actId)
	return self._immortal_movement_stage[actId]
end

function ImmortalMovementConfig:getStageCfgs(actId, groupId)
	if self._immortal_movement_stage[actId] then
		return self._immortal_movement_stage[actId][groupId]
	end
end

function ImmortalMovementConfig:getScoreCfgs(actId)
	return self._immortal_movement_score[actId]
end

ImmortalMovementConfig.instance = ImmortalMovementConfig.New()

return ImmortalMovementConfig
