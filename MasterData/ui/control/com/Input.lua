-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\Input.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local UIConst = UIConst
local strClassName = "Input"
local Input = Class(strClassName, UIBaseControl)

function Input:ctor(parent, path)
	return
end

function Input:_getControlType()
	return UIConst.ControlTypeInputField
end

function Input:getEnable()
	local obj = self:getComObj()

	if self._obj ~= nil then
		return self._obj.interactable
	else
		return false
	end
end

function Input:setEnable(v)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.interactable = v
	end
end

function Input:setText(v)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.text = v
	end
end

function Input:getText()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.text
	end

	return ""
end

function Input:setReadOnly(v)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.readOnly = v
		self.readOnly = v
	end
end

function Input:setCharacterLimit(v)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.characterLimit = v
	end
end

function Input:addEventValueChanged(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddInputFieldOnValueChanged(obj, self:_packageCallback(eventFunc))
	end
end

function Input:clearEventValueChanged()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearInputFieldOnValueChanged(obj)
	end
end

function Input:addEventEndEdit(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddInputFieldOnEndEdit(obj, self:_packageCallback(eventFunc))
	end
end

function Input:clearEventEndEdit()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearInputFieldOnEndEdit(obj)
	end
end

return Input
