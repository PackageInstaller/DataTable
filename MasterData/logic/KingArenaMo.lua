-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/data/KingArenaMo.lua

module("logic.extensions.kingarena.data.KingArenaMo", package.seeall)

local KingArenaMo = class("KingArenaMo")

function KingArenaMo:ctor(seasonId)
	self._seasonId = seasonId
	self._zoneId = 0
	self._zoneInfoDic = {}
	self._dailyFightTimes = 0
	self._myCurRank = 0
	self._bestRank = 0
	self._gainBestRankPrizeIds = {}
	self._opList = {}
	self._lastRefreshtime = 0
	self._lastFightTime = 0
	self._dailyBuyFightTimes = 0
	self._changeZoneTimes = 0
	self._hasFight = false
	self._myAreaId = -1
end

function KingArenaMo:getSeasonId()
	return self._seasonId
end

function KingArenaMo:handlePM_KingArenaGetInfoRes(msg)
	self._zoneId = msg.zoneId
	self._dailyFightTimes = msg.dailyFightTimes
	self._myCurRank = msg.myCurRank
	self._bestRank = msg.bestRank
	self._gainBestRankPrizeIds = GameUtil.pbToTable(msg.gainBestRankPrizeIds) or {}
	self._opList = msg.opList
	self._lastRefreshtime = msg.lastRefreshtime
	self._lastFightTime = msg.lastFightTime
	self._dailyBuyFightTimes = msg.dailyBuyFightTimes
	self._changeZoneTimes = msg.changeZoneTimes
	self._hasFight = checkbool(msg.hasFight)
	self._myAreaId = msg.myAreaId

	for i, v in ipairs(msg.zoneList) do
		self._zoneInfoDic[v.zoneId] = v
	end
end

function KingArenaMo:handlePM_KingArenaFightRes(msg)
	self._myCurRank = msg.newRank
	self._bestRank = msg.bestRank
	self._dailyFightTimes = msg.dailyFightTimes
	self._hasFight = true

	if msg:HasField("lastFightTime") then
		self._lastFightTime = msg.lastFightTime
	end
end

function KingArenaMo:handlePM_KingArenaRefreshOpRes(msg)
	self._lastRefreshtime = msg.lastRefreshtime
	self._opList = msg.opList
end

function KingArenaMo:handlePM_KingArenaBuyFightTimesRes(msg)
	self._dailyBuyFightTimes = msg.dailyBuyFightTimes
end

function KingArenaMo:handlePM_KingArenaGainSeasonPrizeRes(msg)
	for _, prizeId in ipairs(msg.prizeId or {}) do
		if table.indexof(self._gainBestRankPrizeIds, prizeId) == false then
			table.insert(self._gainBestRankPrizeIds, prizeId)
		end
	end
end

function KingArenaMo:handlePM_KingArenaResetZoneRes(msg)
	self._zoneInfoDic[msg.zone.zoneId] = msg.zone
	self._changeZoneTimes = msg.changeZoneTimes
end

function KingArenaMo:handlePM_KingArenaGetRecordsRes(msg)
	return
end

function KingArenaMo:handlePM_KingArenaPetRankViewRes(msg)
	return
end

function KingArenaMo:getZoneId()
	return self._zoneId
end

function KingArenaMo:getMyAreaId()
	return self._myAreaId
end

function KingArenaMo:getZoneInfo(zoneId)
	return self._zoneInfoDic[zoneId]
end

function KingArenaMo:getZonePlayerNum(zoneId)
	local info = self:getZoneInfo(zoneId)

	return (info or nil) and (info.curNum or 0)
end

function KingArenaMo:getMaxZonePlayerNum()
	return KingArenaConfig.instance:getCommonValue("MAX_ZONE_CAPACITY", true)
end

function KingArenaMo:isExceedsZonePlayerNum(zoneId)
	local cur = self:getZonePlayerNum(zoneId)
	local max = self:getMaxZonePlayerNum()

	return max <= cur
end

function KingArenaMo:getDailyFightTimes()
	return self._dailyFightTimes
end

function KingArenaMo:getFreeDailyFightTimes()
	return KingArenaConfig.instance:getCommonValue("DAILY_FREE_FIGHT_TIMES", true)
