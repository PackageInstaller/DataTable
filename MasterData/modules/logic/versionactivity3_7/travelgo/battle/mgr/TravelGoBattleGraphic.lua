-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/mgr/TravelGoBattleGraphic.lua

module("modules.logic.versionactivity3_7.travelgo.battle.mgr.TravelGoBattleGraphic", package.seeall)

local TravelGoBattleGraphic = class("TravelGoBattleGraphic", TravelGoBase)

function TravelGoBattleGraphic:ctor()
	TravelGoBattleGraphic.super.ctor(self)

	self.nodeList = {}

	self:createGraphic()
	self:link()
end

function TravelGoBattleGraphic:onEnable()
	self.battleStart:enable()
end

function TravelGoBattleGraphic:onDisable()
	for i, v in ipairs(self.nodeList) do
		v:disable()
	end
end

function TravelGoBattleGraphic:createGraphic()
	self.battleStart = self:createNode(TravelGoBattleStartNode.New())
	self.battleStartDelay = self:createNode(TravelGoTimeNode.New({
		_time = 0.5
	}))
	self.player_effectTrigger_BattleStart = self:createNode(TravelGoEffectTriggerNode.New())
	self.player_roundStart = self:createNode(TravelGoActionNode.New())
	self.player_effectTrigger_RoundStart1 = self:createNode(TravelGoEffectTriggerNode.New())
	self.player_effectTrigger_RoundStart2 = self:createNode(TravelGoEffectTriggerNode.New())
	self.player_effectTrigger_BeforeAttack = self:createNode(TravelGoEffectTriggerNode.New())
	self.player_attack = self:createNode(TravelGoAttackNode.New())
	self.player_comboBool = self:createNode(TravelGoComboBoolNode.New())
	self.player_counterBool = self:createNode(TravelGoCounterBoolNode.New())
	self.player_effectTrigger_AfterAttack = self:createNode(TravelGoEffectTriggerNode.New())
	self.player_roundEnd = self:createNode(TravelGoActionNode.New())
	self.player_counterStart = self:createNode(TravelGoActionNode.New())
	self.player_counterAttack = self:createNode(TravelGoAttackNode.New())
	self.enemy_roundStart = self:createNode(TravelGoActionNode.New())
	self.enemy_effectTrigger_RoundStart1 = self:createNode(TravelGoEffectTriggerNode.New())
	self.enemy_effectTrigger_RoundStart2 = self:createNode(TravelGoEffectTriggerNode.New())
	self.enemy_effectTrigger_BeforeAttack = self:createNode(TravelGoEffectTriggerNode.New())
	self.enemy_attack = self:createNode(TravelGoAttackNode.New())
	self.enemy_comboBool = self:createNode(TravelGoComboBoolNode.New())
	self.enemy_counterBool = self:createNode(TravelGoCounterBoolNode.New())
	self.enemy_effectTrigger_AfterAttack = self:createNode(TravelGoEffectTriggerNode.New())
	self.enemy_roundEnd = self:createNode(TravelGoActionNode.New())
	self.enemy_counterStart = self:createNode(TravelGoActionNode.New())
	self.enemy_counterAttack = self:createNode(TravelGoAttackNode.New())
	self.battleEndNode1 = self:createNode(TravelGoTimeNode.New({
		_time = TravelGoConst.BattleEndDieTimeS
	}))
	self.battleEndNode2 = self:createNode(TravelGoActionNode.New({
		func = self.onBattleEnd,
		context = self
	}))
end

function TravelGoBattleGraphic:createNode(node)
	table.insert(self.nodeList, node)

	return node
end

function TravelGoBattleGraphic:link()
	self.battleStart:next(self.battleStartDelay)
	self.battleStartDelay:next(self.player_effectTrigger_BattleStart)
	self.player_effectTrigger_BattleStart:next(self.player_roundStart)
	self.player_roundStart:next(self.player_effectTrigger_RoundStart1)
	self.player_effectTrigger_RoundStart1:next(self.player_effectTrigger_RoundStart2)
	self.player_effectTrigger_RoundStart2:next(self.player_effectTrigger_BeforeAttack)
	self.player_effectTrigger_BeforeAttack:next(self.player_attack)
	self.player_attack:next(self.player_comboBool)
	self.player_comboBool:setBranch({
		self.player_effectTrigger_BeforeAttack
	}, {
		self.enemy_counterBool
	})
	self.enemy_counterBool:setBranch({
		self.enemy_counterStart
	}, {
		self.player_effectTrigger_AfterAttack
	})
	self.enemy_counterStart:next(self.enemy_counterAttack)
	self.enemy_counterAttack:next(self.player_effectTrigger_AfterAttack)
	self.player_effectTrigger_AfterAttack:next(self.player_roundEnd)
	self.player_roundEnd:next(self.enemy_roundStart)
	self.enemy_roundStart:next(self.enemy_effectTrigger_RoundStart1)
	self.enemy_effectTrigger_RoundStart1:next(self.enemy_effectTrigger_RoundStart2)
	self.enemy_effectTrigger_RoundStart2:next(self.enemy_effectTrigger_BeforeAttack)
	self.enemy_effectTrigger_BeforeAttack:next(self.enemy_attack)
	self.enemy_attack:next(self.enemy_comboBool)
	self.enemy_comboBool:setBranch({
		self.enemy_effectTrigger_BeforeAttack
	}, {
		self.player_counterBool
	})
	self.player_counterBool:setBranch({
		self.player_counterStart
	}, {
		self.enemy_effectTrigger_AfterAttack
	})
	self.player_counterStart:next(self.player_counterAttack)
	self.player_counterAttack:next(self.enemy_effectTrigger_AfterAttack)
	self.enemy_effectTrigger_AfterAttack:next(self.enemy_roundEnd)
	self.enemy_roundEnd:next(self.player_roundStart)
	self.battleEndNode1:next(self.battleEndNode2)
