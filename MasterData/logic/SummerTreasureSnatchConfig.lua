-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/config/SummerTreasureSnatchConfig.lua

module("logic.extensions.summertreasuresnatch.config.SummerTreasureSnatchConfig", package.seeall)

local SummerTreasureSnatchConfig = class("SummerTreasureSnatchConfig", BaseConfig)

function SummerTreasureSnatchConfig:getNames()
	return {
		"summer_treasure_snatch_activity",
		"summer_treasure_snatch_boss",
		"summer_treasure_snatch_buff",
		"summer_treasure_snatch_camp",
		"summer_treasure_snatch_common",
		"summer_treasure_snatch_creeps",
		"summer_treasure_snatch_master",
		"summer_treasure_snatch_rank_prize",
		"summer_treasure_snatch_item",
		"summer_treasure_snatch_win_prize",
		"summer_treasure_snatch_support_pet"
	}
end

function SummerTreasureSnatchConfig:handleConfig(name, content)
	if name == "summer_treasure_snatch_activity" then
		self._summer_treasure_snatch_activity = content
	elseif name == "summer_treasure_snatch_boss" then
		self._summer_treasure_snatch_boss = content
	elseif name == "summer_treasure_snatch_buff" then
		self._summer_treasure_snatch_buff = content
	elseif name == "summer_treasure_snatch_camp" then
		self._summer_treasure_snatch_camp = content
	elseif name == "summer_treasure_snatch_common" then
		self._summer_treasure_snatch_common = content
	elseif name == "summer_treasure_snatch_creeps" then
		self._summer_treasure_snatch_creeps = content
	elseif name == "summer_treasure_snatch_master" then
		self._summer_treasure_snatch_master = content
	elseif name == "summer_treasure_snatch_rank_prize" then
		self._summer_treasure_snatch_rank_prize = content
	elseif name == "summer_treasure_snatch_item" then
		self._summer_treasure_snatch_item = content
	elseif name == "summer_treasure_snatch_win_prize" then
		self._summer_treasure_snatch_win_prize = content
	elseif name == "summer_treasure_snatch_support_pet" then
		self._summer_treasure_snatch_support_pet = content
	end
end

function SummerTreasureSnatchConfig:getActivityCfg(activityId)
	return self._summer_treasure_snatch_activity[activityId]
end

function SummerTreasureSnatchConfig:getCommonValue(key)
	local cfg = self._summer_treasure_snatch_common[key]

	return cfg and cfg.value
end

function SummerTreasureSnatchConfig:getCommonNumber(key)
	return checknumber(self:getCommonValue(key))
end

function SummerTreasureSnatchConfig:getCampCfgs(activityId)
	return self._summer_treasure_snatch_camp[activityId]
end

function SummerTreasureSnatchConfig:getCampCfgByCampId(activityId, campId)
	return self._summer_treasure_snatch_camp[activityId] and self._summer_treasure_snatch_camp[activityId][campId]
end

function SummerTreasureSnatchConfig:getBossCfgs(activityId)
	return self._summer_treasure_snatch_boss[activityId]
end

function SummerTreasureSnatchConfig:getBossCfgsByWeek(activityId, week)
	local actBossCfg = self._summer_treasure_snatch_boss[activityId]

	return actBossCfg and actBossCfg[week]
end

function SummerTreasureSnatchConfig:getBossCfg(activityId, week, bossId)
	local bossCfgs = self:getBossCfgsByWeek(activityId, week)

	return bossCfgs and bossCfgs[bossId]
end

function SummerTreasureSnatchConfig:getBuffCfgs(activityId)
	return self._summer_treasure_snatch_buff[activityId]
end

function SummerTreasureSnatchConfig:getBuffCfg(activityId, buffId)
	local buffCfgs = self:getBuffCfgs(activityId)

	return buffCfgs and buffCfgs[buffId]
end

function SummerTreasureSnatchConfig:getShopCfgs(activityId)
	return self._summer_treasure_snatch_item[activityId]
end

function SummerTreasureSnatchConfig:getShopCfg(activityId, itemId)
	return self._summer_treasure_snatch_item[activityId] and self._summer_treasure_snatch_item[activityId][itemId]
end

function SummerTreasureSnatchConfig:getMasterCfg(creepsMasterId)
	return self._summer_treasure_snatch_master[creepsMasterId]
end

function SummerTreasureSnatchConfig:getCreepsCfg(creepsMasterId)
	return self._summer_treasure_snatch_creeps[creepsMasterId]
end

function SummerTreasureSnatchConfig:getWinPrizeCfg(activityId, winNum)
	local prizeCfgs = self._summer_treasure_snatch_win_prize[activityId]

	return prizeCfgs and prizeCfgs[winNum]
end

function SummerTreasureSnatchConfig:getSupportPetCfg(activityId, cardId)
	return self._summer_treasure_snatch_support_pet[activityId] and self._summer_treasure_snatch_support_pet[activityId][cardId]
end

function SummerTreasureSnatchConfig:getSupportPetCfgByRaceId(activityId, raceId)
	local petCfgs = self._summer_treasure_snatch_support_pet[activityId]

	if petCfgs then
		for _, petCfg in ipairs(petCfgs) do
			if petCfg.raceId == raceId then
				return petCfg
			end
		end
	end
end

function SummerTreasureSnatchConfig:getRankPrizeCfgs(activityId, week)
	local prizeCfgs = {}

	for _, cfg in ipairs(self._summer_treasure_snatch_rank_prize.dataList) do
		if cfg.activityId == activityId and cfg.week == week then
			table.insert(prizeCfgs, cfg)
		end
	end

	return prizeCfgs
end

function SummerTreasureSnatchConfig:getRankPrizeCfgByRank(activityId, week, rank)
	local rankNum = checknumber(rank)

	if rankNum <= 0 then
		return nil
	end

	local cfgs = self:getRankPrizeCfgs(activityId, week)

	for _, cfg in ipairs(cfgs) do
		local rankRange = cfg.rankRange

		if rankNum >= checknumber(rankRange[1]) and rankNum <= checknumber(rankRange[2]) then
			return cfg
		end
	end

	return nil
end

function SummerTreasureSnatchConfig:getCampName(activityId, campId)
	local campCfg = self:getCampCfgByCampId(activityId, campId)

	if campCfg then
		if not campCfg.name then
			return ""
		end
	end
end

SummerTreasureSnatchConfig.instance = SummerTreasureSnatchConfig.New()

return SummerTreasureSnatchConfig
