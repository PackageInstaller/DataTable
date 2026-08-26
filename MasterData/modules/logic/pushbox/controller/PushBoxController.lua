-- chunkname: @modules/logic/pushbox/controller/PushBoxController.lua

module("modules.logic.pushbox.controller.PushBoxController", package.seeall)

local PushBoxController = class("PushBoxController", BaseController)

function PushBoxController:onInit()
	return
end

function PushBoxController:onInitFinish()
	return
end

function PushBoxController:addConstEvents()
	return
end

function PushBoxController:reInit()
	return
end

function PushBoxController:enterPushBoxGame()
	PushBoxRpc.instance:sendGet111InfosRequest(function()
		GameSceneMgr.instance:startScene(SceneType.PushBox, 1, 1)
	end, self)
end

PushBoxController.instance = PushBoxController.New()

return PushBoxController
