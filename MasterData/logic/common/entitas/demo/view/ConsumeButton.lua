-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/view/ConsumeButton.lua

module("logic.common.entitas.demo.view.ConsumeButton", package.seeall)

local M = class("ConsumeButton", IGameElixirListener, IGamePauseListener)

function M:ctor(container)
	self._go = container.gameObject
	self._consumptionAmount = 1
end

function M:setConsumptionAmount(amount)
	self._consumptionAmount = amount
end

function M:Awake()
	self._context = Contexts.sharedInstance.game

	local entity = self._context:CreateEntity()

	entity:addPauseListener(self)
	entity:addElixirListener(self)

	self._entity = entity

	local btn = self._go:GetComponent("Button")

	self._button = btn
	self._image = goutil.findChildImageComponent(self._go, "Image")
	self._btn = Astral.ButtonAdapter.Get(self._go)

	self._btn:AddClickListener(self.onPressButton, self)
end

function M:OnDestroy()
	self._context:destroy_entity(self._entity)
	self._btn:RemoveClickListener()
end

function M:OnGamePause(entity, isPause)
	self._button.enabled = not isPause
end

function M:OnGameElixir(entity, amount)
	local temp = amount / self._consumptionAmount

	temp = temp < 0 and 0 or temp
	temp = temp > 1 and 1 or temp

	local ratio = 1 - temp

	self._image.fillAmount = ratio
	self._button.enabled = ratio <= 0
end

function M:onPressButton()
	if self._context:hasPause() then
		return
	end

	self._context:CreateEntity():addConsumeElixir(self._consumptionAmount)
end

return M
