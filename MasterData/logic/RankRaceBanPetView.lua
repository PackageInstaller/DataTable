-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceBanPetView.lua

module("logic.extensions.rankrace.view.RankRaceBanPetView", package.seeall)

local RankRaceBanPetView = class("RankRaceBanPetView", ViewComponent)

function RankRaceBanPetView:buildUI()
	RankRaceBanPetView.super.buildUI(self)

	self._imgBg = self:getGo("imgBg")
	self._imgBg = self:getTxt("imgBg")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._txtVoteTime = self:getTxt("ruleCol/txtVoteTime")
	self._txtRule = self:getTxt("ruleCol/txtRule")

	local seatScrView = self:getGo("seatCol/scrView")
	local seatScrCell = self:getGo("seatCol/scrCell")

	self._seatScrollerList = ScrollerList.create(seatScrView, seatScrCell, GameUtil.handler(self._updateSeatCell, self), GameUtil.handler(self._clearSeatCell, self))
	self._petCol_btnFilter = self:getGo("petCol/btnFilter")
	self._petCol_btnSort = self:getGo("petCol/btnSort")
	self._petCol_InputC_Search = self:getGo("petCol/InputC_Search")
	self._petCol_InputC_Search_Clear = self:getGo("petCol/InputC_Search/BtnClear")

	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._inputSearch = self:getInput("petCol/InputC_Search")

	local voteScrView = self:getGo("voteCol/scrView")
	local voteScrCell = self:getGo("voteCol/scrCell")

	self._voteScrollerList = ScrollerList.create(voteScrView, voteScrCell, GameUtil.handler(self._updateVoteCell, self), GameUtil.handler(self._clearVoteCell, self))
	self._txtCountInVote = self:getTxt("voteCol/txtCount")
	self._strTxtCountInVote = self._txtCountInVote.text
	self._btnSureInVote = self:getGo("voteCol/btnSure")
	self._txtBtnSureInVote = self:getTxt("voteCol/btnSure/txt")
	self._tagHasVote = self:getGo("voteCol/tagHasVote")
end

function RankRaceBanPetView:bindEvents()
	RankRaceBanPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSureInVote, self._onClickBtnSureInVote, self)
	GameUtil.addClickHandler(self._petCol_InputC_Search, self._OnSearchTextChanged, self)
	GameUtil.addClickHandler(self._petCol_InputC_Search_Clear, self._onClearSearch, self)
	GameUtil.addClickHandler(self._petCol_btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._petCol_btnSort, self._onClickSort, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
end

function RankRaceBanPetView:unbindEvents()
	RankRaceBanPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSureInVote)
	GameUtil.rmClickHandler(self._petCol_InputC_Search)
	GameUtil.rmClickHandler(self._petCol_InputC_Search_Clear)
	GameUtil.rmClickHandler(self._petCol_btnFilter)
	GameUtil.rmClickHandler(self._petCol_btnSort)
	self._inputSearch:RemoveOnValueChanged()
end

function RankRaceBanPetView:onEnter()
	RankRaceBanPetView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._viewType = params[2]

	if self._seasonId <= 0 then
		self:close()

		return
	end

	self._banRaceIdCount = RankRaceConfig.instance:getRankCommonValue("BAN_RACE_COUNT", true)
	self._startStampVote, self._endStampVote = RankRaceController.instance:getBanPetTimeStamp(self._seasonId)
	self._notBanRaceIdDic = {}

	local notBanCfg = RankRaceConfig.instance:getNoBanRaceCfg(self._seasonId)

	if notBanCfg then
		for _, v in pairs(notBanCfg) do
			self._notBanRaceIdDic[v.raceId] = true
		end
	end

	self._allPetMoList = {}

	local raceIdList = PetbookModel.instance:getRaceIdListWithPTEliBan()

	for _, raceId in pairs(raceIdList) do
		if self._notBanRaceIdDic[raceId] == nil then
			local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, raceId)

			table.insert(self._allPetMoList, tmpMo)
		end
	end

	self._raceIdAndVotes = {}
	self._selfBanRaceIds = {}
	self._selfBanRaceIdDic = {}
	self._selectPetList = {}
	self._viewPetMoList = {}
	self._topRaceIdList = {}
	self._banPetVotes = {}

	self.addGEvent(self, GlobalNotify.HandleRM_GetBanPetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandleRM_BanPetRes, self._handleRM_BanPetRes, self)

	self._txtVoteTime.text = GameUtil.getFormatTimeByStamp(self._startStampVote, self._endStampVote)

	RankRaceController.instance:sendRM_GetBanPetInfoReq(self._seasonId)
end

