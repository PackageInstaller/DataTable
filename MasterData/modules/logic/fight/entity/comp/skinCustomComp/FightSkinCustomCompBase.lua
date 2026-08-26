-- chunkname: @modules/logic/fight/entity/comp/skinCustomComp/FightSkinCustomCompBase.lua

module("modules.logic.fight.entity.comp.skinCustomComp.FightSkinCustomCompBase", package.seeall)

local FightSkinCustomCompBase = class("FightSkinCustomCompBase")

function FightSkinCustomCompBase:ctor(entity)
	self.entity = entity
end

function FightSkinCustomCompBase:init(go)
	self.go = go
end

function FightSkinCustomCompBase:addEventListeners()
	return
end

function FightSkinCustomCompBase:removeEventListeners()
	return
end

function FightSkinCustomCompBase:canPlayAnimState(aniState)
	return true
end

function FightSkinCustomCompBase:replaceAnimState(aniState)
	return aniState
end

function FightSkinCustomCompBase:onDestroy()
	return
end

return FightSkinCustomCompBase