end

function TravelGoBattleGraphic:setBattleData(playerEntity, enemyEntity)
	self.playerEntity = playerEntity
	self.enemyEntity = enemyEntity

	self.player_effectTrigger_BattleStart:setData({
		own = playerEntity,
		target = enemyEntity,
		effectCheckType = TravelGoBattleEnum.EffectCheckType.BattleStart
	})
	self.player_roundStart:setData({
		func = self.onRoundStart,
		context = self,
		param = playerEntity
	})
	self.player_effectTrigger_RoundStart1:setData({
		own = playerEntity,
		target = enemyEntity,
		effectCheckType = TravelGoBattleEnum.EffectCheckType.RoundStart
	})
	self.player_effectTrigger_RoundStart2:setData({
		own = playerEntity,
		target = enemyEntity,
		effectCheckType = TravelGoBattleEnum.EffectCheckType.RoundStartEffect
	})
	self.player_effectTrigger_BeforeAttack:setData({
		own = playerEntity,
		target = enemyEntity,
		effectCheckType = TravelGoBattleEnum.EffectCheckType.BeforeAttack
	})
	self.player_attack:setData({
		attacker = self.playerEntity,
		defender = enemyEntity
	})
	self.player_comboBool:setData({
		entity = playerEntity
	})
	self.player_counterBool:setData({
		entity = playerEntity
	})
	self.player_effectTrigger_AfterAttack:setData({
		own = playerEntity,
		target = enemyEntity,
		effectCheckType = TravelGoBattleEnum.EffectCheckType.AfterAttack
	})
	self.player_roundEnd:setData({
		func = self.onRoundEnd,
		context = self,
		param = playerEntity
	})
	self.player_counterStart:setData({
		func = self.onCounterStart,
		context = self,
		param = playerEntity
	})
	self.player_counterAttack:setData({
		attacker = playerEntity,
		defender = enemyEntity
	})
	self.enemy_roundStart:setData({
		func = self.onRoundStart,
		context = self,
		param = enemyEntity
	})
	self.enemy_effectTrigger_RoundStart1:setData({
		own = enemyEntity,
		target = playerEntity,
		effectCheckType = TravelGoBattleEnum.EffectCheckType.RoundStart
	})
	self.enemy_effectTrigger_RoundStart2:setData({
		own = enemyEntity,
		target = playerEntity,
		effectCheckType = TravelGoBattleEnum.EffectCheckType.RoundStartEffect
	})
	self.enemy_effectTrigger_BeforeAttack:setData({
		own = enemyEntity,
		target = playerEntity,
		effectCheckType = TravelGoBattleEnum.EffectCheckType.BeforeAttack
	})
	self.enemy_attack:setData({
		attacker = self.enemyEntity,
		defender = playerEntity
	})
	self.enemy_comboBool:setData({
		entity = enemyEntity
	})
	self.enemy_counterBool:setData({
		entity = enemyEntity
	})
	self.enemy_effectTrigger_AfterAttack:setData({
		own = enemyEntity,
		target = playerEntity,
		effectCheckType = TravelGoBattleEnum.EffectCheckType.AfterAttack
	})
	self.enemy_roundEnd:setData({
		func = self.onRoundEnd,
		context = self,
		param = enemyEntity
	})
	self.enemy_counterStart:setData({
		func = self.onCounterStart,
		context = self,
		param = enemyEntity
	})
	self.enemy_counterAttack:setData({
		attacker = enemyEntity,
		defender = playerEntity
	})
end

function TravelGoBattleGraphic:onRoundStart(entity)
	logNormal(string.format("小瑞安依 行为 回合开始 是否玩家:%s", entity.entityType == TravelGoBattleEnum.EntityType.Player))

	entity.tag.round = entity.tag.round + 1

	entity.attributes:recoverHpRound()
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnRoundStart, entity)
end

function TravelGoBattleGraphic:onRoundEnd(entity)
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnRoundEnd, entity)
end

function TravelGoBattleGraphic:checkBattleEnd()
	local travelGoBattleMgr = TravelGoController.instance.travelGoBattleMgr
	local isEnd, isWin
	local eventMO = TravelGoModel.instance.travelGoEventMO
	local playerEntity = travelGoBattleMgr.travelGoEntityMgr.playerEntity
	local playerHp = playerEntity.attributes:getHp()

	if playerHp <= 0 then
		isWin = false
		isEnd = true
	else
		isWin = true
		isEnd = true

		local enemyEntityDic = travelGoBattleMgr.travelGoEntityMgr.enemyEntityList

		for i, enemyEntity in pairs(enemyEntityDic) do
			local hp = enemyEntity.attributes:getHp()

			if hp > 0 then
				isWin = false
				isEnd = false

				break
			end
		end
	end

	if isEnd then
		eventMO:setBattleResult(isEnd, isWin)
		self.battleEndNode1:enable()
	end

	return isEnd, isWin
end

function TravelGoBattleGraphic:onCounterStart(entity)
	logNormal(string.format("小瑞安依 行为 反击开始 是否玩家:%s", entity.entityType == TravelGoBattleEnum.EntityType.Player))
end

function TravelGoBattleGraphic:onBattleEnd()
	local travelGoBattleMgr = TravelGoController.instance.travelGoBattleMgr

	travelGoBattleMgr:endBattle()
end

return TravelGoBattleGraphic
