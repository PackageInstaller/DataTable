-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentOwnerMsgPanel.lua

local RentTeamCellBase = require("UI/RentTask/RentTeamCellBase")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local ResColor = require("ClientData/ResColor")
local strClassName = "RentOwnerMsgPanel"
local RentOwnerMsgPanel = Class(strClassName, UIControls.Panel)
local RentOwnerMsgCell = Class("RentOwnerMsgCell", UIControls.ScrollViewLoopCell)

function RentOwnerMsgCell:ctor(...)
	self:initUI()
end

function RentOwnerMsgCell:initUI(...)
	self.playerHead = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.playerHead:setEnable(true)
	self.playerHead:hideLevel()

	self.playerNameTxt = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.playerGenderImg = UIControls.Image(self, "BgPanel/TextPlayerName/IconSex")
	self.playerRelationImg = UIControls.Image(self, "BgPanel/TextPlayerName/ImgRelationship")
	self.playerServerTxt = UIControls.Label(self, "BgPanel/TextServer")
	self.basePanel = RentTeamCellBase(self, "BgPanel/CaseTaskChooseInfoCell")
	self.titleTxt = UIControls.Label(self, "BgPanel/TextTitle")
	self.agreeBtn = UIControls.Button(self, "BgPanel/BtnAgree")

	self.agreeBtn:addEventClick(self._onClickAgree)

	self.refuseBtn = UIControls.Button(self, "BgPanel/BtnRefuse")

	self.refuseBtn:addEventClick(self._onClickRefuse)

	self.revokeBtn = UIControls.Button(self, "BgPanel/SupportPanel/BtnRevoke")

	self.revokeBtn:addEventClick(self._onClickRevoke)

	self.timerPanel = UIControls.Panel(self, "BgPanel/SupportPanel")
	self.timerPanelTxt = UIControls.Label(self, "BgPanel/SupportPanel/TextTime")
	self.difficultyColor = UIControls.Image(self, "BgPanel/BgR2")
	self.difficultyTitleImg = UIControls.Image(self, "BgPanel/BgTitle")
	self.difficultyLvImg = UIControls.Image(self, "BgPanel/ImgDifficultyLv")
end

function RentOwnerMsgCell:setMsgInfo(msg)
	self.teamId = msg.teamId
	self.uid = msg.renterUid
	self.groupTaskId = msg.groupTaskId
	self.taskId = msg.taskId

	self.titleTxt:setText(RentTaskUtils.getTaskTitle(self.taskId) or "")

	local isRare = RentTaskUtils.getTaskType(self.taskId) == Const.RENT_TASK_TYPE.Rare or RentTaskUtils.getTaskType(self.taskId) == Const.RENT_TASK_TYPE.ExtraRare

	self:_setTaskDifficulty(isRare)

	if CurAvatar:isFormationSnapShot(Const.FORMATION_RENT_TEAMS[1]) then
		local formation = CurAvatar:getFormationSnapshot(Const.FORMATION_RENT_TEAMS[self.teamId])

		self.basePanel:setRentFormation(formation, self.teamId)
	else
		local formation = CurAvatar:getNowFormation(Const.FORMATION_RENT_TEAMS[self.teamId])

		self.basePanel:setRentFormationWithLocalData(formation, self.teamId, nil, Const.FORMATION_RENT_TEAMS[self.teamId])
	end

	self.status = msg.status
	self.acceptTick = msg.acceptTick
	self.needUpdateTimer = self.status == Const.RENT_APPLY_STATUS.Accept

	local stateName

	if self.status == Const.RENT_APPLY_STATUS.Applying then
		stateName = "UntreatedBtnCaseTaskReceive"
	elseif self.status == Const.RENT_APPLY_STATUS.Accept then
		stateName = "SupportBtnCaseTaskReceive"
	elseif self.status == Const.RENT_APPLY_STATUS.OverDue or self.status == Const.RENT_APPLY_STATUS.RenterCancel or self.status == Const.RENT_APPLY_STATUS.OwnerCancel then
		stateName = "ExpiredBtnCaseTaskReceive"

		CurAvatar:setOwnerRecordDirty(self.uid, self.teamId, self.groupTaskId)
	elseif self.status == Const.RENT_APPLY_STATUS.Complete then
		stateName = "FinishBtnCaseTaskReceive"
	elseif self.status == Const.RENT_APPLY_STATUS.OtherRented then
		stateName = "LendBtnCaseTaskReceive"
	else
		stateName = "RefuseBtnCaseTaskReceive"

		CurAvatar:setOwnerRecordDirty(self.uid, self.teamId, self.groupTaskId)
	end

	self:playStateAnimator(stateName)
end

function RentOwnerMsgCell:setPlayerInfo(info)
	self.playerHead:setCommInfo(info, true, self)
	self.playerNameTxt:setText(info.name or "")

	local genderImg = UIConst.getGenderImagePath(info.gender)

	if genderImg and #genderImg == 2 then
		self.playerGenderImg:setImage(genderImg[1], genderImg[2])
	end

	self.playerServerTxt:setText(info.serverName or "")
	RentTaskUtils.setRelationImage(self.playerRelationImg, info.uid)
