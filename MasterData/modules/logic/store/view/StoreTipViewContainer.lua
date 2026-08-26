-- chunkname: @modules/logic/store/view/StoreTipViewContainer.lua

module("modules.logic.store.view.StoreTipViewContainer", package.seeall)

local StoreTipViewContainer = class("StoreTipViewContainer", BaseViewContainer)

function StoreTipViewContainer:buildViews()
	return {
		StoreTipView.New()
	}
end

function StoreTipViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return StoreTipViewContainer
