-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9PickHeroEntryViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9PickHeroEntryViewContainer", package.seeall)

local Season123_1_9PickHeroEntryViewContainer = class("Season123_1_9PickHeroEntryViewContainer", BaseViewContainer)

function Season123_1_9PickHeroEntryViewContainer:buildViews()
	return {
		Season123_1_9CheckCloseView.New(),
		Season123_1_9PickHeroEntryView.New()
	}
end

function Season123_1_9PickHeroEntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_9SelectHeroHelp)
		self._navigateButtonView:hideHelpIcon()

		return {
			self._navigateButtonView
		}
	end
end

return Season123_1_9PickHeroEntryViewContainer
