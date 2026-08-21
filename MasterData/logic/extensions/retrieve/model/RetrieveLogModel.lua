-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/model/RetrieveLogModel.lua

module("logic.extensions.retrieve.model.RetrieveLogModel", package.seeall)

local M = class("RetrieveLogModel", BaseModel)

function M:ctor()
	self._lotteryLogList = nil
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._lotteryLogList = {}
	self._tempData = BaseListModel.New()
end

function M:getLotteryLogData()
	return self._lotteryLogList
end

function M:cacheLotteryLogData(logs)
	self._lotteryLogList = {}

	for i, log in ipairs(logs) do
		local lotteryId = log.poolCode

		self._lotteryLogList[lotteryId] = self._lotteryLogList[lotteryId] or {}

		table.insert(self._lotteryLogList[lotteryId], log)
	end

	RetrieveDispatcher:dispatchEvent(RetrieveEventType.LOTTERY_LOG_FILTER)
end

function M:filterLogData(lotteryId)
	self._tempData:clear()

	if not lotteryId then
		return self._tempData
	end

	self._lotteryLogList[lotteryId] = self._lotteryLogList[lotteryId] or {}

	local configCO = RetrieveConfig.instance:getConfigByKey(ConfigName.LotteryPool, lotteryId)
	local tempType = RetrieveEnum.LotteryType.CommonCard
	local lotteryType = RetrieveEnum.LotterySimpleType.Card

	if tempType == RetrieveEnum.LotteryType.CommonEcho or tempType == RetrieveEnum.LotteryType.OptionalEcho then
		lotteryType = RetrieveEnum.LotterySimpleType.Echo
	else
		lotteryType = RetrieveEnum.LotterySimpleType.Card
	end

	for i, log in ipairs(self._lotteryLogList[lotteryId]) do
		self._tempData:addMo({
			id = i,
			log = log,
			type = lotteryType
		})
	end

	return self._tempData
end

function M._logSort(logA, logB)
	if logA.time <= logB.time then
		return false
	else
		return true
	end
end

function M:setKeyword(keyword)
	self._cacheKeyword = keyword
end

function M:getKeyword()
	return self._cacheKeyword
end

M.instance = M.New()

return M
