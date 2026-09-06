-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongunionMissionLeftView.lua

module("logic.extensions.chuangkongunion.view.ChuangkongunionMissionLeftView", package.seeall)

local ChuangkongunionMissionLeftView = class("ChuangkongunionMissionLeftView", FormationLeftView)

function ChuangkongunionMissionLeftView:onEnter()
	local openParam = self:getOpenParam()

	self._stageCfg, self._teamId = openParam[1], openParam[3]

	if self._teamId == nil then
		goutil.setActive(self._Btn_Formation.gameObject, false)
	end

	ChuangkongunionModel.instance:initFormation(self._teamId or self._stageCfg.teamId)
	ChuangkongunionMissionLeftView.super.onEnter(self)
	self:setBtnCutePetActive(false)
	self:_setActiveBtnFormationUse(false)
end

function ChuangkongunionMissionLeftView:_saveCurrFmt()
	if self._teamId then
		ChuangkongunionMissionLeftView.super._saveCurrFmt(self)
	end
end

function ChuangkongunionMissionLeftView:_OnClickBtnBuffForm()
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(96)

	if not isOpen then
		local cfgFuncOpen = FuncOpenConfig.instance:getFunctionOpenById(96)

		if cfgFuncOpen then
			FloatWordMgr.instance:show(cfgFuncOpen.description)
		end

		return
	end

	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()

	UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, true)

	if self._teamId == nil then
		TipsFacade.instance:openCommonTips(lang("tip_form_auto_full_level"))
	end
end

function ChuangkongunionMissionLeftView:_onUpdateBuffFormById(info)
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(96)

	goutil.setActive(self._MarkLock_BuffForm, not isOpen)

	local formId
	local formLv = 0

	if isOpen then
		if info then
			formId = info.formStrengthId

			if self._teamId == nil then
				formLv = BattleConfig.instance:getFormStrengthMaxLv(formId)
				info.formStrengthLv = formLv
			else
				formLv = info.formStrengthLv
			end
		end

		self:SetFormStrengthInfo(info)
	end

	self:_onSelectBuffForm(formId, formLv)

	if self._CurFormId ~= formId then
		self._CurFormId = checknumber(formId)

		self:_SetPowerAndSpeed()

		if checknumber(formId) > 0 then
			self:_showFormationActive()
		end
	end
end

function ChuangkongunionMissionLeftView:SetFormStrengthInfo(info)
	self:_getCurFormation():SetFormStrengthInfo(info)

	local formStrengthId = -1

	if info then
		formStrengthId = info.formStrengthId
	end

	if self._teamId then
		FormationController.instance:setCurrBuffFormInfo(formStrengthId)
	else
		local fomation = self:_getCurFormation()

		if fomation and (fomation._formStrengInfo == nil or fomation._formStrengInfo.formStrengthId ~= formStrengthId) then
			fomation:SetFormStrengthInfo(info)
		end
	end
end

function ChuangkongunionMissionLeftView:_getPet(petId)
	if self._teamId then
		return ChuangkongunionMissionLeftView.super._getPet(self, petId)
	else
		return ChuangkongunionModel.instance:getPetMo(petId)
	end
end

function ChuangkongunionMissionLeftView:_getCurFormId()
	if self._teamId then
		return ChuangkongunionMissionLeftView.super._getCurFormId(self)
	else
		return 10
	end
end

function ChuangkongunionMissionLeftView:_getCurFormation()
	if self._teamId then
		return ChuangkongunionMissionLeftView.super._getCurFormation(self)
	else
		return ChuangkongunionModel.instance:getFormation(self._stageCfg.teamId)
	end
end

function ChuangkongunionMissionLeftView:_getItemSeatCls()
	if self._teamId then
		return ItemSeat
	else
		return ChuangkongunionItemSeat
	end
end

return ChuangkongunionMissionLeftView
