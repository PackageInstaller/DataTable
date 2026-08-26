-- chunkname: @modules/logic/common/view/CommonInputViewContainer.lua

module("modules.logic.common.view.CommonInputViewContainer", package.seeall)

local CommonInputViewContainer = class("CommonInputViewContainer", BaseViewContainer)

function CommonInputViewContainer:buildViews()
	return {
		CommonInputView.New()
	}
end

function CommonInputViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return CommonInputViewContainer
