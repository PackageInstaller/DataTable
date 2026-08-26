-- chunkname: @modules/logic/survival/model/shelter/ShelterRestGroupModel.lua

module("modules.logic.survival.model.shelter.ShelterRestGroupModel", package.seeall)

local ShelterRestGroupModel = class("ShelterRestGroupModel", SurvivalInitGroupModel)

function ShelterRestGroupModel:initViewParam(viewParam)
	self.curClickHeroIndex = viewParam.index
	self.buildingId = viewParam.buildingId

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self.buildingInfo = weekInfo:getBuildingInfo(self.buildingId)

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.Survival)
	self:refreshHeroList()
end

function ShelterRestGroupModel:refreshHeroList()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local healthMax = weekInfo:getAttr(SurvivalEnum.AttrType.HeroHealthMax)

	self.selectHeroDict = {}

	for heroId, pos in pairs(self.buildingInfo.heros) do
		self.selectHeroDict[pos] = heroId
	end

	local moList = {}
	local repeatHero = {}

	for i = 1, self:getCarryHeroCount() do
		local pos = i - 1
		local heroId = self.selectHeroDict[pos]

		if heroId then
			local heroMo = HeroModel.instance:getByHeroId(heroId)

			table.insert(moList, heroMo)

			repeatHero[heroId] = true
		end
	end

	for i, mo in ipairs(CharacterBackpackCardListModel.instance:getCharacterCardList()) do
		if not repeatHero[mo.heroId] then
			repeatHero[mo.heroId] = true

			local heroMo = weekInfo:getHeroMo(mo.heroId)
			local health = heroMo.health

			if health < healthMax then
				table.insert(moList, mo)
			end
		end
	end

	self._heroId2Index = {}

	for i, mo in ipairs(moList) do
		self._heroId2Index[mo.heroId] = i
	end

	table.sort(moList, ShelterRestGroupModel.sortHeroList)
	self:setList(moList)
end

function ShelterRestGroupModel.sortHeroList(a, b)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local healthA = weekInfo:getHeroMo(a.heroId).health or 0
	local healthB = weekInfo:getHeroMo(b.heroId).health or 0

	if healthA ~= healthB then
		return healthA < healthB
	end

	if not ShelterRestGroupModel.instance._heroId2Index[a.heroId] then
		local indexA = 0

		if not ShelterRestGroupModel.instance._heroId2Index[b.heroId] then
			local indexB = 0

			if indexA ~= indexB then
				return indexA < indexB
			end

			return false
		end
	end
end

function ShelterRestGroupModel:getMoIndex(heroMo)
	for pos, heroId in pairs(self.selectHeroDict) do
		if heroId == heroMo.heroId then
			return pos + 1
		end
	end

	return -1
end

function ShelterRestGroupModel:trySetHeroMo(heroMo)
	if heroMo then
		for pos, heroId in pairs(self.selectHeroDict) do
			if heroId == heroMo.heroId then
				self.selectHeroDict[pos] = nil

				break
			end
		end
	end

	self.selectHeroDict[self.curClickHeroIndex - 1] = heroMo.heroId
end

function ShelterRestGroupModel:tryAddHeroMo(heroMo)
	for pos, heroId in pairs(self.selectHeroDict) do
		if heroId == heroMo.heroId then
			self.selectHeroDict[pos] = nil

			return
		end
	end

	for i = 1, self:getCarryHeroCount() do
		local pos = i - 1

		if not self.selectHeroDict[pos] then
			self.selectHeroDict[pos] = heroMo.heroId

			return i
		end
	end
end

function ShelterRestGroupModel:getCarryHeroCount()
	return self.buildingInfo:getAttr(SurvivalEnum.AttrType.LoungeRoleNum)
end

function ShelterRestGroupModel:isHeroFull()
	return tabletool.len(self.allSelectHeroMos) == self:getCarryHeroCount()
end

function ShelterRestGroupModel:saveHeroGroup()
	local heroCount = self:getCarryHeroCount()
	local heroIds = {}

	for i = 1, heroCount do
		if not self.selectHeroDict[i - 1] then
			table.insert(heroIds, self.selectHeroDict[i - 1])
		end
	end

	SurvivalWeekRpc.instance:sendSurvivalBatchHeroChangePositionRequest(heroIds, self.buildingId)
end

ShelterRestGroupModel.instance = ShelterRestGroupModel.New()

return ShelterRestGroupModel
