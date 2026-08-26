-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiTaskViewContainer.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiTaskViewContainer", package.seeall)

local AergusiTaskViewContainer = class("AergusiTaskViewContainer", BaseViewContainer)

function AergusiTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = AergusiTaskItem.prefabPath
	scrollParam.cellClass = AergusiTaskItem
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

	table.insert(views, LuaListScrollViewWithAnimator.New(AergusiTaskListModel.instance, scrollParam, animationDelayTimes))
	table.insert(views, AergusiTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function AergusiTaskViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function AergusiTaskViewContainer:buildTabViews(tabContainerId)
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

return AergusiTaskViewContainer
