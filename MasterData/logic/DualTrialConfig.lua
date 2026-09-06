-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/config/DualTrialConfig.lua

module("logic.extensions.dualtrial.config.DualTrialConfig", package.seeall)

local DualTrialConfig = class("DualTrialConfig", BaseConfig)

function DualTrialConfig:getNames()
	return {
		"dual_trial_npc_dialogue",
		"dual_trial_progress_prize",
		"dual_trial_creeps",
		"dual_trial_creeps_master",
		"dual_trial_event",
		"dual_trial_activity",
		"dual_trial_block"
	}
end

function DualTrialConfig:handleConfig(name, content)
	if name == "dual_trial_npc_dialogue" then
		self._dual_trial_npc_dialogue = content
	elseif name == "dual_trial_progress_prize" then
		self._dual_trial_progress_prize = content
	elseif name == "dual_trial_creeps" then
		self._dual_trial_creeps = content
	elseif name == "dual_trial_creeps_master" then
		self._dual_trial_creeps_master = content
	elseif name == "dual_trial_event" then
		self._dual_trial_event = content
	elseif name == "dual_trial_activity" then
		self._dual_trial_activity = content
	elseif name == "dual_trial_block" then
		self._dual_trial_block = content
	end
end

function DualTrialConfig:getActivityCfgById(activityId)
	return self._dual_trial_activity[activityId]
end

function DualTrialConfig:getBlockCfgsById(activityId)
	return self._dual_trial_block[activityId]
end

function DualTrialConfig:getBlockCfg(activityId, blockId)
	if self._dual_trial_block[activityId] then
		return self._dual_trial_block[activityId][blockId]
	end
end

function DualTrialConfig:getEventCfg(eventPlanId, eventId)
	if self._dual_trial_event[eventPlanId] then
		return self._dual_trial_event[eventPlanId][eventId]
	end
end

function DualTrialConfig:getPrizeCfgs(activityId)
	return self._dual_trial_progress_prize[activityId]
end

function DualTrialConfig:getDialogueCfgById(dialogueId, id)
	if self._dual_trial_npc_dialogue[dialogueId] then
		return self._dual_trial_npc_dialogue[dialogueId][id]
	end
end

function DualTrialConfig:getCreepCfgs(creepsMasterId)
	return self._dual_trial_creeps[creepsMasterId]
end

function DualTrialConfig:getTeamCfg(creepsMasterId)
	return self._dual_trial_creeps_master[creepsMasterId]
end

DualTrialConfig.instance = DualTrialConfig.New()

return DualTrialConfig
