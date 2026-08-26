-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryTaskViewContainer.lua

module("modules.logic.necrologiststory.view.NecrologistStoryTaskViewContainer", package.seeall)

local NecrologistStoryTaskViewContainer = class("NecrologistStoryTaskViewContainer", BaseViewContainer)

function NecrologistStoryTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, NecrologistStoryTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_tasklist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam.cellClass = NecrologistStoryTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1150
	scrollParam.cellHeight = 140
	scrollParam.cellSpaceH = 30
	scrollParam.cellSpaceV = 19

	local times = {}

	for i = 1, 7 do
		times[i] = (i - 1) * 0.06
	end

	self.notPlayAnimation = true
	self._taskScrollView = LuaListScrollViewWithAnimator.New(NecrologistStoryTaskListModel.instance, scrollParam, times)

	table.insert(views, self._taskScrollView)

	return views
end

function NecrologistStoryTaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return NecrologistStoryTaskViewContainer
