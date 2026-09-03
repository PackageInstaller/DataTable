-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/guidelogic/GuideBattleLogic.lua

local co_create = coroutine.create
local co_resume = coroutine.resume
local co_yield = coroutine.yield
local co_status = coroutine.status
local co_running = coroutine.running
local traceback = debug.traceback
local next = _G.next

local function postResume(thread, status, ...)
	local co = thread._co

	if co_status(co) == "dead" then
		thread._co = nil

		if status and thread.onExit ~= nil then
			thread:onExit(...)
		end
	end

	if not status then
		thread._co = nil

		local innerTraceback = traceback(co, ..., 1)

		if not __G__TRACKBACK__ then
			return false, __G__TRACKBACK__(innerTraceback, 3)
		end
	end

	return status, ...
end

local function createSubThread(entry, clazz, ...)
	local thread, main
	local entryType = type(entry)

	if entryType == "function" then
		thread = {}

		function main(...)
			return entry(thread, ...)
		end
	elseif entryType == "table" then
		thread = {}

		assert(entry.main ~= nil, "Main function not defined!")

		function main(...)
			return entry:main(thread, ...)
		end

		if entry.onExit ~= nil then
			function thread:onExit(...)
				return entry:onExit(self, ...)
			end
		end
	else
		assert(false, string.format("Invalid argument #1: function or object expected, got %s", entryType))
	end

	if thread then
		thread._co = co_create(main)

		function thread:resume(...)
			local co = self._co

			if not co then
				return false
			end

			return postResume(self, co_resume(co, ...))
		end

		function thread:yield(...)
			return co_yield(...)
		end

		function thread:isInWorkThread()
			return self._co ~= nil and co_running() == self._co
		end

		function thread:isRunning()
			return self._co ~= nil
		end
	end

	if clazz ~= nil then
		for name, member in pairs(clazz) do
			thread[name] = member
		end

		if thread.initialize ~= nil then
			thread:initialize(...)
		end
	end

	return thread
end

local BattleThread = {}

function BattleThread:initialize(battleLogic, eventCenter)
	self._battleLogic = battleLogic
	self._eventCenter = eventCenter
	self._inputs = {}
end

function BattleThread:pushInput(...)
	local inputs = self._inputs

	inputs[#inputs + 1] = {
		...
	}
end

function BattleThread:processInputs(battleLogic)
	local inputs = self._inputs

	if not self._curInput then
		local cur = 0

		repeat
			cur = cur + 1

			local x = inputs[cur]

			if x == nil then
				break
			end

			self._curInput = cur

			local playerId, op, args, callback = x[1], x[2], x[3], x[4]

			battleLogic:handleInputMessage(playerId, op, args, callback)
		until false
	end
end

function BattleThread:addListener(event, listener, priority)
	if self._eventCenter then
		return self._eventCenter:addListener(event, listener, priority)
	end
end

function BattleThread:removeListener(event, listener)
	if self._eventCenter then
		return self._eventCenter:removeListener(event, listener)
	end
end

function BattleThread:dispatchEvent(event, ...)
	if self._eventCenter then
		return self._eventCenter:dispatchEvent(event, ...)
	end
end

local function timers_add(array, elem)
	local refvalue = elem.value
	local pos = #array + 1

	while pos > 1 do
		local prev = array[pos - 1]

		if refvalue >= prev.value then
			do break end

			pos = pos - 1
		end

		array[pos] = prev
	end

	array[pos] = elem

	return pos
end

local function timers_check(array, refvalue, ids)
	while #array > 0 do
		local elem = array[1]

		if refvalue < elem.value then
			break
		end

		if elem.id ~= nil then
			ids[elem.id] = true
		end

		table.remove(array, 1)
	end

	return ids
end

local GuideThread = {}

function GuideThread:initialize(guideLogic, battleThread)
	self._guideLogic = guideLogic
	self._battleThread = battleThread
	self._millis = 0
	self._millisTimers = {}
	self._frames = 0
	self._frameTimers = {}
	self._isAIDisabled = false
	self._acceptInput = false
end

function GuideThread:getGuideLogic()
	return self._guideLogic
end

function GuideThread:getBattleThread()
	return self._battleThread
end

