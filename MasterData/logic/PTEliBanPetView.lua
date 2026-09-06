-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliBanPetView.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliBanPetView", package.seeall)

local PTEliBanPetView = class("PTEliBanPetView", ViewComponent)

function PTEliBanPetView:ctor()
	PTEliBanPetView.super.ctor(self)

	self._selectPetList = {}
end

function PTEliBanPetView:buildUI()
	PTEliBanPetView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._txtVoteTime = goutil.findChildTextComponent(self.mainGO, "ruleCol/txtVoteTime")
	self._txtRule = goutil.findChildTextComponent(self.mainGO, "ruleCol/txtRule")

	local seatScrView = goutil.findChild(self.mainGO, "seatCol/scrView")
	local seatScrCell = goutil.findChild(self.mainGO, "seatCol/scrCell")

	self._seatScrollerList = ScrollerList.create(seatScrView, seatScrCell, GameUtil.handler(self._updateSeatCell, self), GameUtil.handler(self._clearSeatCell, self))
	self._petCol_btnFilter = goutil.findChild(self.mainGO, "petCol/btnFilter")
	self._petCol_btnSort = goutil.findChild(self.mainGO, "petCol/btnSort")
	self._petCol_InputC_Search = goutil.findChild(self.mainGO, "petCol/InputC_Search")
	self._petCol_InputC_Search_Clear = goutil.findChild(self.mainGO, "petCol/InputC_Search/BtnClear")

	local petScrView = goutil.findChild(self.mainGO, "petCol/scrView")
	local petScrCell = goutil.findChild(self.mainGO, "petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._inputSearch = self:getInput("petCol/InputC_Search")

	local voteScrView = goutil.findChild(self.mainGO, "voteCol/scrView")
	local voteScrCell = goutil.findChild(self.mainGO, "voteCol/scrCell")

	self._voteScrollerList = ScrollerList.create(voteScrView, voteScrCell, GameUtil.handler(self._updateVoteCell, self), GameUtil.handler(self._clearVoteCell, self))
	self._txtCountInVote = goutil.findChildTextComponent(self.mainGO, "voteCol/txtCount")
	self._btnSureInVote = goutil.findChild(self.mainGO, "voteCol/btnSure")
	self._txtBtnSureInVote = goutil.findChildTextComponent(self.mainGO, "voteCol/btnSure/txt")
	self._notCanVote = goutil.findChild(self.mainGO, "voteCol/notCanVote")
	self._tagInNotCanVote = goutil.findChild(self.mainGO, "voteCol/notCanVote/tag")
	self._btnSureInNotCanVote = goutil.findChild(self.mainGO, "voteCol/notCanVote/btnSureInNot")
end

function PTEliBanPetView:bindEvents()
	PTEliBanPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSureInVote, self._onClickBtnSureInVote, self)
	GameUtil.addClickHandler(self._btnSureInNotCanVote, self._onClickBtnSureInVote, self)
	GameUtil.addClickHandler(self._petCol_InputC_Search, self._OnSearchTextChanged, self)
	GameUtil.addClickHandler(self._petCol_InputC_Search_Clear, self._onClearSearch, self)
	GameUtil.addClickHandler(self._petCol_btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._petCol_btnSort, self._onClickSort, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
end

function PTEliBanPetView:unbindEvents()
	PTEliBanPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSureInVote)
	GameUtil.rmClickHandler(self._btnSureInNotCanVote)
	GameUtil.rmClickHandler(self._petCol_InputC_Search)
	GameUtil.rmClickHandler(self._petCol_InputC_Search_Clear)
	GameUtil.rmClickHandler(self._petCol_btnFilter)
	GameUtil.rmClickHandler(self._petCol_btnSort)
	self._inputSearch:RemoveOnValueChanged()
end

function PTEliBanPetView:onEnter()
	PTEliBanPetView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._banPetData = PeakTournamentConfig.instance:getPtBanPetData(self._activityId)
	self._playerBanRaceIdCount = self._banPetData.playerBanRaceIdCount
	self._banRaceIdCount = self._banPetData.banRaceIdCount
	self._maxSelectPetCount = self._playerBanRaceIdCount
	self._raceIdAndVotes = {}
	self._selfBanRaceIds = {}
	self._selfBanRaceIdDic = {}

	self.addGEvent(self, GlobalNotify.PeakTournamentBanPetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PeakTournamentBanPetRes, self._handlePeakTournamentBanPetRes, self)
	PeakTournamentController.instance:sendPM_PeakTournamentBanPetInfoReq(self._activityId)
