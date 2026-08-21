-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/view/EntitasDemoView.lua

module("logic.common.entitas.demo.view.EntitasDemoView", package.seeall)

local M = class("EntitasDemoView", ViewComponent)

function M:buildUI()
	local world = Astral.LuaComponentContainer.Add(self.mainGO, DemoWorld)

	self._txtTime = self:getGo("entitas_demo_view_1794034157")
	self._txtAmount = self:getGo("entitas_demo_view_1728916123")
	self._sliderReplay = self:getGo("entitas_demo_view_1198961581")
	self._slider = self:getGo("entitas_demo_view_1313955126")
	self._button2 = self:getGo("entitas_demo_view_9307941")
	self._button3 = self:getGo("entitas_demo_view_1337530054")
	self._button4 = self:getGo("entitas_demo_view_2144539702")
	self._buttonPause = self:getBtn("entitas_demo_view_2041832363")

	local btn2 = Astral.LuaComponentContainer.Add(self._button2, ConsumeButton)

	btn2:setConsumptionAmount(2)

	local btn3 = Astral.LuaComponentContainer.Add(self._button3, ConsumeButton)

	btn3:setConsumptionAmount(3)

	local btn4 = Astral.LuaComponentContainer.Add(self._button4, ConsumeButton)

	btn4:setConsumptionAmount(4)

	local elixirAmount = Astral.LuaComponentContainer.Add(self._txtAmount, ElixirAmount)
	local elixirBar = Astral.LuaComponentContainer.Add(self._slider, ElixirBar)
	local pauseButton = Astral.LuaComponentContainer.Add(self._buttonPause.gameObject, PauseButton)
	local timePicker = Astral.LuaComponentContainer.Add(self._sliderReplay, TimePicker)
	local timeText = Astral.LuaComponentContainer.Add(self._txtTime, TimeText)

	self._sliderAdapter = self:getSlider("entitas_demo_view_1198961581")
end

function M:bindEvents()
	self._buttonPause:AddClickListener(self.onButtonClickPause, self)
	self._sliderAdapter:AddOnValueChanged(self._onSliderChange, self)
end

function M:unbindEvents()
	self._buttonPause:RemoveClickListener()
	self._sliderAdapter:RemoveOnValueChanged()
end

function M:destroyUI()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:onButtonClickPause()
	local context = Contexts.sharedInstance.game
	local pause = not context:hasPause()

	context:setPause(pause)
end

function M:_onSliderChange(sliderValue)
	Contexts.sharedInstance.game:replaceJumpInTime(sliderValue)
end

return M
