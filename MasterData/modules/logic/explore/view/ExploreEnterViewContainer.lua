-- chunkname: @modules/logic/explore/view/ExploreEnterViewContainer.lua

module("modules.logic.explore.view.ExploreEnterViewContainer", package.seeall)

local ExploreEnterViewContainer = class("ExploreEnterViewContainer", BaseViewContainer)

function ExploreEnterViewContainer:buildViews()
	return {
		ExploreEnterView.New()
	}
end

return ExploreEnterViewContainer
