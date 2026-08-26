-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6TaskViewContainer.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6TaskViewContainer", package.seeall)

local LengZhou6TaskViewContainer = class("LengZhou6TaskViewContainer", BaseViewContainer)

function LengZhou6TaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = LengZhou6TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1160
	scrollParam.cellHeight = 165
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	local animationDelayTimes = {}

	for i = 1, 10 do
		animationDelayTimes[i] = (i - 1) * 0.06
	end

	local scrollView = LuaListScrollViewWithAnimator.New(LengZhou6TaskListModel.instance, scrollParam, animationDelayTimes)

	table.insert(views, scrollView)
	table.insert(views, LengZhou6TaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function LengZhou6TaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigationView:setOverrideClose(self._overrideClose, self)

		return {
			self.navigationView
		}
	end
end

return LengZhou6TaskViewContainer
