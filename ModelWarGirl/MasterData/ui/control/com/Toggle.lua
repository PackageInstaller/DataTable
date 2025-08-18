-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\Toggle.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local Label = require("UI/Control/Com/Label")
local UIConst = UIConst
local strClassName = "Toggle"
local Toggle = Class(strClassName, UIBaseControl)

function Toggle:ctor(parent, path, textPath)
	if textPath ~= nil then
		local p = textPath

		if path ~= "" then
			p = path .. "/" .. p
		end

		self._text = Label(parent, p)
	end
end

function Toggle:_getControlType()
	return UIConst.ControlTypeToggle
end

function Toggle:getEnable()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.interactable
	else
		return false
	end
end

function Toggle:setEnable(v)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.interactable = v
	end
end

function Toggle:getText()
	if self._text ~= nil then
		return self._text:getText()
	end
end

function Toggle:setText(v)
	if self._text ~= nil then
		self._text:setText(v)
	end
end

function Toggle:setOn(v)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.isOn = v
	end
end

function Toggle:setOnVoidUnChange(v)
	local obj = self:getComObj()

	if obj ~= nil and self:isOn() ~= v then
		obj.isOn = v
	end
end

function Toggle:isOn()
	return self:getComObj().isOn
end

function Toggle:addEventValueChanged(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddToggleOnValueChanged(obj, self:_packageCallback(eventFunc))
	end
end

function Toggle:clearEventValueChanged()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearToggleOnValueChanged(obj)
	end
end

return Toggle
