-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameBuffEffect_Seal.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameBuffEffect_Seal", package.seeall)

local MatchGameBuffEffect_Seal = class("MatchGameBuffEffect_Seal")

function MatchGameBuffEffect_Seal:init(viewContent)
	self.viewContent = viewContent
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameBuffEffect_Seal:progressBuff_102(buffEffectData, targetInfoList, skillData, skillBuffMo)
	for index, targetInfo in ipairs(targetInfoList) do
		local selectElementMap = targetInfo.targetData

		for posXIndex, elementMap in pairs(selectElementMap) do
			for posYIndex, elementItem in pairs(elementMap) do
				if elementItem and elementItem.comp and (elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead or elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bomb or elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Cure) then
					MatchGameSkillBuffHandler.instance:removeTargetBuffByEffectType(elementItem.comp, MatchGameFightEnum.BuffEffectType.Poison, self.viewContent)
					elementItem.comp:setCurBuffType(MatchGameFightEnum.BuffType.Seal)
					MatchGameSkillBuffHandler.instance:attachBuffToTarget(elementItem.comp, skillBuffMo)
				end
			end
		end
	end
end

function MatchGameBuffEffect_Seal:removeBuff_102(buffEffectData, targetObj)
	targetObj:setCurBuffType(MatchGameFightEnum.BuffType.None)
end

return MatchGameBuffEffect_Seal
