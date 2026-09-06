-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/model/GoddessContestModel.lua

module("logic.extensions.goddesscontest.model.GoddessContestModel", package.seeall)

local GoddessContestModel = class("GoddessContestModel", BaseModel)

function GoddessContestModel:ctor()
	return
end

function GoddessContestModel:onInit()
	self:onReset()
end

GoddessContestModel.OpenEventKey = "Goddess_Contest_Open_Event"
GoddessContestModel.FrenzyEventKey = "Goddess_Contest_Frenzy_Event"
GoddessContestModel.RandomJoinTipKey = "Goddess_Contest_Random_Join_Tip_Key"
GoddessContestModel.LeaderResultTipKey = "Goddess_Contest_Leader_Result_Tip_Key"
GoddessContestModel.GoddessResultTipKey = "Goddess_Contest_Goddess_Result_Tip_Key"

function GoddessContestModel:onReset()
	self._curActId = 0
	self._isRandomJoin = false
	self._curGroupId = -1
	self._groupInfoList = {}
	self._groupInfosByRank = {}
	self._winGroupInfo = nil
	self._winGoddessInfo = nil
	self._curGroupMemberInfos = {}
	self._curGroupMemberInfoHash = {}
	self._curGrade = 4
	self._curVotePower = 0
	self._curAddPower = -1
	self._curGoddessVoteNums = 0
	self._curLeaderInfo = nil
	self._lastOpenWinnerTabId = nil
	self._lastOpenGroupTabId = nil
	self._rankInfo = {}
	self._isCampaign = false
	self._leaderListPageId = 1
	self._leaderInfoList = {}
	self._leaderNum = 0
	self._curVoteUserGroupSubId = 1
	self._timeList = nil
	self._stepAddVotes = {}
	self._gdcCardBagMgrs = {}
	self._fansGroupCardInfos = {}
end

function GoddessContestModel:onGetInfo(msg)
	self._curActId = msg.actId
	self._curGroupId = msg.funsGroupId
	self._isRandomJoin = msg.isRandomJoin
	self._groupInfoList = {}

	for _, info in ipairs(msg.fansGroupInfos) do
		local groupData = self:createNewFansGroupByData(info)

		self._groupInfoList[groupData.groupId] = groupData
	end

	self._winGroupInfo = nil

	if msg:HasField("winngGroupInfo") then
		local winInfo = msg.winngGroupInfo
		local temWinInfo = {}

		temWinInfo.groupData = self:getFansGroupInfo(winInfo.winngGroupId)
		temWinInfo.leaderHeadInfo = winInfo.directorInfo.headInfo
		temWinInfo.leadergender = winInfo.directorInfo.gender
		temWinInfo.leaderClothes = {}

		for _, clothe in ipairs(winInfo.directorInfo.clothes) do
			table.insert(temWinInfo.leaderClothes, clothe)
		end

		temWinInfo.secLeaderHeadInfos = {}

		for _, headInfo in ipairs(winInfo.headInfos) do
			table.insert(temWinInfo.secLeaderHeadInfos, headInfo)
		end

		self._winGroupInfo = temWinInfo
	end

	self._winGoddessInfo = nil

	if msg:HasField("tipsInfo") then
		local tipsInfo = msg.tipsInfo

		self._winGoddessInfo = {}
		self._winGoddessInfo.faceId = tipsInfo.faceId
		self._winGoddessInfo.popularityValue = tipsInfo.popularityValue
	end

	self:dealGroupRank()
end

function GoddessContestModel:onJoinFansGroup(msg)
	self._curGroupId = msg.fansGroupId

	local info = self:getCurFansGroupInfo()

	info.numMembers = info.numMembers + 1
end

function GoddessContestModel:onGetGroupInfo(msg)
	self._curGroupId = msg.fansGroupId

	local info = self:getCurFansGroupInfo()

	info.voteDataList = {}
	info.voteDataHash = {}

	for _, data in ipairs(msg.infos) do
		local temData = {}

		temData.faceId = data.faceId
		temData.popularityValue = data.popularityValue
		info.voteDataHash[temData.faceId] = temData

		table.insert(info.voteDataList, temData)
	end

	self._curGroupMemberInfos = {}
	self._curGroupMemberInfoHash = {}
	self._curLeaderInfo = nil

	local memberInfos = msg.memberInfos

	for _, data in ipairs(memberInfos) do
		local temData = {}

		temData.headInfo = data.headInfo
		temData.grade = data.grade
		temData.lastChatTime = checkint(data.lastChatTime)
		temData.popularityValue = data.popularityValue
		temData.getVoteNum = data.voteNums

		table.insert(self._curGroupMemberInfos, temData)

		if temData.grade == 1 then
			self._curLeaderInfo = temData
		end

		self._curGroupMemberInfoHash[checkint(data.headInfo.userId)] = temData
	end

	table.sort(self._curGroupMemberInfos, function(a, b)
		if a.grade == b.grade then
			if a.popularityValue > b.popularityValue then
				return true
			end

			return false
		end

		return a.grade < b.grade
	end)

	self._isCampaign = msg.isCampaign
	self._curGrade = msg.grade
	self._curVotePower = msg.popularityValue
	self._curGoddessVoteNums = msg.voteNums
