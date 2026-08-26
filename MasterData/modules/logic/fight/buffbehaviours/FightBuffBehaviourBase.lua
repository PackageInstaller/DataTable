-- chunkname: @modules/logic/fight/buffbehaviours/FightBuffBehaviourBase.lua

module("modules.logic.fight.buffbehaviours.FightBuffBehaviourBase", package.seeall)

local FightBuffBehaviourBase = class("FightBuffBehaviourBase", UserDataDispose)

function FightBuffBehaviourBase:init(viewGo, viewContainer, co)
	self:__onInit()

	self.viewGo = viewGo
	self.viewContainer = viewContainer
	self.co = co
end

function FightBuffBehaviourBase:onAddBuff(entityId, buffId, buffMo)
	return
end

function FightBuffBehaviourBase:onUpdateBuff(entityId, buffId, buffMo)
	return
end

function FightBuffBehaviourBase:onRemoveBuff(entityId, buffId, buffMo)
	return
end

function FightBuffBehaviourBase:onDestroy()
	self:__onDispose()
end

return FightBuffBehaviourBase
