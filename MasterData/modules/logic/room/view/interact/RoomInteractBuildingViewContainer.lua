-- chunkname: @modules/logic/room/view/interact/RoomInteractBuildingViewContainer.lua

module("modules.logic.room.view.interact.RoomInteractBuildingViewContainer", package.seeall)

local RoomInteractBuildingViewContainer = class("RoomInteractBuildingViewContainer", BaseViewContainer)

function RoomInteractBuildingViewContainer:buildViews()
	local views = {}

	self._interactView = RoomInteractBuildingView.New()

	table.insert(views, self._interactView)
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_right/#go_hero/#scroll_hero"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = RoomInteractCharacterItem.prefabUrl
	scrollParam.cellClass = RoomInteractCharacterItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.cellWidth = 200
	scrollParam.lineCount = 3
	scrollParam.cellHeight = 205
	scrollParam.cellSpaceH = 5
	scrollParam.cellSpaceV = 4.6
	scrollParam.startSpace = 10
	scrollParam.emptyScrollParam = EmptyScrollParam.New()

	scrollParam.emptyScrollParam:setFromView("#go_right/#go_hero/#go_empty")
	table.insert(views, LuaListScrollView.New(RoomInteractCharacterListModel.instance, scrollParam))

	return views
end

function RoomInteractBuildingViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setCloseCheck(self._navigateCloseView, self)

		return {
			self.navigateView
		}
	end
end

function RoomInteractBuildingViewContainer:_navigateCloseView()
	if self._interactView then
		self._interactView:goBackClose()
	else
		self:closeThis()
	end
end

return RoomInteractBuildingViewContainer
