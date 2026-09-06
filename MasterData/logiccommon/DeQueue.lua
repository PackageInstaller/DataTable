-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/datastruct/DeQueue.lua

module("logiccommon.common.datastruct.DeQueue", package.seeall)

local DeQueue = class("DeQueue")

function DeQueue:ctor()
	self._first = 0
	self._last = -1
	self._deque = {}
end

function DeQueue:count()
	return self._last - self._first + 1
end

function DeQueue:isEmpty()
	return self:count() == 0
end

function DeQueue:pushFront(value)
	self._first = self._first - 1
	self._deque[self._first] = value
end

function DeQueue:pushBack(value)
	self._last = self._last + 1
	self._deque[self._last] = value
end

function DeQueue:popFront()
	if self:isEmpty() then
		return nil
	end

	self._deque[self._first] = nil
	self._first = self._first + 1

	return self._deque[self._first]
end

function DeQueue:popBack()
	if self:isEmpty() then
		return nil
	end

	self._deque[self._last] = nil
	self._last = self._last - 1

	return self._deque[self._last]
end

function DeQueue:peekFront()
	if self:isEmpty() then
		return nil
	end

	return self._deque[self._first]
end

function DeQueue:peekBack()
	if self:isEmpty() then
		return nil
	end

	return self._deque[self._last]
end

function DeQueue:contains(value)
	for i = self._first, self._last do
		if self._deque[i] == value then
			return true
		end
	end

	return false
end

function DeQueue:clear()
	self._first = 0
	self._last = -1
	self._deque = {}
end

function DeQueue:traversal(_callBack)
	if not _callBack or self._last < self._first then
		return
	end

	for i = self._first, self._last do
		_callBack(i - self._first + 1, self._deque[i])
	end
end

return DeQueue
