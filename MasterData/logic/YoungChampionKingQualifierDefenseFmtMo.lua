-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/model/YoungChampionKingQualifierDefenseFmtMo.lua

module("logic.extensions.youngchampionking.model.YoungChampionKingQualifierDefenseFmtMo", package.seeall)

local YoungChampionKingQualifierDefenseFmtMo = class("YoungChampionKingQualifierDefenseFmtMo", ICustomFmtMo)

function YoungChampionKingQualifierDefenseFmtMo:initParams(stepId)
	self.enterStepId = stepId
	self.isShowBtnSave = true

	self:getCurFormation():SetData(YoungChampionKingModel.instance:getQualifierFormInfo())

	self.activityId = YoungChampionKingModel.instance:getCurActId()

	self:clearAllPetList()
end

function YoungChampionKingQualifierDefenseFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function YoungChampionKingQualifierDefenseFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(self:_changePetMo(petMo))
	end
end

function YoungChampionKingQualifierDefenseFmtMo:_changePetMo(petMo)
	local petMoForm = petMo:GetClone()

	petMoForm.attrMo:resetPublicAttr()
	petMoForm.attrMo:calcTotalAttrs()
	petMoForm:refreshAllAttr()

	return petMoForm
end

function YoungChampionKingQualifierDefenseFmtMo:initSaveHandler()
	local function handler(fmtMo, fromBtnSave)
		if self:checkFormationLimitAndPopWin() then
			return
		end

		if fromBtnSave == true then
			YoungChampionKingController.instance:sendPM_YCKSetDefenseForamtionReq(self:getCurSimpleForm())
		end
	end

	self.setSaveHandler(self, handler, self)
end

function YoungChampionKingQualifierDefenseFmtMo:checkFormationLimitAndPopWin()
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

function YoungChampionKingQualifierDefenseFmtMo:getFormationExtendViewName()
	return ViewName.YoungChampionKingDeFmtExView
end

function YoungChampionKingQualifierDefenseFmtMo:isClickCanCloseInFomation()
	local isEmpty = self:getCurFormation()

	isEmpty()

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

return YoungChampionKingQualifierDefenseFmtMo
