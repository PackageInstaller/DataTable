-- chunkname: @modules/logic/scene/pushbox/logic/PushBoxElementMechanics.lua

module("modules.logic.scene.pushbox.logic.PushBoxElementMechanics", package.seeall)

local PushBoxElementMechanics = class("PushBoxElementMechanics", UserDataDispose)

function PushBoxElementMechanics:ctor(gameObject, cell)
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

function PushBoxElementMechanics:setRendererIndex()
	local final_renderer_index = self._cell:getRendererIndex()

	for i = 0, self._transform.childCount - 1 do
		local tar_transform = self._transform:GetChild(i)
		local meshRenderer = tar_transform:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

		for index = 0, meshRenderer.Length - 1 do
			meshRenderer[index].sortingOrder = final_renderer_index
		end
	end
end

function PushBoxElementMechanics:refreshMechanicsState(has_box)
	local close_obj = gohelper.findChild(self._gameObject, "Normal")
	local open_obj = gohelper.findChild(self._gameObject, "Enabled")

	gohelper.setActive(open_obj, has_box)
	gohelper.setActive(close_obj, not has_box)

	if has_box and has_box ~= self._last_has_box then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_organ_open)
	end

	self._last_has_box = has_box
end

function PushBoxElementMechanics:_onStartElement()
	return
end

function PushBoxElementMechanics:_onRevertStep()
	return
end

function PushBoxElementMechanics:_onRefreshElement()
	return
end

function PushBoxElementMechanics:_onStepFinished()
	return
end

function PushBoxElementMechanics:getPosX()
	return self._cell:getPosX()
end

function PushBoxElementMechanics:getPosY()
	return self._cell:getPosY()
end

function PushBoxElementMechanics:getObj()
	return self._gameObject
end

function PushBoxElementMechanics:getCell()
	return self._cell
end

function PushBoxElementMechanics:releaseSelf()
	self:__onDispose()
end

return PushBoxElementMechanics
