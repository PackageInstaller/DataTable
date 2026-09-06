-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pethire/model/PetHireModel.lua

module("logic.extensions.pethire.model.PetHireModel", package.seeall)

local PetHireModel = class("PetHireModel", BaseModel)

PetHireModel.ID_TYPE_NORMAL = 1
PetHireModel.ID_TYPE_ENDLESS = 2

function PetHireModel:ctor()
	return
end

function PetHireModel:onInit()
	self:onReset()
end

function PetHireModel:onReset()
	self.hireItemDefineMap = {}
	self.hirePetIdMap = {}
	self.hirePetList = {}
	self.hireFormPBMap = {}
	self.hireFormMoMap = {}
	self.hirePetMoMap = {}

	self:addFormMoToMap(PetHireModel.ID_TYPE_NORMAL)
	self:addFormMoToMap(PetHireModel.ID_TYPE_ENDLESS)
end

function PetHireModel:addFormMoToMap(formId)
	local fmo = FormationMO.New(GameUtil.handler(self.getPetMoById, self))

	self.hireFormMoMap[formId] = fmo

	return fmo
end

function PetHireModel:onSetAllHirePetInfo(msg)
	self.hirePetList = {}

	local pets = msg.pets

	for i, v in ipairs(pets) do
		local mo = PetHireMo.New()

		mo.petType = v.petType

		if v.petType == 1 then
			mo:initData(MatType.HIRE_PET, v.petDefineId, v.times)

			mo.petView = nil
			self.hireItemDefineMap[v.petDefineId] = mo
		elseif v.petType == 2 then
			mo:initData(MatType.HIRE_PET, v.petId, v.times)

			mo.petView = v.petView
		end

		mo.petId = v.petId
		mo.subType = checknumber(v.subType)

		table.insert(self.hirePetList, mo)

		self.hirePetIdMap[v.petId] = mo
	end

	local forms = msg.form

	for i, form in ipairs(forms) do
		local formId = form.formId

		self.hireFormPBMap[formId] = form

		local fmo = self.hireFormMoMap[formId]

		if fmo == nil then
			fmo = self:addFormMoToMap(formId)
		end

		fmo:SetData(form.simpleForm)
	end
end

function PetHireModel:updateHrieForm(msg)
	local form = msg.simpleForm

	self.hireFormPBMap[form.formId] = form

	local fmo = self.hireFormMoMap[form.formId]

	if fmo == nil then
		fmo = self:addFormMoToMap(form.formId)
	end

	fmo:SetData(form.simpleForm)
end

function PetHireModel:onPetInfoChange(msg)
	local list = msg.hirePetMsg

	for i, hirePetMsg in ipairs(list) do
		local hasPet = false

		for j, mo in ipairs(self.hirePetList) do
			if mo.petId == hirePetMsg.petId then
				mo:SetCount(hirePetMsg.times)

				hasPet = true

				break
			end
		end

		if hasPet == false then
			local mo = PetHireMo.New()

			mo.petType = hirePetMsg.petType
			mo.subType = checknumber(hirePetMsg.subType)

			if hirePetMsg.petType == 1 then
				mo:initData(MatType.HIRE_PET, hirePetMsg.petDefineId, hirePetMsg.times)

				mo.petView = nil
				self.hireItemDefineMap[hirePetMsg.petDefineId] = mo
			elseif hirePetMsg.petType == 2 then
				mo:initData(MatType.HIRE_PET, hirePetMsg.petId, hirePetMsg.times)

				mo.petView = hirePetMsg.petView
			end

			mo.petId = hirePetMsg.petId

			table.insert(self.hirePetList, mo)

			self.hirePetIdMap[hirePetMsg.petId] = mo
		end
	end
end

function PetHireModel:getAllCfgInfoList()
	local list = {}

	for i, v in pairs(self.hireItemDefineMap or {}) do
		if v:GetCount() > 0 then
			table.insert(list, v)
		end
	end

	return list
