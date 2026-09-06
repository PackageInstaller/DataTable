-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/config/DragonKingChallengeConfig.lua

module("logic.extensions.dragonking.config.DragonKingChallengeConfig", package.seeall)

local DragonKingChallengeConfig = class("DragonKingChallengeConfig", BaseConfig)

function DragonKingChallengeConfig:onInit()
	DragonKingChallengeConfig.super.onInit(self)
end

function DragonKingChallengeConfig:getNames()
	return {
		"dragon_king_doppelganger_clg",
		"dragon_king_doppelganger_clg_progress",
		"dragon_king_doppelganger_clg_rank",
		"dragon_king_doppelganger_clg_stage",
		"dragon_king_doppelganger_clg_monster",
		"dragon_king_doppelganger_clg_creeps"
	}
end

function DragonKingChallengeConfig:handleConfig(name, content)
	if name == "dragon_king_doppelganger_clg" then
		self._dragon_king_doppelganger_clg = content
	elseif name == "dragon_king_doppelganger_clg_progress" then
		self._dragon_king_doppelganger_clg_progress = content
	elseif name == "dragon_king_doppelganger_clg_rank" then
		self._dragon_king_doppelganger_clg_rank = content
	elseif name == "dragon_king_doppelganger_clg_stage" then
		self._dragon_king_doppelganger_clg_stage = content
	elseif name == "dragon_king_doppelganger_clg_monster" then
		self._dragon_king_doppelganger_clg_monster = content
	elseif name == "dragon_king_doppelganger_clg_creeps" then
		self._dragon_king_doppelganger_clg_creeps = content
	end
end

function DragonKingChallengeConfig:getActivityConfig(id)
	return self._dragon_king_doppelganger_clg[id]
end

function DragonKingChallengeConfig:getProgressCfgList(activityId)
	return self._dragon_king_doppelganger_clg_progress[activityId]
end

function DragonKingChallengeConfig:getRankConfig(id)
	return self._dragon_king_doppelganger_clg_rank[id]
end

function DragonKingChallengeConfig:getStageCfgById(activityId, stageId)
	if self._dragon_king_doppelganger_clg_stage[activityId] then
		return self._dragon_king_doppelganger_clg_stage[activityId][stageId]
	end
end

function DragonKingChallengeConfig:getStageConfigList(activityId)
	return self._dragon_king_doppelganger_clg_stage[activityId]
end

function DragonKingChallengeConfig:getMonsterCfgById(id)
	return self._dragon_king_doppelganger_clg_monster[id]
end

function DragonKingChallengeConfig:getCreepsConfig(id)
	return self._dragon_king_doppelganger_clg_creeps[id]
end

function DragonKingChallengeConfig:getPrizeByRank(actId, rank)
	local cfg = self._dragon_king_doppelganger_clg_rank[actId]
	local last = ""

	if cfg then
		for _, v in pairs(cfg) do
			local min = v.rankRange[1]
			local max = v.rankRange[#v.rankRange]

			if min <= rank and rank <= max then
				return v.prize
			end

			last = v.prize
		end
	end

	return last
end

DragonKingChallengeConfig.instance = DragonKingChallengeConfig.New()

return DragonKingChallengeConfig
