-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/view/XuChallengePetBindView.lua

module("logic.extensions.xuchallenge.view.XuChallengePetBindView", package.seeall)

local XuChallengePetBindView = class("XuChallengePetBindView", ViewComponent)
local CellState = {
	CantSelect = 3,
	Full = 4,
	CanSelect = 2,
	Selected = 1
}

local function _getPetMoLevel(petMo)
	if petMo == nil then
		return 0
	end

	if petMo.getPetLv then
		return checknumber(petMo:getPetLv())
	end

	return checknumber(petMo.level or petMo.curLv)
end

local function _getPetMoId(petMo)
	if petMo == nil then
		return 0
	end

	if petMo.getId then
		return checknumber(petMo:getId())
	end

	return checknumber(petMo.petId)
end

local function _getPetMoFightingPower(petMo)
	if petMo == nil then
		return 0
	end

	if petMo.getFightingPower then
		return checknumber(petMo:getFightingPower())
	end

	return checknumber(petMo.fightingPower or petMo.zdl or petMo._zdl)
end

local function _sortPetMoListByPower(petMoList)
	table.sort(petMoList, function(a, b)
		local powerA = _getPetMoFightingPower(a)
		local powerB = _getPetMoFightingPower(b)

		if powerA ~= powerB then
			return powerB < powerA
		end

		local levelA = _getPetMoLevel(a)
		local levelB = _getPetMoLevel(b)

		if levelA ~= levelB then
			return levelB < levelA
		end

		return _getPetMoId(a) < _getPetMoId(b)
	end)
end

function XuChallengePetBindView:buildUI()
	XuChallengePetBindView.super.buildUI(self)

	self._inputSearch = self:getInput("Input_Search")
	self._btnClearSearch = self:getGo("Input_Search/BtnClear")
	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtValidator = self:getTxt("txtValidator")
	self._txtSelectCount = self:getTxt("txtSelectCount")
	self._tagEmpty = self:getGo("petCol/tagEmpty")

	local slotScrView = self:getGo("slotCol/scrView")
	local slotScrCell = self:getGo("slotCol/scrCell")
	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._slotScrollerList = ScrollerList.create(slotScrView, slotScrCell, GameUtil.handler(self._updateSlotCell, self), GameUtil.handler(self._clearSlotCell, self))
	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function XuChallengePetBindView:bindEvents()
	XuChallengePetBindView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClearSearch, self._onClickBtnClearSearch, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	self._inputSearch:AddOnValueChanged(self._onSearchTextChanged, self)
end

function XuChallengePetBindView:unbindEvents()
	XuChallengePetBindView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClearSearch)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	self._inputSearch:RemoveOnValueChanged()
end

function XuChallengePetBindView:onEnter()
	XuChallengePetBindView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._selectedStageId = checknumber(params[2])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		XuChallengeController.instance:getSubMo(self._activityId):clearBindDraftStageToRaceIds()
		self:close()

		return
	end

	self._subMo = XuChallengeController.instance:getSubMo(self._activityId)
	self._stageDataList = XuChallengeConfig.instance:getStageDatas(self._activityId) or {}
	self._currSearching = self._inputSearch:GetText()
	self._racePetList = self:_buildRacePetList()

	if self:_isAllServerStageBound() then
		self._subMo:clearBindDraftStageToRaceIds()
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.HandlePM_XuChallengeReplacePetRes, self._onReplacePetRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_XuChallengeResetRes, self._onResetRes, self)
	self:_onUpdate()
end

function XuChallengePetBindView:onExit()
	XuChallengePetBindView.super.onExit(self)
	self._slotScrollerList:dispose()
	self._petScrollerList:dispose()
end

function XuChallengePetBindView:_onUpdate()
	self:_clearInvalidDraft()
	self:_refreshDraftState()
	self:_rebuildViewPetList()
	self:_updateTips()
	self:_updateSlotCol()
	self:_updatePetCol()
end

