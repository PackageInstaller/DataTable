-- chunkname: @modules/logic/rouge2/start/controller/Rouge2_SystemController.lua

module("modules.logic.rouge2.start.controller.Rouge2_SystemController", package.seeall)

local Rouge2_SystemController = class("Rouge2_SystemController", BaseController)

function Rouge2_SystemController:isRecommendHero(heroId)
	local isGetFromSkill = Rouge2_BackpackController.instance:isHeroGetFromActiveSkill(heroId)

	if isGetFromSkill then
		return true
	end

	local curSystemId = Rouge2_Model.instance:getCurTeamSystemId()

	if not heroId or not curSystemId or curSystemId == Rouge2_Enum.UnselectTeamSystemId then
		return
	end

	return self:checkHeroContainBattleTag(heroId, tostring(curSystemId))
end

function Rouge2_SystemController:getHeroMo(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if not heroMo then
		local trialCo = Rouge2_BackpackController.instance:getTrialConfigByHeroId(heroId)

		if trialCo then
			heroMo = HeroMo.New()

			heroMo:initFromTrial(trialCo.id, trialCo.trialTemplate)
		end
	end

	return heroMo
end

function Rouge2_SystemController:getHeroListByBattleTag(tagId)
	local resultList = {}
	local checkHeroIdMap = {}

	self:_checkHeroBattleTag(tagId, resultList, checkHeroIdMap)
	self:_checkHeroBattleTag("10000", resultList, checkHeroIdMap)

	local allHeroList = Rouge2_BackpackController.instance:getAllHeroIdList()

	if allHeroList then
		for _, heroId in ipairs(allHeroList) do
			if not checkHeroIdMap[heroId] then
				if self:checkHeroContainBattleTag(heroId, tagId) then
					local heroCo = HeroConfig.instance:getHeroCO(heroId)

					table.insert(resultList, heroCo)
				end

				checkHeroIdMap[heroId] = true
			end
		end
	end

	return resultList
end

function Rouge2_SystemController:_checkHeroBattleTag(tagId, resultList, checkHeroIdMap)
	resultList = resultList or {}
	checkHeroIdMap = checkHeroIdMap or {}

	local heroList = HeroConfig.instance:getHeroListByBattleTag(tagId)

	if heroList then
		for _, heroCo in ipairs(heroList) do
			local heroId = heroCo.id

			if not checkHeroIdMap[heroId] then
				if self:checkHeroContainBattleTag(heroId, tagId) then
					table.insert(resultList, heroCo)
				end

				checkHeroIdMap[heroId] = true
			end
		end
	end

	return resultList, checkHeroIdMap
end

function Rouge2_SystemController:checkHeroContainBattleTag(heroId, tagId)
	local battleTagList = self:getHeroBattleTagList(heroId)

	return (self:isContainBattleTag(battleTagList, tagId))
end

function Rouge2_SystemController:getHeroBattleTagList(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if not heroMo then
		return HeroConfig.instance:getHeroBattleTagList(heroId)
	end

	local battleTagStr = heroMo:getHeroBattleTag()

	return battleTagStr and string.split(battleTagStr, "#")
end

function Rouge2_SystemController:isContainBattleTag(tagList, targetTag)
	if not tagList or not targetTag then
		return
	end

	for _, tag in ipairs(tagList) do
		if tag == targetTag or tag == "10000" and targetTag ~= "101" and targetTag ~= "102" or targetTag == "10000" and tag ~= "101" and tag ~= "102" then
			return true
		end
	end
end

function Rouge2_SystemController:hasAnyRecommendHero(battleTag)
	if string.nilorempty(battleTag) then
		return
	end

	local allHeroList = Rouge2_BackpackController.instance:getAllHeroIdList()

	if allHeroList then
		for _, heroId in ipairs(allHeroList) do
			if self:checkHeroContainBattleTag(heroId, battleTag) then
				return true
			end
		end
	end
end

function Rouge2_SystemController:checkCurTeamSystemId()
	local curTeamSystemId = Rouge2_Model.instance:getCurTeamSystemId()

	if not curTeamSystemId or curTeamSystemId == Rouge2_Enum.UnselectTeamSystemId then
		return
	end

	local careerId = Rouge2_Model.instance:getCareerId()

	if Rouge2_CareerConfig.instance:isCareerRecommendSystem(careerId, curTeamSystemId) then
		return
	end

	Rouge2_Rpc.instance:sendRouge2SetSystemIdRequest(Rouge2_Enum.UnselectTeamSystemId)
end

Rouge2_SystemController.instance = Rouge2_SystemController.New()

return Rouge2_SystemController
