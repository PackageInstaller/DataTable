-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/controller/FormationValidatorController.lua

module("logic.extensions.mission.controller.FormationValidatorController", package.seeall)

local FormationValidatorController = class("FormationValidatorController", BaseController)
local EnumValidator = {
	Pos = "Pos",
	All = "All"
}
local EnumValidatorPet = {
	Race = "Race",
	OnlyStart = "OnlyStart",
	Job = "Job",
	Signs = "Signs",
	RaceType = "RaceType",
	Gender = "Gender"
}

function FormationValidatorController:ctor()
	return
end

function FormationValidatorController:filterFormationPosOnEnter(conditionId, formationMO)
	self.formationMO = formationMO or FormationNewModel.instance:GetCurTeam():GetCurFormation()

	local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(conditionId)

	if not cfg or string.nilorempty(cfg.validator) then
		return
	end

	self:_handleValidator(cfg.validator)
end

function FormationValidatorController:isPosValidatorMatchOnSelect(pos, petId, conditionId, formationMO, isShowTip)
	self.formationMO = formationMO or FormationNewModel.instance:GetCurTeam():GetCurFormation()

	local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(conditionId)

	if not cfg or string.nilorempty(cfg.validator) then
		return true
	end

	return (self:_handleOnSelectPetIsMatch(pos, petId, cfg.validator, isShowTip))
end

function FormationValidatorController:isFormationValidatorMatchOnStart(conditionId, formationMO, isNotShowTip)
	self.formationMO = formationMO or FormationNewModel.instance:GetCurTeam():GetCurFormation()

	local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(conditionId)

	if not cfg or string.nilorempty(cfg.validator) then
		return true
	end

	return (self:_handleOnClickEnterBattleIsMatch(cfg.validator, isNotShowTip))
end

function FormationValidatorController:getNecessaryAndForbidPosList(conditionId)
	local resultList = {}
	local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(conditionId)

	if not cfg or string.nilorempty(cfg.validator) then
		return resultList
	end

	local conditionList = ConditionValidator.instance:getAllConditions(cfg.validator)

	for i, v in ipairs(conditionList) do
		local str = string.split(v, "$")

		if str[1] and str[1] == EnumValidator.Pos and str[2] and not string.nilorempty(str[2]) then
			local posStrs = string.split(str[2], ",")
			local pos = checknumber(posStrs[1]) + 1
			local posId = checknumber(posStrs[2])
			local cfg = FormationValidatorConfig.instance:getFormationPosValidatorCfg(posId)

			if cfg then
				if cfg.ban then
					resultList[pos] = false
				elseif cfg.allow then
					resultList[pos] = true
				end
			end
		end
	end

	return resultList
end

function FormationValidatorController:getAllLabelByConditionId(conditionId)
	local labelList = {}
	local label = ""
	local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(conditionId)

	if cfg and not string.nilorempty(cfg.validator) then
		local validatorList = string.split(cfg.validator, "&")

		if validatorList and #validatorList > 0 then
			for i, v in ipairs(validatorList) do
				local conditionList = string.split(v, "$")

				if conditionList and conditionList[1] == EnumValidator.All then
					local allId = checknumber(conditionList[2])
					local allCfg = FormationValidatorConfig.instance:getFormationAllValidatorCfg(allId)

					if allCfg and not string.nilorempty(allCfg.label) then
						table.insert(labelList, allCfg.label)
					end
				end
			end

			for i, v in ipairs(labelList) do
				label = i ~= #labelList and label .. v .. "," or label .. v
			end
		end
	end

	return label
end

function FormationValidatorController._doSingleValidator(singleValidator, petMo, formationMO)
	local strs = string.split(singleValidator, "$")

	if not strs[1] or not strs[2] then
		return true
	end

	local result = true
	local param = strs[2]

	if strs[1] == EnumValidatorPet.Race then
		result = checknumber(param) == petMo:getDefineId()
	elseif strs[1] == EnumValidatorPet.RaceType then
		if formationMO and formationMO.GetChangeRaceTypes and formationMO.getCurElementRelationMap then
			local race = PetSkinConfig.instance:getFisrtEleAttrIdx((checknumber(petMo.curFaceId) > 0 or nil) and checknumber(petMo.curFaceId))
			local types = formationMO:GetChangeRaceTypes()

			for i, v in ipairs(types) do
				if v.petId == petMo.petId and not string.nilorempty(v.raceType) then
					race = GameEnum.Races[v.raceType]
				end
			end

			local eleMap = formationMO:getCurElementRelationMap()

			if eleMap and eleMap[petMo.petId] ~= nil then
				race = eleMap[petMo.petId]
			end

			race = race % 10

			local ele = param

			if ele and type(ele) == "string" then
				ele = GameEnum.Races[ele]
			end

			result = ele == race
		else
			result = petMo:checkHasRace(param)
		end
	elseif strs[1] == EnumValidatorPet.Job then
		result = PetSkinConfig.instance:checkHasJob(petMo.curFaceId, param)
	elseif strs[1] == EnumValidatorPet.Gender then
		result = PetSkinConfig.instance:checkIsSameGender(petMo.curFaceId, param)
	elseif strs[1] == EnumValidatorPet.Signs then
		result = CharacterConfig.instance:checkHasSigns(petMo.raceId, param)
	end

	printInfo("test 处理单条验证", singleValidator, petMo.name, result)

	return result
