-- chunkname: @modules/logic/sodache/view/inside/SodacheCardQuickSelectViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheCardQuickSelectViewContainer", package.seeall)

local SodacheCardQuickSelectViewContainer = class("SodacheCardQuickSelectViewContainer", BaseViewContainer)

function SodacheCardQuickSelectViewContainer:buildViews()
	return {
		SodacheCardQuickSelectView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function SodacheCardQuickSelectViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigationView
		}
	end
end

return SodacheCardQuickSelectViewContainer
