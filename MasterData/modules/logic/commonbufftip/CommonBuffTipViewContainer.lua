-- chunkname: @modules/logic/commonbufftip/CommonBuffTipViewContainer.lua

module("modules.logic.commonbufftip.CommonBuffTipViewContainer", package.seeall)

local CommonBuffTipViewContainer = class("CommonBuffTipViewContainer", BaseViewContainer)

function CommonBuffTipViewContainer:buildViews()
	return {
		CommonBuffTipView.New()
	}
end

function CommonBuffTipViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return CommonBuffTipViewContainer
