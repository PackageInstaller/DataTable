-- chunkname: @modules/logic/scene/pushbox/logic/PushBoxElementDoor.lua

module("modules.logic.scene.pushbox.logic.PushBoxElementDoor", package.seeall)

local PushBoxElementDoor = class("PushBoxElementDoor", UserDataDispose)

function PushBoxElementDoor:ctor(gameObject, cell)
	self:__onInit()

	self._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	self._gameObject = gameObject
	self._transform = gameObject.transform
	self._cell = cell

	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.RefreshElement, self._onRefreshElement, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.StepFinished, self._onStepFinished, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.RevertStep, self._onRevertStep, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.StartElement, self._onStartElement, self)
end

function PushBoxElementDoor:setRendererIndex()
	local final_renderer_index = self._cell:getRendererIndex()

	final_renderer_index = final_renderer_index + 1 - 10000

	for i = 0, self._transform.childCount - 1 do
		local tar_transform = self._transform:GetChild(i)
		local meshRenderer = tar_transform:GetChild(0):GetComponent("MeshRenderer")

		meshRenderer.sortingOrder = final_renderer_index
	end
end

function PushBoxElementDoor:refreshDoorState(open_door)
	local close_obj = gohelper.findChild(self._gameObject, "Close")
	local open_obj = gohelper.findChild(self._gameObject, "Open")

	gohelper.setActive(open_obj, open_door)
	gohelper.setActive(close_obj, not open_door)
end

function PushBoxElementDoor:_onStartElement()
	return
end

function PushBoxElementDoor:_onRevertStep()
	return
end

function PushBoxElementDoor:_onRefreshElement()
	return
end

function PushBoxElementDoor:_onStepFinished()
	return
end

function PushBoxElementDoor:getPosX()
	return self._cell:getPosX()
end

function PushBoxElementDoor:getPosY()
	return self._cell:getPosY()
end

function PushBoxElementDoor:getObj()
	return self._gameObject
end

function PushBoxElementDoor:getCell()
	return self._cell
end

function PushBoxElementDoor:releaseSelf()
	self:__onDispose()
end

return PushBoxElementDoor
