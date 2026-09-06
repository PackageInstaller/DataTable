-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/model/MartialContestQualifierDefenseFmtMo.lua

module("logic.extensions.martialcontest.model.MartialContestQualifierDefenseFmtMo", package.seeall)

local MartialContestQualifierDefenseFmtMo = class("MartialContestQualifierDefenseFmtMo", BaseCustomFmtMo)

function MartialContestQualifierDefenseFmtMo:initParams(activityId, stepId, roundId)
	self.activityId = activityId
	self.enterStepId = stepId
	self.roundId = roundId
	self.isShowBtnSave = true
	self._equipToPetInfo = {}
	self._petToEquipInfo = {}
	self.curTabIndex = 1

	local defenseFormationInfo = MartialContestModel.instance:getDefenseForamtion(self.activityId)

	if defenseFormationInfo.simpleForm then
		self:getCurFormation():SetData(defenseFormationInfo.simpleForm.simpleForm)

		if defenseFormationInfo.simpleForm.equips then
			for i, v in ipairs(defenseFormationInfo.simpleForm.equips) do
				self:setEquipInfo(v.petId, v.equipId)
			end
		end
	end

	self:clearAllPetList()
end

function MartialContestQualifierDefenseFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end

	if self.enterStepId == MartialContestEnum.Qualify_Step_Id then
		local supportPet = MartialContestConfig.instance:getSupportPetList()

		for i, v in ipairs(supportPet) do
			local fMo = FightingPowerPetMo.New()

			fMo:fromChallengeCreepCo(v)

			local petMo = fMo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function MartialContestQualifierDefenseFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function MartialContestQualifierDefenseFmtMo:_changePetMo(petMo)
	local petMoForm = petMo:GetClone()

	petMoForm.attrMo:resetPublicAttr()
	petMoForm.attrMo:calcTotalAttrs()
	petMoForm:refreshAllAttr()

	return petMoForm
end

function MartialContestQualifierDefenseFmtMo:initSaveHandler()
	local function handler(fmtMo, fromBtnSave)
		if self:checkFormationLimitAndPopWin() then
			return
		end

		if fromBtnSave == true then
			local equipList = {}

			if self._equipToPetInfo then
				for equipId, petId in pairs(self._equipToPetInfo) do
					table.insert(equipList, {
						equipId = equipId,
						petId = petId
					})
				end
			end

			local simpleForm = self:getCurSimpleForm()

			MartialContestController.instance:sendPM_MCSetQualifierDefenseForamtionReq(self.activityId, simpleForm, equipList)
			FloatWordMgr.instance:show("保存成功")
		end
	end

	self.setSaveHandler(self, handler, self)
end

function MartialContestQualifierDefenseFmtMo:checkFormationLimitAndPopWin()
	local isLimit = false
	local isEmpty = self:getCurFormation():isEmpty()

	if isEmpty then
		local tip = langPara("守阵不能为空")

		TipsFacade.instance:openTipWindowNoX("提示", tip, function()
			return
		end)

		isLimit = true
	end

	return isLimit
end

function MartialContestQualifierDefenseFmtMo:getFormationExtendViewName()
	return ViewName.MartialContestDeFmtExView
end

function MartialContestQualifierDefenseFmtMo:isClickCanCloseInFomation()
	local isEmpty = self:getCurFormation():isEmpty()

	if isEmpty then
		local tip = langPara("守阵不能为空")

		TipsFacade.instance:openPopupWindowWithX("提示", tip, function()
			self:setSaveHandler(nil, nil)
			UIStateManager.instance:popByName(ViewName.CustomFormationView)
		end)

		return false
	end

	return true
end

function MartialContestQualifierDefenseFmtMo:setEquipInfo(petId, equipId)
	self._petToEquipInfo = self._petToEquipInfo or {}
	self._equipToPetInfo = self._equipToPetInfo or {}

	local oldPetId = self._equipToPetInfo[equipId]
	local oldEquipId = self._petToEquipInfo[petId]

	if oldPetId and oldPetId > 0 then
		self._petToEquipInfo[oldPetId] = nil
	end

	if oldEquipId and oldEquipId > 0 then
		self._equipToPetInfo[oldEquipId] = nil
	end

	self._petToEquipInfo[petId] = equipId
	self._equipToPetInfo[equipId] = petId
end

function MartialContestQualifierDefenseFmtMo:resetEquipInfo(petId)
	self._petToEquipInfo = self._petToEquipInfo or {}
	self._equipToPetInfo = self._equipToPetInfo or {}

	local oldEquipId = self._petToEquipInfo[petId]

	if oldEquipId and oldEquipId > 0 then
		self._equipToPetInfo[oldEquipId] = nil
	end

	self._petToEquipInfo[petId] = nil
end

function MartialContestQualifierDefenseFmtMo:getCurEquipId(petId)
	if self._petToEquipInfo then
		return self._petToEquipInfo[petId]
	end
end

function MartialContestQualifierDefenseFmtMo:getCurEquipPetId(equipId)
	if self._equipToPetInfo then
		return self._equipToPetInfo[equipId]
	end
end

function MartialContestQualifierDefenseFmtMo:refreshCurEquipState()
	local resetList = {}

	if self._petToEquipInfo then
		for petId, equipId in pairs(self._petToEquipInfo) do
			if equipId and equipId > 0 then
				if not self:getCurFormation():GetPetPosition(petId) then
					table.insert(resetList, petId)
				end
			end
		end
	end

	for i, v in ipairs(resetList) do
		self:resetEquipInfo(v)
	end
end

return MartialContestQualifierDefenseFmtMo
