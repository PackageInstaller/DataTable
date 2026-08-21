-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentTeamChoosePanel.lua

local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local RentTeamCellBase = require("UI/RentTask/RentTeamCellBase")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ResRentMisc = require("ClientData/ResRentMisc")
local POWER_RATE = ResRentMisc[1].power_rate
local POWER_NOTICE = ResRentMisc[1].power_notice
local strClassName = "RentTeamChoosePanel"
local RentTeamChoosePanel = Class(strClassName, UIControls.Panel)
local RentChooseTeamCell = Class("RentChooseTeamCell", UIControls.Child)

function RentChooseTeamCell:ctor(...)
	self:initUI()
end

function RentChooseTeamCell:initUI(...)
	self.basePanel = RentTeamCellBase(self, "")
	self.busyImg = UIControls.Image(self, "ImgBusy")
	self.borrowBtn = UIControls.Button(self, "BtnSendRequest")

	self.borrowBtn:addEventClick(self._onClickBorrow)

	self.requestingImg = UIControls.Image(self, "ImgRequestDis")
	self.invalidImg = UIControls.Image(self, "ImgInProgress")
	self.bgPower = UIControls.Image(self, "Icon")
end

RentChooseTeamCell.MATCH_STATUS = {
	InvalidSelf = 2,
	Valid = 1,
	InvalidOther = 3
}

function RentChooseTeamCell:setTeamInfo(teamInfo)
	self.uid = teamInfo.uid
	self.teamId = teamInfo.teamId
	self.groupTaskId = self.mParent.mParent.groupTaskId

	local formation = RentTaskUtils.getMatchFormation(self.uid, self.teamId)

	self.basePanel:setRentFormation(formation, self.teamId)

	local power = self.basePanel.power

	if power and power ~= 0 then
		RentTaskUtils.updateMatchTeamPower(self.groupTaskId, self.uid, self.teamId, power)
	end

	self.teamIsBusy = teamInfo.applyFull

	self.busyImg:setVisible(self.teamIsBusy)

	local record = RentTaskUtils.getBorrowRecord(self.uid, self.teamId, self.groupTaskId)
	local teamStatus

	if record ~= nil then
		if record.status < 0 then
			teamStatus = self.MATCH_STATUS.InvalidOther
		elseif record.status == Const.RENT_BORROW_STATUS.Fail or record.status == Const.RENT_BORROW_STATUS.RenterCancel or record.status == Const.RENT_BORROW_STATUS.OwnerCancel then
			teamStatus = self.MATCH_STATUS.Valid
		else
			teamStatus = self.MATCH_STATUS.InvalidSelf
		end
	elseif teamInfo.canBorrow then
		teamStatus = self.MATCH_STATUS.Valid
	else
		teamStatus = self.MATCH_STATUS.InvalidOther
	end

	self.powerNotOk = false

	local playerInfo = self.mParent.mParent.playerInfoCache[self.uid]

	if playerInfo and playerInfo.commInfo and power and POWER_RATE and POWER_NOTICE then
		local validPower = (playerInfo.commInfo.symbol_power or 0) * POWER_RATE * 0.0001

		if validPower > 0 and power < validPower then
			self.powerNotOk = true
		end
	end

	if self.powerNotOk then
		self.bgPower:setImage("Atlas/CommonAtlas/GridAtlas/GridEquipAtlas", "IconAttr18")
		self.basePanel.powerTxt:setFontColor(ResColor.COLORBGRANK10)
	else
		self.bgPower:setImage("Atlas/CommonAtlas/GridAtlas/GridEquipAtlas", "IconAttr11")
		self.basePanel.powerTxt:setFontColor(ResColor.WHITE)
	end

	self.borrowBtn:setVisible(teamStatus == self.MATCH_STATUS.Valid)
	self.requestingImg:setVisible(teamStatus == self.MATCH_STATUS.InvalidSelf)
	self.invalidImg:setVisible(teamStatus == self.MATCH_STATUS.InvalidOther)

	if self.waitForResp then
		local recordStatus = RentTaskUtils.getBorrowRecordStatus(self.uid, self.teamId, self.groupTaskId)

		if recordStatus then
			if recordStatus ~= Const.RENT_BORROW_STATUS.Wait and recordStatus ~= Const.RENT_BORROW_STATUS.Success then
				MsgManager.notice(RentTaskUtils.getRentNotice(3))
			else
				local borrowDlg = UIManager.getUI("rentTeamBorrowDlg", nil, false)

				if borrowDlg then
					FlyIconUtils.setFlyImagetoUI(self.borrowBtn, borrowDlg.newsBtn, "Atlas/CaseTaskAtlas/CaseTaskAtlas", "IconLetter", 1)
				end
			end

			self.waitForResp = nil
		end
	end
