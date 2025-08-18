-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\CombatResultRecorder.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local strClassName = "CombatResultRecorder"
local CombatResultRecorder = Class(strClassName)

function CombatResultRecorder:ctor()
	self.attackCount = 0
	self.totalDamage = 0
	self.totalHeal = 0
	self.critCount = 0
	self.missCount = 0
	self.missAttackCount = 0
	self.receiveDamage = 0
	self.receiveHeal = 0
end

function CombatResultRecorder:recordOneAttack(damageType, damageValue, isCrit, master)
	self.attackCount = self.attackCount + 1

	if damageType == BattleConst.DAMAGE_TYPE_MISS then
		self.missCount = self.missCount + 1

		return
	end

	if BattleConst.HURT_DICT[damageType] or damageType == BattleConst.DAMAGE_TYPE_REBOUND or damageType == BattleConst.DAMAGE_TYPE_DISPEL_SHIELD or damageType == BattleConst.DAMAGE_TYPE_LINK or damageType == BattleConst.DAMAGE_TYPE_HP_REMOVE then
		if master and master.record_damage_per then
			self.totalDamage = self.totalDamage + math.floor(damageValue * master.record_damage_per)
		else
			self.totalDamage = self.totalDamage + damageValue
		end
	elseif damageType == BattleConst.DAMAGE_TYPE_HEAL or damageType == BattleConst.DAMAGE_TYPE_VAMPIRE or damageType == BattleConst.DAMAGE_TYPE_SHIELD then
		if master and master.record_heal_per then
			self.totalHeal = self.totalHeal + math.floor(damageValue * master.record_heal_per)
		else
			self.totalHeal = self.totalHeal + damageValue
		end
	end

	if isCrit then
		self.critCount = self.critCount + 1
	end
end

function CombatResultRecorder:recordOneHited(damageType, damageValue, master)
	if damageType == BattleConst.DAMAGE_TYPE_MISS then
		self.missAttackCount = self.missAttackCount + 1

		return
	end

	if BattleConst.HURT_DICT[damageType] or damageType == BattleConst.DAMAGE_TYPE_REBOUND or damageType == BattleConst.DAMAGE_TYPE_DISPEL_SHIELD or damageType == BattleConst.DAMAGE_TYPE_LINK or damageType == BattleConst.DAMAGE_TYPE_HP_REMOVE then
		self.receiveDamage = self.receiveDamage + damageValue
	elseif damageType == BattleConst.DAMAGE_TYPE_HEAL or damageType == BattleConst.DAMAGE_TYPE_VAMPIRE or damageType == BattleConst.DAMAGE_TYPE_SHIELD then
		self.receiveHeal = self.receiveHeal + damageValue
	end
end

return CombatResultRecorder
