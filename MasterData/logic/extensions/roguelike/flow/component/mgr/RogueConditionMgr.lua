-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/mgr/RogueConditionMgr.lua

module("logic.extensions.roguelike.flow.component.mgr.RogueConditionMgr", package.seeall)

local M = class("RogueConditionMgr", IRogueFlowComp)

function M:onInit()
	self._conditionHandler = {}

	self:_registerHandler("BySpecialHero", RCondition_SpecialHero_Handler)
end

function M:_registerHandler(conditionType, handlerCls)
	self._conditionHandler[conditionType] = handlerCls.New()
end

function M:getHandler(conditionType)
	return self._conditionHandler[conditionType]
end

function M:addHandler(conditionType, handler)
	self._conditionHandler[conditionType] = handler
end

function M:removeHandler(conditionType)
	self._conditionHandler[conditionType] = nil
end

function M:onStart()
	return
end

function M:onClear()
	return
end

function M:judgeConditions(conditionIds)
	local result = true

	for k, v in pairs(conditionIds) do
		-- block empty
	end

	return result
end

function M:judgeCondition(conditionId)
	local conditionCo = RoguelikeConfig.instance:getConditionById(conditionId)
	local handler = self:getHandler(conditionCo.program)

	return handler:judgeCondition(conditionCo.params)
end

return M
