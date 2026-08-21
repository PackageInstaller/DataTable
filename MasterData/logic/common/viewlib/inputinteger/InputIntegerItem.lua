-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/inputinteger/InputIntegerItem.lua

module("logic.common.viewlib.inputinteger.InputIntegerItem", package.seeall)

local M = class("InputIntegerItem")

M.gameObject = nil
M._btnMax = nil
M._btnMin = nil
M._inpValue = nil
M._curValue = 0
M._minValue = 0
M._maxValue = 0
M._growthValue = 1
M._valueChangeSuccessHandler = nil
M._valueChangeFailHandler = nil
M._interactable = true

function M:ctor(compContainer)
	self.gameObject = compContainer.gameObject
end

function M:Awake()
	local go = self.gameObject

	self._btnMax = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnMax"))
	self._btnMin = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnMin"))
	self._inpValue = goutil.findChildComponent(self.gameObject, "InputField", UIComponentType.InputField)

	local longPressTriggerIncrease = Astral.UILongPressTrigger.Get(goutil.findChild(self.gameObject, "btnAdd"))
	local longPressTriggerReduce = Astral.UILongPressTrigger.Get(goutil.findChild(self.gameObject, "btnMinus"))
	local inpValeAdapter = Astral.InputFieldAdapter.Get(self._inpValue.gameObject)

	self._longPressTriggerIncrease = longPressTriggerIncrease
	self._longPressTriggerReduce = longPressTriggerReduce
	self._inpValeAdapter = inpValeAdapter

	self:_updateView()
	self:bindEvents()
end

function M:onDestroy()
	self:unbindEvents()
end

function M:bindEvents()
	if self._isAdd then
		return
	end

	if self._btnMax then
		self._btnMax:AddClickListener(self._onClickBtnMax, self)
	end

	if self._btnMin then
		self._btnMin:AddClickListener(self._onClickBtnMin, self)
	end

	local longPressTriggerCfg = {
		0.6,
		0.2,
		0.01
	}

	self._longPressTriggerIncrease:SetTriggerTime(longPressTriggerCfg)
	self._longPressTriggerReduce:SetTriggerTime(longPressTriggerCfg)
	self._longPressTriggerIncrease:AddLongPressListener(self._onLongClickBtnIncrease, self, nil)
	self._longPressTriggerReduce:AddLongPressListener(self._onLongClickBtnReduce, self, nil)
	self._inpValeAdapter:AddOnEndEdit(self._onInpValueEndEdit, self)

	self._isAdd = true
end

function M:unbindEvents()
	if not self._isAdd then
		return
	end

	self._btnMax:RemoveClickListener()
	self._btnMin:RemoveClickListener()
	self._longPressTriggerIncrease:RemoveLongPressListener()
	self._longPressTriggerReduce:RemoveLongPressListener()
	self._inpValeAdapter:RemoveOnEndEdit()

	self._isAdd = false
end

function M:getValue()
	return self._curValue
end

function M:setInterval(min, max)
	self._minValue = min
	self._maxValue = max
end

function M:setValue(value)
	self:_tryUpdateValue(value)
end

function M:setGrowthValue(value)
	self._growthValue = value
end

function M:getMaxValue()
	return self._maxValue
end

function M:getMinValue()
	return self._minValue
end

function M:setValueChangeSuccessListener(callback, handler)
	self._valueChangeSuccessCallback = callback
	self._valueChangeSuccessHandler = handler
end

function M:setValueChangeFailListener(callback, handler)
	self._valueChangeFailCallback = callback
	self._valueChangeFailHandler = handler
end

function M:_onLongClickBtnReduce(triggerIndex)
	self:_tryUpdateValue(self._curValue - self._growthValue, triggerIndex == 0)
end

function M:_onLongClickBtnIncrease(triggerIndex)
	self:_tryUpdateValue(self._curValue + self._growthValue, triggerIndex == 0)
end

function M:_onClickBtnMax()
	self:_tryUpdateValue(self._maxValue)
end

function M:_onClickBtnMin()
	self:_tryUpdateValue(self._minValue)
end

function M:_onInpValueEndEdit()
	local value = self._inpValue.text

	value = tonumber(value)

	if value ~= nil then
		self:_tryUpdateValue(value)
	else
		self:_updateView()
	end
end

function M:_tryUpdateValue(newValue, needFailCallback)
	if not self._interactable then
		return
	end

	self._curFailValue = newValue

	if newValue < self._minValue then
		newValue = self._minValue
	end

	if newValue > self._maxValue then
		newValue = self._maxValue
	end

	if self._curValue == newValue then
		needFailCallback = needFailCallback == nil and true or needFailCallback

		if needFailCallback then
			self:_callValueChangeFail()
		end
	else
		self._curValue = newValue

		self:_callValueChangeSuccess()
	end

	self:_updateView()
end

function M:_callValueChangeSuccess()
	if not self._valueChangeSuccessCallback then
		return
	end

	if self._valueChangeSuccessHandler then
		self._valueChangeSuccessCallback(self._valueChangeSuccessHandler, self._curValue)
	else
		self._valueChangeSuccessCallback(self._curValue)
	end
end

function M:_callValueChangeFail()
	if not self._valueChangeFailCallback then
		return
	end

	if self._valueChangeFailHandler then
		self._valueChangeFailCallback(self._valueChangeFailHandler, self._curValue, self._curFailValue)
	else
		self._valueChangeFailCallback(self._curValue)
	end
end

function M:_updateView()
	self._inpValue.text = tostring(self._curValue)
end

function M:setInteractable(interactable)
	if self.interactable ~= interactable then
		self._interactable = interactable
		self._inpValue.interactable = interactable
	end
end

return M
