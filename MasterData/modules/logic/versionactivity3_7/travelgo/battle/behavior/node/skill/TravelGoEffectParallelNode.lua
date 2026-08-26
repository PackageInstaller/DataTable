-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/skill/TravelGoEffectParallelNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.skill.TravelGoEffectParallelNode", package.seeall)

local TravelGoEffectParallelNode = class("TravelGoEffectParallelNode", TravelGoBehaviorNode)

function TravelGoEffectParallelNode:onSetData(data)
	self.own = data.own
	self.target = data.target
	self.effectCheckType = data.effectCheckType
	self.effectId = data.effectId
end

function TravelGoEffectParallelNode:onEnable()
	local actions = self.own.skill:tiggerSkillBehavior(self.effectCheckType, {
		own = self.own,
		target = self.target
	}, self.effectId)

	if actions then
		self.node = TravelGoParallelNode.New()

		for i, v in ipairs(actions) do
			self.node:add(v)
		end

		self.node:complete(self.done, self)
		self.node:enable()
	else
		self:done()
	end
end

function TravelGoEffectParallelNode:onDisable()
	if self.node then
		self.node:dispose()

		self.node = nil
	end
end

return TravelGoEffectParallelNode
