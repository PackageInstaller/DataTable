-- chunkname: @modules/logic/seasonver/act123/view/Season123PickHeroEntryViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123PickHeroEntryViewContainer", package.seeall)

local Season123PickHeroEntryViewContainer = class("Season123PickHeroEntryViewContainer", BaseViewContainer)

function Season123PickHeroEntryViewContainer:buildViews()
	return {
		Season123CheckCloseView.New(),
		Season123PickHeroEntryView.New()
	}
end

function Season123PickHeroEntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			true
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_7SelectHeroHelp)

		return {
			self._navigateButtonView
		}
	end
end

return Season123PickHeroEntryViewContainer
