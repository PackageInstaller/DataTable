-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/container/Array.lua

module("logic.common.entitas.container.Array", package.seeall)

local M = {}

M.__index = M

function M.New(isweak)
	local t = {}

	t._cur = 0
	t._data = {}

	if isweak then
		setmetatable(t._data, {
			__mode = "v"
		})
	end

	setmetatable(t, M)

	return t
end

function M:push(value)
	self._cur = self._cur + 1
	self._data[self._cur] = value
end

function M:pop()
	assert(self._cur > 0, "array:attemp pop empty table")

	self._cur = self._cur - 1

	return self._data[self._cur + 1]
end

function M:clear()
	self._cur = 0
end

function M:size()
	return self._cur
end

function M:data()
	return self._data
end

function M:foreach(f)
	for i = 1, self._cur do
		f(self._data[i])
	end
end

return M
