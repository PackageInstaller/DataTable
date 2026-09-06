-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/MasterFormFmtSubmitView.lua

module("logic.extensions.masterform.view.MasterFormFmtSubmitView", package.seeall)

local MasterFormFmtSubmitView = class("MasterFormFmtSubmitView", ViewComponent)

MasterFormFmtSubmitView.FmtState = {
	Editable = 2,
	UnEditable = 1,
	Editing = 3
}

function MasterFormFmtSubmitView:buildUI()
	MasterFormFmtSubmitView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._tabCol = {}

	local mainGo = goutil.findChild(self.mainGO, "tabCol")

	self._tabCol._mainGo = mainGo
	self._tabCol._tabScrollercell = goutil.findChild(mainGo, "tabScrollercell")
	self._tabCol._tabScrollerview = goutil.findChild(mainGo, "tabScrollerview")
	self._fmtCol = {}

	local mainGo = goutil.findChild(self.mainGO, "fmtCol")

	self._fmtCol._mainGo = mainGo
	self._fmtCol._btnInput = goutil.findChild(mainGo, "btnInput")
	self._fmtCol._InputField = goutil.findChild(mainGo, "InputField")
	self._fmtCol._fmtView = goutil.findChild(mainGo, "fmtView")
	self._descCol = {}

	local mainGo = goutil.findChild(self.mainGO, "descCol")

	self._descCol._mainGo = mainGo
	self._descCol._txtTimes = goutil.findChildTextComponent(mainGo, "txtTimes/txt")
	self._descCol._btnSubmit = goutil.findChild(mainGo, "btnSubmit")
	self._descCol._txtBtnSubmit = goutil.findChildTextComponent(mainGo, "btnSubmit/txt")
	self._descCol._kudo = goutil.findChild(mainGo, "kudo")
	self._descCol._btnKudo = goutil.findChild(mainGo, "kudo/btnKudo")
	self._descCol._txtKudoCount = goutil.findChildTextComponent(mainGo, "kudo/txtKudoCount")
	self._descCol._btnChat = goutil.findChild(mainGo, "btnChat")
	self._descCol._InputField_FmtDesc = goutil.findChild(mainGo, "InputField_FmtDesc")
	self._petCol = {}

	local mainGo = goutil.findChild(self.mainGO, "petCol")

	self._petCol._mainGo = mainGo
	self._petCol._petScrollerview = goutil.findChild(mainGo, "petScrollerview")
	self._petCol._petScrollercell = goutil.findChild(mainGo, "petScrollercell")
	self._petCol._btnFilter = goutil.findChild(mainGo, "btnFilter")
	self._petCol._btnSort = goutil.findChild(mainGo, "btnSort")
	self._petCol._InputC_Search = goutil.findChild(mainGo, "InputC_Search")
	self._petCol._InputC_Search_Clear = goutil.findChild(mainGo, "InputC_Search/BtnClear")
	self._chatCol = {}

	local mainGo = goutil.findChild(self.mainGO, "chatCol")

	self._chatCol._mainGo = mainGo
	self._chatCol._chatScrollercell = goutil.findChild(mainGo, "chatScrollercell")
	self._chatCol._chatScrollerview = goutil.findChild(mainGo, "chatScrollerview")
	self._chatCol._btnSure = goutil.findChild(mainGo, "btnSure")
	self._tabScrollList = ScrollerList.create(self._tabCol._tabScrollerview, self._tabCol._tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._petScrollList = ScrollerList.create(self._petCol._petScrollerview, self._petCol._petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._chatScrollList = ScrollerList.create(self._chatCol._chatScrollerview, self._chatCol._chatScrollercell, GameUtil.handler(self._updateChatCell, self), GameUtil.handler(self._clearChatCell, self))
	self._inputSearch = self:getInput("petCol/InputC_Search")
	self._InputField_FmtName = self:getInput("fmtCol/InputField")
	self._InputField_FmtDesc = self:getInput("descCol/InputField_FmtDesc")
	self._inputFieldChatCol = self:getInput("chatCol/InputField")
	self._customInputOfChatCol = UICustomInput.Get(self._chatCol._mainGo)

	self._InputField_FmtName:SetCharacterLimit(MasterFormConfig.instance:getMfCommonValue("FORM_TITLE_SIZE_LIMIT", true))
	self._InputField_FmtDesc:SetCharacterLimit(MasterFormConfig.instance:getMfCommonValue("FORM_DESC_LIMIT", true))
	self._inputFieldChatCol:SetCharacterLimit(MasterFormConfig.instance:getMfCommonValue("COMMONT_SIZE_LIMIT", true))
end

function MasterFormFmtSubmitView:bindEvents()
	MasterFormFmtSubmitView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._descCol._btnSubmit, self._onClickBtnSubmitOfDesc, self)
	GameUtil.addClickHandler(self._descCol._btnKudo, self._onClickBtnKudoOfDesc, self)
	GameUtil.addClickHandler(self._descCol._btnChat, self._onClickBtnChatOfDesc, self)
	GameUtil.addClickHandler(self._petCol._InputC_Search, self._OnSearchTextChanged, self)
	GameUtil.addClickHandler(self._petCol._InputC_Search_Clear, self._onClearSearch, self)
	GameUtil.addClickHandler(self._petCol._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._petCol._btnSort, self._onClickSort, self)
	GameUtil.addClickHandler(self._chatCol._btnSure, self._onClickBtnSureOfChat, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._InputField_FmtName:AddOnValueChanged(self._onValueChangedFmtName, self)
	self._InputField_FmtDesc:AddOnValueChanged(self._onValueChangedFmtDesc, self)
	self._inputFieldChatCol:AddOnValueChanged(self._onValueChangedOfChat, self)
	self._customInputOfChatCol:AddListener(self._onCustomInputCallbackOfChatCol, self)
end

function MasterFormFmtSubmitView:unbindEvents()
	MasterFormFmtSubmitView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._descCol._btnSubmit)
	GameUtil.rmClickHandler(self._descCol._btnKudo)
	GameUtil.rmClickHandler(self._descCol._btnChat)
	GameUtil.rmClickHandler(self._petCol._InputC_Search)
	GameUtil.rmClickHandler(self._petCol._InputC_Search_Clear)
	GameUtil.rmClickHandler(self._petCol._btnFilter)
	GameUtil.rmClickHandler(self._petCol._btnSort)
	GameUtil.rmClickHandler(self._chatCol._btnSure)
	self._inputSearch:RemoveOnValueChanged()
	self._InputField_FmtName:RemoveOnValueChanged()
	self._InputField_FmtDesc:RemoveOnValueChanged()
	self._inputFieldChatCol:RemoveOnValueChanged()
	self._customInputOfChatCol:RemoveListener()
end

function MasterFormFmtSubmitView:onEnter()
	MasterFormFmtSubmitView.super.onEnter(self)

	self._periodId = MasterFormController.instance:getPeriodId()

	if self._periodId == 0 then
		FloatWordMgr.instance:show("不在活动时间范围内")

		return
	end

	self._masterFormMgr = MasterFormController.instance:getMasterFormMgr(self._periodId)
	self._tabCount = MasterFormConfig.instance:getMfCommonValue("MAX_SUBMIT_FMT_COUNT", true)
	self._curTabIdx = 1
	self._isHandlingOfFmtSubmit = false
	self._isHandlingOfCommnet = false
	self._emptyTempFmtMo = self._masterFormMgr:getFmtMoOfMyAsTemp(0)

	self:_onSetUI()
	self:_onUpdate()
	GlobalDispatcher:addListener(GlobalNotify.MasterFormGetMyFormRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormRevokeRes, self._handleMasterFormRevokeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormSubmitFormRes, self._handleMasterFormSubmitFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormNotifySubmitFormRes, self._handleMasterFormNotifySubmitFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormKudoCommentRes, self._handleKudoCommentRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormKudoFormRes, self._handleMasterFormKudoFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormCommentRes, self._handleCommentRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormNotifyCommnetRes, self._handleMasterFormNotifyCommnetRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormgetCommentsRes, self._handleMasterFormgetCommentsRes, self)
	MasterFormController.instance:sendPM_MasterFormGetMyFormReq(self._periodId)
end

function MasterFormFmtSubmitView:onExit()
	MasterFormFmtSubmitView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormGetMyFormRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormRevokeRes, self._handleMasterFormRevokeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormSubmitFormRes, self._handleMasterFormSubmitFormRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormNotifySubmitFormRes, self._handleMasterFormNotifySubmitFormRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormKudoCommentRes, self._handleKudoCommentRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormKudoFormRes, self._handleMasterFormKudoFormRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormCommentRes, self._handleCommentRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormNotifyCommnetRes, self._handleMasterFormNotifyCommnetRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormgetCommentsRes, self._handleMasterFormgetCommentsRes, self)
	self:_clearValueFmtName()
	self:_clearValueFmtDesc()
	self:_onClearTabCol()
	self:_onClearPetCol()
	self:_onClearFmtColUI()
	self:_onClearSearch()
	self:_onClearChatCol()
	self:_clearAllAddEff()
	self:_clearAllMarkFmtIdx()
	self:_clearValueOfChat()
