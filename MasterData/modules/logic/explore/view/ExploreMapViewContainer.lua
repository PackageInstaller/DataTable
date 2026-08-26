-- chunkname: @modules/logic/explore/view/ExploreMapViewContainer.lua

module("modules.logic.explore.view.ExploreMapViewContainer", package.seeall)

local ExploreMapViewContainer = class("ExploreMapViewContainer", BaseViewContainer)

function ExploreMapViewContainer:buildViews()
	return {
		ExploreMapView.New()
	}
end

return ExploreMapViewContainer
