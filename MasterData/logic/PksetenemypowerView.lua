-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PksetenemypowerView.lua

module("logic.extensions.pk.view.PksetenemypowerView", package.seeall)

local PksetenemypowerView = class("PksetenemypowerView", ViewComponent)

function PksetenemypowerView:ctor()
	PksetenemypowerView.super.ctor(self)
end

function PksetenemypowerView:unbindEvents()
	PksetenemypowerView.super.unbindEvents(self)
	self._btnAdd:RemoveClickListener()
	self._btnReduce:RemoveClickListener()
	self._slider:RemoveOnValueChanged()
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function PksetenemypowerView:bindEvents()
	PksetenemypowerView.super.bindEvents(self)
	self._btnAdd:AddClickListener(self._onClickbtnAdd, self)
	self._btnReduce:AddClickListener(self._onClickbtnReduce, self)
	self._slider:AddOnValueChanged(self._onValueChanged, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function PksetenemypowerView:buildUI()
	PksetenemypowerView.super.buildUI(self)

	self._btnAdd = self:getBtn("btnAdd")
	self._btnReduce = self:getBtn("btnReduce")
	self._txtPower = self:getTxt("slider/Handle/txtPower")
	self._txtMaxPower = self:getTxt("txtMaxPower")
	self._txtMinPower = self:getTxt("txtMinPower")
	self._slider = self:getSlider("slider")
	self._btnSure = self:getBtn("viewnode/btnSure")
	self._btnClose = self:getBtn("viewnode/btnClose")
end

function PksetenemypowerView:onExit()
	PksetenemypowerView.super.onExit(self)
end

function PksetenemypowerView:onEnter()
	PksetenemypowerView.super.onEnter(self)

	local params = self:getOpenParam()

	self._currPower = params[1]
	self._sureCallBack = params[2]
	self._minPower = params[3] or TraincampqiecuoConfig.instance:getPVEFormationMinPower()
	self._maxPower = params[4] or TraincampqiecuoConfig.instance:getPVEFormationMaxPower()
	self._perOpPower = TraincampqiecuoConfig.instance:getPVEFormationStepPower()
	self._perOpSliderValue = self._perOpPower / (self._maxPower - self._minPower)

	self:_updateUI()
end

function PksetenemypowerView:_onClickbtnAdd()
	self._isBtnOP = true
	self._currPower = self._currPower + self._perOpPower
	self._currPower = math.min(self._currPower, self._maxPower)
	self._sliderValue = self._sliderValue + self._perOpSliderValue
	self._sliderValue = math.min(self._sliderValue, 1)

	self._slider:SetValue(self._sliderValue)
end

function PksetenemypowerView:_onClickbtnReduce()
	self._isBtnOP = true
	self._currPower = self._currPower - self._perOpPower
	self._currPower = math.max(self._currPower, self._minPower)
	self._sliderValue = self._sliderValue - self._perOpSliderValue
	self._sliderValue = math.max(self._sliderValue, 0)

	self._slider:SetValue(self._sliderValue)
end

function PksetenemypowerView:_onClickbtnSure()
	local value = self:_getShowPower()

	self._sureCallBack(value)
	self:close()
end

function PksetenemypowerView:_onClickbtnClose()
	self:close()
end

function PksetenemypowerView:_onValueChanged(value)
	if not self._isBtnOP then
		self._sliderValue = value

		self:_calCurrPower()
	else
		self:_showPower()
	end

	self._isBtnOP = false
end

function PksetenemypowerView:_updateUI()
	self:_initPower()

	self._txtMinPower.text = string.format("%sW", self._minPower / 10000)
	self._txtMaxPower.text = string.format("%sW", self._maxPower / 10000)
end

function PksetenemypowerView:_calCurrPower()
	local value = self:_getShowPower()

	self._currPower = value
	self._txtPower.text = string.format("%sW", value / 10000)
end

function PksetenemypowerView:_getShowPower()
	local value = self:_getRealPower()

	value = math.floor(value / 10000) * 10000

	return value
end

function PksetenemypowerView:_getRealPower()
	return (self._maxPower - self._minPower) * self._sliderValue + self._minPower
end

function PksetenemypowerView:_showPower()
	self._txtPower.text = string.format("%sW", self._currPower / 10000)
end

function PksetenemypowerView:_initPower()
	self._isBtnOP = true
	self._sliderValue = (self._currPower - self._minPower) / (self._maxPower - self._minPower)

	self._slider:SetValue(self._sliderValue)

	self._isBtnOP = false

	self:_showPower()
end

return PksetenemypowerView
