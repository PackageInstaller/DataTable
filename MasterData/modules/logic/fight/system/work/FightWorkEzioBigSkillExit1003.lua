-- chunkname: @modules/logic/fight/system/work/FightWorkEzioBigSkillExit1003.lua

module("modules.logic.fight.system.work.FightWorkEzioBigSkillExit1003", package.seeall)

local FightWorkEzioBigSkillExit1003 = class("FightWorkEzioBigSkillExit1003", FightEffectBase)

function FightWorkEzioBigSkillExit1003:onStart()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if not entity or not entity.skill then
		self:onDone(true)

		return
	end

	local fightStepData = FightStepData.New(FightDef_pb.FightStep())

	fightStepData.isFakeStep = true
	fightStepData.fromId = entity.id

	if entity:isMySide() then
		fightStepData.toId = FightEntityScene.EnemySideId or FightEntityScene.MySideId
	end

	fightStepData.actType = FightEnum.ActType.SKILL

	table.insert(fightStepData.actEffect, self.actEffectData)

	local work = entity.skill:registTimelineWork("aijiao_312301_unique_direct_exit", fightStepData)

	self:playWorkAndDone(work)
end

return FightWorkEzioBigSkillExit1003
