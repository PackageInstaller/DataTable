-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/compose/AICondition.lua

module("logic.extensions.ai.core.compose.AICondition", package.seeall)

local AICondition = class("AICondition", AIParentNode)

function AICondition:ctor(context)
	AICondition.super.ctor(self, context)

	self._useChildResult = false
end

function AICondition:initFromConfig(aiConfigData)
	AICondition.super.initFromConfig(self, aiConfigData)

	self._useChildResult = aiConfigData.useChildResult
end

function AICondition:onStart()
	AICondition.super.onStart(self)

	return self:getChildAt(1):onStart()
end

function AICondition:onChildEnd(child)
	if child == self:getChildAt(1) then
		if child:getStatus() == AIConst.AIStatus.FAILD then
			return self:getChildAt(3):onStart()
		end

		return self:getChildAt(2):onStart()
	elseif child == self:getChildAt(2) or child == self:getChildAt(3) then
		if self._useChildResult and child:getStatus() == AIConst.AIStatus.FAILD then
			return self:onEnd(AIConst.AIStatus.FAILD)
		end

		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self:onEnd(AIConst.AIStatus.SUCCESS)
end

function AICondition:handleEnd()
	return
end

function AICondition:onReset()
	AICondition.super.onReset(self)
end

function AICondition:onReuse(context)
	AICondition.super.onReuse(self, context)
end

function AICondition:onRecycle()
	AICondition.super.onRecycle(self)

	self._useChildResult = false
end

function AICondition:onDestroy()
	AICondition.super.onDestroy(self)

	self._useChildResult = false
end

return AICondition
