-- chunkname: @modules/logic/versionactivity2_5/decalogpresent/view/V2a5DecalogPresentFullViewContainer.lua

module("modules.logic.versionactivity2_5.decalogpresent.view.V2a5DecalogPresentFullViewContainer", package.seeall)

local V2a5DecalogPresentFullViewContainer = class("V2a5DecalogPresentFullViewContainer", BaseViewContainer)

function V2a5DecalogPresentFullViewContainer:buildViews()
	return {
		V2a5DecalogPresentFullView.New()
	}
end

return V2a5DecalogPresentFullViewContainer
