-- chunkname: @modules/logic/explore/view/ExploreBlackViewContainer.lua

module("modules.logic.explore.view.ExploreBlackViewContainer", package.seeall)

local ExploreBlackViewContainer = class("ExploreBlackViewContainer", BaseViewContainer)

function ExploreBlackViewContainer:buildViews()
	return {
		ExploreBlackView.New()
	}
end

return ExploreBlackViewContainer
