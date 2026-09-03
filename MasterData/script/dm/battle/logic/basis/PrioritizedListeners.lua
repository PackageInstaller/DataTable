-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/basis/PrioritizedListeners.lua

PrioritizedListeners = class("PrioritizedListeners")

function PrioritizedListeners:initialize()
	super.initialize(self)

	self._listenerRegistry = {}
	self._orderedListeners = {}
end

function PrioritizedListeners:add(listener, priority)
	if self._firingList == self._orderedListeners then
		local copiedListeners = {}
		local orderedListeners = self._orderedListeners

		for i = 1, #orderedListeners do
			copiedListeners[i] = orderedListeners[i]
		end

		self._orderedListeners = copiedListeners
	end

	if priority == nil then
		priority = 0
	end

	local orderedListeners = self._orderedListeners
	local count = #orderedListeners
	local targetEntry = self._listenerRegistry[listener]

	if targetEntry == nil then
		targetEntry = {
			listener = listener,
			priority = priority
		}
		self._listenerRegistry[listener] = targetEntry

		local pos = count + 1

		for i = count, 1, -1 do
			local entry = orderedListeners[i]

			if priority >= entry.priority then
				do break end

				pos = i
			end

			orderedListeners[pos] = entry
		end

		orderedListeners[pos] = targetEntry
	elseif priority >= targetEntry.priority then
		local start = 1

		while orderedListeners[start] ~= targetEntry do
			start = start + 1
		end

		local pos = start

		for i = start + 1, count do
			local entry = orderedListeners[i]

			if priority < entry.priority then
				do break end

				pos = i
			end

			orderedListeners[pos] = entry
		end

		targetEntry.priority = priority
		orderedListeners[pos] = targetEntry
	else
		local start = count

		while orderedListeners[start] ~= targetEntry do
			start = start - 1
		end

		local pos = start

		for i = start - 1, 1, -1 do
			local entry = orderedListeners[i]

			if priority >= entry.priority then
				do break end

				pos = i
			end

			orderedListeners[pos] = entry
		end

		targetEntry.priority = priority
		orderedListeners[pos] = targetEntry
	end
end

function PrioritizedListeners:has(listener)
	return self._listenerRegistry[listener] ~= nil
end

function PrioritizedListeners:remove(listener)
	local targetEntry = self._listenerRegistry[listener]

	if targetEntry == nil or targetEntry.listener == nil then
		return
	end

	targetEntry.listener = nil
	self._listenerRegistry[listener] = nil
end

function PrioritizedListeners:fire(...)
	if self._firingList ~= nil then
		self._firingList = nil

		assert(false, "firingList need to be nil")
	end

	local firingList = self._orderedListeners

	self._firingList = firingList

	local invalidCount = 0

	for i = 1, #firingList do
		local entry = firingList[i]

		if entry.listener ~= nil then
			entry.listener(...)
		end

		if entry.listener == nil then
			invalidCount = invalidCount + 1
		end
	end

	self._firingList = nil

	if invalidCount > 0 then
		remove_if(self._orderedListeners, function(i, elem)
			return elem.listener == nil
		end)
	end
end