end

function PetHireModel:getAllInfoList()
	local list = {}

	for i, v in ipairs(self.hirePetList or {}) do
		if v.petView == nil and v:GetCount() > 0 then
			table.insert(list, v)
		end
	end

	return list
end

function PetHireModel:getPetInfoByDefineId(petDefineId)
	petDefineId = checknumber(petDefineId)

	return self.hireItemDefineMap[petDefineId]
end

function PetHireModel:getPetInfoByPetId(petId)
	petId = checknumber(petId)

	return self.hirePetIdMap[petId]
end

function PetHireModel:getFormationMoByFormId(formId)
	formId = checknumber(formId)

	return self.hireFormMoMap[formId]
end

function PetHireModel:copyFormationMoToHireFmo(formId, formationMo)
	local fmo = self:getFormationMoByFormId(formId)

	fmo:setExtGetPetFunc(function(id)
		return formationMo:_getPet(id)
	end)

	local posList = {}
	local srcList = formationMo:GetPositions()

	for i, petId in ipairs(fmo:GetPositions()) do
		local srcPetId = checknumber(srcList[i])

		if srcPetId > 0 then
			posList[i] = srcPetId
		else
			local info = self:getPetInfoByPetId(petId)

			posList[i] = info and info:GetCount() > 0 and petId or 0
		end
	end

	fmo:CloneFromFmoAndFix(formationMo, posList)
end

function PetHireModel:copyHireFmoToFormationMo(formId, formationMo)
	local fmo = self:getFormationMoByFormId(formId)

	formationMo:CloneFromFmoAndFix(fmo)
end

function PetHireModel:checkIsNotHirePetOrHasTimes(petId)
	local info = self:getPetInfoByPetId(petId)

	if info then
		return info:GetCount() > 0
	end

	return true
end

function PetHireModel:appendListByHirePets(petList)
	local list = {}

	if petList then
		for i, v in ipairs(petList) do
			table.insert(list, v)
		end
	end

	for i, v in ipairs(self.hirePetList or {}) do
		if v:GetCount() > 0 then
			local petMo = self:getPetMoById(v.petId)

			table.insert(list, petMo)
		end
	end

	return list
end

function PetHireModel:tryGetHirePetMo(petId, mo)
	if mo == nil then
		return self:getPetMoById(petId)
	end

	return mo
end

function PetHireModel:getPetMoById(petId)
	local info = self:getPetInfoByPetId(petId)

	if info and info:GetCount() > 0 then
		local petMo = self.hirePetMoMap[petId]

		if info.petType == 1 then
			local spPetCo = PetHireConfig.instance:getHirePetCfgById(info.id)

			if petMo == nil then
				local fPowerPet = FightingPowerPetMo.New()

				fPowerPet:fromChallengeCreepCo(spPetCo)

				petMo = fPowerPet:toBaseBagPetMo()
				petMo.petId = petId
				petMo.isHirePet = true
			end

			local summonMasterInfo = self:getPetInfoByDefineId(spPetCo.summonMasterId)

			petMo.summonMasterId = summonMasterInfo and summonMasterInfo:GetCount() > 0 and summonMasterInfo.petId or 0

			local summonedPetInfo = self:getPetInfoByDefineId(spPetCo.summonedPetId)

			petMo.summonedPetId = summonedPetInfo and summonedPetInfo:GetCount() > 0 and summonedPetInfo.petId or 0

			petMo.attrMo:useTotalPublic()
			petMo.attrMo:calcTotalAttrs()
			petMo:refreshAllAttr()
		elseif info.petType == 2 and info.petView then
			petMo = BagPetMo.New()

			petMo:initBaseView(info.petView)

			petMo.isHirePet = true
		end

		return petMo
	end

	return nil
end

PetHireModel.instance = PetHireModel.New()

return PetHireModel
