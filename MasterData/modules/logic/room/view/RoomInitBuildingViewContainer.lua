-- chunkname: @modules/logic/room/view/RoomInitBuildingViewContainer.lua

module("modules.logic.room.view.RoomInitBuildingViewContainer", package.seeall)

local RoomInitBuildingViewContainer = class("RoomInitBuildingViewContainer", BaseViewContainer)

function RoomInitBuildingViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_navigatebuttonscontainer"))

	self._roomInitBuildingView = RoomInitBuildingView.New()

	table.insert(views, self._roomInitBuildingView)
	table.insert(views, RoomInitBuildingViewChange.New())
	table.insert(views, RoomInitBuildingSkinView.New())
	table.insert(views, RoomViewTopRight.New("#go_topright", self._viewSetting.otherRes[1], {
		{
			initAnim = "idle",
			type = 2,
			id = 5,
			supportFlyEffect = true,
			classDefine = RoomViewTopRightMaterialItem,
			listeningItems = {
				{
					id = 5,
					type = 2
				},
				{
					id = 3,
					type = 2
				}
			}
		},
		{
			initAnim = "idle",
			type = 2,
			id = 3,
			supportFlyEffect = true,
			classDefine = RoomViewTopRightMaterialItem,
			listeningItems = {
				{
					id = 5,
					type = 2
				},
				{
					id = 3,
					type = 2
				}
			}
		}
	}))
	table.insert(views, self:_createShowDegreeListView())
	table.insert(views, self:_createRoomSkinListView())

	return views
end

function RoomInitBuildingViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.RoomInitBuilding, self._closeCallback, nil, nil, self)

		return {
			self._navigateButtonView
		}
	end
end

function RoomInitBuildingViewContainer:_closeCallback()
	if ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		ViewMgr.instance:closeView(ViewName.RoomFormulaView)
	end

	RoomMapController.instance:onCloseRoomInitBuildingView()
end

function RoomInitBuildingViewContainer:setSelectLine(lineId)
	self._selectLineId = lineId
end

function RoomInitBuildingViewContainer:getSelectLine()
	return self._selectLineId
end

function RoomInitBuildingViewContainer:setSelectPartId(partId)
	self._selectPartId = partId
end

function RoomInitBuildingViewContainer:getCurrentViewParam()
	return {
		partId = self._selectPartId,
		lineId = self._selectLineId
	}
end

function RoomInitBuildingViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetCloseBtnAudioId(0)
end

function RoomInitBuildingViewContainer:_createShowDegreeListView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#go_init/#go_activeList/#scroll_activeList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "right/#go_init/#go_activeList/#scroll_activeList/viewport/content/#go_degreeItem"
	scrollParam.cellClass = RoomInitBuildingDegreeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.cellWidth = 635
	scrollParam.cellHeight = 60
	scrollParam.cellSpaceV = 4
	scrollParam.startSpace = 0

	local animationDelayTimes = {}

	for i = 1, 10 do
		animationDelayTimes[i] = (i - 1) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(RoomShowDegreeListModel.instance, scrollParam, animationDelayTimes)
end

function RoomInitBuildingViewContainer:_createRoomSkinListView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#go_skin/#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "right/#go_skin/#scroll_view/viewport/content/#go_skinitem"
	scrollParam.cellClass = RoomInitBuildingSkinItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.cellWidth = 600
	scrollParam.cellHeight = 184
	scrollParam.cellSpaceV = 20
	scrollParam.startSpace = 14

	return LuaListScrollView.New(RoomSkinListModel.instance, scrollParam)
end

function RoomInitBuildingViewContainer:setIsShowTitle(isShow)
	if not self._roomInitBuildingView then
		return
	end

	self._roomInitBuildingView:setTitleShow(isShow)
end

return RoomInitBuildingViewContainer
