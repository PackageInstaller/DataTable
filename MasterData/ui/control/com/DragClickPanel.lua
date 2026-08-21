-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\DragClickPanel.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local UIConst = UIConst
local strClassName = "DragClickPanel"
local DragClickPanel = Class(strClassName, UIBaseControl)

function DragClickPanel:ctor(parent, path)
	return
end

function DragClickPanel:_getControlType()
	return UIConst.ControlTypeDragPinchPanel
end

function DragClickPanel:setDragFunc(func)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:setDragFunc(func)
	end
end

function DragClickPanel:setClickFunc(func)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:setClickFunc(func)
	end
end

function DragClickPanel:setDragBeginFunc(func)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:setDragBeginFunc(func)
	end
end

function DragClickPanel:setDragEndFunc(func)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:setDragEndFunc(func)
	end
end

function DragClickPanel:setPinchFunc(func)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:setPinchFunc(func)
	end
end

function DragClickPanel:setLongPressFunc(func)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:setLongPressFunc(func)
	end
end

function DragClickPanel:setTouchEndFunc(func)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:setTouchEndFunc(func)
	end
end

function DragClickPanel:setRotateFunc(func)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:setRotateFunc(func)
	end
end

function DragClickPanel:setDoubleMoveFunc(func)
	local obj = self:getComObj()

	if obj ~= nil then
		obj:setDoubleMoveFunc(func)
	end
end

return DragClickPanel
