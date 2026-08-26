-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionHasEnoughMaterial.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionHasEnoughMaterial", package.seeall)

local WaitGuideActionHasEnoughMaterial = class("WaitGuideActionHasEnoughMaterial", BaseGuideAction)

function WaitGuideActionHasEnoughMaterial:onStart(context)
	WaitGuideActionHasEnoughMaterial.super.onStart(self, context)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, self._checkMaterials, self)

	self._materials = GameUtil.splitString2(self.actionParam, true, "|", "#")

	self:_checkMaterials()
end

function WaitGuideActionHasEnoughMaterial:_checkMaterials()
	local enough = true

	for _, one in ipairs(self._materials) do
		local type = one[1]
		local id = one[2]
		local quantity = one[3]
		local hasQuantity = ItemModel.instance:getItemQuantity(type, id)

		if hasQuantity < quantity then
			enough = false

			break
		end
	end

	if enough then
		self:onDone(true)
	end
end

function WaitGuideActionHasEnoughMaterial:clearWork()
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, self._checkMaterials, self)
end

return WaitGuideActionHasEnoughMaterial
