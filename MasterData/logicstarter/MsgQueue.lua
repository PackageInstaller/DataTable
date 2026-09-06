-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicstarter/starter/reconnection/MsgQueue.lua

module(..., package.seeall)

local MsgQueue = class("MsgQueue")

function MsgQueue._poolCreateFunc()
	return {}
end

function MsgQueue._poolDisposeFunc(entry)
	return
end

function MsgQueue._poolResetFunc(entry)
	entry.data = nil
	entry.extId = nil
	entry.cmd = nil
	entry._next = nil
end

MsgQueue._pool = nil

function MsgQueue:ctor()
	MsgQueue._pool = MsgQueue._pool or ObjectPool.New(20, MsgQueue._poolCreateFunc, MsgQueue._poolDisposeFunc, MsgQueue._poolResetFunc)
	self._pool = MsgQueue._pool

	local headNode = self._pool:fetchObject()

	self._head = headNode
	self._tail = headNode
	self._count = 0
end

function MsgQueue:enqueue(extId, cmd, data)
	local node = self._pool:fetchObject()

	node.data = data
	node.extId = extId
	node.cmd = cmd
	self._tail._next = node
	self._tail = node
end

function MsgQueue:first()
	if self._head == self._tail then
		return nil
	end

	local first = self._head._next

	return first.extId, first.cmd, first.data
end

function MsgQueue:dequeue()
	if self._head == self._tail then
		return nil
	end

	local first = self._head._next

	if self._head._next == self._tail then
		self._tail = self._head
		self._head._next = nil
	else
		self._head._next = first._next
	end

	self._pool:returnObject(first)
end

function MsgQueue:remove(extId, cmd)
	if self._head == self._tail then
		return false
	end

	local cur = self._head._next
	local pre

	while cur do
		if cur.extId == extId and cur.cmd == cmd then
			if pre then
				pre._next = cur._next

				if not pre._next then
					self._tail = pre
				end

				self._pool:returnObject(cur)
			else
				self:dequeue()
			end

			return true
		end

		pre = cur
		cur = cur._next
	end

	return false
end

function MsgQueue:isInQueue(extId, cmd)
	local cur = self._head._next

	while cur do
		if cur.extId == extId and cur.cmd == cmd then
			return true
		end

		cur = cur._next
	end

	return false
end

function MsgQueue:traverse(fn)
	local cur = self._head._next

	while cur do
		fn(cur.extId, cur.cmd, cur.data)

		cur = cur._next
	end
end

function MsgQueue:dumpMsg()
	printInfo(LogTag.NETWORK, "MsgQueue_dumpMsg===========start=============")

	local cur = self._head._next

	while cur do
		printInfo(string.format("%s MsgQueue_dumpMsg,extId=%s,cmd=%s", LogTag.NETWORK, cur.extId, cur.cmd))

		cur = cur._next
	end

	printInfo(LogTag.NETWORK, "MsgQueue_dumpMsg===========end=============")
end

function MsgQueue:contain(extId, cmd)
	local cur = self._head._next

	while cur do
		if cur.extId == extId and cur.cmd == cmd then
			return true
		end

		cur = cur._next
	end

	return false
end

function MsgQueue:clear()
	local cur = self._head._next

	while cur do
		if cur == self._head then
			printWarn(LogTag.NETWORK .. "MsgQueue clear error")
		end

		local n = cur._next

		self._pool:returnObject(cur)

		cur = n
	end

	self._head._next = nil
	self._tail = self._head
end

return MsgQueue