end

function RentOwnerMsgCell:_setTaskDifficulty(isHard)
	if isHard then
		self.difficultyColor:setObjColor(ResColor.RED03)
		self.difficultyTitleImg:setImage("Atlas/CaseTaskAtlas/CaseTaskAtlas", "BgCaseDetailsTitle3")
		self.difficultyLvImg:setImage("Atlas/CaseTaskAtlas/CaseTaskAtlas", "BgDifficultyLv3")
	else
		self.difficultyColor:setObjColor(ResColor.QUALITYORANGE)
		self.difficultyTitleImg:setImage("Atlas/CaseTaskAtlas/CaseTaskAtlas", "BgCaseDetailsTitle2")
		self.difficultyLvImg:setImage("Atlas/CaseTaskAtlas/CaseTaskAtlas", "BgDifficultyLv2")
	end
end

function RentOwnerMsgCell:_onClickAgree(...)
	if self.status == Const.RENT_APPLY_STATUS.OtherRented then
		MsgManager.notice(RentTaskUtils.getRentNotice(2))
	else
		RentTaskUtils.acceptBorrowRequest(self.groupTaskId, self.uid, self.teamId)
	end
end

function RentOwnerMsgCell:_onClickRefuse(...)
	RentTaskUtils.refuseBorrowRequest(self.groupTaskId, self.uid, self.teamId)
end

function RentOwnerMsgCell:_onClickRevoke(...)
	if self.acceptTick then
		local timePass = ClientUtils.getServerTime() - self.acceptTick
		local cancelCD = RentTaskUtils.getOwnerCancelCd() * 60

		if timePass < cancelCD then
			local leftTime = cancelCD - timePass
			local leftTimeStr

			if leftTime < 60 then
				leftTimeStr = os.date(Lang.get(30722), leftTime)
			else
				leftTimeStr = os.date(Lang.get(30723), leftTime)
			end

			MsgManager.notice(string.format(RentTaskUtils.getRentNotice(10), leftTimeStr))

			return
		end
	end

	RentTaskUtils.cancelLentedTeam(self.groupTaskId, self.uid, self.teamId)
end

function RentOwnerMsgCell:updateTimer()
	if not self.needUpdateTimer then
		return
	end

	if not self.acceptTick then
		return
	end

	local timePass = ClientUtils.getServerTime() - self.acceptTick

	self.timerPanelTxt:setText(utils.calcShortTimeTxt(timePass))
end

function RentOwnerMsgPanel:ctor(...)
	self:initUI()
end

function RentOwnerMsgPanel:initUI(...)
	self.emptyPanel = UIControls.Panel(self, self.mPath .. "/NothingPanel")
	self.msgPanel = UIControls.Panel(self, self.mPath .. "/ReceiveList")
	self.autoAcceptBtn = UIControls.CustomToggle(self, self.mPath .. "/BtnLock")

	self.autoAcceptBtn:addEventOnToggleClick(Slot(self._onClickAutoAccept, self))

	self.noticeWinBtn = UIControls.CustomToggle(self, self.mPath .. "/BtnNewWin")

	self.noticeWinBtn:addEventOnToggleClick(Slot(self._onClickNoticeWin, self))

	self.msgView = UIControls.ScrollViewLoopV(self, self.mPath .. "/ReceiveList", 0, self.onCellChanged)
	self.msgData = {}
	self.cellList = {}
	self.playerInfoDict = {}
	self.slotOfRefreshPlayerData = Slot(self.refreshPlayerCommonData, self)
end

function RentOwnerMsgPanel:setOwnerMsgPanel(...)
	self.msgData = RentTaskUtils.getAllOwnerRecords()

	table.sort(self.msgData, self._sortRecords)
	self.autoAcceptBtn:setToggleValue(CurAvatar.autoAcceptRequest)
	self.noticeWinBtn:setToggleValue(CurAvatar.rentMsgNoticeOn)
	self:_refreshMsgData()
end

function RentOwnerMsgPanel:refreshOwnerMsgPanel(...)
	local newMsgData = RentTaskUtils.getAllOwnerRecords()

	self.msgData = self:_addNewMsg(newMsgData, self.msgData)

	self:_refreshMsgData()
	self.autoAcceptBtn:refreshToggleValue(CurAvatar.autoAcceptRequest)
end

