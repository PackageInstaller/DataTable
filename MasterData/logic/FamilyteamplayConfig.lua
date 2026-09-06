-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/config/FamilyteamplayConfig.lua

module("logic.extensions.familyteamplay.config.FamilyteamplayConfig", package.seeall)

local FamilyteamplayConfig = class("FamilyteamplayConfig", BaseConfig)

function FamilyteamplayConfig:onInit()
	self._errorIdList = {}
	self._lastUserId = false
end

function FamilyteamplayConfig:getNames()
	return {
		"team_play_period",
		"team_play_boss",
		"team_play_monster",
		"team_play_creeps",
		"team_play_rank",
		"team_play_common_config",
		"team_play_boss_season",
		"team_play_fight_prize",
		"team_play_war_zone",
		"team_play_game",
		"team_play_game_prize",
		"team_play_game_time_to_score",
		"zsm_common",
		"zsm_piece",
		"zsm_game_plan",
		"zsm_drop_plan"
	}
end

function FamilyteamplayConfig:handleConfig(name, content)
	if name == "team_play_period" then
		self._team_play_periodCfg = content
	elseif name == "team_play_boss" then
		self._team_play_bossCfg = content
	elseif name == "team_play_monster" then
		self._team_play_monsterCfg = content
	elseif name == "team_play_creeps" then
		self._team_play_creepsCfg = content
	elseif name == "team_play_rank" then
		self._team_play_rankCfg = content
	elseif name == "team_play_common_config" then
		self._team_play_common_configCfg = content
	elseif name == "team_play_boss_season" then
		self._team_play_boss_season = content
	elseif name == "team_play_fight_prize" then
		self._team_play_fight_prize = content
	elseif name == "team_play_war_zone" then
		self._team_play_war_zone = content
	elseif name == "team_play_game" then
		self._team_play_gameCfg = content
	elseif name == "team_play_game_prize" then
		self._team_play_game_prizeCfg = content
	elseif name == "team_play_game_time_to_score" then
		self._team_play_game_time_to_scoreCfg = content
	elseif name == "zsm_common" then
		self._zsm_common = content
	elseif name == "zsm_piece" then
		self._zsm_piece = content
	elseif name == "zsm_game_plan" then
		self._zsm_game_plan = content
	elseif name == "zsm_drop_plan" then
		self._zsm_drop_plan = content
	end
end

function FamilyteamplayConfig:getChallengeTimes(tpType)
	local info

	if tpType == FamilyteamplayController.teamPlayType.Common then
		info = self._team_play_common_configCfg.SIEGE_PLAY_TIMES
	elseif tpType == FamilyteamplayController.teamPlayType.Season then
		info = self._team_play_common_configCfg.SEASON_PLAY_TIMES
	end

	if info == nil or string.nilorempty(info.value) then
		return 3
	end

	return checknumber(info.value)
end

function FamilyteamplayConfig:getPlayCostTili()
	self._constPlayCostTili = self._constPlayCostTili or checknumber(self._team_play_common_configCfg.PLAY_CONSUME_STRENGTH.value)

	return self._constPlayCostTili
end

function FamilyteamplayConfig:getPetLimitLv()
	return checknumber(self._team_play_common_configCfg.PET_LEVEL_LIMIT.value)
end

function FamilyteamplayConfig:getDailyPracticeTimes()
	return checknumber(self._team_play_common_configCfg.BOSS_PRACTICE_TIMES.value)
end

function FamilyteamplayConfig:getPlayConsumeStrength()
	return checknumber(self._team_play_common_configCfg.PLAY_CONSUME_STRENGTH.value)
end

function FamilyteamplayConfig:getUnsealTimeStr()
	return self._team_play_common_configCfg.UNSEAL_TIME.value
end

function FamilyteamplayConfig:getBossCfg(periodId, bossId)
	local cfg = self:getPeriodCfg(periodId)

	if cfg then
		return self._team_play_bossCfg[cfg.templateId][bossId]
	end

	return nil
end

