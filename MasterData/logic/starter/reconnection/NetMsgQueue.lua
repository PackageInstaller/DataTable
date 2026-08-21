-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/starter/reconnection/NetMsgQueue.lua

module("logic.starter.reconnection.NetMsgQueue", package.seeall)

local NetMsgQueue = class("NetMsgQueue")

local function createNode()
	return {}
end

local function resetNode(node)
	node.data = false
	node.extId = false
	node.cmd = false
	node._next = false
end

local kMsgPool

function NetMsgQueue:ctor()
	if not kMsgPool then
		kMsgPool = ObjectPool.New(20, createNode, nil, resetNode)
	end

	self._head = false
	self._tail = false
	self._size = 0
end

function NetMsgQueue:isEmpty()
	return self._size <= 0
end

function NetMsgQueue:getSize()
	return self._size
end

function NetMsgQueue:peekFirstNode()
	if self:isEmpty() then
		return false
	end

	return self._head
end

function NetMsgQueue:enqueue(extId, cmd, data)
	local node = kMsgPool:fetchObject()

	node.data = data
	node.extId = extId
	node.cmd = cmd

	if not self._head then
		self._head = node
		self._tail = node
	else
		self._tail._next = node
		self._tail = node
	end

	self._size = self._size + 1
end

function NetMsgQueue:dequeue()
	if self:isEmpty() then
		return false
	end

	local node = self._head
	local data = node.data

	self._head = self._head._next
	self._size = self._size - 1

	if self:isEmpty() then
		self._tail = false
	end

	kMsgPool:returnObject(node)

	return data
end

function NetMsgQueue:clear()
	if self:isEmpty() then
		return
	end

	local node = self._head

	while node do
		local nextNode = node._next

		kMsgPool:returnObject(node)

		node = nextNode
	end

	self._head = false
	self._tail = false
	self._size = 0
end

return NetMsgQueue
