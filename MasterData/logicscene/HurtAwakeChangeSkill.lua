-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtAwakeChangeSkill.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtAwakeChangeSkill", package.seeall)

local HurtAwakeChangeSkill = class("HurtAwakeChangeSkill", HurtEvtBase)

function HurtAwakeChangeSkill:getEvtType()
	return HurtEvtType.AwakenChangeSkill
end

function HurtAwakeChangeSkill:handleEvt(hurtData)
	BattleAwakeChangeSkillModel.instance:updateAwakeChnageSkillInfo(hurtData.target.teamId, hurtData.target.id, self.changeValue, self.curHadTriggerTimes, self.isAwakening)

	if hurtData.target then
		hurtData.target:onUpdateAwakenSkillStatus()
	end

	HurtAwakeChangeSkill.super.handleEvt(self, hurtData)
end

return HurtAwakeChangeSkill
