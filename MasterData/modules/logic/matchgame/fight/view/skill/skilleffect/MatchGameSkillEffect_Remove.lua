-- chunkname: @modules/logic/matchgame/fight/view/skill/skilleffect/MatchGameSkillEffect_Remove.lua

module("modules.logic.matchgame.fight.view.skill.skilleffect.MatchGameSkillEffect_Remove", package.seeall)

local MatchGameSkillEffect_Remove = class("MatchGameSkillEffect_Remove")

function MatchGameSkillEffect_Remove:init(viewContent)
	self.viewContent = viewContent
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameSkillEffect_Remove:progressEffect_1011(effectCoData, targetInfoList, skillData)
	self.elementItemMap = {}

	for index, targetInfo in ipairs(targetInfoList) do
		local targetElementItemMap = targetInfo.targetData

		for posXIndex, elementMap in pairs(targetElementItemMap) do
			if type(elementMap) == "table" then
				for posYIndex, elementItem in pairs(elementMap) do
					if elementItem and elementItem.comp then
						MatchGameSkillBuffHandler.instance:removeAllTargetBuff(elementItem.comp, self.viewContent)

						self.elementItemMap[posXIndex] = self.elementItemMap[posXIndex] or {}
						self.elementItemMap[posXIndex][posYIndex] = elementItem
					end
				end
			end
		end
	end

	self.sceneView:doSkillMatchAnim(self.elementItemMap, false, false, true, skillData)
end

return MatchGameSkillEffect_Remove
