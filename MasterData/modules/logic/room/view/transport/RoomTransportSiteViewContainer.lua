-- chunkname: @modules/logic/room/view/transport/RoomTransportSiteViewContainer.lua

module("modules.logic.room.view.transport.RoomTransportSiteViewContainer", package.seeall)

local RoomTransportSiteViewContainer = class("RoomTransportSiteViewContainer", BaseViewContainer)

function RoomTransportSiteViewContainer:buildViews()
	local buildingScrollParam = ListScrollParam.New()

	buildingScrollParam.scrollGOPath = "go_content/#go_right/#go_buildinglist/#scroll_building"
	buildingScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	buildingScrollParam.prefabUrl = RoomTransportBuildingItem.prefabPath
	buildingScrollParam.cellClass = RoomTransportBuildingItem
	buildingScrollParam.scrollDir = ScrollEnum.ScrollDirV
	buildingScrollParam.lineCount = 1
	buildingScrollParam.cellWidth = 540
	buildingScrollParam.cellHeight = 180
	buildingScrollParam.cellSpaceV = 10

	local skinScrollParam = ListScrollParam.New()

	skinScrollParam.scrollGOPath = "go_content/#go_right/#go_buildinglist/#scroll_buildingskin"
	skinScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	skinScrollParam.prefabUrl = RoomTransportBuildingSkinItem.prefabPath
	skinScrollParam.cellClass = RoomTransportBuildingSkinItem
	skinScrollParam.scrollDir = ScrollEnum.ScrollDirV
	skinScrollParam.lineCount = 1
	skinScrollParam.cellWidth = 196
	skinScrollParam.cellHeight = 140
	skinScrollParam.cellSpaceV = 10

	local critterScrollParam = ListScrollParam.New()

	critterScrollParam.scrollGOPath = "go_content/#go_right/#go_critterlist/#scroll_critter"
	critterScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	critterScrollParam.prefabUrl = RoomTransportCritterItem.prefabPath
	critterScrollParam.cellClass = RoomTransportCritterItem
	critterScrollParam.scrollDir = ScrollEnum.ScrollDirV
	critterScrollParam.lineCount = 1
	critterScrollParam.cellWidth = 640
	critterScrollParam.cellHeight = 175
	critterScrollParam.cellSpaceV = 10

	local views = {}

	table.insert(views, TabViewGroup.New(1, "go_content/#go_BackBtns"))
	table.insert(views, RoomTransportSiteView.New())
	table.insert(views, LuaListScrollView.New(RoomTransportBuildingListModel.instance, buildingScrollParam))
	table.insert(views, LuaListScrollView.New(RoomTransportBuildingSkinListModel.instance, skinScrollParam))

	return views
end

function RoomTransportSiteViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.RoomTransportHelp)

		self.navigateView:setOverrideClose(self._overrideCloseFunc, self)
		NavigateMgr.instance:addEscape(self.viewName, self._overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function RoomTransportSiteViewContainer:_overrideCloseFunc()
	if ViewMgr.instance:isOpen(ViewName.RoomCritterListView) then
		ViewMgr.instance:closeView(ViewName.RoomCritterListView)

		return
	end

	self:closeThis()
end

function RoomTransportSiteViewContainer:setUseBuildingUid(buildingUid)
	self.useBuildingUid = buildingUid
end

function RoomTransportSiteViewContainer:getUseBuildingUid()
	return self.useBuildingUid
end

return RoomTransportSiteViewContainer
