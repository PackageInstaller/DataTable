-- chunkname: @modules/logic/herogroup/view/HeroGroupRecommendViewContainer.lua

module("modules.logic.herogroup.view.HeroGroupRecommendViewContainer", package.seeall)

local HeroGroupRecommendViewContainer = class("HeroGroupRecommendViewContainer", BaseViewContainer)

function HeroGroupRecommendViewContainer:buildViews()
	local characterScrollParam = ListScrollParam.New()

	characterScrollParam.scrollGOPath = "#scroll_character"
	characterScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	characterScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	characterScrollParam.cellClass = HeroGroupRecommendCharacterItem
	characterScrollParam.scrollDir = ScrollEnum.ScrollDirV
	characterScrollParam.lineCount = 1
	characterScrollParam.cellWidth = 482
	characterScrollParam.cellHeight = 172
	characterScrollParam.cellSpaceH = 0
	characterScrollParam.cellSpaceV = 7.19
	characterScrollParam.startSpace = 0

	local groupScrollParam = ListScrollParam.New()

	groupScrollParam.scrollGOPath = "#scroll_group"
	groupScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	groupScrollParam.prefabUrl = self._viewSetting.otherRes[2]
	groupScrollParam.cellClass = HeroGroupRecommendGroupItem
	groupScrollParam.scrollDir = ScrollEnum.ScrollDirV
	groupScrollParam.lineCount = 1
	groupScrollParam.cellWidth = 1362
	groupScrollParam.cellHeight = 172
	groupScrollParam.cellSpaceH = 0
	groupScrollParam.cellSpaceV = 7.19
	groupScrollParam.startSpace = 0

	local AnimationDelayTimes = {}
	local delayTime

	for i = 1, 5 do
		AnimationDelayTimes[i] = (i - 1) * 0.06
	end

	return {
		HeroGroupRecommendView.New(),
		LuaListScrollViewWithAnimator.New(HeroGroupRecommendCharacterListModel.instance, characterScrollParam, AnimationDelayTimes),
		LuaListScrollViewWithAnimator.New(HeroGroupRecommendGroupListModel.instance, groupScrollParam, AnimationDelayTimes),
		TabViewGroup.New(1, "#go_btns")
	}
end

function HeroGroupRecommendViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return HeroGroupRecommendViewContainer
