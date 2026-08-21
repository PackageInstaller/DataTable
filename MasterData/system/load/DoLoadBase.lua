-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Load\\DoLoadBase.lua

local strClassName = "DoLoadBase"
local DoLoadBase = Class(strClassName)

function DoLoadBase:ctor()
	self.mMaxRate = 1
end

function DoLoadBase:destroy()
	return
end

function DoLoadBase:start()
	return
end

function DoLoadBase:getRate()
	self:checkRate()

	return self.mCurRate
end

function DoLoadBase:checkRate()
	return
end

return DoLoadBase
