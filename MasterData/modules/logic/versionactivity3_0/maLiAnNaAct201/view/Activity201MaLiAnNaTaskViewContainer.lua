-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/Activity201MaLiAnNaTaskViewContainer.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaTaskViewContainer", package.seeall)

local Activity201MaLiAnNaTaskViewContainer = class("Activity201MaLiAnNaTaskViewContainer", BaseViewContainer)

function Activity201MaLiAnNaTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Activity201MaLiAnNaTaskItem
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

	local scrollView = LuaListScrollViewWithAnimator.New(Activity201MaLiAnNaTaskListModel.instance, scrollParam, animationDelayTimes)

	scrollView.dontPlayCloseAnimation = true

	table.insert(views, scrollView)
	table.insert(views, Activity201MaLiAnNaTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function Activity201MaLiAnNaTaskViewContainer:buildTabViews(tabContainerId)
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

return Activity201MaLiAnNaTaskViewContainer
