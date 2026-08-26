-- chunkname: @modules/logic/room/view/RoomInventorySelectViewContainer.lua

module("modules.logic.room.view.RoomInventorySelectViewContainer", package.seeall)

local RoomInventorySelectViewContainer = class("RoomInventorySelectViewContainer", BaseViewContainer)

function RoomInventorySelectViewContainer:buildViews()
	self.selectView = RoomInventorySelectView.New()
	self._listScrollView = self:getScrollView()

	local tViews = {
		self.selectView,
		self._listScrollView
	}

	table.insert(tViews, TabViewGroup.New(1, "blockop_tab"))
	table.insert(tViews, TabViewGroup.New(2, "go_content/go_righttop/go_tabtransprotfail"))
	table.insert(tViews, RoomInventorySelectEffect.New())

	return tViews
end

function RoomInventorySelectViewContainer:getScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "go_content/scroll_block"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "go_content/#go_item"
	scrollParam.cellClass = RoomInventorySelectItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 231
	scrollParam.cellSpaceH = 0.5
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 5

	local animationDelayTimes = {}

	for i = 1, 12 do
		animationDelayTimes[i] = (i - 1) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(RoomShowBlockListModel.instance, scrollParam, animationDelayTimes)
end

function RoomInventorySelectViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local builidngView = RoomViewBuilding.New()
		local tViews = {
			builidngView,
			builidngView:getBuildingListView()
		}

		return {
			MultiView.New(tViews)
		}
	elseif tabContainerId == 2 then
		return {
			RoomTransportPathFailTips.New()
		}
	end
end

function RoomInventorySelectViewContainer:switch2BuildingView(notPlayAudio)
	if self.selectView then
		self.selectView:_btnbuildingOnClick(notPlayAudio)
	end
end

return RoomInventorySelectViewContainer
