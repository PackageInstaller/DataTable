-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiTaskViewContainer.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiTaskViewContainer", package.seeall)

local WuErLiXiTaskViewContainer = class("WuErLiXiTaskViewContainer", BaseViewContainer)

function WuErLiXiTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = WuErLiXiTaskItem.prefabPath
	scrollParam.cellClass = WuErLiXiTaskItem
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

	table.insert(views, LuaListScrollViewWithAnimator.New(WuErLiXiTaskListModel.instance, scrollParam, animationDelayTimes))
	table.insert(views, WuErLiXiTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function WuErLiXiTaskViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function WuErLiXiTaskViewContainer:buildTabViews(tabContainerId)
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

return WuErLiXiTaskViewContainer