function GuideThread:isBattleThreadActive()
	local battleThread = self._battleThread

	return battleThread and battleThread.isActive
end

function GuideThread:isAIDisabled()
	return self._isAIDisabled
end

function GuideThread:isInputAccepted()
	return self._acceptInput
end

function GuideThread:disableAI()
	self._isAIDisabled = true
end

function GuideThread:enableAI()
	self._isAIDisabled = false
end

function GuideThread:disableInput()
	self._acceptInput = false
end

function GuideThread:enableInput()
	self._acceptInput = true
end

function GuideThread:inactivateBattleThread()
	local battleThread = self._battleThread

	if battleThread then
		battleThread.isActive = false
	end
end

function GuideThread:activateBattleThread()
	local battleThread = self._battleThread

	if battleThread then
		battleThread.isActive = true
	end
end

function GuideThread:wakeupLaterInTime(milliseconds, tag)
	assert(milliseconds >= 0, "invalid argument")

	local refvalue = self._millis + milliseconds
	local identifier = {
		tag = tag
	}
	local timer = {
		value = refvalue,
		id = identifier
	}
	local timers = self._millisTimers

	if timers == nil then
		self._millisTimers = {
			timer
		}
	else
		timers_add(timers, timer)
	end

	return identifier
end

function GuideThread:wakeupLaterInFrames(frames, tag)
	assert(frames >= 0, "invalid argument")

	local refvalue = self._frames + frames
	local identifier = {
		tag = tag
	}
	local timer = {
		value = refvalue,
		id = identifier
	}
	local timers = self._frameTimers

	if timers == nil then
		self._frameTimers = {
			timer
		}
	else
		timers_add(timers, timer)
	end

	return identifier
end

function GuideThread:wakeupAtEndOfFrame(tag)
	local identifier = {
		tag = tag
	}
	local endOfFrames = self._endOfFrames

	if endOfFrames == nil then
		self._endOfFrames = {
			[identifier] = true
		}
	else
		endOfFrames[identifier] = true
	end

	return identifier
end

