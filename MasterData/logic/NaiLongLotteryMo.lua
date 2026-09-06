-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonglottery/data/NaiLongLotteryMo.lua

module("logic.extensions.nailonglottery.data.NaiLongLotteryMo", package.seeall)

local NaiLongLotteryMo = class("NaiLongLotteryMo")

function NaiLongLotteryMo:ctor(activityId)
	self._activityId = activityId
	self._todayShareTimes = 0
	self._gainPrizeIds = {}
	self._globalShareTimes = 0
	self._prizeGainTimes = {}

	local actData = NaiLongLotteryConfig.instance:getActData(self._activityId)

	self._lotteryCost = actData and actData.lotteryCost

	local matType, matId, matNum = MaterialMgr.getMatParams(self._lotteryCost)

	self._lotteryCostMatArray = {
		matType = checknumber(matType),
		matId = checknumber(matId),
		matNum = checknumber(matNum)
	}
	self._sharePrize = actData.sharePrize

	local matType, matId, matNum = MaterialMgr.getMatParams(self._sharePrize)

	self._sharePrizeMatArray = {
		matType = checknumber(matType),
		matId = checknumber(matId),
		matNum = checknumber(matNum)
	}
	self._maxDailyShareTimes = actData.dailyShareTimes
end

function NaiLongLotteryMo:dispose()
	return
end

function NaiLongLotteryMo:handlePM_ShareLotteryGetInfoRes(msg)
	self._todayShareTimes = msg.todayShareTimes
	self._gainPrizeIds = GameUtil.pbToTable(msg.gainPrizeIds) or {}
	self._globalShareTimes = checknumber(msg.globalShareTimes)

	table.clear(self._prizeGainTimes)

	for _, v in ipairs(msg.prizeList) do
		self._prizeGainTimes[v.prizeId] = v.gainTimes
	end
end

function NaiLongLotteryMo:handlePM_ShareLotteryLotteryRes(msg)
	self._prizeGainTimes[msg.prizeId] = checknumber(self._prizeGainTimes[msg.prizeId]) + 1
end

function NaiLongLotteryMo:handlePM_ShareLotteryShareRes(msg)
	self._todayShareTimes = msg.todayShareTimes
end

function NaiLongLotteryMo:handlePM_ShareLotteryGainPrizeRes(msg)
	table.insertto(self._gainPrizeIds, msg.prizeIds)
end

function NaiLongLotteryMo:getTodayShareTimes()
	return self._todayShareTimes
end

function NaiLongLotteryMo:getMaxDailyShareTimes()
	return self._maxDailyShareTimes
end

function NaiLongLotteryMo:getGlobalShareTimes()
	return self._globalShareTimes
end

function NaiLongLotteryMo:getPrizeGainTimes(prizeId)
	return checknumber(self._prizeGainTimes[prizeId])
end

function NaiLongLotteryMo:getMaxPrizeGainTimes(prizeId)
	local data = NaiLongLotteryConfig.instance:getPrizeData(self._activityId, prizeId)

	return (data or nil) and (data.gainTimesLimit or 0)
end

function NaiLongLotteryMo:getLeftPrizeGainTimes(prizeId)
	local max = self:getMaxPrizeGainTimes(prizeId)
	local cur = self:getPrizeGainTimes(prizeId)

	return Mathf.Max(0, max - cur)
end

function NaiLongLotteryMo:isHavePrizeCanGain()
	local result = false
	local cfg = NaiLongLotteryConfig.instance:getPrizeCfg(self._activityId)

	for _, data in ipairs(cfg) do
		if self:getLeftPrizeGainTimes(data.prizeId) > 0 then
			result = true

			break
		end
	end

	return result
end

function NaiLongLotteryMo:getLotteryCost()
	return self._lotteryCost
end

function NaiLongLotteryMo:getLotteryCostNum()
	return self._lotteryCostMatArray.matNum
end

function NaiLongLotteryMo:getLotteryTimes()
	local costNum = self:getLotteryCostNum()
	local curNum = MaterialModel.instance:getMaterialsNumber(self._lotteryCostMatArray.matType, self._lotteryCostMatArray.matId)

	return Mathf.Floor(curNum / costNum)
end

function NaiLongLotteryMo:getSharePrizeNum()
	return self._sharePrizeMatArray.matNum
end

function NaiLongLotteryMo:getEachShareCanLotteryTimes()
	local eachGetNum = self:getSharePrizeNum()
	local costNum = self:getLotteryCostNum()

	return Mathf.Floor(eachGetNum / costNum)
end

function NaiLongLotteryMo:getDailyShareCanLotteryTimes()
	local dailyGetNum = self:getSharePrizeNum() * self._maxDailyShareTimes
	local costNum = self:getLotteryCostNum()

	return Mathf.Floor(dailyGetNum / costNum)
end

function NaiLongLotteryMo:isCanGetProgressPrize(prizeId)
	return not self:isHasGainProgressPrize(prizeId) and self:isEnoughGetProgressPrize(prizeId)
end

function NaiLongLotteryMo:isHasGainProgressPrize(prizeId)
	return table.indexof(self._gainPrizeIds, prizeId) ~= false
end

function NaiLongLotteryMo:isEnoughGetProgressPrize(prizeId)
	local cur = self:getGlobalShareTimes()
	local data = NaiLongLotteryConfig.instance:getProgressPrizeData(self._activityId, prizeId)

	if data then
		if not data.needShareCount then
			local need = 0

			return need <= cur
		end
	end
end

return NaiLongLotteryMo
