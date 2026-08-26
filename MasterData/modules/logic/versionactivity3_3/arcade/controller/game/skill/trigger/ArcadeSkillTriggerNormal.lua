-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/trigger/ArcadeSkillTriggerNormal.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.trigger.ArcadeSkillTriggerNormal", package.seeall)

local ArcadeSkillTriggerNormal = class("ArcadeSkillTriggerNormal", ArcadeSkillTriggerBase)

function ArcadeSkillTriggerNormal:onTrigger()
	local triggerCount = ArcadeGameTriggerController.instance:addTriggerCount()

	if triggerCount > ArcadeGameEnum.MaxSkillTriggerCount then
		local skillCfg = self:getSkillConfig()

		if skillCfg then
			ArcadeGameTriggerController.instance:addOutSizeSkillId(skillCfg.id)
		end

		if triggerCount - 2 < ArcadeGameEnum.MaxSkillTriggerCount then
			logError(string.format("【街机秀】回合累计触发技能效果已达上限===(%s/%s) skillId:%s", triggerCount, ArcadeGameEnum.MaxSkillTriggerCount, (skillCfg or nil) and (skillCfg.id or "nil")))
		end

		return
	end

	self._hitBase:hit(self._context)
end

return ArcadeSkillTriggerNormal
