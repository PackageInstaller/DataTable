-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdReportBaseView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdReportBaseView", package.seeall)

local YouthArenaThirdReportBaseView = class("YouthArenaThirdReportBaseView", ViewComponent)
local EMPTY_TEXT = ""
local UNKNOWN_ZDL_TEXT = "--"
local UNKNOWN_SCORE_TEXT = "--"
local PLAYER_SCORE_TEXT = "本局积分：<color=#20b376>%s</color>"
local PET_CELL_COUNT = 6
local THREE_ROUND_COUNT = 3
local UNKNOWN_NAME_TEXT = "--"
local UNKNOWN_TIME_TEXT = "时间：--"
local ExpandedRowKeyCache = {}
local SelectedModeCache = {}
local SIDE_POLICY = {
	BackendOrder = 2,
	SelfLeft = 1
}
local TAB_DATA_LIST = {
	{
		tabName = "1v1",
		mode = YouthArenaThirdEnum.BattleMode.One
	},
	{
		tabName = "3v3",
		mode = YouthArenaThirdEnum.BattleMode.Three
	}
}
local SCORE_MATCH_TAB_DATA_LIST = {
	{
		tabName = "1v1攻阵战报",
		mode = 1
	},
	{
		tabName = "3v3攻阵战报",
		mode = 2
	},
	{
		tabName = "1v1守阵战报",
		mode = 3
	},
	{
		tabName = "3v3守阵战报",
		mode = 4
	}
}
local QUALIFIER_REPORT_BATTLE_MODE = {
	YouthArenaThirdEnum.BattleMode.One,
	YouthArenaThirdEnum.BattleMode.Three,
	YouthArenaThirdEnum.BattleMode.One,
	YouthArenaThirdEnum.BattleMode.Three
}
local DEFENSE_REPORT_MODE = {
	[3] = true,
	[4] = true
}
local MODE_NAME = {
	[YouthArenaThirdEnum.BattleMode.One] = "1v1",
	[YouthArenaThirdEnum.BattleMode.Three] = "3v3"
}

local function _battleResultByWinCount(leftWinCount, rightWinCount)
	leftWinCount = checknumber(leftWinCount)
	rightWinCount = checknumber(rightWinCount)

	if rightWinCount < leftWinCount then
		return GameEnum.BattleResult.Success
	elseif leftWinCount < rightWinCount then
		return GameEnum.BattleResult.Failed
	end

	return GameEnum.BattleResult.DogFall
end

local function _battleResultByScore(leftScore, rightScore, leftWinCount, rightWinCount)
	leftScore = checknumber(leftScore)
	rightScore = checknumber(rightScore)

	if rightScore < leftScore then
		return GameEnum.BattleResult.Success
	elseif leftScore < rightScore then
		return GameEnum.BattleResult.Failed
	end

	return _battleResultByWinCount(leftWinCount, rightWinCount)
end

local function _battleResultByWinnerId(winPlayerId, leftUserId)
	winPlayerId = checknumber(winPlayerId)
	leftUserId = checknumber(leftUserId)

	if winPlayerId <= 0 then
		return GameEnum.BattleResult.DogFall
	end

	return (winPlayerId == leftUserId or nil) and (GameEnum.BattleResult.Success or GameEnum.BattleResult.Failed)
end

local function _invertBattleResult(battleResult)
	if battleResult == GameEnum.BattleResult.Success then
		return GameEnum.BattleResult.Failed
	elseif battleResult == GameEnum.BattleResult.Failed then
		return GameEnum.BattleResult.Success
	end

	return GameEnum.BattleResult.DogFall
end

local function _formatZdl(zdl)
	local value = checknumber(zdl)

	return value > 0 and tostring(value) or UNKNOWN_ZDL_TEXT
end

local function _formatScore(score)
	if score == nil then
		return UNKNOWN_SCORE_TEXT
	end

	return tostring(checknumber(score))
end

local function _getRoleSide()
	local var_7_0 = {
		isSelf = true,
		userId = checknumber(RoleModel.instance:getUserId())
	}

	var_7_0.name = RoleModel.instance:getUserName() or UNKNOWN_NAME_TEXT
	var_7_0.areaId = checknumber(RoleModel.instance:getAreaId())
	var_7_0.zdl = checknumber(RoleModel.instance:getMaxPower())

	return var_7_0
end

local function _getHeadInfoFromPlayerDetail(detail)
	local playerHeadInfo = detail and detail.headInfo
	local var_8_0

	if playerHeadInfo then
		::label_8_0::

		var_8_0 = playerHeadInfo.headInfo or playerHeadInfo
	end

	return var_8_0
end

local function _buildSideByHeadInfo(headInfo, zdl)
	local var_9_0 = {
		userId = checknumber(headInfo and headInfo.userId),
		headInfo = headInfo
	}

	if headInfo then
		var_9_0.name = headInfo.userName or UNKNOWN_NAME_TEXT
	end

	var_9_0.areaId = checknumber(headInfo and headInfo.areaId)
	var_9_0.zdl = checknumber(zdl)

	return var_9_0
