-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/view/XuChallengePetSacrificeView.lua

module("logic.extensions.xuchallenge.view.XuChallengePetSacrificeView", package.seeall)

local XuChallengePetSacrificeView = class("XuChallengePetSacrificeView", ViewComponent)
local CellState = {
	CantSelect = 3,
	CanSelect = 2,
	Selected = 1
}
local TagState = {
	Bind = 1,
	Sacrifice = 2,
	None = 0
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

function XuChallengePetSacrificeView:buildUI()
	XuChallengePetSacrificeView.super.buildUI(self)

	self._inputSearch = self:getInput("InputField")
	self._btnSearch = self:getGo("InputField/btnSearch")
	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtValidator = self:getTxt("txtValidator")
	self._tagEmpty = self:getGo("petCol/tagEmpty")

	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function XuChallengePetSacrificeView:bindEvents()
	XuChallengePetSacrificeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSearch, self._onClickBtnSearch, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	self._inputSearch:AddOnValueChanged(self._onSearchTextChanged, self)
end

function XuChallengePetSacrificeView:unbindEvents()
	XuChallengePetSacrificeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSearch)
	GameUtil.rmClickHandler(self._btnSure)
	self._inputSearch:RemoveOnValueChanged()
end

function XuChallengePetSacrificeView:onEnter()
	XuChallengePetSacrificeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._challengeStageId = checknumber(params[2])
	self._targetStageId = checknumber(params[3])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = XuChallengeController.instance:getSubMo(self._activityId)

	if not self._subMo:isHasBindRaceId(self._targetStageId) then
		FloatWordMgr.instance:show("该关卡尚未绑定精灵")
		self:close()

		return
	end

	self._subMo:ensurePreviewStageToRaceIds(self._challengeStageId)

	self._targetStageData = XuChallengeConfig.instance:getStageData(self._activityId, self._targetStageId)
	self._challengeStageData = XuChallengeConfig.instance:getStageData(self._activityId, self._challengeStageId)

	if self._targetStageData == nil or self._challengeStageData == nil then
		FloatWordMgr.instance:show("关卡配置不存在")
		self:close()

		return
	end

	self._originPreviewRaceId = checknumber(self._subMo:getPreviewRaceIdByStageId(self._targetStageId))
	self._tempSelectedRaceId = self._originPreviewRaceId
	self._currSearching = self._inputSearch:GetText()
	self._racePetList = self:_buildRacePetList()

	if self._tempSelectedRaceId > 0 and self:_getAnyPetMoByRaceId(self._tempSelectedRaceId) == nil then
		self._tempSelectedRaceId = 0
	end

	self:_onUpdate(true)
end

function XuChallengePetSacrificeView:onExit()
	XuChallengePetSacrificeView.super.onExit(self)
	self._petScrollerList:dispose()
end

function XuChallengePetSacrificeView:_onUpdate(isRebuildPetList)
	if isRebuildPetList then
		self:_rebuildViewPetList()
	else
		self:_refreshViewPetListState()
	end

	self:_updateTips()
	self:_updatePetCol()
end

function XuChallengePetSacrificeView:_updateTips()
	if self._targetStageData then
		if not self._targetStageData.validatorDesc then
			local desc = ""

			self._txtValidator.text = string.format("本关上阵要求：%s", desc)
		end
	end
end

function XuChallengePetSacrificeView:_getPetName(petMo)
	if petMo == nil then
		return ""
	end

	return petMo:getName()
end

function XuChallengePetSacrificeView:_isPetMatchSearch(petMo)
	return MmUtil.isPlainSearchMatch(self:_getPetName(petMo), self._currSearching)
end

function XuChallengePetSacrificeView:_getReasonTips(reason)
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

function XuChallengePetSacrificeView:_buildRacePetList()
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

function XuChallengePetSacrificeView:_getAnyPetMoByRaceId(raceId)
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

function XuChallengePetSacrificeView:_getSelectedStageToRaceIds()
	local result = self._subMo:getPreviewStageToRaceIds()
	local hasTargetStage = false

	for _, data in ipairs(result) do
		if checknumber(data.stageId) == self._targetStageId then
			data.raceId = self._tempSelectedRaceId
			hasTargetStage = true

			break
		end
	end

	if self._tempSelectedRaceId > 0 and not hasTargetStage then
		table.insert(result, {
			stageId = self._targetStageId,
			raceId = self._tempSelectedRaceId
		})
	end

	for i = #result, 1, -1 do
		if checknumber(result[i].raceId) <= 0 then
			table.remove(result, i)
		end
	end

	return result
end

function XuChallengePetSacrificeView:_findValidPetMoByRaceId(raceId)
	raceId = checknumber(raceId)

	if raceId <= 0 then
		return nil, XuChallengeEnum.SelectPetFailReason.EmptyPet
	end

	local selectedStageToRaceIds = self:_getSelectedStageToRaceIds()
	local firstReason = XuChallengeEnum.SelectPetFailReason.EmptyPet

	local function tryPetMoList(petMoList)
		for _, petMo in ipairs(petMoList or {}) do
			if checknumber(petMo:getDefineId()) == raceId then
				local isCanSelect, reason = XuChallengeController.instance:checkPetMoCanSelectForStage(self._activityId, self._targetStageId, petMo, selectedStageToRaceIds, self._targetStageId)

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

