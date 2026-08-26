-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/graphic/TravelGoEffectTriggerNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.graphic.TravelGoEffectTriggerNode", package.seeall)

local TravelGoEffectTriggerNode = class("TravelGoEffectTriggerNode", TravelGoBehaviorNode)

function TravelGoEffectTriggerNode:onSetData(data)
	self.own = data.own
	self.target = data.target
	self.effectCheckType = data.effectCheckType
	self.effectId = data.effectId
end

function TravelGoEffectTriggerNode:onEnable()
	logNormal(string.format("小瑞安依 行为 效果触发点 checkType:%s effectId:%s 是否玩家:%s", self.effectCheckType, self.effectId, self.own.entityType == TravelGoBattleEnum.EntityType.Player))

	local actions = self.own.skill:tiggerSkillBehavior(self.effectCheckType, {
		own = self.own,
		target = self.target
	}, self.effectId)

	if actions then
		if not self.flow then
			self.flow = TravelGoFlowNode.New()

			self.flow:setInterruptFunc(self.checkEnd, self)
		else
			self.flow:awake()
		end

		for i, v in ipairs(actions) do
			self.flow:add(v)
		end

		self.flow:complete(self.onSkillBehaviorComplete, self)
		self.flow:enable()
	else
		self:done()
	end
end

function TravelGoEffectTriggerNode:onDisable()
	if self.flow then
		self.flow:dispose()

		self.flow = nil
	end
end

function TravelGoEffectTriggerNode:checkEnd()
	local graphic = TravelGoController.instance.travelGoBattleMgr.graphic
	local isEnd, isWin = graphic:checkBattleEnd()

	return isEnd
end

function TravelGoEffectTriggerNode:onSkillBehaviorComplete()
	local isEnd = self:checkEnd()

	if not isEnd then
		self:done()
	end
end

return TravelGoEffectTriggerNode
