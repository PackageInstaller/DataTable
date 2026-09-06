-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/controller/MusicGameController.lua

module("logic.extensions.musicgame.controller.MusicGameController", package.seeall)

local MusicGameController = class("MusicGameController", BaseController)

function MusicGameController:ctor()
	return
end

function MusicGameController:onInit()
	return
end

function MusicGameController:onReset()
	return
end

function MusicGameController:sendPM_MusicGameInfoReq(activityId)
	MusicGameAgent.instance:sendPM_MusicGameInfoReq(activityId)
end

function MusicGameController:handlePM_MusicGameInfoRes(msg)
	local mo = self:getMusicGameMo(msg.activityId)

	mo:handlePM_MusicGameInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MusicGameInfoRes)
end

function MusicGameController:sendPM_MusicGameStartReq(activityId, gameTypeId)
	local clientKey = math.random(1, 100000)
	local mo = self:getMusicGameMo(activityId)

	mo:setClientKey(clientKey)
	MusicGameAgent.instance:sendPM_MusicGameStartReq(activityId, gameTypeId, clientKey)
end

function MusicGameController:handlePM_MusicGameStartRes(status, msg)
	local mo = self:getMusicGameMo(msg.activityId)

	mo:handlePM_MusicGameStartRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MusicGameStartRes, status, msg)
end

function MusicGameController:sendPM_MusicGameEndReq(activityId, isPass, num)
	local mo = self:getMusicGameMo(activityId)
	local clientKey = mo:getClientKey()
	local serverKey = mo:getServerKey()
	local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, {
		num
	})

	MusicGameAgent.instance:sendPM_MusicGameEndReq(activityId, isPass, num, encryptedKey)
end

function MusicGameController:handlePM_MusicGameEndRes(msg)
	local mo = self:getMusicGameMo(msg.activityId)

	mo:handlePM_MusicGameEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MusicGameEndRes)
end

function MusicGameController:sendPM_MusicGameGainPrizeReq(activityId, prizeId)
	MusicGameAgent.instance:sendPM_MusicGameGainPrizeReq(activityId, prizeId)
end

function MusicGameController:handlePM_MusicGameGainPrizeRes(msg)
	local mo = self:getMusicGameMo(msg.activityId)

	mo:handlePM_MusicGameGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MusicGameGainPrizeRes)
end

function MusicGameController:sendPM_MusicGameSweepReq(activityId, gameTypeId, times)
	MusicGameAgent.instance:sendPM_MusicGameSweepReq(activityId, gameTypeId, times)
end

function MusicGameController:handlePM_MusicGameSweepRes(msg)
	local mo = self:getMusicGameMo(msg.activityId)

	mo:handlePM_MusicGameSweepRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_MusicGameSweepRes)
end

function MusicGameController:getMusicGameMo(activityId)
	return MusicGameModel.instance:getMusicGameMo(activityId)
end

function MusicGameController:getGameMgr(stageId)
	return MusicGameModel.instance:getGameMgr(stageId)
end

function MusicGameController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function MusicGameController:getActivityType()
	return GameEnum.ActivityType.MusicGame
end

function MusicGameController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function MusicGameController:startMusicGame(activityId, gameTypeId, stageId)
	self._gameParams = {}
	self._gameParams[1] = activityId
	self._gameParams[2] = stageId

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_MusicGameStartRes, self._handlePM_MusicGameStartRes, self)
	MusicGameController.instance:sendPM_MusicGameStartReq(activityId, gameTypeId, stageId)
end

function MusicGameController:_handlePM_MusicGameStartRes(status, msg)
	if not self._gameParams then
		local params = {}

		self._gameParams = nil

		GlobalDispatcher:removeListener(GlobalNotify.HandlePM_MusicGameStartRes, self._handlePM_MusicGameStartRes, self)

		if status ~= 0 then
			return
		end

		local activityId = params[1]
		local stageId = params[2]

		if not self:isInActivityTime(activityId) then
			printError(string.format("不在活动时间范围内, activityId = %s", activityId))

			return
		end

		local data = MusicGameConfig.instance:getStageData(stageId)

		if data == nil then
			printError(string.format("配置缺失( yy运营-音乐小游戏.xlsx | export_关卡配置 | activityId=%s, stageId=%s )", activityId, stageId))

			return
		end

		local viewParam = MusicGameViewParam.New()

		viewParam:setStageId(stageId)
		viewParam:setGameEndCallBack(function(gameEndRes, stageId)
			if gameEndRes == MusicGameEnum.GameEndRes_Exit then
				local tipsContent = "中途退出不会扣除次数，也不会累计已获得的分数"

				local function okFunc()
					GlobalDispatcher:dispatch(GlobalNotify.MusicGameSceneViewSatusOp, MusicGameEnum.GameStatusOp_Close)
					MusicGameController.instance:sendPM_MusicGameEndReq(activityId, false, 0)
				end

				local function cencelFunc()
					GlobalDispatcher:dispatch(GlobalNotify.MusicGameSceneViewSatusOp, MusicGameEnum.GameStatusOp_Continue)
				end

				TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
			elseif gameEndRes == MusicGameEnum.GameEndRes_Finish then
				local isPass = gameEndRes == MusicGameEnum.GameEndRes_Finish
				local gameMgr = MusicGameController.instance:getGameMgr(stageId)
				local score = gameMgr:getCurTotalScore()
				local tipsContent = string.format("本关获得%s积分", score)

				local function okFunc()
					GlobalDispatcher:dispatch(GlobalNotify.MusicGameSceneViewSatusOp, MusicGameEnum.GameStatusOp_Close)
					MusicGameController.instance:sendPM_MusicGameEndReq(activityId, isPass, score)
				end

				local alignment = UnityEngine.TextAnchor.MiddleCenter

				TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", alignment)
			end
		end)
		self:enterPlayMusicGame(viewParam)
	end
end

function MusicGameController:startMusicGameByGmTestMode(stageId)
	local viewParam = MusicGameViewParam.New()

	viewParam:setStageId(stageId)
	viewParam:setIsTestMode(true)
	self:enterPlayMusicGame(viewParam)
end

function MusicGameController:enterPlayMusicGame(viewParam)
	UIStateManager.instance:push(ViewName.MusicGameSceneView, viewParam)
end

function MusicGameController:playGameBgMusic(audioId)
	if self._isPlayingBgm then
		return
	else
		self._isPlayingBgm = true
	end

	AudioPlayerEx.instance:playMusic(audioId)
end

function MusicGameController:stopGameBgMusic()
	self._isPlayingBgm = false

	local scene = SceneMgr.instance:getCurScene()

	if scene then
		local bgmId = 0

		if scene.bgm and scene.bgm.getBgmId then
			bgmId = scene.bgm:getBgmId()
		end

		if bgmId and bgmId ~= 0 then
			AudioPlayerEx.instance:playMusic(bgmId)
		end
	end
end

MusicGameController.instance = MusicGameController.New()

return MusicGameController