function FamilyteamplayConfig:getPeriodIdBossCfgs(periodId)
	local cfg = self:getPeriodCfg(periodId)

	if cfg then
		return self._team_play_bossCfg[cfg.templateId]
	else
		return {}
	end
end

function FamilyteamplayConfig:getCreepCfgs(creepMasterId)
	return self._team_play_creepsCfg[creepMasterId]
end

function FamilyteamplayConfig:getMonsterCfg(creepMasterId)
	return self._team_play_monsterCfg[creepMasterId]
end

function FamilyteamplayConfig:getPeriodOpenTime(periodId)
	local cfg = self:getPeriodCfg(periodId)

	if cfg then
		return GameUtil.string2time(cfg.startDate) + self:_getStartTimeAdd()
	else
		return 0
	end
end

function FamilyteamplayConfig:getPeriodEndTime(periodId)
	return self:getPeriodEndZeroTime(periodId) + self:_getEndTimeAdd()
end

function FamilyteamplayConfig:getUnsealTime(periodId)
	return self:getPeriodEndZeroTime(periodId) + self:_getUnsealTimeAdd()
end

function FamilyteamplayConfig:getPeriodEndZeroTime(periodId)
	local cfg = self:getPeriodCfg(periodId)

	if cfg then
		return GameUtil.string2time(cfg.endDate)
	else
		return 0
	end
end

function FamilyteamplayConfig:getPeriodCfg(periodId)
	if checknumber(periodId) <= 0 then
		return
	end

	if self._lastUserId ~= RoleModel.instance:getUserId() then
		self._lastUserId = RoleModel.instance:getUserId()
		self._errorIdList = {}
	end

	if periodId == nil then
		if not self._errorIdList[-1] then
			printError("FamilyteamplayConfig:getPeriodCfg 传空periodId")

			self._errorIdList[-1] = true
		end

		return nil
	end

	local cfg = self._team_play_periodCfg[periodId]

	if not self._errorIdList[periodId] and not cfg then
		self._errorIdList[periodId] = true

		printError("FamilyteamplayConfig:getPeriodCfg 找不到配置，periodId：", tostring(periodId))
	end

	return cfg
end

function FamilyteamplayConfig:getPeriodCfgs()
	return self._team_play_periodCfg
end

function FamilyteamplayConfig:getSmallGameCfg(gameId)
	return self._team_play_gameCfg[gameId]
end

function FamilyteamplayConfig:getClick2ScoreCfgs(typeId)
	return self._team_play_game_time_to_scoreCfg[typeId]
end

function FamilyteamplayConfig:getSmallGamePrizeCfgs(gameId)
	return self._team_play_game_prizeCfg[gameId]
end

function FamilyteamplayConfig:getDailyStartTime()
	return self._team_play_common_configCfg.START_TIME.value
end

function FamilyteamplayConfig:getDailyEndTime()
	return self._team_play_common_configCfg.END_TIME.value
end

function FamilyteamplayConfig:getDailyStartTimeParams()
	local str = self._team_play_common_configCfg.START_TIME.value
	local temp = string.split(str, ":")
	local hour = checknumber(temp[1])
	local min = checknumber(temp[2])
	local sec = checknumber(temp[3])

	return hour, min, sec
end

function FamilyteamplayConfig:getDailyEndTimeParams()
	local str = self._team_play_common_configCfg.END_TIME.value
	local temp = string.split(str, ":")
	local hour = checknumber(temp[1])
	local min = checknumber(temp[2])
	local sec = checknumber(temp[3])

	return hour, min, sec
end

function FamilyteamplayConfig:_getUnsealTimeParams()
	local str = self._team_play_common_configCfg.UNSEAL_TIME.value
	local temp = string.split(str, ":")
	local hour = checknumber(temp[1])
	local min = checknumber(temp[2])
	local sec = checknumber(temp[3])

	return hour, min, sec
end

function FamilyteamplayConfig:_getStartTimeAdd()
	local h, m, s = self:getDailyStartTimeParams()

	return h * 3600 + m * 60 + s
