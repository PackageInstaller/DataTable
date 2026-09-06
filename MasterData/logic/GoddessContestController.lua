-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/controller/GoddessContestController.lua

module("logic.extensions.goddesscontest.controller.GoddessContestController", package.seeall)

local GoddessContestController = class("GoddessContestController", BaseController)

function GoddessContestController:ctor()
	self._gdcCardStepMgrs = {}
	self._gdcCardStepMgrDeltas = {}
end

function GoddessContestController:onInit()
	GlobalDispatcher:addListener(GoddessContestModel.OpenEventKey, self._openEvent, self)
	GlobalDispatcher:addListener(GoddessContestModel.FrenzyEventKey, self._frenzyEvent, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self.checkActRd, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.checkActRd, self)
	GlobalDispatcher:addListener("entercardview", self.enterCardView, self)
end

function GoddessContestController:onReset()
	self:allGdcCardStepMgrOnDestroy()

	self._isDoOpenEvent = false
end

function GoddessContestController:checkActRd()
	self._voteGoddessItemType = nil
	self._voteGoddessItmeId = nil
	self._voteGoddessStartTime = 0
	self._voteGoddessEndTime = 0
	self._voteLeaderItemType = nil
	self._voteLeaderItemId = nil
	self._voteLeaderStartTime = 0
	self._voteLeaderEndTime = 0

	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self.onMatCountChange, self)

	local actId = GoddessContestController.instance:getActivityId()

	if self:isInActivityTime(actId) then
		local actCfg = GoddessContestConfig.instance:getActCfgByActId(actId)

		if actCfg then
			GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self.onMatCountChange, self)

			local parms = string.splitToNumber(actCfg.goddessVoteItemId, ":")

			self._voteGoddessItemType = parms[1]
			self._voteGoddessItmeId = parms[2]

			local timeStr = GoddessContestConfig.instance:getTimeStrByActIdAndTimeKey(actId, "GODDESS_VOTE_TIME")

			parms = string.split(timeStr, "#")
			self._voteGoddessStartTime = GameUtil.string2time(parms[1])
			self._voteGoddessEndTime = GameUtil.string2time(parms[2])
			parms = string.splitToNumber(actCfg.directorVoteItemId, ":")
			self._voteLeaderItemType = parms[1]
			self._voteLeaderItemId = parms[2]
			timeStr = GoddessContestConfig.instance:getTimeStrByActIdAndTimeKey(actId, "CAMPAIGN_VOTE_TIME")
			parms = string.split(timeStr, "#")
			self._voteLeaderStartTime = GameUtil.string2time(parms[1])
			self._voteLeaderEndTime = GameUtil.string2time(parms[2])

			self:onMatCountChange()
			RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_GoddessContestCardDayOnceRed)
		end
	end
end

function GoddessContestController:onMatCountChange()
	local isRed = MaterialModel.instance:getMaterialsNumber(self._voteGoddessItemType, self._voteGoddessItmeId) > 0

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_GODDESS_CONTEST_VOTE_GODDESS, isRed, true, self._voteGoddessStartTime, self._voteGoddessEndTime)

	isRed = MaterialModel.instance:getMaterialsNumber(self._voteLeaderItemType, self._voteLeaderItemId) > 0

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_GODDESS_CONTEST_VOTE_LEADER, isRed, true, self._voteLeaderStartTime, self._voteLeaderEndTime)
end

function GoddessContestController:_openEvent(params)
	local actId = params and checkint(params[1])

	self:getInfo(actId)

	self._isDoOpenEvent = true
end

function GoddessContestController:_frenzyEvent()
	local actId = GoddessContestModel.instance:getCurActId()
	local cfgs = GoddessContestConfig.instance:getFrenzyCfgsByActId(actId)

	if cfgs then
		for _, v in ipairs(cfgs) do
			local timeStr = v.triggerTime

			if not string.nilorempty(timeStr) then
				local timeStrParams = string.split(timeStr, "#")

				if GameUtil.checkIsInTimePeriod(timeStrParams[1], timeStrParams[2]) then
					UIStateManager.instance:push(ViewName.RulesView, GoddessContestConfig.instance:getCommondValueByKey("FRENZY_RULE"))

					return
				end
			end
		end
	end
end

function GoddessContestController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function GoddessContestController:getActivityType()
	return GameEnum.ActivityType.Goddess_Contest
end

function GoddessContestController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function GoddessContestController:getInfo(actId)
	if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.Goddess_Contest, actId) then
		GoddessContestAgent.instance:sendPM_GoddessContestInfoReq(actId)
	end
end