end

function RentChooseTeamCell:_onClickBorrow(...)
	if self.powerNotOk and POWER_NOTICE then
		MsgManager.notice(POWER_NOTICE)
	end

	self:_realBorrow()
end

function RentChooseTeamCell:_realBorrow()
	local reqCount = RentTaskUtils.getRequestCount(self.groupTaskId)
	local maxCount = RentTaskUtils.maxRequestPerTask()

	if maxCount <= reqCount then
		MsgManager.notice(RentTaskUtils.getRentNotice(4))
	else
		self.waitForResp = true

		RentTaskUtils.borrowTeam(self.groupTaskId, self.uid, self.teamId)
	end
end

local RentChoosePlayerCell = Class("RentChoosePlayerCell", UIControls.ScrollViewLoopCell)

function RentChoosePlayerCell:ctor(...)
	self:initUI()
end

function RentChoosePlayerCell:initUI(...)
	self.playerHead = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.playerHead:setEnable(true)
	self.playerHead:hideLevel()

	self.playerNameTxt = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.playerGenderImg = UIControls.Image(self, "BgPanel/TextPlayerName/IconSex")
	self.playerRelationImg = UIControls.Image(self, "BgPanel/TextPlayerName/ImgRelationship")
	self.playerRelationImgExtra = UIControls.Image(self, "BgPanel/TextPlayerName/ImgRelationship2")
	self.playerServerTxt = UIControls.Label(self, "BgPanel/TextServer")
	self.validTeamNumTxt = UIControls.Label(self, "BgPanel/TextFreeTeamTitle/TextFreeTeam")
	self.friendlyMaxImg = UIControls.Image(self, "BgPanel/ImgLimit")
	self.viewTeamsBtn = UIControls.Button(self, "BgPanel/BtnTeam")

	self.viewTeamsBtn:addEventClick(self._onClickViewTeams)

	self.maxPowerTxt = UIControls.Label(self, "BgPanel/TextFreeTeamPowerTitle/TextFreeTeamPower")
	self.teamInfoPanel = UIControls.Panel(self, "TeamInfo")
	self.teamCells = {}
end

local LAYOUT_SIZE_DEFAULT = 140
local LAYOUT_SIZE_ONELINE = 352
local LAYOUT_SIZE_TWOLINE = 552
local LAYOUT_SIZE_TRILINE = 752

function RentChoosePlayerCell:refreshPlayerTeamInfo(uid, teamList)
	self.uid = uid
	self.teamList = teamList

	self:teamInfoVisible(self.mParent.nowViewTeams == uid)

	local giftNum = CurAvatar.rentOtherGiftNum[uid] or 0
	local giftMax = giftNum >= RentTaskUtils.getGiftWeekLimit()

	self.friendlyMaxImg:setVisible(giftMax)
end

function RentChoosePlayerCell:setPlayerInfo(info)
	self.playerHead:setCommInfo(info, true, self)
	self.playerNameTxt:setText(info.name or "")

	local genderImg = UIConst.getGenderImagePath(info.gender)

	if genderImg and #genderImg == 2 then
		self.playerGenderImg:setImage(genderImg[1], genderImg[2])
	end

	self.playerServerTxt:setText(info.serverName or "")
	RentTaskUtils.setRelationImage(self.playerRelationImg, info.uid, true, self.playerRelationImgExtra)
end

