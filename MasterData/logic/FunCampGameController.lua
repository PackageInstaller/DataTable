-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/controller/funcampgame/FunCampGameController.lua

module("logic.extensions.funcamp.controller.funcampgame.FunCampGameController", package.seeall)

local FunCampGameController = class("FunCampGameController", BaseController)

function FunCampGameController:openGameStart(activityId)
	UIStateManager.instance:push(ViewName.FunCampGameStart, activityId)
end

function FunCampGameController:openGameMain(activityId)
	UIStateManager.instance:push(ViewName.FunCampGameMain, activityId)
end

function FunCampGameController:openGameOver(activityId, score, encryptedKey)
	FunCampAgent.instance:sendPM_CB_EndGameReq(score, encryptedKey)
end

function FunCampGameController:sendStartGameReq(activityId, clientKey)
	FunCampAgent.instance:sendPM_CB_StartGameReq(activityId, clientKey)
end

FunCampGameController.instance = FunCampGameController.New()

return FunCampGameController
