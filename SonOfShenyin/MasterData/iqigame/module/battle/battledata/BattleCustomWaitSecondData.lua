-- chunkname: @IQIGame\\Module\\Battle\\BattleData\\BattleCustomWaitSecondData.lua

local m = {
	startTime = 0,
	isCompleted = false
}

function m.New(seconds, callback, args2)
	local obj = Clone(m)

	obj:__Init(seconds, callback, args2)

	return obj
end

function m:__Init(seconds, callback, args2)
	self.seconds = seconds
	self.callbackFunc = callback
	self.callbackArgs = args2
	self.isCompleted = false
	self.totalTime = 0
end

function m:Check()
	if self.isCompleted then
		return
	end

	self.totalTime = self.totalTime + Time.deltaTime
	self.isCompleted = self.totalTime >= self.seconds

	if not self.isCompleted then
		return
	end

	self.callbackFunc(self.callbackArgs)
end

function m:Dispose()
	self.callbackFunc = nil
	self.callbackArgs = nil
	self.isCompleted = false
end

return m
