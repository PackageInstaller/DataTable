-- chunkname: @modules/logic/matchgame/fight/view/skill/skilleffect/MatchGameSkillEffect_Convert.lua

module("modules.logic.matchgame.fight.view.skill.skilleffect.MatchGameSkillEffect_Convert", package.seeall)

local MatchGameSkillEffect_Convert = class("MatchGameSkillEffect_Convert")

function MatchGameSkillEffect_Convert:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameSkillEffect_Convert:progressEffect_1002(effectCoData, targetInfoList, skillData)
	local targetElementId = effectCoData[2]

	for index, targetInfo in ipairs(targetInfoList) do
		local targetElementItemMap = targetInfo.targetData

		for posXIndex, itemMap in pairs(targetElementItemMap) do
			for posYIndex, elementItem in pairs(itemMap) do
				if elementItem then
					elementItem.comp:convertToOtherElement(targetElementId)
				end
			end
		end
	end

	self.sceneView:checkNotMatchConvertElement()
end

return MatchGameSkillEffect_Convert
