-- chunkname: @modules/logic/guide/view/GuideViewContainer.lua

module("modules.logic.guide.view.GuideViewContainer", package.seeall)

local GuideViewContainer = class("GuideViewContainer", BaseViewContainer)

function GuideViewContainer:buildViews()
	return {
		GuideView.New(),
		GuideMaskView.New(),
		GuideTipsView.New(),
		GuideStoryView.New(),
		GuideDialogueView.New()
	}
end

return GuideViewContainer
