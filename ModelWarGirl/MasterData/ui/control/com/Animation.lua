-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\Animation.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local strClassName = "Animation"
local Animation = Class(strClassName, UIBaseControl)

function Animation:ctor(parent, path)
	return
end

function Animation:_getControlType()
	return UIConst.ControlTypeUIAni
end

function Animation:startAni(aniName, sampleAtStart)
	local obj = self:getComObj()

	if obj then
		obj:StartAni(aniName, sampleAtStart or false)
	end
end

function Animation:startAniLoop(aniName)
	local obj = self:getComObj()

	if obj then
		obj:StartAniLoop(aniName)
	end
end

function Animation:stopAni(aniName)
	local obj = self:getComObj()

	if obj then
		obj:StopAni(aniName)
	end
end

function Animation:addEventFinish(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddAniOnFinish(obj, self:_packageCallback(eventFunc))
	end
end

function Animation:clearEventFinish()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearAniOnFinish(obj)
	end
end

function Animation:addEventInterrupt(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddAniOnInterrupt(obj, self:_packageCallback(eventFunc))
	end
end

function Animation:clearEventInterrupt()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearAniOnInterrupt(obj)
	end
end

function Animation:addEventAnimateCue(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddAniOnAnimateCue(obj, self:_packageCallback(eventFunc))
	end
end

function Animation:clearEventAnimateCue()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearAniOnAnimateCue(obj)
	end
end

function Animation:setAniSpeed(speed)
	local obj = self:getComObj()

	if obj then
		obj:SetAniSpeed(speed)
	end
end

return Animation
