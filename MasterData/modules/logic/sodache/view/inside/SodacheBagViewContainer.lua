-- chunkname: @modules/logic/sodache/view/inside/SodacheBagViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheBagViewContainer", package.seeall)

local SodacheBagViewContainer = class("SodacheBagViewContainer", BaseViewContainer)

function SodacheBagViewContainer:buildViews()
	return {
		SodacheBagView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function SodacheBagViewContainer:buildTabViews(tabContainerId)
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

return SodacheBagViewContainer
