-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5ProgressViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5ProgressViewContainer", package.seeall)

local Season123_3_5ProgressViewContainer = class("Season123_3_5ProgressViewContainer", BaseViewContainer)

function Season123_3_5ProgressViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "root/progress/#scroll_view"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam1.cellClass = Season123_3_5ProgressItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 268
	scrollParam1.cellHeight = 600
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 2
	self.scrollView = LuaListScrollViewWithAnimator.New(Season123StageRewardListModel.instance, scrollParam1)

	table.insert(views, self.scrollView)
	table.insert(views, Season123_3_5ProgressView.New())

	return views
end

function Season123_3_5ProgressViewContainer:getScrollView()
	return self.scrollView
end

return Season123_3_5ProgressViewContainer