function XuChallengePetBindView:_refreshDraftState()
	self._selectedCount = self:_getSelectedCount()
	self._totalCount = #self._stageDataList
	self._selectedStageId = self:_getDefaultSelectedStageId(self._selectedStageId)
	self._currentStageId = self._selectedStageId
	self._currentStageData = self._currentStageId > 0 and XuChallengeConfig.instance:getStageData(self._activityId, self._currentStageId) or nil
	self._isFull = self._totalCount > 0 and self._selectedCount >= self._totalCount
	self._selectedStageToRaceIds = self:_getSelectedStageToRaceIds()
end

function XuChallengePetBindView:_updateTips()
	self._txtSelectCount.text = string.format("已选（%s/%s）", self._selectedCount, self._totalCount)

	if self._isFull then
		self._txtValidator.text = "已选择全部关卡精灵"
	elseif self._currentStageData then
		if not self._currentStageData.validatorDesc then
			local desc = ""

			self._txtValidator.text = string.format("本关上阵要求：%s", desc)
		end
	end

	GameUtil.SetGray(self._btnSure, not self._isFull)
end

function XuChallengePetBindView:_getDefaultSelectedStageId(preferredStageId)
	preferredStageId = checknumber(preferredStageId)

	if self:_isEditableStageId(preferredStageId) then
		return preferredStageId
	end

	for _, data in ipairs(self._stageDataList) do
		local stageId = checknumber(data.stageId)
		local raceId = checknumber(self._subMo:getBindDraftRaceIdByStageId(stageId))

		if raceId <= 0 and self:_isEditableStageId(stageId) then
			return stageId
		end
	end

	for _, data in ipairs(self._stageDataList) do
		local stageId = checknumber(data.stageId)

		if self:_isEditableStageId(stageId) then
			return stageId
		end
	end

	return 0
end

function XuChallengePetBindView:_isEditableStageId(stageId)
	stageId = checknumber(stageId)

	if stageId <= 0 or self._subMo:isHasBindRaceId(stageId) then
		return false
	end

	return XuChallengeConfig.instance:getStageData(self._activityId, stageId) ~= nil
end

function XuChallengePetBindView:_isAllServerStageBound()
	if self._stageDataList == nil or #self._stageDataList <= 0 then
		return false
	end

	for _, data in ipairs(self._stageDataList) do
		if not self._subMo:isHasBindRaceId(data.stageId) then
			return false
		end
	end

	return true
end

function XuChallengePetBindView:_getSelectedCount()
	local count = 0

	for _, data in ipairs(self._stageDataList) do
		local stageId = checknumber(data.stageId)

		if checknumber(self._subMo:getBindDraftRaceIdByStageId(stageId)) > 0 then
			count = count + 1
		end
	end

	return count
end

function XuChallengePetBindView:_clearInvalidDraft()
	for _, data in ipairs(self._subMo:getBindDraftStageToRaceIds()) do
		if self:_getAnyPetMoByRaceId(data.raceId) == nil then
			self._subMo:removeBindDraftRaceIdByStageId(data.stageId)
		end
	end
end

function XuChallengePetBindView:_getSelectedStageToRaceIds()
	local result = {}

	for _, data in ipairs(self._stageDataList) do
		local stageId = checknumber(data.stageId)
		local raceId = checknumber(self._subMo:getBindDraftRaceIdByStageId(stageId))

		if stageId > 0 and raceId > 0 then
			table.insert(result, {
				stageId = stageId,
				raceId = raceId
			})
		end
	end

	return result
end

function XuChallengePetBindView:_getPetName(petMo)
	if petMo == nil then
		return ""
	end

	return petMo:getName()
end

function XuChallengePetBindView:_isPetMatchSearch(petMo)
	return MmUtil.isPlainSearchMatch(self:_getPetName(petMo), self._currSearching)
end

function XuChallengePetBindView:_getReasonTips(reason)
	local failReason = XuChallengeEnum.SelectPetFailReason

	if reason == failReason.EmptyPet then
		return "精灵状态已变化，请重新选择"
	elseif reason == failReason.ValidatorNotMatch then
		return "该精灵不满足本关上阵要求"
	elseif reason == failReason.BoundRaceId or reason == failReason.SelectedRaceId then
		return "该精灵已绑定其他关卡"
	elseif reason == failReason.SacrificedRaceId then
		return "该精灵已被献祭"
	end

	return "该精灵不可选择"
