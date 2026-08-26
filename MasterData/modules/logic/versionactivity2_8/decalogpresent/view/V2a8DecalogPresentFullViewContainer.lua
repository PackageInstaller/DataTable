-- chunkname: @modules/logic/versionactivity2_8/decalogpresent/view/V2a8DecalogPresentFullViewContainer.lua

module("modules.logic.versionactivity2_8.decalogpresent.view.V2a8DecalogPresentFullViewContainer", package.seeall)

local V2a8DecalogPresentFullViewContainer = class("V2a8DecalogPresentFullViewContainer", BaseViewContainer)

function V2a8DecalogPresentFullViewContainer:buildViews()
	return {
		V2a8DecalogPresentFullView.New()
	}
end

return V2a8DecalogPresentFullViewContainer
