-- chunkname: @/tmp/or_script/lua_compile/foundation/containers/Queue.lua

local function class(name)
	local cls = {}

	function cls:new(...)
		local obj = setmetatable({}, {
			__index = self
		})

		obj:initialize(...)

		return obj
	end

	return cls
end

Queue = class("Queue")

function Queue:initialize()
	self._size = 0
	self._elements = {}
end

function Queue:size()
	return self._size
end

function Queue:pushBack(elem)
	self._size = self._size + 1
	self._elements[self._size] = elem
end

function Queue:popFront()
	if self._size == 0 then
		return nil
	end

	self._size = self._size - 1

	return table.remove(self._elements, 1)
end

function Queue:front()
	if self._size == 0 then
		return nil
	end

	return self._elements[1]
end

function Queue:remove(elem, equalFn)
	local elements = self._elements

	if equalFn ~= nil then
		for i = 1, self._size do
			if equalFn(elements[i], elem) then
				self._size = self._size - 1

				return table.remove(elements, i)
			end
		end
	else
		for i = 1, self._size do
			if elements[i] == elem then
				self._size = self._size - 1

				return table.remove(elements, i)
			end
		end
	end
end

PriorityQueue = class("PriorityQueue")

function PriorityQueue:initialize()
	self._size = 0
	self._sorted = {}
end

function PriorityQueue:size()
	return self._size
end

function PriorityQueue:insert(elem, priority)
	local count = self._size
	local new = {
		value = elem,
		priority = priority
	}

	self._sorted[count + 1] = new
	self._size = count + 1

	for i = count, 1, -1 do
		where = i

		local cur = self._sorted[i]

		if priority >= cur.priority then
			break
		end

		self._sorted[i] = new
		self._sorted[i + 1] = cur
	end
end

function PriorityQueue:popFront()
	if self._size == 0 then
		return nil
	end

	self._size = self._size - 1

	local a = table.remove(self._sorted, 1)

	return a and a.value
end

function PriorityQueue:front()
	local a = self._sorted[1]

	return a and a.value
end