end

function FormationValidatorController:_removePet(pos)
	if self.formationMO then
		self.formationMO:SetPosition(pos, 0, true)
	end
end

function FormationValidatorController:_getFormationPoses()
	if self.formationMO then
		return self.formationMO:GetPositions()
	end

	return {}
end

function FormationValidatorController:_getPet(petId)
	if self.formationMO then
		return self.formationMO:_getPet(petId)
	end

	return {}
end

function FormationValidatorController:_compareRemove(compareType, curCount, cfgCount)
	local isRemove = false
	local removeNum = 0

	compareType = string.trim(compareType)

	if compareType == GameEnum.GREATER_THAN_OR_EQUAL_TO or compareType == GameEnum.GREATER_THAN then
		isRemove = false
		removeNum = 0
	elseif compareType == GameEnum.EQUAL_TO or compareType == GameEnum.LESS_THAN_OR_EQUAL_TO then
		if cfgCount < curCount then
			isRemove = true
			removeNum = curCount - cfgCount
		end
	elseif compareType == GameEnum.LESS_THAN and cfgCount <= curCount then
		isRemove = true
		removeNum = curCount - cfgCount + 1
	end

	removeNum = removeNum >= 0 and removeNum or 0

	return isRemove, removeNum
end

function FormationValidatorController:_compareAdd(compareType, curCount, cfgCount)
	local isAdd = false
	local addNum = 0

	compareType = string.trim(compareType)

	if compareType == GameEnum.LESS_THAN_OR_EQUAL_TO or compareType == GameEnum.LESS_THAN then
		isAdd = false
		addNum = 0
	elseif compareType == GameEnum.EQUAL_TO or compareType == GameEnum.GREATER_THAN_OR_EQUAL_TO then
		if curCount < cfgCount then
			isAdd = true
			addNum = cfgCount - curCount
		end
	elseif compareType == GameEnum.GREATER_THAN and curCount <= cfgCount then
		isAdd = true
		addNum = cfgCount - curCount + 1
	end

	addNum = addNum >= 0 and addNum or 0

	return isAdd, addNum
end

function FormationValidatorController:_handleValidator(validatorStr)
	local conditionList = ConditionValidator.instance:getAllConditions(validatorStr)

	for i, v in ipairs(conditionList) do
		local str = string.split(v, "$")

		if str[1] then
			if str[1] == EnumValidator.Pos then
				if str[2] and not string.nilorempty(str[2]) then
					local posStrs = string.split(str[2], ",")

					self:_handlePosValidator(posStrs[1], posStrs[2])
				end
			elseif str[1] == EnumValidator.All and str[2] then
				self:_handleAllValidator(str[2])
			end
		end
	end
end

function FormationValidatorController:_handlePosValidator(pos, id)
	if not pos or not id then
		return
	end

	local posIndex = checknumber(pos) + 1
	local idIndex = checknumber(id)
	local cfg = FormationValidatorConfig.instance:getFormationPosValidatorCfg(idIndex)

	if not cfg then
		return
	end

	if cfg.ban then
		self:_removePet(posIndex)

		return
	end

	if string.nilorempty(cfg.validator) then
		return
	end

	local posisions = self:_getFormationPoses()

	for i, petId in ipairs(posisions) do
		if i == posIndex and petId > 0 then
			self:_removePetByValidator(petId, posIndex, cfg.validator, cfg.desc, cfg.allow)
		end
	end
end

function FormationValidatorController:_removePetByValidator(petId, posIndex, validatorStr, desc, isAllow)
	local petMo = self:_getPet(petId)

	if petMo then
		local isMatch = ConditionValidator.instance:isMatch(validatorStr, FormationValidatorController._doSingleValidator, petMo, self.formationMO)

		if isAllow and not isMatch then
			self:_removePet(posIndex)
		elseif not isAllow and isMatch then
			self:_removePet(posIndex)
		end
	end
