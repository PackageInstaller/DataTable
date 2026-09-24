-- chunkname: @modules/logic/matchgame/fight/view/skill/skilleffect/MatchGameSkillEffect_Destory.lua

module("modules.logic.matchgame.fight.view.skill.skilleffect.MatchGameSkillEffect_Destory", package.seeall)

local MatchGameSkillEffect_Destory = class("MatchGameSkillEffect_Destory")

function MatchGameSkillEffect_Destory:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameSkillEffect_Destory:progressEffect_1001(effectCoData, targetInfoList, skillData)
	if effectCoData[2] then
		local canAddEnergy = effectCoData[2] == 1

		if effectCoData[3] then
			local canAddFever = effectCoData[3] == 1

			self.elementItemMap = {}

			for index, targetInfo in ipairs(targetInfoList) do
				local targetElementItemMap = targetInfo.targetData

				for posXIndex, elementMap in pairs(targetElementItemMap) do
					if type(elementMap) == "table" then
						for posYIndex, elementItem in pairs(elementMap) do
							if elementItem and elementItem.comp then
								self.elementItemMap[posXIndex] = self.elementItemMap[posXIndex] or {}
								self.elementItemMap[posXIndex][posYIndex] = elementItem
							end
						end
					end
				end
			end

			self.sceneView:doSkillMatchAnim(self.elementItemMap, canAddFever, canAddEnergy, false, skillData)
		end
	end
end

return MatchGameSkillEffect_Destory
