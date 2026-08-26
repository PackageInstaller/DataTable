-- chunkname: @modules/logic/explore/view/ExploreFinishViewContainer.lua

module("modules.logic.explore.view.ExploreFinishViewContainer", package.seeall)

local ExploreFinishViewContainer = class("ExploreFinishViewContainer", BaseViewContainer)

function ExploreFinishViewContainer:buildViews()
	return {
		ExploreFinishView.New()
	}
end

return ExploreFinishViewContainer
