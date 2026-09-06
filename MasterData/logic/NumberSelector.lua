-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/component/NumberSelector.lua

module("logic.extensions.common.component.NumberSelector", package.seeall)

local NumberSelector = class("NumberSelector", BaseLuaOnce)

function NumberSelector:ctor(go)
	NumberSelector.super.ctor(self, go)

	self._minNum = 0
	self._curNum = 0
	self._maxNum = 0
end

function NumberSelector:buildUI()
	self._m10Btn = self:getBtn("Marks/BtnM10")
	self._minusBtn = self:getBtn("Marks/BtnMs")
	self._addBtn = self:getBtn("Marks/BtnAdd")
	self._a10Btn = self:getBtn("Marks/BtnA10")
	self._procNumText = self:getInput("IptItem")
end

function NumberSelector:bindEvents()
	self._m10Btn:AddClickListener(self._onClickM10, self)
	self._minusBtn:AddClickListener(self._onClickMinus, self)
	self._addBtn:AddClickListener(self._onClickAdd, self)
	self._a10Btn:AddClickListener(self._onClickA10, self)
	self._procNumText:AddOnValueChanged(self._onValueChanged, self)
end

function NumberSelector:unbindEvents()
	self._m10Btn:RemoveClickListener()
	self._minusBtn:RemoveClickListener()
	self._addBtn:RemoveClickListener()
	self._a10Btn:RemoveClickListener()
	self._procNumText:RemoveOnValueChanged()
end

function NumberSelector:onEnter(minNum, maxNum, defaultNum)
	defaultNum = defaultNum or minNum
	self._minNum = minNum
	self._curNum = defaultNum or 1

	self:setMaxNum(maxNum)
	self._procNumText:SetText(tostring(self._curNum))
end

function NumberSelector:onExit()
	self:RemoveListener()
end

function NumberSelector:_onClickM10()
	self:_changeNumText(-10)
end

function NumberSelector:_onClickMinus()
	self:_changeNumText(-1)
end

function NumberSelector:_onClickAdd()
	self:_changeNumText(1)
end

function NumberSelector:_onClickA10()
	self:_changeNumText(10)
end

function NumberSelector:_changeNumText(delta)
	local num = checknumber(self._procNumText:GetText()) + delta

	num = Mathf.Clamp(num, self._minNum, self._maxNum)

	self._procNumText:SetText(tostring(num))
	self:_invoke(num)
end

function NumberSelector:_onValueChanged(strNum)
	local num = checknumber(strNum)

	if num == self._curNum then
		return
	end

	num = Mathf.Clamp(num, 1, self._maxNum)
	self._curNum = num

	self._procNumText:SetText(tostring(self._curNum))
	self:_invoke(self._curNum)
end

function NumberSelector:AddListener(handle, handleObj)
	self._handle = handle
	self._handleObj = handleObj
end

function NumberSelector:RemoveListener()
	self._handleObj = nil
	self._handle = nil
end

function NumberSelector:_invoke(num)
	if not self._handle then
		printInfo("没绑定哦")

		return
	end

	if self._handleObj then
		self._handle(self._handleObj, num)
	else
		self._handle(num)
	end
end

function NumberSelector:setMaxNum(maxNum)
	if self._maxNum == maxNum then
		return
	end

	self._maxNum = maxNum

	if maxNum < self._curNum then
		self._procNumText:SetText(tostring(maxNum))
	end
end

return NumberSelector
