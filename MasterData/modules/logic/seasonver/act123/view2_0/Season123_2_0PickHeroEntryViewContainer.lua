-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0PickHeroEntryViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0PickHeroEntryViewContainer", package.seeall)

local Season123_2_0PickHeroEntryViewContainer = class("Season123_2_0PickHeroEntryViewContainer", BaseViewContainer)

function Season123_2_0PickHeroEntryViewContainer:buildViews()
	return {
		Season123_2_0CheckCloseView.New(),
		Season123_2_0PickHeroEntryView.New()
	}
end

function Season123_2_0PickHeroEntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_0SelectHeroHelp)
		self._navigateButtonView:hideHelpIcon()

		return {
			self._navigateButtonView
		}
	end
end

return Season123_2_0PickHeroEntryViewContainer
