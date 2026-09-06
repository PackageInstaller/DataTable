-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starscratch/controller/StarScratchController.lua

module("logic.extensions.starscratch.controller.StarScratchController", package.seeall)

local StarScratchController = class("StarScratchController", BaseController)

function StarScratchController:ctor()
	StarScratchController.super.ctor(self)
end

function StarScratchController:onInit()
	self:onReset()
end

function StarScratchController:onReset()
	self.isDataInited = false
end

function StarScratchController:handlePM_StarScratchInfoRes(msg)
	StarScratchModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StarScratchInfoRes)
end

function StarScratchController:sendPM_StarScratchBuyReq(activityId, cycleId)
	self._tempActivityId = activityId
	self._tempCycleId = cycleId

	StarScratchAgent.instance:sendPM_StarScratchBuyReq(activityId, cycleId)
end

function StarScratchController:handlePM_StarScratchBuyRes(msg)
	StarScratchModel.instance:saveBuyInfo(msg, self._tempActivityId, self._tempCycleId)

	self._tempActivityId = nil
	self._tempCycleId = nil

	GlobalDispatcher:dispatch(GlobalNotify.PM_StarScratchBuyRes)
end

function StarScratchController:handlePM_StarScratchGainRes(msg)
	StarScratchModel.instance:saveGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StarScratchGainRes)
end

function StarScratchController:handlePM_StarScratchRefreshBroadcastRes(msg)
	StarScratchModel.instance:saveBroadcast(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_StarScratchRefreshBroadcastRes)
end

StarScratchController.instance = StarScratchController.New()

return StarScratchController
