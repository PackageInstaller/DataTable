-- chunkname: @modules/logic/versionactivity2_8/decalogpresent/view/V2a8DecalogPresentViewContainer.lua

module("modules.logic.versionactivity2_8.decalogpresent.view.V2a8DecalogPresentViewContainer", package.seeall)

local V2a8DecalogPresentViewContainer = class("V2a8DecalogPresentViewContainer", BaseViewContainer)

function V2a8DecalogPresentViewContainer:buildViews()
	return {
		V2a8DecalogPresentView.New()
	}
end

return V2a8DecalogPresentViewContainer
