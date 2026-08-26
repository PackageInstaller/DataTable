-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffHandler.lua

module("modules.logic.fight.entity.comp.buff.FightBuffHandler", package.seeall)

local FightBuffHandler = class("FightBuffHandler")

function FightBuffHandler:ctor()
	self.type = nil
end

function FightBuffHandler:onBuffStart(entity, buffMO)
	return
end

function FightBuffHandler:onBuffEnd()
	return
end

function FightBuffHandler:reset()
	return
end

function FightBuffHandler:dispose()
	return
end

return FightBuffHandler
