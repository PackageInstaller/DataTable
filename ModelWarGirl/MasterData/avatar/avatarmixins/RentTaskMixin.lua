-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\RentTaskMixin.lua

local UserData = require("Helper/UserData")
local ResRentTask = require("ClientData/ResRentTask")
local ResRentMisc = require("ClientData/ResRentMisc")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local RentTaskMixin = {}

function RentTaskMixin:initRentTaskMixin(baseData, syncData)
	self.rentTaskFlag = true

	if self.rentTaskFlag then
		RentMsgManager.clearRentMsg()

		local rentData = syncData.other.rent

		self.rentBorrowedTeams = {}
		self.rentSelfRecords = {}
		self.rentMatchTeams = {}
		self.rentMatchTimestamp = {}
		self.rentFormationDict = {}
		self.matchFormationDict = {}
		self.rentOtherGiftNum = {}
		self.rentFormationTimeStamp = {}
		self.matchFormationTimeStamp = {}
		self.rentChangeSelectTimeStamp = {}
		self.rentLetters = {}
		self.rentSendLetters = {}
		self.rentMsgNoticeCache = {}
		self.rentGiftNum = rentData.giftnum
		self.isRentLetterGetted = false
		self.isRentSendLetterGetted = false
		self.autoAcceptRequest = rentData.auto_accept == 1
		self.rentTaskNeedOpenWriteLetterDlg = false

		self:checkRentNewTaskRD(rentData.refresh_tick)

		self.rentTaskData = self:_handleAllRentTask(rentData.task_group)
		self.rentMaxUnlockTeams = rentData.team_num

		self:_loadRentAutoOpenDlg()
		self:_loadShowLetterNotice()

		Const.CONDITION_LIMIT_RENTTASK = ResRentMisc[1].condition_id

		self:checkRentUpWeek()
	end
end

function RentTaskMixin:postinitRentTaskMixin(baseData, syncData)
	self:refreshRentFormationSnapshot()
end

function RentTaskMixin:initCheckRentTaskMixin()
	self:checkRentUnselectRD()
	self:checkRentBorrowRD()
end

function RentTaskMixin:destroyRentTaskMixin()
	RentMsgManager.clearRentMsg()
	RentTaskUtils.destroy()

	self.rentTaskNeedOpenWriteLetterDlg = false
	self.isRentLetterGetted = false
	self.isRentSendLetterGetted = false
end

function RentTaskMixin:onRentDataNotify(data)
	for _, taskGroupItem in ipairs(data.task_group) do
		local groupTaskId = taskGroupItem.gtid

		for _, record in ipairs(taskGroupItem.rent_record) do
			local recordInfo = self:_handleBorrowedRecord(record, groupTaskId)

			if recordInfo.status == Const.RENT_BORROW_STATUS.Success then
				recordInfo.formationDirty = true
				recordInfo.newBorrowed = true

				self:addRentMsgNoticeCache(Const.RENT_NOTICE_TYPE.RespMsg, recordInfo)
			end
		end
	end

	self:checkRentBorrowRD()

	for _, record in ipairs(data.apply_record) do
		self:_handleOwnerRecord(record)
	end

	self:postProcessSelfRecords()
	self:checkRentSelfNewRequest()

	for _, formation in ipairs(data.rented_team) do
		self:_handleRentFormation(formation, true)
	end
end

function RentTaskMixin:onRentTaskDataNotify(gtid, task, status)
	local battleStatus = {}

	for _, battleInfo in ipairs(task.pve) do
		table.insert(battleStatus, {
			teamId = battleInfo.teamid,
			win = battleInfo.win == 1
		})
	end

	for _, groupInfo in ipairs(self.rentTaskData) do
		if groupInfo.groupTaskId == gtid then
			local taskId = groupInfo.selection

			groupInfo.taskItems[taskId] = battleStatus
			groupInfo.taskStatus = status

			break
		end
	end

	self:checkRentBorrowRD()
	self:refreshRentMainUI()
	self:refreshRentBossInfoUI()
end

function RentTaskMixin:onRentTeamNumNotify(team_num)
	self.rentMaxUnlockTeams = team_num

	self:checkRentFormationRedHind()
	self:refreshRentSetupUI()
end

function RentTaskMixin:onRentTMiscNotify(gift_num, team_num)
	self.rentGiftNum = gift_num

	self:refreshRentMainUI()
end

