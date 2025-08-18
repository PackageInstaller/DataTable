-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\FrameImage.lua

local Image = require("UI/Control/Com/Image")
local strClassName = "FrameImage"
local FrameImage = Class(strClassName, Image)
local UIConst = UIConst

function FrameImage:ctor(parent, path, loop)
	self.mAniLoop = loop == true
end

function FrameImage:_getAni()
	if self._ani == nil then
		self._ani = self:getController():GetCom(UIConst.ControlTypeFrameAni, self.mPath)
		self._ani.Loop = self.mAniLoop
	end

	return self._ani
end

function FrameImage:setFrameImage(filePath, spriteNames)
	local ani = self:_getAni()

	if ani ~= nil then
		ani:InitSprits(filePath, spriteNames)
	end
end

function FrameImage:play(forward, loop)
	local ani = self:_getAni()

	if ani == nil then
		return
	end

	if loop ~= nil then
		self.mAniLoop = loop == true
		ani.Loop = self.mAniLoop
	end

	if forward == true then
		ani:Play()
	else
		ani:PlayReverse()
	end
end

function FrameImage:stop()
	local ani = self:_getAni()

	if ani ~= nil then
		ani:Stop()
	end
end

return FrameImage
