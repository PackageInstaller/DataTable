-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/MasterFormSystemView.lua

module("logic.extensions.masterform.view.MasterFormSystemView", package.seeall)

local MasterFormSystemView = class("MasterFormSystemView", ViewComponent)

MasterFormSystemView.ViewType = {
	System = 1,
	Master = 2,
	Collect = 3
}

function MasterFormSystemView:buildUI()
	MasterFormSystemView.super.buildUI(self)

	self._tabCol = {}

	local mainGo = goutil.findChild(self.mainGO, "tabCol")

	self._tabCol._mainGo = mainGo
	self._tabCol._tabScrollercell = goutil.findChild(mainGo, "tabScrollercell")
	self._tabCol._tabScrollerview = goutil.findChild(mainGo, "tabScrollerview")
	self._tabCol._funcCol = {}
	self._tabCol._funcCol._mainGo = goutil.findChild(mainGo, "funcCol")
	self._tabCol._funcCol._btnRefresh = goutil.findChild(mainGo, "funcCol/btnRefresh")
	self._tabCol._funcCol._btnSifter = goutil.findChild(mainGo, "funcCol/btnSifter")
	self._tabCol._funcCol._InputField = goutil.findChild(mainGo, "funcCol/InputField")
	self._tabCol._funcCol._sifterCol = {}
	self._tabCol._funcCol._sifterCol._mainGo = goutil.findChild(mainGo, "funcCol/sifterCol")
	self._tabCol._funcCol._sifterCol._typeCol = goutil.findChild(mainGo, "funcCol/sifterCol/typeCol")
	self._topCol = {}

	local mainGo = goutil.findChild(self.mainGO, "contentCol/topCol")

	self._topCol._mainGo = mainGo
	self._topCol._txtFmtName = goutil.findChildTextComponent(mainGo, "txtFmtName")
	self._topCol._btnCollect = goutil.findChild(mainGo, "btnCollect")
	self._topCol._btnShare = goutil.findChild(mainGo, "btnShare")
	self._topCol._raceTagView = goutil.findChild(mainGo, "raceTagView")
	self._petCol = {}

	local mainGo = goutil.findChild(self.mainGO, "contentCol/petCol")

	self._petCol._mainGo = mainGo
	self._petCol._petView = goutil.findChild(mainGo, "petView")
	self._petCol._emptyGo = goutil.findChild(mainGo, "emptyGo")
	self._petCol._txtEmptyGo = goutil.findChildTextComponent(mainGo, "emptyGo/txt")
	self._petCol._bottomCol = {}
	self._petCol._bottomCol._mainGo = goutil.findChild(mainGo, "bottomCol")
	self._petCol._bottomCol._scrView = goutil.findChild(mainGo, "bottomCol/fmtDesc")
	self._petCol._bottomCol._txtFmtDesc = goutil.findChildTextComponent(mainGo, "bottomCol/fmtDesc/Viewport/Content")
	self._petCol._bottomCol._btnChat = goutil.findChild(mainGo, "bottomCol/btnChat")
	self._petCol._bottomCol._btnKudo = goutil.findChild(mainGo, "bottomCol/btnKudo")
	self._petCol._bottomCol._txtBtnKudo = goutil.findChildTextComponent(mainGo, "bottomCol/btnKudo/txtCount")
	self._chatCol = {}

	local mainGo = goutil.findChild(self.mainGO, "contentCol/chatCol")

	self._chatCol._mainGo = mainGo
	self._chatCol._petView = goutil.findChild(mainGo, "petView")
	self._chatCol._chatScrollercell = goutil.findChild(mainGo, "chatScrollercell")
	self._chatCol._chatScrollerview = goutil.findChild(mainGo, "chatScrollerview")
	self._chatCol._bottomCol = {}
	self._chatCol._bottomCol._mainGo = goutil.findChild(mainGo, "bottomCol")
	self._chatCol._bottomCol._txtFmtDesc = goutil.findChildTextComponent(mainGo, "bottomCol/txtFmtDesc")
	self._chatCol._bottomCol._btnChat = goutil.findChild(mainGo, "bottomCol/btnChat")
	self._chatCol._bottomCol._btnKudo = goutil.findChild(mainGo, "bottomCol/btnKudo")
	self._chatCol._bottomCol._btnSure = goutil.findChild(mainGo, "bottomCol/btnSure")
	self._chatCol._bottomCol._txtBtnKudo = goutil.findChildTextComponent(mainGo, "bottomCol/btnKudo/txtCount")
	self._funcCol = {}

	local mainGo = goutil.findChild(self.mainGO, "contentCol/funcCol")

	self._funcCol._mainGo = mainGo
	self._funcCol._btnSubmit = goutil.findChild(mainGo, "btnSubmit")
	self._funcCol._btnSure = goutil.findChild(mainGo, "btnSure")
	self._funcCol._posBtnSure = goutil.findChild(mainGo, "btnSure/pos")
	self._tabScrollList = ScrollerList.create(self._tabCol._tabScrollerview, self._tabCol._tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._chatScrollList = ScrollerList.create(self._chatCol._chatScrollerview, self._chatCol._chatScrollercell, GameUtil.handler(self._updateChatCell, self), GameUtil.handler(self._clearChatCell, self))

	self._chatScrollList:regGetCellSize(GameUtil.handler(self._cellSizeOfChat, self))

	self._customInputOfSifterCol = UICustomInput.Get(self._tabCol._funcCol._sifterCol._mainGo)
	self._customInputOfChatCol = UICustomInput.Get(self._chatCol._mainGo)
	self._InputFieldAdapter = self:getInput("tabCol/funcCol/InputField")
	self._inputFieldChatCol = self:getInput("contentCol/chatCol/bottomCol/InputField")
end

function MasterFormSystemView:bindEvents()
	MasterFormSystemView.super.bindEvents(self)
	GameUtil.addClickHandler(self._tabCol._funcCol._btnRefresh, self._onClickBtnRefresh, self)
	GameUtil.addClickHandler(self._tabCol._funcCol._btnSifter, self._onClickBtnSifter, self)
	GameUtil.addClickHandler(self._topCol._btnCollect, self._onClickBtnCollect, self)
	GameUtil.addClickHandler(self._topCol._btnShare, self._onClickBtnShare, self)
	GameUtil.addClickHandler(self._chatCol._bottomCol._btnSure, self._onClickBtnSureOfChat, self)
	GameUtil.addClickHandler(self._chatCol._bottomCol._btnChat, self._onClickBtnChat, self)
	GameUtil.addClickHandler(self._chatCol._bottomCol._btnKudo, self._onClickBtnKudo, self)
	GameUtil.addClickHandler(self._funcCol._btnSubmit, self._onClickBtnSubmitOfFunc, self)
	GameUtil.addClickHandler(self._funcCol._btnSure, self._onClickBtnSureOfFunc, self)
	GameUtil.addClickHandler(self._petCol._bottomCol._btnChat, self._onClickBtnChat, self)
	GameUtil.addClickHandler(self._petCol._bottomCol._btnKudo, self._onClickBtnKudo, self)
	self._customInputOfSifterCol:AddListener(self._onCustomInputCallback, self)
	self._customInputOfChatCol:AddListener(self._onCustomInputCallbackOfChatCol, self)
	self._InputFieldAdapter:AddOnValueChanged(self._onValueChanged, self)
	self._inputFieldChatCol:AddOnValueChanged(self._onValueChangedOfChat, self)
	self._InputFieldAdapter:SetCharacterLimit(10)
	self._inputFieldChatCol:SetCharacterLimit(MasterFormConfig.instance:getMfCommonValue("COMMONT_SIZE_LIMIT", true))
end

function MasterFormSystemView:unbindEvents()
	MasterFormSystemView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._tabCol._funcCol._btnRefresh)
	GameUtil.rmClickHandler(self._tabCol._funcCol._btnSifter)
	GameUtil.rmClickHandler(self._topCol._btnCollect)
	GameUtil.rmClickHandler(self._topCol._btnShare)
	GameUtil.rmClickHandler(self._chatCol._bottomCol._btnSure)
	GameUtil.rmClickHandler(self._chatCol._bottomCol._btnChat)
	GameUtil.rmClickHandler(self._chatCol._bottomCol._btnKudo)
	GameUtil.rmClickHandler(self._funcCol._btnSubmit)
	GameUtil.rmClickHandler(self._funcCol._btnSure)
	GameUtil.rmClickHandler(self._petCol._bottomCol._btnChat)
	GameUtil.rmClickHandler(self._petCol._bottomCol._btnKudo)
	self._customInputOfSifterCol:RemoveListener()
	self._customInputOfChatCol:RemoveListener()
	self._InputFieldAdapter:RemoveOnValueChanged()
	self._inputFieldChatCol:RemoveOnValueChanged()
