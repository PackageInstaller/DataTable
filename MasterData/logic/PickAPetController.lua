-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickapet/controller/PickAPetController.lua

module("logic.extensions.pickapet.controller.PickAPetController", package.seeall)

local PickAPetController = class("PickAPetController", BaseController)

function PickAPetController:ctor()
	return
end

function PickAPetController:startCountDown()
	GlobalDispatcher:dispatch(GlobalNotify.PickCountDown)
end

function PickAPetController:startGame()
	GlobalDispatcher:dispatch(GlobalNotify.PickStartGame)
end

function PickAPetController:nextGame()
	GlobalDispatcher:dispatch(GlobalNotify.PickLevelEnd)
	GlobalDispatcher:dispatch(GlobalNotify.PickNextGate)
end

function PickAPetController:pauseGame(pause)
	GlobalDispatcher:dispatch(GlobalNotify.PickPause, pause)
end

function PickAPetController:endGame(success, callback)
	GlobalDispatcher:dispatch(GlobalNotify.PickEndGame)
	UIStateManager.instance:open(ViewName.PickResultView, success, callback)
end

PickAPetController.instance = PickAPetController.New()

return PickAPetController
