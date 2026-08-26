-- chunkname: @modules/logic/explore/view/ExploreBackpackViewContainer.lua

module("modules.logic.explore.view.ExploreBackpackViewContainer", package.seeall)

local ExploreBackpackViewContainer = class("ExploreBackpackViewContainer", BaseViewContainer)

function ExploreBackpackViewContainer:buildViews()
	return {
		ExploreBackpackView.New()
	}
end

function ExploreBackpackViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return ExploreBackpackViewContainer
