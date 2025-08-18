-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentTeamNewsPanel.lua

local RentTeamCellBase = require("UI/RentTask/RentTeamCellBase")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local strClassName = "RentTeamNewsPanel"
local RentTeamNewsPanel = Class(strClassName, UIControls.Panel)
local RentNewsCell = Class("RentNewsCell", UIControls.ScrollViewLoopCell)

function RentNewsCell:ctor(...)
	self:initUI()
end

function RentNewsCell:initUI(...)
	self.playerHead = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.playerHead:setEnable(true)
	self.playerHead:hideLevel()

	self.playerNameTxt = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.playerGenderImg = UIControls.Image(self, "BgPanel/TextPlayerName/IconSex")
	self.playerRelationImg = UIControls.Image(self, "BgPanel/TextPlayerName/ImgRelationship")
	self.playerRelationImgExtra = UIControls.Image(self, "BgPanel/TextPlayerName/ImgRelationship2")
	self.playerServerTxt = UIControls.Label(self, "BgPanel/TextServer")
	self.basePanel = RentTeamCellBase(self, "BgPanel/CaseTaskChooseInfoCell")
	self.battleBtn = UIControls.Button(self, "BgPanel/BtnBattle")

	self.battleBtn:addEventClick(self._onClickBattle)

	self.battleNewImg = UIControls.Image(self, "BgPanel/BtnBattle/IconNew")
	self.waitingStatePanel = UIControls.Panel(self, "BgPanel/ConductPanel")
	self.waitingTimeTxt = UIControls.Label(self, "BgPanel/ConductPanel/TextTime")
	self.refuseStatePanel = UIControls.Panel(self, "BgPanel/FailPanel")
	self.deleteBtn = UIControls.Button(self, "BgPanel/BtnDelete")

	self.deleteBtn:addEventClick(self._onClickDelete)

	self.cancelBtn = UIControls.Button(self, "BgPanel/BtnRecall")

	self.cancelBtn:addEventClick(self._onClickCancel)
end

function RentNewsCell:setNewsInfo(newsData, taskId, pveId)
	self.taskId = taskId
	self.pveId = pveId
	self.uid = newsData.uid
	self.teamId = newsData.teamId
	self.groupTaskId = newsData.groupTaskId
	self.requestTick = newsData.requestTick
	self.status = newsData.status

	self.battleNewImg:setVisible(newsData.newBorrowed)

	if self.status == Const.RENT_BORROW_STATUS.Success then
		self.formation = RentTaskUtils.getRentForamtion(self.uid, self.teamId)
	else
		self.formation = RentTaskUtils.getMatchFormation(self.uid, self.teamId)
	end

	self.basePanel:setRentFormation(self.formation, self.teamId)

	self.needUpdateTimer = self.status == Const.RENT_BORROW_STATUS.Wait or self.status == Const.RENT_BORROW_STATUS.InUse

	self.waitingTimeTxt:setVisible(self.needUpdateTimer)

	local stateName
	local grayPlayer = false

	if self.status == Const.RENT_BORROW_STATUS.Wait then
		stateName = "HighBtnCaseTaskNews"
	elseif self.status == Const.RENT_BORROW_STATUS.Success then
		stateName = "NmlBtnCaseTaskNews"
	elseif self.status == Const.RENT_BORROW_STATUS.InUse then
		stateName = "LendBtnCaseTaskNews"
	elseif self.status == Const.RENT_BORROW_STATUS.OwnerCancel then
		stateName = "RevokeBtnCaseTaskNews"
		grayPlayer = true
	else
		stateName = "DisBtnCaseTaskNews"
		grayPlayer = true
	end

	self:playStateAnimator(stateName)
	self.playerHead:setObjGray(grayPlayer)
	self.basePanel:setObjGray(grayPlayer)
end

function RentNewsCell:setPlayerInfo(info)
	self.playerHead:setCommInfo(info, true, self)

	local nameResult, hasClip = ClientUtils.subStringByLength(info.name or "", 8)

	if hasClip then
		nameResult = nameResult .. "..."
	end

	self.playerNameTxt:setText(nameResult)

	local genderImg = UIConst.getGenderImagePath(info.gender)

	if genderImg and #genderImg == 2 then
		self.playerGenderImg:setImage(genderImg[1], genderImg[2])
	end

	self.playerServerTxt:setText(info.serverName or "")
	RentTaskUtils.setRelationImage(self.playerRelationImg, info.uid, true, self.playerRelationImgExtra)
