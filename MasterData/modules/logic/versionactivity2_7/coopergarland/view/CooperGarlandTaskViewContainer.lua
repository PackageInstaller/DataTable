-- chunkname: @modules/logic/versionactivity2_7/coopergarland/view/CooperGarlandTaskViewContainer.lua

module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandTaskViewContainer", package.seeall)

local CooperGarlandTaskViewContainer = class("CooperGarlandTaskViewContainer", BaseViewContainer)

function CooperGarlandTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = CooperGarlandTaskItem
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

	table.insert(views, LuaListScrollViewWithAnimator.New(CooperGarlandTaskListModel.instance, scrollParam, animationDelayTimes))
	table.insert(views, CooperGarlandTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function CooperGarlandTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return CooperGarlandTaskViewContainer
