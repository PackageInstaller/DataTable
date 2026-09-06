-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/datastruct/CircularQueue.lua

module("logiccommon.common.datastruct.CircularQueue", package.seeall)

local CircularQueue = class("CircularQueue")

function CircularQueue:ctor(maxSize)
	self._maxSize = maxSize
	self._queue = {}
	self._head = 0
	self._tail = 0
	self._count = 0
end

function CircularQueue:count()
	return self._count
end

function CircularQueue:isEmpty()
	return self._count == 0
end

function CircularQueue:resize(newSize)
	local newQueue = {}

	for i = 0, self._count - 1 do
		newQueue[i] = self._queue[(self._head + i) % self._maxSize]
	end

	self._queue = newQueue
	self._head = 0
	self._tail = self._count
	self._maxSize = newSize
end

function CircularQueue:pushFront(value)
	if self:isFull() then
		self._head = (self._head - 1 + self._maxSize) % self._maxSize
		self._queue[self._head] = value
	else
		self._head = (self._head - 1 + self._maxSize) % self._maxSize
		self._queue[self._head] = value
		self._count = self._count + 1
	end
end

function CircularQueue:pushBack(value)
	if self:isFull() then
		self._queue[self._tail] = value
		self._head = (self._head + 1) % self._maxSize
	else
		self._queue[self._tail] = value
		self._tail = (self._tail + 1) % self._maxSize
		self._count = self._count + 1
	end
end

function CircularQueue:popFront()
	if self:isEmpty() then
		return nil
	end

	self._queue[self._head] = nil
	self._head = (self._head + 1) % self._maxSize
	self._count = self._count - 1

	return self._queue[self._head]
end

function CircularQueue:popBack()
	if self:isEmpty() then
		return nil
	end

	local backIndex = (self._tail - 1 + self._maxSize) % self._maxSize

	self._queue[backIndex] = nil
	self._tail = backIndex
	self._count = self._count - 1

	return self._queue[backIndex]
end

function CircularQueue:peekFront()
	if not self:isEmpty() then
		return self._queue[self._head]
	end
end

function CircularQueue:peekBack()
	if not self:isEmpty() then
		return self._queue[self._tail]
	end
end

function CircularQueue:traverse(callback)
	if not callback then
		return
	end

	for i = 0, self._count - 1 do
		local index = (self._head + i) % self._maxSize

		callback(i + 1, self._queue[index])
	end
end

function CircularQueue:traverseReverse(callback)
	if not callback then
		return
	end

	for i = self._count - 1, 0, -1 do
		local index = (self._tail - 1 - i + self._maxSize) % self._maxSize

		callback(i + 1, self._queue[index])
	end
end

function CircularQueue:clear()
	self._head = 0
	self._tail = 0
	self._count = 0

	for k, v in pairs(self._queue) do
		self._queue[k] = nil
	end
end

function CircularQueue:isFull()
	return self._count >= self._maxSize
end

return CircularQueue
