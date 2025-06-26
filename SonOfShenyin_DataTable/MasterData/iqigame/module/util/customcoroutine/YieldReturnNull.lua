-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\YieldReturnNull.lua

YieldReturnNull = class(nil, CustomWait)

function YieldReturnNull:ctor()
	self.waitType = "YieldReturnNull"
end
