-- chunkname: @modules/logic/versionactivity3_3/arcade/model/handbook/ArcadeHandBookSkillMO.lua

module("modules.logic.versionactivity3_3.arcade.model.handbook.ArcadeHandBookSkillMO", package.seeall)

local ArcadeHandBookSkillMO = class("ArcadeHandBookSkillMO")

function ArcadeHandBookSkillMO:ctor(id)
	self.id = id
	self.co = ArcadeConfig.instance:getActiveSkillCfg(id)
	self.type = ArcadeEnum.EffectType.Skill
end

function ArcadeHandBookSkillMO:getName()
	return self.co.skillName or ""
end

function ArcadeHandBookSkillMO:getDesc()
	return ArcadeGameHelper.phraseDesc(self.co.skillDesc or "")
end

function ArcadeHandBookSkillMO:getIcon()
	return self.co.icon
end

return ArcadeHandBookSkillMO