end

function XuChallengePetBindView:_buildRacePetList()
	local result = {}
	local raceMap = {}
	local raceIds = {}

	self._racePetMoListMap = {}

	for _, petMo in ipairs(BagPetsController.instance:getBagPets() or {}) do
		local raceId = checknumber(petMo:getDefineId())

		if raceId > 0 then
			if not raceMap[raceId] then
				raceMap[raceId] = true

				table.insert(raceIds, raceId)

				self._racePetMoListMap[raceId] = {}
			end

			table.insert(self._racePetMoListMap[raceId], petMo)
		end
	end

	for _, raceId in ipairs(raceIds) do
		local petMoList = self._racePetMoListMap[raceId]

		_sortPetMoListByPower(petMoList)

		local petMo = petMoList and petMoList[1]

		if petMo ~= nil then
			table.insert(result, {
				raceId = raceId,
				petMo = petMo,
				defaultPetMo = petMo,
				sortValue = #result + 1
			})
		end
	end

	return result
end

function XuChallengePetBindView:_getAnyPetMoByRaceId(raceId)
	raceId = checknumber(raceId)

	if raceId <= 0 then
		return nil
	end

	if not self._racePetMoListMap then
		local racePetMoListMap = {}

		for _, petMo in ipairs((not racePetMoListMap[raceId] or nil) and {}) do
			return petMo
		end

		for _, petMo in ipairs(BagPetsController.instance:getBagPets() or {}) do
			if checknumber(petMo:getDefineId()) == raceId then
				return petMo
			end
		end

		return nil
	end
end

function XuChallengePetBindView:_findValidPetMoByRaceId(raceId, stageId, selectedStageToRaceIds)
	raceId = checknumber(raceId)
	stageId = checknumber(stageId)

	if raceId <= 0 or stageId <= 0 then
		return nil, XuChallengeEnum.SelectPetFailReason.EmptyPet
	end

	local firstReason = XuChallengeEnum.SelectPetFailReason.EmptyPet

	local function tryPetMoList(petMoList)
		for _, petMo in ipairs(petMoList or {}) do
			if checknumber(petMo:getDefineId()) == raceId then
				local isCanSelect, reason = XuChallengeController.instance:checkPetMoCanSelectForStage(self._activityId, stageId, petMo, selectedStageToRaceIds, stageId)

				firstReason = firstReason == XuChallengeEnum.SelectPetFailReason.EmptyPet and reason or firstReason

				if isCanSelect then
					return petMo
				end
			end
		end
	end

	if not self._racePetMoListMap then
		local racePetMoListMap = {}
		local petMo = tryPetMoList(racePetMoListMap[raceId])

		if petMo ~= nil then
			return petMo, XuChallengeEnum.SelectPetFailReason.None
		end

		petMo = tryPetMoList(BagPetsController.instance:getBagPets())

		if petMo ~= nil then
			return petMo, XuChallengeEnum.SelectPetFailReason.None
		end

		return nil, firstReason
	end
end

function XuChallengePetBindView:_updateSlotCol()
	self._slotScrollerList:reloadData(self._stageDataList or {})
end

function XuChallengePetBindView:_updateSlotCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local imgEmpty = goutil.findChild(mainGo, "imgEmpty")
	local txtStage = goutil.findChildTextComponent(mainGo, "name/txt")
	local pet = goutil.findChild(mainGo, "pet")
	local tagSelect = goutil.findChild(mainGo, "tagSelect")
	local stageId = checknumber(data.stageId)
	local raceId = checknumber(self._subMo:getBindDraftRaceIdByStageId(stageId))

	if txtStage then
		txtStage.text = string.format("第%s关", stageId)
	end

	MaterialMgr.clearIcon(pet)

	if raceId > 0 then
		MaterialMgr.setIcon(pet, MatType.Pet, raceId)
	end

	GameUtil.SetActive(imgEmpty, raceId <= 0)
	GameUtil.SetActive(pet, raceId > 0)
	GameUtil.SetActive(tagSelect, stageId == self._selectedStageId)
	GameUtil.rmClickHandler(mainGo)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickSlotCell, self, stageId))
