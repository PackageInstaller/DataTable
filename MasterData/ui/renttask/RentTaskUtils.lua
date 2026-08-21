-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentTaskUtils.lua

local ResRentTask = require("ClientData/ResRentTask")
local ResRentMisc = require("ClientData/ResRentMisc")
local OtherPlayer = require("Common/Object/OtherPlayer")
local ResRentLetterText = require("ClientData/ResRentLetterText")
local ResHero = require("ClientData/ResHero")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResRentTeamConfig = require("ClientData/ResRentTeamConfig")
local RentTaskUtils = {}

RentTaskUtils.NoticeList = {
	nil,
	359,
	360,
	361,
	nil,
	362,
	363,
	364,
	365,
	366,
	382,
	390,
	387,
	388,
	389
}

function RentTaskUtils.getRentNotice(idx)
	local noticeId = RentTaskUtils.NoticeList[idx]

	return ResClientNotice[noticeId].notice or ""
end

function RentTaskUtils.refreshRentTask(...)
	if CurAvatar.rentTaskNeedRefresh then
		RPC.rentTaskRefresh()

		CurAvatar.rentTaskNeedRefresh = false

		RedDotManager.setKeyState(UIConst.RD_HINT_RENT_NEWTASK, CurAvatar.rentTaskNeedRefresh)
	end
end

function RentTaskUtils.selectRentTask(groupTaskId, taskId)
	RPC.rentTaskSelect(groupTaskId, taskId)
end

function RentTaskUtils.getTaskData(taskId)
	if not ResRentTask[taskId] then
		return
	end

	return ResRentTask[taskId]
end

function RentTaskUtils.getGroupTaskSvrData(groupTaskId)
	local rentData = CurAvatar.rentTaskData
	local nowTime = ClientUtils.getServerTime()

	for _, groupInfo in ipairs(rentData) do
		if groupInfo.taskStatus ~= Const.RENT_GROUPTASK_STATUS.OverDue and nowTime >= groupInfo.overdueTick then
			groupInfo.taskStatus = Const.RENT_GROUPTASK_STATUS.OverDue
		end
	end

	if groupTaskId then
		for _, groupInfo in ipairs(rentData) do
			if groupInfo.groupTaskId == groupTaskId then
				return groupInfo
			end
		end
	else
		return rentData
	end
end

function RentTaskUtils.groupTaskReplaceAward(groupTaskId)
	local groupInfo = RentTaskUtils.getGroupTaskSvrData(groupTaskId)

	if groupInfo and groupInfo.stage then
		local replaceAwardStage = RentTaskUtils.getReplaceAwardStage()

		return replaceAwardStage <= groupInfo.stage
	end

	return false
end

function RentTaskUtils.isGroupTaskValid(groupTaskId)
	local groupInfo = RentTaskUtils.getGroupTaskSvrData(groupTaskId)

	if groupInfo then
		return groupInfo.taskStatus ~= Const.RENT_GROUPTASK_STATUS.OverDue and groupInfo.taskStatus ~= Const.RENT_GROUPTASK_STATUS.Complete and groupInfo.taskStatus ~= Const.RENT_GROUPTASK_STATUS.Thanked
	end

	return false
end

function RentTaskUtils.getGroupTaskMaxStage(groupTaskId)
	local groupInfo = RentTaskUtils.getGroupTaskSvrData(groupTaskId)

	if groupInfo and groupInfo.svrMaxStage then
		return groupInfo.svrMaxStage
	end
end

function RentTaskUtils.getGroupTaskTitle(taskList)
	local titleWords = {}

	for i, taskId in ipairs(taskList) do
		local taskInfo = RentTaskUtils.getTaskData(taskId)

		if taskInfo and taskInfo.task_title_word then
			table.insert(titleWords, taskInfo.task_title_word)
		end
	end

	if #titleWords >= 2 then
		if RegionUtils.isJP() then
			return titleWords[1] .. "：" .. titleWords[2]
		else
			local title = titleWords[1] .. titleWords[2]

			return title
		end
	end
end

function RentTaskUtils.getGroupTaskTitleByGtid(groupTaskId)
	local rentTaskData = RentTaskUtils.getGroupTaskSvrData(groupTaskId)

	if rentTaskData and rentTaskData.taskList then
		return RentTaskUtils.getGroupTaskTitle(rentTaskData.taskList)
	end
