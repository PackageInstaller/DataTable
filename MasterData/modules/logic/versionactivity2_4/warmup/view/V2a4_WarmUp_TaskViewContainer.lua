-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUp_TaskViewContainer.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_TaskViewContainer", package.seeall)

local V2a4_WarmUp_TaskViewContainer = class("V2a4_WarmUp_TaskViewContainer", Activity125TaskViewBaseContainer)

function V2a4_WarmUp_TaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = V2a4_WarmUp_TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1136
	scrollParam.cellHeight = 152
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 12

	local times = {}

	for i = 1, 5 do
		times[i] = (i - 1) * 0.06
	end

	self.notPlayAnimation = true
	self._taskScrollView = LuaListScrollViewWithAnimator.New(V2a4_WarmUp_TaskListModel.instance, scrollParam, times)

	return {
		self._taskScrollView,
		V2a4_WarmUp_TaskView.New()
	}
end

function V2a4_WarmUp_TaskViewContainer:actId()
	return V2a4_WarmUpConfig.instance:actId()
end

return V2a4_WarmUp_TaskViewContainer
