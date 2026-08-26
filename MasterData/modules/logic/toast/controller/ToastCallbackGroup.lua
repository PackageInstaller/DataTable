-- chunkname: @modules/logic/toast/controller/ToastCallbackGroup.lua

module("modules.logic.toast.controller.ToastCallbackGroup", package.seeall)

local ToastCallbackGroup = class("ToastCallbackGroup")

function ToastCallbackGroup:ctor()
	self.onOpen = nil
	self.onOpenObj = nil
	self.onOpenParam = nil
	self.onClose = nil
	self.onCloseObj = nil
	self.onCloseParam = nil
end

function ToastCallbackGroup:tryOnOpen(toastItem)
	if self.onOpen then
		self.onOpen(self.onOpenObj, self.onOpenParam, toastItem)
	end
end

function ToastCallbackGroup:tryOnClose(toastItem)
	if self.onClose then
		self.onClose(self.onCloseObj, self.onCloseParam, toastItem)
	end
end

return ToastCallbackGroup
