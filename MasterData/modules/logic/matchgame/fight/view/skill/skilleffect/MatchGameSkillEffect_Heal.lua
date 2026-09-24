-- chunkname: @modules/logic/matchgame/fight/view/skill/skilleffect/MatchGameSkillEffect_Heal.lua

module("modules.logic.matchgame.fight.view.skill.skilleffect.MatchGameSkillEffect_Heal", package.seeall)

local MatchGameSkillEffect_Heal = class("MatchGameSkillEffect_Heal")

function MatchGameSkillEffect_Heal:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameSkillEffect_Heal:progressEffect_1003(effectCoData, targetInfoList, skillData)
	local cureRate = effectCoData[2] / 1000

	for index, targetInfo in ipairs(targetInfoList) do
		if targetInfo.targetId == MatchGameFightEnum.SkillTargetType.CharacterSingle then
			local selectHeroList = targetInfo.targetData

			self.fightView:onSkillCureHero(selectHeroList, cureRate)
		elseif targetInfo.targetId == MatchGameFightEnum.SkillTargetType.CharacterAll then
			local selectHeroMap = targetInfo.targetData

			self.fightView:onSkillCureHero(selectHeroMap, cureRate)
		elseif targetInfo.targetId == MatchGameFightEnum.SkillTargetType.MonsterSingle then
			local selectEnemyList = targetInfo.targetData

			for _, enemyInfoMo in ipairs(selectEnemyList) do
				self.fightView:doCureEnemy(enemyInfoMo, cureRate)
			end
		end
	end
end

return MatchGameSkillEffect_Heal
