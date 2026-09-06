-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/config/DreamTeamChapterConfig.lua

module("logic.extensions.dreamteamchapter.config.DreamTeamChapterConfig", package.seeall)

local DreamTeamChapterConfig = class("DreamTeamChapterConfig", BaseConfig)

function DreamTeamChapterConfig:getNames()
	return {
		"dream_team_chapter",
		"dream_team_chapter_battle_stage",
		"dream_team_chapter_alchemy_material",
		"dream_team_chapter_dora_stage",
		"dream_team_chapter_master",
		"dream_team_chapter_creeps",
		"dream_team_chapter_rank_prize",
		"dream_team_chapter_progress_plan",
		"dream_team_chapter_dora_puzzle",
		"dream_team_chapter_activity",
		"dream_team_chapter_support_pet",
		"dream_team_chapter_alchemy_potion",
		"dream_team_chapter_awaken_meng_meng",
		"alchemy_mm_game_rule"
	}
end

function DreamTeamChapterConfig:handleConfig(name, content)
	if name == "dream_team_chapter" then
		self._dream_team_chapter = content
	elseif name == "dream_team_chapter_battle_stage" then
		self._dream_team_chapter_battle_stage = content
	elseif name == "dream_team_chapter_alchemy_material" then
		self._dream_team_chapter_alchemy_material = content
	elseif name == "dream_team_chapter_dora_stage" then
		self._dream_team_chapter_dora_stage = content
	elseif name == "dream_team_chapter_master" then
		self._dream_team_chapter_master = content
	elseif name == "dream_team_chapter_creeps" then
		self._dream_team_chapter_creeps = content
	elseif name == "dream_team_chapter_rank_prize" then
		self._dream_team_chapter_rank_prize = content
	elseif name == "dream_team_chapter_progress_plan" then
		self._dream_team_chapter_progress_plan = content
	elseif name == "dream_team_chapter_dora_puzzle" then
		self._dream_team_chapter_dora_puzzle = content
	elseif name == "dream_team_chapter_activity" then
		self._dream_team_chapter_activity = content
	elseif name == "dream_team_chapter_support_pet" then
		self._dream_team_chapter_support_pet = content
	elseif name == "dream_team_chapter_alchemy_potion" then
		self._dream_team_chapter_alchemy_potion = content
	elseif name == "dream_team_chapter_awaken_meng_meng" then
		self._dream_team_chapter_awaken_meng_meng = content
	elseif name == "alchemy_mm_game_rule" then
		self._alchemy_mm_game_rule = content
	end
end

function DreamTeamChapterConfig:getActivityCfg(activityId)
	return self._dream_team_chapter_activity[activityId]
end

function DreamTeamChapterConfig:getChapterCfgs(activityId)
	return self._dream_team_chapter[activityId]
end

function DreamTeamChapterConfig:getChapterCfg(activityId, chapterId)
	return self._dream_team_chapter[activityId] and self._dream_team_chapter[activityId][chapterId]
end

function DreamTeamChapterConfig:getBattleStageCfgs(activityId, challengeId)
	return self._dream_team_chapter_battle_stage[activityId] and self._dream_team_chapter_battle_stage[activityId][challengeId]
end

function DreamTeamChapterConfig:getBattleStageCfg(activityId, challengeId, stageId)
	local cfgs = self:getBattleStageCfgs(activityId, challengeId)

	return cfgs and cfgs[stageId]
end

function DreamTeamChapterConfig:getBattleStageCreepsMasterId(activityId, challengeId, stageId)
	local stageCfg = self:getBattleStageCfg(activityId, challengeId, stageId)

	return stageCfg and stageCfg.creepsMasterId
end

function DreamTeamChapterConfig:getBattleStageMustDeployPetId(activityId, challengeId, stageId)
	local stageCfg = self:getBattleStageCfg(activityId, challengeId, stageId)

	return stageCfg and stageCfg.mustDeployPetId
end

function DreamTeamChapterConfig:getBattleStageSupportPetPlan(activityId, challengeId, stageId)
	local stageCfg = self:getBattleStageCfg(activityId, challengeId, stageId)

	return (stageCfg or nil) and (stageCfg.supportPetPlan or 0)
