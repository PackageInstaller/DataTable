-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Load\\DoLoadWaitLogin.lua

local LoaderFactory = Framework.Resource.LoaderFactory
local DoLoadBase = require("System/Load/DoLoadBase")
local strClassName = "DoLoadWaitLogin"
local DoLoadWaitLogin = Class(strClassName, DoLoadBase)

function DoLoadWaitLogin:ctor()
	return
end

function DoLoadWaitLogin:checkRate()
	if CurAvatar and CurAvatar.syncDataReady then
		self.mCurRate = 1
	else
		self.mCurRate = 0
	end
end

return DoLoadWaitLogin
