-- chunkname: @modules/logic/matchgame/fight/view/skill/skilleffect/MatchGameSkillEffect_RemoveBuffType.lua

module("modules.logic.matchgame.fight.view.skill.skilleffect.MatchGameSkillEffect_RemoveBuffType", package.seeall)

local MatchGameSkillEffect_RemoveBuffType = class("MatchGameSkillEffect_RemoveBuffType")

function MatchGameSkillEffect_RemoveBuffType:init(viewContent)
	self.viewContent = viewContent
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameSkillEffect_RemoveBuffType:progressEffect_1006(effectCoData, targetInfoList, skillData)
	local buffType = effectCoData[2]

	if not buffType then
		return
	end

	for index, targetInfo in ipairs(targetInfoList) do
		local targetObjList = MatchGameSkillEffectHandler.instance:getTargetObjList(targetInfo)

		for _, targetObj in ipairs(targetObjList) do
			if buffType == MatchGameFightEnum.BuffType.HeroSick then
				if targetObj.skillUserType and targetObj.skillUserType == MatchGameFightEnum.SkillUserType.Enemy and targetObj.giddyState then
					self.fightView:showRoleEffect(MatchGameFightEnum.RoleEffectType.Clean, targetObj.id, true)
				elseif targetObj.skillUserType and targetObj.skillUserType == MatchGameFightEnum.SkillUserType.Hero and targetObj.giddyState then
					self.fightView:showRoleEffect(MatchGameFightEnum.RoleEffectType.Clean, targetObj.id, false)
				end
			elseif buffType == MatchGameFightEnum.BuffType.Poison or buffType == MatchGameFightEnum.BuffType.Seal then
				self.fightView:showElementEffect(MatchGameFightEnum.ItemMatchEffect.Cleanse, targetObj.posXIndex, targetObj.posYIndex)
			end

			MatchGameSkillBuffHandler.instance:removeTargetBuffByBuffType(targetObj, buffType, self.viewContent)
		end
	end
end

return MatchGameSkillEffect_RemoveBuffType
