local PrivilegePurchaseConfirmationManager = class("PrivilegePurchaseConfirmationManager", (require("controller.base_manager")))

PrivilegePurchaseConfirmationManager.MULTITON_MSG = "PrivilegePurchaseConfirmationManager instancealready constructed!"

function PrivilegePurchaseConfirmationManager:ctor()
	PrivilegePurchaseConfirmationManager.super.ctor(self)

	self._data = {}
end

function PrivilegePurchaseConfirmationManager:requestInfo(arg_2_1)
	return
end

function PrivilegePurchaseConfirmationManager:handlerInfo(arg_3_1)
	return
end

function PrivilegePurchaseConfirmationManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function PrivilegePurchaseConfirmationManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return PrivilegePurchaseConfirmationManager
