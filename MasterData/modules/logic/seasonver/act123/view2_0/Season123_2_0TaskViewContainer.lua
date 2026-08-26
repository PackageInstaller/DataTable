-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0TaskViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0TaskViewContainer", package.seeall)

local Season123_2_0TaskViewContainer = class("Season123_2_0TaskViewContainer", BaseViewContainer)

function Season123_2_0TaskViewContainer:buildViews()
	local views = {}

	self:buildScrollViews()
	table.insert(views, self.scrollView)
	table.insert(views, Season123_2_0TaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Season123_2_0TaskViewContainer:buildTabViews(tabContainerId)
	local navigateButtonsView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		navigateButtonsView
	}
end

function Season123_2_0TaskViewContainer:buildScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_tasklist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_2_0TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1112
	scrollParam.cellHeight = 140
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 18.9
	scrollParam.startSpace = 0
	scrollParam.frameUpdateMs = 100
	self.scrollView = LuaListScrollView.New(Season123TaskModel.instance, scrollParam)
end

return Season123_2_0TaskViewContainer