end

function FamilyteamplayConfig:_getEndTimeAdd()
	local h, m, s = self:getDailyEndTimeParams()

	return h * 3600 + m * 60 + s
end

function FamilyteamplayConfig:_getUnsealTimeAdd()
	local h, m, s = self:_getUnsealTimeParams()

	return h * 3600 + m * 60 + s
end

function FamilyteamplayConfig:getFlynuoPipeScore()
	local cfg = self:getClick2ScoreCfgs(GameEnum.FamilyTpSmallGame.Flynuo)

	return cfg[1].score
end

function FamilyteamplayConfig:getZSMGameScore(type)
	local cfg = self:getZSMPieceCfgs()

	return cfg[type].score
end

function FamilyteamplayConfig:getZSMGameScoreCfgs()
	return self:getZSMPieceCfgs()
end

function FamilyteamplayConfig:getZSMCommonCfg(key)
	local res = self._zsm_common[key]

	if res then
		return res.value
	else
		return nil
	end
end

function FamilyteamplayConfig:getZSMGameCfg(gameId)
	return self._zsm_game_plan[gameId]
end

function FamilyteamplayConfig:getZSMDropPlanCfg()
	return self._zsm_drop_plan
end

function FamilyteamplayConfig:getZSMPieceCfgs()
	return self._zsm_piece
end

function FamilyteamplayConfig:getTeamPlayBossSeason(periodId, zoneId, bossId)
	local cfg = self:getPeriodCfg(periodId)

	if cfg == nil then
		return
	end

	return self._team_play_boss_season[cfg.templateSeasonId][zoneId][bossId]
end

function FamilyteamplayConfig:getAllBossSeasonCfgs(periodId, zoneId)
	local cfg = self:getPeriodCfg(periodId)

	if cfg then
		return self._team_play_boss_season[cfg.templateSeasonId][zoneId]
	else
		return {}
	end
end

function FamilyteamplayConfig:getTeamPlayWarZoneCfgs()
	return self._team_play_war_zone
end

function FamilyteamplayConfig:getTeamPlayFightPrize(tpType, periodId, bossId, zoneId)
	tpType = checknumber(tpType)

	local bossCfg

	if tpType == FamilyteamplayController.teamPlayType.Season then
		bossCfg = self:getTeamPlayBossSeason(periodId, zoneId, bossId)
	elseif tpType == FamilyteamplayController.teamPlayType.Common then
		bossCfg = self:getBossCfg(periodId, bossId)
	end

	if bossCfg and bossCfg.fightPrizePlanId then
		return self._team_play_fight_prize[bossCfg.fightPrizePlanId]
	end

	return self._team_play_fight_prize[1]
end

function FamilyteamplayConfig:getBossWarZoneCfg(zoneId)
	zoneId = checknumber(zoneId)

	if self._team_play_war_zone == nil or self._team_play_war_zone[zoneId] == nil then
		return
	end

	return self._team_play_war_zone[zoneId]
end

function FamilyteamplayConfig:getBossWarZoneAttribute(zoneId)
	local cfg = self:getBossWarZoneCfg(zoneId)

	return (cfg or nil) and (cfg.tpye or "")
end

function FamilyteamplayConfig:getBossInfo(id)
	if self._team_play_monsterCfg ~= nil then
		return self._team_play_monsterCfg[id]
	end

	return nil
end

function FamilyteamplayConfig:getBossDescription(id)
	local info = self:getBossInfo(id)

	if info ~= nil then
		return info.description
	end

	return ""
end

function FamilyteamplayConfig:getBossHeadIcon(id)
	local info = self:getBossInfo(id)

	if info ~= nil then
		return info.creepMasterHeadIcon
	end

	return 1
end

function FamilyteamplayConfig:getCreepsRaceId(periodId, bossId)
	local cfg = self:getBossCfg(periodId, bossId)

	if cfg then
		return cfg.raceId
	end
end

FamilyteamplayConfig.instance = FamilyteamplayConfig.New()

return FamilyteamplayConfig
