-- chunkname: @modules/logic/survival/view/bubble/SurvivalBubbleViewContainer.lua

module("modules.logic.survival.view.bubble.SurvivalBubbleViewContainer", package.seeall)

local SurvivalBubbleViewContainer = class("SurvivalBubbleViewContainer", BaseViewContainer)

function SurvivalBubbleViewContainer:buildViews()
	return {
		SurvivalBubbleView.New()
	}
end

return SurvivalBubbleViewContainer
