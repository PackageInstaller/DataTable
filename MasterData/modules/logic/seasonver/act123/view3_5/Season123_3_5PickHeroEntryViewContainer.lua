-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5PickHeroEntryViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5PickHeroEntryViewContainer", package.seeall)

local Season123_3_5PickHeroEntryViewContainer = class("Season123_3_5PickHeroEntryViewContainer", BaseViewContainer)

function Season123_3_5PickHeroEntryViewContainer:buildViews()
	return {
		Season123_3_5CheckCloseView.New(),
		Season123_3_5PickHeroEntryView.New()
	}
end

function Season123_3_5PickHeroEntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season3_5SelectHeroHelp)
		self._navigateButtonView:hideHelpIcon()

		return {
			self._navigateButtonView
		}
	end
end

return Season123_3_5PickHeroEntryViewContainer
