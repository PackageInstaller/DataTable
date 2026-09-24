-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameBuffEffect_Poison.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameBuffEffect_Poison", package.seeall)

local MatchGameBuffEffect_Poison = class("MatchGameBuffEffect_Poison")

function MatchGameBuffEffect_Poison:init(viewContent)
	self.viewContent = viewContent
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameBuffEffect_Poison:progressBuff_101(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local poisonHurtRate = buffEffectData[2] / 1000

	for index, targetInfo in ipairs(targetInfoList) do
		local selectElementMap = targetInfo.targetData

		for posXIndex, elementMap in pairs(selectElementMap) do
			for posYIndex, elementItem in pairs(elementMap) do
				if elementItem and elementItem.comp and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead then
					MatchGameSkillBuffHandler.instance:removeTargetBuffByEffectType(elementItem.comp, MatchGameFightEnum.BuffEffectType.Seal, self.viewContent)
					elementItem.comp:setCurBuffType(MatchGameFightEnum.BuffType.Poison)
					elementItem.comp:setPoisonDamageRate(poisonHurtRate)
					MatchGameSkillBuffHandler.instance:attachBuffToTarget(elementItem.comp, skillBuffMo)
				end
			end
		end
	end
end

function MatchGameBuffEffect_Poison:removeBuff_101(buffEffectData, targetObj)
	targetObj:setCurBuffType(MatchGameFightEnum.BuffType.None)
end

return MatchGameBuffEffect_Poison
