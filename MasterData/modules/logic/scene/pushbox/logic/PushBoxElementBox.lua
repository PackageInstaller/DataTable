-- chunkname: @modules/logic/scene/pushbox/logic/PushBoxElementBox.lua

module("modules.logic.scene.pushbox.logic.PushBoxElementBox", package.seeall)

local PushBoxElementBox = class("PushBoxElementBox", UserDataDispose)

function PushBoxElementBox:ctor(gameObject, cell)
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

function PushBoxElementBox:_onStartElement()
	return
end

function PushBoxElementBox:_onRevertStep()
	return
end

function PushBoxElementBox:_onRefreshElement()
	return
end

function PushBoxElementBox:_onStepFinished()
	return
end

function PushBoxElementBox:hideLight()
	gohelper.setActive(gohelper.findChild(self._gameObject, "#vx_light_left"), false)
	gohelper.setActive(gohelper.findChild(self._gameObject, "#vx_light_right"), false)
	gohelper.setActive(gohelper.findChild(self._gameObject, "#vx_light_down"), false)
end

function PushBoxElementBox:refreshLightRenderer(sort_order)
	local meshRenderer = gohelper.findChild(self._gameObject, "#vx_light_left"):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	if meshRenderer then
		for index = 0, meshRenderer.Length - 1 do
			meshRenderer[index].sortingOrder = sort_order + 7
		end
	end

	meshRenderer = gohelper.findChild(self._gameObject, "#vx_light_right"):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	if meshRenderer then
		for index = 0, meshRenderer.Length - 1 do
			meshRenderer[index].sortingOrder = sort_order + 7
		end
	end

	meshRenderer = gohelper.findChild(self._gameObject, "#vx_light_down"):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	if meshRenderer then
		for index = 0, meshRenderer.Length - 1 do
			meshRenderer[index].sortingOrder = sort_order + 7
		end
	end
end

function PushBoxElementBox:getPosX()
	return self._cell:getPosX()
end

function PushBoxElementBox:getPosY()
	return self._cell:getPosY()
end

function PushBoxElementBox:getObj()
	return self._gameObject
end

function PushBoxElementBox:getCell()
	return self._cell
end

function PushBoxElementBox:releaseSelf()
	self:__onDispose()
end

return PushBoxElementBox
