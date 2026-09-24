-- chunkname: @modules/logic/matchgame/fight/view/skill/skilleffect/MatchGameSkillEffect_Generate.lua

module("modules.logic.matchgame.fight.view.skill.skilleffect.MatchGameSkillEffect_Generate", package.seeall)

local MatchGameSkillEffect_Generate = class("MatchGameSkillEffect_Generate")

function MatchGameSkillEffect_Generate:init(viewContent)
	self.viewContent = viewContent
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameSkillEffect_Generate:progressEffect_1009(effectCoData, targetInfoList, skillData)
	local elementId = effectCoData[2]

	if elementId then
		::label_2_0::

		local elementConfig = MatchGameFightConfig.instance:getElementConfig(elementId)

		if not elementConfig then
			return
		end

		for index, targetInfo in ipairs(targetInfoList) do
			local targetData = targetInfo.targetData

			if targetInfo.targetId == MatchGameFightEnum.SkillTargetType.LastClear then
				self:generateElement(targetData.posXIndex, targetData.posYIndex, elementId, elementConfig)
			else
				for posXIndex, elementMap in pairs(targetData) do
					if type(elementMap) == "table" then
						for posYIndex, elementItem in pairs(elementMap) do
							self:generateElement(posXIndex, posYIndex, elementId, elementConfig)
						end
					end
				end
			end
		end
	end
end

function MatchGameSkillEffect_Generate:generateElement(posXIndex, posYIndex, elementId, elementConfig)
	if not posXIndex or not posYIndex then
		return
	end

	local curElementItemMap = self.sceneView:getElementItemMap()

	if curElementItemMap[posXIndex] then
		if curElementItemMap[posXIndex] and curElementItemMap[posXIndex].comp and not curElementItemMap[posXIndex].comp:checkIsEmpty() then
			curElementItemMap[posXIndex].comp:cancelRemoveElementItem()
			curElementItemMap[posXIndex].comp:convertToOtherElement(elementId)

			return
		end

		local move = {
			isNew = true,
			itemType = elementConfig.itemType,
			itemParam = tonumber(elementConfig.param),
			toX = posXIndex,
			toY = posYIndex,
			spawnX = posXIndex,
			spawnY = posYIndex
		}

		self.sceneView:spawnNewElementItem(move)
	end
end

return MatchGameSkillEffect_Generate
