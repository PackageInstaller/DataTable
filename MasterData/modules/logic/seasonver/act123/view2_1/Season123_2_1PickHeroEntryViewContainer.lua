-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1PickHeroEntryViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1PickHeroEntryViewContainer", package.seeall)

local Season123_2_1PickHeroEntryViewContainer = class("Season123_2_1PickHeroEntryViewContainer", BaseViewContainer)

function Season123_2_1PickHeroEntryViewContainer:buildViews()
	return {
		Season123_2_1CheckCloseView.New(),
		Season123_2_1PickHeroEntryView.New()
	}
end

function Season123_2_1PickHeroEntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_1SelectHeroHelp)
		self._navigateButtonView:hideHelpIcon()

		return {
			self._navigateButtonView
		}
	end
end

return Season123_2_1PickHeroEntryViewContainer
