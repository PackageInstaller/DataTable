-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonTaskViewContainer.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonTaskViewContainer", package.seeall)

local AtomicDungeonTaskViewContainer = class("AtomicDungeonTaskViewContainer", BaseViewContainer)

function AtomicDungeonTaskViewContainer:buildViews()
	local views = {}

	self:buildScrollViews()
	table.insert(views, self.scrollView)
	table.insert(views, AtomicDungeonTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function AtomicDungeonTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, nil, self._homeCallback, nil, self)

		return {
			self.navigateView
		}
	end
end

function AtomicDungeonTaskViewContainer:buildScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = AtomicDungeonTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1136
	scrollParam.cellHeight = 165
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.frameUpdateMs = 100

	local animationDelayTimes = {}

	for i = 1, 6 do
		animationDelayTimes[i] = (i - 1) * 0.06
	end

	self.scrollView = LuaListScrollViewWithAnimator.New(AtomicDungeonTaskModel.instance, scrollParam, animationDelayTimes)
end

function AtomicDungeonTaskViewContainer:_homeCallback()
	local isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()

	if not isInMapSelectState then
		AtomicDungeonStatHelper.instance:sendDungeonResultInfo("主动返回")
	end
end

return AtomicDungeonTaskViewContainer
