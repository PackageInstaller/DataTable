-- chunkname: @modules/logic/battlepass/view/BpInformationViewContainer.lua

module("modules.logic.battlepass.view.BpInformationViewContainer", package.seeall)

local BpInformationViewContainer = class("BpInformationViewContainer", BaseViewContainer)

function BpInformationViewContainer:buildViews()
	return {
		BpInformationView.New()
	}
end

function BpInformationViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return BpInformationViewContainer
