-- chunkname: @modules/logic/season/view3_0/Season3_0TaskViewContainer.lua

module("modules.logic.season.view3_0.Season3_0TaskViewContainer", package.seeall)

local Season3_0TaskViewContainer = class("Season3_0TaskViewContainer", BaseViewContainer)

function Season3_0TaskViewContainer:buildViews()
	local views = {}

	table.insert(views, Season3_0TaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_tasklist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season3_0TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1112
	scrollParam.cellHeight = 140
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 19

	local times = {}

	for i = 1, 7 do
		times[i] = (i - 1) * 0.06
	end

	self.notPlayAnimation = true
	self._taskScrollView = LuaListScrollViewWithAnimator.New(Activity104TaskListModel.instance, scrollParam, times)

	table.insert(views, self._taskScrollView)

	return views
end

function Season3_0TaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return Season3_0TaskViewContainer
