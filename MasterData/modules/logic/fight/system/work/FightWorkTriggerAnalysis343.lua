-- chunkname: @modules/logic/fight/system/work/FightWorkTriggerAnalysis343.lua

module("modules.logic.fight.system.work.FightWorkTriggerAnalysis343", package.seeall)

local FightWorkTriggerAnalysis343 = class("FightWorkTriggerAnalysis343", FightEffectBase)

function FightWorkTriggerAnalysis343:onStart()
	local entityId = self.actEffectData.targetId
	local entity = FightHelper.getEntity(entityId)

	if not entity then
		logError("触发分析 未找到技能释放者 : " .. tostring(entityId))

		return self:onDone(true)
	end

	local entityMo = entity:getMO()
	local skinId = entityMo and entityMo.skin
	local co = skinId and lua_fight_sp_effect_wuerlixi_timeline.configDict[skinId]

	if not co then
		self:onDone(true)

		return
	end

	local teamType = self.actEffectData.teamType

	if teamType == FightEnum.TeamType.MySide then
		if not co.mySideTimeline then
			local timeline = co.enemySideTimeline

			if string.nilorempty(timeline) then
				self:onDone(true)

				return
			end

			self:com_registTimer(self._delayDone, 30)
			self:com_registEvent(FightController.instance, FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish)
			entity.skill:playTimeline(timeline, self.fightStepData)
		end
	end
end

function FightWorkTriggerAnalysis343:onSkillPlayFinish()
	self:onDone(true)
end

function FightWorkTriggerAnalysis343:clearWork()
	return
end

return FightWorkTriggerAnalysis343