end

function MasterFormSystemView:onEnter()
	MasterFormSystemView.super.onEnter(self)

	self._periodId = MasterFormController.instance:getPeriodId()

	if self._periodId == 0 then
		FloatWordMgr.instance:show("不在活动时间范围内")

		return
	end

	local params = self:getOpenParam() or {}

	self._viewType = checknumber(params[1])
	self._fmtPlanId = checknumber(params[2])

	if self._viewType == MasterFormSystemView.ViewType.System and self._fmtPlanId == 0 then
		FloatWordMgr.instance:show("阵容方案Id未定义")

		return
	end

	self._curTabIdx = 0
	self._masterFormMgr = MasterFormController.instance:getMasterFormMgr(self._periodId)
	self._isChatColInShow = false
	self._isHandlingOfCommnet = false

	self:_onInitSifterColData()
	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.MasterFormViewFormRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormGetMyFormRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormGetCollectionFormRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormgetCommentsRes, self._handleMasterFormgetCommentsRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormKudoFormRes, self._handleMasterFormKudoFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormRevokeRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormCollectRes, self._onUpdateTopColUI, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormCancelCollectRes, self._onUpdateTopColUI, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormGetBaseInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormKudoCommentRes, self._handleKudoCommentRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormCommentRes, self._handleCommentRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormNotifyCommnetRes, self._handleMasterFormNotifyCommnetRes, self)
	GlobalDispatcher:addListener(GlobalNotify.MasterFormNotifySubmitFormRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationTabModify, self._formationTabModify, self)

	if self._viewType == MasterFormSystemView.ViewType.System then
		self:_onUpdate()
	elseif self._viewType == MasterFormSystemView.ViewType.Master then
		MasterFormController.instance:sendPM_MasterFormViewFormReq(self._periodId, self._fmtPlanId)
	elseif self._viewType == MasterFormSystemView.ViewType.Collect then
		MasterFormController.instance:sendPM_MasterFormGetCollectionFormReq(self._periodId)
	end

	MasterFormController.instance:sendPM_MasterFormGetBaseInfoReq(self._periodId)
end

function MasterFormSystemView:onExit()
	MasterFormSystemView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormViewFormRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormGetMyFormRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormGetCollectionFormRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormgetCommentsRes, self._handleMasterFormgetCommentsRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormKudoFormRes, self._handleMasterFormKudoFormRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormRevokeRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormCollectRes, self._onUpdateTopColUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormCancelCollectRes, self._onUpdateTopColUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormGetBaseInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormKudoCommentRes, self._handleKudoCommentRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormCommentRes, self._handleCommentRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormNotifyCommnetRes, self._handleMasterFormNotifyCommnetRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.MasterFormNotifySubmitFormRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationTabModify, self._formationTabModify, self)
	self:_onClearTopColUI()
	self:_onClearTabCol()
	self:_onClearPetCol()
	self:_onClearChatCol()
	self:_onClearSifterColUI()
	self:_setInputField("")
	self._inputFieldChatCol:SetText("")
end

function MasterFormSystemView:_handleMasterFormgetCommentsRes()
	self:_onUpdateChatColUI()
end

function MasterFormSystemView:_formationTabModify()
	FloatWordMgr.instance:show("预设阵使用成功")
end

function MasterFormSystemView:_handleCommentRes(status, msg)
	if status == 0 then
		self._inputFieldChatCol:SetText("")
	else
		self._isHandlingOfCommnet = false
	end
end

