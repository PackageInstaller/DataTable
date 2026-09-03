-- chunkname: @/tmp/or_script/lua_compile/dragon/misc/Signal.lua

Signal = class("Signal")

function Signal:initialize(id)
	super.initialize(self)

	self._id = id
	self._listeners = {}
	self._nextOrder = 1
end

function Signal:nextOrder()
	local ret = self._nextOrder

	self._nextOrder = ret + 1

	return ret
end

local function private_addListener(self, listener, oneshot, priority)
	local nPriority = priority or 0
	local info = self._listeners[listener]

	if info ~= nil then
		assert(info.listener == listener)

		info.oneshot = oneshot
		info.order = self:nextOrder()
		info.priority = nPriority
		self._sortedListeners = nil

		return listener
	else
		self._listeners[listener] = {
			listener = listener,
			priority = nPriority,
			oneshot = oneshot,
			order = self:nextOrder()
		}
		self._sortedListeners = nil

		return listener
	end
end

local function private_buildSortedListenerList(self)
	local unsorted = self._listeners
	local sorted = {}
	local i = 0

	for _, info in pairs(unsorted) do
		i = i + 1
		sorted[i] = info
	end

	table.sort(sorted, function(a, b)
		return a.priority < b.priority or a.priority == b.priority and a.order < b.order
	end)

	return sorted
end

local function private_cleanInvalidListeners(self)
	if self._sortedListeners == nil then
		return
	end

	for i = #self._sortedListeners, 1, -1 do
		local info = self._sortedListeners[i]

		if self._listeners[info.listener] == nil then
			table.remove(self._sortedListeners, i)
		end
	end
end

local function private_doDispatch(self, ...)
	self._swallowed = false

	local invalidCnt = 0
	local listeners = self._sortedListeners

	for i, info in ipairs(listeners) do
		local listener = info.listener

		if self._listeners[listener] ~= nil then
			if info.oneshot then
				self._listeners[listener] = nil
				invalidCnt = invalidCnt + 1
			end

			info.listener(self, ...)

			if self:isSwallowed() then
				break
			end
		else
			invalidCnt = invalidCnt + 1
		end
	end

	return invalidCnt
end

function Signal:getSignalId()
	return self._id
end

function Signal:add(listener, priority, oneshot)
	return private_addListener(self, listener, oneshot, priority or 0)
end

function Signal:addOnce(listener, priority)
	return private_addListener(self, listener, true, priority or 0)
end

function Signal:hasListener(listener)
	if listener == nil then
		return false
	end

	return self._listeners[listener] ~= nil
end

function Signal:remove(listener)
	if listener ~= nil then
		self._listeners[listener] = nil
	end
end

function Signal:removeAll()
	self._listeners = {}
end

function Signal:swallow()
	self._swallowed = true
end

function Signal:isSwallowed()
	return self._swallowed
end

function Signal:dispatch(...)
	if self._listeners == nil or next(self._listeners) == nil then
		return
	end

	if self._sortedListeners == nil then
		self._sortedListeners = private_buildSortedListenerList(self)
	end

	local invalidCnt = private_doDispatch(self, ...)

	if invalidCnt > 0 then
		private_cleanInvalidListeners(self)
	end
end
