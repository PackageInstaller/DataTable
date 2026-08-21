-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/condition/AISelectedByBehaviorType.lua

module("logic.extensions.ai.impl.condition.AISelectedByBehaviorType", package.seeall)

local M = class("AISelectedByBehaviorType", AINode)

function M:ctor(context)
	M.super.ctor(self, context)

	self._behaviorType = nil
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._behaviorType = aiConfigData.behaviorType
end

function M:onStart()
	M.super.onStart(self)

	local unit = self:getContext():getUnit()
	local data = unit.behaviorMgr:getCurrBehavior()

	if data:getType() == self._behaviorType then
		HousePerformUtil.setBehaviorData(data, unit)
		self:getContext():setBehaviorData(data)

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

	self._behaviorType = nil
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._behaviorType = nil
end

return M
