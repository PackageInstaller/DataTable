-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/config/RankRaceConfig.lua

module("logic.extensions.rankrace.config.RankRaceConfig", package.seeall)

local RankRaceConfig = class("RankRaceConfig", BaseConfig)

function RankRaceConfig:onInit()
	RankRaceConfig.super.onInit(self)

	self._rankingMatchBuff = nil
	self._rankingMatchCommon = nil
	self._rankingMatchLevel = nil
	self._rankingMatchRobot = nil
	self._rankingMatchRobotCreeps = nil
	self._rankingMatchFindEnemy = nil
	self._rankingMatchDeclare = nil
	self._rankingMatchTask = nil
	self._rankingMatchLevelPrize = nil
	self._ranking_match_season = nil

	self:_initWord()
end

function RankRaceConfig:getNames()
	return {
		"ranking_match_buff",
		"ranking_match_common",
		"ranking_match_level",
		"ranking_match_robot",
		"ranking_match_robot_creeps",
		"ranking_match_find_enemy",
		"ranking_match_declare",
		"ranking_match_task",
		"ranking_match_level_prize",
		"ranking_match_rank_prize",
		"ranking_match_season",
		"ranking_match_no_ban_race"
	}
end

function RankRaceConfig:handleConfig(name, content)
	if name == "ranking_match_buff" then
		self._rankingMatchBuff = content
	elseif name == "ranking_match_common" then
		self._rankingMatchCommon = content
	elseif name == "ranking_match_level" then
		self._rankingMatchLevel = content
	elseif name == "ranking_match_robot" then
		self._rankingMatchRobot = content
	elseif name == "ranking_match_robot_creeps" then
		self._rankingMatchRobotCreeps = content
	elseif name == "ranking_match_find_enemy" then
		self._rankingMatchFindEnemy = content
	elseif name == "ranking_match_declare" then
		self._rankingMatchDeclare = content
	elseif name == "ranking_match_task" then
		self._rankingMatchTask = content
	elseif name == "ranking_match_level_prize" then
		self._rankingMatchLevelPrize = content
	elseif name == "ranking_match_rank_prize" then
		self._rankingMatchRankPrize = content
	elseif name == "ranking_match_season" then
		self._ranking_match_season = content
	elseif name == "ranking_match_no_ban_race" then
		self._ranking_match_no_ban_race = content
	end
end

function RankRaceConfig:getRankCommonConfig()
	return self._rankingMatchCommon
end

function RankRaceConfig:getRankLevelConfig()
	return self._rankingMatchLevel
end

function RankRaceConfig:getRankCommonValue(key, isToNumber)
	local data = self._rankingMatchCommon[key]

	if isToNumber then
		return checknumber(data and data.value)
	else
		return data and data.value
	end
end

function RankRaceConfig:getCommonOpenTime()
	return self._rankingMatchCommon.OPEN_TIME[2]
end

function RankRaceConfig:getFirstSeasonTime()
	return self._rankingMatchCommon.SEASON_START_TIME.value
end

function RankRaceConfig:getChallengeRewardCeiling()
	return self._rankingMatchCommon.CHALLENGE_REWARD_CEILING.value
end

function RankRaceConfig:getDeclareConfig()
	return self._rankingMatchDeclare
end

function RankRaceConfig:getFindEnemyConfig()
	return self._rankingMatchFindEnemy
end

function RankRaceConfig:getRankRaceBuffCo(id)
	return self._rankingMatchBuff[id]
end

function RankRaceConfig:getAllRankRaceBuffs()
	return self._rankingMatchBuff.dataList
end

function RankRaceConfig:getRankMatchLevelPrize()
	return self._rankingMatchLevelPrize
end

function RankRaceConfig:getDeclareCo(id)
	return self._rankingMatchDeclare[id]
end

function RankRaceConfig:getRankRaceTask()
	return self._rankingMatchTask
end

