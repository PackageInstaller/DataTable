-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\Beginner\\BeginnerBackGround.lua

local ResColor = require("ClientData/ResColor")
local strClassName = "BeginnerBackGround"
local BeginnerBackGround = Class(strClassName, UIControls.Window)

function BeginnerBackGround:ctor()
	self.bg = UIControls.Image(self, "ImgBlock")
end

function BeginnerBackGround:setBgMode(imgMode)
	local color = ResColor.BLACK

	if imgMode == 1 then
		color = ResColor.WHITE
	end

	self.bg:setColorByRGBA(color.r, color.g, color.b, color.a)
end

return BeginnerBackGround
