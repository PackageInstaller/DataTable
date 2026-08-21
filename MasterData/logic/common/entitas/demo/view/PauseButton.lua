-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/view/PauseButton.lua

module("logic.common.entitas.demo.view.PauseButton", package.seeall)

local M = class("PauseButton", IGamePauseListener)

function M:ctor(container)
	self._go = container.gameObject
end

function M:Awake()
	self._context = Contexts.sharedInstance.game

	local entity = self._context:CreateEntity()

	entity:addPauseListener(self)

	self._entity = entity
	self._text = goutil.findChildTextComponent(self._go, "Text")
end

function M:OnDestroy()
	self._context:destroy_entity(self._entity)
end

function M:OnGamePause(entity, isPause)
	self._text.text = isPause and "Resume" or "Pause"
end

return M