function GoddessContestController:handleGetInfo(msg)
	GoddessContestModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessContestGetInfo)

	if self._isDoOpenEvent then
		self._isDoOpenEvent = false

		if GoddessContestModel.instance:getWinGoddessInfo() then
			if GoddessContestModel.instance:getUserIsFirstOpen(GoddessContestModel.GoddessResultTipKey) then
				UIStateManager.instance:push(ViewName.GoddessContestResultView)
			else
				UIStateManager.instance:push(ViewName.GoddessContestWinnerView)
			end
		else
			local curGroupInfo = GoddessContestModel.instance:getCurFansGroupInfo()

			if curGroupInfo then
				if GoddessContestModel.instance:getIsRandomJoin() and GoddessContestModel.instance:getUserIsFirstOpen(GoddessContestModel.RandomJoinTipKey) then
					local groupCfg = GoddessContestConfig.instance:getFanGroupCfgsByActIdAndGroupId(GoddessContestModel.instance:getCurActId(), GoddessContestModel.instance:getCurGroupId())
					local txtTips = GoddessContestConfig.instance:getCommondValueByKey("RANDOM_JOINS_TIPS")

					TipsFacade.instance:openTipWindow(lang("随机加入粉丝团"), langPara(txtTips, groupCfg.fansGroupName), function()
						UIStateManager.instance:push(ViewName.GoddessContestMainView)
						GoddessContestModel.instance:setUserIsFirstOpen(GoddessContestModel.RandomJoinTipKey)
					end, lang("确定"))
				else
					UIStateManager.instance:push(ViewName.GoddessContestMainView)
				end
			else
				UIStateManager.instance:push(ViewName.GoddessContestJoinView)
			end
		end
	end
end

function GoddessContestController:joinFansGroup(groupId)
	local actId = GoddessContestModel.instance:getCurActId()

	GoddessContestAgent.instance:sendPM_GoddessContestJoinFansGroupReq(actId, groupId)
end

function GoddessContestController:handleJoinFansGroup(msg)
	GoddessContestModel.instance:onJoinFansGroup(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessContestSucJoinGroup)
end

function GoddessContestController:getGroupInfo()
	local actId = GoddessContestModel.instance:getCurActId()
	local groupId = GoddessContestModel.instance:getCurGroupId()

	GoddessContestAgent.instance:sendPM_GoddessContestGetFansGroupInfoReq(actId, groupId)
end

function GoddessContestController:handleGetGroupInfo(msg)
	GoddessContestModel.instance:onGetGroupInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessContestGetGroupInfo)
end

function GoddessContestController:voteToGoddess(faceId, voteNum)
	local actId = GoddessContestModel.instance:getCurActId()
	local nums = voteNum or 1

	GoddessContestAgent.instance:sendPM_GoddessContestGoddessVoteReq(actId, faceId, nums)
end

function GoddessContestController:handleVoteToGoddess(msg)
	GoddessContestModel.instance:onVoteToGoddess(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessContestVoteToGoddess)
end

function GoddessContestController:getCampaighList(pageIndex)
	local actId = GoddessContestModel.instance:getCurActId()
	local pageId = pageIndex or 1

	GoddessContestAgent.instance:sendPM_GoddessContestGetCampaignListReq(actId, pageId)
end

function GoddessContestController:handleGetCampaighList(msg)
	GoddessContestModel.instance:onGetCampaighList(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessContestUpdateLeaderList)
end

function GoddessContestController:voteToDirector(userId, voteNum, activityId)
	local actId = GoddessContestModel.instance:getCurActId()

	if actId == 0 then
		actId = checknumber(activityId)
	end

	local nums = voteNum or 1

	GoddessContestAgent.instance:sendPM_GoddessContestDirectorVoteReq(actId, userId, nums)
end

function GoddessContestController:handleVoteToDirector(msg)
	GoddessContestModel.instance:onVoteToDirector(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessContestVoteToLeader)
end

function GoddessContestController:joinCampaign()
	local actId = GoddessContestModel.instance:getCurActId()

	GoddessContestAgent.instance:sendPM_GoddessContestDirectorCampaignReq(actId)
end

function GoddessContestController:handleJoinCampaign(msg)
	GoddessContestModel.instance:onJoinCampaign(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessContestJoinCampaign)
end

function GoddessContestController:searchCampaign(params)
	local actId = GoddessContestModel.instance:getCurActId()

	GoddessContestAgent.instance:sendPM_GoddessContestCampaignSearchReq(actId, params)
end

function GoddessContestController:handleSearchCampaign(msg)
	GoddessContestModel.instance:onSearchCampaign(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessContestUpdateLeaderList)
end

function GoddessContestController:prompt(userId)
	local actId = GoddessContestModel.instance:getCurActId()

	GoddessContestAgent.instance:sendPM_GoddessContestPromptReq(actId, userId)
end

