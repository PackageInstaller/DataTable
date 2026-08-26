-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffHandleClsBase.lua

module("modules.logic.fight.entity.comp.buff.FightBuffHandleClsBase", package.seeall)

local FightBuffHandleClsBase = class("FightBuffHandleClsBase")

function FightBuffHandleClsBase:ctor()
	return
end

function FightBuffHandleClsBase:onBuffStart(entity, buffMo)
	return
end

function FightBuffHandleClsBase:onUpdateBuff(entityId, effectType, buffId, buffUid)
	return
end

function FightBuffHandleClsBase:clear()
	return
end

function FightBuffHandleClsBase:onBuffEnd()
	self:clear()
end

function FightBuffHandleClsBase:reset()
	self:clear()
end

function FightBuffHandleClsBase:dispose()
	self:clear()
end

return FightBuffHandleClsBase
