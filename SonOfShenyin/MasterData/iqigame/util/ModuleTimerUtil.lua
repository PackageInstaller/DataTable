-- chunkname: @IQIGame\\Util\\ModuleTimerUtil.lua

local m = {
	__ModuleTimers = {},
	__ModuleFrameTimers = {}
}

function m.NewTimer(moduleName, handler, duration, loop, scale)
	local timers = m.__ModuleTimers[moduleName]

	if timers == nil then
		timers = {}
		m.__ModuleTimers[moduleName] = timers
	end

	local timer

	timer = Timer.New(function()
		if timer.loop == 1 then
			local index = table.indexOf(timers, timer)

			table.remove(timers, index)
		end

		xpcall(handler, function(msg)
			logError(tostring(msg))
		end)
	end, duration, loop, scale)

	table.insert(timers, timer)

	return timer
end

function m.NewFrameTimer(moduleName, handler, count, loop)
	local timers = m.__ModuleFrameTimers[moduleName]

	if timers == nil then
		timers = {}
		m.__ModuleFrameTimers[moduleName] = timers
	end

	local timer

	timer = FrameTimer.New(function()
		if timer.loop == 1 then
			local index = table.indexOf(timers, timer)

			table.remove(timers, index)
		end

		xpcall(handler, function(msg)
			logError(tostring(msg))
		end)
	end, count, loop)

	table.insert(timers, timer)

	return timer
end

function m.Stop(moduleName)
	for name, timers in pairs(m.__ModuleTimers) do
		if name == moduleName then
			for i = 1, #timers do
				timers[i]:Stop()
			end

			break
		end
	end

	m.__ModuleTimers[moduleName] = nil

	for name, timers in pairs(m.__ModuleFrameTimers) do
		if name == moduleName then
			for i = 1, #timers do
				timers[i]:Stop()
			end

			break
		end
	end

	m.__ModuleFrameTimers[moduleName] = nil
end

function m.StopAll()
	for name, timers in pairs(m.__ModuleTimers) do
		for i = 1, #timers do
			timers[i]:Stop()
		end
	end

	m.__ModuleTimers = {}

	for name, timers in pairs(m.__ModuleFrameTimers) do
		for i = 1, #timers do
			timers[i]:Stop()
		end
	end

	m.__ModuleFrameTimers = {}
end

function m.StopTimer(timer)
	for name, timers in pairs(m.__ModuleTimers) do
		local index = table.indexOf(timers, timer)

		if index ~= -1 then
			timers[index]:Stop()
			table.remove(timers, index)

			break
		end
	end
end

function m.StopFrameTimer(timer)
	for name, timers in pairs(m.__ModuleFrameTimers) do
		local index = table.indexOf(timers, timer)

		if index ~= -1 then
			timers[index]:Stop()
			table.remove(timers, index)

			break
		end
	end
end

ModuleTimerUtil = m
