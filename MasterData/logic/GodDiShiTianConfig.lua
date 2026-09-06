-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddishitian/config/GodDiShiTianConfig.lua

module("logic.extensions.goddishitian.config.GodDiShiTianConfig", package.seeall)

local GodDiShiTianConfig = class("GodDiShiTianConfig", BaseConfig)

function GodDiShiTianConfig:onInit()
	GodDiShiTianConfig.super.onInit(self)

	self.goddishitian_challenge_info = nil
end

function GodDiShiTianConfig:getNames()
	return {
		"goddishitian_challenge_info",
		"goddishitian_stage_type",
		"goddishitian_stage_info",
		"goddishitian_challenge_score",
		"goddishitian_challenge_creeps"
	}
end

function GodDiShiTianConfig:handleConfig(name, content)
	if name == "goddishitian_challenge_info" then
		self.goddishitian_challenge_info = content
	elseif name == "goddishitian_stage_type" then
		self.goddishitian_stage_type = content
	elseif name == "goddishitian_stage_info" then
		self.goddishitian_stage_info = content
	elseif name == "goddishitian_challenge_score" then
		self.goddishitian_challenge_score = content
	elseif name == "goddishitian_challenge_creeps" then
		self.goddishitian_challenge_creeps = content
	end
end

function GodDiShiTianConfig:getChallengeCfg(id)
	return self.goddishitian_challenge_info[id]
end

function GodDiShiTianConfig:getStageTypeCfg(stageType)
	return self.goddishitian_stage_type[stageType]
end

function GodDiShiTianConfig:getStageTypeInfoList(stageType)
	if not self.goddishitian_stage_info[stageType] then
		local result = {}

		for k, v in pairs(self.goddishitian_stage_info[stageType]) do
			table.insert(result, v)
		end

		table.sort(result, function(a, b)
			return a.creepsMasterId < b.creepsMasterId
		end)

		return result
	end
end

function GodDiShiTianConfig:getStageTypeInfoCfg(stageType, creepsMasterId)
	if self.goddishitian_stage_info[stageType] then
		return self.goddishitian_stage_info[stageType][creepsMasterId]
	end
end

function GodDiShiTianConfig:getChallengeScoreList(scorePlanId)
	return self.goddishitian_challenge_score[scorePlanId]
end

function GodDiShiTianConfig:getChallengeScoreCfg(scorePlanId, id)
	if self.goddishitian_challenge_score[scorePlanId] then
		return self.goddishitian_challenge_score[scorePlanId][id]
	end
end

function GodDiShiTianConfig:getCreeps(creepsMasterId)
	return self.goddishitian_challenge_creeps[creepsMasterId]
end

GodDiShiTianConfig.instance = GodDiShiTianConfig.New()

return GodDiShiTianConfig
