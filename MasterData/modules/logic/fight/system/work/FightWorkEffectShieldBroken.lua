-- chunkname: @modules/logic/fight/system/work/FightWorkEffectShieldBroken.lua

module("modules.logic.fight.system.work.FightWorkEffectShieldBroken", package.seeall)

local FightWorkEffectShieldBroken = class("FightWorkEffectShieldBroken", FightEffectBase)
local TimelineName = "buff_rush_break"
local BossRushShieldBuff = {
	[51400021] = true,
	[514000111] = true
}

function FightWorkEffectShieldBroken:onStart()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity and entity.skill then
		if self:_isBossRushBossShieldBroken(entity) then
			FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillEnd, self, LuaEventSystem.Low)
			entity.skill:playTimeline(TimelineName, self.fightStepData)
			self:com_registTimer(self._delayDone, 10)
		else
			self:onDone(true)
		end
	else
		self:onDone(true)
	end
end

function FightWorkEffectShieldBroken:_isBossRushBossShieldBroken(entity)
	if not BossRushController.instance:isInBossRushFight() then
		return false
	end

	if not entity:isEnemySide() then
		return false
	end

	local monsterGroupId = FightModel.instance:getCurMonsterGroupId()
	local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]
	local bossIds = monsterGroupCO and monsterGroupCO.bossId
	local isBoss = bossIds and FightHelper.isBossId(bossIds, entity:getMO().modelId)

	if not isBoss then
		return false
	end

	local buffDic = entity:getMO():getBuffDic()

	for _, buffMO in pairs(buffDic) do
		if BossRushShieldBuff[buffMO.buffId] then
			return true
		end
	end

	return false
end

function FightWorkEffectShieldBroken:_onSkillEnd(attacker, skillId)
	self:onDone(true)
end

function FightWorkEffectShieldBroken:_delayDone()
	logError("播放破盾Timeline超时")
	self:onDone(true)
end

function FightWorkEffectShieldBroken:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillEnd, self)
end

return FightWorkEffectShieldBroken