end

function RentNewsCell:_onClickBattle()
	if not self.formation then
		MsgManager.notice(Lang.get(30734))

		return
	end

	if not CurAvatar.rentSvrFocusGtid or CurAvatar.rentSvrFocusGtid ~= self.groupTaskId then
		MsgManager.notice(RentTaskUtils.getRentNotice(12))
		RentTaskUtils.getAllBorrowedTeam(self.groupTaskId)

		return
	end

	local record = RentTaskUtils.getBorrowRecord(self.uid, self.teamId, self.groupTaskId)

	if record then
		record.newBorrowed = false
	end

	local overdueTick
	local groupTaskInfo = RentTaskUtils.getGroupTaskSvrData(self.groupTaskId)

	if groupTaskInfo then
		overdueTick = groupTaskInfo.overdueTick
	end

	local heros = utils.getHeroListByFormation(self.formation)

	if self.pveId then
		local battleData = {}

		battleData.rentData = {
			hasAward = false,
			gtId = self.groupTaskId,
			taskId = self.taskId,
			pveId = self.pveId,
			teamUid = self.uid,
			teamId = self.teamId,
			fixedHeros = heros,
			overdueTick = overdueTick,
			svrMaxStage = RentTaskUtils.getGroupTaskMaxStage(self.groupTaskId)
		}

		CurAvatar:enterFormation(self.pveId, BattleConst.BATTLE_TYPE_RENT, battleData)
	end
end

function RentNewsCell:_onClickDelete(...)
	if self:_cancelInCd() then
		return
	end

	local function yesFunc(groupTaskId, uid, teamId)
		RentTaskUtils.cancelBorrowTeam(groupTaskId, uid, teamId)
	end

	UIManager.showConfirmWithId(1030, Functor(yesFunc, self.groupTaskId, self.uid, self.teamId))
end

function RentNewsCell:_onClickCancel(...)
	if self:_cancelInCd() then
		return
	end

	RentTaskUtils.cancelBorrowTeam(self.groupTaskId, self.uid, self.teamId)
end

function RentNewsCell:_cancelInCd()
	if self.requestTick then
		local timePass = ClientUtils.getServerTime() - self.requestTick
		local cancelCD = RentTaskUtils.getRenterCancelCd() * 60

		if timePass < cancelCD then
			local leftTime = cancelCD - timePass
			local leftTimeStr

			if leftTime < 60 then
				leftTimeStr = os.date(Lang.get(30722), leftTime)
			else
				leftTimeStr = os.date(Lang.get(30723), leftTime)
			end

			MsgManager.notice(string.format(RentTaskUtils.getRentNotice(9), leftTimeStr))

			return true
		end
	end

	return false
end

function RentNewsCell:updateTimer()
	if not self.needUpdateTimer then
		return
	end

	if not self.requestTick then
		return
	end

	local timePass = ClientUtils.getServerTime() - self.requestTick

	self.waitingTimeTxt:setText(utils.calcShortTimeTxt(timePass))
end

function RentTeamNewsPanel:ctor(...)
	self:initUI()
end

function RentTeamNewsPanel:initUI(...)
	self.emptyPanel = UIControls.Panel(self, self.mPath .. "/NothingPanel")
	self.listPanel = UIControls.Panel(self, self.mPath .. "/NewsList")
	self.newsView = UIControls.ScrollViewLoopV(self, self.mPath .. "/NewsList", 0, self.onCellChanged)
	self.newsData = {}
	self.cellList = {}
	self.playerInfoDict = {}
	self.slotOfRefreshPlayerData = Slot(self.refreshPlayerCommonData, self)
end

function RentTeamNewsPanel:setTeamNewsInfo(groupTaskId, taskId, pveId)
	self.groupTaskId = groupTaskId
	self.taskId = taskId
	self.pveId = pveId
end

