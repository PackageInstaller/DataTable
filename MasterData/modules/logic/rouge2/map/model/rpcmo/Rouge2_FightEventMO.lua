-- chunkname: @modules/logic/rouge2/map/model/rpcmo/Rouge2_FightEventMO.lua

module("modules.logic.rouge2.map.model.rpcmo.Rouge2_FightEventMO", package.seeall)

local Rouge2_FightEventMO = class("Rouge2_FightEventMO", Rouge2_BaseEventMO)

function Rouge2_FightEventMO:init(eventCo, data)
	Rouge2_FightEventMO.super.init(self, eventCo, data)
end

function Rouge2_FightEventMO:update(eventCo, data)
	Rouge2_FightEventMO.super.update(self, eventCo, data)
end

function Rouge2_FightEventMO:getSurpriseAttackList()
	return self.surpriseAttackList
end

function Rouge2_FightEventMO:__tostring()
	return Rouge2_FightEventMO.super.__tostring(self)
end

return Rouge2_FightEventMO
