-- chunkname: @modules/logic/versionactivity3_3/arcade/view/reward/ArcadeRewardViewContainer.lua

module("modules.logic.versionactivity3_3.arcade.view.reward.ArcadeRewardViewContainer", package.seeall)

local ArcadeRewardViewContainer = class("ArcadeRewardViewContainer", BaseViewContainer)

function ArcadeRewardViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Left/progress/#scroll_view"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam1.cellClass = ArcadeRewardItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 268
	scrollParam1.cellHeight = 700
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 2
	self.scrollView = LuaListScrollViewWithAnimator.New(ArcadeRewardListModel.instance, scrollParam1)

	table.insert(views, self.scrollView)
	table.insert(views, ArcadeRewardView.New())

	return views
end

function ArcadeRewardViewContainer:getScrollView()
	return self.scrollView
end

return ArcadeRewardViewContainer
