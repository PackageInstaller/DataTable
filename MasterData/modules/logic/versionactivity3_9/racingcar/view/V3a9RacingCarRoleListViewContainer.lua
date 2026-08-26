-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarRoleListViewContainer.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarRoleListViewContainer", package.seeall)

local V3a9RacingCarRoleListViewContainer = class("V3a9RacingCarRoleListViewContainer", BaseViewContainer)

function V3a9RacingCarRoleListViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9RacingCarRoleListView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_lefttop"))

	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "root/#scroll_roleList"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam1.cellClass = V3a9RacingCarRoleListItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 468
	scrollParam1.cellHeight = 600
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 60
	self.scrollView = LuaListScrollView.New(V3a9RacingCarRoleListModel.instance, scrollParam1)

	table.insert(views, self.scrollView)

	return views
end

function V3a9RacingCarRoleListViewContainer:onContainerInit()
	V3a9RacingCarRoleListModel.instance:initList()
end

function V3a9RacingCarRoleListViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return V3a9RacingCarRoleListViewContainer