end

function MasterFormFmtSubmitView:_handleMasterFormRevokeRes()
	MasterFormController.instance:sendPM_MasterFormGetMyFormReq(self._periodId)
	FloatWordMgr.instance:show("阵容下架成功")
end

function MasterFormFmtSubmitView:_handleMasterFormNotifySubmitFormRes(status, msg)
	if status == 0 then
		MasterFormController.instance:sendPM_MasterFormGetMyFormReq(self._periodId)
		FloatWordMgr.instance:show("阵容发布成功")
	end

	self._isHandlingOfFmtSubmit = false
end

function MasterFormFmtSubmitView:_handleMasterFormSubmitFormRes(status, msg)
	if status ~= 0 then
		self._isHandlingOfFmtSubmit = false
	end
end

function MasterFormFmtSubmitView:_handleKudoCommentRes(msg)
	self:_onUpdate()
end

function MasterFormFmtSubmitView:_handleMasterFormKudoFormRes()
	self:_onUpdate()
end

function MasterFormFmtSubmitView:_handleCommentRes(status, msg)
	if status == 0 then
		self:_clearValueOfChat()
	else
		self._isHandlingOfCommnet = false
	end
end

function MasterFormFmtSubmitView:_handleMasterFormNotifyCommnetRes(status, msg)
	if status == 0 then
		MasterFormController.instance:sendPM_MasterFormgetCommentsReq(msg.period, msg.formId)
	end

	self._isHandlingOfCommnet = false
