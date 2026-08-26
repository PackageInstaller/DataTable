-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterMonsterModel.lua

module("modules.logic.survival.model.shelter.SurvivalShelterMonsterModel", package.seeall)

local SurvivalShelterMonsterModel = class("SurvivalShelterMonsterModel", BaseModel)

function SurvivalShelterMonsterModel:calBuffIsRepress(buffId)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local fight = weekInfo:getMonsterFight()
	local survivalIntrudeSchemeMo = fight:getIntrudeSchemeMo(buffId)

	return survivalIntrudeSchemeMo.survivalIntrudeScheme.repress
end

function SurvivalShelterMonsterModel:getMonsterSelectNpc()
	local list = {}
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local npcDict = weekInfo.npcDict

	if npcDict then
		for _, v in pairs(npcDict) do
			if self:isFilterNpc(v.co) then
				table.insert(list, v)
			end
		end
	end

	if #list > 1 then
		table.sort(list, SurvivalShelterNpcMo.sort)
	end

	return list
end

local allBuffTags = {}
local lastFightId

function SurvivalShelterMonsterModel:calRecommendNum(npcId)
	if npcId == nil then
		return 0
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local fight = weekInfo:getMonsterFight()

	if lastFightId == nil or lastFightId ~= fight.fightId then
		local schemes = fight.schemes

		if allBuffTags then
			tabletool.clear(allBuffTags)
		end

		for buffId, _ in pairs(schemes) do
			local needTags = SurvivalConfig.instance:getMonsterBuffConfigTag(buffId)

			for j = 1, #needTags do
				allBuffTags[#allBuffTags + 1] = needTags[j]
			end
		end

		lastFightId = fight.fightId
	end

	local npcTags = SurvivalConfig.instance:getNpcConfigTag(npcId)
	local num = 0

	if npcTags then
		for i = 1, #npcTags do
			local tag = npcTags[i]

			for j = 1, #allBuffTags do
				if tag == allBuffTags[j] then
					num = num + 1

					break
				end
			end
		end
	end

	return num
end

function SurvivalShelterMonsterModel:isNeedNpcTag(npcTag)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local fight = weekInfo:getMonsterFight()
	local schemes = fight.schemes

	for buffId, _ in pairs(schemes) do
		local needTags = SurvivalConfig.instance:getMonsterBuffConfigTag(buffId)

		for j = 1, #needTags do
			if needTags[j] == npcTag then
				return true
			end
		end
	end

	return false
end

SurvivalShelterMonsterModel.instance = SurvivalShelterMonsterModel.New()

return SurvivalShelterMonsterModel