function GoddessContestController:handlePrompt(msg)
	GoddessContestModel.instance:onPrompt(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessContestPrompt)
end

function GoddessContestController:reviseDeclaration(str)
	local actId = GoddessContestModel.instance:getCurActId()

	GoddessContestAgent.instance:sendPM_GoddessContestReviseDeclarationReq(actId, str)
end

function GoddessContestController:handleReviseDeclaration(msg)
	GoddessContestModel.instance:onReviseDeclaration(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessContestReviseDeclaration)
end

function GoddessContestController:sendGetRankInfo(actId, fansGroupId)
	GoddessContestAgent.instance:sendPM_GoddessContestGetRankViewReq(actId, fansGroupId)
end

function GoddessContestController:handleGetRankInfo(msg)
	GoddessContestModel.instance:handleGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessContestGetRankInfo, msg)
end

function GoddessContestController:sendPM_GoddessContestGetCardInfoReq(actId)
	GoddessContestAgent.instance:sendPM_GoddessContestGetCardInfoReq(actId)
end

function GoddessContestController:handlePM_GoddessContestGetCardInfoRes(msg)
	GoddessContestModel.instance:handlePM_GoddessContestGetCardInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_GoddessContestGetCardInfoRes)
end

function GoddessContestController:sendPM_GoddessContestSetCardReq(actId, stepId, cardIds)
	GoddessContestAgent.instance:sendPM_GoddessContestSetCardReq(actId, stepId, cardIds)
end

function GoddessContestController:handlePM_GoddessContestSetCardRes(msg)
	GoddessContestModel.instance:handlePM_GoddessContestSetCardRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_GoddessContestSetCardRes)
end

function GoddessContestController:sendPM_GoddessContestFlopReq(actId, stepId, cardId)
	GoddessContestAgent.instance:sendPM_GoddessContestFlopReq(actId, stepId, cardId)
end

function GoddessContestController:handlePM_GoddessContestFlopRes(msg)
	GoddessContestModel.instance:handlePM_GoddessContestFlopRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_GoddessContestFlopRes)
end

function GoddessContestController:isInActTime()
	return ActivityDefineController.instance:isCurServerAvailable(GameEnum.ActivityType.Goddess_Contest)
end

function GoddessContestController:enterCardView(activityId)
	local activityId = self:getActivityId()

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动时间范围内")

		return
	end

	local curGroupInfo = GoddessContestModel.instance:getCurFansGroupInfo()

	if curGroupInfo == nil then
		FloatWordMgr.instance:show("未加入女神团")

		return
	end

	local cardActStepType = self:getCardActStepType(activityId)

	if cardActStepType == GdcCardEnum.ActStepType_Collect then
		UIStateManager.instance:push(ViewName.GodDessContestCardMainView)
	elseif cardActStepType == GdcCardEnum.ActStepType_Contest then
		UIStateManager.instance:push(ViewName.GodDessContestCardArenaView)
	else
		FloatWordMgr.instance:show("不在活动时间范围内")
	end
end

