-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/controller/SummonMasterJiController.lua

module("logic.extensions.summonmasterji.controller.SummonMasterJiController", package.seeall)

local SummonMasterJiController = class("SummonMasterJiController", BaseController)

SummonMasterJiController.SelectBuffFinishEvent = "SummonMasterJiController_SelectBuffFinish"

function SummonMasterJiController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.SummonMasterJiGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.SummonMasterJiOneKeyPassNormalRes, self._onOneKeyPassNormalRes, self)
	GlobalDispatcher:addListener(GlobalNotify.Notify_SummonMasterJiChallengeExtremeRes, self._onNotifyChallengeExtremeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.Notify_SummonMasterJiChallengeNormalRes, self._onNofityChallengeNormalRes, self)
end

function SummonMasterJiController:_onGetInfoRes(activityId)
	self:updateNormalBuffDailyRedPoint(activityId)
end

function SummonMasterJiController:_onOneKeyPassNormalRes(activityId)
	self:updateNormalBuffDailyRedPoint(activityId)
end

function SummonMasterJiController:_onNotifyChallengeExtremeRes(activityId, stageId)
	UIJumper.instance:pushOneStack(ViewName.SummonMasterJiMainView, true)

	if not SummonMasterJiModel.instance:isPassExtremeChallenge(activityId) then
		UIJumper.instance:pushOneStack(ViewName.SummonMasterJiExtremeView, true, activityId)
		UIJumper.instance:pushOneStack(ViewName.SummonMasterJiExtremeClgView, true, activityId, stageId)
	end
end

function SummonMasterJiController:_onNofityChallengeNormalRes(activityId)
	UIJumper.instance:pushOneStack(ViewName.SummonMasterJiMainView, true)

	if not SummonMasterJiModel.instance:isPassNormalChallenge(activityId) then
		UIJumper.instance:pushOneStack(ViewName.SummonMasterJiNormalView, true, activityId)
	end
end

function SummonMasterJiController:loadBaseInfo()
	local activityId = SummonMasterJiModel.instance:getActivityId()

	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		SummonMasterJiAgent.instance:sendPM_SummonMasterJiGetInfoReq(activityId)
	end
end

function SummonMasterJiController:getExtremeAllDesc(activityId)
	local str = ""
	local cfgs = SummonMasterJiConfig.instance:getExtremeScoreBuffList(activityId)
	local maxScore = "∞"

	for i, v in ipairs(cfgs) do
		if cfgs[i + 1] then
			local rangeStr = string.format("%d-%d", v.startTotalScore, cfgs[i + 1].startTotalScore - 1)

			str = i == 1 and str .. string.format(v.desc, rangeStr) or str .. "\n" .. string.format(v.desc, rangeStr)
		else
			local rangeStr = string.format("%d-%s", v.startTotalScore, maxScore)

			str = i == 1 and str .. string.format(v.desc, rangeStr) or str .. "\n" .. string.format(v.desc, rangeStr)
		end
	end

	return str
end

function SummonMasterJiController:getExtremeDescByScore(activityId, curScore)
	local cfgs = SummonMasterJiConfig.instance:getExtremeScoreBuffList(activityId)
	local count = #cfgs
	local maxScore = "∞"
	local str = ""

	for i = count, 1, -1 do
		if curScore >= cfgs[i].startTotalScore then
			if i == count then
				do
					local rangeStr = string.format("%d-%s", cfgs[i].startTotalScore, maxScore)

					str = str .. string.format(cfgs[i].desc, rangeStr)
				end

				break
			end

			do
				local rangeStr = string.format("%d-%d", cfgs[i].startTotalScore, cfgs[i + 1].startTotalScore - 1)

				str = str .. string.format(cfgs[i].desc, rangeStr)
			end

			break
		end
	end

	if string.nilorempty(str) then
		return "无"
	end

	return str
end

