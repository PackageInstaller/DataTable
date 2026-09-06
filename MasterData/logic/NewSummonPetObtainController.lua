-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/controller/NewSummonPetObtainController.lua

module("logic.extensions.newsummonpetobtain.controller.NewSummonPetObtainController", package.seeall)

local NewSummonPetObtainController = class("NewSummonPetObtainController", BaseController)

function NewSummonPetObtainController:ctor()
	return
end

function NewSummonPetObtainController:onInit()
	self:onReset()
end

function NewSummonPetObtainController:onReset()
	return
end

function NewSummonPetObtainController:loadNsop()
	local activityId = self:getActivityId()

	if activityId > 0 then
		NewSummonPetObtainController.instance:sendPM_NewSummonPetObtainGetPlayerInfoReq(activityId)
	end
end

function NewSummonPetObtainController:sendPM_NewSummonPetObtainGetInfoReq(activityId)
	NewSummonPetObtainAgent.instance:sendPM_NewSummonPetObtainGetInfoReq(activityId)
end

function NewSummonPetObtainController:handlePM_NewSummonPetObtainGetInfoRes(msg)
	NewSummonPetObtainModel.instance:handlePM_NewSummonPetObtainGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NewSummonPetObtainGetInfoRes)
end

function NewSummonPetObtainController:sendPM_NewSummonPetObtainGainPrizeReq(activityId, prizeId)
	NewSummonPetObtainAgent.instance:sendPM_NewSummonPetObtainGainPrizeReq(activityId, prizeId)
end

function NewSummonPetObtainController:handlePM_NewSummonPetObtainGainPrizeRes(msg)
	NewSummonPetObtainModel.instance:handlePM_NewSummonPetObtainGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NewSummonPetObtainGainPrizeRes)
end

function NewSummonPetObtainController:sendPM_NewSummonPetObtainGetPlayerInfoReq(activityId)
	NewSummonPetObtainAgent.instance:sendPM_NewSummonPetObtainGetPlayerInfoReq(activityId)
end

function NewSummonPetObtainController:handlePM_NewSummonPetObtainGetPlayerInfoRes(msg)
	NewSummonPetObtainModel.instance:handlePM_NewSummonPetObtainGetPlayerInfoRes(msg)
	self:_updatePlayMusicRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.NewSummonPetObtainGetPlayerInfoRes)
end

function NewSummonPetObtainController:sendPM_NewSummonPetObtainGameEndReq(activityId)
	NewSummonPetObtainAgent.instance:sendPM_NewSummonPetObtainGameEndReq(activityId)
end

function NewSummonPetObtainController:handlePM_NewSummonPetObtainGameEndRes(msg)
	NewSummonPetObtainModel.instance:handlePM_NewSummonPetObtainGameEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NewSummonPetObtainGameEndRes)
end

function NewSummonPetObtainController:sendPM_NewSummonPetObtainGainTaskScoreReq(activityId, taskId)
	NewSummonPetObtainAgent.instance:sendPM_NewSummonPetObtainGainTaskScoreReq(activityId, taskId)
end

function NewSummonPetObtainController:handlePM_NewSummonPetObtainGainTaskScoreRes(msg)
	NewSummonPetObtainModel.instance:handlePM_NewSummonPetObtainGainTaskScoreRes(msg)
	self:_updatePlayMusicRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.NewSummonPetObtainGainTaskScoreRes, msg)
end

function NewSummonPetObtainController:sendPM_NewSummonPetObtainGetBalanceTierReq(activityId)
	NewSummonPetObtainAgent.instance:sendPM_NewSummonPetObtainGetBalanceTierReq(activityId)
end

function NewSummonPetObtainController:handlePM_NewSummonPetObtainGetBalanceTierRes(msg)
	NewSummonPetObtainModel.instance:handlePM_NewSummonPetObtainGetBalanceTierRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NewSummonPetObtainGetBalanceTierRes)
end

