-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/datastruct/OrderedMap.lua

module("logiccommon.common.datastruct.OrderedMap", package.seeall)

local OrderedMap = class("OrderedMap")

local function createNode(key, value)
	return {
		key = key,
		value = value
	}
end

function OrderedMap:ctor()
	self._map = {}
	self._count = 0
	self._iterating = false
	self._head = createNode(nil, nil)
	self._tail = createNode(nil, nil)
	self._head.next = self._tail
	self._tail.prev = self._head
end

function OrderedMap:count()
	return self._count
end

function OrderedMap:isEmpty()
	return self._count == 0
end

function OrderedMap:has(key)
	self:_checkKey(key)

	return self._map[key] ~= nil
end

function OrderedMap:get(key)
	self:_checkKey(key)

	local node = self._map[key]

	if node then
		return node.value
	else
		return nil
	end
end

function OrderedMap:put(key, value)
	self:_checkKey(key)
	self:_checkNotIterating()

	local existingNode = self._map[key]

	if existingNode then
		existingNode.value = value

		return existingNode.value
	else
		local node = createNode(key, value)

		self._map[key] = node

		self:_insertAtTail(node)

		self._count = self._count + 1

		return nil
	end
end

function OrderedMap:remove(key)
	self:_checkKey(key)
	self:_checkNotIterating()

	local node = self._map[key]

	if node then
		self._map[key] = nil

		self:_removeNode(node)

		self._count = self._count - 1

		return node.value
	else
		return nil
	end
end

function OrderedMap:clear()
	self:_checkNotIterating()

	self._map = {}
	self._count = 0
	self._head.next = self._tail
	self._tail.prev = self._head
end

function OrderedMap:front()
	if self:isEmpty() then
		return nil
	end

	local firstNode = self._head.next

	return firstNode.key, firstNode.value
end

function OrderedMap:back()
	if self:isEmpty() then
		return nil
	end

	local lastNode = self._tail.prev

	return lastNode.key, lastNode.value
end

function OrderedMap:popFront()
	self:_checkNotIterating()

	if self:isEmpty() then
		return nil
	end

	local firstNode = self._head.next
	local key, value = firstNode.key, firstNode.value

	self._map[key] = nil

	self:_removeNode(firstNode)

	self._count = self._count - 1

	return key, value
end

function OrderedMap:popBack()
	self:_checkNotIterating()

	if self:isEmpty() then
		return nil
	end

	local lastNode = self._tail.prev
	local key, value = lastNode.key, lastNode.value

	self._map[key] = nil

	self:_removeNode(lastNode)

	self._count = self._count - 1

	return key, value
end

function OrderedMap:keyList()
	local result = {}
	local index = 1
	local current = self._head.next

	while current ~= self._tail do
		result[index] = current.key
		index = index + 1
		current = current.next
	end

	return result
end

function OrderedMap:valueList()
	local result = {}
	local index = 1
	local current = self._head.next

	while current ~= self._tail do
		result[index] = current.value
		index = index + 1
		current = current.next
	end

	return result
end

function OrderedMap:traversal(callback)
	if not callback then
		return
	end

	self._iterating = true

	local index = 1
	local current = self._head.next

	while current ~= self._tail do
		callback(index, current.key, current.value)

		index = index + 1
		current = current.next
	end

	self._iterating = false
end

function OrderedMap:iter()
	local current = self._head.next
	local index = 1

	return function()
		if current == self._tail then
			return nil
		end

		local key, value = current.key, current.value

		current = current.next

		local currentIndex = index

		index = index + 1

		return currentIndex, key, value
	end
end

function OrderedMap:_insertAtTail(node)
	local prev = self._tail.prev

	prev.next = node
	node.prev = prev
	node.next = self._tail
	self._tail.prev = node
end

function OrderedMap:_removeNode(node)
	node.prev.next = node.next
	node.next.prev = node.prev
end

function OrderedMap:_checkNotIterating()
	if self._iterating then
		error("modification is not allowed during traversal")
	end
end

function OrderedMap:_checkKey(key)
	if key == nil then
		error("key cannot be nil")
	end
end

return OrderedMap