function RentChoosePlayerCell:teamInfoVisible(isVisible)
	self.teamInfoIsVisible = isVisible

	self.teamInfoPanel:setVisible(isVisible)

	if isVisible then
		local teamIdList = {}

		for _, team in ipairs(self.teamList) do
			table.insert(teamIdList, team.teamId)
		end

		RentTaskUtils.getTeamOriFormation(self.uid, teamIdList)
		self:refreshTeamInfo()
	else
		self:setLayoutSize(nil, LAYOUT_SIZE_DEFAULT)
	end

	self:_refreshFreeAndPower()
end

function RentChoosePlayerCell:_refreshFreeAndPower()
	local maxTeamCount = #self.teamList
	local freeTeamCount = 0
	local maxPower = 0

	for _, team in ipairs(self.teamList) do
		if team.canBorrow then
			freeTeamCount = freeTeamCount + 1

			if self.mParent.playerViewedDict[self.uid] then
				maxPower = math.max(maxPower, team.calcPower or team.power)
			else
				maxPower = math.max(maxPower, team.power)
			end
		end
	end

	self.validTeamNumTxt:setText(freeTeamCount .. "/" .. maxTeamCount)

	if maxPower ~= 0 then
		self.maxPowerTxt:setVisible(true)
		self.maxPowerTxt:setText(maxPower)
	elseif freeTeamCount == 0 then
		self.maxPowerTxt:setVisible(true)
		self.maxPowerTxt:setText(Lang.get(30733))
	else
		self.maxPowerTxt:setVisible(false)
	end
end

