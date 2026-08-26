-- chunkname: @modules/logic/sdk/view/SdkFitAgeTipViewContainer.lua

module("modules.logic.sdk.view.SdkFitAgeTipViewContainer", package.seeall)

local SdkFitAgeTipViewContainer = class("SdkFitAgeTipViewContainer", BaseViewContainer)

function SdkFitAgeTipViewContainer:buildViews()
	return {
		SdkFitAgeTipView.New()
	}
end

function SdkFitAgeTipViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return SdkFitAgeTipViewContainer
