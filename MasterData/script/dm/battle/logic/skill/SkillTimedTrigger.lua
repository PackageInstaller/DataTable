-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/skill/SkillTimedTrigger.lua

local __scheduleBuilders__ = {}

function __scheduleBuilders__.Specific(cfg, now)
	local moments = cfg.moments

	assert(type(moments) == "table")

	local timer = {}

	table.sort(moments)

	timer._moments = moments
	timer._i = 1

	function timer:next()
		local idx = self._i
		local time = self._moments[idx]

		if time ~= nil then
			self._i = idx + 1
		end

		return time and time + now
	end

	return timer
end

function __scheduleBuilders__.Periodic(cfg, now)
	local interval = cfg.interval

	assert(interval ~= nil and interval > 0, "invalid step interval")

	local timer = {}

	timer._start = cfg.start or 0
	timer._ending = cfg.ending or math.huge
	timer._interval = interval
	timer._next = timer._start

	function timer:next()
		local time = self._next

		if time ~= nil then
			local next = time + self._interval

			self._next = next <= self._ending and next or nil
		end

		return time and time + now
	end

	return timer
end

SkillTimedTrigger = class("SkillTimedTrigger")

function SkillTimedTrigger:initialize()
	super.initialize(self)

	self._time = 0
	self._timeOrderedEntries = {}
end

function SkillTimedTrigger:addAction(plan, actor, action, priority)
	local scheduleBuilder = __scheduleBuilders__[plan.type]

	if scheduleBuilder == nil then
		return nil
	end

	local now = self._time
	local schedule = scheduleBuilder(plan, now)
	local nextTime = schedule:next()

	while nextTime ~= nil do
		if now <= nextTime then
			self:_insertEntry(self._timeOrderedEntries, {
				schedule = schedule,
				time = nextTime,
				priority = priority or 0,
				actor = actor,
				action = action
			})

			return true
		end

		nextTime = schedule:next()
	end

	return false
end

function SkillTimedTrigger:removeAction(actor, action)
	if action == nil then
		remove_if(self._timeOrderedEntries, function(i, entry)
			return entry.actor == actor
		end)
	else
		remove_if(self._timeOrderedEntries, function(i, entry)
			return entry.action == action and entry.actor == actor
		end)
	end
end

function SkillTimedTrigger:_insertEntry(timeOrderedEntries, entry)
	local time, priority = entry.time, entry.priority
	local pos = #timeOrderedEntries

	while pos >= 1 do
		local prev = timeOrderedEntries[pos]

		if time > prev.time or prev.time == time and priority >= prev.priority then
			break
		end

		timeOrderedEntries[pos + 1] = prev
		pos = pos - 1
	end

	pos = pos + 1
	timeOrderedEntries[pos] = entry

	return pos, entry
end

function SkillTimedTrigger:_rearrangeFirstEntry(timeOrderedEntries)
	local entry = timeOrderedEntries[1]

	if entry == nil then
		return nil, nil
	end

	local time = entry.schedule:next()

	if time == nil then
		table.remove(timeOrderedEntries, 1)

		return nil, entry
	end

	entry.time = time

	local priority = entry.priority
	local pos = 2

	while pos <= #timeOrderedEntries do
		local next = timeOrderedEntries[pos]

		if time < next.time or next.time == time and priority < next.priority then
			break
		end

		timeOrderedEntries[pos - 1] = next
		pos = pos + 1
	end

	pos = pos - 1
	timeOrderedEntries[pos] = entry

	return pos, entry
end

function SkillTimedTrigger:update(skillScheduler, dt)
	local time = self._time + dt

	self._time = time

	local timeOrderedEntries = self._timeOrderedEntries
	local entry = timeOrderedEntries[1]

	while entry ~= nil and time >= entry.time do
		self:_rearrangeFirstEntry(timeOrderedEntries)

		local args = {
			ACTOR = entry.actor,
			time = time
		}

		skillScheduler:scheduleWithArgs(entry.actor, entry.action, args)

		entry = timeOrderedEntries[1]
	end
end