function MasterFormSystemView:_handleMasterFormNotifyCommnetRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show(string.format("评论发表成功，今日剩余：%s", self._masterFormMgr:getLeftDaliyCommentTimes()))
		MasterFormController.instance:sendPM_MasterFormgetCommentsReq(msg.period, msg.formId)
	end

	self._isHandlingOfCommnet = false
end

function MasterFormSystemView:_handleMasterFormKudoFormRes()
	FloatWordMgr.instance:show(string.format("点赞成功，今日剩余：%s", self._masterFormMgr:getLeftDaliyKudoTimes()))
	self:_onUpdatePetColUI()
	self:_onUpdateChatColUI()
end

function MasterFormSystemView:_handleKudoCommentRes(msg)
	FloatWordMgr.instance:show(string.format("点赞成功，今日剩余：%s", self._masterFormMgr:getLeftDaliyKudoTimes()))
	self:_onUpdateChatColUI()
end

function MasterFormSystemView:_onSetUI()
	return
end

function MasterFormSystemView:_onUpdate()
	self:_onUpdateFmtInfoData()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function MasterFormSystemView:_onUpdateData()
	self:_onUpdateTabInfoData()
end

function MasterFormSystemView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTabColUI()
	self:_onUpdatePetColUI()
	self:_onUpdateChatColUI()
	self:_onUpdateTopColUI()
	self:_onUpdateSifterColUI()
end

function MasterFormSystemView:_onUpdateFmtInfoData()
	self._fmtMoListOfData = {}

	if self._viewType == MasterFormSystemView.ViewType.System then
		local fmtMoList = self._masterFormMgr:getFmtMoList(MasterFormMgr.FmtType.System)

		for _, fmtMo in ipairs(fmtMoList) do
			if fmtMo:getFmtPlanId() == self._fmtPlanId then
				table.insert(self._fmtMoListOfData, fmtMo)
			end
		end
	elseif self._viewType == MasterFormSystemView.ViewType.Master then
		local fmtMoList = self._masterFormMgr:getFmtMoList(MasterFormMgr.FmtType.Master)

		for _, fmtMo in ipairs(fmtMoList) do
			if fmtMo:getFmtPlanId() == self._fmtPlanId then
				table.insert(self._fmtMoListOfData, fmtMo)
			end
		end
	elseif self._viewType == MasterFormSystemView.ViewType.Collect then
		for _, fmtType in pairs(MasterFormMgr.FmtType) do
			local fmtIdList = self._masterFormMgr:getFmtIdListAsCollectByType(fmtType)

			for _, fmtId in ipairs(fmtIdList) do
				local fmtMo = self._masterFormMgr:getFmtMo(fmtType, fmtId)

				if fmtMo then
					table.insert(self._fmtMoListOfData, fmtMo)
				end
			end
		end
	end
end