function RentTaskMixin:postProcessSelfRecords()
	local teamRentInfo = {}
	local curTime = ClientUtils.getServerTime()

	for uid, teamInfo in pairs(self.rentSelfRecords) do
		for tid, groupTaskInfo in pairs(teamInfo) do
			for gtid, record in pairs(groupTaskInfo) do
				self:checkSelfRecordOverdue(record, curTime)
			end
		end
	end

	for uid, teamInfo in pairs(self.rentSelfRecords) do
		for tid, groupTaskInfo in pairs(teamInfo) do
			for gtid, record in pairs(groupTaskInfo) do
				if record.status ~= Const.RENT_APPLY_STATUS.Accept or teamRentInfo[tid] then
					-- block empty
				else
					teamRentInfo[tid] = record
				end
			end
		end
	end

	for tid, renterRecord in pairs(teamRentInfo) do
		local renterUid = renterRecord.renterUid
		local renterGtid = renterRecord.groupTaskId

		self:_setSelfRecordOtherRented(tid, renterUid, renterGtid)
	end
end

function RentTaskMixin:_setSelfRecordOtherRented(teamId, renterUid, renterGtid, refuse)
	for uid, teamInfo in pairs(self.rentSelfRecords) do
		for tid, groupTaskInfo in pairs(teamInfo) do
			if teamId == tid then
				for gtid, record in pairs(groupTaskInfo) do
					if (uid ~= renterUid or gtid ~= renterGtid) and record.status == Const.RENT_APPLY_STATUS.Applying then
						if refuse then
							record.status = Const.RENT_APPLY_STATUS.Refuse
						else
							record.status = Const.RENT_APPLY_STATUS.OtherRented
						end
					end
				end
			end
		end
	end
end

function RentTaskMixin:_revertSelfRecrodOtherRented(teamId)
	for uid, teamInfo in pairs(self.rentSelfRecords) do
		for tid, groupTaskInfo in pairs(teamInfo) do
			if tid == teamId then
				for gtid, record in pairs(groupTaskInfo) do
					if record.status == Const.RENT_APPLY_STATUS.OtherRented then
						record.status = Const.RENT_APPLY_STATUS.Applying
					end
				end
			end
		end
	end
end

function RentTaskMixin:checkSelfRecordOverdue(record, curTime)
	if record.status == Const.RENT_APPLY_STATUS.OverDue then
		return
	end

	curTime = curTime or ClientUtils.getServerTime()

	if record.overdueTick and curTime >= record.overdueTick then
		local needRevertOtherRented = record.status == Const.RENT_APPLY_STATUS.Accept

		record.status = Const.RENT_APPLY_STATUS.OverDue

		if needRevertOtherRented then
			self:_revertSelfRecrodOtherRented(record.teamId)
		end
	end
end

function RentTaskMixin:onRentTaskRefreshNotify(taskList)
	for i, taskSvrData in ipairs(taskList) do
		local data = self:_handleRentGroupTask(taskSvrData)

		self.rentTaskData[data.groupTaskId] = data

		local changedGtid = data.groupTaskId

		for uid, teamInfo in pairs(self.rentBorrowedTeams) do
			for teamId, record in pairs(teamInfo) do
				record[changedGtid] = nil
			end
		end

		self.rentMatchTimestamp[changedGtid] = nil
		self.rentMatchTeams[changedGtid] = nil
		self.rentChangeSelectTimeStamp[changedGtid] = nil
	end

	self:checkRentUnselectRD()
	self:checkRentBorrowRD()
	self:refreshRentMainUI(true)

	local needNotice = false
	local bossInfoDlg = UIManager.getUI("rentBossInfoDlg", nil, false)

	if bossInfoDlg then
		needNotice = true

		bossInfoDlg:setVisible(false)
	end

	local borrowDlg = UIManager.getUI("rentTeamBorrowDlg", nil, false)

	if borrowDlg then
		needNotice = true

		borrowDlg:setVisible(false)
	end

	if needNotice then
		MsgManager.clientNotice(378)
	end
end

function RentTaskMixin:onRentTaskRefreshResp(taskList)
	self.rentTaskData = self:_handleAllRentTask(taskList)

	for _, groupInfo in pairs(self.rentTaskData) do
		if groupInfo.selection == 0 then
			local changedGtid = groupInfo.groupTaskId

			for uid, teamInfo in pairs(self.rentBorrowedTeams) do
				for teamId, record in pairs(teamInfo) do
					record[changedGtid] = nil
				end
			end

			self.rentMatchTimestamp[changedGtid] = nil
			self.rentMatchTeams[changedGtid] = nil
		end
	end

	self:checkRentUnselectRD()
	self:checkRentBorrowRD()
	self:refreshRentMainUI()
