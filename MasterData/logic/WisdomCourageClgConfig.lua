-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/config/WisdomCourageClgConfig.lua

module("logic.extensions.wisdomcourageclg.config.WisdomCourageClgConfig", package.seeall)

local WisdomCourageClgConfig = class("WisdomCourageClgConfig", BaseConfig)

function WisdomCourageClgConfig:onInit()
	WisdomCourageClgConfig.super.onInit(self)
end

function WisdomCourageClgConfig:getNames()
	return {
		"wisdom_courage_clg_activity",
		"wisdom_courage_clg_boss",
		"wisdom_courage_clg_boss_buff",
		"wisdom_courage_clg_boss_damage",
		"wisdom_courage_clg_boss_rank_prize",
		"wisdom_courage_clg_support_stage",
		"wisdom_courage_clg_support_pet",
		"wisdom_courage_clg_support_rank_prize",
		"wisdom_courage_clg_team",
		"wisdom_courage_clg_creeps"
	}
end

function WisdomCourageClgConfig:handleConfig(name, content)
	if name == "wisdom_courage_clg_activity" then
		self._wisdom_courage_clg_activity = content
	elseif name == "wisdom_courage_clg_boss" then
		self._wisdom_courage_clg_boss = content
	elseif name == "wisdom_courage_clg_boss_buff" then
		self._wisdom_courage_clg_boss_buff = content
	elseif name == "wisdom_courage_clg_boss_damage" then
		self._wisdom_courage_clg_boss_damage = content
	elseif name == "wisdom_courage_clg_boss_rank_prize" then
		self._wisdom_courage_clg_boss_rank_prize = content
	elseif name == "wisdom_courage_clg_support_stage" then
		self._wisdom_courage_clg_support_stage = content
	elseif name == "wisdom_courage_clg_support_pet" then
		self._wisdom_courage_clg_support_pet = content
	elseif name == "wisdom_courage_clg_support_rank_prize" then
		self._wisdom_courage_clg_support_rank_prize = content
	elseif name == "wisdom_courage_clg_team" then
		self._wisdom_courage_clg_team = content
	elseif name == "wisdom_courage_clg_creeps" then
		self._wisdom_courage_clg_creeps = content
	end
end

function WisdomCourageClgConfig:getActData(activityId)
	return self._wisdom_courage_clg_activity[activityId]
end

function WisdomCourageClgConfig:getBossCfg(activityId)
	return self._wisdom_courage_clg_boss[activityId]
end

function WisdomCourageClgConfig:getBossData(activityId, bossId)
	if self._wisdom_courage_clg_boss[activityId] then
		return self._wisdom_courage_clg_boss[activityId][bossId]
	end
end

function WisdomCourageClgConfig:getBossBuffCfg(activityId)
	return self._wisdom_courage_clg_boss_buff[activityId]
end

function WisdomCourageClgConfig:getBossBuffData(activityId, day)
	if self._wisdom_courage_clg_boss_buff[activityId] then
		return self._wisdom_courage_clg_boss_buff[activityId][day]
	end
end

function WisdomCourageClgConfig:getBossDamageCfg(activityId)
	return self._wisdom_courage_clg_boss_damage[activityId]
end

function WisdomCourageClgConfig:getBossDamageData(activityId, damage)
	local result
	local cfg = self._wisdom_courage_clg_boss_damage[activityId]

	if cfg then
		local low, high = 1, #cfg

		while low <= high do
			local mid = math.floor((low + high) / 2)

			if damage >= cfg[mid].damage then
				result = cfg[mid]
				low = mid + 1
			else
				high = mid - 1
			end
		end
	end

	return result
end

function WisdomCourageClgConfig:getBossRankPrizeCfg(activityId)
	return self._wisdom_courage_clg_boss_rank_prize[activityId]
end

function WisdomCourageClgConfig:getBossRankPrizeData(activityId, rank)
	local cfg = self._wisdom_courage_clg_boss_rank_prize[activityId]

	if cfg then
		local low = 1
		local high = #cfg

		while low <= high do
			local mid = math.floor((low + high) / 2)
			local midValue = cfg[mid]

			if rank < midValue.rankRange[1] then
				high = mid - 1
			elseif rank > midValue.rankRange[2] then
				low = mid + 1
			else
				return midValue
			end
		end
	end

	return nil
end

function WisdomCourageClgConfig:getSupportStageCfg(activityId)
	return self._wisdom_courage_clg_support_stage[activityId]
end

function WisdomCourageClgConfig:getSupportStageData(activityId, stageId)
	if self._wisdom_courage_clg_support_stage[activityId] then
		return self._wisdom_courage_clg_support_stage[activityId][stageId]
	end
end

function WisdomCourageClgConfig:getSupportMaxStageCount(activityId)
	local cfg = self:getSupportStageCfg(activityId)

	return (cfg or nil) and (#cfg or 0)
end

function WisdomCourageClgConfig:getSupportPetCfgs(activityId)
	return self._wisdom_courage_clg_support_pet[activityId]
end

function WisdomCourageClgConfig:getSupportPetCfg(activityId, supportPetPoolId)
	if self._wisdom_courage_clg_support_pet[activityId] then
		return self._wisdom_courage_clg_support_pet[activityId][supportPetPoolId]
	end
end

function WisdomCourageClgConfig:getSupportRankPrizeCfg(activityId)
	return self._wisdom_courage_clg_support_rank_prize[activityId]
end

function WisdomCourageClgConfig:getSupportRankPrizeData(activityId, rank)
	local cfg = self._wisdom_courage_clg_support_rank_prize[activityId]

	if cfg then
		local low = 1
		local high = #cfg

		while low <= high do
			local mid = math.floor((low + high) / 2)
			local midValue = cfg[mid]

			if rank < midValue.rankRange[1] then
				high = mid - 1
			elseif rank > midValue.rankRange[2] then
				low = mid + 1
			else
				return midValue
			end
		end
	end

	return nil
end

function WisdomCourageClgConfig:getMasterData(creepsMasterId)
	return self._wisdom_courage_clg_team[creepsMasterId]
end

function WisdomCourageClgConfig:getCreepsCfg(creepsMasterId)
	return self._wisdom_courage_clg_creeps[creepsMasterId]
end

WisdomCourageClgConfig.instance = WisdomCourageClgConfig.New()

return WisdomCourageClgConfig
