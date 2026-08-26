-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/element/FairyLandElementDoor.lua

module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandElementDoor", package.seeall)

local FairyLandElementDoor = class("FairyLandElementDoor", FairyLandElementBase)

function FairyLandElementDoor:onInitView()
	self.animator = self._go:GetComponent(typeof(UnityEngine.Animator))

	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.DoStairAnim, self.onDoStairAnim, self)
end

function FairyLandElementDoor:getState()
	local elementId = self:getElementId()
	local lastId = elementId - 1

	if not FairyLandConfig.instance:getElementConfig(lastId) or FairyLandModel.instance:isFinishElement(lastId) then
		return FairyLandEnum.ShapeState.CanClick
	end

	return FairyLandEnum.ShapeState.LockClick
end

function FairyLandElementDoor:onClick()
	local state = self:getState()

	if state == FairyLandEnum.ShapeState.CanClick and not self._elements:isMoveing() then
		self:setFinish()
	end
end

function FairyLandElementDoor:finish()
	FairyLandModel.instance:setPos(self:getPos(), true)
	self._elements:characterMove()
	self:onDestroy()
end

function FairyLandElementDoor:onDoStairAnim(pos)
	if pos == 46 then
		self.animator:Play("door_01", 0, 0)
	elseif pos == 48 then
		self.animator:Play("door_02", 0, 0)
	end
end

function FairyLandElementDoor:onDestroy()
	self:onDestroyElement()

	if self.click then
		self.click:RemoveClickListener()
	end

	self:__onDispose()
end

function FairyLandElementDoor:onDestroyElement()
	return
end

return FairyLandElementDoor
