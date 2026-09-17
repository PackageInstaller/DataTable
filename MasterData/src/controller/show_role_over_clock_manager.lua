local ShowRoleOverClockManager = class("ShowRoleOverClockManager", (require("controller.base_manager")))

ShowRoleOverClockManager.MULTITON_MSG = "ShowRoleOverClockManager instancealready constructed!"

function ShowRoleOverClockManager:ctor()
	ShowRoleOverClockManager.super.ctor(self)

	self._data = {}
end

function ShowRoleOverClockManager:requestInfo(arg_2_1)
	return
end

function ShowRoleOverClockManager:handlerInfo(arg_3_1)
	return
end

function ShowRoleOverClockManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function ShowRoleOverClockManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return ShowRoleOverClockManager
