-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/puzzlegame/controller/PuzzleGameController.lua

module("logic.extensions.puzzlegame.controller.PuzzleGameController", package.seeall)

local PuzzleGameController = class("PuzzleGameController", BaseController)

function PuzzleGameController:onReset()
	return
end

function PuzzleGameController:getInfo(actId)
	PuzzleGameAgent.instance:sendPM_PuzzleGameGetInfoReq(actId)
end

function PuzzleGameController:handleGetInfo(msg)
	PuzzleGameModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PuzzleGameHudGetInfo)
end

function PuzzleGameController:startGame(actId, jigsawId)
	local clientKey = math.random(ServerTime.now())

	PuzzleGameModel.instance:setClientKey(clientKey)
	PuzzleGameAgent.instance:sendPM_PuzzleGameStartGameReq(actId, jigsawId, clientKey)
end

function PuzzleGameController:handleStartGame(msg)
	PuzzleGameModel.instance:onStartGame(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PuzzleGameHudStart)
end

function PuzzleGameController:endGame(isPass, clientEncryptedKey)
	PuzzleGameAgent.instance:sendPM_PuzzleGameEndGameReq(isPass, clientEncryptedKey)
	GlobalDispatcher:dispatch(GlobalNotify.PuzzleGameHudGetInfo)
end

function PuzzleGameController:handleEndGame(msg)
	PuzzleGameModel.instance:onEndGame(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PuzzleGameHudEnd)
	GlobalDispatcher:dispatch(GlobalNotify.PuzzleGameHudGetInfo)
end

function PuzzleGameController:gainProgressPrize(progreeCfg)
	local actId = PuzzleGameModel.instance:getActId()

	if not progreeCfg then
		printError("传入进度配置为空")

		return
	end

	local progressId = progreeCfg.progressId
	local isTimeMatch = ServerTime.now() - GameUtil.string2time(progreeCfg.startTime) > 0

	if isTimeMatch then
		PuzzleGameAgent.instance:sendPM_PuzzleGameGainProgressPrizeReq(actId, progressId)
	else
		FloatWordMgr.instance:show(langPara("该奖励需在%s后再来领取噢", progreeCfg.startTime))
	end
end

function PuzzleGameController:handleGainProgressPrize(msg)
	PuzzleGameModel.instance:onGainProgressPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PuzzleGameHudGainProgressPrize)
end

PuzzleGameController.instance = PuzzleGameController.New()

return PuzzleGameController
