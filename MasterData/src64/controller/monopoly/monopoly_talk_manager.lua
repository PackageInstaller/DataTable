local MonopolyTalkManager = class("MonopolyTalkManager", (require("controller.base_manager")))

MonopolyTalkManager.MULTITON_MSG = "MonopolyTalkManager instancealready constructed!"

function MonopolyTalkManager:ctor()
	MonopolyTalkManager.super.ctor(self)

	self._data = {}
end

function MonopolyTalkManager:requestInfo(arg_2_1)
	return
end

function MonopolyTalkManager:handlerInfo(arg_3_1)
	return
end

function MonopolyTalkManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MonopolyTalkManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return MonopolyTalkManager