end

function GoddessContestModel:onVoteToGoddess(msg)
	local info = self:getCurFansGroupInfo()

	info.voteDataList = {}
	info.voteDataHash = {}

	for _, data in ipairs(msg.infos) do
		local temData = {}

		temData.faceId = data.faceId
		temData.popularityValue = data.popularityValue

		table.insert(info.voteDataList, temData)

		info.voteDataHash[data.faceId] = temData
	end

	self._curAddPower = checknumber(msg.curPopularityValue) - self._curVotePower
	self._curVotePower = checknumber(msg.curPopularityValue)
	self._curGoddessVoteNums = msg.voteNums
end

function GoddessContestModel:onGetCampaighList(msg)
	self._leaderListPageId = msg.pageIndex
	self._leaderNum = msg.curNums
	self._leaderInfoList = {}

	for k, data in ipairs(msg.infos) do
		local temData = {}

		temData.headInfo = data.headInfo
		temData.popularityValue = data.popularityValue
		temData.voteNums = data.voteNums

		table.insert(self._leaderInfoList, temData)
	end
end

function GoddessContestModel:onVoteToDirector(msg)
	self._leaderListPageId = msg.pageIndex
	self._leaderNum = msg.curNums
	self._leaderInfoList = {}

	local userId = checkint(msg.targetUserId)

	for k, data in ipairs(msg.infos) do
		local temData = {}

		temData.headInfo = data.headInfo
		temData.popularityValue = data.popularityValue
		temData.voteNums = data.voteNums

		if userId == checkint(data.headInfo.userId) then
			self._curVoteUserGroupSubId = k
		end

		table.insert(self._leaderInfoList, temData)
	end
end

function GoddessContestModel:onJoinCampaign(msg)
	self._isCampaign = true
end

function GoddessContestModel:onSearchCampaign(msg)
	self._leaderListPageId = 1
	self._leaderInfoList = {}

	for _, data in ipairs(msg.infos) do
		local temData = {}

		temData.headInfo = data.headInfo
		temData.popularityValue = data.popularityValue
		temData.voteNums = data.voteNums

		table.insert(self._leaderInfoList, temData)
	end

	self._leaderNum = table.nums(self._leaderInfoList)
end

function GoddessContestModel:onPrompt(msg)
	local userId = checkint(msg.targetUserId)
	local info = self._curGroupMemberInfoHash[userId]

	if info then
		info.lastChatTime = ServerTime.now()
	end
end

function GoddessContestModel:onReviseDeclaration(msg)
	local info = self:getCurFansGroupInfo()

	if info then
		info.declaration = msg.declaration
	end
end

function GoddessContestModel:handleGetRankInfo(msg)
	self._rankInfo[msg.fansGroupId] = self._rankInfo[msg.fansGroupId] or {}
	self._rankInfo[msg.fansGroupId].myRank = msg.myRank
	self._rankInfo[msg.fansGroupId].rankInfos = msg.rankInfos
end

function GoddessContestModel:getRankInfoById(id)
	if self._rankInfo[id] then
		return self._rankInfo[id]
	end

	return nil
end

function GoddessContestModel:handlePM_GoddessContestGetCardInfoRes(msg)
	local activityId = msg.actId

	if self._stepAddVotes[activityId] then
		table.clear(self._stepAddVotes[activityId])
	else
		self._stepAddVotes[activityId] = {}
	end

	for i, v in ipairs(msg.stepCardList) do
		self._stepAddVotes[activityId][v.stepId] = v.stepAddVote
	end

	local cardBagMgr = self:getGdcCardBagMgr(activityId)

	cardBagMgr:onResetCard()

	for i, v in ipairs(msg.stepCardList) do
		cardBagMgr:updateCardByCardListMsg(v.stepId, v.cardList, true)
	end

	local groupCards = {}

	self._fansGroupCardInfos = {}

	for _, v in ipairs(msg.cardContestInfo.groupCardList) do
		self._fansGroupCardInfos[v.fansGroupId] = v

		table.insert(groupCards, v)
	end
end

function GoddessContestModel:handlePM_GoddessContestSetCardRes(msg)
	local activityId = msg.actId
	local stepId = msg.stepId
	local cardBagMgr = self:getGdcCardBagMgr(activityId)

	cardBagMgr:updateCardByCardListMsg(stepId, msg.cardList, true)
