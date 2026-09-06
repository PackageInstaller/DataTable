-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/model/CutePetModel.lua

module("logic.extensions.cutepet.model.CutePetModel", package.seeall)

local CutePetModel = class("CutePetModel", BaseModel)

CutePetModel.ReadFlag = "CutePetModel.ReadFlag"
CutePetModel.SortType = {
	Score = -5,
	Quality = -2,
	Time = -4,
	Discard = -6,
	Level = -1,
	Star = -3
}

function CutePetModel:onInit()
	self.CUTEPET_IN_GARDEN_SCENE_MAX_COUNT = CutePetConfig.instance:getCommonValue("CutePetInGardenSceneMaxCount", true)

	self:onReset()
end

function CutePetModel:onReset()
	self._isInit = false
	self._curPetId = nil
	self._cutePetsCount = 0
	self._cutePetMap = {}
	self.buildingLevel = {}
	self._guestHouseGenSlotTime = 0
	self._slotInfo = nil
	self.gainedRace = nil
	self.myCurIllusionCutePetRace = 0
	self.hasGainPrize = false
	self.happiness = nil
	self._isGetInfoed = false
	self._teamTravelSelectMo = nil
	self._showCount = 0
	self._myPetTravelInfo = nil
	self._myPetPresetInfo = nil
	self._buddyInfoMap = {}
end

function CutePetModel:SetCurPetId(petId)
	self._curPetId = petId
end

function CutePetModel:GetCurPetId()
	return self._curPetId
end

function CutePetModel:setInfo(msg)
	local list = self:addCutePetMos(msg.cutePets) or {}

	for i, v in ipairs(list) do
		if v:getState(CutePetMo.STATE_GARDEN_SHOW) == true then
			self._showCount = self._showCount + 1
		end
	end

	self._isGetInfoed = true

	if self._isInit == false then
		self._isInit = true

		BagPetsController.instance:calcAllCutePetAttr()
	end

	self.buildingLevel[CutePetBuildingType.Management] = msg.gardenLvl

	local isCanLvUp = false
	local nextGardenCfg = CutePetConfig.instance:getGardenCfg(msg.gardenLvl + 1)

	if nextGardenCfg then
		local matType, matId, matNumber = MaterialMgr.getMatParams(nextGardenCfg.lvlUpMaterialCost)

		isCanLvUp = MaterialModel.instance:IsEnough(matType, matId, matNumber)
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_CUTEPET_MANAGEMENT, isCanLvUp)
end

function CutePetModel:setPetInteractHasGet(boo)
	self.hasGainPrize = boo
end

function CutePetModel:setPetInteractInfo(msg)
	self.happiness = GameUtil.pbToTable(msg.happiness)
end

function CutePetModel:getIsInit()
	return self._isInit
end

function CutePetModel:updateCuteSuit(msg)
	self.gainedRace = GameUtil.pbToTable(msg.gainedRace)
	self.myCurIllusionCutePetRace = msg.myCurIllusionCutePetRace
end

function CutePetModel:getCuteSuit()
	return self.gainedRace or {}
end

function CutePetModel:unLockCuteSuit(race)
	for i, v in ipairs(self.gainedRace) do
		if v.raceId == race then
			v.unLocked = true
		end
	end
end

function CutePetModel:getCuteSuitInfo(raceId)
	if self.gainedRace then
		for i, v in ipairs(self.gainedRace) do
			if v.raceId == raceId then
				return v
			end
		end
	end
end

function CutePetModel:getAllCutePetsList(filterFunc)
	local resultList = {}

	for i, v in pairs(self._cutePetMap) do
		if not filterFunc or GameUtil.callBack(filterFunc, v) == true then
			table.insert(resultList, v)
		end
	end

	return resultList
end

function CutePetModel:addCutePetMo(info)
	if info then
		if info.deleted then
			if self._cutePetMap[info.uniqueId] and self._cutePetMap[info.uniqueId]:getState(CutePetMo.STATE_GARDEN_SHOW) == true then
				self._showCount = math.max(self._showCount - 1, 0)
			end

			self._cutePetMap[info.uniqueId] = nil
			self._cutePetsCount = math.max(0, self._cutePetsCount - 1)
		else
			local mo = self._cutePetMap[info.uniqueId]

			if mo == nil then
				if not CutePetConfig.instance:getCutePetById(info.raceId) then
					return nil
				end

				mo = CutePetMo.New()
				self._cutePetsCount = self._cutePetsCount + 1

				mo:initData(info)

				if self._isGetInfoed then
					self:checkAndSetGardenShowState(mo)
				end

				self._cutePetMap[info.uniqueId] = mo

				BagPetsController.instance:updateCutePetAttrById(mo.equippedPetId)

				return mo
			else
				mo:initData(info)
				BagPetsController.instance:updateCutePetAttrById(mo.equippedPetId)

				return nil
			end
		end
	end

	return nil
