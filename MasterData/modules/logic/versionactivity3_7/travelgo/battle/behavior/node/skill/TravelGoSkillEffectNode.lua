-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/skill/TravelGoSkillEffectNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.skill.TravelGoSkillEffectNode", package.seeall)

local TravelGoSkillEffectNode = class("TravelGoSkillEffectNode", TravelGoBehaviorNode)

function TravelGoSkillEffectNode:onSetData(data)
	self.own = data.own
	self.target = data.target
	self.skillId = data.skillId
	self.effectCfgId = data.effectCfgId
end

function TravelGoSkillEffectNode:onEnable()
	logNormal(string.format("小瑞安依 行为 技能效果 id:%s skillId:%s", self.effectCfgId, self.skillId))

	self.buffCfg = TravelGoConfig.instance:isBuffCfg(self.effectCfgId)
	self.effectCfg = TravelGoConfig.instance:isEffectCfg(self.effectCfgId)

	if self.buffCfg then
		self.target.buff:addBuff(self.effectCfgId, self.skillId)
		self:done()
	elseif self.effectCfg then
		local probability = self.effectCfg.percent
		local n = math.random()
		local isRelease = n <= probability

		if isRelease then
			self.damage = self.effectCfg.damage
			self.isHurt = self.effectCfg.isHurt == 0

			if self.isHurt then
				local ownDamage = self.own.attributes:getAttr(TravelGoBattleEnum.AttrType.Attack)
				local skillDamage = self.own.attributes:getAttr(TravelGoBattleEnum.AttrType.SkillDamage)
				local targetDefence = self.target.attributes:getAttr(TravelGoBattleEnum.AttrType.Defence)
				local attrId = self.effectCfg.isShow
				local attrValue = self.own.attributes:getAttr(attrId)

				self.value = math.max(1, ownDamage - targetDefence) * (1 + skillDamage) * (1 + attrValue) * self.damage
				self.value = math.max(0, self.value)
			else
				local maxHp = self.own.attributes:getAttr(TravelGoBattleEnum.AttrType.MaxHp)

				self.value = self.damage / 1000 * maxHp
			end

			local isUltimate = self.own.entityType == TravelGoBattleEnum.EntityType.Player and self.skillId == TravelGoConst.UltimateSkillId
			local effectTime = self.effectCfg.effectTime
			local keyTime = self.effectCfg.keyTime
			local hitAnimTime = 1

			self.parallelNode = TravelGoParallelNode.New()

			self.parallelNode:complete(self.onComplete, self)

			local animationFlow = TravelGoFlowNode.New()

			if isUltimate then
				local skillAnim = "skill2"
				local skillAnimTime = self.own:getAnimTime(skillAnim) or 1

				animationFlow:add(TravelGoDispatchEventNode.New({
					controller = TravelGoController.instance,
					event = TravelGoEvent.OnPlaySpineAnim,
					param = {
						self.own.uid,
						skillAnim,
						false,
						true
					}
				}))
				animationFlow:add(TravelGoTimeNode.New({
					_time = skillAnimTime
				}))
			end

			local effectFlow = TravelGoFlowNode.New()

			if not string.nilorempty(self.effectCfg.effect) then
				local speed = self.effectCfg.effectSpeed

				effectFlow:add(TravelGoDispatchEventNode.New({
					controller = TravelGoController.instance,
					event = TravelGoEvent.OnExecuteEffect,
					param = {
						self.target.uid,
						self.effectCfg.effect,
						effectTime,
						speed
					}
				}))
				effectFlow:add(TravelGoActionNode.New({
					func = self.playEffectAudio,
					context = self
				}))
				effectFlow:add(TravelGoTimeNode.New({
					_time = effectTime
				}))
			end

			local floatItemFlow = TravelGoFlowNode.New()

			floatItemFlow:add(TravelGoTimeNode.New({
				_time = keyTime
			}))
			floatItemFlow:add(TravelGoActionNode.New({
				func = self.executeDamage,
				context = self
			}))

			local node = TravelGoParallelNode.New()

			if self.isHurt then
				local skillEffectNode = TravelGoEffectParallelNode.New({
					own = self.own,
					target = self.target,
					effectCheckType = TravelGoBattleEnum.EffectCheckType.TriggerEffect,
					effectId = self.effectCfg.effectId
				})

				node:add(skillEffectNode)
				node:add(TravelGoTimeNode.New({
					_time = hitAnimTime
				}))
			end

			floatItemFlow:add(node)
			self.parallelNode:add(animationFlow)
			self.parallelNode:add(effectFlow)
			self.parallelNode:add(floatItemFlow)
			self.parallelNode:enable()
		else
			self:done()
		end
	else
		logError(string.format("小瑞安依 没有这个效果 id:%s", self.effectCfgId))
		self:done()
	end
end

function TravelGoSkillEffectNode:playEffectAudio()
	local str = self.effectCfg.audio

	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo[str])
end

function TravelGoSkillEffectNode:executeDamage()
	local uid
	local floatNumber = TravelGoController.instance:formatNumber(self.value)
	local isNumberSubtract

	if self.isHurt then
		uid = self.target.uid
		isNumberSubtract = true

		self.target.attributes:damage(self.value)

		if self.target.entityType == TravelGoBattleEnum.EntityType.Player then
			AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_yuzhou_ball_reset)
		else
			AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_yuanzheng_daji)
		end

		if self.target.attributes:getHp() > 0 then
			TravelGoController.instance:dispatchEvent(TravelGoEvent.OnEntityHit, self.target.uid)
		else
			TravelGoController.instance:dispatchEvent(TravelGoEvent.OnEntityDie, self.target.uid)
		end
	else
		uid = self.target.uid
		isNumberSubtract = false

		self.target.attributes:modifyHp(self.damage, true)
	end

	TravelGoController.instance:createFloatItem({
		number = floatNumber,
		isNumberSubtract = isNumberSubtract,
		uid = uid
	})
end

function TravelGoSkillEffectNode:onComplete()
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnSkillEffect, self.entity)
	self:done()
end

function TravelGoSkillEffectNode:onDisable()
	if self.parallelNode then
		self.parallelNode:dispose()

		self.parallelNode = nil
	end
end

return TravelGoSkillEffectNode
