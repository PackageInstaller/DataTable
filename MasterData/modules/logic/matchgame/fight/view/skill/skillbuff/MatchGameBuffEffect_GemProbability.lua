-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameBuffEffect_GemProbability.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameBuffEffect_GemProbability", package.seeall)

local MatchGameBuffEffect_GemProbability = class("MatchGameBuffEffect_GemProbability")

function MatchGameBuffEffect_GemProbability:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameBuffEffect_GemProbability:progressBuff_104(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local gameInfoMo = self.sceneView:getGameInfoMo()

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
	self:refreshElementDropRate(gameInfoMo)
end

function MatchGameBuffEffect_GemProbability:getCurRandomElementIdList(careerNum)
	local elementItemMap = self.sceneView:getElementItemMap()
	local elementCareerMap = {}
	local allElementIdList = {}

	for posXIndex, itemMap in pairs(elementItemMap) do
		for posYIndex, elementItem in pairs(itemMap) do
			if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead and not elementCareerMap[elementItem.comp.itemParam] then
				elementCareerMap[elementItem.comp.itemParam] = true

				table.insert(allElementIdList, elementItem.comp.elementId)
			end
		end
	end

	local elementIdList = {}

	while careerNum > #elementIdList and #allElementIdList > 0 do
		local randomIndex = math.random(1, #allElementIdList)

		table.insert(elementIdList, allElementIdList[randomIndex])
		table.remove(allElementIdList, randomIndex)
	end

	return elementIdList
end

function MatchGameBuffEffect_GemProbability:progressBuff_105(buffEffectData, targetInfoList, skillData, skillBuffMo)
	skillBuffMo.effectData.elementIdList = self:getCurRandomElementIdList(buffEffectData[2])

	local gameInfoMo = self.sceneView:getGameInfoMo()

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
	self:refreshElementDropRate(gameInfoMo)
end

function MatchGameBuffEffect_GemProbability:refreshElementDropRate(targetObj, removeSkillBuffMo)
	local removeBuffUid = removeSkillBuffMo and removeSkillBuffMo:getBuffUid()
	local skillBuffMoList = {}

	for buffUid, skillBuffMo in pairs(targetObj.skillBuffMoMap or {}) do
		if buffUid ~= removeBuffUid and (skillBuffMo.buffEffectId == 104 or skillBuffMo.buffEffectId == 105) then
			table.insert(skillBuffMoList, skillBuffMo)
		end
	end

	table.sort(skillBuffMoList, function(a, b)
		return a.buffUidSeq < b.buffUidSeq
	end)

	local elementDropRateMap = MatchGameFightModel.instance:getSkillElementDropRateMap()

	for elementId in pairs(elementDropRateMap) do
		elementDropRateMap[elementId] = nil
	end

	for _, skillBuffMo in ipairs(skillBuffMoList) do
		local buffEffectData = string.splitToNumber(skillBuffMo.buffConfig.buffEffect, "#")

		if skillBuffMo.buffEffectId == 104 then
			MatchGameFightModel.instance:setElementDropRateMap(buffEffectData[2], buffEffectData[3])
		else
			for _, elementId in ipairs((not skillBuffMo.effectData.elementIdList or nil) and {}) do
				MatchGameFightModel.instance:setElementDropRateMap(elementId, buffEffectData[3])
			end
		end
	end
end

function MatchGameBuffEffect_GemProbability:removeBuff_104(buffEffectData, targetObj, skillBuffMo)
	self:refreshElementDropRate(targetObj, skillBuffMo)
end

function MatchGameBuffEffect_GemProbability:removeBuff_105(buffEffectData, targetObj, skillBuffMo)
	self:refreshElementDropRate(targetObj, skillBuffMo)
end

return MatchGameBuffEffect_GemProbability
