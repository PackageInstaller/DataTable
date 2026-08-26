-- chunkname: @modules/logic/room/model/transport/RoomTransportBuildingListModel.lua

module("modules.logic.room.model.transport.RoomTransportBuildingListModel", package.seeall)

local RoomTransportBuildingListModel = class("RoomTransportBuildingListModel", ListScrollModel)

function RoomTransportBuildingListModel:setBuildingList()
	local moList = {}
	local buildingIdDict = {}
	local infoList = RoomModel.instance:getBuildingInfoList()

	for i = 1, #infoList do
		local info = infoList[i]
		local isUse = not not RoomMapBuildingModel.instance:getBuildingMOById(info.uid)

		if not info.buildingId then
			local buildingId = info.defineId

			if self:_checkInfoShow(buildingId, isUse) then
				local showBuildingMO = isUse

				buildingIdDict[buildingId] = true
				showBuildingMO = RoomShowBuildingMO.New()

				showBuildingMO:init(info)

				showBuildingMO.use = isUse

				showBuildingMO:add(info.uid, info.level)
				table.insert(moList, showBuildingMO)
			end
		end
	end

	local buildingCfgList = RoomConfig.instance:getBuildingConfigList()
	local buyInfo = {
		use = false,
		isNeedToBuy = true
	}

	for i = 1, #buildingCfgList do
		local buildingCfg = buildingCfgList[i]
		local buildingId = buildingCfg.id

		if buildingCfg.buildingType == RoomBuildingEnum.BuildingType.Transport and not buildingIdDict[buildingId] then
			buildingIdDict[buildingId] = true
			buyInfo.uid = -buildingId
			buyInfo.buildingId = buildingId

			local showBuildingMO = RoomShowBuildingMO.New()

			showBuildingMO:init(buyInfo)
			showBuildingMO:add(buyInfo.uid, 0)
			table.insert(moList, showBuildingMO)
		end
	end

	self:setList(moList)
	self:_refreshSelect()
end

function RoomTransportBuildingListModel:getSelect()
	return self._selectId
end

function RoomTransportBuildingListModel:_refreshSelect()
	local selectMO = self:getById(self._selectId)

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomTransportBuildingListModel:setSelect(id)
	self._selectId = id

	self:_refreshSelect()
end

function RoomTransportBuildingListModel:getSelectMO()
	return self:getById(self._selectId)
end

function RoomTransportBuildingListModel:_checkInfoShow(buildingId, isUse)
	local config = RoomConfig.instance:getBuildingConfig(buildingId)

	if config and config.buildingType == RoomBuildingEnum.BuildingType.Transport then
		return true
	end

	return false
end

RoomTransportBuildingListModel.instance = RoomTransportBuildingListModel.New()

return RoomTransportBuildingListModel
