-- chunkname: @IQIGame\\Module\\Battle\\BattleData\\BattleCustomWaitConditionData.lua

local m = {
	isCompleted = false
}

function m.New(condition, args1, callback, args2)
	local obj = Clone(m)

	obj:__Init(condition, args1, callback, args2)

	return obj
end

function m:__Init(condition, args1, callback, args2)
	self.conditionFunc = condition
	self.conditionArgs = args1
	self.callbackFunc = callback
	self.callbackArgs = args2
	self.isCompleted = false
end

function m:Check()
	if self.isCompleted then
		return
	end

	self.isCompleted = self.conditionFunc(self.conditionArgs)

	if not self.isCompleted then
		return
	end

	self.callbackFunc(self.callbackArgs)
end

function m:Dispose()
	self.conditionFunc = nil
	self.conditionArgs = nil
	self.callbackFunc = nil
	self.callbackArgs = nil
	self.isCompleted = false
end

return m
