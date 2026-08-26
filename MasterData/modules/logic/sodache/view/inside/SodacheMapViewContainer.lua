-- chunkname: @modules/logic/sodache/view/inside/SodacheMapViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheMapViewContainer", package.seeall)

local SodacheMapViewContainer = class("SodacheMapViewContainer", BaseViewContainer)

function SodacheMapViewContainer:buildViews()
	return {
		SodacheMapView.New(),
		SodacheMapSceneView.New(),
		SodacheMapUnitView.New(),
		SodacheMapTopView.New(),
		SodacheMapUseCardView.New(),
		SodacheInsideTaskView.New(),
		SodacheGMView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function SodacheMapViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigationView:setOverrideClose(self.defaultOverrideCloseClick, self)

		return {
			self.navigationView
		}
	end
end

function SodacheMapViewContainer:defaultOverrideCloseClick()
	SodacheStatHelper.instance:clientEndStat()
	self:closeThis()
end

function SodacheMapViewContainer:playOpenTransition()
	self:onPlayOpenTransitionFinish()
end

return SodacheMapViewContainer
