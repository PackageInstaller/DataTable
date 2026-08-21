-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/base/RogueBaseBuffHandler.lua

module("logic.extensions.roguelike.buff.base.RogueBaseBuffHandler", package.seeall)

local M = class("RogueBaseBuffHandler", IRogueBuffHandler, AbstractGlobalReusable)

function M:ctor()
	self._triggerEvent = nil
end

function M:getTriggerEvent()
	return self._triggerEvent
end

function M:onAdd(entity, buffMO)
	return
end

function M:onTrigger(triggerEvent, entity, buffMO)
	return triggerEvent == self._triggerEvent
end

function M:onEffectTrigger(count, effectId)
	return
end

function M:onRemove(entity, buffMO)
	return
end

return M