end

function RentTaskUtils.getTaskTitle(taskId)
	local taskData = RentTaskUtils.getTaskData(taskId)

	if taskData then
		return taskData.task_name
	end
end

function RentTaskUtils.getTaskType(taskId)
	local taskData = RentTaskUtils.getTaskData(taskId)

	if taskData then
		return taskData.type
	end
end

function RentTaskUtils.hasMultiBattle(taskId)
	local taskInfo = RentTaskUtils.getTaskData(taskId)

	if taskInfo and taskInfo.type ~= Const.RENT_TASK_TYPE.Normal then
		return true
	end

	return false
end

function RentTaskUtils.getTaskStatus(taskId, taskSvrItem)
	local taskInfo = RentTaskUtils.getTaskData(taskId)

	if taskInfo and taskInfo.type then
		local taskType = taskInfo.type
		local battleCount

		battleCount = taskType == Const.RENT_TASK_TYPE.Normal and 1 or 2

		local finishBattleCount = 0

		for _, battleInfo in ipairs(taskSvrItem) do
			if battleInfo.win then
				finishBattleCount = finishBattleCount + 1
			end
		end

		if finishBattleCount == 0 then
			return Const.RENT_TASK_STATUS.New
		elseif battleCount <= finishBattleCount then
			return Const.RENT_TASK_STATUS.Complete
		elseif battleCount > 1 and finishBattleCount < battleCount then
			return Const.RENT_TASK_STATUS.FinishHalf
		end
	end

	return Const.RENT_TASK_STATUS.New
end

function RentTaskUtils.getFirstNewGtid()
	local rentData = CurAvatar.rentTaskData

	for _, groupInfo in pairs(rentData) do
		local gtid = groupInfo.groupTaskId

		if CurAvatar:checkRentGroupTaskUnselectRD(gtid) then
			return gtid
		end
	end
end

function RentTaskUtils.getFirstHasNewGtid(...)
	local rentData = CurAvatar.rentTaskData

	for _, groupInfo in pairs(rentData) do
		local gtid = groupInfo.groupTaskId

		if RentTaskUtils.gtidHasNew(gtid) then
			return gtid
		end
	end
end

function RentTaskUtils.gtidHasNew(gtid)
	return CurAvatar:checkRentGroupTaskUnselectRD(gtid) or CurAvatar:checkRentGroupTaskUnBorrowRD(gtid) or CurAvatar:checkRentGroupTaskBorrowSucRD(gtid)
end

RentTaskUtils.MATCH_REQUEST_CD = 125

function RentTaskUtils.getMatchTeams(groupTaskId)
	if CurAvatar.rentMatchTeams[groupTaskId] then
		return CurAvatar.rentMatchTeams[groupTaskId]
	end
end

function RentTaskUtils.updateMatchTeamPower(groupTaskId, uid, teamId, power)
	if CurAvatar.rentMatchTeams[groupTaskId] then
		local teams = CurAvatar.rentMatchTeams[groupTaskId]

		for i, team in ipairs(teams) do
			if team.teamId == teamId and team.uid == uid then
				team.calcPower = power
			end
		end
	end
end

function RentTaskUtils.rematchTeams(groupTaskId)
	local nowTime = ClientUtils.getServerTime()

	if not CurAvatar.rentMatchTimestamp[groupTaskId] or nowTime > CurAvatar.rentMatchTimestamp[groupTaskId] + RentTaskUtils.MATCH_REQUEST_CD then
		RPC.rentMatch(groupTaskId, 0)

		CurAvatar.rentMatchTimestamp[groupTaskId] = nowTime

		return true
	end

	return false
end

function RentTaskUtils.refreshMatchTeams(groupTaskId)
	local nowTime = ClientUtils.getServerTime()

	if not CurAvatar.rentMatchTimestamp[groupTaskId] or nowTime > CurAvatar.rentMatchTimestamp[groupTaskId] + RentTaskUtils.MATCH_REQUEST_CD then
		RPC.rentMatch(groupTaskId, 1)

		CurAvatar.rentMatchTimestamp[groupTaskId] = nowTime
	end