function MasterFormSystemView:_onUpdateTabInfoData()
	local moList = {}
	local fmtEleTypeConds = self._condMap[self._condDataList[1].sifterKey]
	local fmtJobTypeConds = self._condMap[self._condDataList[2].sifterKey]
	local fmtTagTypeConds = self._condMap[self._condDataList[3].sifterKey]
	local searchStr = StringUtil.RelpaceEscapeChar(self._curSearchStr or "")

	for _, fmtMo in ipairs(self._fmtMoListOfData) do
		local isFitJobType = false
		local isFitAttrType = false
		local isFitTagType = false
		local isFitSearch = false

		if #fmtEleTypeConds == 0 then
			isFitAttrType = true
		else
			local attrs = fmtMo:getFmtPetEleAttrs()

			for _, cond in ipairs(fmtEleTypeConds) do
				if table.indexof(attrs, cond) then
					isFitAttrType = true

					break
				end
			end
		end

		if #fmtJobTypeConds == 0 then
			isFitJobType = true
		else
			local jobKeyList = fmtMo:getFmtPetJobKeyList()

			for _, cond in ipairs(fmtJobTypeConds) do
				if table.indexof(jobKeyList, cond) ~= false then
					isFitJobType = true
				end
			end
		end

		if #fmtTagTypeConds == 0 then
			isFitTagType = true
		else
			local tagIdList = fmtMo:getFmtTagIds()

			for _, cond in ipairs(fmtTagTypeConds) do
				if table.indexof(tagIdList, cond) ~= false then
					isFitTagType = true
				end
			end
		end

		if string.nilorempty(searchStr) then
			isFitSearch = true
		else
			for _, petId in ipairs(fmtMo:getFmtPetIdList()) do
				if string.find(fmtMo:getPetName(petId), searchStr) then
					isFitSearch = true

					break
				end
			end
		end

		if isFitJobType and isFitAttrType and isFitTagType and isFitSearch then
			table.insert(moList, fmtMo)
		end
	end

	if self._viewType == MasterFormSystemView.ViewType.System then
		local count = MasterFormConfig.instance:getMfCommonValue("MAX_SYSTEM_FMT_SHOW_COUNT", true)

		moList = self:_getRadomList(moList, count)

		local id1, id2 = 0, 0
		local index1, index2 = 0, 0

		table.sort(moList, function(a, b)
			id1, id2 = a:getFmtId(), b:getFmtId()

			local data1 = MasterFormConfig.instance:getMfSysFmtDataById(id1)
			local data2 = MasterFormConfig.instance:getMfSysFmtDataById(id2)

			if data1 then
				index1 = data1.index or 0
			end

			if data2 then
				index2 = data2.index or 0
			end

			if index1 == index2 then
				if a:getFmtType() < b:getFmtType() then
					return true
				end

				return false
			end

			return index1 < index2
		end)
	elseif self._viewType == MasterFormSystemView.ViewType.Master then
		local id1, id2 = 0, 0

		table.sort(moList, function(a, b)
			id1, id2 = a:getFmtId(), b:getFmtId()

			if id1 == id2 then
				if a:getFmtType() < b:getFmtType() then
					return true
				end

				return false
			end

			return id1 < id2
		end)
	elseif self._viewType == MasterFormSystemView.ViewType.Collect then
		local id1, id2 = 0, 0

		table.sort(moList, function(a, b)
			id1, id2 = a:getFmtId(), b:getFmtId()

			if id1 == id2 then
				if a:getFmtType() < b:getFmtType() then
					return true
				end

				return false
			end

			return id1 < id2
		end)
	end

	local tabIdx = 0
	local infoList = {}

	for _, fmtMo in ipairs(moList) do
		tabIdx = tabIdx + 1

		local info = {}

		info.tabIdx = tabIdx
		info.fmtMo = fmtMo

		table.insert(infoList, info)
	end

	self._tabInfoList = infoList
	self._curTabIdx = Mathf.Clamp(self._curTabIdx or 1, 1, #infoList)
end

function MasterFormSystemView:_getTabInfo(tabIdx)
	return self._tabInfoList[tabIdx]
end

function MasterFormSystemView:_getRadomList(list, count)
	local array = {}

	for i, v in ipairs(list) do
		table.insert(array, v)
	end

	GameUtil.permuteArray(array)

	local resList = {}

	for i = 1, count do
		if array[i] then
			table.insert(resList, array[i])
		end
	end

	return resList
end

function MasterFormSystemView:_onInitSifterColData()
	self._condDataList = {}
	self._condDataList[1] = {
		sifterName = "属性",
		sifterKey = "fmtEleTypeConds",
		iconType = "Ele",
		tabNames = {
			"草",
			"水",
			"火",
			"光",
			"暗",
			"空",
			"创"
		},
		sifterConds = {
			"草",
			"水",
			"火",
			"光",
			"暗",
			"空",
			"创"
		},
		iconStateKeys = {
			"草",
			"水",
			"火",
			"光",
			"暗",
			"空",
			"创"
		}
	}
	self._condDataList[2] = {
		sifterName = "职业",
		sifterKey = "fmtJobTypeConds",
		iconType = "Job",
		tabNames = {},
		sifterConds = {},
		iconStateKeys = {}
	}

	local list = {}

	for _, v in pairs(GameEnum.JobZhDefine) do
		if v ~= GameEnum.JobZhDefine.Mowangkexing and v ~= GameEnum.JobZhDefine.Yuanguchong and v ~= GameEnum.JobZhDefine.Yuanshou and v ~= GameEnum.JobZhDefine.Mowang then
			table.insert(list, v)
		end
	end

	table.sort(list, function(a, b)
		return GameEnum.JobZh[a] < GameEnum.JobZh[b]
	end)

	for _, v in ipairs(list) do
		table.insert(self._condDataList[2].tabNames, v)
		table.insert(self._condDataList[2].sifterConds, v)
		table.insert(self._condDataList[2].iconStateKeys, v)
	end

	self._condDataList[3] = {
		sifterName = "角标",
		sifterKey = "fmtTagTypeConds",
		iconType = "tag",
		tabNames = {},
		sifterConds = {},
		iconStateKeys = {}
	}

	local mfTagCfg = MasterFormConfig.instance:getMfTagCfg()

	if mfTagCfg then
		for _, data in ipairs(mfTagCfg) do
			table.insert(self._condDataList[3].tabNames, data.desc)
			table.insert(self._condDataList[3].sifterConds, data.tagId)
		end
	end

	self._condMap = {}

	for _, condData in ipairs(self._condDataList) do
		self._condMap[condData.sifterKey] = {}
	end
end

function MasterFormSystemView:_setSifterCond(sifterKey, value, isAdd)
	local isHaveAdd = self:_isSifterCondHaveAdd(sifterKey, value)

	if isAdd then
		if isHaveAdd then
			printError("对应值已添加，不要重复添加")

			return
		end

		table.insert(self._condMap[sifterKey], value)
	else
		if not isHaveAdd then
			printError("对应值不存在，不要试图删减不存在的值")

			return
		end

		table.removebyvalue(self._condMap[sifterKey], value, true)
	end
end

function MasterFormSystemView:_isSifterCondHaveAdd(sifterKey, value)
	local isHaveAdd = false
	local condData = self._condMap[sifterKey]

	for _, v in ipairs(condData) do
		if v == value then
			isHaveAdd = true

			break
		end
	end

	return isHaveAdd
end

function MasterFormSystemView:_onUpdatePlaneUI()
	local tabInfo = self:_getTabInfo(self._curTabIdx)
	local fmtMo = tabInfo and tabInfo.fmtMo
	local type = fmtMo and fmtMo:getFmtType()

	if self._viewType == MasterFormSystemView.ViewType.Master then
		GameUtil.SetActive(self._funcCol._btnSubmit, self._masterFormMgr:isFitThresholdOfMe())
	else
		GameUtil.SetActive(self._funcCol._btnSubmit, false)
	end

	GameUtil.SetActive(self._funcCol._btnSure, tabInfo)
end

function MasterFormSystemView:_onUpdateSifterColUI()
	self:_setSifterVisual(self._isSifterColInShow)

	if not self._isSifterColInShow then
		return
	end

	local typeColTran = self._tabCol._funcCol._sifterCol._typeCol.transform
	local typeChildList = GameUtil.getChildren(typeColTran)
	local typeCellGo = typeChildList[1]

	for _, go in ipairs(typeChildList) do
		GameUtil.SetActive(go, false)
	end

	for typeIdx, condData in ipairs(self._condDataList) do
		if not typeChildList[typeIdx + 1] then
			local mainGo = goutil.cloneAndSetParent(typeCellGo, typeColTran)
			local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle/txt")
			local tabCol = goutil.findChild(mainGo, "tabCol")
			local tabCellGo = goutil.findChild(mainGo, "tabCol/tabCell")

			GameUtil.SetActive(mainGo, true)

			txtTitle.text = condData.sifterName

			local tabColTran = tabCol.transform
			local tabChildList = GameUtil.getChildren(tabColTran)
			local tabCellGo = tabChildList[1]

			for _, go in ipairs(tabChildList) do
				GameUtil.SetActive(go, false)
			end

			for tabIdx = 1, #condData.tabNames do
				if not tabChildList[tabIdx + 1] then
					local tabMainGo = goutil.cloneAndSetParent(tabCellGo, tabColTran)

					GameUtil.SetActive(tabMainGo, true)
					self:_updateSifterTabCell(tabMainGo, condData, tabIdx)
				end
			end
		end
	end
end

function MasterFormSystemView:_onClearSifterColUI()
	return
end

function MasterFormSystemView:_updateSifterTabCell(mainGo, condData, tabIdx)
	local tabName = condData.tabNames[tabIdx]
	local sifterCond = condData.sifterConds[tabIdx]
	local iconStateKey = condData.iconStateKeys[tabIdx]
	local txtTab = goutil.findChildTextComponent(mainGo, "txtTab")
	local iconAtlas = goutil.findChild(mainGo, "iconAtlas")
	local iconJob = goutil.findChild(mainGo, "iconJob")
	local iconJobEx = goutil.findChild(mainGo, "iconJobEx")

	txtTab.text = tabName

	local isSelected = self:_isSifterCondHaveAdd(condData.sifterKey, sifterCond)

	GameUtil.setUIGroupIdx(mainGo, isSelected and 1 or 0)
	GameUtil.SetActive(iconAtlas, false)
	GameUtil.SetActive(iconJob, false)
	GameUtil.SetActive(iconJobEx, false)

	if condData.iconType == "Ele" then
		GameUtil.SetActive(iconAtlas, true)

		do
			local state = (GameEnum.Races[iconStateKey] or 1) - 1

			GameUtil.setUIImageSpriteIdx(iconAtlas, state)
		end
	elseif condData.iconType == "Job" then
		if not GameEnum.JobZh[iconStateKey] then
			do
				local jobZh = 1

				if jobZh < 21 then
					local state = jobZh - 1

					GameUtil.setUIImageSpriteIdx(iconJob, state)
					GameUtil.setUIImageColorIdx(iconJob, isSelected and 1 or 0)
					GameUtil.SetActive(iconJob, true)
				else
					local state = jobZh - 20 - 1

					GameUtil.setUIImageSpriteIdx(iconJobEx, state)
					GameUtil.setUIImageColorIdx(iconJobEx, isSelected and 1 or 0)
					GameUtil.SetActive(iconJobEx, true)
				end
			end

			local function handler()
				local istabSelected = self:_isSifterCondHaveAdd(condData.sifterKey, sifterCond)
				local isAdd = not istabSelected

				self:_setSifterCond(condData.sifterKey, sifterCond, isAdd)
				self:_onUpdate()
			end

			GameUtil.addClickHandler(mainGo, handler)
		end
	end
end

function MasterFormSystemView:_onClickBtnSifter()
	self:_setSifterVisual(not self._isSifterColInShow)
	self:_onUpdateSifterColUI()
end

function MasterFormSystemView:_setSifterVisual(isToShow)
	self._isSifterColInShow = isToShow

	GameUtil.SetActive(self._tabCol._funcCol._sifterCol._mainGo, isToShow)
end

function MasterFormSystemView:_onCustomInputCallback(hover)
	if not hover then
		self:_setSifterVisual(false)
	end
end

function MasterFormSystemView:_onUpdateTopColUI()
	local tabInfo = self:_getTabInfo(self._curTabIdx)

	self._topCol._txtFmtName.text = tabInfo and tabInfo.fmtMo:getFmtName() or ""

	GameUtil.SetActive(self._topCol._btnCollect, tabInfo ~= nil)
	GameUtil.SetActive(self._topCol._btnShare, tabInfo ~= nil)
	GameUtil.setUIGroupIdx(self._topCol._btnCollect, (tabInfo or nil) and self._masterFormMgr:isCollect(tabInfo.fmtMo:getFmtType(), tabInfo.fmtMo:getFmtId()) and 1 or 0)
end

function MasterFormSystemView:_onClearTopColUI()
	return
end

function MasterFormSystemView:_onClickBtnCollect()
	local tabInfo = self:_getTabInfo(self._curTabIdx)

	if tabInfo then
		local fmtId = tabInfo.fmtMo:getFmtId()
		local fmtType = tabInfo.fmtMo:getFmtType()

		if self._masterFormMgr:isCollect(fmtType, fmtId) then
			MasterFormController.instance:sendPM_MasterFormCancelCollectReq(self._periodId, fmtId, fmtType)
		else
			MasterFormController.instance:sendPM_MasterFormCollectReq(self._periodId, fmtId, fmtType)
		end
	end
end

function MasterFormSystemView:_onClickBtnShare()
	local tabInfo = self:_getTabInfo(self._curTabIdx)
	local fmtMo = tabInfo and tabInfo.fmtMo

	if fmtMo then
		local params = {}

		params.periodId = self._periodId
		params.viewType = self._viewType
		params.fmtPlanId = self._fmtPlanId
		params.fmtId = fmtMo:getFmtId()

		UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.MasterForm, params)
	end