end

function RentTaskMixin:onNewDayRent()
	self:checkRentUpWeek()
	self:rentWeekendClearGift()
end

function RentTaskMixin:rentWeekendClearGift(...)
	local dayIdxInWeek = tonumber(ClientUtils.getServerTimeData(nil, "%w"))

	if dayIdxInWeek == 0 then
		dayIdxInWeek = 7
	end

	local giftRefreshTime = ResRentMisc[1].gift_reset_time

	if giftRefreshTime == dayIdxInWeek then
		self.rentGiftNum = 0

		self:refreshRentMainUI()
	end
end

function RentTaskMixin:onRentTaskSelectResp(groupTaskId, taskId)
	for i, taskData in ipairs(self.rentTaskData) do
		if taskData.groupTaskId == groupTaskId then
			taskData.selection = taskId

			for _, battleStatus in pairs(taskData.taskItems) do
				for _, pve in ipairs(battleStatus) do
					pve.win = false
				end
			end
		end
	end

	for uid, teamInfo in pairs(self.rentBorrowedTeams) do
		for teamId, record in pairs(teamInfo) do
			record[groupTaskId] = nil
		end
	end

	self.rentMatchTimestamp[groupTaskId] = nil
	self.rentMatchTeams[groupTaskId] = nil
	self.rentChangeSelectTimeStamp[groupTaskId] = ClientUtils.getServerTime()

	self:checkRentUnselectRD()
	self:checkRentBorrowRD()
	self:refreshRentMainUI()

	local bossInfoDlg = UIManager.getUI("rentBossInfoDlg", true)

	bossInfoDlg:setRentBossInfo(groupTaskId)
end

function RentTaskMixin:onRentMatchResp(match_result, groupTaskId, tick, refresh_only)
	self.rentMatchTimestamp[groupTaskId] = tick
	self.rentMatchTeams[groupTaskId] = {}

	for _, matchItem in ipairs(match_result.match_item) do
		local uid = matchItem.uid

		for _, team in ipairs(matchItem.team_item) do
			local teamInfo = {}

			teamInfo.teamId = team.teamid
			teamInfo.canBorrow = team.can_rent == 1
			teamInfo.applyFull = team.is_apply_busy == 1
			teamInfo.otherUseDue = team.other_due_tick
			teamInfo.power = team.power
			teamInfo.uid = uid

			table.insert(self.rentMatchTeams[groupTaskId], teamInfo)
		end

		self.rentOtherGiftNum[uid] = matchItem.gift_num
	end

	if refresh_only == 1 then
		self:refreshRentBorrowUI()
	else
		self:initMatchTeamUI()
	end
end

function RentTaskMixin:onRentGetOwnerFormationResp(formation)
	self:_handleRentFormation(formation, false)
	self:refreshRentBorrowUI()
end

function RentTaskMixin:onRentGetRentedFormationResp(formation, gtid)
	for _, f in ipairs(formation) do
		self:_handleRentFormation(f, true)
	end

	self.rentSvrFocusGtid = gtid

	self:refreshRentBorrowUI()
end

function RentTaskMixin:onRentUpdateFormationResp(formation)
	self:_handleRentFormation(formation, true)
end

function RentTaskMixin:onRentRenterRentResp(groupTaskId, record)
	local recordInfo = self:_handleBorrowedRecord(record, groupTaskId)

	if recordInfo.status == Const.RENT_BORROW_STATUS.Success then
		recordInfo.newBorrowed = true
		recordInfo.formationDirty = true
	end

	self:checkRentBorrowRD()
	self:refreshRentBorrowUI()
	self:refreshRentMainUI()
	self:refreshRentBossInfoUI()
end

function RentTaskMixin:onRentRenterCancelResp(groupTaskId, record)
	local uid = record.uid
	local teamId = record.teamid

	if self.rentBorrowedTeams[uid] and self.rentBorrowedTeams[uid][teamId] then
		self.rentBorrowedTeams[uid][teamId][groupTaskId] = nil
	end

	self:checkRentBorrowRD()
	self:refreshRentBorrowUI()
	self:refreshRentMainUI()
	self:refreshRentBossInfoUI()
end

function RentTaskMixin:onRentOwnerAcceptResp(record, refuseOther)
	local record = self:_handleOwnerRecord(record)
	local status = record.status

	if status == Const.RENT_APPLY_STATUS.Accept then
		MsgManager.clientNotice(388)

		local teamId = record.teamId
		local renterUid = record.renterUid
		local groupTaskId = record.groupTaskId

		self:_setSelfRecordOtherRented(teamId, renterUid, groupTaskId, refuseOther == 1)
	end

	self:checkRentSelfNewRequest()
	self:refreshRentReceiveUI()