function RentTeamNewsPanel:refreshTeamNewsPanel(isInit)
	self.newsData = RentTaskUtils.getBorrowRecordList(self.groupTaskId)

	if #self.newsData == 0 then
		self.emptyPanel:setVisible(true)
		self.listPanel:setVisible(false)
	else
		self.emptyPanel:setVisible(false)
		self.listPanel:setVisible(true)
		table.sort(self.newsData, self._sortRecords)

		if isInit then
			self.newsView:setTotalCount(#self.newsData, 1)
		else
			self.newsView:setTotalCount(#self.newsData)
		end

		CurAvatar:checkRentBorrowRD()

		local playerList = {}
		local tempDict = {}
		local needUpdateFormation = false

		for _, record in ipairs(self.newsData) do
			local uid = record.uid

			if not tempDict[uid] then
				tempDict[uid] = {}

				table.insert(playerList, uid)
			end

			if record.status == Const.RENT_BORROW_STATUS.Success then
				if record.formationDirty or not RentTaskUtils.getRentForamtion(uid, record.teamId) then
					needUpdateFormation = true
					record.formationDirty = nil
				end
			elseif not RentTaskUtils.getMatchFormation(uid, record.teamId) then
				table.insert(tempDict[uid], record.teamId)
			end
		end

		CurAvatar:getRoleCommInfosNoTip(playerList, self.slotOfRefreshPlayerData)

		if not isInit and needUpdateFormation then
			RentTaskUtils.getAllBorrowedTeam(self.groupTaskId)
		end

		for uid, teamIdList in pairs(tempDict) do
			if #teamIdList > 0 then
				RentTaskUtils.getTeamOriFormation(uid, teamIdList)
			end
		end
	end
end

RentTeamNewsPanel.STATUS_WEIGHT = {
	[Const.RENT_BORROW_STATUS.Success] = 1,
	[Const.RENT_BORROW_STATUS.Wait] = 2,
	[Const.RENT_BORROW_STATUS.Fail] = 3,
	[Const.RENT_BORROW_STATUS.RenterCancel] = 4,
	[Const.RENT_BORROW_STATUS.OwnerCancel] = 5
}

function RentTeamNewsPanel._sortRecords(a, b)
	if a.status == b.status then
		return a.requestTick > b.requestTick
	else
		local aWeight = RentTeamNewsPanel.STATUS_WEIGHT[a.status] or 4
		local bWeight = RentTeamNewsPanel.STATUS_WEIGHT[b.status] or 4

		return aWeight < bWeight
	end
end

function RentTeamNewsPanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = RentNewsCell(sender, "System/CaseTask/BtnCaseTaskNews", newIdx)
	else
		self.cellList[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local data = self.newsData[newIdx]

	if data then
		targetCell:setNewsInfo(data, self.taskId, self.pveId)

		if self.playerInfoDict[targetCell.uid] then
			local info = self.playerInfoDict[targetCell.uid]

			targetCell:setPlayerInfo(info.commInfo)
		end
	end

	self.cellList[newIdx] = targetCell
end

function RentTeamNewsPanel:refreshPlayerCommonData(infos)
	if self.cleared then
		return
	end

	local infoDict = {}

	for i, info in ipairs(infos) do
		infoDict[info.uid] = info
		self.playerInfoDict[info.uid] = info
	end

	for i, cell in ipairs(self.cellList) do
		local cellUid = cell.uid
		local info = infoDict[cellUid]

		if info then
			cell:setPlayerInfo(info.commInfo)
		end
	end
end

function RentTeamNewsPanel:onPanelOpen()
	RentTaskUtils.getAllBorrowedTeam(self.groupTaskId)
	self:refreshTeamNewsPanel(true)
	self:_startUpdateTimer()

	self.cleared = nil
end

function RentTeamNewsPanel:clear(...)
	self.cellList = {}

	self:_stopTimer()

	self.cleared = true
end

function RentTeamNewsPanel:_startUpdateTimer(...)
	self:_stopTimer()
	self:_timerBeat()

	if not self.updateTimer then
		self.updateTimer = Timer.New(Slot(self._timerBeat, self), 1, -1)
	end

	self.updateTimer:Start()
end

function RentTeamNewsPanel:_stopTimer(...)
	if self.updateTimer then
		self.updateTimer:Stop()
	end
end

function RentTeamNewsPanel:_timerBeat(...)
	for i, cell in ipairs(self.cellList) do
		cell:updateTimer()
	end
end

return RentTeamNewsPanel
