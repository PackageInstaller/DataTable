-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Load\\DoloadWaitCircleBattle.lua

local DoLoadBase = require("System/Load/DoLoadBase")
local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local strClassName = "DoLoadWaitCircleBattle"
local DoLoadWaitCircleBattle = Class(strClassName, DoLoadBase)

function DoLoadWaitCircleBattle:ctor()
	return
end

function DoLoadWaitCircleBattle:checkRate()
	if CircleControlCenter.isLoadFinish() then
		self.mCurRate = 1
	else
		self.mCurRate = 0
	end
end

return DoLoadWaitCircleBattle
