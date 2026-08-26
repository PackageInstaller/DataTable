-- chunkname: @modules/logic/room/model/map/RoomProductionModel.lua

module("modules.logic.room.model.map.RoomProductionModel", package.seeall)

local RoomProductionModel = class("RoomProductionModel", BaseModel)

function RoomProductionModel:onInit()
	self:clear()
end

function RoomProductionModel:reInit()
	self:clear()
end

function RoomProductionModel:clear()
	RoomProductionModel.super.clear(self)
	TaskDispatcher.cancelTask(self._OnTimeNextFinish, self)

	self._unlockAnimLineIdDict = {}
	self._unlockDetailAnimLineIdDict = {}
end

function RoomProductionModel:updateProductionLines(originList)
	local list = {}

	for _, productionLine in ipairs(originList) do
		if productionLine.id ~= 0 then
			local mo = self:getLineMO(productionLine.id)

			mo:updateInfo(productionLine)
			table.insert(list, mo)
		end
	end

	self:addList(list)
	RoomController.instance:dispatchEvent(RoomEvent.UpdateProduceLineData)

	local _allList = self:getList()
	local minNextFinishTime, delayTime
	local nowTime = ServerTime.now()
	local nextFinishList = {}

	for i, mo in ipairs(_allList) do
		if mo.nextFinishTime > 0 and mo.pauseTime == 0 then
			if minNextFinishTime == nil or minNextFinishTime > mo.nextFinishTime then
				minNextFinishTime = mo.nextFinishTime
				delayTime = mo.nextFinishTime - nowTime
				nextFinishList = {}

				table.insert(nextFinishList, mo.id)
			elseif mo.nextFinishTime == minNextFinishTime then
				table.insert(nextFinishList, mo.id)
			end
		end
	end

	self:updateNextFinishList(nextFinishList, delayTime)
end

function RoomProductionModel:updateNextFinishList(list, delayTime)
	self._nextFinishList = list

	TaskDispatcher.cancelTask(self._OnTimeNextFinish, self)

	if delayTime then
		delayTime = math.max(1, delayTime)

		TaskDispatcher.runDelay(self._OnTimeNextFinish, self, delayTime + 0.5)
	end
end

function RoomProductionModel:_OnTimeNextFinish(list)
	RoomRpc.instance:sendProductionLineInfoRequest(list)
end

function RoomProductionModel:updateProductionLinesLevel(id, newLevel)
	local mo = self:getLineMO(id)

	mo:updateLevel(newLevel)
	RoomController.instance:dispatchEvent(RoomEvent.UpdateProduceLineData)
	RoomController.instance:dispatchEvent(RoomEvent.ProduceLineLevelUp)
end

function RoomProductionModel:getLineMO(id)
	local mo = self:getById(id)

	if mo == nil then
		mo = RoomProductionLineMO.New()

		mo:init(id)
	end

	return mo
end

function RoomProductionModel:updateLineMaxLevel()
	local lineMOList = self:getList()

	for _, lineMO in ipairs(lineMOList) do
		lineMO:updateMaxLevel()
	end
end

function RoomProductionModel:checkUnlockLine(roomLevel)
	for _, config in ipairs(lua_production_line.configList) do
		local lineId = config.id

		if not RoomProductionHelper.isLineUnlock(lineId, roomLevel - 1) and RoomProductionHelper.isLineUnlock(lineId, roomLevel) then
			self:setPlayLineUnlock(lineId, true)
			self:setPlayLineUnlockDetail(lineId, true)
		end
	end
end

function RoomProductionModel:shouldPlayLineUnlock(lineId)
	return self._unlockAnimLineIdDict[lineId]
end

function RoomProductionModel:setPlayLineUnlock(lineId, value)
	self._unlockAnimLineIdDict[lineId] = value
end

function RoomProductionModel:shouldPlayLineUnlockDetail(lineId)
	return self._unlockDetailAnimLineIdDict[lineId]
end

function RoomProductionModel:setPlayLineUnlockDetail(lineId, value)
	self._unlockDetailAnimLineIdDict[lineId] = value
end

RoomProductionModel.instance = RoomProductionModel.New()

return RoomProductionModel
