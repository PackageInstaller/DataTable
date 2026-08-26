-- chunkname: @modules/logic/room/view/critter/RoomCritterPlaceViewContainer.lua

module("modules.logic.room.view.critter.RoomCritterPlaceViewContainer", package.seeall)

local RoomCritterPlaceViewContainer = class("RoomCritterPlaceViewContainer", BaseViewContainer)

function RoomCritterPlaceViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterPlaceView.New())

	local scrollParam1 = self:getScrollParam1()
	local scrollParam2 = self:getScrollParam2()
	local critterPlaceListView1 = LuaListScrollView.New(RoomCritterPlaceListModel.instance, scrollParam1)
	local critterPlaceListView2 = LuaListScrollView.New(RoomCritterPlaceListModel.instance, scrollParam2)

	table.insert(views, critterPlaceListView1)
	table.insert(views, critterPlaceListView2)

	return views
end

function RoomCritterPlaceViewContainer:getScrollParam1()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_critterview1/critterscroll"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_critterview1/critterscroll/Viewport/#go_critterContent1/#go_critterItem"
	scrollParam.cellClass = RoomCritterPlaceItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.cellWidth = 150
	scrollParam.cellHeight = 200
	scrollParam.cellSpaceH = 30
	scrollParam.startSpace = 30

	return scrollParam
end

function RoomCritterPlaceViewContainer:getScrollParam2()
	local scrollPath = "#go_critterview2/critterscroll"
	local scrollWidth = self:_getScrollWidth(scrollPath)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = scrollPath
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_critterview2/critterscroll/Viewport/#go_critterContent2/#go_critterItem"
	scrollParam.cellClass = RoomCritterPlaceItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.cellWidth = 180
	scrollParam.cellHeight = 150
	scrollParam.lineCount = self:_getLineCount(scrollWidth, scrollParam.cellWidth)
	scrollParam.cellSpaceV = 20
	scrollParam.startSpace = 10

	return scrollParam
end

function RoomCritterPlaceViewContainer:_getScrollWidth(path)
	local scrollTrans = gohelper.findChildComponent(self.viewGO, path, gohelper.Type_Transform)

	if scrollTrans then
		return recthelper.getWidth(scrollTrans)
	end

	local scale = 1080 / UnityEngine.Screen.height

	return (math.floor(UnityEngine.Screen.width * scale + 0.5))
end

function RoomCritterPlaceViewContainer:_getLineCount(scrollWidth, cellWidth)
	local lineCount = math.floor(scrollWidth / cellWidth)

	lineCount = math.max(lineCount, 1)

	return lineCount
end

function RoomCritterPlaceViewContainer:onContainerInit()
	self:setContainerViewBuildingUid(self.viewParam and self.viewParam.buildingUid)
end

function RoomCritterPlaceViewContainer:onContainerClose()
	self:setContainerViewBuildingUid()
end

function RoomCritterPlaceViewContainer:setContainerViewBuildingUid(buildingUid)
	self._viewBuildingUid = buildingUid
end

function RoomCritterPlaceViewContainer:getContainerViewBuilding(nilError)
	local viewBuildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self._viewBuildingUid)

	if not viewBuildingMO and nilError then
		logError(string.format("RoomCritterPlaceViewContainer:getContainerViewBuilding error, buildingMO is nil, uid:%s", self._viewBuildingUid))
	end

	return self._viewBuildingUid, viewBuildingMO
end

return RoomCritterPlaceViewContainer