end

function RentTaskUtils.borrowTeam(groupTaskId, uid, teamId)
	RPC.rentRenterRent(groupTaskId, uid, teamId)
end

function RentTaskUtils.cancelBorrowTeam(groupTaskId, uid, teamId)
	RPC.rentRenterCancel(groupTaskId, uid, teamId)
end

function RentTaskUtils.teamInBorrowList(uid, teamId, groupTaskId)
	return CurAvatar.rentBorrowedTeams[uid] ~= nil and CurAvatar.rentBorrowedTeams[uid][teamId] ~= nil and CurAvatar.rentBorrowedTeams[uid][teamId][groupTaskId] ~= nil
end

function RentTaskUtils.getBorrowRecord(uid, teamId, groupTaskId)
	local rentBorrowedTeams = CurAvatar.rentBorrowedTeams

	if rentBorrowedTeams[uid] and rentBorrowedTeams[uid][teamId] and rentBorrowedTeams[uid][teamId][groupTaskId] then
		local record = rentBorrowedTeams[uid][teamId][groupTaskId]

		if record.status == Const.RENT_BORROW_STATUS.InUse and record.otherUseDue < ClientUtils.getServerTime() then
			record.status = Const.RENT_BORROW_STATUS.Wait
		end

		return record
	end
end

function RentTaskUtils.getBorrowRecordStatus(uid, teamId, groupTaskId)
	local record = RentTaskUtils.getBorrowRecord(uid, teamId, groupTaskId)

	if not record then
		return
	end

	return record.status
end

function RentTaskUtils.getBorrowRecordList(groupTaskId)
	local recordList = {}
	local recordData = CurAvatar.rentBorrowedTeams

	for uid, teams in pairs(recordData) do
		for teamId, records in pairs(teams) do
			if records[groupTaskId] then
				local record = RentTaskUtils.getBorrowRecord(uid, teamId, groupTaskId)

				if record.status == Const.RENT_BORROW_STATUS.Wait or record.status == Const.RENT_BORROW_STATUS.Success or record.status == Const.RENT_BORROW_STATUS.InUse then
					table.insert(recordList, record)
				end
			end
		end
	end

	return recordList
end

function RentTaskUtils.getRequestCount(groupTaskId)
	local recordList = RentTaskUtils.getBorrowRecordList(groupTaskId)
	local requestCount = 0

	for _, record in ipairs(recordList) do
		if record.status == Const.RENT_BORROW_STATUS.Wait or record.status == Const.RENT_BORROW_STATUS.Success or record.status == Const.RENT_BORROW_STATUS.InUse then
			requestCount = requestCount + 1
		end
	end

	return requestCount
end

function RentTaskUtils.checkBorrowerRecordInStatus(uid, teamId, groupTaskId, status)
	local recordStatus = RentTaskUtils.getBorrowRecordStatus(uid, teamId, groupTaskId)

	if recordStatus and recordStatus == status then
		return true
	end

	return false
end

function RentTaskUtils.checkBorrowerRecordNewBorrowed(uid, teamId, groupTaskId)
	local record = RentTaskUtils.getBorrowRecord(uid, teamId, groupTaskId)

	if not record then
		return false
	end

	return record.status == Const.RENT_BORROW_STATUS.Success and record.newBorrowed
end

RentTaskUtils.GET_RENTED_FORMATION_CD = 0
RentTaskUtils.GET_MATCH_FORMATION_CD = 125

function RentTaskUtils.getAllBorrowedTeam(groupTaskId)
	local nowTime = ClientUtils.getServerTime()

	if not CurAvatar.rentFormationTimeStamp[groupTaskId] or nowTime > CurAvatar.rentFormationTimeStamp[groupTaskId] then
		RPC.rentGetRentedFormation(groupTaskId)

		CurAvatar.rentFormationTimeStamp[groupTaskId] = nowTime + RentTaskUtils.GET_RENTED_FORMATION_CD
	end
end

function RentTaskUtils.getRentForamtion(uid, teamId)
	local formationDict = CurAvatar.rentFormationDict

	if formationDict[uid] and formationDict[uid][teamId] then
		return formationDict[uid][teamId]
	end
end

