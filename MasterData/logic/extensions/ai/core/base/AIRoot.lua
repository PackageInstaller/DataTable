-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/base/AIRoot.lua

module("logic.extensions.ai.core.base.AIRoot", package.seeall)

local AIRoot = class("AIRoot", AIParentNode)

function AIRoot:ctor(context)
	AIRoot.super.ctor(self, context)

	self._currentAI = nil
	self._isStartup = false
	self._name = nil
	self._strErrorAI = ""
end

function AIRoot:getName()
	return self._name
end

function AIRoot:setName(v)
	self._name = v

	return self
end

function AIRoot:onStart()
	if self:getStatus() == AIConst.AIStatus.INACTIVE then
		self._isStartup = true

		AIRoot.super.onStart(self)

		self._currentAI = self:getFirstChild():onStart()
	else
		printError(string.format("the ai[%s] has actived!", tostring(self._currentAI)))
	end

	return self
end

function AIRoot:onUpdate()
	if self._currentAI:getStatus() == AIConst.AIStatus.RUNNING then
		self._currentAI = self._currentAI:onUpdate()

		return self
	else
		local aiStr = tostring(self._currentAI)

		if self._strErrorAI ~= aiStr then
			printError(string.format("the ai[%s] class[%s] tag[%s] has finished!", aiStr, self._currentAI.__cname, self._currentAI._aiTag))
		end

		self._strErrorAI = aiStr
	end

	return self
end

function AIRoot:tick()
	if self._isStartup then
		self:onUpdate()
	else
		self:onStart()
	end
end

function AIRoot:interrupt()
	if self._isStartup then
		self:onReset()
	end
end

function AIRoot:interruptNode(node, status)
	if node then
		if node == self then
			return false
		end

		local isSucc, curNode = node:interrupt(status)

		if isSucc then
			self._currentAI = curNode
		end

		return false
	end

	return false
end

function AIRoot:onChildEnd(child)
	return self:onEnd(child:getStatus())
end

function AIRoot:onReset()
	local context = self:getContext()

	AIRoot.super.onReset(self)

	if context then
		context:onReset()
	end

	self._currentAI = nil
	self._isStartup = false
	self._strErrorAI = ""
end

function AIRoot:onReuse(context)
	AIRoot.super.onReuse(self, context)

	self._currentAI = nil
	self._isStartup = false
end

function AIRoot:onRecycle()
	local context = self:getContext()

	AIRoot.super.onRecycle(self)

	if context then
		context:returnSelf()
	end

	self._currentAI = nil
	self._isStartup = false
	self._strErrorAI = ""
end

function AIRoot:onDestroy()
	AIRoot.super.onDestroy(self)

	self._currentAI = nil
	self._isStartup = nil
	self._strErrorAI = nil
end

return AIRoot