end

function MasterFormFmtSubmitView:_handleMasterFormgetCommentsRes()
	self:_onUpdate()
end

function MasterFormFmtSubmitView:_onSetUI()
	return
end

function MasterFormFmtSubmitView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function MasterFormFmtSubmitView:_onUpdateData()
	self:_updateCurFmtMoTemp()
	self:_onUpdateTabColData()
end

function MasterFormFmtSubmitView:_onUpdateUI()
	local fmtState = self:_getFmtState(self._curTabIdx)
	local isCanEditable = fmtState ~= MasterFormFmtSubmitView.FmtState.UnEditable

	self._fmtCol._InputField:GetComponent("EmptyRaycast").raycastTarget = isCanEditable
	self._descCol._InputField_FmtDesc:GetComponent("EmptyRaycast").raycastTarget = isCanEditable

	self:_onUpdateTabColUI()
	self:_onUpdateFmtColUI()
	self:_onUpdatePetColUI()
	self:_onUpdateDescColUI()
	self:_onUpdateChatColUI()
end

function MasterFormFmtSubmitView:_getCurFmtMoTemp()
	return self._masterFormMgr:getFmtMoOfMyAsTemp(self._curTabIdx)
end

function MasterFormFmtSubmitView:_updateCurFmtMoTemp()
	local fmtMo = self._masterFormMgr:getFmtMoOfMy(self._curTabIdx)

	if fmtMo then
		self:_getCurFmtMoTemp():copyFmtMo(fmtMo)
	else
		self:_getCurFmtMoTemp():copyFmtMo(self._emptyTempFmtMo)
	end
end

function MasterFormFmtSubmitView:_onUpdateTabColData()
	self._tabInfoList = {}

	for tabIdx = 1, self._tabCount do
		local info = {}

		info.tabIdx = tabIdx
		info.fmtState = self:_calcFmtState(tabIdx)

		table.insert(self._tabInfoList, info)
	end
end

function MasterFormFmtSubmitView:_getFmtState(tabIdx)
	local tabInfo = self:_getTabInfo(tabIdx)

	return tabInfo and tabInfo.fmtState
end

function MasterFormFmtSubmitView:_setFmtState(tabIdx, fmtState)
	local tabInfo = self:_getTabInfo(tabIdx)

	if tabInfo then
		tabInfo.fmtState = fmtState
	end
end

function MasterFormFmtSubmitView:_calcFmtState(tabIdx)
	local isHasFmt = self._masterFormMgr:isHasFmtOfMy(tabIdx)

	if isHasFmt then
		return MasterFormFmtSubmitView.FmtState.UnEditable
	else
		return MasterFormFmtSubmitView.FmtState.Editable
	end
