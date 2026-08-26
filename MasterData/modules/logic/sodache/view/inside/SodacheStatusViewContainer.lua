-- chunkname: @modules/logic/sodache/view/inside/SodacheStatusViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheStatusViewContainer", package.seeall)

local SodacheStatusViewContainer = class("SodacheStatusViewContainer", BaseViewContainer)

function SodacheStatusViewContainer:buildViews()
	return {
		SodacheStatusView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function SodacheStatusViewContainer:buildTabViews(tabContainerId)
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

return SodacheStatusViewContainer