function RankRaceBanPetView:onExit()
	RankRaceBanPetView.super.onExit(self)
	self:_onClear()
	table.clear(self._allPetMoList)
	table.clear(self._notBanRaceIdDic)
	table.clear(self._raceIdAndVotes)
	table.clear(self._selfBanRaceIds)
	table.clear(self._selfBanRaceIdDic)
	table.clear(self._selectPetList)
	table.clear(self._viewPetMoList)
	table.clear(self._topRaceIdList)
	table.clear(self._banPetVotes)
end

function RankRaceBanPetView:_handleRM_BanPetRes()
	FloatWordMgr.instance:show("投票完成")
	RankRaceController.instance:sendRM_GetBanPetInfoReq(self._seasonId)
end

function RankRaceBanPetView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function RankRaceBanPetView:_onClear()
	self:_onClearSeatCol()
	self:_onClearPetCol()
	self:_onClearVoteCol()
end

function RankRaceBanPetView:_onUpdateData()
	self._openRankingMatchData = RankRaceController.instance:getOpenRankingMatchData(self._viewType)

	local msg = RankRaceController.instance:getBanPetInfoResMsg(self._seasonId)

	if msg then
		self._raceIdAndVotes = msg.raceIdAndVote or {}
	end

	if msg then
		self._selfBanRaceIds = msg.selfBanRaceIds or {}
	end

	MmUtil.coverList(self._selectPetList, self._selfBanRaceIds)
	table.clear(self._selfBanRaceIdDic)

	for _, raceId in pairs(self._selectPetList) do
		self._selfBanRaceIdDic[raceId] = true
	end

	table.clear(self._topRaceIdList)

	for idx = 1, self._banRaceIdCount do
		if self._raceIdAndVotes[idx] then
			if not self._raceIdAndVotes[idx].left then
				self._topRaceIdList[idx] = 0
			end
		end
	end

	table.clear(self._banPetVotes)

	for _, v in ipairs(self._raceIdAndVotes) do
		self._banPetVotes[v.left] = v.right
	end

	table.clear(self._viewPetMoList)
end

function RankRaceBanPetView:_onUpdateUI()
	self:_onUpdateSeatColUI()
	self:_onUpdatePetColUI()
	self:_onUpdateVoteColUI()
end

function RankRaceBanPetView:setPetToList(raceId, isAdd)
	if isAdd then
		if self._banRaceIdCount == 1 then
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

function RankRaceBanPetView:isHasSelectThePet(raceId)
	return table.indexof(self._selectPetList, raceId) ~= false
end

function RankRaceBanPetView:isFullOfTheList()
	return #self._selectPetList >= self._banRaceIdCount
end

function RankRaceBanPetView:_getVote(raceId)
	return self._banPetVotes[raceId] or 0
end

function RankRaceBanPetView:_onUpdateSeatColUI()
	self._seatScrollerList:reloadData(self._topRaceIdList)
end

function RankRaceBanPetView:_onClearSeatCol()
	self._seatScrollerList:dispose()
end

function RankRaceBanPetView:_updateSeatCell(view, cell, raceId, tag)
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

function RankRaceBanPetView:_clearSeatCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
end

function RankRaceBanPetView:_onUpdatePetColUI()
	table.clear(self._viewPetMoList)

	if self._allPetMoList then
		for k, v in pairs(self._allPetMoList) do
			if self:onFilter(v) then
				table.insert(self._viewPetMoList, v)
			end
		end
	end

	self:sortBagPetMoList()
	self:_updatePetScrollview()
end

function RankRaceBanPetView:_updatePetScrollview()
	self._petScrollerList:reloadData(self._viewPetMoList)

	if not self._selectPetViewIndex then
		self._petScrollerList:MoveCellInView(self._selectPetViewIndex, true)
	end
end

function RankRaceBanPetView:_onClearPetCol()
	self._petScrollerList:dispose()
end

function RankRaceBanPetView:onRefreshPetSort(idx, onResetCallback)
	BagModel.instance:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, BagModel.instance:GetSortState())
	self:sortBagPetMoList()

	self._selectPetViewIndex = 0

	self:_updatePetScrollview()
end

function RankRaceBanPetView:sortBagPetMoList()
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

function RankRaceBanPetView:onFilter(pet)
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

function RankRaceBanPetView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, cfg, rare, skinId)
end

function RankRaceBanPetView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._petCol_btnFilter)

	local function func()
		self._selectPetViewIndex = 0

		self:_onUpdatePetColUI()
	end

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PETVIEW, pos, sizeDelta, func)
end

function RankRaceBanPetView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._petCol_btnSort)
	local arr = BagModel.instance:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self.onRefreshPetSort, self))
end

function RankRaceBanPetView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function RankRaceBanPetView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_onUpdatePetColUI()
	end
end

function RankRaceBanPetView:_onClearSearch()
	self._inputSearch.input.text = ""
end

