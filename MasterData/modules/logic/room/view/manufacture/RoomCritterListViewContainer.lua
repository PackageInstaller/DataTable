-- chunkname: @modules/logic/room/view/manufacture/RoomCritterListViewContainer.lua

module("modules.logic.room.view.manufacture.RoomCritterListViewContainer", package.seeall)

local RoomCritterListViewContainer = class("RoomCritterListViewContainer", BaseViewContainer)

function RoomCritterListViewContainer:buildViews()
	local views = {}
	local critterScrollParam = ListScrollParam.New()

	critterScrollParam.scrollGOPath = "#go_critter/#scroll_critter"
	critterScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	critterScrollParam.prefabUrl = "#go_critter/#scroll_critter/viewport/content/#go_critterItem"
	critterScrollParam.cellClass = RoomManufactureCritterItem
	critterScrollParam.scrollDir = ScrollEnum.ScrollDirV
	critterScrollParam.lineCount = 1
	critterScrollParam.cellWidth = 648
	critterScrollParam.cellHeight = 175
	critterScrollParam.cellSpaceV = 10

	table.insert(views, LuaListScrollView.New(ManufactureCritterListModel.instance, critterScrollParam))
	table.insert(views, RoomCritterListView.New())

	return views
end

function RoomCritterListViewContainer:onContainerInit()
	local pathId, buildingUid

	if self.viewParam then
		buildingUid = self.viewParam.buildingUid
		pathId = self.viewParam.pathId
	end

	if not buildingUid and not pathId then
		logError("RoomCritterListViewContainer:onContainerInit,error, no buildingUid and no pathId")
	end

	self:setContainerViewBelongId(buildingUid, pathId)
end

function RoomCritterListViewContainer:onContainerClose()
	self:setContainerViewBelongId()
end

function RoomCritterListViewContainer:setContainerViewBelongId(buildingUid, pathId)
	self._isTransport = false

	if not buildingUid and pathId then
		self._isTransport = true
	end

	self._viewBelongId = buildingUid or pathId
end

function RoomCritterListViewContainer:getContainerPathId()
	if self._isTransport then
		return self._viewBelongId
	end
end

function RoomCritterListViewContainer:getContainerViewBuilding(nilError)
	local buildingUid, buildingMO, buildingId

	if self._isTransport then
		local pathMO = RoomMapTransportPathModel.instance:getTransportPathMO(self._viewBelongId)

		buildingUid = pathMO and pathMO.buildingUid
		buildingId = pathMO and pathMO.buildingId
	else
		buildingUid = self._viewBelongId
		buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self._viewBelongId)
		buildingId = buildingMO and buildingMO.buildingId
	end

	if not buildingMO and nilError then
		logError(string.format("RoomCritterListViewContainer:getContainerViewBuilding error, buildingMO is nil, id:%s  isTransport:%s", self._viewBelongId, self._isTransport))
	end

	return buildingUid, buildingMO, buildingId
end

return RoomCritterListViewContainer
