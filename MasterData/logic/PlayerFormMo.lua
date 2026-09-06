-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/model/PlayerFormMo.lua

module("logic.extensions.seniorarena.model.PlayerFormMo", package.seeall)

local PlayerFormMo = class("PlayerFormMo")

function PlayerFormMo:initWithForm(form, isMe)
	self._formId = form.formId

	local playerView = form.view

	self._curForm = playerView.curForm
	self._petSimpleView = playerView.petSimpleView
	self._petMoMap = {}

	if self._petSimpleView then
		for _, v in ipairs(self._petSimpleView) do
			local petMo = BagPetMo.New()

			petMo:initBaseView(v)

			petMo.isMyPackPet = false
			self._petMoMap[petMo.petId] = petMo
		end
	end

	self._isMe = isMe

	self:_calcuTotalPower()
end

function PlayerFormMo:initWithSetForm(setForm)
	self._formId = setForm.formId
	self._curForm = setForm.simpleForm
	self._isMe = true

	self:_calcuTotalPower()
end

function PlayerFormMo:initWithCacheForm(form, fmtMo)
	self._isMe = true
	self._formId = form.formId
	self._curForm = form._curForm

	if fmtMo then
		self._curForm = FormationFacade.createFormPb(nil, fmtMo)
	end

	self:_calcuTotalPower()
end

function PlayerFormMo:ctor()
	return
end

function PlayerFormMo:getPetMoByIdx(idx)
	if self._curForm then
		if not self._curForm.pos then
			local pos = {}
			local petId = pos[idx]

			if self._isMe then
				return BagPetsController.instance:getPet(petId)
			else
				return self._petMoMap[petId]
			end
		end
	end
end

function PlayerFormMo:getMaxPowerPet()
	local maxPet

	for i = 1, 9 do
		local petMo = self:getPetMoByIdx(i)

		if petMo and (maxPet == nil or petMo:getFightingPower() > maxPet:getFightingPower()) then
			maxPet = petMo
		end
	end

	return maxPet
end

function PlayerFormMo:getPetMoList(withNil)
	local t = {}

	for i = 1, 9 do
		local petMo = self:getPetMoByIdx(i)

		if withNil == true or petMo ~= nil then
			table.insert(t, petMo)
		end
	end

	return t
end

function PlayerFormMo:getPetNum()
	local num = 0

	for _, v in ipairs((self._curForm or nil) and (self._curForm.pos or {})) do
		if v > 0 then
			num = num + 1
		end
	end

	return num
end

function PlayerFormMo:setFormId(formId)
	self._formId = formId
end

function PlayerFormMo:getFormId()
	return self._formId
end

function PlayerFormMo:getFormationId()
	if self._curForm then
		return self._curForm.formId
	end
end

function PlayerFormMo:getPetIdByPos(i)
	if self._curForm and self._curForm.pos then
		return self._curForm.pos[i]
	end

	return 0
end

function PlayerFormMo:getHeroSkillId()
	if self._curForm then
		return checknumber(self._curForm.extParams.heroSkillId)
	end

	return 0
end

function PlayerFormMo:getPsychicedSkillId()
	if self._curForm then
		return checknumber(self._curForm.extParams.psychicSkillId)
	end

	return 0
end

function PlayerFormMo:getElementPetId()
	if self._curForm then
		return checknumber(self._curForm.extParams.elementalMasterId), checknumber(self._curForm.extParams.elementalTargetId)
	end

	return 0, 0
end

function PlayerFormMo:getChangeRaceTypes()
	if self._curForm then
		return self._curForm.extParams.changeRaceTypes
	end

	return nil
end

function PlayerFormMo:getExtParams()
	if self._curForm then
		return self._curForm.extParams
	end

	return nil
end

function PlayerFormMo:getFormationInfo()
	if self._curForm then
		if not self._curForm.extParams then
			local extParams = {}
			local fid, flv = 0, 0

			if extParams then
				flv = checknumber(extParams.formStrengthLv)
				fid = checknumber(extParams.formStrengthId)
			end

			return fid, flv
		end
	end
end

function PlayerFormMo:getCutePetInfo()
	if self._curForm then
		if not self._curForm.extParams then
			local extParams = {}

			if checknumber(extParams.cutePetId) > 0 then
				local cutePetId = checknumber(extParams.cutePetId)
				local cutePetMo = MaterialMgr.getModel(MatType.CutePet, cutePetId)

				if cutePetMo then
					return cutePetMo.raceId, cutePetMo.curQuality
				end
			end

			return checknumber(extParams.cutePetRaceId), checknumber(extParams.cutePetQuality)
		end
	end
end

function PlayerFormMo:GetCutePetId()
	local extParams = self._curForm.extParams

	return (extParams or nil) and checknumber(extParams.cutePetId)
end

function PlayerFormMo:GetCutePetRaceId()
	local raceId, quality = self:getCutePetInfo()

	return raceId
end

function PlayerFormMo:GetCutePetQuality()
	local raceId, quality = self:getCutePetInfo()

	return quality
end

function PlayerFormMo:_calcuTotalPower()
	local getPetFuncCallback
	local fmo = FormationMO.New((not self._isMe or nil) and function(petId)
		return self._petMoMap[petId]
	end)

	fmo:SetData(self._curForm)

	local masterId = 0
	local summonId = 0
	local pets = self:getPetMoList(false)
	local formations = {}
	local team = {}

	for i = 1, 9 do
		local pet = pets[i]

		if pet then
			local fPetMo = pet:toFightingPowerPetMo(pets)

			table.insert(team, fPetMo)

			formations[i] = fPetMo

			if checknumber(pet.summonMasterId) > 0 then
				masterId = checknumber(pet.summonMasterId)
			end

			if checknumber(pet.summonedPetId) > 0 then
				summonId = checknumber(pet.summonedPetId)
			end
		end
	end

	local heroSkillId = self:getHeroSkillId()
	local fid, flvl = self:getFormationInfo()
	local cutePetRaceId, cutePetQuality = self:getCutePetInfo()

	if fmo:GetSummonMasterPetId() > 0 and fmo:GetSummonPetId() > 0 then
		masterId = fmo:GetSummonMasterPetId()
		summonId = fmo:GetSummonPetId()
	end

	self._totalPower = FightingPowerFormula.instance:getTeamFightingPower(team, heroSkillId, fid, flvl, fmo:getCurElementRelationMap(), cutePetRaceId, cutePetQuality, masterId, summonId)
end

function PlayerFormMo:getTotalPower()
	return checknumber(self._totalPower)
end

function PlayerFormMo:getPowerByPetId(petId)
	if self._powers then
		return checknumber(self._powers[petId])
	end
end

function PlayerFormMo:getPets()
	local list = self:getPetMoList()
	local pets = {}

	for k, v in ipairs(list) do
		local mo = {}

		mo.raceId = v.raceId
		mo.awakenLevel = v.awakeLevel
		mo.level = v.level
		mo.zdl = v:getFightingPower()

		if v._zdl then
			mo._curZdl = v._zdl
		end

		mo.petMo = v

		table.insert(pets, mo)
	end

	return pets
end

return PlayerFormMo
