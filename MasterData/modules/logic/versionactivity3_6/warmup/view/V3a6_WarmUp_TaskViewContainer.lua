-- chunkname: @modules/logic/versionactivity3_6/warmup/view/V3a6_WarmUp_TaskViewContainer.lua

module("modules.logic.versionactivity3_6.warmup.view.V3a6_WarmUp_TaskViewContainer", package.seeall)

local V3a6_WarmUp_TaskViewContainer = class("V3a6_WarmUp_TaskViewContainer", Activity125ViewBaseContainer)

function V3a6_WarmUp_TaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_reward"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = V3a6_WarmUp_TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1500
	scrollParam.cellHeight = 160
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 3
	scrollParam.startSpace = 13

	local times = {}

	for i = 1, 5 do
		times[i] = (i - 1) * 0.06 + 0.3
	end

	self.notPlayAnimation = true
	self._taskScrollView = LuaListScrollViewWithAnimator.New(V3a6_WarmUp_TaskListModel.instance, scrollParam, times)

	return {
		self._taskScrollView,
		V3a6_WarmUp_TaskView.New()
	}
end

function V3a6_WarmUp_TaskViewContainer:actId()
	return V3a6_WarmUpConfig.instance:actId()
end

return V3a6_WarmUp_TaskViewContainer
