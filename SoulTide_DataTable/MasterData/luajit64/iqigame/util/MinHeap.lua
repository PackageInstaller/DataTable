-- chunkname: @IQIGame\\Util\\MinHeap.lua

local TablePool = require("IQIGame.Util.TablePool")
local MinHeap = {}

MinHeap.__index = MinHeap

function MinHeap.new()
	return setmetatable({
		size = 0,
		heap = {},
		tPool = TablePool.New()
	}, MinHeap)
end

function MinHeap:parent(i)
	return math.floor(i / 2)
end

function MinHeap:left(i)
	return 2 * i
end

function MinHeap:right(i)
	return 2 * i + 1
end

function MinHeap:insert(key, value)
	self.size = self.size + 1

	local t = self.tPool:Obtain()

	t.key = key
	t.value = value
	self.heap[self.size] = t

	self:decrease_key(self.size, value)
end

function MinHeap:minimum()
	return self.heap[1]
end

function MinHeap:extract_min()
	if self.size < 1 then
		error("heap underflow")
	end

	local min = self.heap[1]

	self.heap[1] = self.heap[self.size]
	self.size = self.size - 1

	self:min_heapify(1)

	return min
end

function MinHeap:decrease_key(i, key)
	if key > self.heap[i].value then
		error("new key is larger than current key")
	end

	self.heap[i].value = key

	while i > 1 and self.heap[self:parent(i)].value > self.heap[i].value do
		self.heap[i], self.heap[self:parent(i)] = self.heap[self:parent(i)], self.heap[i]
		i = self:parent(i)
	end
end

function MinHeap:min_heapify(i)
	local l = self:left(i)
	local r = self:right(i)
	local smallest

	if l <= self.size and self.heap[l].value < self.heap[i].value then
		smallest = l
	else
		smallest = i
	end

	if r <= self.size and self.heap[r].value < self.heap[smallest].value then
		smallest = r
	end

	if smallest ~= i then
		self.heap[i], self.heap[smallest] = self.heap[smallest], self.heap[i]

		self:min_heapify(smallest)
	end
end

function MinHeap:clear()
	for i, v in pairs(self.heap) do
		self.tPool:Release(v)

		self.heap[i] = nil
	end

	self.size = 0
end

return MinHeap
