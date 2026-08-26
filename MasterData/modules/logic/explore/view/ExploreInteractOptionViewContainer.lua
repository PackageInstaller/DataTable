-- chunkname: @modules/logic/explore/view/ExploreInteractOptionViewContainer.lua

module("modules.logic.explore.view.ExploreInteractOptionViewContainer", package.seeall)

local ExploreInteractOptionViewContainer = class("ExploreInteractOptionViewContainer", BaseViewContainer)

function ExploreInteractOptionViewContainer:buildViews()
	return {
		ExploreInteractOptionView.New()
	}
end

return ExploreInteractOptionViewContainer
