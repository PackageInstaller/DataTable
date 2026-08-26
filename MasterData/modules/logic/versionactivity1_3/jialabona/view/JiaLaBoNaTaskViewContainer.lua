-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaTaskViewContainer.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaTaskViewContainer", package.seeall)

local JiaLaBoNaTaskViewContainer = class("JiaLaBoNaTaskViewContainer", BaseViewContainer)

function JiaLaBoNaTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = JiaLaBoNaTaskItem.prefabPath
	scrollParam.cellClass = JiaLaBoNaTaskItem
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

	table.insert(views, LuaListScrollViewWithAnimator.New(Activity120TaskListModel.instance, scrollParam, animationDelayTimes))
	table.insert(views, JiaLaBoNaTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function JiaLaBoNaTaskViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function JiaLaBoNaTaskViewContainer:buildTabViews(tabContainerId)
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

return JiaLaBoNaTaskViewContainer
