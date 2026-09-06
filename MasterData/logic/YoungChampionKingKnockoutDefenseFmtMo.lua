-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/model/YoungChampionKingKnockoutDefenseFmtMo.lua

module("logic.extensions.youngchampionking.model.YoungChampionKingKnockoutDefenseFmtMo", package.seeall)

local YoungChampionKingKnockoutDefenseFmtMo = class("YoungChampionKingKnockoutDefenseFmtMo", BaseCustomFmtMo)

function YoungChampionKingKnockoutDefenseFmtMo:initParams(stepId)
	self.isShowBtnSave = true
	self.enterStepId = stepId
	self.isShowTab = true
	self.curTabIndex = 1

	self:clearAllPetList()
	self:refreshMyFmts()
end

function YoungChampionKingKnockoutDefenseFmtMo:refreshMyFmts()
	local formInfoList = YoungChampionKingModel.instance:getKnockoutFormInfos()

	if formInfoList then
		for _, formInfo in ipairs(formInfoList) do
			local form = self.forMationMap[formInfo.formId]

			if not form then
				form = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
				self.forMationMap[formInfo.formId] = form
			end

			form:SetData(formInfo.simpleForm)
		end
	end
end

function YoungChampionKingKnockoutDefenseFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function YoungChampionKingKnockoutDefenseFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function YoungChampionKingKnockoutDefenseFmtMo:_changePetMo(petMo)
	local petMoForm = petMo:GetClone()

	petMoForm.attrMo:resetPublicAttr()
	petMoForm.attrMo:calcTotalAttrs()
	petMoForm:refreshAllAttr()

	return petMoForm
end

function YoungChampionKingKnockoutDefenseFmtMo:initSaveHandler()
	local function handler(fmtMo, fromBtnSave)
		if self:checkFormationLimitAndPopWin() then
			return
		end

		if fromBtnSave == true then
			local simpleFormList = {}

			for formId, fmtMo in ipairs(self.forMationMap) do
				table.insert(simpleFormList, CustomFmtController.instance:createFormPb(fmtMo))
			end

			YoungChampionKingController.instance:sendPM_YCKKnockoutSetFormationReq(simpleFormList)
		end
	end

	self.setSaveHandler(self, handler, self)
end

function YoungChampionKingKnockoutDefenseFmtMo:showForbitPetAlert(petMo)
	local boo, tips = self:checkPetIsForbit(petMo)

	FloatWordMgr.instance:show(tips)
end

function YoungChampionKingKnockoutDefenseFmtMo:checkFormationLimitAndPopWin()
	local isLimit = false
	local isExitEmpty = false
	local emptyFormId = 0

	for formId, fmtMo in ipairs(self.forMationMap) do
		if fmtMo:isEmpty() then
			isExitEmpty = true

			return
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

function YoungChampionKingKnockoutDefenseFmtMo:checkPetIsForbit(checkPetMo)
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

function YoungChampionKingKnockoutDefenseFmtMo:getFormationExtendViewName()
	return ViewName.YoungChampionKingDeFmtExView
end

return YoungChampionKingKnockoutDefenseFmtMo
