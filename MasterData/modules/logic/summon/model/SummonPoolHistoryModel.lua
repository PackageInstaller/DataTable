-- chunkname: @modules/logic/summon/model/SummonPoolHistoryModel.lua

module("modules.logic.summon.model.SummonPoolHistoryModel", package.seeall)

local SummonPoolHistoryModel = class("SummonPoolHistoryModel", BaseModel)

function SummonPoolHistoryModel:onInit()
	self._dataList = {}
	self._allMaxNum = 0
	self._getNextTime = 0
	self._typeNums = {}
	self._requestPools = {}
	self._token = nil
	self._tokenEndTime = 0
	self._summonShowTypeDic = nil
end

function SummonPoolHistoryModel:reInit()
	self._dataList = {}
	self._allMaxNum = 0
	self._getNextTime = 0
	self._typeNums = {}
	self._requestPools = {}
	self._token = nil
	self._tokenEndTime = 0
	self._summonShowTypeDic = nil
end

function SummonPoolHistoryModel:isDataValidity()
	if self._getNextTime > Time.time then
		return true
	end

	return false
end

function SummonPoolHistoryModel:onGetInfo(data)
	if data == nil or data.pageData == nil or #data.pageData < 1 then
		if self._allMaxNum > 0 then
			self:reInit()
		end

		return
	end

	self._dataList = data.pageData

	local count = 0
	local typeNums = {}

	for _, history in ipairs(self._dataList) do
		history.gainIds = history.gainIds or {}
		history.gainHeroList = history.gainHeroList or {}

		if history.luckyBagIds ~= nil and #history.luckyBagIds > 0 then
			history.luckyBagIdSet = {}

			for _, luckyBagId in ipairs(history.luckyBagIds) do
				history.luckyBagIdSet[luckyBagId] = true
			end
		end

		local poolType = self:_getShowPoolType(history.poolId, history.poolType)

		if poolType then
			count = count + #history.gainIds
			typeNums[poolType] = typeNums[poolType] or 0
			typeNums[poolType] = typeNums[poolType] + #history.gainIds
		end
	end

	self._allMaxNum = count
	self._typeNums = typeNums
	self._getNextTime = Time.time + 600
end

function SummonPoolHistoryModel:getShowPoolTypeByPoolId(poolId)
	local cfg = SummonConfig.instance:getSummonPool(poolId)

	return cfg and self:_getShowPoolType(poolId, cfg.type)
end

function SummonPoolHistoryModel:_getShowPoolType(poolId, poolType)
	if not self._summonShowTypeDic then
		self._summonShowTypeDic = {}

		local list = SummonConfig.instance:getSummonPoolList()

		for i = 1, #list do
			local cfg = list[i]

			if cfg.historyShowType and cfg.historyShowType ~= 0 and SummonConfig.instance:getPoolDetailConfig(cfg.historyShowType) then
				self._summonShowTypeDic[cfg.id] = cfg.historyShowType
			end
		end
	end

	return self._summonShowTypeDic[poolId] or poolType
end

function SummonPoolHistoryModel:getNumByPoolId(poolId)
	if poolId == nil then
		return 0
	end

	return self._typeNums[poolId] or 0
end

function SummonPoolHistoryModel:updateSummonResult(summonResult)
	if summonResult and #summonResult > 0 then
		local nextTime = Time.time + 300

		if self._getNextTime == nil or nextTime < self._getNextTime then
			self._getNextTime = nextTime
		end
	end
end

