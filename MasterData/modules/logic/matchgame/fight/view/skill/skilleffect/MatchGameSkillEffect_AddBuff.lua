-- chunkname: @modules/logic/matchgame/fight/view/skill/skilleffect/MatchGameSkillEffect_AddBuff.lua

module("modules.logic.matchgame.fight.view.skill.skilleffect.MatchGameSkillEffect_AddBuff", package.seeall)

local MatchGameSkillEffect_AddBuff = class("MatchGameSkillEffect_AddBuff")

function MatchGameSkillEffect_AddBuff:init(viewContent)
	self.viewContent = viewContent
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameSkillEffect_AddBuff:progressEffect_1004(effectCoData, targetInfoList, skillData)
	local buffId = effectCoData[2]
	local skillBuffMo = self.skillView:addAndGetSkillBuff(skillData, buffId)

	if skillBuffMo then
		MatchGameSkillBuffHandler.instance:handleBuffEffect(skillBuffMo.buffConfig, targetInfoList, skillData, self.viewContent, skillBuffMo)
	end
end

return MatchGameSkillEffect_AddBuff
