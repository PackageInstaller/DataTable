-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/datastruct/Queue.lua

module("logiccommon.common.datastruct.Queue", package.seeall)

local Queue = class("Queue")

function Queue:ctor()
	self._first = 1
	self._last = 0
	self._queue = {}
end

function Queue:count()
	return self._last - self._first + 1
end

function Queue:peek()
	if self:count() <= 0 then
		return
	end

	return self._queue[self._first]
end

function Queue:dequeue()
	if self:count() <= 0 then
		return
	end

	self._queue[self._first] = nil
	self._first = self._first + 1

	return self._queue[self._first]
end

function Queue:enqueue(value)
	self._last = self._last + 1
	self._queue[self._last] = value
end

function Queue:clear()
	self._first = 1
	self._last = 0
	self._queue = {}
end

function Queue:traversal(_callBack)
	if not _callBack or self._last < self._first then
		return
	end

	for i = self._first, self._last do
		_callBack(i - self._first + 1, self._queue[i])
	end
end

return Queue