end

function MasterFormFmtSubmitView:_getTabInfo(tabIdx)
	return self._tabInfoList[tabIdx]
end

function MasterFormFmtSubmitView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabInfoList)
end

function MasterFormFmtSubmitView:_onClearTabCol()
	self._tabScrollList:dispose()
end

function MasterFormFmtSubmitView:_updateTabCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local tabIdx = info.tabIdx
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local isSelected = tabIdx == self._curTabIdx

	GameUtil.setUIGroupIdx(mainGo, isSelected and 1 or 0)

	local nameStr = "未发布"
	local fmtId = self._masterFormMgr:getFmtIdOfMy(tabIdx)

	if fmtId > 0 then
		local fmtMo = self._masterFormMgr:getFmtMo(MasterFormMgr.FmtType.Master, fmtId)

		if fmtMo then
			nameStr = fmtMo:getFmtName()
		end
	end

	txtName.text = nameStr

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTabCell, self, mainGo, tabIdx))
end

function MasterFormFmtSubmitView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function MasterFormFmtSubmitView:_onClickTabCell(mainGo, tabIdx)
	if self._curTabIdx == tabIdx then
		return
	end

	local tipsContent = "存在编辑中的阵容未提交，是否继续切换阵容？"

	local function okFunc()
		self:_clearValueOfChat()

		self._curTabIdx = tabIdx

		self:_onUpdate()
	end

	local function cencelFunc()
		return
	end

	if self:_getFmtState(self._curTabIdx) == MasterFormFmtSubmitView.FmtState.Editing then
		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
	else
		okFunc()
	end
end

function MasterFormFmtSubmitView:_onUpdateFmtColUI()
	local parentTran = self._fmtCol._fmtView
	local children = GameUtil.getChildren(parentTran)
	local petIdList = self:_getCurFmtMoTemp():getFmtPetIdList()

	for fmtIdx, mainGo in ipairs(children) do
		local petId = checknumber(petIdList[fmtIdx])

		self:_updateFmtCell(mainGo, fmtIdx, petId)
	end

	self:_setValueInputFieldFmtName(self:_getCurFmtMoTemp():getFmtName(), true)
end

function MasterFormFmtSubmitView:_onClearFmtColUI()
	local parentTran = self._fmtCol._fmtView
	local children = GameUtil.getChildren(parentTran)

	for fmtIdx, mainGo in ipairs(children) do
		self:_clearFmtCell(mainGo, fmtIdx)
	end
end

function MasterFormFmtSubmitView:_updateFmtCell(mainGo, fmtIdx, petId)
	local item = goutil.findChild(mainGo, "item")
	local dropdown = goutil.findChild(mainGo, "dropdown")
	local btn = goutil.findChild(mainGo, "btn")
	local raceId = self:_getCurFmtMoTemp():getPetRaceId(petId)
	local isHasPet = petId > 0
	local petMo

	if petId > 0 then
		petMo = self:_getCurFmtMoTemp():getPetMo(petId)
	end

	local fmtState = self:_getFmtState(self._curTabIdx)
	local isCanEditable = fmtState ~= MasterFormFmtSubmitView.FmtState.UnEditable

	if self._dropDowns == nil then
		self._dropDowns = {}
	end

	if not self._dropDowns[mainGo] then
		local dropdownComp = DropDownAdapter.Get(dropdown)

		dropdownComp:RemoveOnValueChanged()
		dropdownComp:ClearOptions()

		if isCanEditable then
			local stripeIdMap = {}
			local hsDataList = HolyStripeConfig.instance:getHolyStripeDataList()

			for _, data in ipairs(hsDataList) do
				if stripeIdMap[data.suitType] == nil then
					stripeIdMap[data.suitType] = data.id
				end
			end

			local stripeIdList = TableUtil.toList(stripeIdMap)
			local valueIndex = 0
			local curWearStripeId = self:_getFitHolyStripeIdByRace(raceId)

			if curWearStripeId > 0 then
				local curWearHsData = HolyStripeConfig.instance:getHolyStripeCfg(curWearStripeId)

				for i = 1, #stripeIdList do
					local hsData = HolyStripeConfig.instance:getHolyStripeCfg(stripeIdList[i])

					if hsData.suitType == curWearHsData.suitType then
						valueIndex = i

						break
					end
				end
			end

			dropdownComp:AddOnValueChanged(function(handler, value)
				if petId > 0 then
					local hsId = stripeIdList[value]

					self:_getCurFmtMoTemp():addPet(petId, raceId, hsId)
				end
			end, self)
			dropdownComp:AddOptions("选择灵纹")

			for _, holyStripeId in ipairs(stripeIdList) do
				local hsData = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeId)

				if hsData then
					dropdownComp:AddOptions(hsData.name)
				end
			end

			dropdownComp:SetValue(valueIndex)
		else
			local stripeIdList = {}

			if petId > 0 then
				table.insert(stripeIdList, self:_getCurFmtMoTemp():getPetHolyStripeId(petId))
			end

			for _, holyStripeId in ipairs(stripeIdList) do
				local hsData = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeId)

				if hsData then
					dropdownComp:AddOptions(hsData.name)
				end
			end

			dropdownComp:SetValue(0)
		end

		if self:_isNewFmtIdx(fmtIdx) then
			self:_markFmtIdxAsNew(fmtIdx, false)
			self:_showAddEff(mainGo)
		else
			self:_clearAddEff(mainGo)
		end

		MaterialMgr.resetAll(item)

		if petMo then
			local proxy = MaterialMgr.setCell(MatType.Pet, petMo.curFaceId, item)

			proxy.binder:setAutoTips(false)
		end

		local function handler()
			if isHasPet then
				local fmtState = self:_getFmtState(self._curTabIdx)

				if fmtState == MasterFormFmtSubmitView.FmtState.UnEditable then
					return
				end

				self:_setFmtState(self._curTabIdx, MasterFormFmtSubmitView.FmtState.Editing)
				self:_getCurFmtMoTemp():rmPet(petId)
				self:_onUpdateFmtColUI()
				self:_onUpdatePetColUI()
			end
		end

		GameUtil.addClickHandler(btn, handler)
	end