end

function GoddessContestModel:handlePM_GoddessContestFlopRes(msg)
	local activityId = msg.actId
	local stepId = msg.stepId
	local cardBagMgr = self:getGdcCardBagMgr(activityId)

	cardBagMgr:updateCardByCardListMsg(stepId, {
		msg.cardInfo
	}, true)
end

function GoddessContestModel:dealGroupRank()
	self._groupInfosByRank = {}

	for _, v in pairs(self._groupInfoList) do
		table.insert(self._groupInfosByRank, v)
	end

	table.sort(self._groupInfosByRank, function(a, b)
		if a.totalPower == b.totalPower then
			if a.groupId < b.groupId then
				return true
			end

			return false
		end

		return a.totalPower > b.totalPower
	end)

	for k, v in ipairs(self._groupInfosByRank) do
		v.curRank = k
	end
end

function GoddessContestModel:createNewFansGroup()
	local fansGroup = {}

	fansGroup.groupId = 0
	fansGroup.totalPower = 0
	fansGroup.declaration = ""
	fansGroup.leaderHeadInfo = nil
	fansGroup.numMembers = 0
	fansGroup.voteDataList = {}
	fansGroup.voteDataHash = {}
	fansGroup.curRank = 0

	return fansGroup
end

function GoddessContestModel:createNewFansGroupByData(data)
	local fansGroup = self:createNewFansGroup()

	fansGroup.groupId = data.fansGroupId
	fansGroup.totalPower = checknumber(data.curPopularityValue)
	fansGroup.declaration = data.declaration
	fansGroup.leaderHeadInfo = nil
	fansGroup.numMembers = data.numbers
	fansGroup.voteDataList = {}
	fansGroup.voteDataHash = {}

	for _, info in ipairs(data.infos) do
		local temData = {}

		temData.faceId = info.faceId
		temData.popularityValue = info.popularityValue

		table.insert(fansGroup.voteDataList, temData)

		fansGroup.voteDataHash[temData.faceId] = temData
	end

	if data:HasField("headInfo") then
		fansGroup.leaderHeadInfo = data.headInfo
	end

	return fansGroup
end

function GoddessContestModel:getCurActId()
	return self._curActId
end

function GoddessContestModel:getCurGroupId()
	return self._curGroupId
end

function GoddessContestModel:getCurGoddessVoteValue(faceId)
	local value = 0

	for _, info in ipairs(self._groupInfoList) do
		local data = info.voteDataHash[faceId]

		if data then
			value = data.popularityValue

			break
		end
	end

	return value
end

function GoddessContestModel:getFansGroupInfo(groupId)
	return self._groupInfoList[groupId]
end

function GoddessContestModel:getCurFansGroupInfo()
	return self:getFansGroupInfo(self._curGroupId)
end

function GoddessContestModel:getWinGroupInfo()
	return self._winGroupInfo
end

function GoddessContestModel:getWinGoddessInfo()
	return self._winGoddessInfo
end

function GoddessContestModel:getIsRandomJoin()
	return self._isRandomJoin
end

function GoddessContestModel:getGroupInfosByRank()
	return self._groupInfosByRank
end

function GoddessContestModel:getCurLeaderInfo()
	return self._curLeaderInfo
end

function GoddessContestModel:getCurGroupMemberInfos()
	return self._curGroupMemberInfos
end

function GoddessContestModel:getCurGrade()
	return self._curGrade
end

function GoddessContestModel:getVotePower()
	return self._curVotePower
end

function GoddessContestModel:getCurGoddessVoteNums()
	return self._curGoddessVoteNums
end

function GoddessContestModel:getLeaderInfoList()
	return self._leaderInfoList
end

function GoddessContestModel:getLeaderListPageId()
	return self._leaderListPageId
end

function GoddessContestModel:getLeaderCampaignListNum()
	return self._leaderNum
end

function GoddessContestModel:getIsCampaign()
	return self._isCampaign
end

function GoddessContestModel:getCurVoteUserGroupSubId()
	return self._curVoteUserGroupSubId
end

function GoddessContestModel:getCurAddPower()
	if self._curAddPower < 0 then
		return 0
	end

	return self._curAddPower
end

function GoddessContestModel:getIsTime(timeKey)
	local timeStr = GoddessContestConfig.instance:getTimeStrByActIdAndTimeKey(self._curActId, timeKey)

	if string.nilorempty(timeStr) then
		return fasle
	end

	local timeStrParams = string.split(timeStr, "#")

	return GameUtil.checkIsInTimePeriod(timeStrParams[1], timeStrParams[2])
