-- chunkname: @modules/logic/explore/view/ExploreViewContainer.lua

module("modules.logic.explore.view.ExploreViewContainer", package.seeall)

local ExploreViewContainer = class("ExploreViewContainer", BaseViewContainer)

function ExploreViewContainer:buildViews()
	return {
		ExploreView.New(),
		ExploreSmallMapView.New()
	}
end

return ExploreViewContainer
