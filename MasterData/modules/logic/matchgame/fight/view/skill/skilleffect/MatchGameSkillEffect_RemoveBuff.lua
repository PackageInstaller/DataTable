-- chunkname: @modules/logic/matchgame/fight/view/skill/skilleffect/MatchGameSkillEffect_RemoveBuff.lua

module("modules.logic.matchgame.fight.view.skill.skilleffect.MatchGameSkillEffect_RemoveBuff", package.seeall)

local MatchGameSkillEffect_RemoveBuff = class("MatchGameSkillEffect_RemoveBuff")

function MatchGameSkillEffect_RemoveBuff:init(viewContent)
	self.viewContent = viewContent
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameSkillEffect_RemoveBuff:progressEffect_1005(effectCoData, targetInfoList, skillData)
	local buffId = effectCoData[2]

	if not buffId then
		return
	end

	for index, targetInfo in ipairs(targetInfoList) do
		local targetObjList = MatchGameSkillEffectHandler.instance:getTargetObjList(targetInfo)

		for _, targetObj in ipairs(targetObjList) do
			if targetObj.skillUserType and targetObj.skillUserType == MatchGameFightEnum.SkillUserType.Enemy and targetObj.giddyState then
				local buffConfig = MatchGameFightConfig.instance:getHeroBuffConfig(buffId)

				if buffConfig and buffConfig.buffType == MatchGameFightEnum.BuffType.HeroSick then
					self.fightView:showRoleEffect(MatchGameFightEnum.RoleEffectType.Clean, targetObj.id, true)
				end
			elseif targetObj.skillUserType and targetObj.skillUserType == MatchGameFightEnum.SkillUserType.Hero and targetObj.giddyState then
				local buffConfig = MatchGameFightConfig.instance:getMonsterBuffConfig(buffId)

				if buffConfig and buffConfig.buffType == MatchGameFightEnum.BuffType.HeroSick then
					self.fightView:showRoleEffect(MatchGameFightEnum.RoleEffectType.Clean, targetObj.id, false)
				end
			elseif targetObj.elementId and targetObj.elementId > 0 then
				local buffConfig = MatchGameFightConfig.instance:getMonsterBuffConfig(buffId)

				buffConfig = buffConfig or MatchGameFightConfig.instance:getHeroBuffConfig(buffId)

				if buffConfig and buffConfig.buffType == MatchGameFightEnum.BuffType.Poison or buffConfig.buffType == MatchGameFightEnum.BuffType.Seal then
					self.fightView:showElementEffect(MatchGameFightEnum.ItemMatchEffect.Cleanse, targetObj.posXIndex, targetObj.posYIndex)
				end
			end

			MatchGameSkillBuffHandler.instance:removeTargetBuffByBuffId(targetObj, buffId, self.viewContent)
		end
	end
end

return MatchGameSkillEffect_RemoveBuff
