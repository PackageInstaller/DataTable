-- chunkname: @modules/logic/matchgame/fight/view/skill/skilleffect/MatchGameSkillEffect_Attack.lua

module("modules.logic.matchgame.fight.view.skill.skilleffect.MatchGameSkillEffect_Attack", package.seeall)

local MatchGameSkillEffect_Attack = class("MatchGameSkillEffect_Attack")

function MatchGameSkillEffect_Attack:init(viewContent)
	self.viewContent = viewContent
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameSkillEffect_Attack:progressEffect_1007(effectCoData, targetInfoList, skillData)
	local attackRate = (effectCoData[2] or 0) / 1000

	for index, targetInfo in ipairs(targetInfoList) do
		if targetInfo.targetId == MatchGameFightEnum.SkillTargetType.CharacterSingle or targetInfo.targetId == MatchGameFightEnum.SkillTargetType.CharacterAll then
			self.fightView:onSkillAttackHero(targetInfo.targetData, attackRate)
		end
	end
end

return MatchGameSkillEffect_Attack