end

function KingArenaMo:getLeftFreeDailyFightTimes()
	local cur = self:getDailyFightTimes()
	local max = self:getFreeDailyFightTimes()

	return Mathf.Max(0, max - cur)
end

function KingArenaMo:getLeftCanGainPrizeFightTimes()
	local cur = self:getDailyFightTimes()
	local max = self:getMaxCanGainPrizeFightTimes()

	return Mathf.Max(0, max - cur)
end

function KingArenaMo:getMaxCanGainPrizeFightTimes()
	return KingArenaConfig.instance:getCommonValue("DAILY_PRIZE_TIMES", true)
end

function KingArenaMo:getMyCurRank()
	return self._myCurRank
end

function KingArenaMo:getBestRank()
	return self._bestRank
end

function KingArenaMo:getZdlRatio()
	local rank = self:getMyCurRank()
	local data = KingArenaConfig.instance:getZdlRatioData(rank)

	return (data or nil) and checknumber(data.ratio)
end

function KingArenaMo:getGainBestRankPrizeIds()
	return self._gainBestRankPrizeIds
end

function KingArenaMo:isHasGainBestRankPrize(prizeId)
	local ids = self:getGainBestRankPrizeIds()

	return table.indexof(ids, prizeId) ~= false
end

function KingArenaMo:isEnoughGetBestRankPrize(prizeId)
	local result = false
	local data = KingArenaConfig.instance:getBestRankPrizeDataById(self._seasonId, prizeId)

	if data then
		local cur = self:getBestRank()
		local max = data.range[2]

		result = cur > 0 and cur <= max
	end

	return result
end

function KingArenaMo:getRankPrizeState(prizeId)
	local isHasGain = self:isHasGainBestRankPrize(prizeId)

	if isHasGain then
		return GameEnum.PrizeState.IsHasGain
	end

	local isEnough = self:isEnoughGetBestRankPrize(prizeId)

	if not isEnough then
		return GameEnum.PrizeState.IsNotEnough
	end

	return GameEnum.PrizeState.IsCanGet
end

function KingArenaMo:isCanGainBestRankPrizeById(prizeId)
	local state = self:getRankPrizeState(prizeId)

	return state == GameEnum.PrizeState.IsCanGet
end

function KingArenaMo:isCanGainBestRankPrize(periodId)
	local result = false
	local cfg = KingArenaConfig.instance:getBestRankPrizeCfg(self._seasonId)

	if cfg then
		for _, data in ipairs(cfg) do
			if self:isCanGainBestRankPrizeById(data.rankPrizeId) then
				result = true

				break
			end
		end
	end

	return result
end

function KingArenaMo:getOpList()
	return self._opList
end

function KingArenaMo:getLastRefreshtime()
	return self._lastRefreshtime
end

function KingArenaMo:getLastFightTime()
	return checknumber(self._lastFightTime)
end

function KingArenaMo:getDailyBuyFightTimes()
	return self._dailyBuyFightTimes
end

function KingArenaMo:getMaxBuyFightTimes()
	return KingArenaConfig.instance:getMaxBuyFightTimes(self._seasonId)
end

function KingArenaMo:getLeftDailyBuyFightTimes()
	local cur = self:getDailyBuyFightTimes()
	local max = self:getMaxBuyFightTimes()

	return Mathf.Max(0, max - cur)
end

function KingArenaMo:getChangeZoneTimes()
	return self._changeZoneTimes
end

function KingArenaMo:isHasFight()
	return self._hasFight
end

function KingArenaMo:getFreeChangeZoneTimes()
	local times = 0
	local cfg = KingArenaConfig.instance:getSelectCostCfg(self._seasonId)

	if cfg then
		for i, v in ipairs(cfg) do
			if string.nilorempty(v.cost) then
				times = times + 1
			end
		end
	end

	return times
end

function KingArenaMo:getMaxBuyChangeZoneTimes()
	local max = self:getMaxChangeZoneTimes()

	return max - self:getFreeChangeZoneTimes()
end

function KingArenaMo:getMaxChangeZoneTimes()
	return KingArenaConfig.instance:getMaxSelectCostTimes(self._seasonId)
end

return KingArenaMo