function RentChoosePlayerCell:refreshTeamInfo()
	for i, team in ipairs(self.teamList) do
		if not self.teamCells[i] then
			self.teamCells[i] = RentChooseTeamCell(self, "TeamInfo", "System/CaseTask/CaseTaskChooseInfoCell")
		end

		local cell = self.teamCells[i]

		cell:setVisible(true)
		cell:setTeamInfo(team)
	end

	if #self.teamCells > #self.teamList then
		for i = #self.teamCells, #self.teamList + 1, -1 do
			self.teamCells[i]:destroy()

			self.teamCells[i] = nil
		end
	end

	local lineNum = math.ceil(#self.teamList / 2)

	if lineNum == 1 then
		self:setLayoutSize(nil, LAYOUT_SIZE_ONELINE)
	elseif lineNum == 2 then
		self:setLayoutSize(nil, LAYOUT_SIZE_TWOLINE)
	elseif lineNum == 3 then
		self:setLayoutSize(nil, LAYOUT_SIZE_TRILINE)
	end
end

function RentChoosePlayerCell:_onClickViewTeams()
	RentTaskUtils.refreshMatchTeams(self.mParent.groupTaskId)

	if not self.teamInfoIsVisible then
		self.mParent:viewPlayerTeams(self.uid)
	else
		self.mParent:viewPlayerTeams(0)
	end
end

function RentTeamChoosePanel:ctor(...)
	self:initUI()

	self.playerViewedDict = {}
end

function RentTeamChoosePanel:initUI(...)
	self.playerCells = {}
	self.playerInfoCache = {}
	self.playersView = UIControls.ScrollViewLoopV(self, self.mPath .. "/ChosseList", 0, self.onCellChanged)
	self.slotOfPlayerSort = Slot(self._sortPlayer, self)
	self.slotOfRefreshPlayerData = Slot(self.refreshPlayerCommonData, self)
end

function RentTeamChoosePanel:setTeamChooseInfo(groupTaskId)
	self.groupTaskId = groupTaskId
	self.giftWeekLimit = RentTaskUtils.getGiftWeekLimit()
end

function RentTeamChoosePanel:initMatchList(...)
	local matchTeams = RentTaskUtils.getMatchTeams(self.groupTaskId)

	if not matchTeams then
		return
	end

	self.playerTeamDict = {}
	self.playerList = {}

	for _, teamInfo in ipairs(matchTeams) do
		local playerUid = teamInfo.uid

		if not self.playerTeamDict[playerUid] then
			self.playerTeamDict[playerUid] = {}

			table.insert(self.playerList, playerUid)
		end

		local teamId = teamInfo.teamId

		self.playerTeamDict[playerUid][teamId] = teamInfo
	end

	table.sort(self.playerList, self.slotOfPlayerSort)
	self.playersView:setTotalCount(#self.playerList, 1)
	CurAvatar:getRoleCommInfosNoTip(self.playerList, self.slotOfRefreshPlayerData)
end

function RentTeamChoosePanel:refreshTeamChoosePanel()
	self.giftWeekLimit = RentTaskUtils.getGiftWeekLimit()

	local matchTeams = RentTaskUtils.getMatchTeams(self.groupTaskId)

	if not matchTeams then
		return
	end

	self.playerTeamDict = {}

	for _, teamInfo in ipairs(matchTeams) do
		local playerUid = teamInfo.uid

		if not self.playerTeamDict[playerUid] then
			self.playerTeamDict[playerUid] = {}
		end

		local teamId = teamInfo.teamId

		self.playerTeamDict[playerUid][teamId] = teamInfo
	end

	for _, cell in pairs(self.playerCells) do
		local uid = cell.uid

		if self.playerTeamDict[uid] then
			cell:refreshPlayerTeamInfo(uid, self.playerTeamDict[uid])
		end
	end
end

function RentTeamChoosePanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = RentChoosePlayerCell(sender, "System/CaseTask/BtnCaseTaskChoose", newIdx)
	else
		self.playerCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local uid = self.playerList[newIdx]

	if uid and self.playerTeamDict[uid] then
		local data = self.playerTeamDict[uid]

		targetCell:refreshPlayerTeamInfo(uid, data)

		local playerInfo = self.playerInfoCache[uid]

		if playerInfo then
			targetCell:setPlayerInfo(playerInfo.commInfo)
		end
	end

	self.playerCells[newIdx] = targetCell
end

function RentTeamChoosePanel:viewPlayerTeams(uid)
	self.nowViewTeams = uid
	self.playerViewedDict[uid] = true

	for _, cell in pairs(self.playerCells) do
		cell:teamInfoVisible(cell.uid == uid)
	end
end

function RentTeamChoosePanel:_sortPlayer(a, b)
	local aWeight = self:_getPlayerSortWeight(a)
	local bWeight = self:_getPlayerSortWeight(b)

	return bWeight < aWeight
end

function RentTeamChoosePanel:_getPlayerSortWeight(uid)
	local weight = 0

	if CurAvatar:isMyMaster(uid) then
		weight = weight + 1000
	end

	if CurAvatar:isMyApprentice(uid) then
		weight = weight + 9
	end

	if CurAvatar:setConfidantOnMe(uid) then
		weight = weight + 9
	end

	if CurAvatar:isMyFriend(uid) then
		weight = weight + 8
	end

	if CurAvatar:playerInMyCircle(uid) then
		weight = weight + 7
	end

	local teamList = self.playerTeamDict[uid]
	local freeTeamCount = 0

	for _, team in ipairs(teamList) do
		if team.canBorrow then
			freeTeamCount = freeTeamCount + 1
		end
	end

	if freeTeamCount > 0 then
		weight = weight + freeTeamCount + 1
	end

	local giftNum = CurAvatar.rentOtherGiftNum[uid]

	if giftNum < self.giftWeekLimit then
		weight = weight + 1
	end

	return weight
end

function RentTeamChoosePanel:refreshPlayerCommonData(infos)
	for i, info in ipairs(infos) do
		self.playerInfoCache[info.uid] = info
	end

	if next(self.playerCells) == 0 then
		return
	end

	for _, cell in pairs(self.playerCells) do
		local info = self.playerInfoCache[cell.uid]

		if info then
			cell:setPlayerInfo(info.commInfo)
		end
	end
end

function RentTeamChoosePanel:onPanelOpen()
	if not RentTaskUtils.rematchTeams(self.groupTaskId) then
		self:initMatchList()
	end
end

function RentTeamChoosePanel:onPanelClose()
	self:viewPlayerTeams(0)
	coroutine.step()
	self.playersView:clearCells()
	coroutine.step()
end

function RentTeamChoosePanel:clear(...)
	self.playerCells = {}
end

return RentTeamChoosePanel