end

function MasterFormFmtSubmitView:_clearFmtCell(mainGo, fmtIdx)
	local item = goutil.findChild(mainGo, "item")
	local dropdown = goutil.findChild(mainGo, "dropdown")
	local btn = goutil.findChild(mainGo, "btn")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btn)

	if self._dropDowns then
		if self._dropDowns then
			self._dropDowns:RemoveOnValueChanged()
			self._dropDowns:ClearOptions()
		end
	end
end

function MasterFormFmtSubmitView:_markFmtIdxAsNew(fmtIdx, isToAdd)
	if self._fmtIdxAsNew == nil then
		self._fmtIdxAsNew = {}
	end

	if isToAdd then
		if table.indexof(self._fmtIdxAsNew, fmtIdx) == false then
			table.insert(self._fmtIdxAsNew, fmtIdx)
		end
	else
		table.removebyvalue(self._fmtIdxAsNew, fmtIdx)
	end
end

function MasterFormFmtSubmitView:_clearAllMarkFmtIdx()
	if self._fmtIdxAsNew then
		table.clear(self._fmtIdxAsNew)

		self._fmtIdxAsNew = nil
	end
end

function MasterFormFmtSubmitView:_isNewFmtIdx(fmtIdx)
	if self._fmtIdxAsNew then
		return table.indexof(self._fmtIdxAsNew, fmtIdx) ~= false
	end

	return false
end

function MasterFormFmtSubmitView:_isSelectedPet(raceId)
	return self:_getCurFmtMoTemp():isHasPetOfRaceId(raceId)
end

function MasterFormFmtSubmitView:_isFullOfFmtPet()
	local maxCount = MasterFormConfig.instance:getMfCommonValue("MAX_SUBMIT_PET_COUNT", true)

	return maxCount <= #self:_getCurFmtMoTemp():getFmtPetIdList()
end

function MasterFormFmtSubmitView:_getHolyStripeIdList(petId)
	local holyStripeIdList = {}
	local hsMoList = HolyStripeModel.instance:getEquippedByPetId(petId)

	for _, hsMo in ipairs(hsMoList) do
		table.insert(holyStripeIdList, hsMo:getDefineId())
	end

	return holyStripeIdList
end

