-- chunkname: @modules/logic/autochess/main/view/AutoChessTaskViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessTaskViewContainer", package.seeall)

local AutoChessTaskViewContainer = class("AutoChessTaskViewContainer", BaseViewContainer)

function AutoChessTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = AutoChessTaskItem.prefabPath
	scrollParam.cellClass = AutoChessTaskItem
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

	table.insert(views, LuaListScrollViewWithAnimator.New(AutoChessTaskListModel.instance, scrollParam, animationDelayTimes))
	table.insert(views, AutoChessTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function AutoChessTaskViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function AutoChessTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return AutoChessTaskViewContainer
