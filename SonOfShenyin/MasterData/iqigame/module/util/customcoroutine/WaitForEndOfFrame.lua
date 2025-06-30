-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\WaitForEndOfFrame.lua

WaitForEndOfFrame = class(nil, CustomWait)

function WaitForEndOfFrame:ctor()
	self.waitType = "WaitForEndOfFrame"
end
