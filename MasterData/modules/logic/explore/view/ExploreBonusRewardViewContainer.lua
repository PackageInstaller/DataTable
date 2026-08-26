-- chunkname: @modules/logic/explore/view/ExploreBonusRewardViewContainer.lua

module("modules.logic.explore.view.ExploreBonusRewardViewContainer", package.seeall)

local ExploreBonusRewardViewContainer = class("ExploreBonusRewardViewContainer", BaseViewContainer)

function ExploreBonusRewardViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "mask/#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "mask/#scroll_view/Viewport/Content/rewarditem"
	scrollParam.cellClass = ExploreBonusRewardItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1470
	scrollParam.cellHeight = 140
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.frameUpdateMs = 100

	return {
		ExploreBonusRewardView.New(),
		LuaListScrollView.New(ExploreTaskModel.instance:getTaskList(0), scrollParam)
	}
end

return ExploreBonusRewardViewContainer
