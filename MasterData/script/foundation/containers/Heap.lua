-- chunkname: @/tmp/or_script/lua_compile/foundation/containers/Heap.lua

local Heap = {}

function Heap:new(...)
	local obj = setmetatable({}, {
		__index = self
	})

	obj:initialize(...)

	return obj
end

function Heap:initialize(compare)
	self._compare = compare or function(a, b)
		return a < b
	end
	self._size = 0
	self._elements = {}
end

function Heap:size()
	return self._size
end

function Heap:isEmpty()
	return self._size == 0
end

function Heap:insert(elem)
	self._size = self._size + 1
	self._elements[self._size] = elem

	self:_shiftUp(self._size)
end

function Heap:fetchTop()
	if self._size == 0 then
		return nil
	end

	return self._elements[1]
end

function Heap:popTop()
	if self._size == 0 then
		return nil
	end

	local elem = self._elements[1]

	self._elements[1] = self._elements[self._size]
	self._elements[self._size] = nil
	self._size = self._size - 1

	self:_shiftDown(1)

	return elem
end

function Heap:_shiftUp(index)
	local parent = (index - index % 2) / 2

	if parent == 0 then
		return
	end

	local elem = self._elements[index]
	local upper = self._elements[parent]

	if self._compare(upper, elem) then
		return
	end

	self._elements[index], self._elements[parent] = upper, elem

	self:_shiftUp(parent)
end

function Heap:_shiftDown(index)
	if index >= self._size then
		return
	end

	local left = index * 2

	if left > self._size then
		return
	end

	local child = left
	local down = self._elements[left]
	local right = left + 1

	if right <= self._size then
		local down2 = self._elements[right]

		if self._compare(down2, down) then
			child = right
			down = down2
		end
	end

	local elem = self._elements[index]

	if self._compare(elem, down) then
		return
	end

	self._elements[index], self._elements[child] = down, elem

	self:_shiftDown(child)
end

_G.Heap = Heap
