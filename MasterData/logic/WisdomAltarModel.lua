-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomaltar/model/WisdomAltarModel.lua

module("logic.extensions.wisdomaltar.model.WisdomAltarModel", package.seeall)

local WisdomAltarModel = class("WisdomAltarModel", BaseModel)
local maxAutoStarUpNum = 100

WisdomAltarModel.OneMode = {
	Auto = 1,
	Smart = 2,
	None = 0
}

function WisdomAltarModel:onInit()
	self._raceIdsRecords = nil
	self._attrsRecords = nil
	self._jobsRecords = nil
	self._availablePets = nil
	self._oneMode = nil
	self._oneModePets = nil
end

function WisdomAltarModel:onReset()
	self:clearPetsInfos()
end

function WisdomAltarModel:setCurPet(mo)
	self._curPet = mo
end

function WisdomAltarModel:getCurPet()
	return self._curPet
end

function WisdomAltarModel:recordPetsInfos()
	self._raceIdsRecords = {}
	self._attrsRecords = {}
	self._jobsRecords = {}
	self._availablePets = nil

	self:_clearCurOneMode()

	local allPets = BagPetsController.instance:getBagPets()

	for k, v in pairs(allPets) do
		local raceId = v.raceId
		local petCo = CharacterConfig.instance:getPetCo(raceId)
		local raceIds = self._raceIdsRecords[raceId]

		if not raceIds then
			raceIds = {}
			self._raceIdsRecords[raceId] = raceIds
		end

		table.insert(raceIds, v)

		local race = self:getFirstAttr(petCo.raceTypes)
		local races = self._attrsRecords[race]

		if not races then
			races = {}
			self._attrsRecords[race] = races
		end

		table.insert(races, v)

		local job = petCo.job
		local jobs = self._jobsRecords[race]

		if not jobs then
			jobs = {}
			self._jobsRecords[job] = jobs
		end

		table.insert(jobs, v)
	end

	self:_sortPetsInfos()
	self:_caculateCurOneMode()
end

function WisdomAltarModel:_sortPetsInfos()
	if self._raceIdsRecords then
		for k, v in pairs(self._raceIdsRecords) do
			table.sort(v, WisdomAltarModel.sortMatsFunc)
		end
	end

	if self._jobsRecords then
		for k, v in pairs(self._jobsRecords) do
			table.sort(v, WisdomAltarModel.sortMatsFunc)
		end
	end

	if self._attrsRecords then
		for k, v in pairs(self._attrsRecords) do
			table.sort(v, WisdomAltarModel.sortMatsFunc)
		end
	end
end

function WisdomAltarModel:clearPetsInfos()
	self._raceIdsRecords = nil
	self._attrsRecords = nil
	self._jobsRecords = nil
	self._availablePets = nil
	self._matsTempTable = nil

	self:_clearCurOneMode()
end

function WisdomAltarModel:getFirstAttr(raceTypes)
	local races = string.split(raceTypes, ",")

	return GameEnum.Races[races[1]]
end

function WisdomAltarModel.sortPetsFunc(x, y)
	if x == y then
		return false
	end

	if x:isLocked() ~= y:isLocked() then
		return x:isLocked()
	end

	local xPetCo = CharacterConfig.instance:getPetCo(x.raceId)
	local yPetCo = CharacterConfig.instance:getPetCo(y.raceId)

	if x.awakeLevel ~= y.awakeLevel then
		return x.awakeLevel > y.awakeLevel
	end

	if x.rare ~= y.rare then
		return x.rare > y.rare
	end

	if x.level ~= y.level then
		return x.level > y.level
	end

	local xInTeam = FormationNewModel.instance:HasPetAtCurFormation(x.petId)
	local yInTeam = FormationNewModel.instance:HasPetAtCurFormation(y.petId)

	if xInTeam and not yInTeam then
		return true
	end

	if not xInTeam and yInTeam then
		return false
	end

	local xPower = x:getFightingPower()
	local yPower = y:getFightingPower()

	if yPower < xPower then
		return true
	end

	if xPower < yPower then
		return false
	end

	return x.petId < y.petId
end

function WisdomAltarModel.sortMatsFunc(x, y)
	if x == y then
		return false
	end

	local xPetCo = CharacterConfig.instance:getPetCo(x.raceId)
	local yPetCo = CharacterConfig.instance:getPetCo(y.raceId)

	if x.rare < y.rare then
		return true
	end

	if x.rare > y.rare then
		return false
	end

	if x.awakeLevel < y.awakeLevel then
		return true
	end

	if x.awakeLevel > y.awakeLevel then
		return false
	end

	if x.level < y.level then
		return true
	end

	if x.level > y.level then
		return false
	end

	local xInTeam = FormationNewModel.instance:HasPetAtCurFormation(x.petId)
	local yInTeam = FormationNewModel.instance:HasPetAtCurFormation(y.petId)

	if xInTeam and not yInTeam then
		return false
	end

	if not xInTeam and yInTeam then
		return true
	end

	local xPower = x:getFightingPower()
	local yPower = y:getFightingPower()

	if yPower < xPower then
		return false
	end

	if xPower < yPower then
		return true
	end

	return false
