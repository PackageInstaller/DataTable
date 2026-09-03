-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/skill/SkillEventTrigger.lua

local INVALID_LISTENER_ENTRY = {}

SkillEventTrigger = class("SkillEventTrigger")

SkillEventTrigger:has("_eventId", {
	is = "r"
})

function SkillEventTrigger:initialize(eventId)
	super.initialize(self)

	self._eventId = eventId
	self._lookupTable = {}
	self._listeners = {}
end

function SkillEventTrigger:addResponder(actor, responder, priority, oneshot)
	if priority == nil then
		priority = 0
	end

	local lookupTable = self._lookupTable
	local entry = lookupTable[responder]

	if entry ~= nil then
		if entry.priority == priority then
			entry.actor = actor
			entry.oneshot = oneshot

			return true
		end

		lookupTable[responder] = nil
	end

	entry = {
		responder = responder,
		actor = actor,
		priority = priority,
		oneshot = oneshot
	}
	lookupTable[responder] = entry

	local listeners = self._listeners
	local pos = #listeners

	while pos > 0 do
		local cur = listeners[pos]

		if cur and priority >= cur.priority then
			break
		end

		listeners[pos + 1] = cur

		if self._curpos == pos then
			self._curpos = pos + 1
		end

		pos = pos - 1
	end

	listeners[pos + 1] = entry
end

function SkillEventTrigger:hasResponder(responder)
	return self._lookupTable[responder] ~= nil
end

function SkillEventTrigger:removeResponder(responder)
	self._lookupTable[responder] = nil
end

function SkillEventTrigger:removeRespondersOfActor(actor)
	local lookupTable = self._lookupTable

	for responder, entry in pairs(lookupTable) do
		if entry.actor == actor then
			lookupTable[responder] = nil
		end
	end
end

function SkillEventTrigger:removeAllResponders()
	if self._curpos ~= nil then
		self._lookupTable = {}
		self._listeners = {}
	else
		local lookupTable, listeners = self._lookupTable, self._listeners

		for k, v in pairs(lookupTable) do
			lookupTable[k] = nil
		end

		for k, v in pairs(listeners) do
			listeners[k] = nil
		end
	end
end

function SkillEventTrigger:activate(skillScheduler, eventArgs)
	local listeners = self._listeners

	if #listeners == 0 then
		return
	end

	local lookupTable = self._lookupTable
	local hasInvalidEntries = false
	local curpos = 1

	while curpos <= #listeners do
		local entry = listeners[curpos]
		local responder = entry.responder

		if lookupTable[responder] == entry then
			self._curpos = curpos

			if entry.oneshot then
				lookupTable[responder] = nil
				listeners[curpos] = INVALID_LISTENER_ENTRY
				hasInvalidEntries = true
			end

			local actor = entry.actor
			local action = entry.responder
			local args = setmetatable({}, {
				__index = eventArgs
			})

			args.event = self._eventId
			args.ACTOR = actor

			skillScheduler:scheduleWithArgs(actor, action, args)

			curpos = self._curpos
		else
			listeners[curpos] = INVALID_LISTENER_ENTRY
			hasInvalidEntries = true
		end

		curpos = curpos + 1
	end

	self._curpos = nil

	if hasInvalidEntries then
		remove_values(listeners, INVALID_LISTENER_ENTRY)
	end
end
