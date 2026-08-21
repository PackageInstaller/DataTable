-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/view/ElixirAmount.lua

module("logic.common.entitas.demo.view.ElixirAmount", package.seeall)

local M = class("ElixirAmount", IGameElixirListener)

function M:ctor(container)
	self._go = container.gameObject
end

function M:Awake()
	self._context = Contexts.sharedInstance.game

	local entity = self._context:CreateEntity()

	entity:addElixirListener(self)

	self._entity = entity
	self._text = self._go:GetComponent("Text")
end

function M:OnDestroy()
	self._context:destroy_entity(self._entity)
end

function M:OnGameElixir(entity, amount)
	self._text.text = string.format("%.2f", amount)
end

return M
