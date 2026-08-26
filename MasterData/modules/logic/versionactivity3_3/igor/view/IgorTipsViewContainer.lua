-- chunkname: @modules/logic/versionactivity3_3/igor/view/IgorTipsViewContainer.lua

module("modules.logic.versionactivity3_3.igor.view.IgorTipsViewContainer", package.seeall)

local IgorTipsViewContainer = class("IgorTipsViewContainer", BaseViewContainer)

function IgorTipsViewContainer:buildViews()
	return {
		IgorTipsView.New()
	}
end

function IgorTipsViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return IgorTipsViewContainer
