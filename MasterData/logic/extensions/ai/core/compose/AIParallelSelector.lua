-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/compose/AIParallelSelector.lua

module("logic.extensions.ai.core.compose.AIParallelSelector", package.seeall)

local M = class("AIParallelSelector", AIParentNode)

function M:ctor(context)
	M.super.ctor(self, context)

	self._finishedCount = 0
	self._runningList = {}
	self._runningListTmp = {}
end

function M:onStart()
	M.super.onStart(self)

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

function M:resetRunningList()
	table.clear(self._runningList)
	table.clear(self._runningListTmp)
end

function M:SwapRunningList()
	local tmp = self._runningList

	self._runningList = self._runningListTmp
	self._runningListTmp = tmp

	table.clear(self._runningListTmp)
end

function M:onUpdate()
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

function M:onChildEnd(child)
	if child:getStatus() == AIConst.AIStatus.FAILD then
		self._finishedCount = self._finishedCount + 1

		local children = self:getChildren()

		if self._finishedCount == #children then
			return self:onEnd(AIConst.AIStatus.FAILD)
		end
	else
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end
end

function M:handleEnd()
	self:resetRunningList()
end

function M:onReset()
	M.super.onReset(self)
	self:resetRunningList()

	self._finishedCount = 0
end

function M:onReuse(context)
	M.super.onReuse(self, context)
	self:resetRunningList()
end

function M:onRecycle()
	M.super.onRecycle(self)

	self._finishedCount = 0

	self:resetRunningList()
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._finishedCount = nil
	self._runningList = nil
	self._runningListTmp = nil
end

return M
