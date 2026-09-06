-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolammgame/controller/DuoLaMMGameController.lua

module("logic.extensions.duolammgame.controller.DuoLaMMGameController", package.seeall)

local DuoLaMMGameController = class("DuoLaMMGameController", BaseController)

function DuoLaMMGameController:ctor()
	return
end

function DuoLaMMGameController:onReset()
	return
end

function DuoLaMMGameController:sendPM_DuoLaMMGameGetInfoReq(activityId)
	DuoLaMMGameAgent.instance:sendPM_DuoLaMMGameGetInfoReq(activityId)
end

function DuoLaMMGameController:handlePM_DuoLaMMGameGetInfoRes(msg)
	DuoLaMMGameModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DuoLaMMGameGetInfoRes)
end

function DuoLaMMGameController:sendPM_DuoLaMMGameBuyGameTimesReq(activityId)
	DuoLaMMGameAgent.instance:sendPM_DuoLaMMGameBuyGameTimesReq(activityId)
end

function DuoLaMMGameController:handlePM_DuoLaMMGameBuyGameTimesRes(msg)
	DuoLaMMGameModel.instance:onButGameTime(msg)
end

function DuoLaMMGameController:sendPM_DuoLaMMGameStartGameReq(activityId, clientKey)
	DuoLaMMGameAgent.instance:sendPM_DuoLaMMGameStartGameReq(activityId, clientKey)
end

function DuoLaMMGameController:handlePM_DuoLaMMGameStartGameRes(msg)
	DuoLaMMGameModel.instance:onStartGame(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DuoLaMMGameStartRes)
end

function DuoLaMMGameController:sendPM_DuoLaMMGameReliveReq(activityId)
	DuoLaMMGameAgent.instance:sendPM_DuoLaMMGameReliveReq(activityId)
end

function DuoLaMMGameController:handlePM_DuoLaMMGameReliveRes(msg)
	DuoLaMMGameModel.instance:onGameRelive(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DuoLaMMGameReliveRes)
end

function DuoLaMMGameController:sendPM_DuoLaMMGameEndGameReq(activityId, ids, encryptedKey)
	DuoLaMMGameAgent.instance:sendPM_DuoLaMMGameEndGameReq(activityId, ids, encryptedKey)
end

function DuoLaMMGameController:handlePM_DuoLaMMGameEndGameRes(msg)
	DuoLaMMGameModel.instance:onGameEnd(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DuoLaMMGameEndRes)
end

function DuoLaMMGameController:startGame(actId)
	if not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DuoLaMMGame, actId) then
		FloatWordMgr.instance:show("游戏未开放")

		return
	end

	local actCfg = DuoLaMMGameConfig.instance:getActCfg(actId)
	local gameTimes = DuoLaMMGameModel.instance:getGameTimes(actId)

	if gameTimes >= actCfg.dailyFreeGameTimes then
		FloatWordMgr.instance:show("今日游戏次数已用完，请明天再来")

		return
	end

	UIStateManager.instance:push(ViewName.DuoLaMMGameView, actId)
end

DuoLaMMGameController.instance = DuoLaMMGameController.New()

return DuoLaMMGameController
