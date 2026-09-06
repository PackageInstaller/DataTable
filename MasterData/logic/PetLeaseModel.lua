-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petlease/model/PetLeaseModel.lua

module("logic.extensions.petlease.model.PetLeaseModel", package.seeall)

local PetLeaseModel = class("PetLeaseModel", BaseModel)

PetLeaseModel.LEASE_TYPE_FB = 1
PetLeaseModel.LEASE_TYPE_WT = 2
PetLeaseModel.LEASE_TYPE_CH = 3

function PetLeaseModel:ctor()
	self._isOpenHelpTab = false
	self._allHireInfo = nil
	self._hirePetsList = nil
	self._allRentInfo = nil
end

function PetLeaseModel:onInit()
	PetLeaseModel.super.onInit(self)
	self:onReset()
end

function PetLeaseModel:onReset()
	self._isOpenHelpTab = false
	self._allHireInfo = nil
	self._hirePetsList = nil
	self._allRentInfo = nil
	self.hireFormationMO = FormationMO.New(function(id)
		return PetLeaseModel.instance:getPet(id)
	end)
	self.petMap = {}
end

function PetLeaseModel:sendSaveFormation(type)
	if self:checkHasHirePet(type) then
		local simpleForm = self.hireFormationMO:createFormPb()

		simpleForm.formId = 0

		PetLeaseAgent.instance:sendPM_SetRentPetFormReq(type, simpleForm)
	end
end

function PetLeaseModel:copyFromFormationMO(formationMo)
	self.hireFormationMO:setExtGetPetFunc(function(id)
		return formationMo:_getPet(id)
	end)
	self.hireFormationMO:SetHeroSkillId(formationMo:GetHeroSkillId())
	self.hireFormationMO:_setAllPositions(formationMo:GetPositions())
end

function PetLeaseModel:copyHireMOToNormalMo(type, formationMo)
	local list, map = self:getHirePetsListByType(type)
	local hasHire = false
	local pos = {}
	local pet_poisition = self.hireFormationMO:GetPositions() or {}
	local team = {}

	for i, v in ipairs(pet_poisition) do
		if map and map[v] ~= nil then
			pos[i] = 0
			hasHire = true
		else
			if v > 0 then
				local petMo = BagModel.instance:getPet(v)

				if petMo then
					table.insert(team, petMo)
				end
			end

			pos[i] = v
		end
	end

	formationMo:SetHeroSkillId(self.hireFormationMO:GetHeroSkillId())
	formationMo:setPositionForce(pos, true)

	local strengthInfo = self.hireFormationMO:GetFormStrengthInfo()

	if strengthInfo then
		local info = {
			formStrengthId = strengthInfo.formStrengthId,
			formStrengthLv = strengthInfo.formStrengthLv
		}

		formationMo:SetFormStrengthInfo(info)
	else
		formationMo:SetFormStrengthInfo(nil)
	end

	formationMo:fixAndUpdateStength()
end

function PetLeaseModel:getHireFormationMO()
	return self.hireFormationMO
end

function PetLeaseModel:getPet(id)
	local mo = self.petMap[id]

	if mo == nil then
		mo = BagPetsController.instance:getPet(id)
	end

	return mo
end

function PetLeaseModel:checkHasHirePet(type)
	local list, map = self:getHirePetsListByType(type)

	if map then
		local pet_poisition = self.hireFormationMO:GetPositions() or {}

		for i, v in ipairs(pet_poisition) do
			if v > 0 and map[v] ~= nil then
				return true
			end
		end
	end

	return false
end

function PetLeaseModel:getHirePetsListByType(type)
	local list, map
	local cfg = PetLeaseConfig.instance:getHireCfg(type)

	if cfg then
		local funcId = checknumber(cfg.openFuncId)
		local totalTime = cfg.maxUseTimes
		local info = self:GetMyHirePetsInfo()
		local funcUseList = info.funcUseList

		if funcUseList and totalTime > checknumber(funcUseList[type]) then
			local petInfoList = info.petInfoList

			for k, v in pairs(petInfoList or {}) do
				local mo = v.info

				list = list or {}
				map = map or {}

				table.insert(list, mo)

				map[mo.petId] = mo
			end
		end
	end

	return list, map
