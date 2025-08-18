-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\Dropdown.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local UIConst = UIConst
local strClassName = "Dropdown"
local Dropdown = Class(strClassName, UIBaseControl)

function Dropdown:ctor(parent, path)
	self._items = {}
end

function Dropdown:_getControlType()
	return UIConst.ControlTypeDropdown
end

function Dropdown:getEnable()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.interactable
	else
		return false
	end
end

function Dropdown:setEnable(v)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.interactable = v
	end
end

function Dropdown:getText()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.captionText.text
	end

	return ""
end

function Dropdown:setItems(v)
	local obj = self:getComObj()

	if obj ~= nil then
		local datas = {}

		for i, item in ipairs(v) do
			datas[i] = {
				image = "",
				text = item
			}
		end

		self._items = v

		self:getController():SetDropdownItems(obj, datas)
	end
end

function Dropdown:getItems()
	return self._items
end

function Dropdown:setIndex(v)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.value = v
	end
end

function Dropdown:getIndex()
	return self:getComObj().value
end

function Dropdown:addEventValueChanged(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddDropdownOnValueChanged(obj, self:_packageCallback(eventFunc))
	end
end

function Dropdown:clearEventValueChanged()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearDropdownOnValueChanged(obj)
	end
end

return Dropdown
