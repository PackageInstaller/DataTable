-- chunkname: @IQIGame\\Util\\TablePool.lua

local TablePool = {
	size = 0,
	maxSize = 20,
	_stack = {}
}

TablePool.__index = TablePool

function TablePool.New(size)
	size = size or 20

	return setmetatable({
		size = 0,
		_stack = {},
		maxSize = size
	}, TablePool)
end

function TablePool:Obtain()
	if self.size > 0 then
		local t = self._stack[self.size]

		self._stack[self.size] = nil
		self.size = self.size - 1

		return t
	end

	return {}
end

function TablePool:Release(t)
	if self.size >= self.maxSize then
		return
	end

	for i, _ in pairs(t) do
		t[i] = nil
	end

	self._stack[self.size + 1] = t
	self.size = self.size + 1
end

return TablePool
