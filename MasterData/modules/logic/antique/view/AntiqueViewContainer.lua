-- chunkname: @modules/logic/antique/view/AntiqueViewContainer.lua

module("modules.logic.antique.view.AntiqueViewContainer", package.seeall)

local AntiqueViewContainer = class("AntiqueViewContainer", BaseViewContainer)

function AntiqueViewContainer:buildViews()
	return {
		AntiqueView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function AntiqueViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigationView
		}
	end
end

return AntiqueViewContainer
