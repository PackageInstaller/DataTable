-- chunkname: @modules/logic/fight/buffbehaviours/FightBuffBehaviour_ScrollLife.lua

module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_ScrollLife", package.seeall)

local FightBuffBehaviour_ScrollLife = class("FightBuffBehaviour_ScrollLife", FightBuffBehaviourBase)

function FightBuffBehaviour_ScrollLife:init(viewGo, viewContainer)
	FightBuffBehaviour_ScrollLife.super.init(self, viewGo, viewContainer)
end

function FightBuffBehaviour_ScrollLife:onAddBuff(entityId, buffId, buffMo)
	return
end

function FightBuffBehaviour_ScrollLife:onUpdateBuff(entityId, buffId, buffMo)
	return
end

function FightBuffBehaviour_ScrollLife:onRemoveBuff(entityId, buffId, buffMo)
	return
end

function FightBuffBehaviour_ScrollLife:onDestroy()
	FightBuffBehaviour_ScrollLife.super.onDestroy(self)
end

return FightBuffBehaviour_ScrollLife
