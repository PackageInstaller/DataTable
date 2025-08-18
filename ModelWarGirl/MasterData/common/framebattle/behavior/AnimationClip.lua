-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\Behavior\\AnimationClip.lua

local Class = require("Framework/Class")
local className = "AnimationClip"
local AnimationClip = Class(strClassName)

function AnimationClip:ctor(motionInfo)
	self.mName = motionInfo.name
	self.mFrameCount = self:timeToFrame(motionInfo.length)
	self.mIsLoop = motionInfo.isLooping
end

function AnimationClip:timeToFrame(seconds)
	local frame = math.ceil(seconds * 16)

	return frame
end

return AnimationClip