function MasterFormFmtSubmitView:_getFitHolyStripeIdByRace(raceId)
	local hsIdList = {}

	if self._bagPetMoList and raceId > 0 then
		local maxPetMo

		for _, petMo in ipairs(self._bagPetMoList) do
			if petMo:getDefineId() == raceId then
				local hsIdListTemp = self:_getHolyStripeIdList(petMo:getPetId())

				if #hsIdListTemp > 0 then
					if maxPetMo == nil then
						maxPetMo = petMo
					end

					if petMo._zdl > maxPetMo._zdl then
						maxPetMo = petMo
						hsIdList = hsIdListTemp
					elseif petMo._zdl == maxPetMo._zdl and #hsIdListTemp > #hsIdList then
						maxPetMo = petMo
						hsIdList = hsIdListTemp
					end
				end
			end
		end
	end

	return checknumber(hsIdList[1])
end

function MasterFormFmtSubmitView:_showAddEff(mainGo)
	local effGo = mainGo
	local path = "fx_ui_zhuangbeijiemian/fx_ui_fangru_zhuangbei"

	self:_clearAddEff(mainGo)

	if effGo and not string.nilorempty(path) then
		local pathName = path .. ".prefab"

		local function func(_, eff)
			eff:setParent(effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		if self._addEffList == nil then
			self._addEffList = {}
		end

		self._addEffList[effGo] = UIEffectManager.instance:playEffect(self, pathName, effGo, 0, 0, false, false, nil, func, nil)
	end
end

function MasterFormFmtSubmitView:_clearAllAddEff()
	if self._addEffList then
		for mainGo, eff in pairs(self._addEffList) do
			self:_clearAddEff(mainGo)
		end
	end
end

function MasterFormFmtSubmitView:_clearAddEff(mainGo)
	if self._addEffList then
		UIEffectManager.instance:stopEffect(self._addEffList[mainGo])
	end
end

function MasterFormFmtSubmitView:_setValueInputFieldFmtName(str, isNotEditing)
	self._isNotEditingOfFmtName = isNotEditing

	self._InputField_FmtName:SetText(str)
end

function MasterFormFmtSubmitView:_clearValueFmtName()
	self:_setValueInputFieldFmtName("", true)
end

function MasterFormFmtSubmitView:_onValueChangedFmtName(str)
	if self._isNotEditingOfFmtName then
		self._isNotEditingOfFmtName = false
	else
		self:_setFmtState(self._curTabIdx, MasterFormFmtSubmitView.FmtState.Editing)
	end

	self:_getCurFmtMoTemp():setFmtName(str)
end

function MasterFormFmtSubmitView:_setValueInputFieldFmtDesc(str, isNotEditing)
	self._isNotEditingOfFmtDesc = isNotEditing

	self._InputField_FmtDesc:SetText(str)
end

function MasterFormFmtSubmitView:_clearValueFmtDesc()
	self:_setValueInputFieldFmtDesc("", true)
end

function MasterFormFmtSubmitView:_onValueChangedFmtDesc(str)
	if self._isNotEditingOfFmtDesc then
		self._isNotEditingOfFmtDesc = false
	else
		self:_setFmtState(self._curTabIdx, MasterFormFmtSubmitView.FmtState.Editing)
	end

	self:_getCurFmtMoTemp():setFmtDesc(str)
end

function MasterFormFmtSubmitView:_onUpdateDescColUI()
	local fmtMo = self:_getCurFmtMoTemp()
	local isHasFmt = self._masterFormMgr:isHasFmtOfMy(self._curTabIdx)
	local count = self._masterFormMgr:getLeftGainPrizeCount(self._periodId)

	self._descCol._txtTimes.text = string.format("奖励次数：%s", count)
	self._descCol._txtKudoCount.text = Mathf.Min(self:_getCurFmtMoTemp():getFmtKudos(), 999)

	GameUtil.setUIGroupIdx(self._descCol._btnKudo, fmtMo:isKudos() and 1 or 0)
	GameUtil.SetActive(self._descCol._kudo, isHasFmt)
	GameUtil.SetActive(self._descCol._btnChat, isHasFmt)

	if isHasFmt then
		self._descCol._txtBtnSubmit.text = "下架阵容"
	end

	local var_55_0

	do
		self._descCol._txtBtnSubmit.text = "发布阵容"
		var_55_0 = self:_getCurFmtMoTemp()
	end

	self:_setValueInputFieldFmtDesc(var_55_0:getFmtDesc(), true)
end

function MasterFormFmtSubmitView:_onClickBtnSubmitOfDesc()
	local isHasFmt = self._masterFormMgr:isHasFmtOfMy(self._curTabIdx)

	if isHasFmt then
		local fmtMo = self._masterFormMgr:getFmtMoOfMy(self._curTabIdx)

		MasterFormController.instance:sendPM_MasterFormRevokeReq(self._periodId, fmtMo:getFmtId())
	else
		if self._isHandlingOfFmtSubmit then
			FloatWordMgr.instance:show("阵容提交正在处理中")

			return
		end

		local fmtMo = self:_getCurFmtMoTemp()
		local result, tips = self._masterFormMgr:getSubmitFmtResultAndTips(fmtMo)

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		self._isHandlingOfFmtSubmit = true

		MasterFormController.instance:sendPM_MasterFormSubmitFormReq(self._periodId, fmtMo:createFormMsg())
	end
end

function MasterFormFmtSubmitView:_onClickBtnKudoOfDesc()
	local fmtMo = self:_getCurFmtMoTemp()
	local fmtType, fmtId = fmtMo:getFmtType(), fmtMo:getFmtId()
	local result, tips = self._masterFormMgr:getTryKudoFmtResultAndTips(fmtType, fmtId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	MasterFormController.instance:sendPM_MasterFormKudoFormReq(self._periodId, fmtId)
end

function MasterFormFmtSubmitView:_onClickBtnChatOfDesc()
	local isShowing = self:_isChatColShowing()

	self:_setChatColVisual(not isShowing)

	if not isShowing then
		local fmtMo = self:_getCurFmtMoTemp()

		if fmtMo then
			MasterFormController.instance:sendPM_MasterFormgetCommentsReq(self._periodId, fmtMo:getFmtId())
		end
	else
		self:_onUpdateChatColUI()
	end
end

function MasterFormFmtSubmitView:_onUpdatePetColUI()
	self:_updateBagPetList()
	self:_updatePetScrollview()
end

function MasterFormFmtSubmitView:_onClearPetCol()
	self._petScrollList:dispose()
end

function MasterFormFmtSubmitView:_updatePetCell(view, cell, petMo, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local imgReduce = goutil.findChild(mainGo, "imgReduce")
	local petId = petMo:getPetId()
	local raceId = petMo:getDefineId()
	local rare = petMo:getRare()
	local isSelected = self:_isSelectedPet(raceId)
	local minRareLimit = MasterFormConfig.instance:getMfCommonValue("RARE_COND_LIMIT_MIN", true)
	local isFitRare = minRareLimit <= rare

	GameUtil.SetActive(imgReduce, isSelected)

	local proxy = MaterialMgr.setCell(MatType.Pet, petMo.curFaceId, item)

	proxy.binder:setAutoTips(false)
	proxy.binder:setSelected(isSelected)
	proxy.binder:setGray(not isFitRare)

	local function handler()
		local fmtState = self:_getFmtState(self._curTabIdx)

		if fmtState == MasterFormFmtSubmitView.FmtState.UnEditable then
			return
		end

		if not isFitRare then
			return
		end

		self:_setFmtState(self._curTabIdx, MasterFormFmtSubmitView.FmtState.Editing)

		local isPetSelected = self:_isSelectedPet(raceId)

		if isPetSelected then
			self:_getCurFmtMoTemp():rmPet(raceId)
		elseif not self:_isFullOfFmtPet() then
			local holyStripeIdList = self:_getHolyStripeIdList(petId)

			self:_getCurFmtMoTemp():addPet(raceId, raceId, 0)

			local fmtIdx = #self:_getCurFmtMoTemp():getFmtPetIdList()

			self:_markFmtIdxAsNew(fmtIdx, true)
		end

		self:_updatePetScrollview()
		self:_onUpdateFmtColUI()
	end

	GameUtil.addClickHandler(btnSelect, handler)
end

function MasterFormFmtSubmitView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local imgReduce = goutil.findChild(mainGo, "imgReduce")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnSelect)
end

function MasterFormFmtSubmitView:_updatePetScrollview()
	self._petScrollList:reloadData(self._bagPetMoList or {})
end

function MasterFormFmtSubmitView:_updateBagPetList()
	self._bagPetMoList = {}

	if not BagPetsController.instance:getReady() then
		return
	end

	local allPets = BagPetsController.instance:getBagPets()

	for k, v in pairs(allPets) do
		if self:onFilter(v) then
			self._bagPetMoList[#self._bagPetMoList + 1] = v
		end
	end

	self:sortBagPetMoList()
end

function MasterFormFmtSubmitView:onRefreshPetSort(idx, onResetCallback)
	BagModel.instance:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, BagModel.instance:GetSortState())
	self:sortBagPetMoList()
	self:_updatePetScrollview()
end

function MasterFormFmtSubmitView:sortBagPetMoList()
	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and limit <= #self._bagPetMoList then
		-- block empty
	else
		local names, opt = BagModel.instance:GetSortParms()

		ArraySort.sortOn(self._bagPetMoList, names, opt)
	end

	table.sort(self._bagPetMoList, function(a, b)
		if a:getRare() == b:getRare() then
			return false
		end

		return a:getRare() > b:getRare()
	end)
end

function MasterFormFmtSubmitView:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
	local isHit = false

	isHit = self:_isMatch(petCo, pet.rare, pet.curFaceId)

	if not string.nilorempty(self._currSearching) then
		local str = StringUtil.RelpaceEscapeChar(self._currSearching)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function MasterFormFmtSubmitView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, cfg, rare, skinId)
end

function MasterFormFmtSubmitView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._petCol._btnFilter)

	local function func()
		self:_onUpdatePetColUI()
	end

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, func)
end

