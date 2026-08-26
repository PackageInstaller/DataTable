-- chunkname: @modules/logic/tower/model/TowerHeroTrialListModel.lua

module("modules.logic.tower.model.TowerHeroTrialListModel", package.seeall)

local TowerHeroTrialListModel = class("TowerHeroTrialListModel", ListScrollModel)

function TowerHeroTrialListModel:onInit()
	self:reInit()
end

function TowerHeroTrialListModel:reInit()
	self.entranceHeroTrialList = {}
	self.curSelectHeroId = 0
end

function TowerHeroTrialListModel:getEntranceHeroTrialList(trialType)
	if not self.entranceHeroTrialList[trialType] then
		self.entranceHeroTrialList[trialType] = {}

		local sameHeroMap = {}

		if trialType == TowerEnum.HeroTrialEntranceType.Normal then
			local allStageHeroList = TowerConfig.instance:getAllStageTrialHeroList()

			for _, heroId in ipairs(allStageHeroList) do
				if not sameHeroMap[heroId] then
					sameHeroMap[heroId] = true

					local trialCoData = self:buildHeroTrialData(heroId)

					table.insert(self.entranceHeroTrialList[trialType], trialCoData)
				end
			end

			local allDeepHeroList = TowerDeepConfig.instance:getAllHeroTrialList()

			for _, heroId in ipairs(allDeepHeroList) do
				if not sameHeroMap[heroId] then
					sameHeroMap[heroId] = true

					local trialCoData = self:buildHeroTrialData(heroId)

					table.insert(self.entranceHeroTrialList[trialType], trialCoData)
				end
			end

			local bossHeroTrialStr = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossHeroTrialList)
			local BossHeroTrialList = string.splitToNumber(bossHeroTrialStr, "|")

			for _, heroId in ipairs(BossHeroTrialList) do
				if not sameHeroMap[heroId] then
					sameHeroMap[heroId] = true

					local trialCoData = self:buildHeroTrialData(heroId)

					table.insert(self.entranceHeroTrialList[trialType], trialCoData)
				end
			end
		elseif trialType == TowerEnum.HeroTrialEntranceType.Compose then
			local allThemeHeroList = TowerComposeConfig.instance:getAllThemeTrialHeroList()

			for _, heroId in ipairs(allThemeHeroList) do
				local trialCoData = self:buildHeroTrialData(heroId)

				table.insert(self.entranceHeroTrialList[trialType], trialCoData)
			end
		end
	end

	return self.entranceHeroTrialList[trialType] or {}
end

function TowerHeroTrialListModel:buildHeroTrialData(trialHeroId)
	local trialCoData = {}

	trialCoData.trialHeroId = trialHeroId
	trialCoData.trialConfig = lua_hero_trial.configDict[trialHeroId][0]
	trialCoData.heroConfig = HeroConfig.instance:getHeroCO(trialCoData.trialConfig.heroId)
	trialCoData.skinConfig = SkinConfig.instance:getSkinCo(trialCoData.trialConfig.skin)

	return trialCoData
end

function TowerHeroTrialListModel:setHeroTrialList(trialType)
	local heroTrialList = self:getEntranceHeroTrialList(trialType)
	local var_5_0

	if self.curSelectHeroId and self.curSelectHeroId > 0 then
		var_5_0 = self.curSelectHeroId

		if not self.curSelectHeroId then
			if heroTrialList[1] then
				var_5_0 = heroTrialList[1].trialHeroId or 0
			end
		end
	end

	self.curSelectHeroId = var_5_0

	self:setList(heroTrialList)
end

function TowerHeroTrialListModel:getTrialHeroCoDataList(trialHeroList)
	local trialHeroCoDataList = {}

	for _, trialHeroId in ipairs(trialHeroList) do
		local trialCoData = self:buildHeroTrialData(trialHeroId)

		table.insert(trialHeroCoDataList, trialCoData)
	end

	return trialHeroCoDataList
end

function TowerHeroTrialListModel:setCurSelectHeroId(heroId)
	self.curSelectHeroId = heroId
end

function TowerHeroTrialListModel:getCurSelectHeroId()
	return self.curSelectHeroId
end

TowerHeroTrialListModel.instance = TowerHeroTrialListModel.New()

return TowerHeroTrialListModel
