-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/controller/ChopKingController.lua

module("logic.extensions.chopking.controller.ChopKingController", package.seeall)

local ChopKingController = class("ChopKingController", BaseController)

function ChopKingController:ctor()
	return
end

function ChopKingController:onInit()
	self:onReset()
end

function ChopKingController:onReset()
	return
end

function ChopKingController:handlePM_ChopKingFirstClgInfoRes(msg)
	ChopKingModel.instance:saveRogueInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ChopKingFirstClgInfoRes)
end

function ChopKingController:handlePM_ChopKingReShuffleDropBuffRes(msg)
	ChopKingModel.instance:saveRogueDropInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ChopKingReShuffleDropBuffRes)
end

function ChopKingController:getFirstClgStartStageId(activityId, curStageId)
	local stageList = ChopKingConfig.instance:getFirstClgStageList(activityId)
	local targetStageId = 1
	local isRefresh = false

	for i, v in ipairs(stageList) do
		if isRefresh then
			isRefresh = false
			targetStageId = v.stageId
		end

		if curStageId > v.stageId and v.dropBuffPlanId > 0 then
			isRefresh = true
		end
	end

	return targetStageId
end

function ChopKingController:getTargetBuffCount(activityId, stageId)
	local buffCount = 0
	local cfgNormalStages = ChopKingConfig.instance:getFirstClgStageList(activityId)

	for i, v in ipairs(cfgNormalStages) do
		if stageId > v.stageId and v.dropBuffPlanId > 0 then
			buffCount = buffCount + 1
		end
	end

	return buffCount
end

function ChopKingController:openRogueMissionView(activityId, isUiJumper)
	local fmtMo = ChopKingModel.instance:getRogueFmtMo()

	fmtMo:initParams(activityId)

	if isUiJumper == true then
		UIJumper.instance:pushOneStack(ViewName.CustomMissionView, true, fmtMo)
	else
		CustomFmtController.instance:showMissionView(fmtMo)
	end
end

function ChopKingController:startOnceBattle(activityId, form)
	ChopKingAgent.instance:sendPM_ChopKingFirstClgStartFightReq(activityId, form)
end

function ChopKingController:PM_NotifyChopKingFirstClgFightResultRes(msg)
	if msg.win then
		ChopKingModel.instance:saveRogueChallengeInfo(msg)

		if msg.canContinueFight == true then
			BattleFacade.instance:registerResultHandler(function()
				BattleFacade.instance:startContinuousBattle()
				ChopKingAgent.instance:sendPM_ChopKingFirstClgContinueFightReq(msg.activityId)

				return true
			end, self)
		else
			BattleFacade.instance:registerResultHandler(function()
				if ChopKingModel.instance:isNeedSelectBuff(msg.activityId) then
					ChopKingController.instance:openRogueMissionView(msg.activityId, true)
					UIJumper.instance:pushOneStack(ViewName.ChopKingRogueSelectBuffView, true, msg.activityId)
				end

				return false
			end, self)
		end
	else
		BattleFacade.instance:registerResultHandler(function()
			ChopKingController.instance:openRogueMissionView(msg.activityId, true)

			return false
		end, self)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyChopKingFirstClgFightResultRes)
end

function ChopKingController:handlePM_ChopKingRerandomDropBuffRes(msg)
	ChopKingModel.instance:saveReRandomInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ChopKingRerandomDropBuffRes)
end

function ChopKingController:handlePM_ChopKingSelectDropBuffRes(msg)
	ChopKingModel.instance:saveRogueDropInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ChopKingSelectDropBuffRes)
end

function ChopKingController:isPassFirstClg(activityId)
	local passNum = ChopKingModel.instance:getRoguePassNum(activityId)
	local stageList = ChopKingConfig.instance:getFirstClgStageList(activityId)

	return passNum >= #stageList
end

function ChopKingController:handlePM_ChopKingCircleClgInfoRes(msg)
	ChopKingModel.instance:saveCircleClgInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ChopKingCircleClgInfoRes)
end

function ChopKingController:handlePM_NotifyChopKingCircleClgFightResultRes(msg)
	if msg.win then
		ChopKingModel.instance:saveCircleClgFightInfo(msg)

		local stageCfg = ChopKingConfig.instance:getCircleClgCfg(msg.activityId, msg.stageId)
		local score = ChopKingConfig.instance:getScoreByNum(msg.activityId, stageCfg.circleScorePlanId, msg.circleNum)
		local params = {
			title = "目 标",
			content = langPara("胜利回合数：%d     积分：%d", msg.circleNum, score)
		}

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.SimplyDesc, params)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_ChopKingCircleClgInfoRes)
end

function ChopKingController:openCircleMissionView(activityId, stageId)
	local fmtMo = ChopKingModel.instance:getCircleFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function ChopKingController:getCircleClgScore(activityId)
	local clgCfgs = ChopKingConfig.instance:getCircleClgCfgs(activityId)
	local totalScore = 0

	for i, v in ipairs(clgCfgs) do
		local stageNum = ChopKingModel.instance:getCircleClgStageInfo(activityId, v.stageId)

		if stageNum then
			local stageCfg = ChopKingConfig.instance:getCircleClgCfg(activityId, v.stageId)

			totalScore = totalScore + ChopKingConfig.instance:getScoreByNum(activityId, stageCfg.circleScorePlanId, stageNum)
		end
	end

	return totalScore
end

function ChopKingController:handlePM_ChopKingAgainstTwoClgInfoRes(msg)
	ChopKingModel.instance:saveAgainstTwoInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ChopKingAgainstTwoClgInfoRes)
end

