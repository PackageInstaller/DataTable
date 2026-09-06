-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/config/KingCiYuanChallengeConfig.lua

module("logic.extensions.kingciyuanchallenge.config.KingCiYuanChallengeConfig", package.seeall)

local KingCiYuanChallengeConfig = class("KingCiYuanChallengeConfig", BaseConfig)

KingCiYuanChallengeConfig.StageType_Fight = 1
KingCiYuanChallengeConfig.StageType_Buff = 2
KingCiYuanChallengeConfig.StageType_Prize = 3
KingCiYuanChallengeConfig.BuffType_Normal = 1
KingCiYuanChallengeConfig.BuffType_Suit = 2

function KingCiYuanChallengeConfig:onInit()
	KingCiYuanChallengeConfig.super.onInit(self)
end

function KingCiYuanChallengeConfig:getNames()
	return {
		"king_ciyuan_activity",
		"king_ciyuan_common",
		"king_ciyuan_ext_challenge_plan",
		"king_ciyuan_boss_challenge_plan",
		"king_ciyuan_boss_open_day",
		"king_ciyuan_master",
		"king_ciyuan_creeps",
		"king_ciyuan_tag_plan",
		"king_ciyuan_tag_level",
		"king_ciyuan_boss_buff_plan",
		"king_ciyuan_boss_buy",
		"king_ciyuan_boss_damage_plan"
	}
end

function KingCiYuanChallengeConfig:handleConfig(name, content)
	if name == "king_ciyuan_activity" then
		self._king_ciyuan_activity = content
	elseif name == "king_ciyuan_common" then
		self._king_ciyuan_common = content
	elseif name == "king_ciyuan_ext_challenge_plan" then
		self._king_ciyuan_ext_challenge_plan = content
	elseif name == "king_ciyuan_boss_challenge_plan" then
		self._king_ciyuan_boss_challenge_plan = content
	elseif name == "king_ciyuan_boss_open_day" then
		self._king_ciyuan_boss_open_day = content
	elseif name == "king_ciyuan_master" then
		self._king_ciyuan_master = content
	elseif name == "king_ciyuan_creeps" then
		self._king_ciyuan_creeps = content
	elseif name == "king_ciyuan_tag_plan" then
		self._king_ciyuan_tag_plan = content
	elseif name == "king_ciyuan_tag_level" then
		self._king_ciyuan_tag_level = content
		self._suitConfigs = {}

		for i, v in ipairs(self._king_ciyuan_tag_level.dataList) do
			if v.type == KingCiYuanChallengeConfig.BuffType_Suit and v.level == 1 then
				table.insert(self._suitConfigs, v)
			end
		end
	elseif name == "king_ciyuan_boss_buff_plan" then
		self._king_ciyuan_boss_buff_plan = content
	elseif name == "king_ciyuan_boss_buy" then
		self._king_ciyuan_boss_buy = content
	elseif name == "king_ciyuan_boss_damage_plan" then
		self._king_ciyuan_boss_damage_plan = content
	end
end

function KingCiYuanChallengeConfig:getCommonValue(key, isToNumber)
	local str = ""

	if self._king_ciyuan_common and self._king_ciyuan_common[key] then
		str = not string.nilorempty(self._king_ciyuan_common[key].value2) and self._king_ciyuan_common[key].value2 or self._king_ciyuan_common[key].value
	end

	if isToNumber then
		str = checknumber(str)
	end

	return str
end

function KingCiYuanChallengeConfig:getActivityConfig(activityId)
	return self._king_ciyuan_activity[activityId]
end

function KingCiYuanChallengeConfig:getBossOpenDayConfigs()
	return self._king_ciyuan_boss_open_day
end

function KingCiYuanChallengeConfig:getBossPrizeConfigs(dmgPlanId)
	return self._king_ciyuan_boss_damage_plan[dmgPlanId]
end

function KingCiYuanChallengeConfig:getBuyBossCountCost(times)
	if not self._king_ciyuan_boss_buy[times] then
		return self._king_ciyuan_boss_buy[times].cost
	end
end

function KingCiYuanChallengeConfig:getMaxBuyBossCount()
	return #self._king_ciyuan_boss_buy
end

function KingCiYuanChallengeConfig:getBossChallengePlan(bossPlanId, bossId)
	if not self._king_ciyuan_boss_challenge_plan[bossPlanId] then
		return self._king_ciyuan_boss_challenge_plan[bossPlanId][bossId]
	end
end

function KingCiYuanChallengeConfig:getCreepMasterConfig(creepsMaterId)
	return self._king_ciyuan_master[creepsMaterId]
end

function KingCiYuanChallengeConfig:getCreepConfig(creepsMaterId)
	return self._king_ciyuan_creeps[creepsMaterId]
end

function KingCiYuanChallengeConfig:getExtChallengeConfig(extPlanId, stageId)
	if not self._king_ciyuan_ext_challenge_plan[extPlanId] then
		return self._king_ciyuan_ext_challenge_plan[extPlanId][stageId]
	end
end

function KingCiYuanChallengeConfig:getMaxStage(extPlanId)
	return #self._king_ciyuan_ext_challenge_plan[extPlanId]
end

function KingCiYuanChallengeConfig:getAllTagConfigs()
	return self._king_ciyuan_tag_level
end

function KingCiYuanChallengeConfig:getTagConfigs(tagId)
	return self._king_ciyuan_tag_level[tagId]
end

function KingCiYuanChallengeConfig:getTagConfig(tagId, level)
	if not self._king_ciyuan_tag_level[tagId] then
		return self._king_ciyuan_tag_level[tagId][level]
	end
end

function KingCiYuanChallengeConfig:getSuitConfigs()
	return self._suitConfigs
end

function KingCiYuanChallengeConfig:getBossBuffConfig(buffPlanId, buffId)
	if not self._king_ciyuan_boss_buff_plan[buffPlanId] then
		return self._king_ciyuan_boss_buff_plan[buffPlanId][buffId]
	end
end

KingCiYuanChallengeConfig.instance = KingCiYuanChallengeConfig.New()

return KingCiYuanChallengeConfig
