-- chunkname: @modules/logic/tower/view/permanenttower/TowerDeepTaskViewContainer.lua

module("modules.logic.tower.view.permanenttower.TowerDeepTaskViewContainer", package.seeall)

local TowerDeepTaskViewContainer = class("TowerDeepTaskViewContainer", BaseViewContainer)

function TowerDeepTaskViewContainer:buildViews()
	local views = {}

	self:buildScrollViews()
	table.insert(views, self.scrollView)
	table.insert(views, TowerDeepTaskView.New())

	return views
end

function TowerDeepTaskViewContainer:buildScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_task"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = TowerDeepTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1440
	scrollParam.cellHeight = 152
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 10
	scrollParam.frameUpdateMs = 100

	local animationDelayTimes = {}

	for i = 1, 6 do
		animationDelayTimes[i] = (i - 1) * 0.06
	end

	self.scrollView = LuaListScrollViewWithAnimator.New(TowerDeepTaskModel.instance, scrollParam, animationDelayTimes)
end

return TowerDeepTaskViewContainer
