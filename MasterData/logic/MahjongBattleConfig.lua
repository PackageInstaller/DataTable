-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/config/MahjongBattleConfig.lua

module("logic.extensions.mahjongbattle.config.MahjongBattleConfig", package.seeall)

local MahjongBattleConfig = class("MahjongBattleConfig", BaseConfig)

function MahjongBattleConfig:getNames()
	return {
		"mahjong_battle_activity",
		"mahjong_battle_card_luck",
		"mahjong_battle_common",
		"mahjong_battle_creeps",
		"mahjong_battle_genre",
		"mahjong_battle_mahjong",
		"mahjong_battle_master",
		"mahjong_battle_pet",
		"mahjong_battle_score",
		"mahjong_battle_score_rank_prize",
		"mahjong_battle_summon_buff",
		"mahjong_battle_summon_type",
		"mahjong_battle_teach",
		"mahjong_battle_teach_fake_data"
	}
end

function MahjongBattleConfig:handleConfig(name, content)
	if name == "mahjong_battle_activity" then
		self._mahjong_battle_activity = content
	elseif name == "mahjong_battle_card_luck" then
		self._mahjong_battle_card_luck = content
	elseif name == "mahjong_battle_common" then
		self._mahjong_battle_common = content
	elseif name == "mahjong_battle_creeps" then
		self._mahjong_battle_creeps = content
	elseif name == "mahjong_battle_genre" then
		self._mahjong_battle_genre = content
	elseif name == "mahjong_battle_mahjong" then
		self._mahjong_battle_mahjong = content
	elseif name == "mahjong_battle_master" then
		self._mahjong_battle_master = content
	elseif name == "mahjong_battle_score" then
		self._mahjong_battle_score = content
	elseif name == "mahjong_battle_pet" then
		self._mahjong_battle_pet = content
	elseif name == "mahjong_battle_score_rank_prize" then
		self._mahjong_battle_score_rank_prize = content

		self:_handleScoreRankPrizeCfgs()
	elseif name == "mahjong_battle_summon_buff" then
		self._mahjong_battle_summon_buff = content

		self:_handleSummonBuffCfgs()
	elseif name == "mahjong_battle_summon_type" then
		self._mahjong_battle_summon_type = content
	elseif name == "mahjong_battle_teach" then
		self._mahjong_battle_teach = content
	elseif name == "mahjong_battle_teach_fake_data" then
		self._mahjong_battle_teach_fake_data = content
	end
end

function MahjongBattleConfig:getActivityCfg(activityId)
	return self._mahjong_battle_activity[activityId]
end

function MahjongBattleConfig:getCardLuckCfgById(activityId, cardLuckId)
	if self._mahjong_battle_card_luck[activityId] then
		return self._mahjong_battle_card_luck[activityId][cardLuckId]
	end
end

function MahjongBattleConfig:getCommonValueToNumber(key)
	if not self._mahjong_battle_common[key] then
		printError("MahjongBattleConfig:getCommonValueToNumber 未找到通用配置，key=%s", key)
	end

	return checknumber(self._mahjong_battle_common[key].value)
end

function MahjongBattleConfig:getGenreCfgs(activityId)
	return self._mahjong_battle_genre[activityId]
end

function MahjongBattleConfig:getGenreCfg(activityId, genreId)
	local genreCfgs = self._mahjong_battle_genre[activityId]

	if genreCfgs then
		return genreCfgs[genreId]
	end
end

function MahjongBattleConfig:getMahjongCfgs(activityId)
	return self._mahjong_battle_mahjong[activityId]
end

function MahjongBattleConfig:getMahjongCfg(activityId, mahjongId)
	local mahjongCfgs = self._mahjong_battle_mahjong[activityId]

	if mahjongCfgs then
		return mahjongCfgs[mahjongId]
	end
end

function MahjongBattleConfig:getSystemPetByCreepsId(activityId, creepsId)
	if self._mahjong_battle_pet[activityId] then
		return self._mahjong_battle_pet[activityId][creepsId]
	end
end

function MahjongBattleConfig:_handleScoreRankPrizeCfgs()
	self._mahjong_battle_score_rank_prizeList = {}

	local dataList = self._mahjong_battle_score_rank_prize.dataList

	for i, v in ipairs(dataList) do
		if not self._mahjong_battle_score_rank_prizeList[v.activityId] then
			table.insert(self._mahjong_battle_score_rank_prizeList[v.activityId], v)

			self._mahjong_battle_score_rank_prizeList[v.activityId] = self._mahjong_battle_score_rank_prizeList[v.activityId]
		end
	end
end

function MahjongBattleConfig:getRankPrizeDataByRank(activityId, rank)
	local cfgs = self._mahjong_battle_score_rank_prizeList[activityId]

	if cfgs then
		return MmUtil.binarySearchInArrayKey(cfgs, "rankRange", rank)
	end
end

function MahjongBattleConfig:getSummonBuffCfgById(activityId, buffId)
	if self._mahjong_battle_summon_buff[activityId] then
		return self._mahjong_battle_summon_buff[activityId][buffId]
	end
end

function MahjongBattleConfig:_handleSummonBuffCfgs()
	self._mahjong_battle_summon_buff_map = {}

	local dataList = self._mahjong_battle_summon_buff.dataList

	for i, v in ipairs(dataList) do
		if not self._mahjong_battle_summon_buff_map[v.activityId] then
			if not self._mahjong_battle_summon_buff_map[v.activityId][v.buffPlan] then
				local cfgs = {}

				table.insert(cfgs, v)

				self._mahjong_battle_summon_buff_map[v.activityId][v.buffPlan] = cfgs
				self._mahjong_battle_summon_buff_map[v.activityId] = self._mahjong_battle_summon_buff_map[v.activityId]
			end
		end
	end
end

function MahjongBattleConfig:getSummonBuffCfgsByPlan(activityId, buffPlan)
	local cfgMap = self._mahjong_battle_summon_buff_map[activityId]

	if cfgMap then
		return cfgMap[buffPlan]
	end
end

function MahjongBattleConfig:getSummonTypeCfgById(activityId, typeId)
	if self._mahjong_battle_summon_type[activityId] then
		return self._mahjong_battle_summon_type[activityId][typeId]
	end
end

function MahjongBattleConfig:getScoreByWinNum(winNum)
	local scoreCfg = self._mahjong_battle_score[winNum]

	if scoreCfg then
		return scoreCfg.score
	end

	return 0
end

function MahjongBattleConfig:getCreepsCfgsById(creepsMasterId)
	return self._mahjong_battle_creeps[creepsMasterId]
end

function MahjongBattleConfig:getTeachCfg(activityId)
	return self._mahjong_battle_teach[activityId]
end

function MahjongBattleConfig:getTeachFakeDataCfg(activityId, id)
	if self._mahjong_battle_teach_fake_data[activityId] then
		return self._mahjong_battle_teach_fake_data[activityId][id]
	end
end

MahjongBattleConfig.instance = MahjongBattleConfig.New()

return MahjongBattleConfig