end

function RentTaskMixin:onRentOwnerRefuseResp(record)
	self:_handleOwnerRecord(record)
	MsgManager.clientNotice(387)
	self:checkRentSelfNewRequest()
	self:refreshRentReceiveUI()
end

function RentTaskMixin:onRentOwnerCancelResp(record)
	local recordInfo = self:_handleOwnerRecord(record)
	local teamId = recordInfo.teamId

	self:_revertSelfRecrodOtherRented(teamId)
	self:checkRentSelfNewRequest()
	self:refreshRentReceiveUI()
end

function RentTaskMixin:setOwnerRecordDirty(renterUid, selfTeamId, renterGtId)
	if self.rentSelfRecords[renterUid] and self.rentSelfRecords[renterUid][selfTeamId] and self.rentSelfRecords[renterUid][selfTeamId][renterGtId] then
		self.rentSelfRecords[renterUid][selfTeamId][renterGtId].dirtyToClear = true
	end
end

function RentTaskMixin:clearDirtyOwnerRecord()
	for renterUid, teamInfo in pairs(self.rentSelfRecords) do
		for teamId, groupInfo in pairs(teamInfo) do
			for gtid, record in pairs(groupInfo) do
				if record.dirtyToClear then
					self.rentSelfRecords[renterUid][teamId][gtid] = nil
				end
			end
		end
	end
end

function RentTaskMixin:onRentOwnerNotify(record, comm)
	local recordInfo = self:_handleOwnerRecord(record)

	if recordInfo.status == Const.RENT_APPLY_STATUS.Applying then
		self:addRentMsgNoticeCache(Const.RENT_NOTICE_TYPE.ReqMsg, recordInfo, comm)
	elseif recordInfo.status == Const.RENT_APPLY_STATUS.RenterCancel or recordInfo.status == Const.RENT_APPLY_STATUS.Complete or recordInfo.status == Const.RENT_APPLY_STATUS.OwnerCancel or recordInfo.status == Const.RENT_APPLY_STATUS.OverDue then
		local teamId = recordInfo.teamId
		local renterUid = recordInfo.renterUid
		local groupTaskId = recordInfo.groupTaskId

		self:_revertSelfRecrodOtherRented(teamId)
	elseif recordInfo.status == Const.RENT_APPLY_STATUS.Accept then
		local teamId = recordInfo.teamId
		local renterUid = recordInfo.renterUid
		local groupTaskId = recordInfo.groupTaskId

		self:_setSelfRecordOtherRented(teamId, renterUid, groupTaskId)
	end

	if comm and comm.uid then
		self:refreshRoleInfo(comm)
	end

	self:checkRentSelfNewRequest()
	self:refreshRentReceiveUI()
end

function RentTaskMixin:onRentRenterNotify(record, comm, gtid)
	local recordInfo = self:_handleBorrowedRecord(record, gtid)

	if recordInfo.status == Const.RENT_BORROW_STATUS.Success then
		recordInfo.newBorrowed = true
		recordInfo.formationDirty = true

		self:addRentMsgNoticeCache(Const.RENT_NOTICE_TYPE.RespMsg, recordInfo, comm)
	end

	if comm and comm.uid then
		self:refreshRoleInfo(comm)
	end

	self:checkRentBorrowRD()
	self:refreshRentMainUI()
	self:refreshRentBorrowUI()
	self:refreshRentBossInfoUI()
end

function RentTaskMixin:checkRentUpWeek(weekIdx)
	self.isRentUpWeek = self:calcRentUpWeek()

	self:refreshRentMainUI()
end

function RentTaskMixin:calcRentUpWeek(targetTick)
	targetTick = targetTick or ClientUtils.getServerTime()

	local upActStartTime = self:getRentUpActivityStartTime()

	if not upActStartTime then
		return false
	else
		local rentWeekIdx = math.floor((targetTick - upActStartTime) / Const.TIME_ONE_WEEK)
		local isUp = rentWeekIdx % 4 == 0
		local endTick

		if isUp then
			endTick = upActStartTime + (rentWeekIdx + 1) * Const.TIME_ONE_WEEK
		end

		return isUp, endTick
	end
end

function RentTaskMixin:refreshRentFormationSnapshot()
	if self:isFormationSnapShot(Const.FORMATION_RENT_TEAMS[1]) then
		for i = 1, self.rentMaxUnlockTeams do
			RPC.formationSnapshotGet(Const.FORMATION_RENT_TEAMS[i])
		end
	end
