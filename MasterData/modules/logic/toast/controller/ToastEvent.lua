-- chunkname: @modules/logic/toast/controller/ToastEvent.lua

module("modules.logic.toast.controller.ToastEvent", package.seeall)

local ToastEvent = _M

ToastEvent.ShowToast = 1
ToastEvent.RecycleToast = 2
ToastEvent.ReceiveToast = 3
ToastEvent.RecycleFixedToast = 4
ToastEvent.ClearToast = 5
ToastEvent.ClearCacheToastInfo = 6

return ToastEvent
