-- chunkname: @modules/logic/matchgame/fight/view/skill/skilltarget/MatchGameSkillTargetHandler.lua

module("modules.logic.matchgame.fight.view.skill.skilltarget.MatchGameSkillTargetHandler", package.seeall)

local MatchGameSkillTargetHandler = class("MatchGameSkillTargetHandler")

function MatchGameSkillTargetHandler:handleSkillTarget(targetCoData, skillData, viewContent, skillIndex)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView

	local targetId = targetCoData[1]
	local skillTargetConfig = MatchGameFightConfig.instance:getSkillTargetConfig(targetId)
	local targetType = skillTargetConfig.targetType
	local func = self[string.format("processTarget_%s_%s", targetType, targetId)]

	if func then
		return func(self, targetId, targetCoData, skillData, skillIndex)
	end
end

function MatchGameSkillTargetHandler:processTarget_Board_100(targetId, targetCoData)
	return targetId, {}
end

function MatchGameSkillTargetHandler:processTarget_Range_101(targetId, targetCoData)
	local selectElemenMap = {}
	local rangeId = targetCoData[2]
	local rangeConfig = MatchGameFightConfig.instance:getSkillRangeConfig(rangeId)
	local curElementItemMap = self.sceneView:getElementItemMap()
	local rangeDataList = GameUtil.splitString2(rangeConfig.range, true)

	if rangeConfig.rangeType == MatchGameFightEnum.SkillRangeType.Skill then
		for index, rangeData in ipairs(rangeDataList) do
			local posXIndex = tonumber(rangeData[1])
			local posYIndex = tonumber(rangeData[2])

			if curElementItemMap[posXIndex] and curElementItemMap[posXIndex][posYIndex] then
				selectElemenMap[posXIndex] = selectElemenMap[posXIndex] or {}
				selectElemenMap[posXIndex][posYIndex] = curElementItemMap[posXIndex][posYIndex]
			end
		end
	end

	return targetId, selectElemenMap
end

function MatchGameSkillTargetHandler:processTarget_GemType_102(targetId, targetCoData)
	local selectElementMap = {}
	local elementId = targetCoData[2]
	local curElementItemMap = self.sceneView:getElementItemMap()

	for posXIndex, DataMap in ipairs(curElementItemMap) do
		for posYIndex, elementItem in ipairs(DataMap) do
			if elementItem and elementItem.comp.elementId == elementId then
				selectElementMap[posXIndex] = selectElementMap[posXIndex] or {}
				selectElementMap[posXIndex][posYIndex] = elementItem
			end
		end
	end

	return targetId, selectElementMap
end