function RentTaskUtils.getTeamOriFormation(uid, teamIdList)
	local nowTime = ClientUtils.getServerTime()

	if not CurAvatar.matchFormationTimeStamp[uid] or nowTime > CurAvatar.matchFormationTimeStamp[uid] then
		RPC.rentGetOwnerFormation(uid, teamIdList)

		CurAvatar.matchFormationTimeStamp[uid] = nowTime + RentTaskUtils.GET_MATCH_FORMATION_CD
	end
end

function RentTaskUtils.getMatchFormation(uid, teamId)
	local formationDict = CurAvatar.matchFormationDict

	if formationDict[uid] and formationDict[uid][teamId] then
		return formationDict[uid][teamId]
	end
end

function RentTaskUtils.updateTeamFormation(groupTaskId, uid, teamId, posList)
	RPC.rentUpdateFormation(groupTaskId, uid, teamId, posList)
end

function RentTaskUtils.selfMaxTeamCount()
	return #ResRentTeamConfig
end

function RentTaskUtils.acceptBorrowRequest(groupTaskId, uid, teamId)
	if not RentTaskUtils.checkOwnerRecordInStatus(groupTaskId, uid, teamId, Const.RENT_APPLY_STATUS.Applying) then
		return
	end

	local allRecords = RentTaskUtils.getAllOwnerRecords(teamId, Const.RENT_APPLY_STATUS.Applying)

	if #allRecords > 1 then
		local function yesFunc(groupTaskId, uid, teamId)
			RPC.rentOwnerAccept(groupTaskId, uid, teamId, 1)
		end

		local function noFunc(groupTaskId, uid, teamId)
			RPC.rentOwnerAccept(groupTaskId, uid, teamId, 0)
		end

		UIManager.showConfirmWithId(1027, Functor(yesFunc, groupTaskId, uid, teamId), Functor(noFunc, groupTaskId, uid, teamId), nil, nil)
	else
		RPC.rentOwnerAccept(groupTaskId, uid, teamId, 0)
	end
end

function RentTaskUtils.refuseBorrowRequest(groupTaskId, uid, teamId)
	RPC.rentOwnerRefuse(groupTaskId, uid, teamId)
end

function RentTaskUtils.cancelLentedTeam(groupTaskId, uid, teamId)
	RPC.rentOwnerCancel(groupTaskId, uid, teamId)
end

function RentTaskUtils.checkOwnerRecordInStatus(groupTaskId, uid, teamId, status)
	local recordStatus = RentTaskUtils.getOwnerRecrodStatus(groupTaskId, uid, teamId)

	if recordStatus then
		return recordStatus == status
	end

	return false
end

function RentTaskUtils.getOwnerRecrodStatus(groupTaskId, uid, teamId)
	if CurAvatar.rentSelfRecords[uid] and CurAvatar.rentSelfRecords[uid][teamId] and CurAvatar.rentSelfRecords[uid][teamId][groupTaskId] then
		local record = CurAvatar.rentSelfRecords[uid][teamId][groupTaskId]

		CurAvatar:checkSelfRecordOverdue(record)

		return record.status
	end
end

function RentTaskUtils.getAllOwnerRecords(targetTeamId, targetStatus)
	local rentSelfRecords = CurAvatar.rentSelfRecords
	local recordList = {}
	local curTime = ClientUtils.getServerTime()

	for uid, taskRecordInfo in pairs(rentSelfRecords) do
		for tid, teamRecords in pairs(taskRecordInfo) do
			for gtid, record in pairs(teamRecords) do
				CurAvatar:checkSelfRecordOverdue(record, curTime)
			end
		end
	end

	for uid, taskRecordInfo in pairs(rentSelfRecords) do
		for teamId, teamRecords in pairs(taskRecordInfo) do
			if not targetTeamId or teamId == targetTeamId then
				for gtid, info in pairs(teamRecords) do
					if not targetStatus or info.status == targetStatus then
						table.insert(recordList, info)
					end
				end
			end
		end
	end

	return recordList
end

function RentTaskUtils.getAllRenters()
	local rentSelfRecords = CurAvatar.rentSelfRecords
	local renterList = {}

	for uid, taskRecordInfo in pairs(rentSelfRecords) do
		table.insert(renterList, uid)
	end

	return renterList
end