end

function WisdomAltarModel:getMaterials(data)
	local cfg = CharacterConfig.instance:getPetCo(data.raceId)
	local costCg = CharacterConfig.instance:getPetAwakenCostCfg(cfg.awakenCostStrategyId, data.awakeLevel + 1)

	if not costCg then
		return
	end

	local materials = {}
	local upType = costCg.petCostType

	if upType == GameEnum.PetStarUpStrategy.RaceId then
		for i = 1, costCg.needPetNum do
			local mat = {}

			mat.raceId = data.raceId
			mat.job = cfg.job
			mat.rare = data.rare
			mat.race = self:getFirstAttr(cfg.raceTypes)
			mat.star = costCg.needPetAwakenLv

			table.insert(materials, mat)
		end
	elseif upType == GameEnum.PetStarUpStrategy.Attr then
		for i = 1, costCg.needPetNum do
			local mat = {}

			mat.race = self:getFirstAttr(cfg.raceTypes)
			mat.star = costCg.needPetAwakenLv

			table.insert(materials, mat)
		end
	elseif upType == GameEnum.PetStarUpStrategy.Job then
		for i = 1, costCg.needPetNum do
			local mat = {}

			mat.job = cfg.job
			mat.star = costCg.needPetAwakenLv

			table.insert(materials, mat)
		end
	elseif upType == GameEnum.PetStarUpStrategy.RaceIds then
		local petIds = string.split(costCg.costTypeParams, ",")

		for i = 1, costCg.needPetNum do
			local mat = {}

			mat.raceId = tonumber(petIds[i])

			local petCo = CharacterConfig.instance:getPetCo(mat.raceId)

			mat.race = self:getFirstAttr(petCo.raceTypes)
			mat.job = petCo.job
			mat.rare = data.rare
			mat.star = costCg.needPetAwakenLv

			table.insert(materials, mat)
		end
	end

	return materials
end

function WisdomAltarModel:isMaterialByMatAndData(mat, data)
	if type(data) ~= "table" then
		return ItemConfig.instance:canReplacePet(data, mat.star, mat.raceId, mat.race)
	end

	if mat.star ~= data.awakeLevel then
		return
	end

	if mat.raceId and mat.raceId > 0 then
		return mat.raceId == data.raceId
	end

	local petCo = CharacterConfig.instance:getPetCo(data.raceId)

	if mat.race then
		local race = self:getFirstAttr(petCo.raceTypes)

		return race == mat.race
	end

	if mat.job then
		return petCo.job == mat.job
	end
end

function WisdomAltarModel:isPetAwakable(data)
	self._availablePets = self._availablePets or {}

	if self._availablePets[data.petId] ~= nil then
		return self._availablePets[data.petId]
	end

	local materials, isEnough, needCoinNum, _, extCostItem, trialCondition, alternativeItemEnough = self:getOneMaterials(data)
	local isGoldEnough = MaterialModel.instance:getMaterialsNumber(MatType.Coin, 8) >= checknumber(needCoinNum)
	local isReached = data:reachTrialCondition(trialCondition)

	isEnough = isEnough or alternativeItemEnough
	self._availablePets[data.petId] = isEnough and isGoldEnough and MaterialMgr.getMatEnough(extCostItem) and isReached

	return self._availablePets[data.petId]
end

