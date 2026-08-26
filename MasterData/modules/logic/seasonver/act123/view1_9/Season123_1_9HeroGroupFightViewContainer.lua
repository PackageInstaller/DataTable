-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9HeroGroupFightViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9HeroGroupFightViewContainer", package.seeall)

local Season123_1_9HeroGroupFightViewContainer = class("Season123_1_9HeroGroupFightViewContainer", BaseViewContainer)

function Season123_1_9HeroGroupFightViewContainer:buildViews()
	return {
		Season123_1_9HeroGroupFightView.New(),
		Season123_1_9HeroGroupListView.New(),
		Season123_1_9HeroGroupFightViewRule.New(),
		Season123_1_9HeroGroupMainCardView.New(),
		Season123_1_9HeroGroupReplaySelectView.New(),
		TabViewGroup.New(1, "#go_container/#go_btns/commonBtns")
	}
end

function Season123_1_9HeroGroupFightViewContainer:getSeasonHeroGroupFightView()
	return self._views[1]
end

function Season123_1_9HeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.Season1_9HerogroupHelp, self._closeCallback, nil, nil, self)

		self._navigateButtonsView:setHelpId(HelpEnum.HelpId.Season1_9HerogroupHelp)
		self._navigateButtonsView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonsView
		}
	end
end

function Season123_1_9HeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	if self:handleVersionActivityCloseCall() then
		return
	end

	MainController.instance:enterMainScene(true, false)
end

function Season123_1_9HeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return Season123_1_9HeroGroupFightViewContainer
