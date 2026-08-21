-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/decorator/AICoolingDown.lua

module("logic.extensions.ai.core.decorator.AICoolingDown", package.seeall)

local AICoolingDown = class("AICoolingDown", AIParentNode)

function AICoolingDown:ctor(context)
	AICoolingDown.super.ctor(self, context)

	self._cdTime = 0
	self._coolingDownEndTime = 0
	self._isFirst = true
end

function AICoolingDown:initFromConfig(aiConfigData)
	AICoolingDown.super.initFromConfig(self, aiConfigData)

	self._cdTime = aiConfigData.time
end

function AICoolingDown:onStart()
	AICoolingDown.super.onStart(self)

	if self._isFirst then
		self._isFirst = false
		self._coolingDownEndTime = Time.time + self._cdTime

		return self:getFirstChild():onStart()
	elseif self._coolingDownEndTime > Time.time then
		return self:onEnd(AIConst.AIStatus.FAILD)
	else
		self._coolingDownEndTime = Time.time + self._cdTime

		return self:getFirstChild():onStart()
	end
end

function AICoolingDown:onChildEnd(child)
	if child:getStatus() == AIConst.AIStatus.FAILD then
		return self:onEnd(AIConst.AIStatus.FAILD)
	else
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end
end

function AICoolingDown:onReset()
	AICoolingDown.super.onReset(self)

	self._coolingDownEndTime = 0
	self._isFirst = true
end

function AICoolingDown:onReuse(context)
	AICoolingDown.super.onReuse(self, context)
end

function AICoolingDown:onRecycle()
	AICoolingDown.super.onRecycle(self)

	self._coolingDownEndTime = 0
	self._cdTime = 0
	self._isFirst = true
end

function AICoolingDown:onDestroy()
	AICoolingDown.super.onDestroy(self)

	self._coolingDownEndTime = nil
	self._cdTime = nil
	self._isFirst = nil
end

return AICoolingDown
