-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/model/NewHandVerifyFormationCustomFmtMo.lua

module("logic.extensions.newhandwelfare.model.NewHandVerifyFormationCustomFmtMo", package.seeall)

local NewHandVerifyFormationCustomFmtMo = class("NewHandVerifyFormationCustomFmtMo", BaseCustomFmtMo)

function NewHandVerifyFormationCustomFmtMo:updateCfg(bondTeamId)
	self._bondTeamId = checknumber(bondTeamId)
	self._teamData = NewhandwelfareConfig.instance:getBondTeamData(self._bondTeamId)

	if not self._teamData.bondRaceIds then
		self._raceIdList = TableUtil.deepcopy(self._teamData.bondRaceIds)
		self._raceIdMaps = {}

		for _, v in ipairs(self._raceIdList) do
			self._raceIdMaps[v] = v
		end

		self.needUpPetCount = Mathf.Max(#self._raceIdList, 5)
		self.isShowBtnFormation = false
		self.isShowBtnBuffForm = false
		self.isShowClean = false
		self.isShowNegoRight = false
		self.isOnlyUpdateExistPet = false

		self:initPetList()
		self:updateFixedPos()
	end
end

function NewHandVerifyFormationCustomFmtMo:getBondTeamId()
	return self._bondTeamId
end

function NewHandVerifyFormationCustomFmtMo:getRaceIdList()
	return self._raceIdList
end

function NewHandVerifyFormationCustomFmtMo:isUpFmt(raceId)
	local petMo = self:getPetMoInFmtByRaceId(raceId)

	return petMo ~= nil
end

function NewHandVerifyFormationCustomFmtMo:getPetZdlInFmtByRaceId(raceId)
	local petMo = self:getPetMoInFmtByRaceId(raceId)

	return (petMo or nil) and petMo:getFightingPower()
end

function NewHandVerifyFormationCustomFmtMo:getPetZdlInListByRaceId(raceId)
	local petMo = self:getPetMoInListByRaceId(raceId)

	return (petMo or nil) and petMo:getFightingPower()
end

function NewHandVerifyFormationCustomFmtMo:getPetMoInFmtByRaceId(raceId)
	local fmtMo = self:getCurFormation()

	for posId, petId in ipairs(fmtMo:GetPositions()) do
		local petMo = fmtMo:_getPet(petId)

		if petMo and petMo:getDefineId() == raceId then
			return petMo
		end
	end

	return nil
end

function NewHandVerifyFormationCustomFmtMo:getPetMoInListByRaceId(raceId)
	local petMo

	if self._rightPetList then
		for _, petMo in ipairs(self._rightPetList) do
			if petMo:getDefineId() == raceId then
				return petMo
			end
		end
	end

	return petMo
end

function NewHandVerifyFormationCustomFmtMo:updateFixedPos()
	local fmtMo = self:getCurFormation()
	local posIdList = {}

	for posId, petId in ipairs(fmtMo:GetPositions()) do
		if petId > 0 then
			table.insert(posIdList, posId)
		end
	end

	MissionModel.instance:setFixedPos(posIdList)
end

function NewHandVerifyFormationCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getBagPets()
	local petMoMap = {}
	local raceId = 0

	for _, petMo in ipairs(pets) do
		raceId = petMo:getDefineId()

		if self._raceIdMaps[raceId] and (petMoMap[raceId] == nil or petMo:getFightingPower() > petMoMap[raceId]:getFightingPower()) then
			petMoMap[raceId] = petMo
		end
	end

	for raceId, petMo in pairs(petMoMap) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function NewHandVerifyFormationCustomFmtMo:refreshPetList(changePetMoMap)
	local map = {}

	for _, petMo in pairs(changePetMoMap) do
		local raceId = petMo:getDefineId()

		if self._raceIdMaps[raceId] and petMo:isBagPet() then
			map[petMo:getPetId()] = petMo
		end
	end

	NewHandVerifyFormationCustomFmtMo.super.refreshPetList(self, map)
end

function NewHandVerifyFormationCustomFmtMo:_changePetMo(petMo)
	if self._teamData.excludePublicStrengthens then
		local mo = petMo:GetClone()

		mo.attrMo:resetPublicAttr()
		mo.attrMo:calcBaseAttrs(mo)
		mo.attrMo:calcEquipmentAttr(mo)
		mo.attrMo:calcPetRelationAttr(mo)
		mo:calcStarGodPlusAttr(true)
		mo:calcHolyStripesAttr(true)
		mo:refreshAllAttr()

		petMo = mo
	end

	return petMo
end

function NewHandVerifyFormationCustomFmtMo:initSaveHandler()
	self.setSaveHandler(self, self.fmtVerifyReq, self)
end

function NewHandVerifyFormationCustomFmtMo:fmtVerifyReq()
	if self:isEmptyFmt() then
		return
	end

	local simpleForm = self:getCurSimpleForm()

	NewhandwelfareController.instance:sendNewHandWelfareSubmitFormZdlReq(self._bondTeamId, simpleForm)
end

function NewHandVerifyFormationCustomFmtMo:getFormationExtendViewName()
	return ViewName.NewHandVerifyFormExView
end

function NewHandVerifyFormationCustomFmtMo:onFmoSetDown()
	self:updateFixedPos()
	GlobalDispatcher:dispatch(GlobalNotify.HandleNewHandWelfareVerifyFmtUpdate)
end

function NewHandVerifyFormationCustomFmtMo:autoCloneFormation()
	self:revertLastFormation()
end

function NewHandVerifyFormationCustomFmtMo:GetFormStrengthIdAndLv()
	return 0, 0
end

function NewHandVerifyFormationCustomFmtMo:getFmtPowerByParams(team, heroSkill, fid, flvl, eleMap, cutePetRaceId, cutePetQuality, summonMasterId, summonPetId)
	local zdl = 0
	local fmtMo = self:getCurFormation()
	local posList = fmtMo:GetPositions()

	for i, petId in ipairs(posList) do
		local petMo = fmtMo:_getPet(petId)

		if petMo then
			zdl = zdl + petMo:getFightingPower()
		end
	end

	return zdl
end

function NewHandVerifyFormationCustomFmtMo:isEmptyFmt()
	return self:getCurFormation():isEmpty()
end

return NewHandVerifyFormationCustomFmtMo
