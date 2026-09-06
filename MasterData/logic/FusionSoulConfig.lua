-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/config/FusionSoulConfig.lua

module("logic.extensions.fuyao.config.FusionSoulConfig", package.seeall)

local FusionSoulConfig = class("FusionSoulConfig", BaseConfig)

function FusionSoulConfig:onInit()
	FusionSoulConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function FusionSoulConfig:getNames()
	return {
		"fusion_soul_clue",
		"fusion_soul_activity",
		"fusion_soul_dialogue",
		"fusion_soul_section",
		"fusion_soul_progress_prize",
		"fusion_soul_event",
		"fusion_soul_formula",
		"fusion_soul_creeps",
		"fusion_soul_master",
		"fusion_soul_npc"
	}
end

function FusionSoulConfig:handleConfig(name, content)
	if name == "fusion_soul_clue" then
		self._fusion_soul_clue = content
	elseif name == "fusion_soul_activity" then
		self._fusion_soul_activity = content
	elseif name == "fusion_soul_dialogue" then
		self._fusion_soul_dialogue = content
	elseif name == "fusion_soul_section" then
		self._fusion_soul_section = content
	elseif name == "fusion_soul_progress_prize" then
		self._fusion_soul_progress_prize = content
	elseif name == "fusion_soul_event" then
		self._fusion_soul_event = content

		self:_handleFusionEventData(content)
	elseif name == "fusion_soul_formula" then
		self._fusion_soul_formula = content
	elseif name == "fusion_soul_creeps" then
		self._fusion_soul_creeps = content
	elseif name == "fusion_soul_master" then
		self._fusion_soul_master = content
	elseif name == "fusion_soul_npc" then
		self._fusion_soul_npc = content
	end
end

function FusionSoulConfig:getActivityCfg(activityId)
	return self._fusion_soul_activity[activityId]
end

function FusionSoulConfig:_handleFusionEventData(content)
	self._fusionEventDatas = {}

	for _, data in ipairs(content.dataList) do
		if self._fusionEventDatas[data.activityId] == nil and data.eventType == "fusion" then
			self._fusionEventDatas[data.activityId] = data
		end
	end
end

function FusionSoulConfig:getFusionEventData(activityId)
	return self._fusionEventDatas[activityId]
end

function FusionSoulConfig:getPhaseCfgs(activityId)
	return self._fusion_soul_section[activityId]
end

function FusionSoulConfig:getClueCfgs(activityId)
	return self._fusion_soul_clue[activityId]
end

function FusionSoulConfig:getClueCfg(activityId, clueId)
	if self._fusion_soul_clue[activityId] then
		return self._fusion_soul_clue[activityId][clueId]
	end
end

function FusionSoulConfig:getProgressPrizeCfgs(activityId)
	return self._fusion_soul_progress_prize[activityId]
end

function FusionSoulConfig:getZoneCfgs(activityId)
	return self._fusion_soul_event[activityId]
end

function FusionSoulConfig:getEventCfg(activityId, zoneId, eventId)
	if self._fusion_soul_event[activityId] and self._fusion_soul_event[activityId][zoneId] then
		return self._fusion_soul_event[activityId][zoneId][eventId]
	end
end

function FusionSoulConfig:getTeamCfg(creepsMasterId)
	return self._fusion_soul_master[creepsMasterId]
end

function FusionSoulConfig:getCreepsCfg(creepsMasterId)
	return self._fusion_soul_creeps[creepsMasterId]
end

function FusionSoulConfig:getDialogueCfgById(activityId, dialogueId, id)
	if self._fusion_soul_dialogue[activityId] and self._fusion_soul_dialogue[activityId][dialogueId] then
		return self._fusion_soul_dialogue[activityId][dialogueId][id]
	end
end

function FusionSoulConfig:getNpcCfgById(activityId, npcId)
	if self._fusion_soul_npc[activityId] then
		return self._fusion_soul_npc[activityId][npcId]
	end
end

FusionSoulConfig.instance = FusionSoulConfig.New()

return FusionSoulConfig