end

function RentTaskMixin:onRentSendLetterResp()
	MsgManager.notice(Lang.get(1899))

	local ui = UIManager.tryGetUI("rentTaskWriteLetterDlg")

	ui:onRentSendLetterSuccess()
end

function RentTaskMixin:onRentSendLetterRespError(ecode, hint)
	local writeLetter = UIManager.getUI("rentTaskWriteLetterDlg", nil, false)

	if ecode == "kCSErrorRentLetterAlreadySent" then
		MsgManager.clientNotice(386)

		if writeLetter then
			writeLetter:setVisible(false)
		end
	elseif ecode == "kCSErrorYiDunDirtyCommon" and writeLetter then
		writeLetter.btnLockFlag = false

		if hint and #hint > 0 then
			writeLetter:markInputIllegal(hint)
		end
	end
end

RentTaskMixin.rentLetters = {}

function RentTaskMixin:onRentGetLetterResp(letters)
	for i, l in ipairs(letters) do
		local recordLetter = self:_handleRentLetterData(l)

		if not self:checkRentLetterRepetition(recordLetter) then
			table.insert(self.rentLetters, recordLetter)
		end
	end

	local ui = UIManager.tryGetUI("rentTaskReceiveLetterDlg")

	if ui then
		ui:onRentGetLetter()
	end
end

RentTaskMixin.rentSendLetters = {}

function RentTaskMixin:onRentGetSendLetterResp(letters)
	for i, l in ipairs(letters) do
		local recordLetter = self:_handleRentLetterData(l)

		if not self:checkRentSendLetterRepetition(recordLetter) then
			table.insert(self.rentSendLetters, recordLetter)
		end
	end

	local ui = UIManager.tryGetUI("rentSendLetterListDlg")

	if ui then
		ui:onRentGetSendLetter()
	end
end

function RentTaskMixin:onRentLetterNotify(letter, giftNum)
	local recordLetter = self:_handleRentLetterData(letter)

	recordLetter.isNew = true

	local existLetter = self:checkRentLetterRepetition(recordLetter)

	if existLetter then
		existLetter.isNew = true
	else
		table.insert(self.rentLetters, 1, recordLetter)
	end

	self:checkRentNewLetterRD()
	self:addRentMsgNoticeCache(Const.RENT_NOTICE_TYPE.Letter, recordLetter, recordLetter.roleCommInfo)

	self.rentGiftNum = giftNum

	self:refreshRentMainUI()
	self:refreshRentLetterListUI()
end

function RentTaskMixin:onRentSendLetterNotify(letter)
	local recordLetter = self:_handleRentLetterData(letter)

	recordLetter.isNew = true

	local existLetter = self:checkRentSendLetterRepetition(recordLetter)

	if existLetter then
		existLetter.isNew = true
	else
		table.insert(self.rentSendLetters, 1, recordLetter)
	end

	self:checkRentNewSendLetterRD()
	self:refreshRentSendLetterListUI()
end

function RentTaskMixin:checkRentLetterRepetition(recordLetter)
	local curReplayId = recordLetter.replayId

	for _, letter in ipairs(self.rentLetters) do
		if curReplayId == letter.replayId then
			return letter
		end
	end
end

function RentTaskMixin:checkRentSendLetterRepetition(recordLetter)
	local curReplayId = recordLetter.replayId

	for _, letter in ipairs(self.rentSendLetters) do
		if curReplayId == letter.replayId then
			return letter
		end
	end
end

function RentTaskMixin:onRentWaitLetterNotify(letter)
	self.rentTaskNeedOpenWriteLetterDlg = true
end

function RentTaskMixin:onRentTaskCompletBattle()
	self.rentTaskNeedOpenWriteLetterDlg = true
	self.rentTaskCompletTime = Time.time
end

function RentTaskMixin:onRentSetAutoAcceptResp(auto_accept)
	self.autoAcceptRequest = auto_accept == 1

	self:refreshRentReceiveUI()
end

function RentTaskMixin:addRentMsgNoticeCache(msgType, recordInfo, playerComm)
	local msgNeedCache = false

	if msgType == Const.RENT_NOTICE_TYPE.Letter then
		if self.rentLetterNoticeOn then
			msgNeedCache = true
		end
	elseif self.rentMsgNoticeOn then
		msgNeedCache = true
	end

	if msgNeedCache then
		RentMsgManager.addRentMsg(msgType, recordInfo, playerComm)
	end