end

function CutePetModel:addCutePetMos(changedInfos)
	local list

	for i, v in ipairs(changedInfos or {}) do
		local mo = self:addCutePetMo(v)

		if mo then
			list = list or {}

			table.insert(list, mo)
		end
	end

	return list
end

function CutePetModel:checkAndSetGardenShowState(cutePetMo)
	if self._cutePetMap then
		local num = 0

		for k, mo in pairs(self._cutePetMap) do
			if mo:getState(CutePetMo.STATE_GARDEN_SHOW) then
				num = num + 1

				if num >= self.CUTEPET_IN_GARDEN_SCENE_MAX_COUNT then
					return false
				end
			end
		end

		return true
	end

	return false
end

function CutePetModel:getAllCutePet()
	return self._cutePetMap
end

function CutePetModel:getCutePeMo(id)
	return self._cutePetMap[id]
end

function CutePetModel:getCutePetsCount()
	return self._cutePetsCount
end

function CutePetModel:getShowCount()
	return self._showCount
end

function CutePetModel:setShowCount(count)
	self._showCount = count
end

function CutePetModel:getCutePetItemNumByDefineId(defindId)
	local num = 0

	for i, v in pairs(self._cutePetMap) do
		if v.raceId and v.raceId == defindId then
			num = num + 1
		end
	end

	return num
end

function CutePetModel:getCutePetCapacity()
	local managementCfg = CutePetConfig.instance:getGardenCfg(self.buildingLevel[CutePetBuildingType.Management])

	if managementCfg then
		return managementCfg.cutePetCapacity
	else
		return 0
	end
end

function CutePetModel:getBuildingLevel(buildType)
	return checknumber(self.buildingLevel[buildType])
end

function CutePetModel:setGuestInfo(msg)
	self._guestHouseGenSlotTime = checknumber(msg.guestHouseGenSlotTime) / 1000
	self._slotInfo = GameUtil.pbToTable(msg.slotInfo)
end

function CutePetModel:getGuestComeTime()
	return self._guestHouseGenSlotTime
end

function CutePetModel:getGuestSlotInfo()
	return self._slotInfo or {}
end

function CutePetModel:getSelectGoodCuteTips()
	return GameUtil.getUserDayData(CutePetModel.ReadFlag .. "#GoodTip")
end

function CutePetModel:saveSelectGoodCuteTips()
	return GameUtil.saveUserDayData(CutePetModel.ReadFlag .. "#GoodTip", true)
end

function CutePetModel:gardenLevelUp()
	self.buildingLevel[CutePetBuildingType.Management] = self.buildingLevel[CutePetBuildingType.Management] + 1

	local isCanLvUp = false
	local nextGardenCfg = CutePetConfig.instance:getGardenCfg(self.buildingLevel[CutePetBuildingType.Management] + 1)

	if nextGardenCfg then
		local matType, matId, matNumber = MaterialMgr.getMatParams(nextGardenCfg.lvlUpMaterialCost)

		isCanLvUp = MaterialModel.instance:IsEnough(matType, matId, matNumber)
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_CUTEPET_MANAGEMENT, isCanLvUp)
end

function CutePetModel:setTravelTimeInfo(msg)
	self._travelTime = msg.todayHasTravelCount
end

function CutePetModel:getTravelTime()
	return checknumber(self._travelTime)
end

function CutePetModel:initAdventureBuilding(buildingCount)
	self._buildingInfo = {}

	for i = 1, buildingCount do
		local buildingCfg = CutePetConfig.instance:getAdventureBuildingCfg(i, 1)
		local mo = {
			balanceTime = 0,
			stashNum = 0,
			cutePetId = 0,
			buildingId = i,
			buildingLvl = (buildingCfg and buildingCfg.gardenMinLvlLimit <= self.buildingLevel[CutePetBuildingType.Management] or nil) and true and 1 or 0,
			cfg = buildingCfg
		}

		table.insert(self._buildingInfo, mo)
	end
end

function CutePetModel:setAdventureInfos(msg)
	for i, v in ipairs(msg.building or {}) do
		self:setAdventureInfo(v)
	end
end

