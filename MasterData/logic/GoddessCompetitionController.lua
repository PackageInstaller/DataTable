-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/controller/GoddessCompetitionController.lua

module("logic.extensions.goddesscompetition.controller.GoddessCompetitionController", package.seeall)

local GoddessCompetitionController = class("GoddessCompetitionController", BaseController)

GoddessCompetitionController.Step_Preliminary = "KNOCKOUT"
GoddessCompetitionController.Step_Resurrection = "REVIVE_MATCH"
GoddessCompetitionController.Step_Group = "EIGHT_PLACE_MATCH"
GoddessCompetitionController.Step_finals = "FOUR_PLACE_MATCH"
GoddessCompetitionController.Step_result = "SHOW_RESULT"

function GoddessCompetitionController:ctor()
	return
end

function GoddessCompetitionController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterGoddessCompetition", self.enterModule, self)
	GlobalDispatcher:addListener("enterGoddessCompetitionTask", self.enterCompetitionTask, self)
end

function GoddessCompetitionController:onReset()
	return
end

function GoddessCompetitionController:enterModule(param)
	local activityId = checknumber(param[1])

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		printError("女神大赛S3活动未开启：" .. activityId)

		return
	end

	GoddessCompetitionModel.instance:setCurActId(activityId)

	local headTabIndex = checknumber(param[2])
	local secTabIndex = checknumber(param[3])

	if headTabIndex <= 0 then
		local curStepId = GoddessCompetitionController.instance:getCurStepIdByTime(activityId)
		local stepCfgs = GoddessCompetitionConfig.instance:getStepCfgs(activityId)

		if curStepId > #stepCfgs then
			curStepId = #stepCfgs
		end

		headTabIndex = 1
		secTabIndex = curStepId
	end

	local params = {
		activityId,
		headTabIndex,
		secTabIndex
	}

	GlobalDispatcher:dispatch(TabFrameWorkController.NotifyOpentabframeworkview, params)
end

function GoddessCompetitionController:enterCompetitionTask(param)
	local activityId = checknumber(param[1])

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		printError("女神大赛S3活动未开启：" .. activityId)

		return
	end

	GoddessCompetitionModel.instance:setCurActId(activityId)

	local params = {
		activityId,
		2,
		0
	}

	GlobalDispatcher:dispatch(TabFrameWorkController.NotifyOpentabframeworkview, params)
end

function GoddessCompetitionController:getInfo(activityId)
	GoddessCompetitionAgent.instance:sendPM_GoddessCompetitionGetInfoReq(activityId)
end

function GoddessCompetitionController:handleGetInfo(msg)
	GoddessCompetitionModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionGetBaseInfoRes)
end

function GoddessCompetitionController:vote(activityId, faceId, voteCount)
	GoddessCompetitionAgent.instance:sendPM_GoddessCompetitionVoteReq(activityId, faceId, voteCount)
end

function GoddessCompetitionController:handleVote(msg)
	GoddessCompetitionModel.instance:onVote(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionVoteRes)
end

function GoddessCompetitionController:getRedPackList(activityId, redPackType)
	GoddessCompetitionAgent.instance:sendPM_GoddessCompetitionRedPackListReq(activityId, redPackType)
end

function GoddessCompetitionController:handleRedPackList(msg)
	GoddessCompetitionModel.instance:onGetRedPackList(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionGetRedPackListRes)
end

function GoddessCompetitionController:getRedPackRecord(activityId)
	GoddessCompetitionAgent.instance:sendPM_GoddessCompetitionRedPackRecordReq(activityId)
end

function GoddessCompetitionController:handleGetRedPackRecord(msg)
	GoddessCompetitionModel.instance:onGetRedPackRecord(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionGetRedPackRecordRes)
end

function GoddessCompetitionController:getRedPackInfo(activityId, redPackType, redPackId)
	GoddessCompetitionAgent.instance:sendPM_GoddessCompetitionRedPackInfoReq(activityId, redPackType, redPackId)
end

function GoddessCompetitionController:handleGetRedPackInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionGetRedPackInfoRes, msg)
end

function GoddessCompetitionController:grabRedPack(activityId, redPackDefineId, redPackId)
	GoddessCompetitionAgent.instance:sendPM_GoddessCompetitionGrabRedPackReq(activityId, redPackDefineId, redPackId)
end

function GoddessCompetitionController:handleGrabRedPack(msg)
	MaterialController.instance:saveChangeSetToTemp(checknumber(msg.changeSetId))
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionGrabRedPackRes, msg)
end

function GoddessCompetitionController:handlePM_GoddessCompetitionSuperFansRankViewRes(msg)
	GoddessCompetitionModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionRankViewRes)
end

function GoddessCompetitionController:handlePM_GoddessCompetitionPopularityRankViewRes(msg)
	GoddessCompetitionModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionRankViewRes)
end

function GoddessCompetitionController:handlePM_GoddessCompetitionRedPackRankViewRes(msg)
	GoddessCompetitionModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionRankViewRes)
end

function GoddessCompetitionController:useDoubleCard(activityId, cardId)
	GoddessCompetitionAgent.instance:sendPM_GoddessCompetitionUseDoubleCardReq(activityId, cardId)
end

function GoddessCompetitionController:handleUseDoubleCard(msg)
	GoddessCompetitionModel.instance:onUseDoubleCard(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionUseDoubleCardRes)
end

