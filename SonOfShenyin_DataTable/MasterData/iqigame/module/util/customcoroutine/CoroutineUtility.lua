-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\CoroutineUtility.lua

local CustomCoroutine = require("IQIGame.Module.Util.CustomCoroutine.CustomCoroutine")

CoroutineUtility = {
	coroutines = {},
	customCoroutineToIndex = {},
	coroutinesToRemove = {}
}

function CoroutineUtility.HandleRemoveCoroutineRequest()
	for i = #CoroutineUtility.coroutines, 1, -1 do
		local customCoroutine = CoroutineUtility.coroutines[i]

		if customCoroutine.isNeedToRemove then
			table.remove(CoroutineUtility.coroutines, i)

			if customCoroutine.customWait and customCoroutine.customWait.Dispose then
				customCoroutine.customWait:Dispose()
			end

			CoroutineUtility.customCoroutineToIndex[customCoroutine] = nil
		end
	end
end

function CoroutineUtility.CreateCoroutine(yieldable, ...)
	local customCoroutine = CustomCoroutine()

	table.insert(CoroutineUtility.coroutines, customCoroutine)

	CoroutineUtility.customCoroutineToIndex[customCoroutine] = #CoroutineUtility.coroutines

	if type(yieldable) == "function" then
		customCoroutine.coroutine = coroutine.create(yieldable)
		customCoroutine.parameters = ...
	elseif type(yieldable) == "table" and yieldable.waitType then
		customCoroutine.customWait = yieldable
	end

	return customCoroutine
end

function CoroutineUtility.StartCoroutine(yieldable, ...)
	local customCoroutine = CustomCoroutine()

	table.insert(CoroutineUtility.coroutines, customCoroutine)

	CoroutineUtility.customCoroutineToIndex[customCoroutine] = #CoroutineUtility.coroutines

	local parent = CoroutineUtility.current

	CoroutineUtility.current = customCoroutine

	if type(yieldable) == "function" then
		customCoroutine.coroutine = coroutine.create(yieldable)

		if coroutine.status(customCoroutine.coroutine) == "suspended" then
			local succeed, errorInfo = coroutine.resume(customCoroutine.coroutine, ...)

			if not succeed then
				Log.Error(errorInfo)
			end
		end
	elseif type(yieldable) == "table" and yieldable.waitType then
		customCoroutine.customWait = yieldable
	end

	CoroutineUtility.current = parent

	return customCoroutine
end

local yieldReturnNull

function CoroutineUtility.Yield(yieldable, ...)
	if yieldable == nil then
		if yieldReturnNull == nil then
			yieldReturnNull = YieldReturnNull()
		end

		return CoroutineUtility.Yield(yieldReturnNull)
	end

	local customCoroutine

	if type(yieldable) == "table" and (yieldable.coroutine or yieldable.customWait) then
		customCoroutine = yieldable
	elseif type(yieldable) == "function" or type(yieldable) == "table" and yieldable.waitType then
		customCoroutine = CustomCoroutine()

		table.insert(CoroutineUtility.coroutines, customCoroutine)

		CoroutineUtility.customCoroutineToIndex[customCoroutine] = #CoroutineUtility.coroutines
	else
		error("协程不支持的类型" .. tostring(yieldable))
	end

	local parent = CoroutineUtility.current

	CoroutineUtility.current = customCoroutine

	if parent then
		parent.child = customCoroutine
		customCoroutine.parent = parent
	end

	if type(yieldable) == "function" then
		customCoroutine.coroutine = coroutine.create(yieldable)

		if coroutine.status(customCoroutine.coroutine) ~= "dead" then
			local succeed, errorInfo = coroutine.resume(customCoroutine.coroutine, ...)

			if not succeed then
				Log.Error(errorInfo)
			end
		end
	elseif type(yieldable) == "table" and yieldable.waitType then
		customCoroutine.customWait = yieldable
	end

	if parent and parent.coroutine ~= nil then
		coroutine.yield(parent.coroutine)
	end

	CoroutineUtility.current = parent

	return customCoroutine
end

function CoroutineUtility.YieldAll(...)
	return CoroutineUtility.YieldAllByTable({
		...
	})
end

function CoroutineUtility.YieldAllByTable(coroutines)
	return CoroutineUtility.Yield(WaitAll(coroutines))
end

function CoroutineUtility.YieldAllByTableWrap(createSubCoroutinesFunction)
	local parent = CoroutineUtility.current
	local subCoroutines = createSubCoroutinesFunction()

	CoroutineUtility.current = parent

	return CoroutineUtility.Yield(WaitAll(subCoroutines))
end

function CoroutineUtility.Update()
	CoroutineUtility.HandleRemoveCoroutineRequest()

	local index = 1

	while index <= #CoroutineUtility.coroutines do
		local customCoroutine = CoroutineUtility.coroutines[index]

		CoroutineUtility.current = customCoroutine

		customCoroutine:Update()

		index = index + 1
	end
end

function CoroutineUtility.StopCoroutine(customCoroutine)
	customCoroutine:Stop()
end

CoroutineUtility.updateFrameTimer = FrameTimer.New(CoroutineUtility.Update, 1, -1)

CoroutineUtility.updateFrameTimer:Start()
