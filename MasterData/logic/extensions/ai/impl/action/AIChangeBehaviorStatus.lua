-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIChangeBehaviorStatus.lua

module("logic.extensions.ai.impl.action.AIChangeBehaviorStatus", package.seeall)

local M = class("AIChangeBehaviorStatus", AINode)
local BehaviorStatus = HouseEnum.BehaviorStatus

function M:ctor(context)
	M.super.ctor(self, context)

	self._behaviorStatus = BehaviorStatus.None
	self._isClear = false
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._behaviorStatus = aiConfigData.behaviorStatus
	self._isClear = aiConfigData.isClear
end

function M:onStart()
	M.super.onStart(self)

	local unit = self:getContext():getUnit()

	if self._isClear then
		unit.model:clearBehaviorStatus(self._behaviorStatus)
	else
		unit.model:setBehaviorStatus(self._behaviorStatus)
	end

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

	self._behaviorStatus = BehaviorStatus.None
	self._isClear = false
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._behaviorStatus = BehaviorStatus.None
	self._isClear = false
end

return M
