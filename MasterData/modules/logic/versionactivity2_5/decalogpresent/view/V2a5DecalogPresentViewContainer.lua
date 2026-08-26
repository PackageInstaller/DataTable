-- chunkname: @modules/logic/versionactivity2_5/decalogpresent/view/V2a5DecalogPresentViewContainer.lua

module("modules.logic.versionactivity2_5.decalogpresent.view.V2a5DecalogPresentViewContainer", package.seeall)

local V2a5DecalogPresentViewContainer = class("V2a5DecalogPresentViewContainer", BaseViewContainer)

function V2a5DecalogPresentViewContainer:buildViews()
	return {
		V2a5DecalogPresentView.New()
	}
end

return V2a5DecalogPresentViewContainer
