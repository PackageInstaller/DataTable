-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyTaskViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyTaskViewContainer", package.seeall)

local OdysseyTaskViewContainer = class("OdysseyTaskViewContainer", BaseViewContainer)

function OdysseyTaskViewContainer:buildViews()
	local views = {}

	self:buildScrollViews()
	table.insert(views, self.scrollView)
	table.insert(views, OdysseyTaskView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function OdysseyTaskViewContainer:buildScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/Task/#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = OdysseyTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1160
	scrollParam.cellHeight = 158
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.frameUpdateMs = 100

	local animationDelayTimes = {}

	for i = 1, 6 do
		animationDelayTimes[i] = (i - 1) * 0.06
	end

	self.scrollView = LuaListScrollViewWithAnimator.New(OdysseyTaskModel.instance, scrollParam, animationDelayTimes)
end

function OdysseyTaskViewContainer:buildTabViews(tabContainerId)
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

return OdysseyTaskViewContainer
