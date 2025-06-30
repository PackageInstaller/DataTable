-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\CustomWaitForSeconds.lua

CustomWaitForSeconds = class(nil, CustomWait)

function CustomWaitForSeconds:ctor(seconds)
	self.duration = seconds
	self.waitType = "WaitForSeconds"
end
