-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/graphic/TravelGoCounterBoolNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.graphic.TravelGoCounterBoolNode", package.seeall)

local TravelGoCounterBoolNode = class("TravelGoCounterBoolNode", TravelGoBoolNode)

function TravelGoCounterBoolNode:onSetData(data)
	self.entity = data.entity
end

function TravelGoCounterBoolNode:onEnable()
	local rate = self.entity.attributes:getAttr(TravelGoBattleEnum.AttrType.CounterAttackRate)
	local r = math.random()

	self.entity.tag.isCounter = r < rate

	self:done()
end

function TravelGoCounterBoolNode:isTrue()
	logNormal(string.format("小瑞安依 行为 是否反击:%s 是否玩家:%s", self.entity.tag.isCounter, self.entity.entityType == TravelGoBattleEnum.EntityType.Player))

	return self.entity.tag.isCounter
end

return TravelGoCounterBoolNode