end

function PetLeaseModel:SCPushHirePetsData(data)
	self._allHireInfo = {
		expireTime = 0,
		petInfoList = {},
		funcUseList = {}
	}
	self._allHireInfo.expireTime = checknumber(data.expireTime)

	self:_AddHirePetsToList(data.rentPets)
	self:SCPushRentPetsTimes(data.useTimes)
	GlobalDispatcher:dispatch("UpdataPetLeaseData")
end

function PetLeaseModel:SCPushHireSinglePet(data, expireTime)
	self._allHireInfo = self._allHireInfo or {
		expireTime = 0,
		petInfoList = {},
		funcUseList = {}
	}
	self._allHireInfo.expireTime = checknumber(expireTime)
	self._allHireInfo.petInfoList = self._allHireInfo.petInfoList or {}

	self:_AddHirePetsToList(data)
	GlobalDispatcher:dispatch("UpdataPetLeaseData")
end

function PetLeaseModel:_AddHirePetsToList(data)
	if data == nil then
		return
	end

	for _, info in pairs(data) do
		if info and checknumber(info.leasePetId) > 0 and info.petView then
			local bagPetMo = BagPetMo.New()

			bagPetMo:initBaseView(info.petView)

			bagPetMo.isHirePet = true
			self.petMap[bagPetMo.petId] = bagPetMo
			self._allHireInfo.petInfoList[info.slotId] = {
				info = bagPetMo,
				leaseId = info.leasePetId,
				power = bagPetMo:getFightingPower()
			}
		end
	end
end

function PetLeaseModel:SCPushRentPetsData(data)
	self._allRentInfo = {}
	self._hirePetsList = {}

	for _, info in pairs(data.myLeasePets) do
		if info and checknumber(info.slotId) > 0 and checknumber(info.petId) > 0 then
			local petMo = BagPetsController.instance:getPet(info.petId)

			if petMo then
				self._allRentInfo[info.slotId] = {
					info = petMo,
					leaseId = petMo.petId,
					power = petMo:getFightingPower()
				}
			end
		end
	end

	for _, info in pairs(data.canRentPets or {}) do
		if info and checknumber(info.petId) > 0 then
			local temp = {
				info = {
					userId = info.userId,
					petId = info.petId,
					raceId = info.raceId,
					skinId = info.skinId,
					level = info.petLv,
					awakeLevel = info.awakenLv
				},
				leaseId = info.petId,
				power = info.zdl
			}

			table.insert(self._hirePetsList, temp)
		end
	end

	if #self._hirePetsList > 1 then
		table.sort(self._hirePetsList, function(a, b)
			return a.power > b.power
		end)
	end

	GlobalDispatcher:dispatch("UpdataPetLeaseData")
end

function PetLeaseModel:SCPushRentSinglePet(reqList, isAdd)
	if reqList == nil or #reqList == 0 then
		return
	end

	self._allRentInfo = self._allRentInfo or {}

	for i = 1, #reqList do
		if reqList[i] and checknumber(reqList[i].slotId) > 0 then
			if isAdd then
				local petMo = BagPetsController.instance:getPet(reqList[i].petId)

				if petMo then
					self._allRentInfo[reqList[i].slotId] = {
						info = petMo,
						leaseId = petMo.petId,
						power = petMo:getFightingPower()
					}
				end
			else
				self._allRentInfo[reqList[i].slotId] = nil
			end
		end
	end

	GlobalDispatcher:dispatch("UpdataPetLeaseData")
end

function PetLeaseModel:SCPushRentPetsTimes(data)
	if self._allHireInfo == nil then
		self._allHireInfo = {
			expireTime = 0,
			petInfoList = {},
			funcUseList = {}
		}
	end

	for _, info in pairs(data or {}) do
		if info and checknumber(info.usage) > 0 and checknumber(info.hasUseTimes) > 0 then
			self._allHireInfo.funcUseList[info.usage] = info.hasUseTimes
		end
	end
end

function PetLeaseModel:GetMyHirePetsInfo()
	return self._allHireInfo or {
		expireTime = 0,
		petInfoList = {},
		funcUseList = {}
	}