end

function PTEliBanPetView:onExit()
	PTEliBanPetView.super.onExit(self)
	self:_onClear()
end

function PTEliBanPetView:_handlePeakTournamentBanPetRes()
	FloatWordMgr.instance:show("投票完成")
	PeakTournamentController.instance:sendPM_PeakTournamentBanPetInfoReq(self._activityId)
end

function PTEliBanPetView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function PTEliBanPetView:_onClear()
	self:_onClearSeatCol()
	self:_onClearPetCol()
	self:_onClearVoteCol()
end

function PTEliBanPetView:_onUpdateData()
	self._notBanRaceIdDic = {}

	local notBanCfg = PeakTournamentConfig.instance:getPtNotBanPetCfg(self._activityId)

	if notBanCfg then
		for _, v in pairs(notBanCfg) do
			self._notBanRaceIdDic[v.raceId] = true
		end
	end

	local banRaceIds = PeakTournamentModel.instance:getBanRaceIds()

	for _, raceId in pairs(banRaceIds) do
		self._notBanRaceIdDic[raceId] = true
	end

	self._allPetMoList = {}

	local raceIdList = PetbookModel.instance:getRaceIdListWithPTEliBan()

	for _, raceId in pairs(raceIdList) do
		if self._notBanRaceIdDic[raceId] == nil then
			local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, raceId)

			table.insert(self._allPetMoList, tmpMo)
		end
	end

	self._banPetInfo = PeakTournamentModel.instance:getBanPetInfo()

	if self._banPetInfo then
		self._raceIdAndVotes = self._banPetInfo.raceIdAndVote or {}
	end

	if self._banPetInfo then
		self._selfBanRaceIds = self._banPetInfo.selfBanRaceIds or {}
	end

	table.clear(self._selectPetList)
	table.insertto(self._selectPetList, self._selfBanRaceIds)

	self._selfBanRaceIdDic = {}

	for _, raceId in pairs(self._selectPetList) do
		self._selfBanRaceIdDic[raceId] = true
	end

	self._topRaceIdList = {}

	for idx = 1, self._banRaceIdCount do
		if self._raceIdAndVotes[idx] then
			if not self._raceIdAndVotes[idx].left then
				self._topRaceIdList[idx] = 0
			end
		end
	end

	self._viewPetMoList = {}
end

function PTEliBanPetView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateSeatColUI()
	self:_onUpdatePetColUI()
	self:_onUpdateVoteColUI()
end

function PTEliBanPetView:_onUpdatePlaneUI()
	local voteTimeStart, voteTimeEnd = PeakTournamentController.instance:getStartAndEndTimeStrAsPTBanPet(self._activityId)

	self._txtVoteTime.text = GameUtil.getFormatTimeByStamp(GameUtil.string2time(voteTimeStart), GameUtil.string2time(voteTimeEnd))
end

function PTEliBanPetView:setPetToList(raceId, isAdd)
	if isAdd then
		if self._maxSelectPetCount == 1 then
			table.clear(self._selectPetList)
			table.insert(self._selectPetList, raceId)
		else
			local isHave = self:isHasSelectThePet(raceId)
			local isFull = self:isFullOfTheList()

			if not isHave and not isFull then
				table.insert(self._selectPetList, raceId)
			end
		end
	else
		table.removebyvalue(self._selectPetList, raceId)
	end
end

function PTEliBanPetView:isHasSelectThePet(raceId)
	return table.indexof(self._selectPetList, raceId) ~= false
end

function PTEliBanPetView:isFullOfTheList()
	return #self._selectPetList >= self._maxSelectPetCount
end

function PTEliBanPetView:_getVote(raceId)
	return PeakTournamentModel.instance:getVoteOfBanPet(raceId)
end

function PTEliBanPetView:_onUpdateSeatColUI()
	local list = {}

	for idx = 1, self._banRaceIdCount do
		list[idx] = idx
	end

	self._seatScrollerList:reloadData(list)
end

function PTEliBanPetView:_onClearSeatCol()
	self._seatScrollerList:dispose()
end

