-- chunkname: @modules/logic/versionactivity3_4/lusijian/view/LuSiJianTaskViewContainer.lua

module("modules.logic.versionactivity3_4.lusijian.view.LuSiJianTaskViewContainer", package.seeall)

local LuSiJianTaskViewContainer = class("LuSiJianTaskViewContainer", BaseViewContainer)

function LuSiJianTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = LuSiJianTaskItem
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

	local scrollView = LuaListScrollViewWithAnimator.New(LuSiJianTaskListModel.instance, scrollParam, animationDelayTimes)

	scrollView.dontPlayCloseAnimation = true

	table.insert(views, scrollView)
	table.insert(views, LuSiJianTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function LuSiJianTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

return LuSiJianTaskViewContainer