end

local function _buildSideByPlayerDetail(detail)
	return _buildSideByHeadInfo(_getHeadInfoFromPlayerDetail(detail), detail and detail.zdl)
end

local function _buildSideWithScore(side, score)
	local ret = {}

	for k, v in pairs(side or {}) do
		ret[k] = v
	end

	ret.score = score

	return ret
end

local function _getPlayerUserIdString(detail)
	return tostring(_getHeadInfoFromPlayerDetail(detail) and _getHeadInfoFromPlayerDetail(detail).userId or "")
end

local function _copyList(list)
	local ret = {}

	for _, v in ipairs(list or {}) do
		table.insert(ret, v)
	end

	return ret
end

local function _buildRoundSide(raceIds, formZdl, petCells)
	return {
		raceIds = _copyList(raceIds),
		formZdl = checknumber(formZdl),
		petCells = petCells
	}
end

local function _buildRound(index, battleId, battleResult, played, left, right)
	return {
		index = index,
		battleId = checknumber(battleId),
		battleResult = battleResult,
		played = played ~= false,
		left = left,
		right = right
	}
end

local function _buildRow(mode, time, left, right, rounds, battleResult, showScore, reportMode)
	return {
		expanded = false,
		mode = mode,
		reportMode = checknumber(reportMode),
		time = checknumber(time),
		left = left,
		right = right,
		rounds = rounds or {},
		result = {
			battleResult = battleResult
		},
		showScore = showScore ~= false
	}
end

local function _getVideoBattleId(row, battleId)
	local videoBattleId = checknumber(battleId)

	if videoBattleId == 0 then
		return 0
	end

	if DEFENSE_REPORT_MODE[checknumber(row and row.reportMode)] then
		return -math.abs(videoBattleId)
	end

	return videoBattleId
end

local function _padThreeRounds(rounds)
	while #rounds < THREE_ROUND_COUNT do
		local index = #rounds + 1

		table.insert(rounds, _buildRound(index, 0, GameEnum.BattleResult.DogFall, false, _buildRoundSide(), _buildRoundSide()))
	end

	return rounds
end

function YouthArenaThirdReportBaseView:ctor()
	YouthArenaThirdReportBaseView.super.ctor(self)
end

function YouthArenaThirdReportBaseView.resetReportStateCache()
	ExpandedRowKeyCache = {}
	SelectedModeCache = {}
end

function YouthArenaThirdReportBaseView:buildUI()
	YouthArenaThirdReportBaseView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tagEmpty = self:getGo("tagEmpty")
	self._tabScrView = self:getGo("tabScrView")
	self._tabScrCell = self:getGo("tabScrCell")
	self._scrCell = self:getGo("recordCol/scrCell")
	self._scrView = self:getGo("recordCol/scrView")
	self._reportScrollerList = ScrollerList.create(self._scrView, self._scrCell, GameUtil.handler(self._updateReportCell, self), GameUtil.handler(self._clearTableCell, self))

	self._reportScrollerList:regGetCellSize(GameUtil.handler(self._getReportCellSize, self))

	self._tabScrollList = ScrollerList.create(self._tabScrView, self._tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._rows = {}
	self._cellBinders = setmetatable({}, {
		__mode = "k"
	})
	self._petScrollerListDic = {}
	self._tipPetMoDic = {}

	self:_readPrefabSizes()
	goutil.setActive(self._scrCell, false)
end

function YouthArenaThirdReportBaseView:bindEvents()
	YouthArenaThirdReportBaseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function YouthArenaThirdReportBaseView:unbindEvents()
	YouthArenaThirdReportBaseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function YouthArenaThirdReportBaseView:onEnter()
	YouthArenaThirdReportBaseView.super.onEnter(self)

	self._rows = {}

	self:_ensureCurMode()
	self:_refreshTabs()
	self:requestReportData(self._curMode)
	self:_refreshRows()
end

function YouthArenaThirdReportBaseView:onExit()
	YouthArenaThirdReportBaseView.super.onExit(self)
	self._reportScrollerList:dispose()
	self._tabScrollList:dispose()
	self:_disposePetScrollerLists()

	self._rows = {}
	self._tipPetMoDic = {}
end

function YouthArenaThirdReportBaseView:_refreshRows()
	local isReady = self:isReportDataReady(self._curMode)
	local hasFailed = self:hasReportRequestFailed(self._curMode)
	local rows = isReady and self:buildReportRows(self._curMode) or {}

	self:setReportRows(rows, isReady and not hasFailed)
end

function YouthArenaThirdReportBaseView:getInitialMode()
	return YouthArenaThirdEnum.BattleMode.One
end

function YouthArenaThirdReportBaseView:getTabDataList()
	if self._stepId == YouthArenaThirdEnum.MatchStepId.ScoreMatch then
		return SCORE_MATCH_TAB_DATA_LIST
	end

	return TAB_DATA_LIST
end

function YouthArenaThirdReportBaseView:requestReportData(mode)
	return
end

function YouthArenaThirdReportBaseView:buildReportRows(mode)
	return {}
end

function YouthArenaThirdReportBaseView:isReportDataReady(mode)
	return true
end

function YouthArenaThirdReportBaseView:hasReportRequestFailed(mode)
	return false
end

function YouthArenaThirdReportBaseView:_ensureCurMode()
	self._reportContextKey = self:_getReportCacheScope()
	self._curMode = self:_normalizeMode(SelectedModeCache[self._reportContextKey] or self:getInitialMode())
	SelectedModeCache[self._reportContextKey] = self._curMode
end

function YouthArenaThirdReportBaseView:_rebindReportContext()
	self._reportContextKey = self:_getReportCacheScope()
	SelectedModeCache[self._reportContextKey] = self:_normalizeMode(self._curMode)
end

function YouthArenaThirdReportBaseView:_normalizeMode(mode)
	mode = checknumber(mode)

	if self:_isValidMode(mode) then
		return mode
	end

	local tabDataList = self:getTabDataList()

	return checknumber(tabDataList[1] and tabDataList[1].mode)
end

function YouthArenaThirdReportBaseView:_isValidMode(mode)
	for _, data in ipairs(self:getTabDataList()) do
		if data.mode == mode then
			return true
		end
	end

	return false
end

function YouthArenaThirdReportBaseView:_refreshTabs()
	if self._tabScrollList then
		self._tabScrollList:reloadData(self:getTabDataList())
	end
end

function YouthArenaThirdReportBaseView:_updateTabCell(view, cell, data, tag)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)

	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	if txtName then
		if data then
			txtName.text = data.tabName or ""
		end
	end

	local isSelect = data and data.mode == self._curMode

	GameUtil.setUIGroupIdx(cell, isSelect and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data))
