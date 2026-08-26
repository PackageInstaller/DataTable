-- chunkname: @modules/logic/versionactivity1_4/act134/view/Activity134TaskViewContainer.lua

module("modules.logic.versionactivity1_4.act134.view.Activity134TaskViewContainer", package.seeall)

local Activity134TaskViewContainer = class("Activity134TaskViewContainer", BaseViewContainer)

function Activity134TaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "main/#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Activity134TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1300
	scrollParam.cellHeight = 160
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	local times = {}

	for i = 1, 6 do
		times[i] = (i - 1) * 0.06
	end

	self._scrollview = LuaListScrollViewWithAnimator.New(Activity134TaskListModel.instance, scrollParam, times)

	table.insert(views, self._scrollview)
	table.insert(views, Activity134TaskView.New())

	return views
end

function Activity134TaskViewContainer:buildTabViews(tabContainerId)
	return
end

function Activity134TaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._scrollview)
end

function Activity134TaskViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Activity134TaskViewContainer
