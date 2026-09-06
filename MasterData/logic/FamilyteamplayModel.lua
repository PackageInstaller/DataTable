-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/model/FamilyteamplayModel.lua

module("logic.extensions.familyteamplay.view.FamilyteamplayModel", package.seeall)

local FamilyteamplayModel = class("FamilyteamplayModel", BaseModel)

function FamilyteamplayModel:ctor()
	self._seasonRankList = nil
	self._baseProgressInfo = nil
	self._zdlInfoList = nil
	self._familyRankInfo = nil
	self._memberDamageList = nil
	self._sgGameId = nil
	self._endBattleInfo = nil
	self._flynuoTempScore = nil
	self._flyNuoHp = nil
	self._pipeScore = nil
	self._viewOpenType = nil
end

function FamilyteamplayModel:onInit()
	self:onReset()
end

function FamilyteamplayModel:onReset()
	self._viewOpenType = FamilyteamplayController.teamPlayType.Common
	self._seasonRankList = nil
	self._baseProgressInfo = nil
	self._zdlInfoList = nil
	self._familyRankInfo = nil
	self._memberDamageList = nil
	self._sgGameId = nil
	self._endBattleInfo = nil
	self._flynuoTempScore = nil
	self._flyNuoHp = 3
	self._pipeScore = nil
end

function FamilyteamplayModel:getViewOpenTeamPlayType()
	return self._viewOpenType or FamilyteamplayController.teamPlayType.Common
end

function FamilyteamplayModel:setViewOpenTeamPlayType(tpType)
	self._viewOpenType = tpType or FamilyteamplayController.teamPlayType.Common
end

function FamilyteamplayModel:isFunOpen()
	local var_6_0 = self._baseProgressInfo

	if self._baseProgressInfo then
		if checknumber(self._baseProgressInfo.periodId) > 0 then
			var_6_0 = FuncOpenModel.instance:getFuncIsOpen(GameEnum.FuncType.FamilyTeamplay)

			if var_6_0 then
				var_6_0 = self:_isInPeriodOpenTime(self._baseProgressInfo.periodId)
			end
		else
			var_6_0 = false
		end
	end

	return var_6_0
end

function FamilyteamplayModel:_isInPeriodOpenTime(periodId)
	local stime = FamilyteamplayConfig.instance:getPeriodOpenTime(periodId)
	local etime = FamilyteamplayConfig.instance:getPeriodEndTime(periodId)
	local nowTime = ServerTime.nowServerLook()

	return stime <= nowTime and nowTime < etime
end

function FamilyteamplayModel:getBaseProgressInfo()
	if self._baseProgressInfo == nil then
		self._baseProgressInfo = {}
		self._baseProgressInfo.periodId = 0
		self._baseProgressInfo.worldZdl = 0
		self._baseProgressInfo.availableGames = {}
		self._baseProgressInfo.curZoneId = 0
		self._baseProgressInfo.progressInfo = {}
		self._baseProgressInfo.progressInfo[FamilyteamplayController.teamPlayType.Common] = {}
		self._baseProgressInfo.progressInfo[FamilyteamplayController.teamPlayType.Season] = {}
	end

	return self._baseProgressInfo
end

function FamilyteamplayModel:getProgressInfoByType(tpType)
	if self._baseProgressInfo == nil then
		self:getBaseProgressInfo()
	end

	return self._baseProgressInfo.progressInfo[tpType] or {}
end

function FamilyteamplayModel:isAllStagePass(tpType)
	if tpType == nil then
		return self:_isCommonStagePass() and self:_isSeasonStagePass()
	end

	if tpType == FamilyteamplayController.teamPlayType.Common then
		return self:_isCommonStagePass()
	elseif tpType == FamilyteamplayController.teamPlayType.Season then
		return self:_isSeasonStagePass()
	end

	return false
end

function FamilyteamplayModel:_isCommonStagePass()
	self:getBaseProgressInfo()

	local info = self:getProgressInfoByType(FamilyteamplayController.teamPlayType.Common)

	if info == nil or info.realBossId == nil then
		return false
	end

	local nextBossCfg = FamilyteamplayConfig.instance:getBossCfg(self._baseProgressInfo.periodId, info.realBossId + 1)

	if nextBossCfg == nil and info.leftHp <= 0 then
		return true
	end

	return false
end

function FamilyteamplayModel:_isSeasonStagePass()
	self:getBaseProgressInfo()

	if checknumber(self._baseProgressInfo.curZoneId) <= 0 then
		return false
	end

	local info = self:getProgressInfoByType(FamilyteamplayController.teamPlayType.Season)

	if info == nil or info.realBossId == nil then
		return false
	end

	local nextBossCfg = FamilyteamplayConfig.instance:getTeamPlayBossSeason(self._baseProgressInfo.periodId, self._baseProgressInfo.curZoneId, info.realBossId + 1)

	if not nextBossCfg and info.leftHp <= 0 then
		return true
	end

	return false
