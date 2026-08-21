-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Load\\DoLoadWaitRearHouse.lua

local LoaderFactory = Framework.Resource.LoaderFactory
local DoLoadBase = require("System/Load/DoLoadBase")
local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local strClassName = "DoLoadWaitRearHouse"
local DoLoadWaitRearHouse = Class(strClassName, DoLoadBase)

function DoLoadWaitRearHouse:ctor()
	return
end

function DoLoadWaitRearHouse:checkRate()
	if RearHouseDragCenter.isLoadFinish() then
		self.mCurRate = 1
	else
		self.mCurRate = 0
	end
end

return DoLoadWaitRearHouse
