-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/model/MartialContestScoreDefenseFmtMo.lua

module("logic.extensions.martialcontest.model.MartialContestScoreDefenseFmtMo", package.seeall)

local MartialContestScoreDefenseFmtMo = class("MartialContestScoreDefenseFmtMo", BaseCustomFmtMo)

function MartialContestScoreDefenseFmtMo:initParams(activityId, stepId, roundId)
	self.activityId = activityId
	self.enterStepId = stepId
	self.roundId = roundId
	self.isShowBtnSave = true
	self._equipToPetInfo = {}
	self._petToEquipInfo = {}
	self.isShowTab = true
	self.curTabIndex = 1
	self.maxTabCount = 3

	self:clearAllPetList()
	self:refreshMyFmts()
end

function MartialContestScoreDefenseFmtMo:refreshMyFmts()
	local formationInfo = MartialContestModel.instance:getFinalFormation(self.activityId)

	if formationInfo and formationInfo.forms then
		for _, formInfo in ipairs(formationInfo.forms) do
			local form = self.forMationMap[formInfo.formId]

			if not form then
				form = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
				self.forMationMap[formInfo.formId] = form
			end

			form:SetData(formInfo.simpleForm)

			if formInfo.equips then
				for _, equipInfo in ipairs(formInfo.equips) do
					self:setEquipInfo(equipInfo.petId, equipInfo.equipId)
				end
			end
		end
	end
end

function MartialContestScoreDefenseFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function MartialContestScoreDefenseFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function MartialContestScoreDefenseFmtMo:_changePetMo(petMo)
	local petMoForm = petMo:GetClone()

	petMoForm.attrMo:resetPublicAttr()
	petMoForm.attrMo:calcTotalAttrs()
	petMoForm:refreshAllAttr()

	return petMoForm
end

function MartialContestScoreDefenseFmtMo:initSaveHandler()
	local function handler(cutFmtMo, fromBtnSave)
		if self:checkFormationLimitAndPopWin() then
			return
		end

		if fromBtnSave == true then
			local simpleFormList = {}

			for formId, fmtMo in pairs(self.forMationMap) do
				local simpleForm = {}

				simpleForm.simpleForm = CustomFmtController.instance:createFormPb(fmtMo)
				simpleForm.formId = formId
				simpleForm.equipList = {}

				if self._equipToPetInfo then
					for equipId, petId in pairs(self._equipToPetInfo) do
						if fmtMo:GetPetPosition(petId) then
							table.insert(simpleForm.equipList, {
								equipId = equipId,
								petId = petId
							})
						end
					end
				end

				table.insert(simpleFormList, simpleForm)
			end

			MartialContestController.instance:sendPM_MCScoreSetFormationReq(self.activityId, simpleFormList)
		end
	end

	self.setSaveHandler(self, handler, self)
end

function MartialContestScoreDefenseFmtMo:checkFormationLimitAndPopWin()
	local isLimit = false
	local emptyList = {}
	local isExitEmpty = false

	for formId, fmtMo in pairs(self.forMationMap) do
		if fmtMo:isEmpty() then
			isExitEmpty = true

			table.insert(emptyList, langPara("%d号", formId))
		end
	end

	if isExitEmpty then
		local content = table.concat(emptyList, "、")
		local tip = langPara("%s阵型为空阵", content)

		TipsFacade.instance:openTipWindowNoX("提示", tip, function()
			return
		end)

		isLimit = true
	end

	return isLimit
end

function MartialContestScoreDefenseFmtMo:showForbitPetAlert(petMo)
	local boo, tips = self:checkPetIsForbit(petMo)

	FloatWordMgr.instance:show(tips)
end

function MartialContestScoreDefenseFmtMo:checkPetIsForbit(checkPetMo)
	local isForbit = false
	local tips = ""

	if isForbit == false then
		for i, form in ipairs(self.forMationMap) do
			if i ~= self.curTabIndex then
				local pet_poisition = form:GetPositions() or {}

				for idx, v in ipairs(pet_poisition) do
					if v ~= 0 then
						local petmo = self:getPetMoById(v)

						if petmo and checkPetMo:getDefineId() == petmo:getDefineId() then
							isForbit = true
							tips = langPara("【%s】阵型中已使用该精灵", i)

							break
						end
					end
				end
			end
		end
	end

	return isForbit, tips
end

function MartialContestScoreDefenseFmtMo:getFormationExtendViewName()
	return ViewName.MartialContestDeFmtExView
end

function MartialContestScoreDefenseFmtMo:isClickCanCloseInFomation()
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

function MartialContestScoreDefenseFmtMo:setEquipInfo(petId, equipId)
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

function MartialContestScoreDefenseFmtMo:resetEquipInfo(petId)
	self._petToEquipInfo = self._petToEquipInfo or {}
	self._equipToPetInfo = self._equipToPetInfo or {}

	local oldEquipId = self._petToEquipInfo[petId]

	if oldEquipId and oldEquipId > 0 then
		self._equipToPetInfo[oldEquipId] = nil
	end

	self._petToEquipInfo[petId] = nil
end

function MartialContestScoreDefenseFmtMo:getCurEquipId(petId)
	if self._petToEquipInfo then
		return self._petToEquipInfo[petId]
	end
end

function MartialContestScoreDefenseFmtMo:getCurEquipPetId(equipId)
	if self._equipToPetInfo then
		return self._equipToPetInfo[equipId]
	end
end

function MartialContestScoreDefenseFmtMo:refreshCurEquipState()
	local resetList = {}

	if self._petToEquipInfo then
		for petId, equipId in pairs(self._petToEquipInfo) do
			if equipId and equipId > 0 then
				local isInFromation = false

				for i, form in pairs(self.forMationMap) do
					if form:GetPetPosition(petId) then
						isInFromation = true

						break
					end
				end

				if not isInFromation then
					table.insert(resetList, petId)
				end
			end
		end
	end

	for i, v in ipairs(resetList) do
		self:resetEquipInfo(v)
	end
end

return MartialContestScoreDefenseFmtMo
