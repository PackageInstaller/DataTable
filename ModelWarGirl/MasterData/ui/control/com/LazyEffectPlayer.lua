-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\LazyEffectPlayer.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local strClassName = "LazyEffectPlayer"
local LazyEffectPlayer = Class(strClassName, UIBaseControl)

function LazyEffectPlayer:ctor(parent, path)
	return
end

function LazyEffectPlayer:_getControlType()
	return UIConst.ControlTypeLazyEffectPlayer
end

function LazyEffectPlayer:playEffectByPath(effectPath, lifeTime, needMirror)
	lifeTime = lifeTime or 0
	needMirror = needMirror or false

	local obj = self:getComObj()

	if obj then
		return obj:PlayNamedEffect(effectPath, lifeTime, needMirror)
	end
end

function LazyEffectPlayer:playEffect(...)
	local obj = self:getComObj()

	if obj then
		obj:PlayEffect()
	end
end

function LazyEffectPlayer:stopEffect(...)
	local obj = self:getComObj()

	if obj then
		obj:StopEffect()
	end
end

return LazyEffectPlayer
