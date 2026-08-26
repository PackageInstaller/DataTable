-- chunkname: @modules/logic/versionactivity2_8/molideer/view/MoLiDeErTaskViewContainer.lua

module("modules.logic.versionactivity2_8.molideer.view.MoLiDeErTaskViewContainer", package.seeall)

local MoLiDeErTaskViewContainer = class("MoLiDeErTaskViewContainer", BaseViewContainer)

function MoLiDeErTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = MoLiDeErTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1160
	scrollParam.cellHeight = 165
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	local animationDelayTimes = {}

	for i = 1, 6 do
		animationDelayTimes[i] = (i - 1) * 0.06
	end

	local scrollView = LuaListScrollViewWithAnimator.New(MoLiDeErTaskListModel.instance, scrollParam, animationDelayTimes)

	scrollView.dontPlayCloseAnimation = true

	table.insert(views, scrollView)
	table.insert(views, MoLiDeErTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function MoLiDeErTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return MoLiDeErTaskViewContainer