function NewSummonPetObtainController:sendPM_NewSummonPetObtainGetBalanceInfoReq(activityId, stageId)
	NewSummonPetObtainAgent.instance:sendPM_NewSummonPetObtainGetBalanceInfoReq(activityId, stageId)
end

function NewSummonPetObtainController:handlePM_NewSummonPetObtainGetBalanceInfoRes(msg)
	NewSummonPetObtainModel.instance:handlePM_NewSummonPetObtainGetBalanceInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NewSummonPetObtainGetBalanceInfoRes)
	self:sendBalanceStageReadyStack()
end

function NewSummonPetObtainController:sendPM_NewSummonPetObtainChallengeReq(activityId, stageId, isBlack, form)
	NewSummonPetObtainAgent.instance:sendPM_NewSummonPetObtainChallengeReq(activityId, stageId, isBlack, form)
end

function NewSummonPetObtainController:handlePM_NewSummonPetObtainChallengeRes(msg)
	NewSummonPetObtainModel.instance:handlePM_NewSummonPetObtainChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NewSummonPetObtainChallengeRes)
end

function NewSummonPetObtainController:handlePM_NewSummonPetObtainChallengeResultRes(msg)
	NewSummonPetObtainModel.instance:handlePM_NewSummonPetObtainChallengeResultRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NewSummonPetObtainChallengeResultRes)
end

function NewSummonPetObtainController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.PET_OBTAIN)
end

function NewSummonPetObtainController:getBeiduoActivityId()
	return 206001
end

function NewSummonPetObtainController:getHuanHuangActivityId()
	return 206002
end