function SummonMasterJiController:openExtremeMissionView(activityId, stageId, itemId2Score)
	local customFmtMo = SummonMasterJiModel.instance:getExtremeFmtMo(activityId)

	customFmtMo:initParams(activityId, stageId, itemId2Score)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function SummonMasterJiController:openNormalMissionView(activityId, stageId, blessingId)
	local customFmtMo = SummonMasterJiModel.instance:getNormalFmtMo(activityId)

	customFmtMo:initParams(activityId, stageId, blessingId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function SummonMasterJiController:getMaxChapterNum(activityId)
	local cfgList = SummonMasterJiConfig.instance:getNormalStageList(activityId)

	return cfgList[#cfgList].chapterId
end

function SummonMasterJiController:getChapterList(activityId)
	local chapterList = {}
	local maxChapterNum = self:getMaxChapterNum(activityId)

	for i = 1, maxChapterNum do
		local info = {}

		info.chapterId = i
		info.cfgs = SummonMasterJiConfig.instance:getNormalChapterStageList(activityId, i)

		table.insert(chapterList, info)
	end

	return chapterList
end

function SummonMasterJiController:getChapterIdByStageId(activityId, stageId)
	local cfgStages = SummonMasterJiConfig.instance:getNormalStageList(activityId)

	for i, v in ipairs(cfgStages) do
		if v.stageId == stageId then
			return v.chapterId
		end
	end

	return 0
end

function SummonMasterJiController:getMaxNormalStageId(activityId)
	local cfgStages = SummonMasterJiConfig.instance:getNormalStageList(activityId)

	return cfgStages[#cfgStages].stageId
end

function SummonMasterJiController:getNormalOneKeyCost(activityId)
	local maxStageProgress = self:getMaxNormalStageId(activityId)
	local curStageProgress = SummonMasterJiModel.instance:getNormalCurProgress(activityId)
	local leftProgress = self:getLeftProgress(activityId, curStageProgress)
	local cfgList = SummonMasterJiConfig.instance:getNormalOneKeyCfgList(activityId)
	local count = #cfgList

	for i = count, 1, -1 do
		if leftProgress >= cfgList[i].leftProgress then
			return cfgList[i].cost
		end
	end

	return (cfgList[1] or nil) and (cfgList[1].cost or "")
end

function SummonMasterJiController:getProgress(activityId, stageId)
	local progress = 0
	local totalProgress = 0
	local cfgs = SummonMasterJiConfig.instance:getNormalStageList(activityId)

	for i, v in ipairs(cfgs) do
		totalProgress = totalProgress + v.addNormalProgress

		if stageId >= v.stageId then
			progress = progress + v.addNormalProgress
		end
	end

	return progress, totalProgress
end

function SummonMasterJiController:getLeftProgress(activityId, stageId)
	local progress = 0
	local totalProgress = 0
	local cfgs = SummonMasterJiConfig.instance:getNormalStageList(activityId)

	for i, v in ipairs(cfgs) do
		totalProgress = totalProgress + v.addNormalProgress

		if stageId >= v.stageId then
			progress = progress + v.addNormalProgress
		end
	end

	return (Mathf.Max(totalProgress - progress, 0))
end

function SummonMasterJiController:updateNormalBuffDailyRedPoint(activityId)
	local isEnteredBuffView = GameUtil.getUserDayData(RedPointModel.ID_SummonMasterJiNormalBuffDaily)
	local isPassedNormal = SummonMasterJiModel.instance:isPassNormalChallenge(activityId)
	local isShowRed = not isPassedNormal and not isEnteredBuffView

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SummonMasterJiNormalBuffDaily, isShowRed)
end

function SummonMasterJiController:markNormalBuffDailyRedPoint(activityId)
	GameUtil.saveUserDayData(RedPointModel.ID_SummonMasterJiNormalBuffDaily, true)
	self:updateNormalBuffDailyRedPoint(activityId)
end

function SummonMasterJiController:getRedPointIds(activityId)
	if SummonMasterJiModel.instance:isPassNormalChallenge(activityId) then
		return RedPointModel.ID_SummonMasterJiNormalBuffDaily
	else
		return RedPointModel.ID_SummonMasterJiNormalBuffDaily
	end
end

function SummonMasterJiController:saveBlessingId(activityId, stageId, blessingId)
	local key = activityId .. "_" .. stageId

	GameUtil.saveUserData(key, blessingId)
end

function SummonMasterJiController:getBlessingId(activityId, stageId)
	local key = activityId .. "_" .. stageId
	local blessingId = GameUtil.getUserData(key)

	return checknumber(blessingId)
end

function SummonMasterJiController:isOpenExtremeStage(activityId, stageId)
	local cfg = SummonMasterJiConfig.instance:getExtremeStageCfg(activityId, stageId)

	if cfg then
		local openTime = GameUtil.string2time(cfg.openTime)
		local curTime = ServerTime.now()

		return openTime <= curTime
	else
		return false
	end
end

SummonMasterJiController.instance = SummonMasterJiController.New()

return SummonMasterJiController