function RentTaskUtils.teamIsBusy(teamId)
	local rentSelfRecords = CurAvatar.rentSelfRecords

	for uid, teamInfos in pairs(rentSelfRecords) do
		for tid, teamInfo in pairs(teamInfos) do
			if tid == teamId then
				for gtid, recordInfo in pairs(teamInfo) do
					CurAvatar:checkSelfRecordOverdue(recordInfo)

					if recordInfo.status == Const.RENT_APPLY_STATUS.Accept then
						return true
					end
				end
			end
		end
	end

	return false
end

function RentTaskUtils.sendLetterOfThanks(uid, teamId, content)
	RPC.rentSendLetter(uid, content, teamId)
end

function RentTaskUtils.getAllLetters()
	RPC.rentGetLetter()
end

function RentTaskUtils.getAllSendLetters()
	RPC.rentGetSendLetter()
end

function RentTaskUtils.getTotalHelpCount()
	if CurAvatar then
		return CurAvatar:getAchieveProcessByType(Const.ACHIEVE_TYPE_RENT_HELP)
	end
end

function RentTaskUtils.setAutoAccept(autoAccept)
	RPC.rentSetAutoAccept(autoAccept and 1 or 0)
end

function RentTaskUtils.addConfidant(uid)
	if CurAvatar.friendList[uid] and not CurAvatar.friendList[uid].isMyConfidant then
		local nowCount = CurAvatar:getConfidantCount()
		local maxCount = RentTaskUtils.getConfidantMaxNum()

		if nowCount < maxCount then
			RPC.buddyBondSet(uid, 1)
		else
			MsgManager.notice(Lang.get(30727))
		end
	end
end

function RentTaskUtils.delConfidant(uid)
	if CurAvatar.friendList[uid] and CurAvatar.friendList[uid].isMyConfidant then
		RPC.buddyBondSet(uid, 0)
	end
end

function RentTaskUtils.setRelationImage(uiObj, uid, beBonded, uiObjExtra)
	local uiObjVisible = false
	local uiObjPath
	local uiObjExtraVisible = false
	local isConfidant

	if beBonded then
		isConfidant = CurAvatar:setConfidantOnMe(uid)
	else
		isConfidant = CurAvatar:isMyConfidant(uid)
	end

	if isConfidant then
		if beBonded then
			uiObjExtraVisible = true
		else
			uiObjVisible = true
			uiObjPath = "IconConfidant"
		end
	elseif CurAvatar:isMyFriend(uid) then
		uiObjVisible = true
		uiObjPath = "IconFriend"
	elseif CurAvatar:playerInMyCircle(uid) then
		uiObjVisible = true
		uiObjPath = "IconCircle" or uiObjPath
	end

	uiObj:setVisible(uiObjVisible)

	if uiObjVisible and uiObjPath then
		uiObj:setImage("Atlas/FriendAtlas/FriendAtlas", uiObjPath)
	end

	if beBonded and uiObjExtra then
		uiObjExtra:setVisible(uiObjExtraVisible)
	end
end

function RentTaskUtils.setRelationImageBeBonded(uiObj, uid, uiObjExtra)
	local inMyCircle = CurAvatar:playerInMyCircle(uid)
	local isMyFriend = CurAvatar:isMyFriend(uid)
	local isMyConfidant = CurAvatar:isMyConfidant(uid)
	local setMeConfidant = CurAvatar:setConfidantOnMe(uid)

	if isMyConfidant then
		uiObj:setVisible(true)
		uiObj:setImage("Atlas/FriendAtlas/FriendAtlas", "IconConfidant")
	elseif isMyFriend then
		uiObj:setVisible(true)
		uiObj:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFriend")
	elseif inMyCircle then
		uiObj:setVisible(true)
		uiObj:setImage("Atlas/FriendAtlas/FriendAtlas", "IconCircle")
	else
		uiObj:setVisible(false)
	end
end

function RentTaskUtils.getMiscData()
	return ResRentMisc[1]
end

function RentTaskUtils.getGiftWeekLimit(...)
	if RentTaskUtils.isActivityActive() then
		return ResRentMisc[1].gift_upweek_limit
	else
		return ResRentMisc[1].gift_week_limit
	end
end