end

function YouthArenaThirdReportBaseView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function YouthArenaThirdReportBaseView:_onClickTab(data)
	local mode = data and data.mode

	if not self:_isValidMode(mode) or mode == self._curMode then
		return
	end

	self._curMode = mode
	SelectedModeCache[self._reportContextKey or self:_getReportCacheScope()] = mode

	self:_refreshTabs()
	self:requestReportData(self._curMode)
	self:_refreshRows()
end

function YouthArenaThirdReportBaseView:_readPrefabSizes()
	local simple = goutil.findChild(self._scrCell, "simple")
	local detailCell = goutil.findChild(self._scrCell, "detail/cell1")

	self._cellWidth = self:_getNodeWidth(self._scrCell, "recordCol/scrCell")
	self._simpleHeight = self:_getNodeHeight(simple, "recordCol/scrCell/simple")
	self._detailRoundHeight = self:_getNodeHeight(detailCell, "recordCol/scrCell/detail/cell1")
end

function YouthArenaThirdReportBaseView:_getNodeWidth(go, nodePath)
	assert(go, string.format("YouthArenaThirdReportBaseView prefab missing node: %s", nodePath))

	local width = checknumber(GameUtil.getWidth(go))

	assert(width > 0, string.format("YouthArenaThirdReportBaseView prefab node width invalid: %s", nodePath))

	return width
end

function YouthArenaThirdReportBaseView:_getNodeHeight(go, nodePath)
	assert(go, string.format("YouthArenaThirdReportBaseView prefab missing node: %s", nodePath))

	local height = checknumber(GameUtil.getHeight(go))

	assert(height > 0, string.format("YouthArenaThirdReportBaseView prefab node height invalid: %s", nodePath))

	return height
end

function YouthArenaThirdReportBaseView:_buildQualifierRows(recordsInfo, mode, stepId)
	local rows = {}
	local left = _getRoleSide()
	local targetMode = QUALIFIER_REPORT_BATTLE_MODE[checknumber(mode)] or YouthArenaThirdEnum.BattleMode.One
	local targetStepId = checknumber(stepId)

	if targetStepId <= 0 then
		return rows
	end

	for _, record in ipairs((recordsInfo or nil) and (recordsInfo.records or {})) do
		if checknumber(record.stepId) == targetStepId then
			local right = _buildSideByHeadInfo(record.opHeadInfo, record.opHistoryMaxZdl)
			local rounds = {}
			local leftWinCount = 0
			local rightWinCount = 0

			for index, round in ipairs(record.roundList or {}) do
				local played = round.played ~= false

				if checkbool(round.isWin) then
					if not GameEnum.BattleResult.Success then
						local battleResult = GameEnum.BattleResult.Failed
						local roundLeft = _buildRoundSide(round.myRaceIds, round.myFormZdl)
						local roundRight = _buildRoundSide(round.opRaceIds, round.opFormZdl)

						if played then
							if checkbool(round.isWin) then
								leftWinCount = leftWinCount + 1
							else
								rightWinCount = rightWinCount + 1
							end
						end

						table.insert(rounds, _buildRound(index, round.battleId, battleResult, played, roundLeft, roundRight))
					end
				end
			end

			if targetMode == YouthArenaThirdEnum.BattleMode.Three then
				_padThreeRounds(rounds)
			end

			local myCurScore = checknumber(record.myCurScore)
			local opCurScore = checknumber(record.opCurScore)
			local battleResult = self._isFun and _battleResultByWinCount(leftWinCount, rightWinCount) or _battleResultByScore(myCurScore, opCurScore, leftWinCount, rightWinCount)
			local showScore = not self._isFun and targetStepId ~= YouthArenaThirdEnum.MatchStepId.ScoreMatch

			table.insert(rows, _buildRow(targetMode, math.floor(checknumber(record.challengeTime) / 1000), _buildSideWithScore(left, record.myCurScore), _buildSideWithScore(right, record.opCurScore), rounds, battleResult, showScore, mode))
		end
	end

	return rows