function ChopKingController:handlePM_ChopKingAgainstTwoClgFightRes(msg)
	if msg.win then
		ChopKingModel.instance:saveAgainstTwoFightInfo(msg)

		local stageCfg = ChopKingConfig.instance:getAgainstTwoStageCfg(msg.activityId, msg.stageId)
		local score = ChopKingConfig.instance:getScoreByNum(msg.activityId, stageCfg.activeScorePlanId, msg.activeNum)
		local params = {
			title = "目 标",
			content = langPara("存活数：%d     积分：%d", msg.activeNum, score)
		}

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.SimplyDesc, params)
	end

	local btlResultList = {
		msg.teamABattleResult
	}

	if msg.teamBBattleResult and msg.teamBBattleResult.oneFightResult and msg.teamBBattleResult.oneFightResult.roundList and #msg.teamBBattleResult.oneFightResult.roundList > 0 then
		table.insert(btlResultList, msg.teamBBattleResult)
	end

	BattleController.instance:viewUserFightMonsterBtlResultWithList(btlResultList)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ChopKingAgainstTwoClgInfoRes)
end

function ChopKingController:getAgainstTwoScore(activityId)
	local clgCfgs = ChopKingConfig.instance:getAgainstTwoStageCfgs(activityId)
	local totalScore = 0

	for i, v in ipairs(clgCfgs) do
		local stageNum = ChopKingModel.instance:getAgainstTwoStageInfo(activityId, v.stageId)

		if stageNum then
			local stageCfg = ChopKingConfig.instance:getAgainstTwoStageCfg(activityId, v.stageId)

			totalScore = totalScore + ChopKingConfig.instance:getScoreByNum(activityId, stageCfg.activeScorePlanId, stageNum)
		end
	end

	return totalScore
end

function ChopKingController:openAgainstTwoMissionView(activityId, stageId)
	local fmtMo = ChopKingModel.instance:getAgainstTwoFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function ChopKingController:handlePM_ChopKingLoopClgInfoRes(msg)
	ChopKingModel.instance:saveLoopClgInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ChopKingLoopClgInfoRes)
end

function ChopKingController:handlePM_NotifyChopKingLoopClgFightResultRes(msg)
	if msg.win then
		local info = ChopKingModel.instance:getLoopClgStageInfo(msg.activityId, msg.loopId, msg.stageId)

		if not info then
			ChopKingModel.instance:saveLoopClgFightInfo(msg)
		else
			local curScore = self:getLoopStageScore(msg.activityId, msg.loopId, msg.stageId)
			local newScore = self:calcLoopStageScore(msg.activityId, msg.loopId, msg.stageId, checknumber(msg.activeNum), checknumber(msg.circleNum))

			if curScore < newScore then
				ChopKingModel.instance:saveLoopClgFightInfo(msg)
			end
		end

		local loopCfg = ChopKingConfig.instance:getLoopClgLoopCfg(msg.activityId, msg.loopId)

		if loopCfg.rank == true then
			local circleScore = ChopKingConfig.instance:getScoreByNum(msg.activityId, loopCfg.circleScorePlanId, msg.circleNum)
			local activeScore = ChopKingConfig.instance:getScoreByNum(msg.activityId, loopCfg.activeScorePlanId, msg.activeNum)
			local params = {
				title = "目 标",
				content = langPara("存活数：%d       积分：%d\n胜利回合数：%d     积分：%d", msg.activeNum, activeScore, msg.circleNum, circleScore)
			}

			BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.SimplyDesc, params)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_ChopKingLoopClgInfoRes)
end

function ChopKingController:getLoopStageScore(activityId, loopId, stageId)
	local stageInfo = ChopKingModel.instance:getLoopClgStageInfo(activityId, loopId, stageId)

	if stageInfo then
		return self:calcLoopStageScore(activityId, loopId, stageId, checknumber(stageInfo.bestActiveNum), checknumber(stageInfo.bestCircleNum))
	else
		return 0
	end
end

function ChopKingController:calcLoopStageScore(activityId, loopId, stageId, activeNum, circleNum)
	local loopCfg = ChopKingConfig.instance:getLoopClgLoopCfg(activityId, loopId)
	local score = loopCfg.baseScore

	if loopCfg.rank == false then
		return score
	end

	local activeScore = ChopKingConfig.instance:getScoreByNum(activityId, loopCfg.activeScorePlanId, activeNum)
	local circleScore = ChopKingConfig.instance:getScoreByNum(activityId, loopCfg.circleScorePlanId, circleNum)

	score = score + activeScore + circleScore

	return score
end

function ChopKingController:getLoopClgScore(activityId)
	local totalScore = 0
	local maxLoopId, maxStageId = ChopKingModel.instance:getLoopClgMaxStage(activityId)
	local stageCfgs = ChopKingConfig.instance:getLoopClgStageCfgs(activityId)

	for i = 1, maxLoopId do
		for j, v in ipairs(stageCfgs) do
			totalScore = totalScore + ChopKingController.instance:getLoopStageScore(activityId, i, v.stageId)
		end
	end

	return totalScore
end

function ChopKingController:openLoopClgMissionView(activityId, loopId, stageId)
	local fmtMo = ChopKingModel.instance:getLoopClgFmtMo()

	fmtMo:initParams(activityId, loopId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function ChopKingController:handlePM_ChopKingRankRes(msg)
	ChopKingModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ChopKingRankRes)
end

function ChopKingController:getTotalScore(activityId)
	return self:getCircleClgScore(activityId) + self:getLoopClgScore(activityId) + self:getAgainstTwoScore(activityId)
end

ChopKingController.instance = ChopKingController.New()

return ChopKingController
