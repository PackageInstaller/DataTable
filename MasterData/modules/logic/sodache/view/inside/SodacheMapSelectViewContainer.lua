-- chunkname: @modules/logic/sodache/view/inside/SodacheMapSelectViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheMapSelectViewContainer", package.seeall)

local SodacheMapSelectViewContainer = class("SodacheMapSelectViewContainer", BaseViewContainer)

function SodacheMapSelectViewContainer:buildViews()
	return {
		SodacheMapSelectView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function SodacheMapSelectViewContainer:buildTabViews(tabContainerId)
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

return SodacheMapSelectViewContainer