end

function FamilyteamplayModel:getAvailableGames()
	self:getBaseProgressInfo()

	local list = {}
	local nowMs = ServerTime.nowMs()

	for _, info in ipairs(self._baseProgressInfo.availableGames or {}) do
		if info and nowMs < checknumber(info.expiredTimeMillis) then
			table.insert(list, info)
		end
	end

	return list
end

function FamilyteamplayModel:isHaveAvailableGames()
	local list = self:getAvailableGames()

	return #list > 0
end

function FamilyteamplayModel:formatLeftTimeStr(leftTime)
	local d, h, m, s = GameUtil.getTimeDDHHMMSS(leftTime)

	return d > 0 and string.format("时间剩余：%s天%s时%s分", d, h, m) or h > 0 and string.format("时间剩余：%s时%s分%s秒", h, m, s) or string.format("时间剩余：%s分%s秒", m, s)
end

function FamilyteamplayModel:isFatiguePetId(petId, tpType)
	if petId == nil or self._baseProgressInfo == nil then
		return false
	end

	petId = checknumber(petId)

	local info = self:getProgressInfoByType(tpType)

	if info == nil or info.lockPetIds == nil then
		return false
	end

	for _, id in ipairs(info.lockPetIds) do
		if id and checknumber(id) == petId then
			return true
		end
	end

	return false
end

function FamilyteamplayModel:isOverLimitLv(petId)
	local limitLv = FamilyteamplayConfig.instance:getPetLimitLv()
	local petMo = BagPetsController.instance:getPet(petId)

	return limitLv <= petMo:getPetLv()
end

function FamilyteamplayModel:getPeriodEndDescStr()
	if self._baseProgressInfo == nil or self._baseProgressInfo.periodId == nil then
		return "暂无"
	end

	local isPass = self:isAllStagePass(FamilyteamplayController.teamPlayType.Common)
	local str = "当前模式：%s\n通关数：%s关\n家族排名：%s"
	local info
	local ms = "围剿模式"

	if isPass and self._baseProgressInfo.curZoneId > 0 then
		info = self:getProgressInfoByType(FamilyteamplayController.teamPlayType.Season)

		local cfg = FamilyteamplayConfig.instance:getBossWarZoneCfg(self._baseProgressInfo.curZoneId)

		ms = cfg and cfg.name or "赛季模式"
	else
		info = self:getProgressInfoByType(FamilyteamplayController.teamPlayType.Common)
	end

	if info == nil or info.realBossId == nil then
		return "暂无"
	end

	if checknumber(info.leftHp) > 0 then
		if not (info.realBossId - 1) then
			local stageNum = info.realBossId

			stageNum = math.max(stageNum, 0)

			if checknumber(self._baseProgressInfo.familyRank) <= 0 then
				return string.format(str, ms, GameUtil.getChineseNumber(stageNum), "未上榜")
			else
				return string.format(str, ms, GameUtil.getChineseNumber(stageNum), string.format("第<color=#0174DEFF>%s</color>名", self._baseProgressInfo.familyRank))
			end
		end
	end
end

function FamilyteamplayModel:getNextPeriodOpenDescStr()
	local str = ""

	if self._baseProgressInfo == nil or self._baseProgressInfo.periodId == nil then
		return str
	end

	local cfg = FamilyteamplayConfig.instance:getPeriodCfg(self._baseProgressInfo.periodId + 1)

	if cfg == nil then
		return str
	end

	local hour = FamilyteamplayConfig.instance:getDailyStartTimeParams()
	local stimeStr = hour .. "点"

	hour = FamilyteamplayConfig.instance:getDailyEndTimeParams()

	local etimeStr = hour .. "点"

	return string.format("下一期开启时间：\n%s %s\n~ %s %s", cfg.startDate, stimeStr, cfg.endDate, etimeStr)
end

function FamilyteamplayModel:getPeriodOpenTimeStr()
	if self._baseProgressInfo == nil or self._baseProgressInfo.periodId == nil then
		return ""
	end

	local hour = FamilyteamplayConfig.instance:getDailyStartTimeParams()
	local stimeStr = hour .. "点"

	hour = FamilyteamplayConfig.instance:getDailyEndTimeParams()

	local etimeStr = hour .. "点"
	local cfg = self:_isInPeriodOpenTime(self._baseProgressInfo.periodId) and FamilyteamplayConfig.instance:getPeriodCfg(self._baseProgressInfo.periodId) or FamilyteamplayConfig.instance:getPeriodCfg(self._baseProgressInfo.periodId + 1)

	if cfg == nil then
		return ""
	end

	return string.format("%s %s\n至%s %s", cfg.startDate, stimeStr, cfg.endDate, etimeStr)