end

function FormationValidatorController:_handleAllValidator(id)
	local idIndex = checknumber(id)
	local cfg = FormationValidatorConfig.instance:getFormationAllValidatorCfg(idIndex)

	if not cfg then
		return
	end

	if not string.nilorempty(cfg.validator) and string.match(cfg.validator, EnumValidatorPet.OnlyStart) then
		return
	end

	local count = 0
	local matchPosList = {}
	local posisions = self:_getFormationPoses()

	for i, petId in ipairs(posisions) do
		if petId > 0 then
			if string.nilorempty(cfg.validator) then
				count = count + 1

				table.insert(matchPosList, i)
			else
				local petMo = self:_getPet(petId)

				if petMo then
					local isMatch = ConditionValidator.instance:isMatch(cfg.validator, FormationValidatorController._doSingleValidator, petMo, self.formationMO)

					if isMatch then
						count = count + 1

						table.insert(matchPosList, i)
					end
				end
			end
		end
	end

	local isNeedRemove, removeNum = self:_compareRemove(cfg.compareType, count, cfg.count)

	if isNeedRemove then
		for i = #matchPosList, 1, -1 do
			local pos = matchPosList[i]

			self:_removePet(pos)

			removeNum = removeNum - 1

			if removeNum == 0 then
				break
			end
		end
	end
end

function FormationValidatorController:_handleOnSelectPetIsMatch(pos, petId, validatorStr, isShowTip)
	isShowTip = isShowTip == nil or isShowTip == true

	local conditionList = ConditionValidator.instance:getAllConditions(validatorStr)

	for i, v in ipairs(conditionList) do
		local str = string.split(v, "$")

		if str[1] then
			if str[1] == EnumValidator.Pos then
				if str[2] and not string.nilorempty(str[2]) then
					local posStrs = string.split(str[2], ",")

					if not self:_handleOnSelectPetIsPosMatch(pos, checknumber(posStrs[1]) + 1, petId, checknumber(posStrs[2]), isShowTip) then
						return false
					end
				end
			elseif str[1] == EnumValidator.All and str[2] and not self:_handleOnSelectPetIsAllMatch(pos, petId, checknumber(str[2]), isShowTip) then
				return false
			end
		end
	end

	return true
end

function FormationValidatorController:_handleOnSelectPetIsPosMatch(selectPos, cfgPos, petId, fmtPosValidatorId, isShowTip)
	isShowTip = isShowTip == nil or isShowTip == true

	if selectPos ~= cfgPos then
		return true
	else
		local cfg = FormationValidatorConfig.instance:getFormationPosValidatorCfg(fmtPosValidatorId)

		if not cfg then
			return true
		end

		if cfg.ban then
			self:_showTip(cfg.desc, isShowTip)

			return false
		end

		if string.nilorempty(cfg.validator) then
			return true
		end

		local petMo = self:_getPet(petId)

		if petMo then
			local isMatch = ConditionValidator.instance:isMatch(cfg.validator, FormationValidatorController._doSingleValidator, petMo, self.formationMO)

			if cfg.allow and not isMatch then
				self:_showTip(cfg.desc, isShowTip)

				return false
			elseif not cfg.allow and isMatch then
				self:_showTip(cfg.desc, isShowTip)

				return false
			end

			return true
		else
			self:_showTip(cfg.desc, isShowTip)

			return false
		end
	end
end

function FormationValidatorController:_handleOnSelectPetIsAllMatch(pos, petId, fmtAllValidatorId, isShowTip)
	isShowTip = isShowTip == nil or isShowTip == true

	local cfg = FormationValidatorConfig.instance:getFormationAllValidatorCfg(fmtAllValidatorId)

	if not cfg then
		return true
	end

	if not string.nilorempty(cfg.validator) and string.match(cfg.validator, EnumValidatorPet.OnlyStart) then
		return true
	end

	local isPetExist = false
	local count = 0
	local matchPosList = {}
	local posisions = self:_getFormationPoses()

	for i, vPetId in ipairs(posisions) do
		if vPetId > 0 then
			if vPetId == petId then
				isPetExist = true
			end

			if string.nilorempty(cfg.validator) then
				count = count + 1

				table.insert(matchPosList, i)
			else
				local petMo = self:_getPet(vPetId)

				if petMo then
					local isMatch = ConditionValidator.instance:isMatch(cfg.validator, FormationValidatorController._doSingleValidator, petMo, self.formationMO)

					if isMatch then
						count = count + 1

						table.insert(matchPosList, i)
					end
				end
			end
		end
	end

	if not isPetExist then
		local isExistPetOnSelectPos = false

		for i, v in ipairs(matchPosList) do
			if pos == v then
				isExistPetOnSelectPos = true

				break
			end
		end

		if not isExistPetOnSelectPos then
			local petMo = self:_getPet(petId)

			if petMo then
				local isMatch = ConditionValidator.instance:isMatch(cfg.validator, FormationValidatorController._doSingleValidator, petMo, self.formationMO)

				if isMatch then
					count = count + 1
				end
			end
		end
	end

	local isNeedRemove, removeNum = self:_compareRemove(cfg.compareType, count, cfg.count)
	local isNotMatch = isNeedRemove and removeNum > 0

	if isNotMatch then
		self:_showTip(cfg.desc, isShowTip)

		return false
	end

	return true
