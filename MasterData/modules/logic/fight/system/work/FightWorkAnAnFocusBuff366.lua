-- chunkname: @modules/logic/fight/system/work/FightWorkAnAnFocusBuff366.lua

module("modules.logic.fight.system.work.FightWorkAnAnFocusBuff366", package.seeall)

local FightWorkAnAnFocusBuff366 = class("FightWorkAnAnFocusBuff366", FightEffectBase)

function FightWorkAnAnFocusBuff366:onConstructor()
	self.SAFETIME = 3
end

function FightWorkAnAnFocusBuff366:onStart()
	local targetId = self.actEffectData.targetId
	local targetEntity = FightHelper.getEntity(targetId)

	if not targetEntity then
		return self:onDone(true)
	end

	local entityMo = targetEntity:getMO()
	local skinId = entityMo and entityMo.skin
	local co = skinId and lua_fight_anan_focus_timeline.configDict[skinId]

	co = co or lua_fight_anan_focus_timeline.configDict[0]
	self.timelineName = co.timeline

	if string.nilorempty(self.timelineName) then
		logError("time line is empty, skinId : " .. tostring(skinId))

		return self:onDone(true)
	end

	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self.onSkillEnd, self)
	targetEntity.skill:playTimeline(self.timelineName, self.fightStepData)
end

function FightWorkAnAnFocusBuff366:onSkillEnd(entity, actId, fightStepData, timelineName)
	if timelineName ~= self.timelineName then
		return
	end

	self:onDone(true)
end

function FightWorkAnAnFocusBuff366:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self.onSkillEnd, self)
end

return FightWorkAnAnFocusBuff366