end

function FamilyteamplayModel:getMemberZdlInfoList()
	return self._zdlInfoList or {}
end

function FamilyteamplayModel:getFamilyTeamPlayRank()
	return self._familyRankInfo or {}
end

function FamilyteamplayModel:getMemberDamageList()
	return self._memberDamageList or {}
end

function FamilyteamplayModel:setStartSmallGameParam(gameId)
	self._sgGameId = checknumber(gameId)
end

function FamilyteamplayModel:getStartSmallGameParam()
	return self._sgGameId
end

function FamilyteamplayModel:getNewSmallGameId()
	return self._baseProgressInfo and checknumber(self._baseProgressInfo.newSmallGameId) or 0
end

function FamilyteamplayModel:resetNewSmallGameId()
	if self._baseProgressInfo then
		self._baseProgressInfo.newSmallGameId = 0
	end
end

function FamilyteamplayModel:getCurrBossName()
	if self._baseProgressInfo == nil or self._baseProgressInfo.periodId == nil then
		return "未知"
	end

	local cfg

	if checknumber(self._baseProgressInfo.curZoneId) > 0 then
		local info = self:getProgressInfoByType(FamilyteamplayController.teamPlayType.Season)

		if info and info.realBossId then
			cfg = FamilyteamplayConfig.instance:getTeamPlayBossSeason(self._baseProgressInfo.periodId, self._baseProgressInfo.curZoneId, info.realBossId)
		end
	else
		local info = self:getProgressInfoByType(FamilyteamplayController.teamPlayType.Common)

		if info and info.realBossId then
			cfg = FamilyteamplayConfig.instance:getBossCfg(self._baseProgressInfo.periodId, info.realBossId)
		end
	end

	return (cfg or nil) and (cfg.name or "未知")
end

function FamilyteamplayModel:setFlynuoScoreToTemp(score)
	self._flynuoTempScore = score
end

function FamilyteamplayModel:getFlynuoScoreInTemp()
	return checknumber(self._flynuoTempScore)
end

function FamilyteamplayModel:getEndBattleHpRatio()
	if self._endBattleInfo == nil then
		return 0
	end

	local ratio = self._endBattleInfo.battleBossTotalHp / self._endBattleInfo.battleBossLeftHp

	return ratio * 100
end

function FamilyteamplayModel:getEndBattleInfo()
	return self._endBattleInfo
end

function FamilyteamplayModel:resetFlyNuoHp()
	self._flyNuoHp = 3
end

function FamilyteamplayModel:reduceFlyNuoHp()
	self._flyNuoHp = checknumber(self._flyNuoHp) - 1
	self._flyNuoHp = math.max(0, self._flyNuoHp)
end

function FamilyteamplayModel:getFlyNuoHp()
	return checknumber(self._flyNuoHp)
end

function FamilyteamplayModel:addFlynuoPipeScore()
	self._pipeScore = checknumber(self._pipeScore) + FamilyteamplayConfig.instance:getFlynuoPipeScore()
end

function FamilyteamplayModel:getFlynuoScore()
	return checknumber(self._pipeScore)
end

function FamilyteamplayModel:scTeamPlayProgressInfo(tpType, msg)
	if self._baseProgressInfo and self._baseProgressInfo.periodId ~= checknumber(msg.periodId) then
		self._flyNuoHp = 3
	end

	self:getBaseProgressInfo()

	self._baseProgressInfo.periodId = checknumber(msg.periodId)
	self._baseProgressInfo.worldZdl = checknumber(msg.worldZdl)
	self._baseProgressInfo.curZoneId = checknumber(msg.curZoneId)
	self._baseProgressInfo.progressInfo[tpType] = {}
	self._baseProgressInfo.progressInfo[tpType].curBossId = checknumber(msg.progressInfo.curBossId)
	self._baseProgressInfo.progressInfo[tpType].memberDamageTop = msg.progressInfo.memberDamageTop
	self._baseProgressInfo.progressInfo[tpType].todayChallengedTimes = checknumber(msg.progressInfo.todayChallengedTimes)
	self._baseProgressInfo.progressInfo[tpType].practiceTimes = checknumber(msg.progressInfo.practiceTimes)
	self._baseProgressInfo.progressInfo[tpType].lockPetIds = msg.progressInfo.lockPetIds
	self._baseProgressInfo.progressInfo[tpType].totalHp = checknumber(msg.progressInfo.totalHp)
	self._baseProgressInfo.progressInfo[tpType].leftHp = checknumber(msg.progressInfo.leftHp)
	self._baseProgressInfo.progressInfo[tpType].realBossId = checknumber(msg.progressInfo.curBossId)

	local bossCfg

	if tpType == FamilyteamplayController.teamPlayType.Common then
		self:_checkSmallGameOpen(msg.availableGames)

		self._baseProgressInfo.availableGames = msg.availableGames
		self._baseProgressInfo.familyRank = checknumber(msg.myFamilyRank)
		bossCfg = FamilyteamplayConfig.instance:getBossCfg(msg.periodId, msg.progressInfo.curBossId)
	elseif tpType == FamilyteamplayController.teamPlayType.Season then
		bossCfg = FamilyteamplayConfig.instance:getTeamPlayBossSeason(msg.periodId, msg.curZoneId, msg.progressInfo.curBossId)
	end

	if bossCfg == nil or bossCfg.relativeOpenDay == 0 then
		return
	end

	local openTime = FamilyteamplayConfig.instance:getPeriodOpenTime(msg.periodId)

	if openTime + bossCfg.relativeOpenDay * 86400 > ServerTime.nowServerLook() then
		self._baseProgressInfo.progressInfo[tpType].leftHp = 0
		self._baseProgressInfo.progressInfo[tpType].realBossId = msg.progressInfo.curBossId - 1
	end