end

function MasterFormSystemView:_onUpdateTabColUI()
	self._tabScrollList:regReloadFinish(function()
		local comps = self._tabCol._tabScrollerview:GetComponentsInChildren(goutil.Type_RectTransform)

		for i = 0, comps.Length - 1 do
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(comps[i])
		end
	end)
	self._tabScrollList:reloadData(self._tabInfoList)

	if self._viewType == MasterFormSystemView.ViewType.System then
		self:_setSifterVisual(false)
		GameUtil.SetActive(self._tabCol._funcCol._btnSifter, false)
	else
		GameUtil.SetActive(self._tabCol._funcCol._btnSifter, true)
	end

	if self._viewType == MasterFormSystemView.ViewType.System then
		GameUtil.SetActive(self._tabCol._funcCol._InputField, false)
	else
		GameUtil.SetActive(self._tabCol._funcCol._InputField, true)
	end
end

function MasterFormSystemView:_onClearTabCol()
	self._tabScrollList:dispose()
end

function MasterFormSystemView:_updateTabCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local fmtMo = info.fmtMo
	local tabIdx = info.tabIdx
	local txtFmtName = goutil.findChildTextComponent(mainGo, "txtFmtName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local tagCol = goutil.findChild(mainGo, "tagCol")
	local tagView = goutil.findChild(mainGo, "tagCol/tagView")
	local txtCompCell = goutil.findChildTextComponent(mainGo, "tagCol/compCell/txt")
	local headIcon = goutil.findChild(mainGo, "headIcon")
	local txtPlayerName = goutil.findChildTextComponent(mainGo, "txtPlayerName")
	local thresholdGo = goutil.findChild(mainGo, "txtThreshold")
	local txtThreshold = goutil.findChildTextComponent(mainGo, "txtThreshold/txt")
	local fmtType = fmtMo:getFmtType()
	local isSelected = tabIdx == self._curTabIdx

	GameUtil.SetActive(imgSelect, isSelected)

	txtFmtName.text = fmtMo:getFmtName()
	txtDesc.text = fmtMo:getFmtSimpleDesc()

	local tagCellStrList = {}
	local tagIds = fmtMo:getFmtTagIds()

	for _, tagId in ipairs(tagIds) do
		local tagData = MasterFormConfig.instance:getMfTagData(tagId)

		if tagData then
			table.insert(tagCellStrList, tagData.desc)
		end
	end

	local parentTran = tagView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, go in ipairs(children) do
		GameUtil.SetActive(go, false)
	end

	for i, v in ipairs(tagCellStrList) do
		if not children[i] then
			local mainGo = goutil.cloneAndSetParent(children[1], parentTran)
			local txt = goutil.findChildTextComponent(mainGo, "txt")

			txt.text = v

			GameUtil.SetActive(mainGo, true)
		end
	end

	local fmtCompletion = checkint(fmtMo:getFmtCompletion() * 100)

	txtCompCell.text = string.format("完成度：%s%%", fmtCompletion)

	local isNeedHead = fmtType == MasterFormMgr.FmtType.Master

	GameUtil.SetActive(headIcon, isNeedHead)
	GameUtil.SetActive(txtPlayerName.gameObject, isNeedHead)
	HeadItemController.instance:resetHeadCell(headIcon)

	if isNeedHead then
		local headInfo = fmtMo:getHeadInfo()

		if headInfo then
			local proxy = HeadItemController.instance:setHeadCellByInfo(headIcon, headInfo)

			if proxy then
				local function func()
					RoleController.instance:openCardByUserId(headInfo.userId)
				end

				proxy:setCallBack(func)
			end
		end

		if headInfo then
			txtPlayerName.text = headInfo.userName or ""
		end
	end

	local isNeedThreshold = fmtType == MasterFormMgr.FmtType.Master

	GameUtil.SetActive(thresholdGo, isNeedThreshold)

	if isNeedThreshold then
		txtThreshold.text = fmtMo:getThresholdStr()
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTabCell, self, mainGo, tabIdx))
end

