local ItemsPanelPartsManager = class("ItemsPanelPartsManager", (require("controller.base_manager")))

ItemsPanelPartsManager.MULTITON_MSG = "ItemsPanelPartsManager instancealready constructed!"

function ItemsPanelPartsManager:ctor()
	ItemsPanelPartsManager.super.ctor(self)

	self._data = {}
end

function ItemsPanelPartsManager:requestInfo(arg_2_1)
	return
end

function ItemsPanelPartsManager:handlerInfo(arg_3_1)
	return
end

function ItemsPanelPartsManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function ItemsPanelPartsManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return ItemsPanelPartsManager
