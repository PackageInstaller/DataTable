-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/EliminateGame\\DoLoadWaitEliminate.lua

local LoaderFactory = Framework.Resource.LoaderFactory
local DoLoadBase = require("System/Load/DoLoadBase")
local EliminateDragCenter = require("EliminateGame/EliminateDragCenter")
local strClassName = "DoLoadWaitEliminate"
local DoLoadWaitEliminate = Class(strClassName, DoLoadBase)

function DoLoadWaitEliminate:ctor()
	return
end

function DoLoadWaitEliminate:checkRate()
	if EliminateDragCenter.isLoadFinish() then
		self.mCurRate = 1
	else
		self.mCurRate = 0
	end
end

return DoLoadWaitEliminate