end

function RentTaskMixin:refreshRentMainUI(forceInit)
	local rentMainDlg = UIManager.getUI("rentTaskMainDlg", nil, false)

	if rentMainDlg then
		rentMainDlg:refreshRentTasks(nil, forceInit)
	end
end

function RentTaskMixin:refreshRentLetterListUI(...)
	local rentTaskReceiveLetterDlg = UIManager.getUI("rentTaskReceiveLetterDlg", nil, false)

	if rentTaskReceiveLetterDlg then
		rentTaskReceiveLetterDlg:refreshLetterPanel()
	end
end

function RentTaskMixin:refreshRentSendLetterListUI(...)
	local RentSendLetterListDlg = UIManager.getUI("rentSendLetterListDlg", nil, false)

	if RentSendLetterListDlg then
		RentSendLetterListDlg:refresh()
	end
end

function RentTaskMixin:refreshRentReceiveUI(...)
	local rentMsgDlg = UIManager.getUI("rentTaskReceiveLetterDlg", nil, false)

	if rentMsgDlg then
		rentMsgDlg:refreshReceivePanel()
	end
end

function RentTaskMixin:refreshRentBossInfoUI(...)
	local bossInfoDlg = UIManager.getUI("rentBossInfoDlg", nil, false)

	if bossInfoDlg then
		bossInfoDlg:refresRentBossInfo()
	end
end

function RentTaskMixin:refreshRentBorrowUI(...)
	local borrowDlg = UIManager.getUI("rentTeamBorrowDlg", nil, false)

	if borrowDlg then
		borrowDlg:refreshTeamBorrowInfo()
	end
end

function RentTaskMixin:initMatchTeamUI()
	local borrowDlg = UIManager.getUI("rentTeamBorrowDlg", nil, false)

	if borrowDlg then
		borrowDlg:initMatchTeams()
	end
end

function RentTaskMixin:_handleAllRentTask(taskList)
	local taskData = {}

	for i, groupInfo in ipairs(taskList) do
		local data = self:_handleRentGroupTask(groupInfo)

		table.insert(taskData, data)
	end

	return taskData
end

function RentTaskMixin:_handleRentGroupTask(groupInfo)
	local data = {}

	data.groupTaskId = groupInfo.gtid
	data.overdueTick = groupInfo.duetick

	if ClientUtils.getServerTime() >= data.overdueTick then
		data.taskStatus = Const.RENT_GROUPTASK_STATUS.OverDue
	else
		data.taskStatus = groupInfo.status
	end

	data.selection = groupInfo.selected_id
	data.stage = groupInfo.stage
	data.svrMaxStage = groupInfo.max_stage

	local taskItems = {}
	local taskList = {}

	for _, taskItem in ipairs(groupInfo.task_item) do
		local taskId = taskItem.id
		local taskType = taskItem.type
		local battleStatus = {}

		for _, battleInfo in ipairs(taskItem.pve) do
			table.insert(battleStatus, {
				teamId = battleInfo.teamid,
				win = battleInfo.win == 1
			})
		end

		taskItems[taskId] = battleStatus

		table.insert(taskList, taskId)
	end

	table.sort(taskList, function(a, b)
		return a < b
	end)

	data.taskItems = taskItems
	data.taskList = taskList
	self.rentChangeSelectTimeStamp[data.groupTaskId] = groupInfo.selected_tick

	return data
end

function RentTaskMixin:_handleRentFormation(formation, isRented)
	local uid = formation.uid
	local teamId = formation.teamid
	local formationData = formation.data

	if isRented then
		if not self.rentFormationDict[uid] then
			self.rentFormationDict[uid] = {}
		end

		self.rentFormationDict[uid][teamId] = formationData
	else
		if not self.matchFormationDict[uid] then
			self.matchFormationDict[uid] = {}
		end

		self.matchFormationDict[uid][teamId] = formationData
	end
end

function RentTaskMixin:_handleOwnerRecord(record)
	local renterUid = record.uid
	local renterGtId = record.gtid
	local selfTeamId = record.teamid
	local recordInfo = {}

	recordInfo.renterUid = renterUid
	recordInfo.groupTaskId = renterGtId
	recordInfo.taskId = record.taskid
	recordInfo.status = record.status
	recordInfo.acceptTick = record.accept_tick
	recordInfo.overdueTick = record.duetick
	recordInfo.taskList = utils.getNumListFromString(record.taskidstr, ",")
	recordInfo.teamId = selfTeamId
	recordInfo.applyTick = record.applytick or 0

	if not self.rentSelfRecords[renterUid] then
		self.rentSelfRecords[renterUid] = {}
	end

	if not self.rentSelfRecords[renterUid][selfTeamId] then
		self.rentSelfRecords[renterUid][selfTeamId] = {}
	end

	self.rentSelfRecords[renterUid][selfTeamId][renterGtId] = recordInfo

	return recordInfo
