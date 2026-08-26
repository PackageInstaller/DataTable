-- chunkname: @modules/logic/versionactivity1_3/chess/view/Activity1_3ChessTaskViewContainer.lua

module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessTaskViewContainer", package.seeall)

local Activity1_3ChessTaskViewContainer = class("Activity1_3ChessTaskViewContainer", BaseViewContainer)

function Activity1_3ChessTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = Activity1_3ChessTaskItem.prefabPath
	scrollParam.cellClass = Activity1_3ChessTaskItem
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

	table.insert(views, LuaListScrollViewWithAnimator.New(Activity122TaskListModel.instance, scrollParam, animationDelayTimes))
	table.insert(views, Activity1_3ChessTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function Activity1_3ChessTaskViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function Activity1_3ChessTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return Activity1_3ChessTaskViewContainer