function MatchGameSkillTargetHandler:processTarget_RandomColor_103(targetId, targetCoData, skillData, skillIndex)
	local randomNum = tonumber(targetCoData[2])
	local curElementItemMap = self.sceneView:getElementItemMap()
	local beadTypePool = {}
	local elementCareerMap = {}

	for posXIndex, DataMap in ipairs(curElementItemMap) do
		for posYIndex, elementItem in ipairs(DataMap) do
			if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead and not elementCareerMap[elementItem.comp.itemParam] then
				table.insert(beadTypePool, elementItem.comp.itemParam)

				elementCareerMap[elementItem.comp.itemParam] = true
			end
		end
	end

	local skillEffectData = skillData.skillEffectList[skillIndex]

	if skillEffectData then
		for _, effectCoData in ipairs(skillEffectData.effectCoDataList) do
			if effectCoData[1] == MatchGameFightEnum.SkillEffectType.Convert then
				local ignoreCareer = effectCoData[2]

				tabletool.removeValue(beadTypePool, ignoreCareer)
			end
		end
	end

	local selectCareerList = {}

	if not beadTypePool or #beadTypePool == 0 or not randomNum or randomNum <= 0 then
		return targetId, selectCareerList
	end

	local remainPool = tabletool.copy(beadTypePool)
	local selectCareerCount = Mathf.Min(randomNum, #remainPool)

	for i = 1, selectCareerCount do
		local randomIndex = math.random(1, #remainPool)

		table.insert(selectCareerList, remainPool[randomIndex])
		table.remove(remainPool, randomIndex)
	end

	local selectElementMap = {}
	local curElementItemMap = self.sceneView:getElementItemMap()

	for posXIndex, DataMap in ipairs(curElementItemMap) do
		for posYIndex, elementItem in ipairs(DataMap) do
			if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead then
				for _, career in ipairs(selectCareerList) do
					if elementItem.comp.itemParam == career then
						selectElementMap[posXIndex] = selectElementMap[posXIndex] or {}
						selectElementMap[posXIndex][posYIndex] = elementItem

						break
					end
				end
			end
		end
	end

	return targetId, selectElementMap
end

function MatchGameSkillTargetHandler:processTarget_BuffType_105(targetId, targetCoData, skillData)
	local selectElementMap = {}
	local buffType = tonumber(targetCoData[2])
	local curElementItemMap = self.sceneView:getElementItemMap()

	for posXIndex, DataMap in ipairs(curElementItemMap) do
		for posYIndex, elementItem in ipairs(DataMap) do
			if elementItem and elementItem.comp.curBuffType == buffType then
				selectElementMap[posXIndex] = selectElementMap[posXIndex] or {}
				selectElementMap[posXIndex][posYIndex] = elementItem
			end
		end
	end

	return targetId, selectElementMap
end

function MatchGameSkillTargetHandler:processTarget_RandomCount_106(targetId, targetCoData)
	local selectElementMap = {}
	local randomNum = tonumber(targetCoData[2])

	if not randomNum or randomNum <= 0 then
		return targetId, selectElementMap
	end

	local allBeadElementList = {}
	local curElementItemMap = self.sceneView:getElementItemMap()

	for posXIndex, DataMap in ipairs(curElementItemMap) do
		for posYIndex, elementItem in pairs(DataMap) do
			if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead then
				table.insert(allBeadElementList, elementItem)
			end
		end
	end

	local selectCount = Mathf.Min(randomNum, #allBeadElementList)

	for i = 1, selectCount do
		local randomIndex = math.random(1, #allBeadElementList)
		local elementItem = table.remove(allBeadElementList, randomIndex)
		local posXIndex, posYIndex = elementItem.comp.posXIndex, elementItem.comp.posYIndex

		selectElementMap[posXIndex] = selectElementMap[posXIndex] or {}
		selectElementMap[posXIndex][posYIndex] = elementItem
	end

	return targetId, selectElementMap
end

function MatchGameSkillTargetHandler:selectBuffNeighborElement(targetCoData, offsetList)
	local selectElementMap = {}
	local skillBeadType = tonumber(targetCoData[2])
	local curElementItemMap = self.sceneView:getElementItemMap()

	if skillBeadType == MatchGameFightEnum.SkillBeadType.Buff then
		local buffType = tonumber(targetCoData[3])

		for posXIndex, DataMap in ipairs(curElementItemMap) do
			for posYIndex, elementItem in ipairs(DataMap) do
				if elementItem and elementItem.comp.curBuffType == buffType then
					for _, offset in ipairs(offsetList) do
						local neighborXIndex = posXIndex + offset[1]
						local neighborYIndex = posYIndex + offset[2]

						if curElementItemMap[neighborXIndex] then
							local neighborItem = curElementItemMap[neighborXIndex][neighborYIndex]

							if neighborItem and neighborItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead then
								selectElementMap[neighborXIndex] = selectElementMap[neighborXIndex] or {}
								selectElementMap[neighborXIndex][neighborYIndex] = neighborItem
							end
						end
					end
				end
			end
		end
	elseif skillBeadType == MatchGameFightEnum.SkillBeadType.Bead then
		local elementId = tonumber(targetCoData[3])
		local elementConfig = MatchGameFightConfig.instance:getElementConfig(elementId)

		if not elementConfig then
			return selectElementMap
		end

		for posXIndex, DataMap in ipairs(curElementItemMap) do
			for posYIndex, elementItem in ipairs(DataMap) do
				if elementItem and elementItem.comp.elementId == elementId then
					for _, offset in ipairs(offsetList) do
						local neighborXIndex = posXIndex + offset[1]
						local neighborYIndex = posYIndex + offset[2]

						if curElementItemMap[neighborXIndex] then
							local neighborItem = curElementItemMap[neighborXIndex][neighborYIndex]

							if neighborItem and neighborItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead then
								selectElementMap[neighborXIndex] = selectElementMap[neighborXIndex] or {}
								selectElementMap[neighborXIndex][neighborYIndex] = neighborItem
							end
						end
					end
				end
			end
		end

		return selectElementMap
	end

	return selectElementMap
end

function MatchGameSkillTargetHandler:processTarget_Neighbor4_107(targetId, targetCoData)
	return targetId, self:selectBuffNeighborElement(targetCoData, MatchGameFightEnum.FourRangeOffsetList)
end

function MatchGameSkillTargetHandler:processTarget_Neighbor8_108(targetId, targetCoData)
	return targetId, self:selectBuffNeighborElement(targetCoData, MatchGameFightEnum.EightRangeOffsetList)
end

function MatchGameSkillTargetHandler:processTarget_LastClear_109(targetId, targetCoData)
	local lastMatchPosIndex = self.sceneView:getLastMatchSelectPos() or {}
	local selectPosIndex = {}

	selectPosIndex.posXIndex = lastMatchPosIndex.posXIndex
	selectPosIndex.posYIndex = lastMatchPosIndex.posYIndex

	return targetId, selectPosIndex
end

function MatchGameSkillTargetHandler:processTarget_DropRate_110(targetId, targetCoData)
	return targetId, self.sceneView:getGameInfoMo()
end

function MatchGameSkillTargetHandler:processTarget_RoundTime_111(targetId, targetCoData)
	return targetId, self.sceneView:getGameInfoMo()
end

function MatchGameSkillTargetHandler:processTarget_FeverCost_112(targetId, targetCoData)
	return targetId, self.sceneView:getGameInfoMo()
end

function MatchGameSkillTargetHandler:processTarget_CharacterSingle_201(targetId, targetCoData)
	local selectHeroList = {}
	local heroFightInfoMap = MatchGameFightModel.instance:getHeroFightInfoMap()
	local posIndexList = {}

	for posIndex, heroFightMo in pairs(heroFightInfoMap) do
		if heroFightMo and heroFightMo.id ~= 0 then
			table.insert(posIndexList, posIndex)
		end
	end

	if #posIndexList > 0 then
		local randomPosIndex = posIndexList[math.random(1, #posIndexList)]

		table.insert(selectHeroList, heroFightInfoMap[randomPosIndex])
	end

	return targetId, selectHeroList
end

function MatchGameSkillTargetHandler:processTarget_CharacterAll_202(targetId, targetCoData)
	local selectHeroList = {}
	local heroFightInfoMap = MatchGameFightModel.instance:getHeroFightInfoMap()

	for posIndex, heroFightMo in pairs(heroFightInfoMap) do
		if heroFightMo and heroFightMo.id ~= 0 then
			table.insert(selectHeroList, heroFightMo)
		end
	end

	return targetId, selectHeroList
end

function MatchGameSkillTargetHandler:processTarget_MonsterSingle_301(targetId, targetCoData)
	local selectEnemyList = {}
	local enemyInfoMo = self.fightView:getCurEnemyInfoMo()

	if enemyInfoMo then
		table.insert(selectEnemyList, enemyInfoMo)
	end

	return targetId, selectEnemyList
end

MatchGameSkillTargetHandler.instance = MatchGameSkillTargetHandler.New()

return MatchGameSkillTargetHandler