function XuChallengePetSacrificeView:_updatePetCol()
	if not self._viewPetList then
		self._petScrollerList:reloadData(self._viewPetList)
		GameUtil.SetActive(self._tagEmpty, #self._viewPetList <= 0)
	end
end

function XuChallengePetSacrificeView:_rebuildViewPetList()
	self._viewPetList = {}

	for _, data in ipairs(self._racePetList or {}) do
		self:_updatePetDataState(data)

		if data.state == CellState.Selected or self:_isPetMatchSearch(data.defaultPetMo) then
			table.insert(self._viewPetList, data)
		end
	end

	self:_sortViewPetList()
end

function XuChallengePetSacrificeView:_refreshViewPetListState()
	local result = {}

	for _, data in ipairs(self._viewPetList or {}) do
		self:_updatePetDataState(data)

		if data.state == CellState.Selected or self:_isPetMatchSearch(data.defaultPetMo) then
			table.insert(result, data)
		end
	end

	self._viewPetList = result

	self:_sortViewPetList()
end

function XuChallengePetSacrificeView:_updatePetDataState(data)
	data.reason = XuChallengeEnum.SelectPetFailReason.None
	data.tagState = TagState.None
	data.petMo = data.defaultPetMo

	if data.raceId == self._tempSelectedRaceId then
		data.state = CellState.Selected
		data.sortState = CellState.CanSelect
		data.sortValueForView = data.sortValue

		return
	end

	local petMo, reason = self:_findValidPetMoByRaceId(data.raceId)

	if petMo ~= nil then
		data.petMo = petMo
		data.state = CellState.CanSelect
		data.sortState = CellState.CanSelect
	else
		data.state = CellState.CantSelect
		data.sortState = CellState.CantSelect
		data.reason = reason
		data.tagState = self:_getTagStateByReason(reason)
	end

	data.sortValueForView = data.sortValue
end

function XuChallengePetSacrificeView:_getTagStateByReason(reason)
	local failReason = XuChallengeEnum.SelectPetFailReason

	if reason == failReason.SacrificedRaceId then
		return TagState.Sacrifice
	elseif reason == failReason.BoundRaceId or reason == failReason.SelectedRaceId then
		return TagState.Bind
	end

	return TagState.None
end

function XuChallengePetSacrificeView:_sortViewPetList()
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

function XuChallengePetSacrificeView:_updatePetCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local tagSacrifice = goutil.findChild(mainGo, "tagSacrifice")
	local tagBind = goutil.findChild(mainGo, "tagBind")
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

	GameUtil.SetActive(tagSacrifice, data.tagState == TagState.Sacrifice)
	GameUtil.SetActive(tagBind, data.tagState == TagState.Bind)
end

function XuChallengePetSacrificeView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function XuChallengePetSacrificeView:_onClickPetCell(data)
	if data.state == CellState.Selected then
		self._tempSelectedRaceId = 0

		self:_onUpdate(false)

		return
	end

	if data.state == CellState.CantSelect then
		FloatWordMgr.instance:show(self:_getReasonTips(data.reason))

		return
	end

	local petMo, reason = self:_findValidPetMoByRaceId(data.raceId)

	if petMo == nil then
		FloatWordMgr.instance:show(self:_getReasonTips(reason))

		return
	end

	self._tempSelectedRaceId = data.raceId

	self:_onUpdate(false)
end

function XuChallengePetSacrificeView:_onClickBtnSearch()
	self._currSearching = self._inputSearch:GetText()

	self:_onUpdate(true)
end

function XuChallengePetSacrificeView:_onSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_onUpdate(true)
	end
end

function XuChallengePetSacrificeView:_onClickBtnSure()
	local isValid, tips = self:_checkCanSavePreview()

	if not isValid then
		FloatWordMgr.instance:show(tips)
		self:_onUpdate(true)

		return
	end

	self._subMo:setPreviewRaceIdByStageId(self._challengeStageId, self._targetStageId, self._tempSelectedRaceId)
	GlobalDispatcher:dispatch(GlobalNotify.XuChallengePreviewSacrificeChanged)
	FloatWordMgr.instance:show("选择成功")
	self:close()
end

function XuChallengePetSacrificeView:_checkCanSavePreview()
	if self._tempSelectedRaceId <= 0 then
		return true
	end

	local petMo, reason = self:_findValidPetMoByRaceId(self._tempSelectedRaceId)

	if petMo == nil then
		return false, self:_getReasonTips(reason)
	end

	if not self:_isPreviewSacrificeCountInLimitAfterSave() then
		return false, "本次献祭精灵数量已达上限"
	end

	return true
end

function XuChallengePetSacrificeView:_isPreviewSacrificeCountInLimitAfterSave()
	local maxCount = checknumber((self._challengeStageData or nil) and self._challengeStageData.canSacrificeStageNum)
	local currentCount = checknumber(self._subMo:getPreviewSacrificeCount())
	local oldChanged = self:_isRaceIdChangedFromServer(self._originPreviewRaceId)
	local newChanged = self:_isRaceIdChangedFromServer(self._tempSelectedRaceId)
	local nextCount = currentCount

	if oldChanged and not newChanged then
		nextCount = nextCount - 1
	elseif not oldChanged and newChanged then
		nextCount = nextCount + 1
	end

	return nextCount <= maxCount
end

function XuChallengePetSacrificeView:_isRaceIdChangedFromServer(raceId)
	raceId = checknumber(raceId)

	return raceId > 0 and raceId ~= checknumber(self._subMo:getBindRaceId(self._targetStageId))
end

return XuChallengePetSacrificeView
