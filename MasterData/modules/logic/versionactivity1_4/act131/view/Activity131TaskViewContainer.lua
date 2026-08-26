-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131TaskViewContainer.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131TaskViewContainer", package.seeall)

local Activity131TaskViewContainer = class("Activity131TaskViewContainer", BaseViewContainer)

function Activity131TaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = Activity131TaskItem.prefabPath
	scrollParam.cellClass = Activity131TaskItem
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

	table.insert(views, LuaListScrollViewWithAnimator.New(Activity131TaskListModel.instance, scrollParam, animationDelayTimes))
	table.insert(views, Activity131TaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function Activity131TaskViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function Activity131TaskViewContainer:buildTabViews(tabContainerId)
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

return Activity131TaskViewContainer
