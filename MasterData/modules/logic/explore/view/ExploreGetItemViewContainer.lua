-- chunkname: @modules/logic/explore/view/ExploreGetItemViewContainer.lua

module("modules.logic.explore.view.ExploreGetItemViewContainer", package.seeall)

local ExploreGetItemViewContainer = class("ExploreGetItemViewContainer", BaseViewContainer)

function ExploreGetItemViewContainer:buildViews()
	return {
		ExploreGetItemView.New()
	}
end

function ExploreGetItemViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return ExploreGetItemViewContainer