function RankRaceConfig:getRankingLevelByStar(star)
	local dataList = self._rankingMatchLevel.dataList
	local lastCo

	for i = 1, #dataList do
		if star < dataList[i].star then
			break
		else
			lastCo = dataList[i]
		end
	end

	lastCo = lastCo or dataList[1]

	return lastCo
end

function RankRaceConfig:getRankingReward(planId, _type)
	return self._rankingMatchRankPrize[planId][_type]
end

function RankRaceConfig:_initWord()
	self._configWord = {
		"经典赛",
		"极限赛",
		"每日%s点到%s点开放",
		"每周%s开放",
		"S%s赛季段位",
		"经典排位赛",
		"极限排位赛",
		"旗鼓相当的对手",
		"匹配成功",
		"取消匹配",
		"<size=28>当前没有旗鼓相当的玩家与你匹配\n请稍后再试试吧~</size>",
		"宣言将在战胜时播放，可选择多个随机播放",
		"宣言将在战败时播放，可选择多个随机播放",
		"已领取",
		"领取",
		"赛季",
		"胜利",
		"失败",
		"平局",
		"基础规则",
		"段位规则",
		"未上榜",
		"暂无战报消息",
		"第<size=34><color=#FB6400FF>%s</color></size>名",
		"返回",
		"我离开了",
		"对方离开了",
		"每日%s点-%s点排位可获得双倍竞技币",
		"未参加",
		"每日%s点-%s点排位可获得双倍竞技币"
	}
end

function RankRaceConfig:getWord(id)
	if not id then
		return
	end

	return self._configWord[id]
end

function RankRaceConfig:getCurSeasonTime()
	local list = self._ranking_match_season.dataList
	local curTimestamp = ServerTime.now()
	local count = #list
	local targetStart = list[count - 1].openTime
	local targetEnd = list[count].startTime
	local seasonNum = 1

	for i, v in ipairs(list) do
		if i ~= 1 then
			seasonNum = i - 1

			local startTimestamp = GameUtil.string2time(list[i - 1].openTime)
			local endTimestamp = GameUtil.string2time(v.startTime)

			if startTimestamp <= curTimestamp and curTimestamp <= endTimestamp then
				targetStart = list[i - 1].openTime
				targetEnd = v.startTime

				break
			end
		end
	end

	local timeStr = targetStart .. "#" .. targetEnd

	return timeStr, seasonNum
end

function RankRaceConfig:getCurSeasonNum()
	local timeStr, seasonNum = self:getCurSeasonTime()

	return seasonNum
end

function RankRaceConfig:getNextSeasonTime()
	local list = self._ranking_match_season.dataList
	local curTimestamp = ServerTime.now()
	local count = #list
	local targetStart = list[count - 1].openTime
	local targetEnd = list[count].startTime
	local seasonNum = 1

	for i = count, 1, -1 do
		seasonNum = i + 1

		local startTimestamp = GameUtil.string2time(list[i].openTime)

		if startTimestamp <= curTimestamp then
			targetStart = list[i + 1] and list[i + 1].openTime or targetStart

			if list[i + 2] then
				targetEnd = list[i + 2].startTime or targetEnd
			end

			break
		end
	end

	local timeStr = targetStart .. "#" .. targetEnd

	return timeStr, seasonNum
end

function RankRaceConfig:getSeasonNumBySeasonId(seasonId)
	local id = checknumber(seasonId)
	local seasonNum = 1
	local list = self._ranking_match_season.dataList

	for i, v in ipairs(list) do
		if v.seasonId == id then
			seasonNum = i
		end
	end

	return seasonNum
end

function RankRaceConfig:getSeasonTimeCfgList()
	return self._ranking_match_season.dataList
end

function RankRaceConfig:getSeasonCfg(seasonId)
	return self._ranking_match_season[seasonId]
end

function RankRaceConfig:getNoBanRaceCfg(seasonId)
	local data = self:getSeasonCfg(seasonId)

	if data then
		if not data.notBanPlanId then
			local notBanPlanId = 0

			return self._ranking_match_no_ban_race[notBanPlanId]
		end
	end
end

RankRaceConfig.instance = RankRaceConfig.New()

return RankRaceConfig