end

function DreamTeamChapterConfig:getBattleStageLimitPos(activityId, challengeId, stageId)
	local stageCfg = self:getBattleStageCfg(activityId, challengeId, stageId)

	return stageCfg and stageCfg.limitPos
end

function DreamTeamChapterConfig:isMultBattleStage(activityId, challengeId, stageId)
	local stageCfg = self:getBattleStageCfg(activityId, challengeId, stageId)

	return stageCfg ~= nil and not stageCfg.isLinear
end

function DreamTeamChapterConfig:getDoraStageCfgs(activityId)
	return self._dream_team_chapter_dora_stage[activityId]
end

function DreamTeamChapterConfig:getDoraStageCfg(activityId, stageId)
	return self._dream_team_chapter_dora_stage[activityId] and self._dream_team_chapter_dora_stage[activityId][stageId]
end

function DreamTeamChapterConfig:getDoraPuzzleCfg(puzzleId)
	return self._dream_team_chapter_dora_puzzle[puzzleId]
end

function DreamTeamChapterConfig:getDoraPuzzleCfgs()
	return self._dream_team_chapter_dora_puzzle
end

function DreamTeamChapterConfig:getMasterCfg(creepsMasterId)
	return self._dream_team_chapter_master[creepsMasterId]
end

function DreamTeamChapterConfig:getCreepsCfg(creepsMasterId)
	return self._dream_team_chapter_creeps[creepsMasterId]
end

function DreamTeamChapterConfig:getProgressPlanCfgs(activityId, progressType)
	return self._dream_team_chapter_progress_plan[activityId] and self._dream_team_chapter_progress_plan[activityId][progressType]
end

function DreamTeamChapterConfig:getProgressPlanCfg(activityId, progressType, progressId)
	local cfgs = self:getProgressPlanCfgs(activityId, progressType)

	return cfgs and cfgs[progressId]
end

function DreamTeamChapterConfig:getSupportPetCfgs(supportPetPlan)
	return self._dream_team_chapter_support_pet[supportPetPlan]
end

function DreamTeamChapterConfig:getSupportPetCfg(supportPetPlan, creepsId)
	return self._dream_team_chapter_support_pet[supportPetPlan] and self._dream_team_chapter_support_pet[supportPetPlan][creepsId]
end

function DreamTeamChapterConfig:getAlchemyMaterialCfgs(activityId)
	return self._dream_team_chapter_alchemy_material[activityId]
end

function DreamTeamChapterConfig:getAlchemyMaterialCfg(activityId, materialId)
	return self._dream_team_chapter_alchemy_material[activityId] and self._dream_team_chapter_alchemy_material[activityId][materialId]
end

function DreamTeamChapterConfig:getAlchemyPotionCfgs(activityId)
	return self._dream_team_chapter_alchemy_potion[activityId]
end

function DreamTeamChapterConfig:getAlchemyPotionCfg(activityId, potionId)
	return self._dream_team_chapter_alchemy_potion[activityId] and self._dream_team_chapter_alchemy_potion[activityId][potionId]
end

function DreamTeamChapterConfig:getRankPrizeCfgs(activityId)
	return self._dream_team_chapter_rank_prize[activityId]
end

function DreamTeamChapterConfig:getRankPrizeCfgByRank(activityId, rank)
	local cfgs = self._dream_team_chapter_rank_prize[activityId]

	if cfgs then
		for rankRange, cfg in pairs(cfgs) do
			if rank >= rankRange[1] and rank <= rankRange[2] then
				return cfg
			end
		end
	end
end

function DreamTeamChapterConfig:getAwakeMMCfgs(activityId)
	return self._dream_team_chapter_awaken_meng_meng[activityId]
end

function DreamTeamChapterConfig:getAwakeMMCfgById(activityId, id)
	return self._dream_team_chapter_awaken_meng_meng[activityId] and self._dream_team_chapter_awaken_meng_meng[activityId][id]
end

function DreamTeamChapterConfig:getAlchemyRuleCfgs(ruleId)
	return self._alchemy_mm_game_rule[ruleId]
end

DreamTeamChapterConfig.instance = DreamTeamChapterConfig.New()

return DreamTeamChapterConfig