function RentTaskUtils.getTaskTimeLimit(...)
	return ResRentMisc[1].time_limit
end

function RentTaskUtils.getRenterCancelCd(...)
	return ResRentMisc[1].renter_cancel_cd
end

function RentTaskUtils.getOwnerCancelCd(...)
	return ResRentMisc[1].owner_cancel_cd
end

function RentTaskUtils.getGiftItemId(...)
	return ResRentMisc[1].gift_id
end

function RentTaskUtils.getActivityTempId(...)
	return ResRentMisc[1].act_tmplid
end

function RentTaskUtils.getConfidantMaxNum()
	return ResRentMisc[1].bond_num or 0
end

function RentTaskUtils.maxRequestPerTask()
	return 5
end

function RentTaskUtils.getTaskGiftNum(taskId, isUp)
	local taskInfo = RentTaskUtils.getTaskData(taskId)

	if taskInfo then
		if isUp then
			return taskInfo.up_help_award
		else
			return taskInfo.normal_help_award
		end
	end
end

function RentTaskUtils.getGiftWeekLimitByUp(isUp)
	if isUp then
		return ResRentMisc[1].gift_upweek_limit
	else
		return ResRentMisc[1].gift_week_limit
	end
end

function RentTaskUtils.getReplaceAwardStage()
	local stageList = ResRentMisc[1].replace_stage

	return stageList[1] * 10000 + stageList[2] * 100 + stageList[3]
end

function RentTaskUtils.isActivityActive(...)
	return CurAvatar.isRentUpWeek
end

function RentTaskUtils.simpleLetterData(letter)
	local data = {}

	local function getTeamInfo(letter)
		local teamInfo = {}

		if letter then
			local items = letter.formInfo.data.item

			for i, item in ipairs(items) do
				local hero = item.hero.base

				teamInfo[i] = {
					heroId = hero.resid,
					level = hero.level,
					star = hero.star,
					step = hero.step
				}
			end

			teamInfo.mvpId = letter.mvpId
		end

		return teamInfo
	end

	local otherPlayer = OtherPlayer()

	otherPlayer:initDataByCommonData(letter.roleCommInfo)

	local teamInfo = getTeamInfo(letter)

	data = {
		uid = letter.roleCommInfo.uid,
		gender = letter.roleCommInfo.gender,
		head = letter.roleCommInfo.head,
		award = letter.giftNum,
		defaultLetterId = letter.textId,
		content = letter.content,
		groupTaskId = letter.groupTaskId,
		level = letter.roleCommInfo.level,
		playerName = letter.roleCommInfo.name,
		orgLetter = letter,
		taskId = letter.taskId,
		replayId = letter.replayId,
		teamId = letter.formInfo.teamid,
		team = teamInfo,
		taskIdstr = letter.taskIdstr,
		serverName = otherPlayer.serverName,
		comm = letter.roleCommInfo
	}

	return data
end

function RentTaskUtils.getRandomLetter()
	local letterData = {}

	math.randomseed(os.time())

	local ran = math.random(#ResRentLetterText)
	local letter = ResRentLetterText[ran].content[1]

	letterData.content = letter
	letterData.id = ResRentLetterText[ran].id

	return letterData
end

function RentTaskUtils.parseLetter(letterData, mvpId)
	if letterData.id == 2 then
		local heroName = Lang.get(30728)

		if mvpId and ResHero[mvpId] then
			heroName = ResHero[mvpId].full_name
		end

		return string.gsub(letterData.content, "%$(%d)", heroName)
	else
		return letterData.content
	end
end

function RentTaskUtils.storeLastLetterInfo(letter)
	RentTaskUtils._lastLetterInfo = letter
end

function RentTaskUtils.getLastLetterInfo()
	return RentTaskUtils._lastLetterInfo
end

function RentTaskUtils.getLetterByIndex(index, mvpId)
	if index == 2 then
		local l = ResRentLetterText[2]

		return RentTaskUtils.parseLetter({
			content = l.content[1],
			id = l.id
		}, mvpId)
	elseif ResRentLetterText[index] then
		return ResRentLetterText[index].content[1]
	end
end

function RentTaskUtils.destroy()
	RentTaskUtils._lastLetterInfo = nil
end

return RentTaskUtils
