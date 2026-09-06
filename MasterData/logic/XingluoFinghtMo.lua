-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/model/XingluoFinghtMo.lua

module("logic.extensions.lailisi.model.XingluoFinghtMo", package.seeall)

local XingluoFinghtMo = class("XingluoFinghtMo", BaseModel)

function XingluoFinghtMo:ctor()
	return
end

function XingluoFinghtMo:onInit()
	XingluoFinghtMo.super.onInit(self)
	self:onReset()
end

function XingluoFinghtMo:onReset()
	self:onResetInfo()

	self.formationMo = {}
	self._customFmtMo = nil
end

function XingluoFinghtMo:onResetInfo()
	self._allPetList = nil
	self._curPetMap = {}
end

function XingluoFinghtMo:GetAllPetList(actId, stageId)
	if self._allPetList == nil then
		self:initPetList(actId, stageId)
	end

	return self._allPetList
end

function XingluoFinghtMo:initPetList(actId, stageId)
	if LailisiModel.instance:isFinalAct(actId) then
		local teamInfo = LailisiConfig.instance:getTeamInfo(actId, 1)
		local cfg = LailisiConfig.instance:getHelperPetCfg(teamInfo.creepsMasterId)

		self:initSupPetList(cfg)

		return
	end

	self:initBagPetList(actId, stageId)
end

function XingluoFinghtMo:initBagPetList(actId, stageId)
	local pets = BagPetsController.instance:getFightBagPet()
	local isHavePublicAttr = LailisiConfig.instance:isHavePublicAttr(actId)
	local list = {}

	self._curPetMap = {}

	ArraySort.sortOn(pets, function(mo)
		return (mo:getFightingPower())
	end, ArraySort.DESCENDING)

	local attrList = self:PetValidator(actId, stageId)

	for k, v in pairs(pets) do
		if v then
			local mo = v:GetClone()

			if self:screenPet(attrList, mo) then
				if isHavePublicAttr then
					mo.attrMo:resetPublicAttr()
					mo.attrMo:calcTotalAttrs()
					mo:refreshAllAttr()
				end

				table.insert(list, mo)

				self._curPetMap[v.petId] = mo
			end
		end
	end

	self._allPetList = list
end

function XingluoFinghtMo:screenPet(list, petMo)
	if #list == 0 then
		return true
	end

	for k, v in pairs(list) do
		if petMo:checkHasRace(v) then
			return true
		end
	end

	return false
end

function XingluoFinghtMo:PetValidator(actId, stageId)
	if actId == nil or stageId == nil then
		return {}
	end

	local teamData = LailisiConfig.instance:getTeamInfo(actId, stageId)

	if teamData.formCondition == 0 then
		return {}
	end

	local validator = FormationValidatorConfig.instance:getFormationValidatorCfg(teamData.formCondition)
	local list = {}
	local str = string.split(validator.validator, "$")

	if str[1] == "All" then
		local allValidator = FormationValidatorConfig.instance:getFormationAllValidatorCfg(checknumber(str[2]))

		if allValidator and allValidator.count == 0 then
			local validatorList = string.split(allValidator.validator, "&")

			for k, v in pairs(validatorList) do
				local validator = string.split(v, "$")

				table.insert(list, validator[2])
			end
		end
	end

	return list
end

function XingluoFinghtMo:initSupPetList(cfg)
	local list = {}

	self._curPetMap = {}

	for k, v in pairs(cfg) do
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(v)

		local petMo = fMo:toBaseBagPetMo()

		table.insert(list, petMo)

		self._curPetMap[petMo.petId] = petMo
	end

	self._allPetList = list
end

function XingluoFinghtMo:GetCurFormation(actId, newFor)
	self.formationMo[actId] = self.formationMo[actId] or newFor

	return self.formationMo[actId]
end

function XingluoFinghtMo:getCustomFmtMo(actId, stageId)
	if self._customFmtMo == nil then
		self._customFmtMo = XingluoCustomFmtMo.New()
	end

	self._curActId = actId

	self._customFmtMo:getActivityId(actId, stageId)

	return self._customFmtMo
end

XingluoFinghtMo.instance = XingluoFinghtMo.New()

return XingluoFinghtMo
