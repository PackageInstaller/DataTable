local FastStrengthConfirmManager = class("FastStrengthConfirmManager", (require("controller.base_manager")))

FastStrengthConfirmManager.MULTITON_MSG = "FastStrengthConfirmManager instancealready constructed!"

function FastStrengthConfirmManager:ctor()
	FastStrengthConfirmManager.super.ctor(self)

	self._data = {}
end

function FastStrengthConfirmManager:requestInfo(arg_2_1)
	return
end

function FastStrengthConfirmManager:handlerInfo(arg_3_1)
	return
end

function FastStrengthConfirmManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function FastStrengthConfirmManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return FastStrengthConfirmManager
