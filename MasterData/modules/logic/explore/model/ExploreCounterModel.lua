-- chunkname: @modules/logic/explore/model/ExploreCounterModel.lua

module("modules.logic.explore.model.ExploreCounterModel", package.seeall)

local ExploreCounterModel = class("ExploreCounterModel", BaseModel)

function ExploreCounterModel:onInit()
	self:clearData()
end

function ExploreCounterModel:reInit()
	self:clearData()
end

function ExploreCounterModel:clearData()
	self._countDic = {}
end

function ExploreCounterModel:reCalcCount()
	for _, counterMO in pairs(self._countDic) do
		counterMO:reCalcCount()
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.CounterInitDone)
end

function ExploreCounterModel:addCountSource(counterId, unitId)
	local counterMO = self._countDic[counterId]

	if counterMO == nil then
		counterMO = ExploreCounterMO.New()

		counterMO:init(counterId)

		self._countDic[counterId] = counterMO
	end

	counterMO:addCountSource(unitId)
end

function ExploreCounterModel:add(counterId, unitId)
	local counterMO = self._countDic[counterId]

	if counterMO then
		local preCount = counterMO.nowCount
		local isTrigger = counterMO:add(unitId)

		if preCount ~= counterMO.nowCount then
			ExploreController.instance:dispatchEvent(ExploreEvent.CounterChange, counterMO.tarUnitId, counterMO.nowCount)
		end

		if isTrigger then
			ExploreController.instance:dispatchEvent(ExploreEvent.TryTriggerUnit, counterMO.tarUnitId, true)
		end
	end
end

function ExploreCounterModel:reduce(counterId, unitId)
	local counterMO = self._countDic[counterId]

	if counterMO then
		local preCount = counterMO.nowCount
		local cancelTrigger = counterMO:reduce(unitId)

		if preCount ~= counterMO.nowCount then
			ExploreController.instance:dispatchEvent(ExploreEvent.CounterChange, counterMO.tarUnitId, counterMO.nowCount)
		end

		if cancelTrigger then
			ExploreController.instance:dispatchEvent(ExploreEvent.TryCancelTriggerUnit, counterMO.tarUnitId)
		end
	end
end

function ExploreCounterModel:getCount(counterId)
	local counterMO = self._countDic[counterId]

	if counterMO then
		return counterMO.nowCount
	else
		return 0
	end
end

function ExploreCounterModel:getTotalCount(counterId)
	local counterMO = self._countDic[counterId]

	if counterMO then
		return counterMO.tarCount
	else
		return 0
	end
end

ExploreCounterModel.instance = ExploreCounterModel.New()

return ExploreCounterModel