end

function XuChallengePetBindView:_clearSlotCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")

	GameUtil.rmClickHandler(mainGo)
	MaterialMgr.clearIcon(pet)
end

function XuChallengePetBindView:_onClickSlotCell(stageId)
	stageId = checknumber(stageId)

	if not self:_isEditableStageId(stageId) then
		return
	end

	local raceId = checknumber(self._subMo:getBindDraftRaceIdByStageId(stageId))

	if self._selectedStageId == stageId then
		self._pendingMovePetRaceId = raceId

		self:_movePetColToPendingRaceId()

		return
	end

	self._selectedStageId = stageId
	self._pendingMovePetRaceId = raceId

	self:_onUpdate()
end

function XuChallengePetBindView:_updatePetCol()
	if not self._viewPetList then
		self._petScrollerList:reloadData(self._viewPetList)
		self:_movePetColToPendingRaceId()
		GameUtil.SetActive(self._tagEmpty, #self._viewPetList <= 0)
	end
end

function XuChallengePetBindView:_movePetColToPendingRaceId()
	local raceId = checknumber(self._pendingMovePetRaceId)

	self._pendingMovePetRaceId = nil

	if raceId <= 0 then
		return
	end

	for index, data in ipairs(self._viewPetList or {}) do
		if checknumber(data.raceId) == raceId then
			self._petScrollerList:MoveCellInView(index - 1, false)

			return
		end
	end
end

function XuChallengePetBindView:_rebuildViewPetList()
	self._viewPetList = {}

	for _, data in ipairs(self._racePetList or {}) do
		self:_updatePetDataState(data)

		if data.state == CellState.Selected or data.state == CellState.CanSelect and self:_isPetMatchSearch(data.defaultPetMo) then
			table.insert(self._viewPetList, data)
		end
	end

	self:_sortViewPetList()
end

function XuChallengePetBindView:_updatePetDataState(data)
	local selectedStageId = checknumber(self._selectedStageId)
	local selectedRaceId = checknumber(self._subMo:getBindDraftRaceIdByStageId(selectedStageId))
	local bindStageId = self._subMo:getBindDraftStageIdByRaceId(data.raceId)

	data.bindStageId = bindStageId
	data.reason = XuChallengeEnum.SelectPetFailReason.None
	data.petMo = data.defaultPetMo

	if selectedStageId > 0 and data.raceId == selectedRaceId then
		data.bindStageId = selectedStageId
		data.state = CellState.Selected
		data.sortState = CellState.CanSelect
		data.sortValueForView = data.sortValue

		return
	end

	if selectedStageId <= 0 then
		data.state = CellState.Full
		data.sortState = CellState.CantSelect
		data.sortValueForView = data.sortValue

		return
	end

	if bindStageId > 0 then
		data.state = CellState.CantSelect
		data.sortState = CellState.CantSelect
		data.reason = XuChallengeEnum.SelectPetFailReason.SelectedRaceId
		data.sortValueForView = data.sortValue

		return
	end

	local petMo, reason = self:_findValidPetMoByRaceId(data.raceId, selectedStageId, self._selectedStageToRaceIds)

	if petMo ~= nil then
		data.petMo = petMo
		data.state = CellState.CanSelect
		data.sortState = CellState.CanSelect
	else
		data.state = CellState.CantSelect
		data.sortState = CellState.CantSelect
		data.reason = reason
	end

	data.sortValueForView = data.sortValue
end

function XuChallengePetBindView:_sortViewPetList()
	table.sort(self._viewPetList, function(a, b)
		if a.sortState ~= b.sortState then
			return a.sortState < b.sortState
		end

		local powerA = _getPetMoFightingPower(a.petMo)
		local powerB = _getPetMoFightingPower(b.petMo)

		if powerA ~= powerB then
			return powerB < powerA
		end

		return a.sortValueForView < b.sortValueForView
	end)
end

function XuChallengePetBindView:_updatePetCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local tagBind = goutil.findChild(mainGo, "tagBind")
	local txtTagBind = goutil.findChildTextComponent(mainGo, "tagBind/txt")
	local tagLock = goutil.findChild(mainGo, "tagLock")
	local petMo = data.petMo
	local isSelected = data.state == CellState.Selected
	local isCanSelect = data.state == CellState.CanSelect
	local isGray = not isSelected and not isCanSelect

	MaterialMgr.resetAll(item)

	local proxy = MaterialMgr.setCellByData(MatType.Pet, petMo, item)

	if proxy then
		proxy.binder:setSelected(isSelected)
		proxy.binder:setGray(isGray)
		proxy.binder:setClickCallBack(GameUtil.handler(self._onClickPetCell, self, data))
	end

	GameUtil.SetActive(tagBind, isSelected)

	if txtTagBind and isSelected then
		txtTagBind.text = string.format("绑定第%s关", data.bindStageId)
	end

	if tagLock then
		GameUtil.SetActive(tagLock, false)
	end
end

function XuChallengePetBindView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function XuChallengePetBindView:_onClickPetCell(data)
	if data.state == CellState.Selected then
		self._subMo:removeBindDraftRaceIdByStageId(self._selectedStageId)
		self:_onUpdate()

		return
	end

	if data.state == CellState.Full then
		FloatWordMgr.instance:show("已选择全部关卡精灵")

		return
	end

	if data.state == CellState.CantSelect then
		FloatWordMgr.instance:show(self:_getReasonTips(data.reason))

		return
	end

	local stageId = checknumber(self._selectedStageId)

	if stageId <= 0 then
		FloatWordMgr.instance:show("已选择全部关卡精灵")

		return
	end

	local petMo, reason = self:_findValidPetMoByRaceId(data.raceId, stageId, self._selectedStageToRaceIds)

	if petMo == nil then
		FloatWordMgr.instance:show(self:_getReasonTips(reason))

		return
	end

	self._subMo:setBindDraftRaceIdByStageId(stageId, data.raceId)
	self:_onUpdate()
end

function XuChallengePetBindView:_onClickBtnClearSearch()
	self._inputSearch:SetText("")

	if self._currSearching ~= "" then
		self._currSearching = ""

		self:_onUpdate()
	end
end

function XuChallengePetBindView:_onSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_onUpdate()
	end
end

function XuChallengePetBindView:_onClickBtnSure()
	if not self._isFull then
		FloatWordMgr.instance:show("请选择全部关卡精灵")

		return
	end

	local isValid, tips, stageToPetId = self:_buildStageToPetIdForSubmit()

	if not isValid then
		FloatWordMgr.instance:show(tips)
		self:_onUpdate()

		return
	end

	XuChallengeController.instance:sendPM_XuChallengeReplacePetReq(self._activityId, stageToPetId)
end

function XuChallengePetBindView:_buildStageToPetIdForSubmit()
	local stageToRaceIds = self:_getSelectedStageToRaceIds()

	if #stageToRaceIds < #self._stageDataList then
		return false, "请选择全部关卡精灵"
	end

	local raceIdMap = {}
	local stageToPetId = {}

	for _, data in ipairs(self._stageDataList) do
		local stageId = checknumber(data.stageId)
		local raceId = checknumber(self._subMo:getBindDraftRaceIdByStageId(stageId))

		if raceId <= 0 then
			return false, "请选择全部关卡精灵"
		end

		if raceIdMap[raceId] then
			return false, "不能绑定重复精灵"
		end

		local petMo, reason = self:_findValidPetMoByRaceId(raceId, stageId, stageToRaceIds)

		if petMo == nil then
			return false, self:_getReasonTips(reason)
		end

		local var_43_1 = {
			stageId = stageId
		}

		var_43_1.petId = checknumber(petMo.petId or petMo:getId())

		table.insert(stageToPetId, var_43_1)

		raceIdMap[raceId] = true
	end

	return true, nil, stageToPetId
end

function XuChallengePetBindView:_onReplacePetRes(msg)
	if msg and msg.activityId ~= self._activityId then
		return
	end

	FloatWordMgr.instance:show("绑定成功")
	self:close()
end

function XuChallengePetBindView:_onResetRes(msg)
	if msg and msg.activityId ~= self._activityId then
		return
	end

	self:close()
end

return XuChallengePetBindView
