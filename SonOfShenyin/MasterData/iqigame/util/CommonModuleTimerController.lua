-- chunkname: @IQIGame\\Util\\CommonModuleTimerController.lua

local Call = {
	count = 1,
	complete = false
}

function Call.New(delay, callback, callbackArgs, count)
	local obj = Clone(Call)

	obj:__OnInit(delay, callback, callbackArgs, count)

	return obj
end

function Call:_OnInit(callback, callbackArgs, count)
	self.callback = callback
	self.callbackArgs = callbackArgs
	self.count = TryToNumber(count, 1)
	self.complete = false
end

function Call:Update()
	if self.complete then
		return
	end

	if not self:__Check() then
		return
	end

	self:__Execute()
end

function Call:__Check()
	return false
end

function Call:__Execute()
	self.callback(self.callbackArgs)

	self.count = self.count - 1

	if self.count > 0 then
		return
	end

	self.complete = true
end

function Call:Dispose()
	self.callback = nil
	self.callbackArgs = nil
end

local ConditionCall = Clone(Call)

function ConditionCall.New(conditionCall, conditionArgs, callback, callbackArgs, count)
	local obj = Clone(ConditionCall)

	obj:__OnInit(conditionCall, conditionArgs, callback, callbackArgs, count)

	return obj
end

function ConditionCall:__OnInit(conditionCall, conditionArgs, callback, callbackArgs, count)
	self.conditionCall = conditionCall
	self.conditionArgs = conditionArgs

	self:_OnInit(callback, callbackArgs, count)
end

function ConditionCall:__Check()
	if self.conditionCall == nil then
		return true
	end

	return self.conditionCall(self.conditionArgs)
end

local DelayCall = Clone(Call)

function DelayCall.New(delay, callback, callbackArgs, count)
	local obj = Clone(DelayCall)

	obj:__OnInit(delay, callback, callbackArgs, count)

	return obj
end

function DelayCall:__OnInit(delay, callback, callbackArgs, count)
	self.delay = delay

	self:_OnInit(callback, callbackArgs, count)
end

function DelayCall:__Check()
	self.delay = self.delay - 1

	return self.delay <= 0
end

local Controller = {
	__frameCallTable = {},
	__secondCallTable = {}
}

function Controller.New(moduleName, scale)
	local obj = Clone(Controller)

	obj:__Init(moduleName, scale)

	return obj
end

function Controller:__Init(moduleName, scale)
	self.__moduleName = moduleName
	self.__frameCallTable = {}

	function self.__delegateOnFrameUpdate()
		self:__OnFrameUpdate()
	end

	self.__frameTimer = ModuleTimerUtil.NewFrameTimer(moduleName, self.__delegateOnFrameUpdate, 1, -1)

	self.__frameTimer:Start()

	self.__secondCallTable = {}

	function self.__delegateOnSecondUpdate()
		self:__OnSecondUpdate()
	end

	self.__secondTimer = ModuleTimerUtil.NewTimer(moduleName, self.__delegateOnSecondUpdate, 1, -1, scale)

	self.__secondTimer:Start()
end

function Controller:__OnFrameUpdate()
	if self.OnFrameUpdateEvent ~= nil then
		self.OnFrameUpdateEvent()
	end

	ForArray(self.__frameCallTable, function(_, _call)
		_call:Update()
	end)
	ForArrayTable(self.__frameCallTable, function(_index, _call)
		if not _call.complete then
			return
		end

		_call:Dispose()
		table.remove(self.__frameCallTable, _index)
	end, true)
end

function Controller:__OnSecondUpdate()
	if self.OnSecondUpdateEvent ~= nil then
		self.OnSecondUpdateEvent()
	end

	ForArray(self.__secondCallTable, function(_, _call)
		_call:Update()
	end)
	ForArrayTable(self.__secondCallTable, function(_index, _call)
		if not _call.complete then
			return
		end

		_call:Dispose()
		table.remove(self.__secondCallTable, _index)
	end, true)
end

function Controller:Dispose()
	ModuleTimerUtil.Stop(self.__moduleName)

	self.__frameTimer = nil
	self.__secondTimer = nil
	self.OnSecondUpdateEvent = nil
	self.OnFrameUpdateEvent = nil

	ForPairs(self.__secondCallTable, function(_, _call)
		_call:Dispose()
	end)
	ForPairs(self.__frameCallTable, function(_, _call)
		_call:Dispose()
	end)
end

function Controller:AddFrameDelayCall(delay, call, callArgs, count)
	local _call = DelayCall.New(delay, call, callArgs, count)

	table.insert(self.__frameCallTable, _call)

	return _call
end

function Controller:AddFrameConditionCall(conditionCall, conditionArgs, callback, callbackArgs, count)
	local _call = ConditionCall.New(conditionCall, conditionArgs, callback, callbackArgs, count)

	table.insert(self.__frameCallTable, _call)

	return _call
end

function Controller:AddSecondDelayCall(delay, call, callArgs, count)
	local _call = DelayCall.New(delay, call, callArgs, count)

	table.insert(self.__secondCallTable, _call)

	return _call
end

function Controller:AddSecondConditionCall(conditionCall, conditionArgs, callback, callbackArgs, count)
	local _call = ConditionCall.New(conditionCall, conditionArgs, callback, callbackArgs, count)

	table.insert(self.__secondCallTable, _call)

	return _call
end

return Controller
