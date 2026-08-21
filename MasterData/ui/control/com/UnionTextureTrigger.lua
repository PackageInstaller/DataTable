-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\UnionTextureTrigger.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local Label = require("UI/Control/Com/Label")
local Image = require("UI/Control/Com/Image")
local UIConst = UIConst
local strClassName = "UnionTextureTrigger"
local UnionTextureTrigger = Class(strClassName, UIBaseControl)

function UnionTextureTrigger:ctor(parent, path, textPath, canEmoji)
	return
end

function UnionTextureTrigger:_getControlType()
	return UIConst.ControlTypeUnionTextureTrigger
end

function UnionTextureTrigger:getComObj()
	if self._obj == nil then
		local obj = UnionTextureTrigger.super.getComObj(self)
	end

	return self._obj
end

function UnionTextureTrigger:getEnabled()
	return self:getComObj().enabled
end

function UnionTextureTrigger:setEnabled(isEnable)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.enabled = isEnable and true or false
	end
end

function UnionTextureTrigger:setPauseDelay(pauseDelay)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():SetUnionTexturePauseDelay(obj, pauseDelay)
	end
end

function UnionTextureTrigger:refresh()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():RefreshUnionTexture(obj)
	end
end

return UnionTextureTrigger
