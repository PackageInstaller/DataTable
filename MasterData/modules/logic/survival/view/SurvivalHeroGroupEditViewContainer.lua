-- chunkname: @modules/logic/survival/view/SurvivalHeroGroupEditViewContainer.lua

module("modules.logic.survival.view.SurvivalHeroGroupEditViewContainer", package.seeall)

local SurvivalHeroGroupEditViewContainer = class("SurvivalHeroGroupEditViewContainer", HeroGroupEditViewContainer)

function SurvivalHeroGroupEditViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SurvivalHeroGroupEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 450
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 37

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	return {
		SurvivalHeroGroupEditView.New(),
		LuaListScrollViewWithAnimator.New(SurvivalHeroGroupEditListModel.instance, scrollParam, animationDelayTimes),
		self:getQuickEditScroll(),
		CommonRainEffectView.New("bg/#go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function SurvivalHeroGroupEditViewContainer:getQuickEditScroll()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_quickedit"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[2]
	scrollParam.cellClass = SurvivalHeroGroupQuickEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 450
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 37

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(SurvivalHeroGroupQuickEditListModel.instance, scrollParam, animationDelayTimes)
end

function SurvivalHeroGroupEditViewContainer:_overrideClose()
	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	elseif ViewMgr.instance:isOpen(ViewName.SurvivalHeroGroupEditView) then
		ViewMgr.instance:closeView(ViewName.SurvivalHeroGroupEditView, nil, true)
	end
end

function SurvivalHeroGroupEditViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

return SurvivalHeroGroupEditViewContainer