function RentOwnerMsgPanel:_refreshMsgData()
	if #self.msgData == 0 then
		self.emptyPanel:setVisible(true)
		self.msgPanel:setVisible(false)
	else
		self.emptyPanel:setVisible(false)
		self.msgPanel:setVisible(true)
		self.msgView:setTotalCount(#self.msgData)

		local playerList = RentTaskUtils.getAllRenters()

		CurAvatar:getRoleCommInfosNoTip(playerList, self.slotOfRefreshPlayerData)
	end
end

function RentOwnerMsgPanel._sortRecords(a, b)
	if a.status == b.status then
		local aTaskType = RentTaskUtils.getTaskType(a.taskId) or Const.RENT_TASK_TYPE.Advanced
		local bTaskType = RentTaskUtils.getTaskType(b.taskId) or Const.RENT_TASK_TYPE.Advanced

		if aTaskType == bTaskType then
			if a.overdueTick == b.overdueTick then
				return a.applyTick < b.applyTick
			else
				return a.overdueTick < b.overdueTick
			end
		else
			return bTaskType < aTaskType
		end
	else
		return a.status < b.status
	end
end

function RentOwnerMsgPanel:_addNewMsg(newMsgData, oldMsgData)
	local newMsgs = {}

	for _, msg in ipairs(newMsgData) do
		local alreadyExist = false

		for i, oldMsg in ipairs(oldMsgData) do
			if oldMsg.renterUid == msg.renterUid and oldMsg.groupTaskId == msg.groupTaskId and oldMsg.taskId == msg.taskId and oldMsg.teamId == msg.teamId then
				oldMsgData[i] = msg
				alreadyExist = true

				break
			end
		end

		if not alreadyExist and msg.status == Const.RENT_APPLY_STATUS.Applying then
			table.insert(newMsgs, msg)
		end
	end

	for _, msg in ipairs(newMsgs) do
		table.insert(oldMsgData, 1, msg)
	end

	return oldMsgData
end

function RentOwnerMsgPanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = RentOwnerMsgCell(sender, "System/CaseTask/BtnCaseTaskReceive", newIdx)
	else
		self.cellList[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local msgInfo = self.msgData[newIdx]

	if msgInfo then
		targetCell:setMsgInfo(msgInfo)

		if self.playerInfoDict[targetCell.uid] then
			local info = self.playerInfoDict[targetCell.uid]

			targetCell:setPlayerInfo(info.commInfo)
		end
	end

	self.cellList[newIdx] = targetCell
end

function RentOwnerMsgPanel:refreshPlayerCommonData(infos)
	if self.cleared then
		return
	end

	local infoDict = {}

	for i, info in ipairs(infos) do
		infoDict[info.uid] = info
		self.playerInfoDict[info.uid] = info
	end

	for i, cell in pairs(self.cellList) do
		local cellUid = cell.uid
		local info = infoDict[cellUid]

		if info then
			cell:setPlayerInfo(info.commInfo)
		end
	end
end

function RentOwnerMsgPanel:_onClickAutoAccept(isOn)
	self.autoAcceptCache = isOn
	self.autoAcceptOptTick = ClientUtils.getServerTime()

	self.autoAcceptBtn:refreshToggleValue(isOn)

	if isOn then
		MsgManager.notice(Lang.get(30725))
	else
		MsgManager.notice(Lang.get(30726))
	end
end

function RentOwnerMsgPanel:_realSetAutoAccept()
	if self.autoAcceptCache ~= CurAvatar.autoAcceptRequest then
		RentTaskUtils.setAutoAccept(self.autoAcceptCache)
	end

	self.autoAcceptCache = nil
	self.autoAcceptOptTick = nil
end

function RentOwnerMsgPanel:_onClickNoticeWin(isOn)
	CurAvatar:setAutoOpenUIFlag(isOn)
	self.noticeWinBtn:refreshToggleValue(isOn)

	if isOn then
		MsgManager.notice(Lang.get(30725))
	else
		MsgManager.notice(Lang.get(30726))
	end
end

function RentOwnerMsgPanel:onPanelOpen()
	self:setOwnerMsgPanel()
	self:_startUpdateTimer()

	self.cleared = nil
end

function RentOwnerMsgPanel:clear(...)
	self.cellList = {}

	self:_stopTimer()

	if self.autoAcceptOptTick then
		self:_realSetAutoAccept()
	end

	CurAvatar:clearDirtyOwnerRecord()

	self.cleared = true
end

function RentOwnerMsgPanel:_startUpdateTimer(...)
	self:_stopTimer()
	self:_timerBeat()

	if not self.updateTimer then
		self.updateTimer = Timer.New(Slot(self._timerBeat, self), 1, -1)
	end

	self.updateTimer:Start()
end

function RentOwnerMsgPanel:_stopTimer(...)
	if self.updateTimer then
		self.updateTimer:Stop()
	end
end

local DELAY_SET_AUTOACCEPT = 3

function RentOwnerMsgPanel:_timerBeat(...)
	for _, cell in pairs(self.cellList) do
		cell:updateTimer()
	end

	if self.autoAcceptOptTick then
		local nowTime = ClientUtils.getServerTime()

		if nowTime - self.autoAcceptOptTick >= DELAY_SET_AUTOACCEPT then
			self:_realSetAutoAccept()
		end
	end
end

return RentOwnerMsgPanel