function PTEliBanPetView:_updateSeatCell(view, cell, idx, tag)
	local raceId = self._topRaceIdList[idx]
	local voteValue = self:_getVote(raceId)
	local isHaveRace = raceId > 0
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")
	local empty = goutil.findChild(mainGo, "pet/empty")
	local vote = goutil.findChild(mainGo, "vote")
	local txtVote = goutil.findChildTextComponent(mainGo, "vote/txt")

	GameUtil.SetActive(empty, not isHaveRace)
	GameUtil.SetActive(vote, isHaveRace)

	txtVote.text = voteValue

	if raceId > 0 then
		MaterialMgr.setIcon(con, MatType.Pet, raceId, nil, nil)
		GameUtil.addClickHandler(pet, function()
			local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, raceId)

			CommonTipsMgr.instance:showPetTips(tmpMo, true)
		end)
	else
		MaterialMgr.clearIcon(con)
		GameUtil.rmClickHandler(pet)
	end
end

function PTEliBanPetView:_clearSeatCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
end

function PTEliBanPetView:_onUpdatePetColUI()
	self._viewPetMoList = self._viewPetMoList or {}

	if self._allPetMoList then
		table.clear(self._viewPetMoList)

		for k, v in pairs(self._allPetMoList) do
			if self:onFilter(v) then
				table.insert(self._viewPetMoList, v)
			end
		end
	end

	self:sortBagPetMoList()
	self:_updatePetScrollview()
end

function PTEliBanPetView:_updatePetScrollview()
	self._petScrollerList:reloadData(self._viewPetMoList or {})

	if not self._selectPetViewIndex then
		local idx = 0
		local isMotion = true

		self._petScrollerList:MoveCellInView(idx, isMotion)
	end
end

function PTEliBanPetView:_onClearPetCol()
	self._petScrollerList:dispose()
end

function PTEliBanPetView:onRefreshPetSort(idx, onResetCallback)
	BagModel.instance:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, BagModel.instance:GetSortState())
	self:sortBagPetMoList()

	self._selectPetViewIndex = 0

	self:_updatePetScrollview()
end

function PTEliBanPetView:sortBagPetMoList()
	table.sort(self._viewPetMoList, function(a, b)
		local aRaceId = a:getDefineId()
		local bRaceId = b:getDefineId()
		local aVote = PeakTournamentModel.instance:getVoteOfBanPet(aRaceId)
		local bVote = PeakTournamentModel.instance:getVoteOfBanPet(bRaceId)

		if aVote ~= bVote then
			return bVote < aVote
		end

		if a:getRare() ~= b:getRare() then
			return a:getRare() > b:getRare()
		end

		return bRaceId < aRaceId
	end)
end

function PTEliBanPetView:onFilter(pet)
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

function PTEliBanPetView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, cfg, rare, skinId)
end

function PTEliBanPetView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._petCol_btnFilter)

	local function func()
		self._selectPetViewIndex = 0

		self:_onUpdatePetColUI()
	end

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, func)
end

function PTEliBanPetView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._petCol_btnSort)
	local arr = BagModel.instance:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self.onRefreshPetSort, self))
end

function PTEliBanPetView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function PTEliBanPetView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_onUpdatePetColUI()
	end
end

function PTEliBanPetView:_onClearSearch()
	self._inputSearch.input.text = ""
end

function PTEliBanPetView:_updatePetCell(view, cell, petMo, tag)
	local mainGo = cell.gameObject
	local raceId = petMo:getDefineId()
	local skinId = petMo.curFaceId
	local petName = petMo:getName()
	local isSelected = self:isHasSelectThePet(raceId)
	local voteValue = self:_getVote(raceId)
	local isHasVote = self._selfBanRaceIdDic[raceId] == true
	local img = goutil.findChild(mainGo, "img")
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")
	local voteTag = goutil.findChild(mainGo, "voteTag")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	GameUtil.SetActive(imgSelected, isSelected)
	GameUtil.SetActive(voteTag, isHasVote)

	txtName.text = voteValue

	MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)
	GameUtil.addClickHandler(pet, function()
		CommonTipsMgr.instance:showPetTips(petMo, true)
	end)

	local result, tips = self:_getTrySelectPetResultAndTips(self._activityId, raceId)

	if result == GameEnum.ResultCode.Success or result == GameEnum.ResultCode.NotPass then
		img:GetComponent(ComponentType.Image).raycastTarget = true

		GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickPetCell, self, cell.index, raceId))
	else
		img:GetComponent(ComponentType.Image).raycastTarget = false

		GameUtil.rmClickHandler(mainGo)
	end
end

function PTEliBanPetView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
	GameUtil.rmClickHandler(mainGo)
end