function GuideThread:wakeupOnInput(expected, tag)
	local filter

	if expected == nil then
		function filter()
			return true
		end
	else
		local theType = type(expected)

		if theType == "string" then
			function filter(_, op)
				return op == expected
			end
		elseif theType == "table" then
			local ops = {}

			for _, op in pairs(expected) do
				ops[op] = true
			end

			function filter(_, op)
				return ops[op]
			end
		elseif theType == "function" then
			filter = expected
		else
			error("invalid argument #1")
		end
	end

	local identifier = {
		tag = tag
	}
	local entry = {
		filter = filter,
		id = identifier
	}
	local expectedInputs = self._expectedInputs

	if expectedInputs == nil then
		self._expectedInputs = {
			entry
		}
	else
		expectedInputs[#expectedInputs + 1] = entry
	end

	return identifier
end

function GuideThread:wakeupOnBattleEvent(event, priority, repeats, tag)
	return self:wakeupOnExactBattleEvent(event, nil, priority, repeats, tag)
end

function GuideThread:wakeupOnExactBattleEvent(event, filter, priority, repeats, tag)
	local battleThread = self._battleThread

	if battleThread == nil then
		return nil
	end

	local wakeupListeners = self._wakeupListeners

	if wakeupListeners == nil then
		wakeupListeners = {}
		self._wakeupListeners = wakeupListeners
	end

	if wakeupListeners[event] ~= nil then
		battleThread:removeListener(event, wakeupListeners[event])

		wakeupListeners[event] = nil
	end

	local identifier = {
		tag = tag,
		event = event
	}
	local repCounter

	if repeats == nil then
		repCounter = 1
	elseif repeats > 0 then
		repCounter = repeats
	end

	local function listener(event, ...)
		if filter and not filter(...) then
			return
		end

		if wakeupListeners[event] ~= listener then
			battleThread:removeListener(event, listener)

			return
		end

		if repCounter ~= nil then
			repCounter = repCounter - 1

			if repCounter <= 0 then
				battleThread:removeListener(event, listener)

				wakeupListeners[event] = nil
			end
		end

		battleThread:yield("@guide", identifier, {
			event,
			...
		})
	end

	wakeupListeners[event] = listener

	battleThread:addListener(event, listener, priority)

	return identifier
end

function GuideThread:suspend(...)
	assert(self:isInWorkThread(), "This method is misused!")

	local argc = select("#", ...)

	if argc == 0 then
		local _, sources, data = self:yield()

		return data, nil, sources
	elseif argc == 1 then
		local s1 = ...

		while true do
			local _, sources, data = self:yield()

			if sources and sources[s1] then
				return data, s1, sources
			end
		end
	else
		local acceptable = {
			...
		}

		while true do
			local _, sources, data = self:yield()

			if sources then
				for i = 1, argc do
					if sources[acceptable[i]] then
						return data, acceptable[i], sources
					end
				end
			end
		end
	end
end

function GuideThread:sleepForTime(milliseconds)
	assert(self:isInWorkThread(), "This method is misused!")

	if milliseconds ~= nil and milliseconds > 0 then
		local id = self:wakeupLaterInTime(milliseconds)
		local what, sources

		while sources == nil or not sources[id] do
			what, sources = self:yield()
		end
	end
end

function GuideThread:sleepForFrames(frames)
	assert(self:isInWorkThread(), "This method is misused!")

	if frames ~= nil and frames > 0 then
		local id = self:wakeupLaterInFrames(frames)
		local what, sources

		while sources == nil or not sources[id] do
			what, sources = self:yield()
		end
	end
end

function GuideThread:sleepUntilEndOfFrame()
	assert(self:isInWorkThread(), "This method is misused!")

	local id = self:wakeupAtEndOfFrame()
	local what, sources

	while sources == nil or not sources[id] do
		what, sources = self:yield()
	end
end

function GuideThread:waitPlayerInput(expected)
	assert(self:isInWorkThread(), "This method is misused!")

	local id = self:wakeupOnInput(expected)

	while true do
		local what, sources, input = self:yield()

		if sources[id] then
			return input
		end
	end
end

function GuideThread:waitBattleEvent(event, priority, repeats)
	assert(self:isInWorkThread(), "This method is misused!")

	local id = self:wakeupOnBattleEvent(event, priority, repeats)

	if id == nil then
		return nil
	end

	while true do
		local what, sources, eventDetail = self:yield()

		if sources[id] then
			return eventDetail
		end
	end
end

local function GuideThread_checkTimers(self, dt)
	local millis = self._millis + dt

	self._millis = millis

	local frames = self._frames + 1

	self._frames = frames

	local timeout_ids = {}

	timers_check(self._millisTimers, millis, timeout_ids)
	timers_check(self._frameTimers, frames, timeout_ids)

	if next(timeout_ids) ~= nil then
		self:resume("@timeout", timeout_ids)
	end
end

local function GuideThread_onFrameEnded(self)
	while self._endOfFrames ~= nil do
		local endOfFrames = self._endOfFrames

		self._endOfFrames = nil

		self:resume("@eof", endOfFrames)
	end
end

local function GuideThread_processInput(self, playerId, op, args, callback)
	local expectedInputs = self._expectedInputs

	if expectedInputs ~= nil then
		local accepted = {}
		local hole = 1

		for i = 1, #expectedInputs do
			local entry = expectedInputs[i]

			if entry.filter(playerId, op, args, callback) then
				accepted[entry.id] = true
				expectedInputs[i] = nil
			else
				if hole ~= i then
					expectedInputs[hole] = entry
					expectedInputs[i] = nil
				end

				hole = hole + 1
			end
		end

		if next(accepted) ~= nil then
			local data = {
				claimed = false,
				pid = playerId,
				op = op,
				args = args,
				cb = callback
			}

			self:resume("@input", accepted, data)

			return data.claimed
		end
	end

	return false
end

GuideBattleLogic = class("GuideBattleLogic", BaseBattleLogic)

function GuideBattleLogic:initialize(guideProc)
	super.initialize(self)

	self._guideProc = guideProc
end

function GuideBattleLogic:attachBattleLogic(battleLogic)
	self._battleLogic = battleLogic
end

function GuideBattleLogic:getAttachedBattleLogic()
	return self._battleLogic
end

function GuideBattleLogic:createBattleContext()
	if self._battleLogic ~= nil then
		return self._battleLogic:createBattleContext()
	end

	return super.createBattleContext(self)
end

function GuideBattleLogic:_createBattleThread(battleLogic, battleContext)
	local eventCenter = battleContext:getObject("EventCenter")

	local function battleProc(thisThread, battleLogic)
		local result = battleLogic:getBattleResult()

		while result == nil do
			local dt = thisThread:yield("@next")

			thisThread:processInputs(battleLogic)

			result = battleLogic:step(dt)
		end

		return "@$", result
	end

	return createSubThread(battleProc, BattleThread, battleLogic, eventCenter)
end

function GuideBattleLogic:_createGuideThread(guideProc, battleThread, battleContext)
	return createSubThread(guideProc, GuideThread, self, battleThread)
end

function GuideBattleLogic:start(battleContext)
	if not super.start(self, battleContext) then
		return false
	end

	self._millis = 0
	self._millisTimers = {}
	self._frames = 0
	self._frameTimers = {}

	local battleLogic = self._battleLogic

	if battleLogic ~= nil then
		if not battleLogic:start(battleContext) then
			return false
		end

		local battleThread = self:_createBattleThread(battleLogic, battleContext)

		self._battleThread = battleThread
		battleThread.isActive = true

		local ok, where, result = battleThread:resume(battleLogic)

		if not ok then
			self._battleThread = nil

			return false
		end

		if where == "@$" then
			assert(result ~= nil)

			self._battleResult = result

			return true
		end
	end

	self._guideThread = self:_createGuideThread(self._guideProc, self._battleThread, battleContext)

	assert(self._guideThread ~= nil, "Failed to create cuide thread")

	if not self._guideThread:resume(battleContext) then
		self._guideThread = nil
		self._battleThread = nil

		return false
	end

	return true
end

function GuideBattleLogic:finish(result)
	if self._battleLogic ~= nil then
		self._battleLogic:finish(result)
	end

	return super.finish(self, result)
end

function GuideBattleLogic:getBoutTime()
	if self._battleLogic then
		return self._battleLogic:getBoutTime()
	else
		return 0
	end
end

function GuideBattleLogic:getRoundNumber()
	if self._battleLogic then
		return self._battleLogic:getRoundNumber()
	else
		return 0
	end
end

function GuideBattleLogic:isReadyForInput()
	if self._battleLogic then
		return self._battleLogic:isReadyForInput()
	else
		return self._guideThread:isInputAccepted()
	end
end

function GuideBattleLogic:isReadyForAI()
	if self._guideThread and self._guideThread:isAIDisabled() then
		return false
	elseif self._battleLogic then
		return self._battleLogic:isReadyForAI()
	else
		return false
	end
end

function GuideBattleLogic:isWaiting()
	if self._battleLogic then
		return self._battleLogic:isWaiting()
	else
		return false
	end
end

function GuideBattleLogic:step(dt)
	local battleThread = self._battleThread
	local guideThread = self._guideThread

	GuideThread_checkTimers(guideThread, dt)

	local frameEnded = false

	if battleThread then
		while battleThread.isActive do
			local ok, where, d1, d2 = battleThread:resume(dt)

			if not ok then
				break
			end

			if where == "@next" then
				frameEnded = true

				break
			elseif where == "@guide" then
				guideThread:resume("@event", {
					[d1] = true
				}, d2)
			elseif where == "@$" then
				assert(d1 ~= nil)

				self._battleResult = d1
				frameEnded = true

				break
			end
		end
	else
		frameEnded = true
	end

	if frameEnded then
		GuideThread_onFrameEnded(guideThread)
	end

	return self._battleResult
end

function GuideBattleLogic:handleInputMessage(playerId, op, args, callback)
	if GuideThread_processInput(self._guideThread, playerId, op, args, callback) then
		return
	end

	if self._battleThread ~= nil then
		self._battleThread:pushInput(playerId, op, args, callback)
	end
end

function GuideBattleLogic:dispatchMessage(...)
	if self._battleLogic then
		return self._battleLogic:dispatchMessage(...)
	end
end

function GuideBattleLogic:getBattleMode(...)
	if self._battleLogic then
		return self._battleLogic:getBattleMode(...)
	end
end

function GuideBattleLogic:getPlayer(...)
	if self._battleLogic then
		return self._battleLogic:getPlayer(...)
	end
end
