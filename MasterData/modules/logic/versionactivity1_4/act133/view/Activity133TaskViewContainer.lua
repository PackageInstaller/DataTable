-- chunkname: @modules/logic/versionactivity1_4/act133/view/Activity133TaskViewContainer.lua

module("modules.logic.versionactivity1_4.act133.view.Activity133TaskViewContainer", package.seeall)

local Activity133TaskViewContainer = class("Activity133TaskViewContainer", BaseViewContainer)

function Activity133TaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "main/#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Activity133TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1300
	scrollParam.cellHeight = 160
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 0

	local animationDelayTimes = {}

	for i = 1, 5 do
		animationDelayTimes[i] = (i - 1) * 0.06
	end

	self._scrollview = LuaListScrollViewWithAnimator.New(Activity133TaskListModel.instance, scrollParam, animationDelayTimes)

	table.insert(views, self._scrollview)
	table.insert(views, Activity133TaskView.New())

	return views
end

function Activity133TaskViewContainer:buildTabViews(tabContainerId)
	return
end

function Activity133TaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._scrollview)
end

function Activity133TaskViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Activity133TaskViewContainer
