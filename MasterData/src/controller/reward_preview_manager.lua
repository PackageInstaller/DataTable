local RewardPreviewManager = class("RewardPreviewManager", (require("controller.base_manager")))

RewardPreviewManager.MULTITON_MSG = "RewardPreviewManager instancealready constructed!"

function RewardPreviewManager:ctor()
	RewardPreviewManager.super.ctor(self)

	self._data = {}
end

function RewardPreviewManager:requestInfo(arg_2_1)
	return
end

function RewardPreviewManager:handlerInfo(arg_3_1)
	return
end

function RewardPreviewManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function RewardPreviewManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return RewardPreviewManager