function GoddessCompetitionController:gainProgressPrize(activityId, prizeIds)
	GoddessCompetitionAgent.instance:sendPM_GoddessCompetitionGainProgressPrizeReq(activityId, prizeIds)
end

function GoddessCompetitionController:handleGainProgressPrize(msg)
	GoddessCompetitionModel.instance:onGainProgressPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionGainProgressPrizeRes)
end

function GoddessCompetitionController:getAllGoddessRank(activityId, stepId)
	GoddessCompetitionAgent.instance:sendPM_GoddessCompetitionAllGoddessPopularityRankReq(activityId, stepId)
end

function GoddessCompetitionController:handleAllGoddessRank(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionActivityRankViewRes, msg)
end

function GoddessCompetitionController:handleDoubleCardNotify(msg)
	GoddessCompetitionModel.instance:onDoubleCardNotify(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionDoubleCardNotify)
end

function GoddessCompetitionController:handlePM_GoddessCompetitionSendRedPackRes(msg)
	GoddessCompetitionModel.instance:saveSendRedPack(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GoddessCompetitionSendRedPackRes)

	local info = GameUtil.pbToTable(msg)

	UIStateManager.instance:push(ViewName.GoddessCompetitionRedpackPopupView, info.activityId, info.redPackDefineId, checknumber(info.redPackId), info.faceId)
end

function GoddessCompetitionController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.GoddessCompetition)
end

function GoddessCompetitionController:getCurStepIdByTime(activityId)
	local timeNow = ServerTime.now()
	local stepCfgs = GoddessCompetitionConfig.instance:getStepCfgs(activityId)
	local curStepId = 0

	for stepId, cfg in ipairs(stepCfgs) do
		local startTime = GameUtil.string2time(cfg.openTime)

		if startTime < timeNow then
			curStepId = stepId
		else
			break
		end
	end

	if curStepId == #stepCfgs then
		local lastCfg = stepCfgs[#stepCfgs]
		local endTime = GameUtil.string2time(lastCfg.endTime)

		if endTime < timeNow then
			curStepId = curStepId + 1
		end
	end

	return curStepId
end

function GoddessCompetitionController:isDisplayStep(activityId)
	local curStepId = self:getCurStepIdByTime(activityId)
	local stepCfgs = GoddessCompetitionConfig.instance:getStepCfgs(activityId)

	return curStepId > #stepCfgs
end

function GoddessCompetitionController:isInCompetitionTime(activityId)
	local startData = GoddessCompetitionConfig.instance:getStepCfg(activityId, 1)
	local oepnTime = startData and startData.openTime
	local stepCfgs = GoddessCompetitionConfig.instance:getStepCfgs(activityId) or {}
	local endData = GoddessCompetitionConfig.instance:getStepCfg(activityId, #stepCfgs)
	local endTime = endData and endData.endTime
	local period = GameUtil.getTimePeriod(oepnTime, endTime)

	return period == GameUtil.inTimePeriod
end

function GoddessCompetitionController:getLastSendGoddessId(activityId, stepId)
	local userDataKey = string.format("saveLastSendGoddessId_%s_%s", activityId, stepId)

	return checknumber(GameUtil.getUserData(userDataKey))
end

function GoddessCompetitionController:saveLastSendGoddessId(activityId, stepId, faceId)
	local userDataKey = string.format("saveLastSendGoddessId_%s_%s", activityId, stepId)
	local saveValue = checknumber(faceId)

	GameUtil.saveUserData(userDataKey, saveValue)
end

function GoddessCompetitionController:openCommonTabListRank(activityId, defaultKey)
	local headCfg = {
		{
			tabName = "贡献总榜",
			tabKey = ViewName.GoddessCompetitionActivityChildRankView,
			viewName = ViewName.GoddessCompetitionActivityChildRankView,
			viewParams = {
				activityId
			}
		},
		{
			tabName = "贡献周榜",
			tabKey = "StepRank"
		},
		{
			tabName = "红包榜",
			tabKey = ViewName.GoddessCompetitionRedPackChildRankView,
			viewName = ViewName.GoddessCompetitionRedPackChildRankView,
			viewParams = {
				activityId
			}
		}
	}
	local secCfgs = {}

	secCfgs[2] = {}

	local stepRankPrizeCfgs = GoddessCompetitionConfig.instance:getStepRankPrizeCfgsByActivity(activityId) or {}

	for stepId, data in ipairs(stepRankPrizeCfgs) do
		local tabKey = string.format("StepRank_%s", stepId)
		local tab = {
			tabKey = tabKey,
			viewName = ViewName.GoddessCompetitionStepChildRankView,
			tabName = string.format("第%s周", stepId),
			viewParams = {
				activityId,
				stepId
			}
		}

		table.insert(secCfgs[2], tab)
	end

	local params = CommonTabRankListParams.New()

	for headTabId, headData in ipairs(headCfg) do
		params:addTabData(headTabId, 0, headData.tabKey, headData.viewName, headData.tabName, headData.viewParams)

		local secCfg = secCfgs[headTabId]

		if secCfg then
			for secTabId, secData in ipairs(secCfg) do
				params:addTabData(headTabId, secTabId, secData.tabKey, secData.viewName, secData.tabName, secData.viewParams)
			end
		end
	end

	params:setDafaultOpenTab(defaultKey)
	UIStateManager.instance:push(ViewName.GoddessCompetitionRankFatherListView, params)
end

GoddessCompetitionController.instance = GoddessCompetitionController.New()

return GoddessCompetitionController