function MasterFormSystemView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local headIcon = goutil.findChild(mainGo, "headIcon")

	HeadItemController.instance:resetHeadCell(headIcon)
	GameUtil.rmClickHandler(mainGo)
end

function MasterFormSystemView:_onClickTabCell(mainGo, tabIdx)
	if self._curTabIdx == tabIdx then
		return
	end

	self._curTabIdx = tabIdx

	self:_setChatColVisual(false)
	self:_onUpdateUI()
end

function MasterFormSystemView:_onClickBtnRefresh()
	self:_onUpdate()
end

function MasterFormSystemView:_onUpdatePetColUI()
	local tabInfo = self:_getTabInfo(self._curTabIdx)
	local fmtMo = tabInfo and tabInfo.fmtMo
	local petId = 0
	local petIdList = fmtMo and fmtMo:getFmtPetIdList() or {}
	local children = GameUtil.getChildren(self._petCol._petView)

	for index, mainGo in ipairs(children) do
		petId = checknumber(petIdList[index])

		GameUtil.SetActive(mainGo, petId > 0)

		if petId > 0 then
			self:_updatePetCell(mainGo, fmtMo, petId)
		end
	end

	self._petCol._bottomCol._txtFmtDesc.text = fmtMo and fmtMo:getFmtDesc() or ""

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._petCol._bottomCol._txtFmtDesc.gameObject:GetComponent(goutil.Type_RectTransform))

	self._petCol._bottomCol._scrView:GetComponent(ComponentType.ScrollRect).verticalNormalizedPosition = 1

	if tabInfo == nil then
		local str = "没有阵容"

		if self._viewType == MasterFormSystemView.ViewType.System then
			str = "当前没有推荐阵容"
		elseif self._viewType == MasterFormSystemView.ViewType.Master then
			str = "当前没有已发布的阵容"
		elseif self._viewType == MasterFormSystemView.ViewType.Collect then
			str = "当前没有收藏阵容"
		end

		self._petCol._txtEmptyGo.text = str

		GameUtil.SetActive(self._petCol._emptyGo, true)
		GameUtil.SetActive(self._petCol._petView, false)
	else
		GameUtil.SetActive(self._petCol._emptyGo, false)
		GameUtil.SetActive(self._petCol._petView, true)
	end

	local isMaster = fmtMo and fmtMo:getFmtType() == MasterFormMgr.FmtType.Master

	GameUtil.SetActive(self._petCol._bottomCol._btnChat, isMaster)
	GameUtil.SetActive(self._petCol._bottomCol._btnKudo, isMaster)
	GameUtil.setUIGroupIdx(self._petCol._bottomCol._btnKudo, isMaster and fmtMo and fmtMo:isKudos() and 1 or 0)

	self._petCol._bottomCol._txtBtnKudo.text = Mathf.Min(isMaster and fmtMo and fmtMo:getFmtKudos() or 0, 999)
end

function MasterFormSystemView:_onClearPetCol()
	local children = GameUtil.getChildren(self._petCol._petView)

	for _, mainGo in ipairs(children) do
		self:_clearPetCell(mainGo)
	end
end

function MasterFormSystemView:_updatePetCell(mainGo, fmtMo, petId)
	local con = goutil.findChild(mainGo, "con")
	local imgPet = goutil.findChild(mainGo, "con/img/pet")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	MaterialMgr.setIcon(imgPet, MatType.Pet, fmtMo:getPetRaceId(petId), nil, nil)

	txtName.text = fmtMo:getPetName(petId)

	local hsName = fmtMo:getPetHolyStripeName(petId)

	if string.nilorempty(hsName) then
		GameUtil.SetActive(txtDesc.gameObject, false)
	else
		txtDesc.text = string.format("推荐灵纹：%s", fmtMo:getPetHolyStripeName(petId))

		GameUtil.SetActive(txtDesc.gameObject, true)
	end

	local isWithPet = BagModel.instance:isExistRaceId(fmtMo:getPetRaceId(petId))

	GameUtil.SetGray(con, not isWithPet)

	local function func()
		local raceId = fmtMo:getPetRaceId(petId)
		local hotPetCfg = MasterFormConfig.instance:getHotPetCfg(raceId)

		if hotPetCfg and (checknumber(hotPetCfg.cutePetId) > 0 or hotPetCfg.equipDefineId or hotPetCfg.holyStripeId or hotPetCfg.starGodsId) then
			UIStateManager.instance:push(ViewName.MasterFormHotPetDetailView, raceId)
		else
			local str = string.format("%s:%s", MatType.Pet, fmtMo:getPetRaceId(petId))

			TipsFacade.instance:openItemSourceView(str)
		end
	end

	GameUtil.addClickHandler(con, func, self)