function MasterFormFmtSubmitView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._petCol._btnSort)
	local arr = BagModel.instance:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self.onRefreshPetSort, self))
end

function MasterFormFmtSubmitView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function MasterFormFmtSubmitView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_onUpdatePetColUI()
	end
end

function MasterFormFmtSubmitView:_onClearSearch()
	self._inputSearch.input.text = ""
end

function MasterFormFmtSubmitView:_onUpdateChatColUI()
	self:_setChatColVisual(self:_isChatColShowing())

	if not self:_isChatColShowing() then
		return
	end

	self:_setChatColVisual(true)

	local fmtMo = self:_getCurFmtMoTemp()
	local comments = self._masterFormMgr:getComments(fmtMo:getFmtId())

	self._chatScrollList:reloadData(comments)
end

function MasterFormFmtSubmitView:_onClearChatCol()
	self._chatScrollList:dispose()
end

function MasterFormFmtSubmitView:_updateChatCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local fmtMo = self:_getCurFmtMoTemp()
	local fmtId = fmtMo:getFmtId()
	local isHasKudos = data.isKudos
	local btnKudo = goutil.findChild(mainGo, "btnKudo")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txtBtnKudo = goutil.findChildTextComponent(mainGo, "txtKudoCount")

	txtDesc.text = string.format("<color=#3bc28a>%s：</color>%s", data.headInfo.userName, data.content)
	txtBtnKudo.text = Mathf.Min(data.kudos, 999)

	GameUtil.setUIGroupIdx(btnKudo, isHasKudos and 1 or 0)

	local function handle()
		if self._isHandlingOfCommnet then
			FloatWordMgr.instance:show("评论正在处理中")

			return
		end

		local result, tips = self._masterFormMgr:getTryKudoCommentResultAndTips(fmtId, data.commentId)

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		self._isHandlingOfCommnet = true

		MasterFormController.instance:sendPM_MasterFormKudoCommentReq(self._periodId, fmtId, data.commentId)
	end

	GameUtil.addClickHandler(btnKudo, handle, self)
