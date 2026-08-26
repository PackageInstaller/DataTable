-- chunkname: @modules/logic/toast/view/ToastFixedItem.lua

module("modules.logic.toast.view.ToastFixedItem", package.seeall)

local ToastFixedItem = class("ToastFixedItem", ToastItem)

function ToastFixedItem:quitAnimationFrame(value)
	return
end

function ToastFixedItem:_delay()
	ToastController.instance:dispatchEvent(ToastEvent.RecycleFixedToast, self)
end

return ToastFixedItem
