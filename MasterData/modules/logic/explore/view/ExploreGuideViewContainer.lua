-- chunkname: @modules/logic/explore/view/ExploreGuideViewContainer.lua

module("modules.logic.explore.view.ExploreGuideViewContainer", package.seeall)

local ExploreGuideViewContainer = class("ExploreGuideViewContainer", BaseViewContainer)

function ExploreGuideViewContainer:buildViews()
	return {
		ExploreGuideView.New()
	}
end

return ExploreGuideViewContainer