function CutePetModel:setAdventureInfo(info)
	self._buildingInfo[info.buildingId].buildingId = info.buildingId
	self._buildingInfo[info.buildingId].buildingLvl = info.buildingLvl
	self._buildingInfo[info.buildingId].cutePetId = info.cutePetId
	self._buildingInfo[info.buildingId].stashNum = info.stashNum
	self._buildingInfo[info.buildingId].balanceTime = info.balanceTime
	self._buildingInfo[info.buildingId].cfg = CutePetConfig.instance:getAdventureBuildingCfg(info.buildingId, info.buildingLvl)

	self:_calcRedPointBuildingOneKey()
end

function CutePetModel:getAdvAllBuildingInfo()
	return self._buildingInfo or {}
end

function CutePetModel:getAdvBuildingInfo(buildingId)
	return self._buildingInfo[buildingId]
end

function CutePetModel:_calcRedPointBuildingOneKey()
	local hasMax = false

	for i, v in pairs(self._buildingInfo) do
		local matNum = 0

		_, _, matNum = MaterialMgr.getMatParams(v.cfg.unitTimeOutputResource)

		if v.stashNum >= v.cfg.buildCapacityFen * matNum then
			hasMax = true

			break
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_CUTEPET_ADVENTURE_ONEKEY, hasMax)
end

function CutePetModel:setCommunityNewsInfo(msg)
	self._communitynewsinfo = GameUtil.pbToTable(msg.news)
end

function CutePetModel:getCommunityNewsInfo()
	return self._communitynewsinfo
end

function CutePetModel:setTeamTravelSelectMo(mo)
	self._teamTravelSelectMo = mo
end

function CutePetModel:getTeamTravelSelectMo()
	return self._teamTravelSelectMo
end

function CutePetModel:setTeamTravelReceiveMo(msg)
	self._teamTravelReceiveMo = GameUtil.pbToTable(msg.receiverCutePet or msg.inviterCutePet)
end

function CutePetModel:getTeamTravelReceiveMo()
	return self._teamTravelReceiveMo
end

function CutePetModel:setCurPairingToken(pairingToken)
	self._pairingToken = pairingToken
end

function CutePetModel:getCurPairingToken()
	return self._pairingToken
end

function CutePetModel:calcByCutePetAttrs(cutePet, isMyPackPet)
	if cutePet == nil then
		return {}
	end

	if isMyPackPet == true then
		if checknumber(cutePet.cutePetId) <= 0 then
			return {}
		end

		local cutePetMo = self:getCutePeMo(cutePet.cutePetId)

		if cutePetMo == nil then
			return {}
		end

		local result = {}

		for i, v in pairs(cutePetMo.attr) do
			result[i] = v
		end

		result[AttrMo.KEY_DIRECT_ZDL] = cutePetMo.zdl

		return result
	else
		local attr = {}

		if checknumber(cutePet.cutePetRaceId) <= 0 then
			return {}
		end

		local initialProps = {}

		for i, v in ipairs(cutePet.initialProps or {}) do
			initialProps[v.propClientIndex] = v.propValue
		end

		local result = {}
		local raceCfg = CutePetConfig.instance:getCutePetById(cutePet.cutePetRaceId)
		local starCfg = CutePetConfig.instance:getStarUpCfg(raceCfg.starUpPlan, (not cutePet.star or nil) and 1)
		local result1 = FightingPowerFormula.instance:parseAttrValues(starCfg.starProps)
		local plan = CutePetConfig.instance:getQualityUpPlan(raceCfg.qualityUpPlan)

		for i, v in ipairs(plan) do
			if v.quality <= (cutePet.quality or 1) then
				for j, attrType in ipairs(v.newActivePropTypes) do
					local typeIndex = FightingPowerFormula.instance:getAttrTypeByName(attrType)

					result[typeIndex] = checknumber(result[typeIndex]) + checknumber(initialProps[typeIndex]) + checknumber(result1[typeIndex])
				end
			end
		end

		attr = AttrMo.addSameAttrs(result, attr)
		result = {}

		local levelCfg = CutePetConfig.instance:getLevelUpCfg(raceCfg.lvlUpPlan, cutePet.lvl or 1)
		local result = FightingPowerFormula.instance:parseAttrValues(levelCfg.levelProps)
		local qualityCfg = CutePetConfig.instance:getQualityUpCfg(raceCfg.qualityUpPlan, (not cutePet.quality or nil) and 1)

		for i, v in pairs(result) do
			result[i] = result[i] * (1 + qualityCfg.propsRate)
		end

		attr = AttrMo.addSameAttrs(result, attr)
		result = {}

		local starSkillCfg = CutePetConfig.instance:getStarSkillCfg(cutePet.cutePetRaceId, cutePet.star or 1)

		attr[AttrMo.KEY_DIRECT_ZDL] = starSkillCfg.numZdl

		return attr
	end

	return {}
end