function WisdomAltarModel:getOneMaterials(data, rareLimit, raresMap)
	if self._availablePets and self._availablePets[data.petId] == false then
		return
	end

	local cfg = CharacterConfig.instance:getPetCo(data.raceId)
	local costCg = CharacterConfig.instance:getPetAwakenCostCfg(cfg.awakenCostStrategyId, data.awakeLevel + 1)

	if not costCg then
		return
	end

	local upType = costCg.petCostType
	local needPetNum = costCg.needPetNum
	local needPetAwakenLv = costCg.needPetAwakenLv

	if upType == GameEnum.PetStarUpStrategy.RaceId then
		self._matsTempTable = self:_getOneMaterialsWithRaceIdType(data, needPetAwakenLv, needPetNum, self._matsTempTable, rareLimit, raresMap)
	elseif upType == GameEnum.PetStarUpStrategy.Attr then
		local raceType = self:getFirstAttr(cfg.raceTypes)

		self._matsTempTable = self:_getOneMaterialsWithAttrType(data, raceType, needPetAwakenLv, needPetNum, self._matsTempTable, rareLimit, raresMap)
	elseif upType == GameEnum.PetStarUpStrategy.Job then
		self._matsTempTable = self:_getOneMaterialsWithJobType(data, cfg.job, needPetAwakenLv, needPetNum, self._matsTempTable, rareLimit, raresMap)
	elseif upType == GameEnum.PetStarUpStrategy.RaceIds then
		local raceIds = string.split(costCg.costTypeParams, ",")

		self._matsTempTable = self:_getOneMaterialsWithRaceIdsType(data, raceIds, needPetAwakenLv, needPetNum, self._matsTempTable, rareLimit, raresMap)
	end

	local itemId = ItemConfig.instance:getReplaceItemId(data.raceId, upType, needPetAwakenLv, self:getFirstAttr(cfg.raceTypes))
	local allNums = 0

	if itemId then
		allNums = allNums + MaterialModel.instance:getMaterialsNumber(MatType.Item, itemId)
	end

	if self._matsTempTable then
		allNums = allNums + #self._matsTempTable
	end

	return self._matsTempTable, self._matsTempTable and needPetNum <= #self._matsTempTable, checknumber(costCg.needCoinNum), costCg.needCoinNum <= MaterialModel.instance:getMaterialsNumber(MatType.Coin, 8), costCg.extCostItem, costCg.trialCondition, needPetNum <= allNums
end

function WisdomAltarModel:_isMaterialMet(data, matData, needPetAwakenLv, rareLimit, raresMap)
	rareLimit = rareLimit or 0

	local petCo = CharacterConfig.instance:getPetCo(matData.raceId)

	if matData:isLocked() then
		return false
	end

	local curBagMo = BagPetsController.instance:GetCurPetMo()

	if curBagMo and matData.petId == curBagMo.petId then
		return false
	end

	if matData ~= data and matData.awakeLevel == needPetAwakenLv and (rareLimit == 0 or rareLimit >= data.rare) then
		if not raresMap then
			return true
		end

		return not self:_isPetCosted(raresMap, data) and not self:_isPetCosted(raresMap, matData)
	end
end

function WisdomAltarModel:_getOneMaterialsWithRaceIdType(data, needPetAwakenLv, num, materials, rareLimit, raresMap)
	local petsOfRaceId = self._raceIdsRecords[data.raceId]

	if materials then
		table.clear(materials)
	end

	if not petsOfRaceId then
		return materials
	end

	for i = 1, #petsOfRaceId do
		if self:_isMaterialMet(data, petsOfRaceId[i], needPetAwakenLv, rareLimit, raresMap) then
			num = num - 1
			materials = materials or {}

			table.insert(materials, petsOfRaceId[i])
		end

		if num <= 0 then
			break
		end
	end

	return materials
end

function WisdomAltarModel:_getOneMaterialsWithAttrType(data, raceType, needPetAwakenLv, num, materials, rareLimit, raresMap)
	local petsOfAttrs = self._attrsRecords[raceType]

	if materials then
		table.clear(materials)
	end

	if not petsOfAttrs then
		return materials
	end

	for i = 1, #petsOfAttrs do
		if self:_isMaterialMet(data, petsOfAttrs[i], needPetAwakenLv, rareLimit, raresMap) then
			num = num - 1
			materials = materials or {}

			table.insert(materials, petsOfAttrs[i])
		end

		if num <= 0 then
			break
		end
	end

	return materials
end

function WisdomAltarModel:_getOneMaterialsWithJobType(data, job, needPetAwakenLv, num, materials, rareLimit, raresMap)
	local petsOfJobs = self._jobsRecords[job]

	if materials then
		table.clear(materials)
	end

	if not petsOfJobs then
		return materials
	end

	for i = 1, #petsOfJobs do
		if self:_isMaterialMet(data, petsOfJobs[i], needPetAwakenLv, rareLimit, raresMap) then
			num = num - 1
			materials = materials or {}

			table.insert(materials, petsOfJobs[i])
		end

		if num <= 0 then
			break
		end
	end

	return materials
end

function WisdomAltarModel:_getOneMaterialsWithRaceIdsType(data, raceIds, needPetAwakenLv, num, materials, rareLimit, raresMap)
	if materials then
		table.clear(materials)
	end

	for i = 1, num do
		local raceId = tonumber(raceIds[i])
		local petsOfRaceId = self._raceIdsRecords[raceId]

		if not petsOfRaceId then
			break
		end

		for j = 1, #petsOfRaceId do
			if self:_isMaterialMet(data, petsOfRaceId[j], needPetAwakenLv, rareLimit, raresMap) then
				num = num - 1
				materials = materials or {}

				table.insert(materials, petsOfRaceId[j])

				break
			end
		end

		if num <= 0 then
			break
		end
	end

	return materials