end

function MasterFormSystemView:_clearPetCell(mainGo)
	local con = goutil.findChild(mainGo, "con")
	local imgPet = goutil.findChild(mainGo, "con/img/pet")

	MaterialMgr.resetAll(imgPet)
	GameUtil.rmClickHandler(con)
end

function MasterFormSystemView:_onClickBtnChat()
	local isShowing = self:_isChatColShowing()

	self:_setChatColVisual(not isShowing)

	if not isShowing then
		local tabInfo = self:_getTabInfo(self._curTabIdx)

		if tabInfo then
			MasterFormController.instance:sendPM_MasterFormgetCommentsReq(self._periodId, tabInfo.fmtMo:getFmtId())
		end
	else
		self:_onUpdateUI()
	end
end

function MasterFormSystemView:_onClickBtnKudo()
	local tabInfo = self:_getTabInfo(self._curTabIdx)
	local fmtMo = tabInfo and tabInfo.fmtMo

	if not fmtMo then
		return
	end

	local fmtType, fmtId = fmtMo:getFmtType(), fmtMo:getFmtId()
	local result, tips = self._masterFormMgr:getTryKudoFmtResultAndTips(fmtType, fmtId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	MasterFormController.instance:sendPM_MasterFormKudoFormReq(self._periodId, fmtId)
end

function MasterFormSystemView:_onClickBtnSureOfFmt()
	return
end

function MasterFormSystemView:_onUpdateChatColUI()
	self:_setChatColVisual(self:_isChatColShowing())

	if not self:_isChatColShowing() then
		return
	end

	self:_setChatColVisual(true)

	local tabInfo = self:_getTabInfo(self._curTabIdx)
	local fmtMo = tabInfo and tabInfo.fmtMo
	local isMaster = fmtMo and fmtMo:getFmtType() == MasterFormMgr.FmtType.Master

	self._chatCol._bottomCol._txtFmtDesc.text = tabInfo and tabInfo.fmtMo:getFmtDesc() or ""

	local petIdList = fmtMo and fmtMo:getFmtPetIdList() or {}
	local children = GameUtil.getChildren(self._chatCol._petView.transform)

	for index, mainGo in ipairs(children) do
		local con = goutil.findChild(mainGo, "con")
		local img = goutil.findChild(mainGo, "con/img")
		local petId = checknumber(petIdList[index])

		GameUtil.SetActive(mainGo, petId > 0)

		if petId > 0 then
			local raceId = fmtMo:getPetRaceId(petId)

			MaterialMgr.setIcon(img, MatType.Pet, raceId, nil, nil)

			local function func()
				local str = string.format("%s:%s", MatType.Pet, raceId)

				TipsFacade.instance:openItemSourceView(str)
			end

			GameUtil.addClickHandler(con, func, self)
		end
	end

	GameUtil.setUIGroupIdx(self._chatCol._bottomCol._btnKudo, isMaster and fmtMo and fmtMo:isKudos() and 1 or 0)
	GameUtil.setUIGroupIdx(self._petCol._bottomCol._btnKudo, isMaster and fmtMo and fmtMo:isKudos() and 1 or 0)

	self._chatCol._bottomCol._txtBtnKudo.text = Mathf.Min(isMaster and fmtMo and fmtMo:getFmtKudos() or 0, 999)

	local comments

	self._chatScrollList:reloadData(fmtMo and self._masterFormMgr:getComments(fmtMo:getFmtId()) or {})
end

function MasterFormSystemView:_onClearChatCol()
	self._chatScrollList:dispose()

	local children = GameUtil.getChildren(self._chatCol._petView.transform)

	for index, mainGo in ipairs(children) do
		local con = goutil.findChild(mainGo, "con")
		local img = goutil.findChild(mainGo, "con/img")

		MaterialMgr.resetAll(img)
		GameUtil.rmClickHandler(con)
	end
end

function MasterFormSystemView:_updateChatCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local tabInfo = self:_getTabInfo(self._curTabIdx)
	local fmtId = tabInfo and tabInfo.fmtMo:getFmtId() or 0
	local isHasKudos = data.isKudos
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local btnKudo = goutil.findChild(mainGo, "btnKudo")
	local txtBtnKudo = goutil.findChildTextComponent(mainGo, "btnKudo/txtCount")

	txtDesc.text = string.format("<color=#3bc28a>%s：</color>%s", data.headInfo.userName, data.content)
	txtBtnKudo.text = Mathf.Min(data.kudos, 999)

	GameUtil.setUIGroupIdx(btnKudo, isHasKudos and 1 or 0)

	local function handle()
		local result, tips = self._masterFormMgr:getTryKudoCommentResultAndTips(fmtId, data.commentId)

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		GameUtil.setUIGroupIdx(btnKudo, 1)

		txtBtnKudo.text = data.kudos + 1

		self._masterFormMgr:setHasKudoOfComment(fmtId, data.commentId, true)
		MasterFormController.instance:sendPM_MasterFormKudoCommentReq(self._periodId, fmtId, data.commentId)
	end

	GameUtil.addClickHandler(btnKudo, handle, self)
end

function MasterFormSystemView:_clearChatCell(cell)
	local mainGo = cell.gameObject
	local btnKudo = goutil.findChild(mainGo, "btnKudo")

	GameUtil.rmClickHandler(btnKudo)
end

function MasterFormSystemView:_cellSizeOfChat(view, index)
	local cell = self._chatScrollList._tableview:GetCellAtIndex(index)

	return GameUtil.getWidth(cell), GameUtil.getHeight(cell)
end

function MasterFormSystemView:_onValueChangedOfChat(str)
	return
end

function MasterFormSystemView:_onClickBtnSureOfChat()
	if self._isHandlingOfCommnet then
		FloatWordMgr.instance:show("评论正在处理中")

		return
	end

	local str = self._inputFieldChatCol:GetText()
	local result, tips = self._masterFormMgr:getSubmitCommentResultAndTips(str)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local tabInfo = self:_getTabInfo(self._curTabIdx)

	if tabInfo then
		MasterFormController.instance:sendPM_MasterFormCommentReq(self._periodId, tabInfo.fmtMo:getFmtId(), str)
	end
end

function MasterFormSystemView:_onCustomInputCallbackOfChatCol(hover)
	if not hover then
		self:_setChatColVisual(false)
	end
end

function MasterFormSystemView:_setChatColVisual(isToShow)
	self._isChatColInShow = isToShow

	GameUtil.SetActive(self._chatCol._mainGo, isToShow)
	GameUtil.SetActive(self._petCol._mainGo, not isToShow)
end

function MasterFormSystemView:_isChatColShowing()
	return checkbool(self._isChatColInShow)
end

function MasterFormSystemView:_setInputField(str)
	self._curSearchStr = str

	self._InputFieldAdapter:SetText(str)
end

function MasterFormSystemView:_getInputField()
	return self._InputFieldAdapter:GetText()
end

function MasterFormSystemView:_onValueChanged(str)
	if self._curSearchStr ~= str then
		self:_setInputField(str)
		self:_onUpdateData()
		self:_onUpdateUI()
	end
end

function MasterFormSystemView:_onClickBtnSubmitOfFunc()
	if self._masterFormMgr:isFitThresholdOfMe() then
		UIStateManager.instance:push(ViewName.MasterFormFmtSubmitView)
	else
		FloatWordMgr.instance:show("不符合发布门槛")
	end
end

function MasterFormSystemView:_onClickBtnSureOfFunc()
	local tabInfo = self:_getTabInfo(self._curTabIdx)

	if tabInfo and tabInfo.fmtMo:getFmtCompletion() >= 1 then
		self:_openBtnFormationView()
	else
		FloatWordMgr.instance:show("所选推荐阵中存在未收集精灵，使用失败")
	end
end

function MasterFormSystemView:_openBtnFormationView()
	local tabInfo = self:_getTabInfo(self._curTabIdx)

	if tabInfo then
		local tipsContent = "确定要添加此方案到阵型预设中吗？"

		TipsFacade.instance:openPopupWindow(lang("tip"), tipsContent, function()
			local idList = tabInfo.fmtMo:getFmtPetIdList()
			local positions = {
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0
			}
			local fmtData

			if tabInfo.fmtMo:getFmtType() == MasterFormMgr.FmtType.System then
				fmtData = MasterFormConfig.instance:getMfSysFmtDataById(tabInfo.fmtMo:getFmtId())
			end

			if fmtData then
				if not fmtData.posList then
					local posList = {}
					local raceId, petId = 0, 0

					for i, id in ipairs(idList) do
						petId = BagModel.instance:getMaxZdlPetIdByRaceId((tabInfo.fmtMo:getPetRaceId(id)))

						if petId then
							local pos = checknumber(posList[i])

							if pos < 1 or pos > #positions or positions[pos] ~= 0 then
								pos = table.indexof(positions, 0)
							end

							if pos then
								positions[pos] = petId
							end
						end
					end

					local summonPetId = 0

					if checknumber(tabInfo.fmtMo:getSummonPetRaceId()) > 0 then
						local targetRaceId = tabInfo.fmtMo:getSummonPetRaceId()

						for i, v in ipairs(positions) do
							local petMo = BagPetsController.instance:getPet(v)

							if petMo.raceId == targetRaceId then
								summonPetId = v

								break
							end
						end
					end

					local summonMasterPetId = 0
					local var_73_1

					if checknumber(tabInfo.fmtMo:getSummonMasterRaceId()) > 0 then
						do
							local targetRaceId = tabInfo.fmtMo:getSummonMasterRaceId()

							for i, v in ipairs(positions) do
								local petMo = BagPetsController.instance:getPet(v)

								if petMo.raceId == targetRaceId then
									summonMasterPetId = v

									break
								end
							end
						end

						var_73_1 = tabInfo.fmtMo:getFmtName() or lang("推荐阵克隆")
					end

					FormationGroupController.instance:sendAddNewTab(FormationGroupController.DEFAULT_GROUP_ID, var_73_1, positions, summonMasterPetId, summonPetId)
				end
			end
		end)
	end
end

function MasterFormSystemView:_OnMenuCloseFormation()
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnPopupClick, self._OnMenuClickFormation, self)
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseFormation, self)
end

