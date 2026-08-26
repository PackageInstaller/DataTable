-- chunkname: @modules/logic/investigate/view/InvestigateClueViewContainer.lua

module("modules.logic.investigate.view.InvestigateClueViewContainer", package.seeall)

local InvestigateClueViewContainer = class("InvestigateClueViewContainer", BaseViewContainer)

function InvestigateClueViewContainer:buildViews()
	return {
		InvestigateClueView.New()
	}
end

return InvestigateClueViewContainer
