-- chunkname: @modules/logic/tips/view/MaterialPackageTipViewContainer.lua

module("modules.logic.tips.view.MaterialPackageTipViewContainer", package.seeall)

local MaterialPackageTipViewContainer = class("MaterialPackageTipViewContainer", BaseViewContainer)

function MaterialPackageTipViewContainer:buildViews()
	return {
		MaterialTipView.New()
	}
end

function MaterialPackageTipViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return MaterialPackageTipViewContainer
