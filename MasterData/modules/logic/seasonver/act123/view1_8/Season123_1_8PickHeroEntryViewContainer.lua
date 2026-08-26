-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8PickHeroEntryViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8PickHeroEntryViewContainer", package.seeall)

local Season123_1_8PickHeroEntryViewContainer = class("Season123_1_8PickHeroEntryViewContainer", BaseViewContainer)

function Season123_1_8PickHeroEntryViewContainer:buildViews()
	return {
		Season123_1_8CheckCloseView.New(),
		Season123_1_8PickHeroEntryView.New()
	}
end

function Season123_1_8PickHeroEntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_8SelectHeroHelp)
		self._navigateButtonView:hideHelpIcon()

		return {
			self._navigateButtonView
		}
	end
end

return Season123_1_8PickHeroEntryViewContainer
