-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/reward/V3a9RacingRewardViewContainer.lua

module("modules.logic.versionactivity3_9.racingcar.view.reward.V3a9RacingRewardViewContainer", package.seeall)

local V3a9RacingRewardViewContainer = class("V3a9RacingRewardViewContainer", BaseViewContainer)

function V3a9RacingRewardViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Left/progress/#scroll_view"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam1.cellClass = V3a9RacingRewardItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 268
	scrollParam1.cellHeight = 700
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 2
	self.scrollView = LuaListScrollViewWithAnimator.New(V3a9RacingRewardListModel.instance, scrollParam1)

	table.insert(views, self.scrollView)
	table.insert(views, V3a9RacingRewardView.New())

	return views
end

function V3a9RacingRewardViewContainer:getScrollView()
	return self.scrollView
end

return V3a9RacingRewardViewContainer
