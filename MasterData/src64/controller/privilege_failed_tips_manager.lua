local PrivilegeFailedTipsManager = class("PrivilegeFailedTipsManager", (require("controller.base_manager")))

PrivilegeFailedTipsManager.MULTITON_MSG = "PrivilegeFailedTipsManager instancealready constructed!"

function PrivilegeFailedTipsManager:ctor()
	PrivilegeFailedTipsManager.super.ctor(self)

	self._data = {}
end

function PrivilegeFailedTipsManager:requestInfo(arg_2_1)
	return
end

function PrivilegeFailedTipsManager:handlerInfo(arg_3_1)
	return
end

function PrivilegeFailedTipsManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function PrivilegeFailedTipsManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return PrivilegeFailedTipsManager