function MasterFormSystemView:_OnMenuCloseFormation()
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnPopupClick, self._OnMenuClickFormation, self)
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseFormation, self)
end

function MasterFormSystemView:_OnMenuClickFormation(id)
	self:_OnClickFormationItem(id)
end

function MasterFormSystemView:_OnClickFormationItem(id)
	local tabInfo = self:_getTabInfo(self._curTabIdx)

	if tabInfo then
		local idList = tabInfo.fmtMo:getFmtPetIdList()
		local positions = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
		local raceId, petId = 0, 0

		for i, id in ipairs(idList) do
			petId = BagModel.instance:getMaxZdlPetIdByRaceId((tabInfo.fmtMo:getPetRaceId(id)))

			if petId then
				positions[i] = petId
			end
		end

		local teamMo = FormationNewModel.instance:GetTeam(id)
		local formatMo = teamMo and teamMo:GetCurFormation()

		if formatMo then
			local function saveFunc()
				formatMo:setPositionForce(positions)
				FormationController.instance:SaveFormationEx()
				FormationController.instance:ChangeTeamId(id)
				FloatWordMgr.instance:show("推荐阵使用成功")
			end

			if formatMo:isEmpty() then
				saveFunc()
			else
				local tipsContent = "该阵容正在使用，是否确认覆盖？"

				local function okFunc()
					saveFunc()
				end

				local function cencelFunc()
					return
				end

				TipsFacade.instance:openPopupWindow("更新提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
			end
		end
	end
end

return MasterFormSystemView
