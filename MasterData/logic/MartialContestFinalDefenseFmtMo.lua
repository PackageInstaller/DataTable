-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/model/MartialContestFinalDefenseFmtMo.lua

module("logic.extensions.martialcontest.model.MartialContestFinalDefenseFmtMo", package.seeall)

local MartialContestFinalDefenseFmtMo = class("MartialContestFinalDefenseFmtMo", BaseCustomFmtMo)

function MartialContestFinalDefenseFmtMo:initParams(activityId, is3v3)
	self.activityId = activityId
	self.isShowBtnSave = true
	self._equipToPetInfo = {}
	self._petToEquipInfo = {}
	self.isShowTab = true
	self.curTabIndex = 1
	self.maxTabCount = is3v3 and 3 or 1

	if self.maxTabCount == 1 then
		self.isShowTab = false
	end

	self._is3v3 = is3v3

	self:clearAllPetList()
	self:refreshMyFmts()
end

function MartialContestFinalDefenseFmtMo:refreshMyFmts()
	if self._is3v3 then
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
	else
		local defenseFormationInfo = MartialContestModel.instance:getDefenseForamtion(self.activityId)

		if defenseFormationInfo and defenseFormationInfo.simpleForm then
			self:getCurFormation():SetData(defenseFormationInfo.simpleForm.simpleForm)

			if defenseFormationInfo.simpleForm.equips then
				for i, v in ipairs(defenseFormationInfo.simpleForm.equips) do
					self:setEquipInfo(v.petId, v.equipId)
				end
			end
		end
	end
end

function MartialContestFinalDefenseFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function MartialContestFinalDefenseFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function MartialContestFinalDefenseFmtMo:_changePetMo(petMo)
	local petMoForm = petMo:GetClone()

	petMoForm.attrMo:resetPublicAttr()
	petMoForm.attrMo:calcTotalAttrs()
	petMoForm:refreshAllAttr()

	return petMoForm
end

function MartialContestFinalDefenseFmtMo:initSaveHandler()
	local function handler(cutFmtMo, fromBtnSave)
		if self:checkFormationLimitAndPopWin() then
			return
		end

		if fromBtnSave == true then
			if self._is3v3 then
				local simpleFormList = {}
				local buffIds = {}

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

				MartialContestController.instance:sendPM_MCFinalsSetDefenseForamtionReq(self.activityId, simpleFormList, buffIds)
			else
				local equipList = {}

				if self._equipToPetInfo then
					for equipId, petId in pairs(self._equipToPetInfo) do
						table.insert(equipList, {
							equipId = equipId,
							petId = petId
						})
					end
				end

				MartialContestController.instance:sendPM_MCSetQualifierDefenseForamtionReq(self.activityId, self:getCurSimpleForm(), equipList)
				FloatWordMgr.instance:show("新的阵型将在下一轮战斗阶段生效")
			end
		end
	end

	self.setSaveHandler(self, handler, self)
end

function MartialContestFinalDefenseFmtMo:checkFormationLimitAndPopWin()
	local isLimit = false
	local isExitEmpty = false
	local emptyFormId = 0

	for formId, fmtMo in pairs(self.forMationMap) do
		if fmtMo:isEmpty() then
			isExitEmpty = true
			emptyFormId = formId

			break
		end
	end

	if isExitEmpty then
		local tip = string.format("%s号阵为空阵", emptyFormId)

		TipsFacade.instance:openTipWindowNoX("提示", tip, function()
			return
		end)

		isLimit = true
	end

	return isLimit
end

function MartialContestFinalDefenseFmtMo:showForbitPetAlert(petMo)
	local boo, tips = self:checkPetIsForbit(petMo)

	FloatWordMgr.instance:show(tips)
end

function MartialContestFinalDefenseFmtMo:checkPetIsForbit(checkPetMo)
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

function MartialContestFinalDefenseFmtMo:getFormationExtendViewName()
	return ViewName.MartialcontestfinaldefmtexView
end

function MartialContestFinalDefenseFmtMo:isClickCanCloseInFomation()
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

function MartialContestFinalDefenseFmtMo:setEquipInfo(petId, equipId)
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

function MartialContestFinalDefenseFmtMo:resetEquipInfo(petId)
	self._petToEquipInfo = self._petToEquipInfo or {}
	self._equipToPetInfo = self._equipToPetInfo or {}

	local oldEquipId = self._petToEquipInfo[petId]

	if oldEquipId and oldEquipId > 0 then
		self._equipToPetInfo[oldEquipId] = nil
	end

	self._petToEquipInfo[petId] = nil
end

function MartialContestFinalDefenseFmtMo:getCurEquipId(petId)
	if self._petToEquipInfo then
		return self._petToEquipInfo[petId]
	end
end

function MartialContestFinalDefenseFmtMo:getCurEquipPetId(equipId)
	if self._equipToPetInfo then
		return self._equipToPetInfo[equipId]
	end
end

function MartialContestFinalDefenseFmtMo:refreshCurEquipState()
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

return MartialContestFinalDefenseFmtMo
