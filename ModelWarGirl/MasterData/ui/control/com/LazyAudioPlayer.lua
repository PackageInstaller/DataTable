-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\LazyAudioPlayer.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local strClassName = "LazyAudioPlayer"
local LazyAudioPlayer = Class(strClassName, UIBaseControl)

function LazyAudioPlayer:ctor(parent, path)
	return
end

function LazyAudioPlayer:_getControlType()
	return UIConst.ControlTypeLazyAudioPlayer
end

function LazyAudioPlayer:playAudio()
	local obj = self:getComObj()

	if obj then
		obj:PlayAudio()
	end
end

function LazyAudioPlayer:setAudioPath(path)
	local obj = self:getComObj()

	if obj then
		obj:SetClipPath(path)
	end
end

function LazyAudioPlayer:setAudioPlayInfo(volume, priority)
	local obj = self:getComObj()

	if obj then
		obj:SetAudioInfo(volume or -1, priority or -1)
	end
end

return LazyAudioPlayer