function PTEliBanPetView:_clickPetCell(index, raceId)
	local result, tips = self:_getTrySelectPetResultAndTips(self._activityId, raceId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local isSelected = self:isHasSelectThePet(raceId)

	self:setPetToList(raceId, not isSelected)

	self._selectPetViewIndex = index

	self:_onUpdateUI()
end

function PTEliBanPetView:_onUpdateVoteColUI()
	local list = {}

	for idx = 1, self._maxSelectPetCount do
		table.insert(list, idx)
	end

	self._voteScrollerList:reloadData(list)

	self._txtCountInVote.text = #self._selectPetList < self._maxSelectPetCount and string.format("<color=#24d58b>%s</color>/%s", #self._selectPetList, self._maxSelectPetCount) or string.format("%s/%s", #self._selectPetList, self._maxSelectPetCount)

	local isCanBanPet = self:_isCanBanPet()
	local isHaveVote = self:_isHaveVoteOfBanPet()

	GameUtil.SetGray(self._btnSureInVote, isHaveVote)

	self._txtBtnSureInVote.text = isHaveVote and "已投票" or "投票"

	GameUtil.SetActive(self._btnSureInVote, isCanBanPet)
	GameUtil.SetActive(self._notCanVote, not GameUtil.GetActive(self._btnSureInVote))
	GameUtil.SetGray(self._btnSureInNotCanVote, true)
end

function PTEliBanPetView:_onClearVoteCol()
	self._voteScrollerList:dispose()
end

function PTEliBanPetView:_updateVoteCell(view, cell, idx, tag)
	local raceId = checknumber(self._selectPetList[idx])
	local skinId = raceId
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")
	local empty = goutil.findChild(mainGo, "pet/empty")

	if raceId > 0 then
		MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)
		GameUtil.addClickHandler(pet, function()
			for viewIndex, petMo in ipairs(self._viewPetMoList) do
				if petMo:getDefineId() == raceId then
					self._selectPetViewIndex = viewIndex - 1

					break
				end
			end

			self:_updatePetScrollview()
		end)
	else
		MaterialMgr.clearIcon(con)
		GameUtil.rmClickHandler(pet)
	end

	GameUtil.SetActive(empty, raceId <= 0)
end

function PTEliBanPetView:_clearVoteCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
end

function PTEliBanPetView:_onClickBtnTip()
	local key = PeakTournamentConfig.instance:getPtCommonValue("RULEKEY_BANPETTIPS")

	TipsFacade.instance:openRulesView(key)
end

function PTEliBanPetView:_onClickBtnSureInVote()
	local result, tips = self:_getTryVotePetResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local left = Mathf.Max(self._maxSelectPetCount - #self._selectPetList, 0)
	local tipsContent = left > 0 and string.format("当前仍可选择%s只精灵进行投票，是否放弃选择，完成投票？\n<color=#eb4624>确认完成投票后不可更改</color>", left) or "已完成精灵选择，是否确认完成投票？\n<color=#eb4624>确认完成投票后不可更改</color>"

	local function okFunc()
		PeakTournamentController.instance:sendPM_PeakTournamentBanPetReq(self._activityId, self._selectPetList)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
end

function PTEliBanPetView:_getTrySelectPetResultAndTips(activityId, raceId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:_isInTimePeriodAsPTBanPet(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在投票期限内"
	elseif self:_isHaveVoteOfBanPet(activityId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = "已投票"
	elseif not self:_isCanBanPet(activityId) then
		result = GameEnum.ResultCode.NotPass
		tips = "进入淘汰赛才能投票"
	end

	return result, tips
end

function PTEliBanPetView:_getTryVotePetResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:_isInTimePeriodAsPTBanPet(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在投票期限内"
	elseif self:_isHaveVoteOfBanPet(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "已投票"
	elseif not self:_isCanBanPet(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "进入淘汰赛才能投票"
	elseif #self._selectPetList <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "未选择精灵"
	end

	return result, tips
end

function PTEliBanPetView:_isInTimePeriodAsPTBanPet(activityId)
	local timePeriod = PeakTournamentController.instance:getTimePeriodAsPTBanPet(activityId)

	return timePeriod == GameUtil.inTimePeriod
end

function PTEliBanPetView:_isHaveVoteOfBanPet(activityId)
	return PeakTournamentModel.instance:isHaveVoteOfBanPet()
end

function PTEliBanPetView:_isCanBanPet(activityId)
	local banPetInfo = PeakTournamentModel.instance:getBanPetInfo()

	return checkbool(banPetInfo and banPetInfo.canBanPet)
end

return PTEliBanPetView