end

function GoddessContestModel:getStarTimeDate(timeKey)
	local timeStr = GoddessContestConfig.instance:getTimeStrByActIdAndTimeKey(self._curActId, timeKey)

	if string.nilorempty(timeStr) then
		return 0
	end

	local timeStrParams = string.split(timeStr, "#")

	return GameUtil.string2date(timeStrParams[1])
end

function GoddessContestModel:getUserIsFirstOpen(userDataKey)
	if string.nilorempty(userDataKey) then
		return false
	end

	return checkint(GameUtil.getUserData(userDataKey .. "_" .. self._curActId)) <= 0
end

function GoddessContestModel:setUserIsFirstOpen(userDataKey)
	if string.nilorempty(userDataKey) then
		return
	end

	return GameUtil.saveUserData(userDataKey .. "_" .. self._curActId, 1)
end

function GoddessContestModel:getLastOpenWinnerTabId()
	return self._lastOpenWinnerTabId
end

function GoddessContestModel:setLastOpenWinnerTabId(Id)
	self._lastOpenWinnerTabId = Id
end

function GoddessContestModel:getLastOpenGroupTabId()
	return self._lastOpenWinnerTabId
end

function GoddessContestModel:setLastOpenGroupTabId(Id)
	self._lastOpenWinnerTabId = Id
end

function GoddessContestModel:getRankInfo()
	return self._rankInfo
end

function GoddessContestModel:getGroupInfos()
	return self._groupInfoList or {}
end

function GoddessContestModel:getTaskQueue(actId, taskType)
	local content = EventTaskSummaryConfig.instance:getTaskCfgs(actId)
	local startTime = self._timeList[taskType].startTime
	local taskPlanId = EventTaskSummaryConfig.instance:getPlanCfg(actId).taskPlanId

	for taskPlanId, taskCfg in ipairs(content) do
		local queue = {}

		for _, data in ipairs(taskCfg) do
			local pageId = data.pageId
			local completionStartTime = data.completionStartTime

			if completionStartTime == startTime then
				queue[pageId] = queue[pageId] or {}

				table.insert(queue[pageId], data)
			end
		end

		for _, list in ipairs(queue) do
			ArraySort.sortOn(list, "taskId")
		end

		self._taskQueues[taskPlanId] = queue
	end

	return self._taskQueues[taskPlanId]
end

function GoddessContestModel:handleTaskData(actId)
	if self._timeList then
		return self._timeList
	end

	self._timeList = self._timeList or {}

	local queue = EventTaskSummaryConfig.instance:getTaskQueue(actId)
	local type = 0
	local timeMap = {}

	for pageId, taskList in ipairs(queue) do
		for idx, data in ipairs(taskList) do
			local completionStartTime = data.completionStartTime
			local completionEndTime = data.completionEndTime

			if not timeMap[completionStartTime] then
				type = type + 1
				timeMap[completionStartTime] = type

				local timeData = {
					startTime = completionStartTime,
					endTime = completionEndTime
				}

				table.insert(self._timeList, timeData)
			end
		end
	end

	table.sort(self._timeList, function(a, b)
		return a.startTime < b.startTime
	end)

	return self._timeList
end

function GoddessContestModel:getGdcCardBagMgr(activityId)
	local mgr = self._gdcCardBagMgrs[activityId]

	if mgr == nil then
		self._gdcCardBagMgrs[activityId] = GdcCardBagMgr.New(activityId)
		mgr = self._gdcCardBagMgrs[activityId]
	end

	return mgr
end

function GoddessContestModel:getStepAddVote(activityId, stepId)
	local value

	return (self._stepAddVotes[activityId] or nil) and self._stepAddVotes[activityId][stepId] or 0
end

function GoddessContestModel:getFansGroupCardInfo(fansGroupId)
	return self._fansGroupCardInfos[fansGroupId]
end

function GoddessContestModel:getCardNumListInFgc(fansGroupId)
	local info = self:getFansGroupCardInfo(fansGroupId)

	return (info or nil) and (info.cardNumList or {})
end

function GoddessContestModel:getContestScoreInFgc(fansGroupId)
	local info = self:getFansGroupCardInfo(fansGroupId)

	return (info or nil) and (info.contestScore or 0)
end

function GoddessContestModel:getTotalVoteNumInFgc(fansGroupId)
	local info = self:getFansGroupCardInfo(fansGroupId)

	return (info or nil) and (info.totalVoteNum or "0")
end

function GoddessContestModel:getGroupRankInFgc(fansGroupId)
	local info = self:getFansGroupCardInfo(fansGroupId)

	return (info or nil) and (info.rank or 0)
end

GoddessContestModel.instance = GoddessContestModel.New()

return GoddessContestModel