end

function FamilyteamplayModel:_checkSmallGameOpen(games)
	if checknumber(self._baseProgressInfo.newSmallGameId) > 0 or games == nil then
		return
	end

	local gameList = {}

	for _, info in ipairs(self._baseProgressInfo.availableGames or {}) do
		if info and checknumber(info.gameId) > 0 then
			gameList[info.gameId] = info.expiredTimeMillis
		end
	end

	local newGameList = {}

	for _, info in ipairs(games) do
		if info and checknumber(info.gameId) > 0 then
			newGameList[info.gameId] = info.expiredTimeMillis
		end
	end

	local nowTime = ServerTime.now()

	for gameId, etm in pairs(newGameList) do
		if not gameList[gameId] or checknumber(gameList[gameId]) ~= checknumber(etm) and nowTime < checknumber(etm) then
			self._baseProgressInfo.newSmallGameId = gameId

			return
		end
	end
end

function FamilyteamplayModel:setMemberZdlInfoList(zdlList)
	self._zdlInfoList = zdlList
end

function FamilyteamplayModel:setFamilyTeamPlayRank(msg)
	self._familyRankInfo = msg.rankInfo
end

function FamilyteamplayModel:setMemberDamageList(list)
	self._memberDamageList = list
end

function FamilyteamplayModel:getFamilySeasonRankList(periodId, zoneId)
	self._seasonRankList = self._seasonRankList or {}
	self._seasonRankList[periodId] = self._seasonRankList[periodId] or {}

	local info = self._seasonRankList[periodId][zoneId]
	local nowTime = ServerTime.nowServerLook()

	if info == nil or info.rankList == nil or nowTime <= checknumber(info.getTime) + 120 then
		return info, true
	end

	return info, false
end

function FamilyteamplayModel:setFamilySeasonRankList(msg, zoneId)
	if msg == nil or msg.periodId == nil then
		return
	end

	self._seasonRankList = self._seasonRankList or {}
	self._seasonRankList[msg.periodId] = self._seasonRankList[msg.periodId] or {}

	if self._seasonRankList[msg.periodId][zoneId] == nil then
		self._seasonRankList[msg.periodId][zoneId] = {}
	end

	self._seasonRankList[msg.periodId][zoneId].rankList = msg.rankInfo
	self._seasonRankList[msg.periodId][zoneId].myRank = checknumber(msg.myRank)
	self._seasonRankList[msg.periodId][zoneId].getTime = ServerTime.nowServerLook()
end

function FamilyteamplayModel:scChooseTeamPlayWarZone(zoneId)
	self:getBaseProgressInfo()

	self._baseProgressInfo.curZoneId = zoneId
end

function FamilyteamplayModel:setEndBattleInfo(msg)
	self._endBattleInfo = nil

	if not msg.isPratice then
		self._endBattleInfo = msg
	else
		self:getBaseProgressInfo()

		if checknumber(msg.zoneId) > 0 then
			self._baseProgressInfo.progressInfo[FamilyteamplayController.teamPlayType.Season].practiceTimes = self._baseProgressInfo.progressInfo[FamilyteamplayController.teamPlayType.Season].practiceTimes + 1
		else
			self._baseProgressInfo.progressInfo[FamilyteamplayController.teamPlayType.Common].practiceTimes = self._baseProgressInfo.progressInfo[FamilyteamplayController.teamPlayType.Common].practiceTimes + 1
		end
	end
end

FamilyteamplayModel.instance = FamilyteamplayModel.New()

return FamilyteamplayModel