function RankRaceBanPetView:_updatePetCell(view, cell, petMo, tag)
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

	local result = self:_getTrySelectPetResultAndTips(false, raceId)

	if result == GameEnum.ResultCode.Success then
		img:GetComponent(ComponentType.Image).raycastTarget = true

		GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickPetCell, self, cell.index, raceId))
	else
		img:GetComponent(ComponentType.Image).raycastTarget = false

		GameUtil.rmClickHandler(mainGo)
	end
end

function RankRaceBanPetView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
	GameUtil.rmClickHandler(mainGo)
end

function RankRaceBanPetView:_clickPetCell(index, raceId)
	local result, tips = self:_getTrySelectPetResultAndTips(true, raceId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local isSelected = self:isHasSelectThePet(raceId)

	self:setPetToList(raceId, not isSelected)

	self._selectPetViewIndex = index

	self:_onUpdateUI()
end

function RankRaceBanPetView:_onUpdateVoteColUI()
	local list = {}

	for idx = 1, self._banRaceIdCount do
		table.insert(list, idx)
	end

	self._voteScrollerList:reloadData(list)

	self._txtCountInVote.text = #self._selectPetList < self._banRaceIdCount and string.format(self._strTxtCountInVote, #self._selectPetList, self._banRaceIdCount) or string.format("%s/%s", #self._selectPetList, self._banRaceIdCount)

	local result = self:_getTryVotePetResultAndTips(false, self._seasonId)
	local isHaveVote = self:_isHaveVoteOfBanPet()
	local isEnoughVoteOfBanPet = self:_isEnoughVoteOfBanPet()

	self._txtBtnSureInVote.text = isHaveVote and "已投票" or "投票"

	GameUtil.SetGray(self._btnSureInVote, result ~= GameEnum.ResultCode.Success)
	GameUtil.SetActive(self._tagHasVote, isHaveVote)
end

function RankRaceBanPetView:_onClearVoteCol()
	self._voteScrollerList:dispose()
end

function RankRaceBanPetView:_updateVoteCell(view, cell, idx, tag)
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

function RankRaceBanPetView:_clearVoteCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
end

function RankRaceBanPetView:_onClickBtnTip()
	local key = RankRaceConfig.instance:getRankCommonValue("BAN_PET_RULE_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

function RankRaceBanPetView:_onClickBtnSureInVote()
	local result = self:_getTryVotePetResultAndTips(true, self._seasonId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local left = Mathf.Max(self._banRaceIdCount - #self._selectPetList, 0)
	local tipsContent = left > 0 and string.format("当前仍可选择%s只精灵进行投票，是否放弃选择，完成投票？\n<color=#eb4624>确认完成投票后不可更改</color>", left) or "已完成精灵选择，是否确认完成投票？\n<color=#eb4624>确认完成投票后不可更改</color>"

	local function okFunc()
		RankRaceController.instance:sendRM_BanPetReq(self._seasonId, self._selectPetList)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
end

function RankRaceBanPetView:_getTrySelectPetResultAndTips(isNeedTips, raceId)
	local result = GameEnum.ResultCode.Success
	local tips

	if not self:_isInTimePeriodAsPTBanPet() then
		result = GameEnum.ResultCode.Error
		tips = isNeedTips and "不在投票期限内"
	elseif self:_isHaveVoteOfBanPet() then
		result = GameEnum.ResultCode.IsHasGain
		tips = isNeedTips and "已投票"
	elseif not self:_isEnoughVoteOfBanPet() then
		result = GameEnum.ResultCode.IsHasGain
		tips = isNeedTips and "赛季段位不满足投票条件"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function RankRaceBanPetView:_getTryVotePetResultAndTips(isNeedTips)
	local result = GameEnum.ResultCode.Success
	local tips

	if not self:_isInTimePeriodAsPTBanPet() then
		result = GameEnum.ResultCode.Error
		tips = isNeedTips and "不在投票期限内"
	elseif self:_isHaveVoteOfBanPet() then
		result = GameEnum.ResultCode.Error
		tips = isNeedTips and "已投票"
	elseif not self:_isEnoughVoteOfBanPet() then
		result = GameEnum.ResultCode.IsHasGain
		tips = isNeedTips and "赛季段位不满足投票条件"
	elseif #self._selectPetList <= 0 then
		result = GameEnum.ResultCode.Error
		tips = isNeedTips and "未选择精灵"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function RankRaceBanPetView:_isInTimePeriodAsPTBanPet()
	local timePeriod = GameUtil.getTimePeriodTypeBySec(self._startStampVote, self._endStampVote)

	return timePeriod == GameUtil.inTimePeriod
end

function RankRaceBanPetView:_isHaveVoteOfBanPet()
	return #self._selfBanRaceIds > 0
end

function RankRaceBanPetView:_isEnoughVoteOfBanPet()
	return RankRaceController.instance:isEnoughVoteOfBanPet()
end

return RankRaceBanPetView
