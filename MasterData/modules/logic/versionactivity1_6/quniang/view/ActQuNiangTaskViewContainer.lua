-- chunkname: @modules/logic/versionactivity1_6/quniang/view/ActQuNiangTaskViewContainer.lua

module("modules.logic.versionactivity1_6.quniang.view.ActQuNiangTaskViewContainer", package.seeall)

local ActQuNiangTaskViewContainer = class("ActQuNiangTaskViewContainer", BaseViewContainer)

function ActQuNiangTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = ActQuNiangTaskItem.prefabPath
	scrollParam.cellClass = ActQuNiangTaskItem
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

	table.insert(views, LuaListScrollViewWithAnimator.New(ActQuNiangTaskListModel.instance, scrollParam, animationDelayTimes))
	table.insert(views, ActQuNiangTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function ActQuNiangTaskViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function ActQuNiangTaskViewContainer:buildTabViews(tabContainerId)
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

return ActQuNiangTaskViewContainer
