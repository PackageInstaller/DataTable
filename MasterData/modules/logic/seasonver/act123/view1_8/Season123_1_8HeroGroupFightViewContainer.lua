-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8HeroGroupFightViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8HeroGroupFightViewContainer", package.seeall)

local Season123_1_8HeroGroupFightViewContainer = class("Season123_1_8HeroGroupFightViewContainer", BaseViewContainer)

function Season123_1_8HeroGroupFightViewContainer:buildViews()
	return {
		Season123_1_8HeroGroupFightView.New(),
		Season123_1_8HeroGroupListView.New(),
		Season123_1_8HeroGroupFightViewRule.New(),
		Season123_1_8HeroGroupMainCardView.New(),
		Season123_1_8HeroGroupReplaySelectView.New(),
		TabViewGroup.New(1, "#go_container/#go_btns/commonBtns")
	}
end

function Season123_1_8HeroGroupFightViewContainer:getSeasonHeroGroupFightView()
	return self._views[1]
end

function Season123_1_8HeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.Season1_8HerogroupHelp, self._closeCallback, nil, nil, self)

		self._navigateButtonsView:setHelpId(HelpEnum.HelpId.Season1_8HerogroupHelp)
		self._navigateButtonsView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonsView
		}
	end
end

function Season123_1_8HeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	if self:handleVersionActivityCloseCall() then
		return
	end

	MainController.instance:enterMainScene(true, false)
end

function Season123_1_8HeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return Season123_1_8HeroGroupFightViewContainer
