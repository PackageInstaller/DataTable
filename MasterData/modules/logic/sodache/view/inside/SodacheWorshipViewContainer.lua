-- chunkname: @modules/logic/sodache/view/inside/SodacheWorshipViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheWorshipViewContainer", package.seeall)

local SodacheWorshipViewContainer = class("SodacheWorshipViewContainer", BaseViewContainer)

function SodacheWorshipViewContainer:buildViews()
	return {
		SodacheWorshipView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function SodacheWorshipViewContainer:buildTabViews(tabContainerId)
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

return SodacheWorshipViewContainer