function CutePetModel:setFirstEnter(bool, changeSetId)
	self._firstEnterGarden = bool
	self._tempChangeSetId = changeSetId
end

function CutePetModel:getFirstEnter()
	return self._firstEnterGarden
end

function CutePetModel:getTempChangeSetId()
	return self._tempChangeSetId
end

function CutePetModel:setMyPetTravelInfo(msg)
	self._myPetTravelInfo = msg
end

function CutePetModel:getMyPetTravelInfo()
	return self._myPetTravelInfo
end

function CutePetModel:setMyPetPresetInfo(msg)
	self._myPetPresetInfo = GameUtil.pbToTable(msg)
end

function CutePetModel:getMyPetPresetInfo()
	return self._myPetPresetInfo
end

function CutePetModel:onAddPresetCute(msg)
	if self._myPetPresetInfo then
		if not self._myPetPresetInfo.presetCutePetList then
			local info = GameUtil.pbToTable(msg)
			local exists = false

			for i, petInfo in ipairs(self._myPetPresetInfo.presetCutePetList) do
				if petInfo.uniqueId == info.PresetCutePet.uniqueId then
					petInfo.cutePet = info.PresetCutePet.cutePet
					exists = true

					break
				end
			end

			if not exists then
				table.insert(self._myPetPresetInfo.presetCutePetList, info.PresetCutePet)
			end

			self._myPetPresetInfo.presetCutePetList = self._myPetPresetInfo.presetCutePetList
		end
	end
end

function CutePetModel:onRemovePresetCute(msg)
	if self._myPetPresetInfo then
		local removeCutePetId = checknumber(msg.removeCutePetId)

		if not self._myPetPresetInfo.presetCutePetList then
			local removeId = -1

			for i, petInfo in ipairs(self._myPetPresetInfo.presetCutePetList) do
				if petInfo.uniqueId == removeCutePetId then
					removeId = i

					break
				end
			end

			if removeId > 0 then
				table.remove(self._myPetPresetInfo.presetCutePetList, removeId)
			end

			self._myPetPresetInfo.presetCutePetList = self._myPetPresetInfo.presetCutePetList
		end
	end
end

function CutePetModel:onSetPresetPublic(msg)
	if self._myPetPresetInfo then
		self._myPetPresetInfo.presetPublic = msg.presetPublic
	end
end

function CutePetModel:clearBuddyInfoMap()
	self._buddyInfoMap = {}
end

function CutePetModel:updateBuddyTravelInfo(info)
	self._buddyInfoMap = self._buddyInfoMap or {}

	if info then
		self._buddyInfoMap[checknumber(info.buddyId)] = info
	end
end

function CutePetModel:getAllBuddyTravelInfo()
	return self._buddyInfoMap
end

function CutePetModel:getLimitTotalNum(petCount, initCapacity)
	self:getPetStartLine()

	if petCount <= self._petStartLine then
		return initCapacity, 0
	end

	self:getIncrCapacityPetGap()
	self:getGapAddPercent()
	self:getMaxCapacity()

	local addPercent = GameUtil.toInteger((petCount - self._petStartLine) / self._incrCapacityPetGap) * self._gapAddPercent

	return GameUtil.toInteger(math.min(self._maxCapacity, initCapacity * (100 + addPercent) / 100)), addPercent
end

function CutePetModel:getPetStartLine()
	if self._petStartLine == nil then
		self._petStartLine = checknumber(CutePetConfig.instance:getCommonValue("MATERIAL_CAPACITY_PET_START_LINE"))
	end

	return self._petStartLine
end

function CutePetModel:getIncrCapacityPetGap()
	if self._incrCapacityPetGap == nil then
		self._incrCapacityPetGap = checknumber(CutePetConfig.instance:getCommonValue("MATERIAL_CAPACITY_INCR_PET_GAP"))
	end

	return self._incrCapacityPetGap
end

function CutePetModel:getGapAddPercent()
	if self._gapAddPercent == nil then
		self._gapAddPercent = checknumber(CutePetConfig.instance:getCommonValue("MATERIAL_CAPACITY_GAP_ADD_PERCENT"))
	end

	return self._gapAddPercent
end

function CutePetModel:getMaxCapacity()
	if self._maxCapacity == nil then
		self._maxCapacity = checknumber(CutePetConfig.instance:getCommonValue("MATERIAL_CAPACITY_MAX_VALUE"))
	end

	return self._maxCapacity
end

function CutePetModel:searchCutePet(raceId, quality)
	for k, mo in pairs(self._cutePetMap) do
		if mo.raceId == raceId and mo.curQuality == quality then
			return mo
		end
	end
end

CutePetModel.instance = CutePetModel.New()

return CutePetModel