end

function RentTaskMixin:_handleBorrowedRecord(record, groupTaskId)
	local uid = record.uid
	local teamId = record.teamid
	local recordInfo = {}

	recordInfo.record_id = record.rent_unique_id
	recordInfo.status = record.status
	recordInfo.requestTick = record.rent_tick
	recordInfo.groupTaskId = groupTaskId
	recordInfo.uid = uid
	recordInfo.teamId = teamId
	recordInfo.otherUseDue = record.other_due_tick

	local groupTaskData = self.rentTaskData[groupTaskId]

	if groupTaskData and groupTaskData.overdueTick then
		recordInfo.overdueTick = groupTaskData.overdueTick
	end

	if not self.rentBorrowedTeams[uid] then
		self.rentBorrowedTeams[uid] = {}
	end

	if not self.rentBorrowedTeams[uid][teamId] then
		self.rentBorrowedTeams[uid][teamId] = {}
	end

	self.rentBorrowedTeams[uid][teamId][groupTaskId] = recordInfo

	return recordInfo
end

function RentTaskMixin:_handleRentLetterData(letter)
	local letterInfo = {}

	letterInfo.content = letter.content

	local baseData = letter.base

	letterInfo.groupTaskId = baseData.gtid
	letterInfo.replayId = baseData.replay_id
	letterInfo.mvpId = baseData.mvpid
	letterInfo.taskIdstr = baseData.taskidstr
	letterInfo.taskId = baseData.taskid
	letterInfo.textId = baseData.textid
	letterInfo.formInfo = baseData.formation
	letterInfo.roleCommInfo = baseData.comm
	letterInfo.giftNum = letter.gift_num or 0

	return letterInfo
end

function RentTaskMixin:_loadRentAutoOpenDlg(...)
	local flag = UserData.loadCommonData("RentOpenDlg")

	if not flag or flag == "" then
		self:setAutoOpenUIFlag(true)
	else
		self.rentMsgNoticeOn = flag == "1"
	end
end

function RentTaskMixin:setAutoOpenUIFlag(autoOpen)
	self.rentMsgNoticeOn = autoOpen

	if autoOpen then
		UserData.saveCommonData("RentOpenDlg", "1")
	else
		UserData.saveCommonData("RentOpenDlg", "0")
		RentMsgManager.clearRentMsg()
	end
end

function RentTaskMixin:_loadShowLetterNotice(...)
	local flag = UserData.loadCommonData("RentLetterNoticeOn")

	if not flag or flag == "" then
		self:setShowLetterNotice(true)
	else
		self.rentLetterNoticeOn = flag == "1"
	end
end

function RentTaskMixin:setShowLetterNotice(isShow)
	self.rentLetterNoticeOn = isShow

	if isShow then
		UserData.saveCommonData("RentLetterNoticeOn", "1")
	else
		UserData.saveCommonData("RentLetterNoticeOn", "0")
		RentMsgManager.clearRentMsg()
	end
end

function RentTaskMixin:checkRentNewTaskRD(lastRefreshTick)
	if not self.rentTaskFlag then
		return
	end
end

function RentTaskMixin:checkRentUnselectRD(...)
	if not self.rentTaskFlag then
		return
	end

	local rentData = self.rentTaskData
	local hasNew = false

	for _, groupInfo in pairs(rentData) do
		local gtid = groupInfo.groupTaskId

		hasNew = self:checkRentGroupTaskUnselectRD(gtid)

		if hasNew then
			break
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_RENT_UNSELECT, hasNew)
end

function RentTaskMixin:checkRentGroupTaskUnselectRD(groupTaskId)
	if not self.rentTaskFlag then
		return
	end

	local taskData = self.rentTaskData[groupTaskId]

	if not taskData or taskData.taskStatus == Const.RENT_GROUPTASK_STATUS.Complete or taskData.taskStatus == Const.RENT_GROUPTASK_STATUS.Thanked or taskData.taskStatus == Const.RENT_GROUPTASK_STATUS.OverDue then
		return false
	end

	local selection = taskData.selection

	return selection == 0
end

