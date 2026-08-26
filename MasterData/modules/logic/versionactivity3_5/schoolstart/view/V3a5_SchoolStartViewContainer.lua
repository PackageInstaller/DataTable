-- chunkname: @modules/logic/versionactivity3_5/schoolstart/view/V3a5_SchoolStartViewContainer.lua

module("modules.logic.versionactivity3_5.schoolstart.view.V3a5_SchoolStartViewContainer", package.seeall)

local V3a5_SchoolStartViewContainer = class("V3a5_SchoolStartViewContainer", BaseViewContainer)

function V3a5_SchoolStartViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/right/#scroll_task"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "root/right/#scroll_task/Viewport/Content/#go_taskitem"
	scrollParam.cellClass = V3a5_SchoolStartTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1000
	scrollParam.cellHeight = 156
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	local animationDelayTimes = {}

	for i = 1, 5 do
		animationDelayTimes[i] = (i - 1) * 0.12
	end

	local scrollView = LuaListScrollViewWithAnimator.New(V3a5_SchoolStartTaskListModel.instance, scrollParam, animationDelayTimes)

	scrollView.dontPlayCloseAnimation = true

	table.insert(views, V3a5_SchoolStartView.New())
	table.insert(views, scrollView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3a5_SchoolStartViewContainer:buildTabViews(tabContainerId)
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

return V3a5_SchoolStartViewContainer
