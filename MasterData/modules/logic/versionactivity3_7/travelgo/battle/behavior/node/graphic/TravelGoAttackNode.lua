-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/graphic/TravelGoAttackNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.graphic.TravelGoAttackNode", package.seeall)

local TravelGoAttackNode = class("TravelGoAttackNode", TravelGoBehaviorNode)

function TravelGoAttackNode:onSetData(data)
	self.attacker = data.attacker
	self.defender = data.defender
end

function TravelGoAttackNode:onEnable()
	logNormal(string.format("小瑞安依 行为 攻击 是否玩家:%s", self.attacker.entityType == TravelGoBattleEnum.EntityType.Player))

	local isCombo = self.attacker.tag.isCombo
	local isCounter = self.attacker.tag.isCounter

	self.attacker.tag.isCombo = false
	self.attacker.tag.isCounter = false

	if self.attacker.attributes:isFrozen() then
		self:done()

		return
	end

	local critRate = self.attacker.attributes:getAttr(TravelGoBattleEnum.AttrType.CritRate)
	local r = math.random()

	self.isCrit = r < critRate

	local attack = self.attacker.attributes:getAttr(TravelGoBattleEnum.AttrType.Attack)
	local defenderDefence = self.defender.attributes:getAttr(TravelGoBattleEnum.AttrType.Defence)
	local damage = math.max(attack - defenderDefence, 1)
	local attackDamageAttr = 1 + self.attacker.attributes:getAttr(TravelGoBattleEnum.AttrType.AttackDamage)
	local comboDamage = 1

	if isCombo then
		comboDamage = comboDamage + self.attacker.attributes:getAttr(TravelGoBattleEnum.AttrType.ComboDamage)
	end

	local totalDamage = damage * attackDamageAttr * comboDamage + ((isCounter or nil) and self.attacker.attributes:getAttr(TravelGoBattleEnum.AttrType.CounterAttackDamage))

	self.damage = totalDamage * ((self.isCrit or nil) and 2 + self.attacker.attributes:getAttr(TravelGoBattleEnum.AttrType.CritDamage))

	local attackAnim, attackAnimTime = self.attacker:getAttackAnimTime()
	local keyTime
	local actId = TravelGoModel.instance.activityId

	if self.attacker.entityType == TravelGoBattleEnum.EntityType.Player then
		local attackKeyTimeScale = TravelGoConfig.instance:getConsValue(actId, TravelGoConst.ConstId.AttackKeyTimeScale, true) or 1

		keyTime = attackAnimTime * attackKeyTimeScale
	else
		keyTime = self.attacker.cfg.keyTime
	end

	local hitTime = TravelGoConfig.instance:getConsValue(actId, TravelGoConst.ConstId.AttackHitTime, true) or 1
	local battleSpeed = TravelGoConfig.instance:getConsValue(actId, TravelGoConst.ConstId.BattleSpeed, true) or 1

	attackAnimTime = attackAnimTime / battleSpeed + 0.3
	keyTime = keyTime / battleSpeed

	local hitAnimTime = hitTime / battleSpeed

	self.parallelNode = TravelGoParallelNode.New()

	self.parallelNode:complete(self.onComplete, self)

	local animationFlow = TravelGoFlowNode.New()

	animationFlow:add(TravelGoDispatchEventNode.New({
		controller = TravelGoController.instance,
		event = TravelGoEvent.OnPlaySpineAnim,
		param = {
			self.attacker.uid,
			attackAnim,
			false,
			true
		}
	}))
	animationFlow:add(TravelGoTimeNode.New({
		_time = attackAnimTime
	}))

	local effectFlow = TravelGoFlowNode.New()
	local floatItemFlow = TravelGoFlowNode.New()

	if isCombo then
		floatItemFlow:add(TravelGoDispatchEventNode.New({
			controller = TravelGoController.instance,
			event = TravelGoEvent.OnComboTip,
			param = {
				self.attacker.uid,
				self.attacker.tag.comboCount
			}
		}))
	end

	if isCounter then
		floatItemFlow:add(TravelGoDispatchEventNode.New({
			controller = TravelGoController.instance,
			event = TravelGoEvent.OnCounterTip,
			param = {
				self.attacker.uid
			}
		}))
	end

	floatItemFlow:add(TravelGoTimeNode.New({
		_time = keyTime
	}))
	floatItemFlow:add(TravelGoActionNode.New({
		func = self.executeDamage,
		context = self
	}))

	local node = TravelGoParallelNode.New()
	local attackNode = TravelGoEffectTriggerNode.New({
		own = self.attacker,
		target = self.defender,
		effectCheckType = TravelGoBattleEnum.EffectCheckType.AttackEffect
	})

	node:add(attackNode)

	if self.isCrit then
		local critNode = TravelGoEffectTriggerNode.New({
			own = self.attacker,
			target = self.defender,
			effectCheckType = TravelGoBattleEnum.EffectCheckType.CritEffect
		})

		node:add(critNode)
	end

	if isCounter then
		local counterNode = TravelGoEffectTriggerNode.New({
			own = self.attacker,
			target = self.defender,
			effectCheckType = TravelGoBattleEnum.EffectCheckType.CounterEffect
		})

		node:add(counterNode)
	end

	if isCombo then
		local comboNode = TravelGoEffectTriggerNode.New({
			own = self.attacker,
			target = self.defender,
			effectCheckType = TravelGoBattleEnum.EffectCheckType.ComboEffect
		})

		node:add(comboNode)
	end

	node:add(TravelGoTimeNode.New({
		_time = hitAnimTime
	}))
	floatItemFlow:add(node)
	self.parallelNode:add(animationFlow)
	self.parallelNode:add(effectFlow)
	self.parallelNode:add(floatItemFlow)
	self.parallelNode:enable()
end

function TravelGoAttackNode:executeDamage()
	self.defender.attributes:damage(self.damage)

	local number = TravelGoController.instance:formatNumber(self.damage)
	local isNumberSubtract = self.damage >= 0

	TravelGoController.instance:createFloatItem({
		number = number,
		isNumberSubtract = isNumberSubtract,
		uid = self.defender.uid,
		isCrit = self.isCrit
	})

	if self.defender.attributes:getHp() > 0 then
		TravelGoController.instance:dispatchEvent(TravelGoEvent.OnEntityHit, self.defender.uid)
	else
		TravelGoController.instance:dispatchEvent(TravelGoEvent.OnEntityDie, self.defender.uid)
	end

	if self.attacker.entityType == TravelGoBattleEnum.EntityType.Player then
		AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_yuanzheng_daji)
	else
		AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_yuzhou_ball_reset)
	end

	if self.isCrit then
		AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_yuanzheng_baoji)
	end
end

function TravelGoAttackNode:onComplete()
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnAttack, self.attacker)

	local graphic = TravelGoController.instance.travelGoBattleMgr.graphic
	local isEnd, isWin = graphic:checkBattleEnd()

	if not isEnd then
		self:done()
	end
end

function TravelGoAttackNode:onDisable()
	if self.parallelNode then
		self.parallelNode:dispose()

		self.parallelNode = nil
	end
end

return TravelGoAttackNode
