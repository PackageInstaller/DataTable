-- chunkname: @modules/logic/room/model/transport/RoomTransportBuildingSkinListModel.lua

module("modules.logic.room.model.transport.RoomTransportBuildingSkinListModel", package.seeall)

local RoomTransportBuildingSkinListModel = class("RoomTransportBuildingSkinListModel", ListScrollModel)

function RoomTransportBuildingSkinListModel:setBuildingUid(buildingUid)
	local info = RoomModel.instance:getBuildingInfoByBuildingUid(buildingUid)

	if info then
		if not info.buildingId then
			self:setBuildingId(info.buildingId)
		end
	else
		self:setList({})
	end
end

function RoomTransportBuildingSkinListModel:setBuildingId(buildingId)
	local moList = {}
	local buildingCfg = RoomConfig.instance:getBuildingConfig(buildingId)
	local skinCfgList = RoomConfig.instance:getBuildingSkinList(buildingId)

	if skinCfgList then
		for i, skinCfg in ipairs(skinCfgList) do
			local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, skinCfg.itemId)
			local mo = {
				id = skinCfg.id,
				buildingId = buildingId,
				config = skinCfg,
				buildingCfg = buildingCfg,
				isLock = (quantity > 0 or nil) and false
			}

			table.insert(moList, mo)
		end
	end

	local mo = {
		isLock = false,
		id = 0,
		buildingId = buildingId,
		buildingCfg = buildingCfg
	}

	table.insert(moList, mo)
	table.sort(moList, self:_getSortFunc())
	self:setList(moList)
end

function RoomTransportBuildingSkinListModel:_getSortFunc()
	if self._sortFunc_ then
		return self._sortFunc_
	end

	function self._sortFunc_(a, b)
		if a.isLock ~= b.isLock then
			if b.isLock then
				return true
			end

			return false
		end

		if a.id ~= b.id then
			if a.id == 0 or a.id > b.id then
				return true
			end

			return false
		end
	end

	return self._sortFunc_
end

function RoomTransportBuildingSkinListModel:getBuildingUid()
	return self._buildingUid
end

function RoomTransportBuildingSkinListModel:getSelectMO()
	return self:getById(self._selectId)
end

function RoomTransportBuildingSkinListModel:getSelect()
	return self._selectId
end

function RoomTransportBuildingSkinListModel:_refreshSelect()
	local selectMO = self:getById(self._selectId)

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomTransportBuildingSkinListModel:setSelect(skinId)
	self._selectId = skinId

	self:_refreshSelect()
end

RoomTransportBuildingSkinListModel.instance = RoomTransportBuildingSkinListModel.New()

return RoomTransportBuildingSkinListModel
