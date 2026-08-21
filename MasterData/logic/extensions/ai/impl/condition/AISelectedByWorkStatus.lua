-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/condition/AISelectedByWorkStatus.lua

module("logic.extensions.ai.impl.condition.AISelectedByWorkStatus", package.seeall)

local M = class("AISelectedByWorkStatus", AINode)

function M:ctor(context)
	M.super.ctor(self, context)

	self._workStatus = 0
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._workStatus = aiConfigData.status
end

function M:onStart()
	M.super.onStart(self)

	local unit = self:getContext():getUnit()

	if unit.scheduleModel:getCurWorkStatus() == self._workStatus then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self:onEnd(AIConst.AIStatus.FAILD)
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

	self._workStatus = 0
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._workStatus = 0
end

return M
