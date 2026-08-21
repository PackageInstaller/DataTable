-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/view/TimePicker.lua

module("logic.common.entitas.demo.view.TimePicker", package.seeall)

local M = class("TimePicker", IGamePauseListener)

function M:ctor(container)
	self._go = container.gameObject
end

function M:Awake()
	self._context = Contexts.sharedInstance.game

	local entity = self._context:CreateEntity()

	entity:addPauseListener(self)

	self._entity = entity
	self._slider = self._go:GetComponent("Slider")
end

function M:OnDestroy()
	self._context:destroy_entity(self._entity)
end

function M:OnGamePause(entity, isPause)
	self._slider.enabled = isPause
	self._slider.maxValue = self._context.tick.currentTick
	self._slider.value = self._context.tick.currentTick
end

function M:onSliderValueChanged(value)
	self._context:replaceJumpInTime(value)
end

return M
