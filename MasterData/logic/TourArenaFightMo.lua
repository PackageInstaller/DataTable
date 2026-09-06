-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaFightMo.lua

module("logic.extensions.tourarena.view.TourArenaFightMo", package.seeall)

local TourArenaFightMo = class("TourArenaFightMo")

function TourArenaFightMo:ctor(activityId)
	self._activityId = checknumber(activityId)

	local actData = TourArenaFightConfig.instance:getTafActData(activityId)

	if actData then
		self._periodId = actData.periodId or 0
	end

	self._prizeCfg = TourArenaFightConfig.instance:getTafPrizeCfg(self._activityId) or {}
	self._periodPrizeCfg = TourArenaFightConfig.instance:getTafPeriodPrizeCfg(self._periodId) or {}
	self._gainPrizeIdPool = {}
	self._zoneRankFirstInfoPool = {}
	self._totalRankResMsgPool = {}
	self._totalScore = 0
	self._periodTotalScore = 0
	self._gainPeriodPrizeIds = {}
end

function TourArenaFightMo:getActivityId()
	return self._activityId
end

function TourArenaFightMo:deepcopy()
	return TableUtil.deepcopy(self)
end

function TourArenaFightMo:getTotalScore()
	return self._totalScore
end

function TourArenaFightMo:setTotalScore(totalScore)
	self._totalScore = totalScore
end

function TourArenaFightMo:getTryGainPrizeOfProResultAndTips(prizeId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if self:isHasGainPrize(prizeId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = "您已领奖"
	elseif not self:isEnoughGainPrize(prizeId) then
		result = GameEnum.ResultCode.NotEnoughProgress
		tips = "未满足领奖要求"
	end

	return result, tips
end

function TourArenaFightMo:isCanGetPrize(prizeId)
	local result, tips = self:getTryGainPrizeOfProResultAndTips(prizeId)

	return result == GameEnum.ResultCode.Success
end

function TourArenaFightMo:isEnoughGainPrize(prizeId)
	local curProgress = self:getCurProgress()
	local data = TourArenaFightConfig.instance:getTafPrizeData(self._activityId, prizeId)
	local needProgress = data.score

	return needProgress <= curProgress
end

function TourArenaFightMo:isHasGainPrize(prizeId)
	return self._gainPrizeIdPool[prizeId]
end

function TourArenaFightMo:getCurProgress()
	return self:getTotalScore()
end

function TourArenaFightMo:getMaxProgress()
	local data = self._prizeCfg[#self._prizeCfg]

	return (data or nil) and (data.score or 0)
end

function TourArenaFightMo:getGainPrizeIdList()
	local prizeIdList = {}

	for prizeId, isHasGain in pairs(self._gainPrizeIdPool) do
		if isHasGain then
			table.insert(prizeIdList, prizeId)
		end
	end

	return prizeIdList
end

function TourArenaFightMo:clearPrizeIdOfGain()
	for prizeId, isHasGain in pairs(self._gainPrizeIdPool) do
		if isHasGain then
			self._gainPrizeIdPool[prizeId] = false
		end
	end
end

function TourArenaFightMo:setPrizeIdOfGain(prizeId, isGain)
	self._gainPrizeIdPool[prizeId] = checkbool(isGain)
end

function TourArenaFightMo:getTryGainPeriodPrizeOfProResultAndTips(prizeId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if self:isHasGainPeriodPrize(prizeId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = "您已领奖"
	elseif not self:isEnoughGainPeriodPrize(prizeId) then
		result = GameEnum.ResultCode.NotEnoughProgress
		tips = "未满足领奖要求"
	end

	return result, tips
end

function TourArenaFightMo:getPeriodTotalScore()
	return self._periodTotalScore
end

function TourArenaFightMo:getCurPeriodProgress()
	return self:getPeriodTotalScore()
end

function TourArenaFightMo:getMaxPeriodProgress()
	local data = self._periodPrizeCfg[#self._periodPrizeCfg]

	return (data or nil) and (data.score or 0)
end

function TourArenaFightMo:isCanGetPeriodPrize(prizeId)
	local result, tips = self:getTryGainPeriodPrizeOfProResultAndTips(prizeId)

	return result == GameEnum.ResultCode.Success
end

function TourArenaFightMo:isEnoughGainPeriodPrize(prizeId)
	local curProgress = self:getCurPeriodProgress()
	local data = TourArenaFightConfig.instance:getTafPeriodPrizeData(self._periodId, prizeId)
	local needProgress = data.score

	return needProgress <= curProgress
end

function TourArenaFightMo:isHasGainPeriodPrize(prizeId)
	return self._gainPeriodPrizeIds[prizeId] or false
end

function TourArenaFightMo:getPeriodGainPrizeIdList()
	local prizeIdList = {}

	for prizeId, isHasGain in pairs(self._gainPeriodPrizeIds) do
		if isHasGain then
			table.insert(prizeIdList, prizeId)
		end
	end

	return prizeIdList
end

function TourArenaFightMo:setPeriodTotalScore(periodTotalScore)
	self._periodTotalScore = periodTotalScore
end

function TourArenaFightMo:clearPeriodPrizeIdOfGain()
	for prizeId, isHasGain in pairs(self._gainPeriodPrizeIds) do
		if isHasGain then
			self._gainPeriodPrizeIds[prizeId] = false
		end
	end
end

function TourArenaFightMo:setPeriodPrizeIdOfGain(prizeId, isGain)
	self._gainPeriodPrizeIds[prizeId] = checkbool(isGain)
end

function TourArenaFightMo:handlePeriodRankRes(msg)
	self._periodRankResMsg = msg
end

function TourArenaFightMo:getPeriodRankResMsg()
	return self._periodRankResMsg
end

function TourArenaFightMo:getZoneIdListOfRankFirstInfo()
	local list = {}

	for zoneId, info in pairs(self._zoneRankFirstInfoPool) do
		table.insert(list, zoneId)
	end

	table.sort(list, function(a, b)
		if a == b then
			return false
		end

		return b < a
	end)

	return list
end

function TourArenaFightMo:getCommonRankInfoOfZoneRankFirst(zoneId)
	local info = self:getZoneRankFirstInfo(zoneId)

	return (info or nil) and info.first
end

function TourArenaFightMo:getZoneRankFirstInfo(zoneId)
	return self._zoneRankFirstInfoPool[zoneId]
end

function TourArenaFightMo:setZoneRankFirstInfo(zoneId, info)
	self._zoneRankFirstInfoPool[zoneId] = info
end

function TourArenaFightMo:clearAllZoneRankFirstInfo()
	table.clear(self._zoneRankFirstInfoPool)
end

function TourArenaFightMo:_getTotalRankResMsg(zoneId)
	return self._totalRankResMsgPool[zoneId]
end

function TourArenaFightMo:_handleTotalRankRes(msg)
	self._totalRankResMsgPool[msg.zoneId] = msg
end

return TourArenaFightMo