function GoddessContestController:getTryFlopCardResultAndTips(activityId, stepId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif not self:isInFlopCardPeiodOfStep(activityId, stepId) then
		result = GameEnum.ResultCode.Error
		tips = "不在翻牌时间范围内"
	elseif not self:isEnoughFlopCardGrade() then
		result = GameEnum.ResultCode.Error
		tips = "副团长才可以翻牌"
	end

	return result, tips
end

function GoddessContestController:getCardActStepType(activityId)
	local result = GdcCardEnum.ActStepType_Empty
	local stepCfg = GoddessContestConfig.instance:getCardStepCfg(activityId) or {}

	for _, actStepType in ipairs(GdcCardEnum.ActStepTypeList) do
		local isEnd = false

		for _, stepData in ipairs(stepCfg) do
			local stepId = stepData.stepId
			local timePeriod = self:getTimePeriodInCardStep(actStepType, activityId, stepId)

			if timePeriod == GameUtil.afterTimePeriod then
				result = actStepType
			elseif timePeriod == GameUtil.inTimePeriod then
				result = actStepType
				isEnd = true

				break
			end
		end

		if isEnd then
			break
		end
	end

	return result
end

function GoddessContestController:getCurStepIdInCardStep(actStepType, activityId)
	local curStepId = 1
	local stepCfg = GoddessContestConfig.instance:getCardStepCfg(activityId)

	if stepCfg then
		for _, stepData in ipairs(stepCfg) do
			local stepId = stepData.stepId

			if self:getTimePeriodInCardStep(actStepType, activityId, stepId) >= GameUtil.inTimePeriod then
				curStepId = stepId
			else
				break
			end
		end
	end

	return curStepId
end

function GoddessContestController:getTimePeriodInCardStep(actStepType, activityId, stepId)
	local stepData = GoddessContestConfig.instance:getCardStepData(activityId, stepId)
	local fields = GdcCardEnum.ActStepTimeFields[actStepType]

	return (stepData and fields or nil) and GameUtil.getTimePeriod(stepData[fields[1]], stepData[fields[2]])
end

function GoddessContestController:isInFlopCardPeiodOfStep(activityId, stepId)
	local result = false
	local stepData = GoddessContestConfig.instance:getCardStepData(activityId, stepId)

	if stepData then
		local timePeriod = GameUtil.getTimePeriod(stepData.openCardTime, stepData.autoShowCardTime)

		result = timePeriod == GameUtil.inTimePeriod
	end

	return result
end

function GoddessContestController:isEnoughFlopCardGrade()
	local grade = GoddessContestModel.instance:getCurGrade()

	return grade == 2
end

function GoddessContestController:isEnoughAdjustCardGrade()
	local grade = GoddessContestModel.instance:getCurGrade()

	return grade == 1
end

function GoddessContestController:getCardGridNum(activityId)
	local data = GoddessContestConfig.instance:getActCfgByActId(activityId)

	return (data or nil) and (data.cardGridNum or 0)
end

function GoddessContestController:getCurStep(activityId)
	return self:getCurStepByTimeStamp(activityId, ServerTime.now())
end

function GoddessContestController:getStepInterval(activityId, stepId)
	return self:getStepIntervalByTime(activityId, stepId, ServerTime.now())
end

function GoddessContestController:getCurStepByTimeStamp(activityId, otherTimeStamp)
	local result = self:getFirstStepInterval()
	local stepCfg = GoddessContestConfig.instance:getCardStepCfg(activityId)

	if stepCfg then
		for stepId, stepData in ipairs(stepCfg) do
			local interval = self:getStepIntervalByTime(activityId, stepId, otherTimeStamp)

			if interval <= self:getFirstStepInterval() then
				break
			end

			if interval <= self:getLastStepInterval() then
				result = stepId
			end
		end
	end

	return result
end

function GoddessContestController:getStepIntervalByTime(activityId, stepId, otherTimeStamp)
	local stepData = GoddessContestConfig.instance:getCardStepData(activityId, stepId)
	local index = 0

	for idx, field in ipairs(GdcCardEnum.ConIntervalTimeFields) do
		index = idx * 2

		if not stepData[field] then
			local startTime = ""
			local timePeriod = GameUtil.getTimePeriod(startTime, nil)

			if timePeriod <= GameUtil.beforeTimePeriod then
				index = index - 1

				break
			end
		end
	end

	return GdcCardEnum.ConIntervalList[index]
end

function GoddessContestController:getFirstStepInterval()
	return GdcCardEnum.ConIntervalList[1]
end

function GoddessContestController:getLastStepInterval()
	local length = #GdcCardEnum.ConIntervalList

	return GdcCardEnum.ConIntervalList[length]
end

function GoddessContestController:getGdcCardStepMgr(activityId)
	return self._gdcCardStepMgrs[activityId]
end

function GoddessContestController:gdcCardStepMgrOnEnter(activityId)
	local stepMgr = self._gdcCardStepMgrs[activityId]

	if stepMgr == nil then
		self._gdcCardStepMgrs[activityId] = GdcCardStepMgr.New(activityId)
		self._gdcCardStepMgrDeltas[activityId] = 0
		stepMgr = self._gdcCardStepMgrs[activityId]
	end

	if not self._gdcCardStepMgrDeltas[activityId] then
		local curDelta = 0

		if curDelta == 0 then
			stepMgr:onEnter()
		end

		self._gdcCardStepMgrDeltas[activityId] = curDelta + 1

		return stepMgr
	end
end

function GoddessContestController:gdcCardStepMgrOnExit(activityId)
	local stepMgr = self._gdcCardStepMgrs[activityId]

	if stepMgr then
		self._gdcCardStepMgrDeltas[activityId] = Mathf.Max(checknumber(self._gdcCardStepMgrDeltas[activityId]) - 1, 0)

		if self._gdcCardStepMgrDeltas[activityId] <= 0 then
			stepMgr:onExit()
		end
	end
end

function GoddessContestController:gdcCardStepMgrOnDestroy(activityId)
	local stepMgr = self._gdcCardStepMgrs[activityId]

	if stepMgr then
		stepMgr:onDestroy()

		self._gdcCardStepMgrDeltas[activityId] = 0
	end
end

function GoddessContestController:allGdcCardStepMgrOnDestroy()
	for activityId, mgr in pairs(self._gdcCardStepMgrs) do
		self:gdcCardStepMgrOnDestroy(activityId)
	end
end

GoddessContestController.instance = GoddessContestController.New()

return GoddessContestController