end

function MasterFormFmtSubmitView:_clearChatCell(cell)
	local mainGo = cell.gameObject
	local btnKudo = goutil.findChild(mainGo, "btnKudo")

	GameUtil.rmClickHandler(btnKudo)
end

function MasterFormFmtSubmitView:_onClickBtnSureOfChat()
	local str = self._inputFieldChatCol:GetText()
	local result, tips = self._masterFormMgr:getSubmitCommentResultAndTips(str)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local fmtMo = self:_getCurFmtMoTemp()

	if fmtMo then
		MasterFormController.instance:sendPM_MasterFormCommentReq(self._periodId, fmtMo:getFmtId(), str)
	end
end

function MasterFormFmtSubmitView:_onValueChangedOfChat(str)
	return
end

function MasterFormFmtSubmitView:_clearValueOfChat()
	self._inputFieldChatCol:SetText("")
end

function MasterFormFmtSubmitView:_onCustomInputCallbackOfChatCol(hover)
	if not hover then
		self:_setChatColVisual(false)
	end
end

function MasterFormFmtSubmitView:_setChatColVisual(isToShow)
	self._isChatColInShow = isToShow

	GameUtil.SetActive(self._chatCol._mainGo, isToShow)
	GameUtil.SetActive(self._petCol._mainGo, not isToShow)
end

function MasterFormFmtSubmitView:_isChatColShowing()
	return checkbool(self._isChatColInShow)
end

return MasterFormFmtSubmitView
