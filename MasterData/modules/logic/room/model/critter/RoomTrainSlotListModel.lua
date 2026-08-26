-- chunkname: @modules/logic/room/model/critter/RoomTrainSlotListModel.lua

module("modules.logic.room.model.critter.RoomTrainSlotListModel", package.seeall)

local RoomTrainSlotListModel = class("RoomTrainSlotListModel", ListScrollModel)
local MAX_SLOT_NUM = 4

function RoomTrainSlotListModel:onInit()
	self:_clearData()
end

function RoomTrainSlotListModel:reInit()
	self:_clearData()
end

function RoomTrainSlotListModel:clear()
	RoomTrainSlotListModel.super.clear(self)
	self:_clearData()
end

function RoomTrainSlotListModel:_clearData()
	self:clearData()
end

function RoomTrainSlotListModel:clearData()
	RoomTrainSlotListModel.super.clear(self)

	self._selectId = nil
end

function RoomTrainSlotListModel:setSlotList()
	local critterMOList = CritterModel.instance:getCultivatingCritters()
	local moList = {}
	local selectId

	for i = 1, MAX_SLOT_NUM do
		local slotMO = RoomTrainSlotMO.New()
		local critterMO = critterMOList and critterMOList[i]

		slotMO:init({
			id = i,
			isLock = self:checkIsLock(i)
		})
		slotMO:setCritterMO(critterMO)

		if not slotMO:isFree() then
			selectId = selectId or slotMO.id
		end

		if critterMO and critterMO.id == self._selectCritterUid then
			selectId = slotMO.id
		end

		table.insert(moList, slotMO)
	end

	self._selectId = selectId or self._selectId

	self:setList(moList)
	self:_refreshSelect()
end

function RoomTrainSlotListModel:updateSlotList()
	local moList = self:getList()

	for i = 1, #moList do
		moList[i].isLock = self:checkIsLock(i)
	end

	self:onModelUpdate()
end

function RoomTrainSlotListModel:getTradeLevelCfgBySlotNum(slotNum)
	if not self._unLockDict then
		self._unLockDict = {}
		self._maxSloNum = 0

		local cfgList = lua_trade_level.configList

		for i, cfg in ipairs(cfgList) do
			local levelCfg = self._unLockDict[cfg.maxTrainSlotCount]

			if cfg.maxTrainSlotCount > self._maxSloNum then
				self._maxSloNum = cfg.maxTrainSlotCount
			end

			if not levelCfg or levelCfg.level > cfg.level then
				self._unLockDict[cfg.maxTrainSlotCount] = cfg
			end
		end
	end

	return self._unLockDict[slotNum]
end

function RoomTrainSlotListModel:checkIsLock(slotNum)
	if slotNum > MAX_SLOT_NUM then
		return true
	end

	local tradeLevelCfg = self:getTradeLevelCfgBySlotNum(slotNum)
	local tradeLevel = ManufactureModel.instance:getTradeLevel() or 0

	if tradeLevelCfg and tradeLevel < tradeLevelCfg.level then
		return true
	end

	return false
end

function RoomTrainSlotListModel:clearSelect()
	for i, view in ipairs(self._scrollViews) do
		view:setSelect(nil)
	end

	self._selectId = nil
end

function RoomTrainSlotListModel:_refreshSelect()
	local selectMO
	local moList = self:getList()

	for i, mo in ipairs(moList) do
		if mo.id == self._selectId then
			selectMO = mo
		end
	end

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomTrainSlotListModel:findFreeSlotMO()
	local moList = self:getList()

	for i = 1, #moList do
		local mo = moList[i]

		if mo and not mo.isLock and not mo.critterMO then
			return mo
		end
	end
end

function RoomTrainSlotListModel:setSelectCritterUid(critterUid)
	self._selectCritterUid = critterUid

	local slotMO = self:getSlotMOByCritterUi(critterUid)

	if slotMO then
		self:setSelect(slotMO.id)
	end
end

function RoomTrainSlotListModel:findWaitingSlotMOByUid(critterUid)
	local moList = self:getList()

	for i = 1, #moList do
		local mo = moList[i]

		if mo.waitingTrainUid == critterUid then
			return mo
		end
	end
end

function RoomTrainSlotListModel:getSlotMOByCritterUi(critterUid)
	local moList = self:getList()

	for i = 1, #moList do
		local mo = moList[i]

		if mo.critterMO and mo.critterMO.id == critterUid then
			return mo
		end
	end
end

function RoomTrainSlotListModel:getSlotMOByHeroId(heroId)
	local moList = self:getList()

	for i = 1, #moList do
		local mo = moList[i]

		if mo.critterMO and mo.critterMO.trainInfo and mo.critterMO.trainInfo.heroId == heroId then
			return mo
		end
	end
end

function RoomTrainSlotListModel:_getTrainAndFreeCount()
	local moList = self:getList()
	local train = 0
	local free = 0

	for i = 1, #moList do
		local mo = moList[i]

		if mo and not mo.isLock then
			if mo.critterMO then
				train = train + 1
			else
				free = free + 1
			end
		end
	end

	return train, free
end

function RoomTrainSlotListModel:getTrarinAndFreeCount()
	return self:_getTrainAndFreeCount()
end

function RoomTrainSlotListModel:getSelectMO()
	return self:getById(self._selectId)
end

function RoomTrainSlotListModel:getSelect()
	return self._selectId
end

function RoomTrainSlotListModel:setSelect(selectId)
	self._selectId = selectId

	self:_refreshSelect()
end

RoomTrainSlotListModel.instance = RoomTrainSlotListModel.New()

return RoomTrainSlotListModel
