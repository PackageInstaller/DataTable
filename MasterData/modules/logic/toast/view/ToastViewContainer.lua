-- chunkname: @modules/logic/toast/view/ToastViewContainer.lua

module("modules.logic.toast.view.ToastViewContainer", package.seeall)

local ToastViewContainer = class("ToastViewContainer", BaseViewContainer)

function ToastViewContainer:buildViews()
	return {
		ToastFixedView.New(),
		ToastView.New()
	}
end

return ToastViewContainer
