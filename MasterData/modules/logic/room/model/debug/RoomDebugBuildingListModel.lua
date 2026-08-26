-- chunkname: @modules/logic/room/model/debug/RoomDebugBuildingListModel.lua

module("modules.logic.room.model.debug.RoomDebugBuildingListModel", package.seeall)

local RoomDebugBuildingListModel = class("RoomDebugBuildingListModel", ListScrollModel)

function RoomDebugBuildingListModel:onInit()
	self:_clearData()
end

function RoomDebugBuildingListModel:reInit()
	self:_clearData()
end

function RoomDebugBuildingListModel:clear()
	RoomDebugBuildingListModel.super.clear(self)
	self:_clearData()
end

function RoomDebugBuildingListModel:_clearData()
	self._selectBuildingId = nil
end

function RoomDebugBuildingListModel:setDebugBuildingList()
	local moList = {}
	local buildingConfigList = RoomConfig.instance:getBuildingConfigList()

	for i, buildingConfig in pairs(buildingConfigList) do
		local roomDebugBuildingMO = RoomDebugBuildingMO.New()

		roomDebugBuildingMO:init({
			id = buildingConfig.id
		})
		table.insert(moList, roomDebugBuildingMO)
	end

	table.sort(moList, self._sortFunction)
	self:setList(moList)
	self:_refreshSelect()
end

function RoomDebugBuildingListModel._sortFunction(x, y)
	return x.id < y.id
end

function RoomDebugBuildingListModel:clearSelect()
	for i, view in ipairs(self._scrollViews) do
		view:setSelect(nil)
	end

	self._selectBuildingId = nil
end

function RoomDebugBuildingListModel:_refreshSelect()
	local selectMO
	local moList = self:getList()

	for i, mo in ipairs(moList) do
		if mo.id == self._selectBuildingId then
			selectMO = mo
		end
	end

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomDebugBuildingListModel:setSelect(buildingId)
	self._selectBuildingId = buildingId

	self:_refreshSelect()
end

function RoomDebugBuildingListModel:getSelect()
	return self._selectBuildingId
end

function RoomDebugBuildingListModel:initDebugBuilding()
	self:setDebugBuildingList()
end

RoomDebugBuildingListModel.instance = RoomDebugBuildingListModel.New()

return RoomDebugBuildingListModel