end

function PetLeaseModel:GetMyHirePetsList()
	local maxPower = 0
	local _allPets = BagPetsController.instance:getBagPets()

	for _, mo in pairs(_allPets or {}) do
		if mo and mo.petId then
			local power = mo:getFightingPower()

			if maxPower < power then
				maxPower = power
			end
		end
	end

	local bl = PetLeaseConfig.instance:GetMaxHirePower()

	maxPower = maxPower * bl / 10000

	local tempList = {}

	for _, info in pairs(self._hirePetsList or {}) do
		if info.info and checknumber(info.leaseId) > 0 and not self:_IsBeLeasePetByPetId(info.leaseId, (self._allHireInfo and self._allHireInfo.petInfoList or nil) and self._allHireInfo.petInfoList) and maxPower >= checknumber(info.power) then
			table.insert(tempList, info)
		end
	end

	return tempList
end

function PetLeaseModel:GetMyRentPetsInfo()
	return self._allRentInfo or {}
end

function PetLeaseModel:GetMyRentPetsList()
	local _allPets = BagPetsController.instance:getBagPets()

	if _allPets == nil then
		return {}
	end

	local tempList = {}

	for _, info in pairs(_allPets) do
		if info and not self:_IsBeLeasePetByPetId(info.petId, self._allRentInfo) then
			table.insert(tempList, {
				info = info,
				leaseId = info.petId,
				power = info:getFightingPower()
			})
		end
	end

	if #tempList > 1 then
		table.sort(tempList, function(a, b)
			return a.power > b.power
		end)
	end

	return tempList
end

function PetLeaseModel:_IsBeLeasePetByPetId(petId, list)
	if list == nil then
		return false
	end

	for _, mo in pairs(list) do
		if mo and mo.info and mo.leaseId == petId then
			return true
		end
	end

	return false
end

function PetLeaseModel:GetLeaseTypeCount(leaseType)
	local have = PetLeaseConfig.instance:GetUseInfoCfg(leaseType) or 1

	return have, (self._allHireInfo and self._allHireInfo.funcUseList or nil) and checknumber(self._allHireInfo.funcUseList[leaseType])
end

function PetLeaseModel:SetLeaseTypeCount(leaseType, count, isAdd)
	if self._allHireInfo == nil or self._allHireInfo.funcUseList == nil then
		return
	end

	if self._allHireInfo.funcUseList[leaseType] == nil then
		self._allHireInfo.funcUseList[leaseType] = 0
	end

	if not isAdd then
		self._allHireInfo.funcUseList[leaseType] = self._allHireInfo.funcUseList[leaseType] - count

		if self._allHireInfo.funcUseList[leaseType] < 0 then
			self._allHireInfo.funcUseList[leaseType] = 0
		end
	else
		self._allHireInfo.funcUseList[leaseType] = self._allHireInfo.funcUseList[leaseType] + count

		local allCount = PetLeaseConfig.instance:GetUseInfoCfg(leaseType)

		if self._allHireInfo.funcUseList[leaseType] > checknumber(allCount) then
			self._allHireInfo.funcUseList[leaseType] = allCount
		end
	end
end

function PetLeaseModel:GetMyHirePetsRedPoint()
	local isHave = not not (self._hirePetsList and #self._hirePetsList > 0)

	if self._allHireInfo == nil or self._allHireInfo.petInfoList == nil then
		return isHave
	end

	for _, info in pairs(self._allHireInfo.petInfoList) do
		if info.info and checknumber(info.leaseId) > 0 then
			return false
		end
	end

	return isHave
end

function PetLeaseModel:GetMyRentPetsRedPoint()
	local isHave = false
	local list = self:GetMyRentPetsList()

	if list and #list > 0 then
		isHave = true
	end

	if self._allRentInfo == nil and isHave then
		return true
	end

	for _, info in pairs(self._allRentInfo or {}) do
		if info.info and checknumber(info.leaseId) > 0 then
			return false
		end
	end

	return isHave
end

PetLeaseModel.instance = PetLeaseModel.New()

return PetLeaseModel
