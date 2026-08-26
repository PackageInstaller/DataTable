-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3PickHeroEntryViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3PickHeroEntryViewContainer", package.seeall)

local Season123_2_3PickHeroEntryViewContainer = class("Season123_2_3PickHeroEntryViewContainer", BaseViewContainer)

function Season123_2_3PickHeroEntryViewContainer:buildViews()
	return {
		Season123_2_3CheckCloseView.New(),
		Season123_2_3PickHeroEntryView.New()
	}
end

function Season123_2_3PickHeroEntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_3SelectHeroHelp)
		self._navigateButtonView:hideHelpIcon()

		return {
			self._navigateButtonView
		}
	end
end

return Season123_2_3PickHeroEntryViewContainer
