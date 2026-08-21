-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/compose/AIParallelSequence.lua

module("logic.extensions.ai.core.compose.AIParallelSequence", package.seeall)

local AIParallelSequence = class("AIParallelSequence", AIParentNode)

function AIParallelSequence:ctor(context)
	AIParallelSequence.super.ctor(self, context)

	self._finishedCount = 0
	self._runningList = {}
	self._runningListTmp = {}
end

function AIParallelSequence:onStart()
	AIParallelSequence.super.onStart(self)

	self._finishedCount = 0

	self:resetRunningList()

	local retNode = false

	for _, child in ipairs(self:getChildren()) do
		local node = child:onStart()

		if self:getStatus() == AIConst.AIStatus.RUNNING then
			if node then
				table.insert(self._runningListTmp, node)
			end
		else
			retNode = node

			break
		end
	end

	return retNode or self
end

function AIParallelSequence:resetRunningList()
	table.clear(self._runningList)
	table.clear(self._runningListTmp)
end

function AIParallelSequence:SwapRunningList()
	local tmp = self._runningList

	self._runningList = self._runningListTmp
	self._runningListTmp = tmp

	table.clear(self._runningListTmp)
end

function AIParallelSequence:onUpdate()
	self:SwapRunningList()

	local retNode = false

	for _, child in ipairs(self._runningList) do
		local node = child:onUpdate()

		if self:getStatus() == AIConst.AIStatus.RUNNING then
			if node then
				table.insert(self._runningListTmp, node)
			end
		else
			retNode = node

			break
		end
	end

	return retNode or self
end

function AIParallelSequence:onChildEnd(child)
	if child:getStatus() == AIConst.AIStatus.SUCCESS then
		self._finishedCount = self._finishedCount + 1

		local children = self:getChildren()

		if self._finishedCount == #children then
			return self:onEnd(AIConst.AIStatus.SUCCESS)
		end
	else
		return self:onEnd(AIConst.AIStatus.FAILD)
	end
end

function AIParallelSequence:handleEnd()
	self:resetRunningList()
end

function AIParallelSequence:onReset()
	AIParallelSequence.super.onReset(self)
	self:resetRunningList()

	self._finishedCount = 0
end

function AIParallelSequence:onReuse(context)
	AIParallelSequence.super.onReuse(self, context)
	self:resetRunningList()
end

function AIParallelSequence:onRecycle()
	AIParallelSequence.super.onRecycle(self)

	self._finishedCount = 0

	self:resetRunningList()
end

function AIParallelSequence:onDestroy()
	AIParallelSequence.super.onDestroy(self)

	self._finishedCount = nil
	self._runningList = nil
	self._runningListTmp = nil
end

return AIParallelSequence
