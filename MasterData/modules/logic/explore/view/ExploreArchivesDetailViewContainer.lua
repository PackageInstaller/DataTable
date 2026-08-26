-- chunkname: @modules/logic/explore/view/ExploreArchivesDetailViewContainer.lua

module("modules.logic.explore.view.ExploreArchivesDetailViewContainer", package.seeall)

local ExploreArchivesDetailViewContainer = class("ExploreArchivesDetailViewContainer", BaseViewContainer)

function ExploreArchivesDetailViewContainer:buildViews()
	return {
		ExploreArchivesDetailView.New()
	}
end

return ExploreArchivesDetailViewContainer
