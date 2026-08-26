-- chunkname: @modules/logic/explore/view/ExploreInteractViewContainer.lua

module("modules.logic.explore.view.ExploreInteractViewContainer", package.seeall)

local ExploreInteractViewContainer = class("ExploreInteractViewContainer", BaseViewContainer)

function ExploreInteractViewContainer:buildViews()
	return {
		ExploreInteractView.New()
	}
end

return ExploreInteractViewContainer
