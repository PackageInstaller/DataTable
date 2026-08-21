-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/impl/RogueMonster.lua

module("logic.extensions.roguelike.unit.impl.RogueMonster", package.seeall)

local M = class("RogueMonster", RogueUnitBase)

function M:_initComponents()
	self:_addComponent("mountRoot", BattleUnitCompMountRoot)
	self:_addComponent("transform", RogueCompTransform)
	self:_addComponent("monsterProp", RogueUnitCompMonsterProp)
	self:_addComponent("dice", RogueUnitCompDices)
	self:_addComponent("buff", RogueUnitCompBuffs)
	self:_addComponent("meshModelMover", BattleUnitCompMeshModelMover)
	self:_addComponent("meshModel", RogueUnitCompMeshModel)
	self:_addComponent("uiFollow", UnitCompUIFollow)
	self:_addComponent("infoBar", RogueUnitCompMonsterInfoBar)
	self:_addComponent("material", RogueUnitCompMaterial)
end

function M:_init()
	self._const = RoguelikeConst

	M.super._init(self)
	self:setEvent(true)
end

function M:OnDestroy()
	self:setEvent(false)
	goutil.destroy(self.go)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_MONSTER_COMBAT_BEGIN, self._onCombatBegin, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_MONSTER_COMBAT_END, self._onCombatEnd, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_MONSTER_TAKE_DAMAGE, self._onMonsterTakeDamage, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_MONSTER_HP, self._onMonsterHpChange, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_ROUND_END, self._onRoundEnd, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_MONSTER_COMBAT_BEGIN, self._onCombatBegin, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_MONSTER_COMBAT_END, self._onCombatEnd, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_MONSTER_TAKE_DAMAGE, self._onMonsterTakeDamage, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_MONSTER_HP, self._onMonsterHpChange, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_ROUND_END, self._onRoundEnd, self)
	end
end

function M:_onCombatBegin()
	self:triggerBuff(EventType.ROGUE_MONSTER_COMBAT_BEGIN)
end

function M:_onCombatEnd()
	self:triggerBuff(EventType.ROGUE_MONSTER_COMBAT_END)

	local buffMos = self.buff:getAllBuff()

	for k, v in pairs(buffMos) do
		v:getBuffHandler():onRemove(self, v)
	end
end

function M:_onMonsterTakeDamage(sender, damage)
	self:triggerBuff(EventType.ROGUE_MONSTER_TAKE_DAMAGE, damage)
end

function M:_onMonsterHpChange(sender, monsterId, hp)
	self:triggerBuff(EventType.ROGUE_REFRESH_MONSTER_HP)
end

function M:_onRoundEnd()
	self:triggerBuff(EventType.ROGUE_ROUND_END)
end

function M:triggerBuff(eventType, params)
	local buffMos = self.buff:getAllBuff()

	for k, v in pairs(buffMos) do
		v:getBuffHandler():onTrigger(eventType, self, v, params)
	end
end

return M