function NewSummonPetObtainController:getMaxNeedScoreInProgress(activityId)
	local prizeCfg = NewSummonPetObtainConfig.instance:getNspoPrizeCfgById(activityId)

	return (prizeCfg or nil) and (prizeCfg[#prizeCfg].needScore or 0)
end

function NewSummonPetObtainController:isCanGetPrizeInProgress(prizeId)
	return self:isEnoughPrizeInProgress(prizeId) and not self:isHasGainPrizeInProgress(prizeId)
end

function NewSummonPetObtainController:isHasGainPrizeInProgress(prizeId)
	return NewSummonPetObtainModel.instance:isHasGainPrizeInProgress(prizeId)
end

function NewSummonPetObtainController:isEnoughPrizeInProgress(prizeId)
	local activityId = NewSummonPetObtainModel.instance:getCurActivityId()
	local data = NewSummonPetObtainConfig.instance:getNspoPrizeDataById(activityId, prizeId)
	local curScore = NewSummonPetObtainModel.instance:getCurScoreInProgress()

	return data and curScore >= data.needScore or false
end

function NewSummonPetObtainController:isCanGetPrizeInMusic()
	local activityId = self:getActivityId()

	if activityId == 0 then
		return
	end

	local isCanGet = false
	local cfg = NewSummonPetObtainConfig.instance:getNspoTaskCfgById(activityId)

	for _, data in ipairs(cfg) do
		if self:isCanGetPrizeAsMusicTask(data.taskId) then
			isCanGet = true

			break
		end
	end

	return isCanGet
end

function NewSummonPetObtainController:isCanGetPrizeAsMusicTask(taskId)
	return self:isEnoughPrizeAsMusicTask(taskId) and not self:isHasGainTaskPrizeAsMusicTask(taskId)
end

function NewSummonPetObtainController:isHasGainTaskPrizeAsMusicTask(taskId)
	return NewSummonPetObtainModel.instance:isHasGainTaskPrizeAsMusicTask(taskId)
end

function NewSummonPetObtainController:isEnoughPrizeAsMusicTask(taskId)
	local activityId = NewSummonPetObtainModel.instance:getCurActivityId()
	local finalAccomplishId = NewSummonPetObtainModel.instance:getFinalAccomplishIdInMusic()
	local isHasPlay = NewSummonPetObtainModel.instance:isHasPlayGameTodayInMusic()

	return taskId <= finalAccomplishId
end

function NewSummonPetObtainController:isFinishAllTask()
	local activityId = NewSummonPetObtainModel.instance:getCurActivityId()
	local finalAccomplishId = NewSummonPetObtainModel.instance:getFinalAccomplishIdInMusic()
	local allTaskCount = NewSummonPetObtainConfig.instance:getNspoTaskCount(activityId)

	return allTaskCount <= finalAccomplishId
end

function NewSummonPetObtainController:_updatePlayMusicRed(activityId)
	local redIdAsMusicPlay = NewSummonPetObtainConfig.instance:getNspoMusicCanPlayRedId(activityId)

	if not string.nilorempty(redIdAsMusicPlay) then
		local isHasPlayGameToday = NewSummonPetObtainModel.instance:isHasPlayGameTodayInMusic()
		local isFinishAllTask = self:isFinishAllTask()

		RedPointController.instance:setRedPointInfo(redIdAsMusicPlay, not isHasPlayGameToday and not isFinishAllTask)
	end

	local redIdAsMusicPrize = NewSummonPetObtainConfig.instance:getNspoMusicPrizeRedId(activityId)

	if not string.nilorempty(redIdAsMusicPrize) then
		RedPointController.instance:setRedPointInfo(redIdAsMusicPrize, self:isCanGetPrizeInMusic())
	end
end

function NewSummonPetObtainController:getNsopMusicPlayAudioId()
	return 12001
end

function NewSummonPetObtainController:playNsopBgMusic(audioId)
	if self._isPlayingBgm then
		return
	else
		self._isPlayingBgm = true
	end

	self._curAudioId = audioId

	AudioPlayerEx.instance:playMusic(self._curAudioId)
end

function NewSummonPetObtainController:stopNsopBgMusic(audioId)
	if not self._isPlayingBgm or self._curAudioId == audioId then
		return
	else
		self._isPlayingBgm = false
	end

	local scene = SceneMgr.instance:getCurScene()

	if scene then
		local bgmId = 0

		if scene.bgm and scene.bgm.getBgmId then
			bgmId = scene.bgm:getBgmId()
		end

		if bgmId and bgmId ~= 0 then
			self._curAudioId = bgmId

			AudioPlayerEx.instance:playMusic(bgmId)
		end
	end
end

function NewSummonPetObtainController:updateBalanceMainViewInfo(activityId, tier)
	local tierData = NewSummonPetObtainConfig.instance:getNspoTierDataById(activityId, tier)
	local stageCfg = NewSummonPetObtainConfig.instance:getNspoStageCfg(tierData.stagePlanId)

	self._balanceStageReady = {}
	self._balanceStageReady.activityId = activityId
	self._balanceStageReady.stageIdList = {}

	for _, data in ipairs(stageCfg) do
		table.insert(self._balanceStageReady.stageIdList, data.stageId)
	end

	self:sendBalanceStageReadyStack()
end

function NewSummonPetObtainController:sendBalanceStageReadyStack()
	if self._balanceStageReady then
		local activityId = self._balanceStageReady.activityId
		local stageId = self._balanceStageReady.stageIdList[#self._balanceStageReady.stageIdList]

		if checknumber(activityId) > 0 and checknumber(stageId) > 0 then
			self:sendPM_NewSummonPetObtainGetBalanceInfoReq(activityId, stageId)

			self._balanceStageReady.stageIdList[#self._balanceStageReady.stageIdList] = nil
		else
			GlobalDispatcher:dispatch(GlobalNotify.AllBalanceStageInfoReadky)
		end
	end
end

function NewSummonPetObtainController:enterBattleAsBS(activityId, stagePlanId, stageId, isBlack)
	local customFmtMo = NewSummonPetObtainModel.instance:getCustomFmtMoAsBS()

	customFmtMo:updateCfg(activityId, stagePlanId, stageId, isBlack)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

NewSummonPetObtainController.instance = NewSummonPetObtainController.New()

return NewSummonPetObtainController
