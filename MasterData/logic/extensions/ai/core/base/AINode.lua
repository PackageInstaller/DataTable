-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/base/AINode.lua

module("logic.extensions.ai.core.base.AINode", package.seeall)

local AINode = class("AINode", AbstractGlobalReusable)

function AINode:ctor(context)
	self._context = context
	self._status = AIConst.AIStatus.INACTIVE
	self._parent = nil
	self._childrenIndex = -1
	self._aiTag = ""
	self._errorStrName = ""
end

function AINode:getCapacity()
	return 9999
end

function AINode:initFromConfig(aiConfigData)
	self._aiTag = aiConfigData.aiTag or ""
end

function AINode:getContext()
	return self._context
end

function AINode:getStatus()
	return self._status
end

function AINode:setParent(parent)
	self._parent = parent
end

function AINode:getParent()
	return self._parent
end

function AINode:onStart()
	self._status = AIConst.AIStatus.RUNNING

	return self
end

function AINode:onEnd(status)
	if status == nil then
		printError(string.format("the param['status'] of method['onEnd'] is nil in class[%s]", tostring(self)))
	end

	self._status = status

	self:handleEnd()

	local returnNode = self

	if self:getParent() then
		returnNode = self:getParent():onChildEnd(self)
	end

	return returnNode
end

function AINode:handleEnd()
	return
end

function AINode:handleInterrupt()
	return
end

function AINode:canInterrupt()
	return true
end

function AINode:interruptWithoutReport()
	if self._status == AIConst.AIStatus.RUNNING and self:canInterrupt() then
		self:onInterruptWithoutReport()

		return true
	end

	return false
end

function AINode:onInterruptWithoutReport()
	self._status = AIConst.AIStatus.INACTIVE

	self:handleInterrupt()
	self:handleEnd()
end

function AINode:interrupt(status)
	status = status or AIConst.AIStatus.FAILD

	if not status or status ~= AIConst.AIStatus.FAILD and status ~= AIConst.AIStatus.SUCCESS then
		printError(string.format("interrupt status error [%s]", tostring(status)))

		return false, nil
	end

	if self._status == AIConst.AIStatus.RUNNING and self:canInterrupt() then
		return true, self:onInterrupt(status)
	end

	return false, nil
end

function AINode:onInterrupt(status)
	self._status = status

	self:handleInterrupt()

	return self:onEnd(status)
end

function AINode:onUpdate()
	local errorStr = tostring(self.class)

	if self._errorStrName ~= errorStr then
		printError(string.format("no implement exception or logic error in class [%s]", errorStr))
	end

	self._errorStrName = errorStr
end

function AINode:getChildrenIndex()
	return self._childrenIndex
end

function AINode:onReset()
	self._status = AIConst.AIStatus.INACTIVE
	self._errorStrName = ""
end

function AINode:reuse(context)
	self:onReuse(context)
end

function AINode:onReuse(context)
	self._context = context
end

function AINode:reset()
	self:onRecycle()
end

function AINode:onRecycle()
	self._status = AIConst.AIStatus.INACTIVE
	self._context = nil
	self._errorStrName = ""
	self._childrenIndex = nil
	self._parent = nil
end

function AINode:destroy()
	self:onDestroy()
end

function AINode:onDestroy()
	self._status = nil
	self._context = nil
	self._childrenIndex = nil
	self._parent = nil
	self._errorStrName = nil
end

return AINode
