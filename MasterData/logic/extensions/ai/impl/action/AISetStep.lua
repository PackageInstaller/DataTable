-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AISetStep.lua

module("logic.extensions.ai.impl.action.AISetStep", package.seeall)

local M = class("AISetStep", AINode)

function M:ctor(context)
	M.super.ctor(self, context)

	self._step = -99
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._step = aiConfigData.step
end

function M:onStart()
	M.super.onStart(self)
	self:getContext():setStep(self._step)

	return self:onEnd(AIConst.AIStatus.SUCCESS)
end

function M:handleEnd()
	return
end

function M:onReset()
	M.super.onReset(self)
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	M.super.onRecycle(self)

	self._step = -99
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._step = -99
end

return M