end

function YouthArenaThirdReportBaseView:_buildChampionRowsByMatch(matchInfo, modeFilter, sidePolicy)
	local rows = {}
	local result = matchInfo and matchInfo.result
	local var_46_0

	if not result then
		do return rows end

		var_46_0 = RoleModel.instance:getUserId() or ""
	end

	local currentUserId = tostring(var_46_0)
	local playerA = matchInfo.playerA
	local playerB = matchInfo.playerB
	local playerBId = _getPlayerUserIdString(playerB)
	local swapped = sidePolicy == SIDE_POLICY.SelfLeft and not string.nilorempty(currentUserId) and currentUserId == playerBId
	local leftDetail = swapped and playerB or playerA
	local rightDetail = swapped and playerA or playerB
	local left = _buildSideByPlayerDetail(leftDetail)
	local right = _buildSideByPlayerDetail(rightDetail)

	local function addRow(rowMode, records, modeBattleResult, leftScore, rightScore)
		if checknumber(modeFilter) > 0 and checknumber(modeFilter) ~= rowMode then
			return
		end

		if not records or #records <= 0 then
			return
		end

		local rounds = {}

		for index, record in ipairs(records or {}) do
			if swapped then
				if not record.playerBRaceIds then
					local recordLeftRaceIds = record.playerARaceIds

					if swapped then
						if not record.playerARaceIds then
							local recordRightRaceIds = record.playerBRaceIds

							if swapped then
								if not record.formBZdl then
									local recordLeftFormZdl = record.formAZdl

									if swapped then
										if not record.formAZdl then
											local recordRightFormZdl = record.formBZdl
											local roundLeft = _buildRoundSide(recordLeftRaceIds, recordLeftFormZdl)
											local roundRight = _buildRoundSide(recordRightRaceIds, recordRightFormZdl)

											table.insert(rounds, _buildRound(index, record.battleId, _battleResultByWinnerId(record.winPlayerId, left.userId), true, roundLeft, roundRight))
										end
									end
								end
							end
						end
					end
				end
			end
		end

		if rowMode == YouthArenaThirdEnum.BattleMode.Three then
			_padThreeRounds(rounds)
		end

		table.insert(rows, _buildRow(rowMode, 0, _buildSideWithScore(left, leftScore), _buildSideWithScore(right, rightScore), rounds, modeBattleResult))

		rows[#rows].matchIndex = checknumber(matchInfo.index)
		rows[#rows].matchRoundId = checknumber(matchInfo.roundId)
	end

	local record1v1 = result.record1v1
	local score1v1A = result.score1v1A
	local score1v1B = result.score1v1B
	local score3v3A = result.score3v3A
	local score3v3B = result.score3v3B
	local score1v1Left = score1v1A
	local score1v1Right = score1v1B
	local score3v3Left = score3v3A
	local score3v3Right = score3v3B

	if swapped then
		score1v1Right = score1v1A
		score1v1Left = score1v1B
		score3v3Right = score3v3A
		score3v3Left = score3v3B
	end

	local left3v3WinCount = 0
	local right3v3WinCount = 0

	for _, record in ipairs(result.records3v3 or {}) do
		local winPlayerId = checknumber(record.winPlayerId)

		if winPlayerId > 0 and winPlayerId == checknumber(left.userId) then
			left3v3WinCount = left3v3WinCount + 1
		elseif winPlayerId > 0 and winPlayerId == checknumber(right.userId) then
			right3v3WinCount = right3v3WinCount + 1
		end
	end

	addRow(YouthArenaThirdEnum.BattleMode.One, record1v1 and {
		record1v1
	} or nil, _battleResultByWinnerId(record1v1 and record1v1.winPlayerId, left.userId), score1v1Left, score1v1Right)
	addRow(YouthArenaThirdEnum.BattleMode.Three, result.records3v3, _battleResultByScore(score3v3Left, score3v3Right, left3v3WinCount, right3v3WinCount), score3v3Left, score3v3Right)

	return rows
end

function YouthArenaThirdReportBaseView:_buildChampionRowsByScheduleInfo(scheduleInfo, modeFilter)
	local rows = {}

	for _, matchInfo in ipairs((scheduleInfo or nil) and (scheduleInfo.groupList or {})) do
		local matchRows = self:_buildChampionRowsByMatch(matchInfo, modeFilter, SIDE_POLICY.BackendOrder)

		for _, row in ipairs(matchRows) do
			table.insert(rows, row)
		end
	end

	return rows
end

function YouthArenaThirdReportBaseView:_buildChampionRowsByMyInfo(myInfo, scheduleInfo, modeFilter)
	local var_49_0

	if not myInfo or not scheduleInfo then
		do return {} end

		var_49_0 = RoleModel.instance:getUserId() or ""
	end

	local myUserId = tostring(var_49_0)
	local roundId = checknumber(myInfo.roundId)

	for _, matchInfo in ipairs(scheduleInfo.groupList or {}) do
		if checknumber(matchInfo.roundId) == roundId then
			local playerAId = _getPlayerUserIdString(matchInfo.playerA)
			local playerBId = _getPlayerUserIdString(matchInfo.playerB)

			if not string.nilorempty(myUserId) and (myUserId == playerAId or myUserId == playerBId) then
				return self:_buildChampionRowsByMatch(matchInfo, modeFilter, SIDE_POLICY.SelfLeft)
			end
		end
	end

	return {}
end

function YouthArenaThirdReportBaseView:setReportRows(rows, showEmpty)
	self._rows = rows or {}

	ArraySort.sortOn(self._rows, "time", ArraySort.DESCENDING)
	self:_applyExpandedCache()
	goutil.setActive(self._tagEmpty, showEmpty == true and #self._rows <= 0)
	self._reportScrollerList:reloadData(self._rows)
end

function YouthArenaThirdReportBaseView:_getReportCellSize(view, idx)
	local row = self._rows[idx + 1]

	return self._cellWidth, self:_getRowHeight(row)
end

function YouthArenaThirdReportBaseView:_getRowHeight(row)
	if row and row.mode == YouthArenaThirdEnum.BattleMode.Three and row.expanded then
		local roundCount = #(row.rounds or {})

		return self._simpleHeight + math.max(roundCount, 1) * self._detailRoundHeight
	end

	return self._simpleHeight
end

function YouthArenaThirdReportBaseView:_updateReportCell(view, cell, row, tag)
	self:_updateTableCell(cell, row)
end

function YouthArenaThirdReportBaseView:_getCellBinder(cell)
	if not cell.gameObject then
		local go = cell

		if self._cellBinders[go] then
			return self._cellBinders[go]
		end

		local binder = {
			go = go,
			simple = goutil.findChild(go, "simple"),
			detail = goutil.findChild(go, "detail")
		}

		binder.btnVideo = goutil.findChild(binder.simple, "btnVideo")
		binder.btnDetail = goutil.findChild(binder.simple, "btnDetail")
		binder.txtTime = goutil.findChildTextComponent(binder.simple, "txtTime")
		binder.imgResult = goutil.findChild(binder.simple, "imgResult")
		binder.imgResultChange = binder.imgResult and binder.imgResult:GetComponent("UIImageSpriteChange")
		binder.left = self:_buildSimpleSide(binder.simple, "left")
		binder.right = self:_buildSimpleSide(binder.simple, "right")
		binder.detailTemplate = goutil.findChild(binder.detail, "cell1")
		binder.detailCells = {}
		self._cellBinders[go] = binder

		return binder
	end
end

function YouthArenaThirdReportBaseView:_buildSimpleSide(root, path)
	local go = goutil.findChild(root, path)

	return {
		go = go,
		head = goutil.findChild(go, "head"),
		txtName = goutil.findChildTextComponent(go, "txtName"),
		txtScore = goutil.findChildTextComponent(go, "txtScore")
	}
end

function YouthArenaThirdReportBaseView:_buildDetailCell(go)
	return {
		go = go,
		leftForm = self:_buildFormCell(goutil.findChild(go, "leftForm")),
		rightForm = self:_buildFormCell(goutil.findChild(go, "rightForm")),
		btnVideo = goutil.findChild(go, "btnVideo")
	}
end

function YouthArenaThirdReportBaseView:_buildFormCell(go)
	local cell = {
		go = go,
		txtTeam = goutil.findChildTextComponent(go, "txtTeam"),
		txtZdl = goutil.findChildTextComponent(go, "txtZdl"),
		tagResult = goutil.findChild(go, "tagResult"),
		petScrView = goutil.findChild(go, "petScrView"),
		petScrCell = goutil.findChild(go, "petScrCell")
	}

	cell.tagResultChange = cell.tagResult and cell.tagResult:GetComponent("UIImageSpriteChange")

	return cell
end

function YouthArenaThirdReportBaseView:_updateTableCell(cell, row)
	local binder = self:_getCellBinder(cell)
	local isThree = row and row.mode == YouthArenaThirdEnum.BattleMode.Three
	local showVideo = not isThree and self:_hasPlayedRound(row) and not self:_isReportVideoExpired(row)
	local rowHeight = self:_getRowHeight(row)

	if row then
		local roundCount = #(row.rounds or {})
		local detailHeight = isThree and row.expanded and math.max(roundCount, 1) * self._detailRoundHeight or 0

		self:_clearTableCell(cell)
		self:_setNodeHeight(binder.go, rowHeight)
		self:_setDetailLayout(binder, detailHeight)

		if not row then
			return
		end

		goutil.setActive(binder.simple, true)
		goutil.setActive(binder.detail, isThree and row.expanded == true)
		goutil.setActive(binder.btnVideo, showVideo)
		goutil.setActive(binder.btnDetail, isThree)
		goutil.setActive(binder.imgResult, row.result ~= nil)

		if binder.txtTime then
			binder.txtTime.text = self:_formatTime(row.time)
		end

		if binder.imgResultChange and row.result then
			binder.imgResultChange:SetState(row.result.battleResult)
		end

		self:_updateSimpleSide(binder.left, row.left, row.showScore)
		self:_updateSimpleSide(binder.right, row.right, row.showScore)
		GameUtil.rmClickHandler(binder.btnVideo)
		GameUtil.rmClickHandler(binder.btnDetail)

		if showVideo then
			GameUtil.addClickHandler(binder.btnVideo, GameUtil.handler(self._onClickVideo, self, row))
		end

		if isThree then
			GameUtil.addClickHandler(binder.btnDetail, GameUtil.handler(self._onClickDetail, self, row, cell.index))
		end

		if isThree and row.expanded then
			self:_updateDetailCells(binder, row)
		end
	end
end

function YouthArenaThirdReportBaseView:_setDetailLayout(binder, detailHeight)
	self:_setNodeHeight(binder.detail, detailHeight)

	local pos = GameUtil.getAnchoredPos(binder.detail)

	GameUtil.setAnchoredPos(binder.detail, (pos or nil) and (pos.x or 0), detailHeight * 0.5)
end

function YouthArenaThirdReportBaseView:_setNodeHeight(go, height)
	if go then
		GameUtil.setHeight(go, height)
	end
end

function YouthArenaThirdReportBaseView:_updateSimpleSide(cell, side, showScore)
	if not cell then
		return
	end

	if side and side.isSelf then
		HeadItemController.instance:setMyHeadCell(cell.head)
	elseif side and side.headInfo then
		HeadItemController.instance:setHeadCellByInfo(cell.head, side.headInfo, true)
	end

	cell.txtName.text = self:_formatName(side)

	goutil.setActive(cell.txtScore.gameObject, showScore == true)

	cell.txtScore.text = string.format(PLAYER_SCORE_TEXT, _formatScore(side and side.score))
end

function YouthArenaThirdReportBaseView:_updateDetailCells(binder, row)
	if not row.rounds then
		for index, round in ipairs(row.rounds) do
			local cell = binder.detailCells[index]

			if not cell then
				if index == 1 then
					if not binder.detailTemplate then
						local go = goutil.cloneAndSetParent(binder.detailTemplate, binder.detailTemplate.transform.parent, string.format("cell%s", index))

						cell = self:_buildDetailCell(go)
						binder.detailCells[index] = cell
					end
				end
			end

			goutil.setActive(cell.go, true)
			self:_setDetailCellLayout(cell.go, index)
			self:_updateOneDetailCell(cell, row, round, index)
		end

		for index = #row.rounds + 1, #binder.detailCells do
			local cell = binder.detailCells[index]

			if cell then
				goutil.setActive(cell.go, false)
			end
		end
	end
end

function YouthArenaThirdReportBaseView:_setDetailCellLayout(go, index)
	local parentHeight = GameUtil.getHeight(go.transform.parent.gameObject)

	self:_setNodeHeight(go, self._detailRoundHeight)
	GameUtil.setAnchoredPos(go, 0, parentHeight - (index - 0.5) * self._detailRoundHeight)
end

function YouthArenaThirdReportBaseView:_updateOneDetailCell(cell, row, round, index)
	local played = round and round.played ~= false
	local showVideo = played and not self:_isReportVideoExpired(row)

	if round then
		if not round.battleResult then
			local leftBattleResult = GameEnum.BattleResult.DogFall

			self:_updateFormCell(cell.leftForm, round.left, index, leftBattleResult, played)
			self:_updateFormCell(cell.rightForm, round.right, index, _invertBattleResult(leftBattleResult), played)
			GameUtil.rmClickHandler(cell.btnVideo)
			goutil.setActive(cell.btnVideo, showVideo)

			if showVideo then
				GameUtil.addClickHandler(cell.btnVideo, GameUtil.handler(self._onClickRoundVideo, self, row, round))
			end
		end
	end
end

function YouthArenaThirdReportBaseView:_updateFormCell(cell, formInfo, index, battleResult, showResult)
	if not cell then
		return
	end

	cell.txtTeam.text = string.format("队伍%s", index)
	cell.txtZdl.text = _formatZdl(formInfo and formInfo.formZdl)

	goutil.setActive(cell.tagResult, showResult == true)

	if cell.tagResultChange and showResult then
		cell.tagResultChange:SetState(battleResult)
	end

	self:_updatePetList(cell, formInfo)
end

function YouthArenaThirdReportBaseView:_updatePetList(cell, formInfo)
	if formInfo then
		if not formInfo.raceIds then
			local raceIds = {}

			if formInfo then
				if not formInfo.petCells then
					local petCells = {}
					local list = {}
					local count = math.max(#raceIds, #petCells, PET_CELL_COUNT)

					for i = 1, count do
						local raceId = checknumber(raceIds[i])

						table.insert(list, {
							raceId = raceId,
							petData = petCells[i]
						})
					end

					local petScrollerList = self._petScrollerListDic[cell.go]

					if petScrollerList == nil then
						petScrollerList = ScrollerList.create(cell.petScrView, cell.petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

						petScrollerList:dragNotifyParent()

						self._petScrollerListDic[cell.go] = petScrollerList
					end

					petScrollerList:reloadData(list)
				end
			end
		end
	end
end

function YouthArenaThirdReportBaseView:_updatePetCell(view, cell, data, tag)
	local pointPet = goutil.findChild(cell.gameObject, "pointPet")
	local proxy

	MaterialMgr.resetAll(pointPet)

	if data and data.petData then
		proxy = MaterialMgr.setCellByData(MatType.Pet, data.petData, pointPet)
	elseif data and data.raceId > 0 then
		proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, pointPet)
	end

	if proxy then
		proxy.binder:setClickCallBack(GameUtil.handler(self._onClickPet, self, data))
	end
end

function YouthArenaThirdReportBaseView:_onClickPet(data)
	if not self._tipPetMoDic[data.raceId] then
		local petMo = data.petData

		if self._tipPetMoDic[data.raceId] == nil and data.raceId > 0 then
			local petCfg = MaterialMgr.getMatCfg(MatType.Pet, data.raceId)

			if petCfg then
				local awakenLv = CharacterConfig.instance:getMaxAwaken(data.raceId)

				petMo = FightingPowerPetMo.createPetByLevel(data.raceId, petCfg.maxLv, awakenLv, data.raceId)
			end
		end

		if self._tipPetMoDic[data.raceId] then
			self._tipPetMoDic[data.raceId].hideZdl = true
			self._tipPetMoDic[data.raceId] = self._tipPetMoDic[data.raceId]

			CommonTipsMgr.instance:showPetTips(self._tipPetMoDic[data.raceId])
		end
	end
end

function YouthArenaThirdReportBaseView:_clearPetCell(cell)
	local pointPet = goutil.findChild(cell.gameObject, "pointPet")

	MaterialMgr.resetAll(pointPet)
end

function YouthArenaThirdReportBaseView:_clearTableCell(cell)
	local binder = self:_getCellBinder(cell)

	GameUtil.rmClickHandler(binder.btnVideo)
	GameUtil.rmClickHandler(binder.btnDetail)
	goutil.setActive(binder.imgResult, false)

	if binder.txtTime then
		binder.txtTime.text = EMPTY_TEXT
	end

	self:_clearSimpleSide(binder.left)
	self:_clearSimpleSide(binder.right)

	for _, detailCell in ipairs(binder.detailCells or {}) do
		GameUtil.rmClickHandler(detailCell.btnVideo)
		self:_clearFormCell(detailCell.leftForm)
		self:_clearFormCell(detailCell.rightForm)
	end
end

function YouthArenaThirdReportBaseView:_clearSimpleSide(cell)
	if not cell then
		return
	end

	HeadItemController.instance:resetHeadCell(cell.head)

	cell.txtName.text = EMPTY_TEXT
	cell.txtScore.text = EMPTY_TEXT

	goutil.setActive(cell.txtScore.gameObject, false)
end

function YouthArenaThirdReportBaseView:_clearFormCell(cell)
	if not cell then
		return
	end

	goutil.setActive(cell.tagResult, false)

	local petScrollerList = self._petScrollerListDic[cell.go]

	if petScrollerList then
		petScrollerList:dispose()

		self._petScrollerListDic[cell.go] = nil
	end
end

function YouthArenaThirdReportBaseView:_disposePetScrollerLists()
	for _, petScrollerList in pairs(self._petScrollerListDic or {}) do
		petScrollerList:dispose()
	end

	self._petScrollerListDic = {}
end

function YouthArenaThirdReportBaseView:_onClickDetail(row, index)
	if not row or row.mode ~= YouthArenaThirdEnum.BattleMode.Three then
		return
	end

	local shouldExpand = not checkbool(row.expanded)
	local rowKey = self:_getRowKey(row)
	local reportScope = self:_getReportCacheScope()

	for _, item in ipairs(self._rows or {}) do
		item.expanded = shouldExpand and item == row
	end

	ExpandedRowKeyCache[reportScope] = shouldExpand and rowKey or nil

	self._reportScrollerList:reloadData(self._rows)

	if shouldExpand then
		self._reportScrollerList:MoveCellToBegin(index)
	end
end

function YouthArenaThirdReportBaseView:_applyExpandedCache()
	local reportScope = self:_getReportCacheScope()
	local expandedRowKey = ExpandedRowKeyCache[reportScope]
	local hasExpandedRow = false

	for index, row in ipairs(self._rows or {}) do
		row.reportKey = self:_getRowKey(row, index)
		row.expanded = row.mode == YouthArenaThirdEnum.BattleMode.Three and row.reportKey == expandedRowKey
		hasExpandedRow = hasExpandedRow or row.expanded
	end

	if expandedRowKey and not hasExpandedRow then
		ExpandedRowKeyCache[reportScope] = nil
	end
end

function YouthArenaThirdReportBaseView:_getRowKey(row, index)
	if not row then
		return tostring(index or 0)
	end

	if row.reportKey then
		return row.reportKey
	end

	local battleIds = {}

	for _, round in ipairs(row.rounds or {}) do
		local battleId = checknumber(round.battleId)

		if battleId > 0 then
			table.insert(battleIds, tostring(battleId))
		end
	end

	if #battleIds > 0 then
		return string.format("%s:battle:%s:%s", self:_getReportCacheScope(), checknumber(row.mode), table.concat(battleIds, ","))
	end

	local var_76_1 = self:_getReportCacheScope()
	local var_76_2 = checknumber(row.mode)
	local var_76_3 = checknumber(row.time)

	return string.format("row:%s:%s:%s:%s:%s:%s:%s:%s", var_76_1, var_76_2, var_76_3, checknumber(row.matchRoundId), checknumber(row.matchIndex), checknumber(row.left and row.left.userId), checknumber(row.right and row.right.userId), checknumber(index))
end

function YouthArenaThirdReportBaseView:_getReportCacheScope()
	return string.format("%s:%s:%s:%s:%s:%s:%s:%s", tostring(self._reportContextKind or "base"), checknumber(self._activityId), tostring(self._isFun == true), checknumber(self._stepId), checknumber(self._viewGroupId), checknumber(self._roundId), checknumber(self._matchIndex), checknumber(self._matchRoundId))
end

function YouthArenaThirdReportBaseView:_onClickVideo(row)
	if self:_isReportVideoExpired(row) then
		return
	end

	local battleIds = self:_getBattleIds(row)
	local var_78_0

	if row then
		::label_78_0::

		var_78_0 = row.left and row.left.userId
	end

	local leftUserId = checknumber(var_78_0)

	if #battleIds <= 0 then
		FloatWordMgr.instance:show("暂无战斗录像")

		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetVideoReq(battleIds, leftUserId)
end

function YouthArenaThirdReportBaseView:_onClickRoundVideo(row, round)
	if self:_isReportVideoExpired(row) then
		return
	end

	local battleId = _getVideoBattleId(row, round and round.battleId)
	local var_79_0

	if row then
		::label_79_0::

		var_79_0 = row.left and row.left.userId
	end

	local leftUserId = checknumber(var_79_0)

	if battleId == 0 then
		FloatWordMgr.instance:show("暂无战斗录像")

		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetVideoReq({
		battleId
	}, leftUserId)
end

function YouthArenaThirdReportBaseView:_getBattleIds(row)
	local battleIds = {}

	for _, round in ipairs((row or nil) and (row.rounds or {})) do
		local battleId = _getVideoBattleId(row, round.battleId)

		if round.played ~= false and battleId ~= 0 then
			table.insert(battleIds, battleId)
		end
	end

	return battleIds
end

function YouthArenaThirdReportBaseView:_hasPlayedRound(row)
	for _, round in ipairs((row or nil) and (row.rounds or {})) do
		if round.played ~= false then
			return true
		end
	end

	return false
end

function YouthArenaThirdReportBaseView:_isReportVideoExpired(row)
	local recordTime = checknumber(row and row.time)

	return recordTime > 0 and ServerTime.now() >= recordTime + YouthArenaThirdEnum.ReportVideoExpireSeconds
end

function YouthArenaThirdReportBaseView:_formatTime(stamp)
	stamp = checknumber(stamp)

	if stamp <= 0 then
		return UNKNOWN_TIME_TEXT
	end

	return GameUtil.formatTimeStamp("%m月%d日 %H:%M", stamp)
end

function YouthArenaThirdReportBaseView:_formatName(side)
	if not side then
		return UNKNOWN_NAME_TEXT
	end

	local areaId = checknumber(side.areaId or side.headInfo and side.headInfo.areaId)

	if string.nilorempty(side.name) then
		if not UNKNOWN_NAME_TEXT then
			local name = side.name

			if areaId > 0 then
				return string.format("s%03d-%s", areaId, name)
			end

			return name
		end
	end
end

function YouthArenaThirdReportBaseView:_formatModeName(mode)
	return MODE_NAME[mode] or ""
end

return YouthArenaThirdReportBaseView
