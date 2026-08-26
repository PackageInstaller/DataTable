-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/graphic/TravelGoComboBoolNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.graphic.TravelGoComboBoolNode", package.seeall)

local TravelGoComboBoolNode = class("TravelGoComboBoolNode", TravelGoBoolNode)

function TravelGoComboBoolNode:onSetData(data)
	self.entity = data.entity
end

function TravelGoComboBoolNode:onEnable()
	local comboLimit = self.entity.attributes:getAttr(TravelGoBattleEnum.AttrType.ComboLimit)

	if comboLimit <= self.entity.tag.comboCount then
		logNormal("小瑞安依 连击达到上限")

		self.entity.tag.isCombo = false
		self.entity.tag.comboCount = 0

		self:done()

		return
	end

	local rate = self.entity.attributes:getAttr(TravelGoBattleEnum.AttrType.ComboRate)
	local r = math.random()

	self.entity.tag.isCombo = r < rate

	if self.entity.tag.isCombo then
		self.entity.tag.comboCount = self.entity.tag.comboCount + 1
	end

	self:done()
end

function TravelGoComboBoolNode:isTrue()
	logNormal(string.format("小瑞安依 行为 是否连击:%s 是否玩家:%s", self.entity.tag.isCombo, self.entity.entityType == TravelGoBattleEnum.EntityType.Player))

	return self.entity.tag.isCombo
end

return TravelGoComboBoolNode