function RentTaskMixin:checkRentBorrowRD(...)
	if not self.rentTaskFlag then
		return
	end

	local rentData = self.rentTaskData
	local hasNew = false

	for _, groupInfo in pairs(rentData) do
		local gtid = groupInfo.groupTaskId

		hasNew = self:checkRentGroupTaskUnBorrowRD(gtid) or self:checkRentGroupTaskBorrowSucRD(gtid)

		if hasNew then
			break
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_RENT_BORROW, hasNew)
end

function RentTaskMixin:checkRentGroupTaskUnBorrowRD(groupTaskId)
	if not self.rentTaskFlag then
		return
	end

	local taskData = self.rentTaskData[groupTaskId]

	if taskData.selection == 0 or taskData.taskStatus == Const.RENT_GROUPTASK_STATUS.Complete or taskData.taskStatus == Const.RENT_GROUPTASK_STATUS.Thanked or taskData.taskStatus == Const.RENT_GROUPTASK_STATUS.OverDue then
		return false
	end

	local taskId = taskData.selection

	if not ResRentTask[taskId] then
		return false
	end

	local taskType = ResRentTask[taskId].type

	if taskType == Const.RENT_TASK_TYPE.Normal then
		return false
	end

	local battleStatus = taskData.taskItems[taskId]

	if battleStatus[1].win and not battleStatus[2].win then
		local hasRequest = false
		local recordData = self.rentBorrowedTeams

		for uid, teams in pairs(recordData) do
			for teamId, record in pairs(teams) do
				if record[groupTaskId] and (record[groupTaskId].status == Const.RENT_BORROW_STATUS.Wait or record[groupTaskId].status == Const.RENT_BORROW_STATUS.Success) then
					hasRequest = true

					break
				end
			end
		end

		return not hasRequest
	else
		return false
	end
end

function RentTaskMixin:checkRentGroupTaskBorrowSucRD(groupTaskId)
	if not self.rentTaskFlag then
		return
	end

	local taskData = self.rentTaskData[groupTaskId]

	if taskData.selection == 0 or taskData.taskStatus == Const.RENT_GROUPTASK_STATUS.Complete or taskData.taskStatus == Const.RENT_GROUPTASK_STATUS.Thanked or taskData.taskStatus == Const.RENT_GROUPTASK_STATUS.OverDue then
		return false
	end

	local taskId = taskData.selection

	if not ResRentTask[taskId] then
		return false
	end

	local taskType = ResRentTask[taskId].type

	if taskType == Const.RENT_TASK_TYPE.Normal then
		return false
	end

	for uid, teamInfo in pairs(self.rentBorrowedTeams) do
		for teamId, record in pairs(teamInfo) do
			local recordInfo = record[groupTaskId]

			if recordInfo and recordInfo.newBorrowed then
				return true
			end
		end
	end

	return false
end

function RentTaskMixin:checkRentNewLetterRD()
	if not self.rentTaskFlag then
		return
	end

	local result = false
	local letters = self.rentLetters

	for i, letter in ipairs(letters) do
		if letter.isNew then
			result = true

			break
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_RENT_NEWLETTER, result)
end

function RentTaskMixin:checkRentNewSendLetterRD()
	if not self.rentTaskFlag then
		return
	end

	local result = false
	local letters = self.rentSendLetters

	for i, letter in ipairs(letters) do
		if letter.isNew then
			result = true

			break
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_RENT_NEWSENDLETTER, false)
end

function RentTaskMixin:checkRentSelfNewRequest()
	if not self.rentTaskFlag then
		return
	end

	local hasNewRequest = false
	local curTime = ClientUtils.getServerTime()

	for renterUid, teamInfo in pairs(self.rentSelfRecords) do
		for teamId, groupInfo in pairs(teamInfo) do
			for gtid, record in pairs(groupInfo) do
				self:checkSelfRecordOverdue(record, curTime)
			end
		end
	end

	for renterUid, teamInfo in pairs(self.rentSelfRecords) do
		for teamId, groupInfo in pairs(teamInfo) do
			for gtid, record in pairs(groupInfo) do
				if record.status == Const.RENT_APPLY_STATUS.Applying then
					hasNewRequest = true
				end
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_RENT_NEWREQ, hasNewRequest)
end

function RentTaskMixin:getRentedPetByTeamId(teamUid, teamId)
	local pets = {}
	local pet = utils.getBattleFormationPet(self.rentFormationDict[teamUid][teamId].pet)

	if pet then
		table.insert(pets, utils.getBattleFormationPet(self.rentFormationDict[teamUid][teamId].pet))
	end

	return pets
end

return RentTaskMixin