function SummonPoolHistoryModel:getHistoryListByIndexOf(start, num, poolType)
	local list = {}
	local count = 0

	for _, histroy in ipairs(self._dataList) do
		local histroyType = self:_getShowPoolType(histroy.poolId, histroy.poolType)

		if poolType == histroyType then
			if start <= count then
				self:_addHistoryToList(list, histroy, 1 - start, num - #list)
			elseif count < start and start <= count + #histroy.gainIds then
				self:_addHistoryToList(list, histroy, start - count, num - #list)
			end

			count = count + #histroy.gainIds
		end

		if num <= #list then
			break
		end
	end

	return list
end

function SummonPoolHistoryModel:_addHistoryToList(list, historyData, start, num)
	if not historyData.gainIds or #historyData.gainIds < 1 then
		return
	end

	local gainIdCount = #historyData.gainIds

	list = list or {}
	start = math.max(1, start)

	local len = start + num

	len = math.min(len, gainIdCount)

	for i = start, len do
		local index = gainIdCount - i + 1
		local gainId = historyData.gainIds[index]
		local tmpData = {
			createTime = historyData.createTime,
			summonType = historyData.summonType,
			poolName = historyData.poolName,
			gainId = gainId,
			poolId = historyData.poolId
		}

		if SummonConfig.poolTypeIsLuckyBag(historyData.poolType) and historyData.luckyBagIdSet and historyData.luckyBagIdSet[gainId] then
			tmpData.isLuckyBag = true
		end

		table.insert(list, tmpData)
	end

	return list
end

function SummonPoolHistoryModel:getHistoryValidPools()
	local typeNums = self._typeNums
	local result = {}
	local resultDict = {}
	local poolDetailCfgList = SummonConfig.instance:getPoolDetailConfigList()

	for i, pooldetailCfg in ipairs(poolDetailCfgList) do
		if pooldetailCfg.historyShowType == 1 then
			self:_addHistoryValidPools(result, resultDict, pooldetailCfg.id)
		end
	end

	local poolCfgs = SummonMainModel.getValidPools()

	for _, cfg in ipairs(poolCfgs) do
		local poolType = self:_getShowPoolType(cfg.id, cfg.type)

		self:_addHistoryValidPools(result, resultDict, poolType)
	end

	local curTime = Time.time

	for poolId, time in pairs(self._requestPools) do
		if curTime <= time then
			local cfg = SummonConfig.instance:getSummonPool(poolId)

			if cfg then
				local poolType = self:_getShowPoolType(cfg.id, cfg.type)

				self:_addHistoryValidPools(result, resultDict, poolType)
			else
				logNormal(string.format("配置表找不到id为%s的卡池", poolId))
			end
		end
	end

	for pooltype, _ in pairs(typeNums) do
		self:_addHistoryValidPools(result, resultDict, pooltype)
	end

	if #result > 1 then
		table.sort(result, function(a, b)
			if a.order ~= b.order then
				return a.order < b.order
			end
		end)
	end

	return result
end

function SummonPoolHistoryModel:_addHistoryValidPools(list, dict, poolType)
	if poolType == nil or dict[poolType] then
		return
	end

	local pooldetailCfg = SummonConfig.instance:getPoolDetailConfig(poolType)

	if self:isCanShowByPoolTypeId(poolType) then
		dict[poolType] = true

		table.insert(list, pooldetailCfg)
	end
end

function SummonPoolHistoryModel:isCanShowByPoolTypeId(poolTypeId)
	local pooldetailCfg = SummonConfig.instance:getPoolDetailConfig(poolTypeId)

	if pooldetailCfg and pooldetailCfg.historyShowType ~= 99 and (pooldetailCfg.openId == nil or pooldetailCfg.openId == 0 or OpenModel.instance:isFunctionUnlock(pooldetailCfg.openId)) then
		return true
	end

	return false
end

function SummonPoolHistoryModel:addRequestHistoryPool(poolId)
	if not poolId then
		return
	end

	self._requestPools[poolId] = Time.time + 3600
end

function SummonPoolHistoryModel:getToken(token)
	return self._token
end

function SummonPoolHistoryModel:setToken(token)
	self._token = token
	self._tokenEndTime = Time.time + 300 - 10
end

function SummonPoolHistoryModel:isTokenValidity()
	return self._tokenEndTime > Time.time
end

SummonPoolHistoryModel.instance = SummonPoolHistoryModel.New()

return SummonPoolHistoryModel