end

function WisdomAltarModel:getCurOneMode()
	return self._oneMode
end

function WisdomAltarModel:getCurOneModePets()
	return self._oneModePets
end

function WisdomAltarModel:_caculateCurOneMode()
	if self._oneMode then
		return
	end

	self:_calculateOneMode(WisdomAltarModel.OneMode.Auto)

	if not self._oneMode then
		self:_calculateOneMode(WisdomAltarModel.OneMode.Smart)
	end

	self._oneMode = self._oneMode or WisdomAltarModel.OneMode.None
end

function WisdomAltarModel:_calculateOneMode(mode)
	local raresMap = self:_generateRaresMap(mode)
	local oneMos = self:_getAllOneMos(raresMap, mode)

	if oneMos and #oneMos > 0 then
		self._oneMode = mode
		self._oneModePets = oneMos
	end
end

function WisdomAltarModel:_generateRaresMap(mode)
	local pets = BagPetsController.instance:getBagPets()
	local raresMap = {}

	for k, v in pairs(pets) do
		local petCo = CharacterConfig.instance:getPetCo(v.raceId)

		raresMap[v.rare] = raresMap[v.rare] or {}

		local petCos = raresMap[v.rare]

		petCos[v.awakeLevel] = petCos[v.awakeLevel] or {}

		local petByStars = petCos[v.awakeLevel]

		petByStars[v.petId] = v
	end

	return raresMap
end

function WisdomAltarModel:_getAllOneMos(raresMap, mode)
	local wisdomAltarsOne = WisdomAltarConfig.instance:getWisdomaltarConfigs(mode)
	local oneMaterials, oneExtMats
	local totalMoney = 0

	for k, v in pairs(wisdomAltarsOne) do
		if raresMap[v.rare] and raresMap[v.rare][v.awakeLevel] then
			petsByStars = raresMap[v.rare][v.awakeLevel]

			local onePets = {}

			for k, v in pairs(petsByStars) do
				table.insert(onePets, v)
			end

			table.sort(onePets, WisdomAltarModel.sortPetsFunc)

			local matMap = {}

			for i = 1, #onePets do
				self._tempMode = mode

				local materials, isEnough, needCoinNum, _, extCostItem = self:getOneMaterials(onePets[i], v.mat_rare, raresMap)

				self._tempMode = nil

				if isEnough then
					self:_costPet(raresMap, onePets[i])

					for j = 1, #materials do
						self:_costPet(raresMap, materials[j])
					end

					oneMaterials = oneMaterials or {}

					local oneMo = WisdomAltarOneMo.New()

					oneMo.materials = {}

					table.merge(oneMo.materials, materials)

					oneMo.petData = onePets[i]
					oneMo.goldCost = needCoinNum
					oneMo.extCostItem = extCostItem
					oneExtMats = oneExtMats or {}

					local arr = string.split(extCostItem, ":")
					local matType = checknumber(arr[1])
					local matId = checknumber(arr[2])
					local matNum = checknumber(arr[3])
					local matKey = matType .. ":" .. matId

					if matMap[matKey] == nil then
						matMap[matKey] = 0
					end

					local isMatEnough = matMap[matKey] + matNum <= MaterialModel.instance:getMaterialsNumber(matType, matId)

					if isMatEnough and totalMoney + needCoinNum > MaterialModel.instance:getMaterialsNumber(MatType.Coin, 8) then
						isMatEnough = false
					end

					if isMatEnough then
						matMap[matKey] = matMap[matKey] + matNum
						totalMoney = totalMoney + needCoinNum

						table.insert(oneMaterials, oneMo)

						if #oneMaterials >= maxAutoStarUpNum then
							return oneMaterials
						end
					end
				end
			end
		end
	end

	return oneMaterials
end

function WisdomAltarModel:_isPetCosted(raresMap, petData)
	local petCo = CharacterConfig.instance:getPetCo(petData.raceId)
	local rare = petData.rare

	if raresMap[rare] and raresMap[rare][petData.awakeLevel] then
		petsByStars = raresMap[rare][petData.awakeLevel]

		return not petsByStars[petData.petId]
	end
end

function WisdomAltarModel:_costPet(raresMap, petData)
	local petCo = CharacterConfig.instance:getPetCo(petData.raceId)
	local rare = petData.rare

	if raresMap[rare] and raresMap[rare][petData.awakeLevel] then
		petsByStars = raresMap[rare][petData.awakeLevel]
		petsByStars[petData.petId] = nil
	end
end

function WisdomAltarModel:_clearCurOneMode()
	self._oneMode = nil
	self._oneModePets = nil
end

WisdomAltarModel.instance = WisdomAltarModel.New()

return WisdomAltarModel
