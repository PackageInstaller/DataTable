-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/model/GodStatuesWarAdvanceCustomFmtMo.lua

module("logic.extensions.godstatueswar.model.GodStatuesWarAdvanceCustomFmtMo", package.seeall)

local GodStatuesWarAdvanceCustomFmtMo = class("GodStatuesWarAdvanceCustomFmtMo", BaseCustomFmtMo)

function GodStatuesWarAdvanceCustomFmtMo:onReset()
	GodStatuesWarAdvanceCustomFmtMo.super.onReset(self)

	self._seasonId = 0
	self.isShowBtnSave = true
end

function GodStatuesWarAdvanceCustomFmtMo:updateCfg(seasonId)
	self._seasonId = checknumber(seasonId)

	local addHpRate = GodStatuesWarConfig.instance:getNfbParamsValue("HP_INCREASE_RATE", true)

	self.formationTips = string.format("守阵阵容将血量提升%s%%，同时恢复血量将无法使用", (addHpRate - 1) * 100)
end

function GodStatuesWarAdvanceCustomFmtMo:updateData()
	self.isShowBtnFormation = false
	self.isShowBtnBuffForm = false
	self.isShowTab = true

	self:refreshMyFmts()
end

function GodStatuesWarAdvanceCustomFmtMo:initFormationMo()
	self.forMationMap = {}

	for idx = 1, self.maxTabCount do
		self.forMationMap[idx] = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	end

	self.formationMo = self:getCurFormation()
end

function GodStatuesWarAdvanceCustomFmtMo:getCurFormation()
	return self.forMationMap[self.curTabIndex]
end

function GodStatuesWarAdvanceCustomFmtMo:refreshMyFmts()
	for id = 1, self.maxTabCount do
		local formInfo = GodStatuesWarController.instance:getFormInfoOfMy(self._seasonId, id)

		if formInfo then
			self.forMationMap[id]:SetData(formInfo.form)
		else
			self.forMationMap[id]:ResetPosition()
		end
	end
end

function GodStatuesWarAdvanceCustomFmtMo:sendSaveMsg(fromBtnSave)
	if not fromBtnSave then
		return
	end

	GodStatuesWarAdvanceCustomFmtMo.super.sendSaveMsg(self, fromBtnSave)
end

function GodStatuesWarAdvanceCustomFmtMo:initSaveHandler()
	self.setSaveHandler(self, self.fmtSaveReq, self)
end

function GodStatuesWarAdvanceCustomFmtMo:fmtSaveReq()
	local isEmpty, indexList = self:isHaveEmptyFmt()

	if isEmpty then
		local str = ""

		for _, index in ipairs(indexList) do
			str = index < #indexList and str .. string.format("%s号阵型、", index) or str .. string.format("%s号阵型", index)
		end

		str = str .. "为空阵，不能保存作为守阵，请返回布阵"

		FloatWordMgr.instance:show(str)

		return
	end

	local simpleFormList = self:getSimpleFormList()

	GlobalDispatcher:addListener(GlobalNotify.handlePM_NewFamilyBattleSetFormRes, self._handleFmtSaveReq, self)
	GodStatuesWarController.instance:sendPM_NewFamilyBattleSetFormReq(self._seasonId, simpleFormList)
end

function GodStatuesWarAdvanceCustomFmtMo:_handleFmtSaveReq(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_NewFamilyBattleSetFormRes, self._handleFmtSaveReq, self)

	if status ~= 0 then
		return
	end

	FloatWordMgr.instance:show("阵容保存成功")
end

function GodStatuesWarAdvanceCustomFmtMo:getSimpleFormList()
	local list = {}

	for idx = 1, self.maxTabCount do
		local forMation = self.forMationMap[idx]

		if forMation then
			table.insert(list, CustomFmtController.instance:createFormPb(forMation))
		end
	end

	return list
end

function GodStatuesWarAdvanceCustomFmtMo:isHaveEmptyFmt()
	local isHave = false
	local indexList = {}

	for idx, forMation in pairs(self.forMationMap) do
		if forMation:isEmpty() then
			isHave = true

			table.insert(indexList, idx)
		end
	end

	return isHave, indexList
end

function GodStatuesWarAdvanceCustomFmtMo:checkPetIsForbit(checkPetMo)
	for i = 1, self.maxTabCount do
		if i ~= self.curTabIndex then
			local otherFormationMo = self.forMationMap[i]
			local pet_poisition = otherFormationMo:GetPositions() or {}

			for idx, v in ipairs(pet_poisition) do
				if v ~= 0 then
					local petmo = self:getPetMoById(v)

					if petmo and checkPetMo:getDefineId() == petmo:getDefineId() then
						return true, i
					end
				end
			end
		end
	end

	return false
end

function GodStatuesWarAdvanceCustomFmtMo:showForbitPetAlert(petMo)
	local boo, tabIdx = self:checkPetIsForbit(petMo)

	if boo then
		FloatWordMgr.instance:show(langPara("【%s】阵型中已使用该精灵", tabIdx))
	end
end

return GodStatuesWarAdvanceCustomFmtMo
