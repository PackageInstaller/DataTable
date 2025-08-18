-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\Panel.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local strClassName = "Panel"
local Panel = Class(strClassName, UIBaseControl)
local Vector3 = Vector3
local Vector3_ONE = Vector3(1, 1, 1)
local Vector3_ZERO = Vector3(0, 0, 0)

function Panel:ctor(parent, path)
	self.mIsScaleHide = false
end

function Panel:setRectSize(width, height)
	if not width or not height then
		return
	end

	local obj = self:getComObj()

	if obj ~= nil then
		obj.transform.sizeDelta = UnityEngine.Vector2(width, height)
	end
end

function Panel:getRectSize()
	local obj = self:getComObj()

	if obj ~= nil then
		local size = obj.transform.sizeDelta

		return {
			width = size.x,
			height = size.y
		}
	end
end

function Panel:setHideByScale(hide)
	if self.mIsScaleHide == hide then
		return
	end

	self.mIsScaleHide = hide

	local obj = self:getComObj()

	if obj ~= nil then
		if self.mIsScaleHide then
			obj.transform.localScale = Vector3_ZERO
		else
			obj.transform.localScale = Vector3_ONE
		end
	end
end

function Panel:addEventDragOnGet(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddDragOnGet(obj, self:_packageCallback(eventFunc))
	end
end

function Panel:clearEventDragOnGet()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearDragOnGet(obj)
	end
end

function Panel:addEventDragOnClick(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddDragOnClick(obj, self:_packageCallback(eventFunc))
	end
end

function Panel:clearEventDragOnClick()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearDragOnClick(obj)
	end
end

function Panel:addEventDragOnLeave(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddDragOnLeave(obj, self:_packageCallback(eventFunc))
	end
end

function Panel:clearEventDragOnLeave()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearDragOnLeave(obj)
	end
end

function Panel:playPortraitAnimation(aniName)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():PlayPortraitAnimation(obj, aniName, 0.3, 0, false)
	end
end

function Panel:setPortraitOrder(order)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():SetPortraitOrder(obj, order)
	end
end

return Panel
