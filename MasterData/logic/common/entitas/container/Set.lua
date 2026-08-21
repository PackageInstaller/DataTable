-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/container/Set.lua

module("logic.common.entitas.container.Set", package.seeall)

local tableinsert = table.insert
local pairs = pairs
local M = {}

M.__index = M

function M.New(isweak)
	local t = {}

	t._data = {}
	t._size = 0

	if isweak then
		setmetatable(t._data, {
			__mode = "k"
		})
	end

	setmetatable(t, M)

	return t
end

function M:insert(value)
	if not self._data[value] then
		self._data[value] = true
		self._size = self._size + 1

		return true
	end

	return false
end

function M:remove(value)
	if self._data[value] then
		self._data[value] = nil
		self._size = self._size - 1

		return value
	end

	return false
end

function M:size()
	return self._size
end

function M:has(value)
	return self._data[value]
end

function M:foreach(f, ...)
	for k, v in pairs(self._data) do
		if v then
			f(k, ...)
		end
	end
end

function M:at(pos)
	local n = 0

	for k, _ in pairs(self._data) do
		n = n + 1

		if n == pos then
			return k
		end
	end

	return nil
end

function M:get_buffer()
	local ret = {}

	for k, _ in pairs(self._data) do
		tableinsert(ret, k)
	end

	return ret
end

function M:clear()
	for k, _ in pairs(self._data) do
		self._data[k] = nil
	end

	self._size = 0
end

return M
