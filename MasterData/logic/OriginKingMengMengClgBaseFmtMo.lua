-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/model/OriginKingMengMengClgBaseFmtMo.lua

module("logic.extensions.originkingmengmengclg.model.OriginKingMengMengClgBaseFmtMo", package.seeall)

local OriginKingMengMengClgBaseFmtMo = class("OriginKingMengMengClgBaseFmtMo", BaseCustomFmtMo)

function OriginKingMengMengClgBaseFmtMo:updateData()
	OriginKingMengMengClgBaseFmtMo.super.updateData(self)
	self:_syncMustOnFormValidatorDesc()
end

function OriginKingMengMengClgBaseFmtMo:onFormationChangeFinish()
	OriginKingMengMengClgBaseFmtMo.super.onFormationChangeFinish(self)
	self:_syncMustOnFormValidatorDesc()
end

function OriginKingMengMengClgBaseFmtMo:getFinalFmoList(posList, petPool, needPets)
	posList, petPool = OriginKingMengMengClgBaseFmtMo.super.getFinalFmoList(self, posList, petPool, needPets)

	if self:_needCheckMustOnFormPet() then
		local isMustOnFormPetReady = false

		for _, petMo in ipairs(petPool) do
			if self:_isMustOnFormPetMoMatch(petMo) then
				isMustOnFormPetReady = true

				break
			end
		end

		if not isMustOnFormPetReady then
			local mustOnFormPetMo, replaceIndex = self:_findBestMustOnFormPetMo(posList, petPool)

			if mustOnFormPetMo and replaceIndex > 0 then
				local fixPos = checknumber(posList[replaceIndex])

				if fixPos > 0 then
					posList, petPool = CustomFmtController.instance:getFinalFmoListAsFixPos(self:getCurFormation(), posList, petPool, needPets, {
						fixPos
					}, {
						mustOnFormPetMo
					}, self.needUpPetCount)
				end
			end
		end
	end

	return posList, petPool
end

function OriginKingMengMengClgBaseFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if not self:_isMustOnFormPetMatch() then
		FloatWordMgr.instance:show(self:_getMustOnFormPetTip())

		return true
	end

	return OriginKingMengMengClgBaseFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

function OriginKingMengMengClgBaseFmtMo:_isCandidatePetValid(petMo)
	return true
end

function OriginKingMengMengClgBaseFmtMo:_isMustOnFormPetMatch()
	if not self:_needCheckMustOnFormPet() then
		return true
	end

	local formation = self:getCurFormation()
	local positions = formation and formation:GetPositions() or {}

	for _, petId in ipairs(positions) do
		if petId > 0 then
			local petMo = self:getPetMoById(petId)

			if self:_isMustOnFormPetMoMatch(petMo, formation) then
				return true
			end
		end
	end

	return false
end

function OriginKingMengMengClgBaseFmtMo:_isMustOnFormPetMoMatch(petMo, formation)
	if not petMo then
		return false
	end

	return ConditionValidator.instance:isMatch(self._mustOnFormPetFilter, FormationValidatorController._doSingleValidator, petMo, formation or self:getCurFormation())
end

function OriginKingMengMengClgBaseFmtMo:_needCheckMustOnFormPet()
	return not string.nilorempty(self._mustOnFormPetFilter)
end

function OriginKingMengMengClgBaseFmtMo:_getMustOnFormPetTip()
	if self._stageData and not string.nilorempty(self._stageData.name) then
		return string.format("请至少上阵一只任意时代的%s", self._stageData.name)
	end

	local filterName = self:_getMustOnFormPetFilterName()

	if not string.nilorempty(filterName) then
		return string.format("请至少上阵一只任意时代的%s", filterName)
	end

	return "请至少上阵一只符合条件的精灵"
end

function OriginKingMengMengClgBaseFmtMo:_syncMustOnFormValidatorDesc()
	if checknumber(self:getFormCondition()) > 0 then
		return
	end

	if not self:_needCheckMustOnFormPet() then
		return
	end

	self.validatorDescStr = self:_getMustOnFormPetTip()
	self.validatorDescIsShowYesOrNo = true

	self:setValidatorDescYesOrNo(self:_isMustOnFormPetMatch())
end

function OriginKingMengMengClgBaseFmtMo:_getMustOnFormPetFilterName()
	if string.nilorempty(self._mustOnFormPetFilter) then
		return ""
	end

	local filterInfos = string.split(self._mustOnFormPetFilter, "$")

	if filterInfos[1] == "Signs" then
		return filterInfos[2] or ""
	end

	return ""
end

function OriginKingMengMengClgBaseFmtMo:_findBestMustOnFormPetMo(posList, petPool)
	local petList = self:getAllShowPetList()
	local result
	local replaceIndex = 0
	local maxZdl = -1

	for _, petMo in pairs(petList) do
		if self:_isCandidatePetValid(petMo) and self:_isMustOnFormPetMoMatch(petMo) then
			local index = self:_getReplaceIndexForMustOnFormPet(posList, petPool, petMo)
			local zdl = index > 0 and petMo:getFightingPower() or -1

			if index > 0 and maxZdl < zdl then
				replaceIndex = index
				result = petMo
				maxZdl = zdl
			end
		end
	end

	return result, replaceIndex
end

function OriginKingMengMengClgBaseFmtMo:_getReplaceIndexForMustOnFormPet(posList, petPool, mustOnFormPetMo)
	local replaceIndex = 0
	local minZdl = -1

	for index, petMo in ipairs(petPool) do
		local pos = checknumber(posList[index])

		if pos > 0 and self:isPosValidatorMatchOnSelect(pos, mustOnFormPetMo.petId, false) then
			local zdl = petMo:getFightingPower()

			if petMo:getDefineId() == mustOnFormPetMo:getDefineId() then
				return index
			elseif minZdl <= 0 or zdl < minZdl then
				minZdl = zdl
				replaceIndex = index
			end
		end
	end

	return replaceIndex
end

return OriginKingMengMengClgBaseFmtMo