end

function FormationValidatorController:_handleOnClickEnterBattleIsMatch(validatorStr, isNotShowTip)
	local conditionList = ConditionValidator.instance:getAllConditions(validatorStr)

	for i, v in ipairs(conditionList) do
		local str = string.split(v, "$")

		if str[1] then
			if str[1] == EnumValidator.Pos then
				if str[2] and not string.nilorempty(str[2]) then
					local posStrs = string.split(str[2], ",")

					if not self:_handleOnClickEnterBattleIsPosMatch(checknumber(posStrs[1]) + 1, checknumber(posStrs[2]), isNotShowTip) then
						return false
					end
				end
			elseif str[1] == EnumValidator.All and str[2] and not self:_handleOnClickEnterBattleIsAllMatch(checknumber(str[2]), isNotShowTip) then
				return false
			end
		end
	end

	return true
end

function FormationValidatorController:_handleOnClickEnterBattleIsPosMatch(pos, fmtPosValidatorId, isNotShowTip)
	local cfg = FormationValidatorConfig.instance:getFormationPosValidatorCfg(fmtPosValidatorId)

	if not cfg then
		return true
	end

	local posisions = self:_getFormationPoses()

	for i, petId in ipairs(posisions) do
		if i == pos then
			if petId > 0 then
				local petMo = self:_getPet(petId)

				if petMo then
					if cfg.ban then
						self:_showTip(cfg.desc)

						return false
					end

					local isMatch = string.nilorempty(cfg.validator) and true or ConditionValidator.instance:isMatch(cfg.validator, FormationValidatorController._doSingleValidator, petMo, self.formationMO)

					if cfg.allow and not isMatch then
						if not isNotShowTip then
							self:_showTip(cfg.desc)
						end

						return false
					elseif not cfg.allow and isMatch and not isNotShowTip then
						if not isNotShowTip then
							self:_showTip(cfg.desc)
						end

						return false
					end

					return true
				end
			else
				if cfg.ban then
					return true
				end

				if cfg.allow then
					if not isNotShowTip then
						self:_showTip(cfg.desc)
					end

					return false
				else
					return true
				end
			end
		end
	end

	return true
end

function FormationValidatorController:_handleOnClickEnterBattleIsAllMatch(fmtAllValidatorId, isNotShowTip)
	local cfg = FormationValidatorConfig.instance:getFormationAllValidatorCfg(fmtAllValidatorId)

	if not cfg then
		return true
	end

	local count = 0
	local posisions = self:_getFormationPoses()

	for i, petId in ipairs(posisions) do
		if petId > 0 then
			if string.nilorempty(cfg.validator) then
				count = count + 1
			else
				local petMo = self:_getPet(petId)

				if petMo then
					local isMatch = ConditionValidator.instance:isMatch(cfg.validator, FormationValidatorController._doSingleValidator, petMo, self.formationMO)

					if isMatch then
						count = count + 1
					end
				end
			end
		end
	end

	local isNeedRemove, removeNum = self:_compareRemove(cfg.compareType, count, cfg.count)
	local isNotMatch = isNeedRemove and removeNum > 0

	if isNotMatch then
		if not isNotShowTip then
			self:_showTip(cfg.desc)
		end

		return false
	end

	local isNeedAdd, addNum = self:_compareAdd(cfg.compareType, count, cfg.count)
	local isAddNotMatch = isNeedAdd and addNum > 0

	if isAddNotMatch then
		if not isNotShowTip then
			self:_showTip(cfg.desc)
		end

		return false
	end

	return true
end

function FormationValidatorController:_showTip(desc, isShowTip)
	isShowTip = isShowTip == nil or isShowTip == true

	if isShowTip then
		FloatWordMgr.instance:show(desc)
	end
end

FormationValidatorController.instance = FormationValidatorController.New()

return FormationValidatorController
