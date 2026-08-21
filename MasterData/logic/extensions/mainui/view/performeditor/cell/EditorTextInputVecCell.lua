-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/cell/EditorTextInputVecCell.lua

module("logic.extensions.mainui.view.performeditor.cell.EditorTextInputVecCell", package.seeall)

local M = class("EditorTextInputVecCell", SimpleCellComponent)

function M:buildUI()
	self._inputAdapter = UIComponentType.InputFieldAdapter(self._go)
	self._valueHandler = Handler.New()
	self._endEditHandler = Handler.New()
end

function M:bindEvents()
	self._inputAdapter:AddOnValueChanged(self._onValueChange, self)
	self._inputAdapter:AddOnEndEdit(self._onEndEdit, self)
end

function M:unbindEvents()
	self._inputAdapter:RemoveOnValueChanged()
	self._inputAdapter:RemoveOnEndEdit()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:destroyUI()
	self:_clearHandler()

	self._inputAdapter = nil
	self._valueHandler = nil
	self._endEditHandler = nil
end

function M:_setData(val, valueChangeCallBack, endEditCallBack, callBackObj)
	self._curVal = self:_toVal(val)

	self:_clearHandler()
	self._valueHandler:setListener(valueChangeCallBack, callBackObj)
	self._endEditHandler:setListener(endEditCallBack, callBackObj)
end

function M:_refreshUI()
	self:setVal(self._curVal)
end

function M:_clearHandler()
	self._valueHandler:clear()
	self._endEditHandler:clear()
end

function M:_onEndEdit(str)
	local val = self:_toVal(str)

	if self._curVal == val then
		return
	end

	self._curVal = val

	self._endEditHandler:call(self._curVal)
end

function M:_onValueChange(str)
	local val = self:_toVal(str)

	if self._curVal == val then
		return
	end

	self._curVal = val

	self._valueHandler:call(self._curVal)
end

function M:_toVal(strOrNum)
	return tonumber(strOrNum) or 0
end

function M:init()
	self:_clearHandler()
	self:setVal(0)
end

function M:getVal()
	return self._curVal
end

function M:setVal(val)
	self._curVal = tonumber(val) or 0

	self._inputAdapter:SetText(self._curVal)
end

function M:setValueListener(callBackFun, callBackObj)
	self._valueHandler:setListener(callBackFun, callBackObj)
end

function M:setEndEditListener(callBackFun, callBackObj)
	self._endEditHandler:setListener(callBackFun, callBackObj)
end

return M
