-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat/controller/YearCardPreheatController.lua

module("logic.extensions.preheatsale.controller.YearCardPreheatController", package.seeall)

local YearCardPreheatController = class("YearCardPreheatController", BaseController)

function YearCardPreheatController:handleGetInfo(msg)
	YearCardPreheatModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheatUndateInfo)
end

function YearCardPreheatController:handleStartGame(msg)
	YearCardPreheatModel.instance:onStartGame(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheatGameStart)
end

function YearCardPreheatController:handleGameOver(msg)
	YearCardPreheatModel.instance:onGameOver(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheatGameEnd)
end

function YearCardPreheatController:handleGainPrize(msg)
	YearCardPreheatModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheatUndateInfo)
end

function YearCardPreheatController:handleUnlock(msg)
	YearCardPreheatModel.instance:onUnlock(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearCardPreheatUndateInfo)
end

YearCardPreheatController.instance = YearCardPreheatController.New()

return YearCardPreheatController
