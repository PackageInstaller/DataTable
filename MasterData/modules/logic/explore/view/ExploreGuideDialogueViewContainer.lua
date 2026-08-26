-- chunkname: @modules/logic/explore/view/ExploreGuideDialogueViewContainer.lua

module("modules.logic.explore.view.ExploreGuideDialogueViewContainer", package.seeall)

local ExploreGuideDialogueViewContainer = class("ExploreGuideDialogueViewContainer", BaseViewContainer)

function ExploreGuideDialogueViewContainer:buildViews()
	return {
		ExploreGuideDialogueView.New()
	}
end

return ExploreGuideDialogueViewContainer
