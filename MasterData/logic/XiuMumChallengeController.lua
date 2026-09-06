-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiumumchallenge/controller/XiuMumChallengeController.lua

module("logic.extensions.xiumumchallenge.controller.XiuMumChallengeController", package.seeall)

local XiuMumChallengeController = class("XiuMumChallengeController", BaseController)

function XiuMumChallengeController:onReset()
	return
end

function XiuMumChallengeController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
end

function XiuMumChallengeController:_dailyReset()
	if XiuMumChallengeModel.instance:getCurActId() ~= 0 then
		XiuMumChallengeModel.instance:setDailyRefresh(true)
	end
end

function XiuMumChallengeController:getInfo(actId)
	XiuMumChallengeAgent.instance:sendPM_XiuMumChallengeGetInfoReq(actId)
end

function XiuMumChallengeController:handleGetInfo(msg)
	XiuMumChallengeModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.XiuMumChallengeUpdateInfo)
end

function XiuMumChallengeController:passGame(map, road, stageId)
	local activityId = XiuMumChallengeModel.instance:getCurActId()
	local req = XiuMumChallengeExtension_pb.PM_XiuMumChallengeSubmitMapReq()
	local arr = {}

	if map and #map > 0 then
		for i = 1, #map do
			local param = req.map:add()

			param.id = map[i].id
			param.time = map[i].time

			table.insert(arr, param)
		end
	end

	XiuMumChallengeAgent.instance:sendPM_XiuMumChallengeSubmitMapReq(activityId, arr, road, stageId)
end

function XiuMumChallengeController:handlePassGame(msg)
	XiuMumChallengeModel.instance:onPassGame(msg)
	GlobalDispatcher:dispatch(GlobalNotify.XiuMumChallengePassGame)
end

function XiuMumChallengeController:startChallenge(id, fmo)
	local activityId = XiuMumChallengeModel.instance:getCurActId()
	local simpleForm = fmo:createFormPb()

	XiuMumChallengeAgent.instance:sendPM_XiuMumChallengeReq(activityId, id, simpleForm)
end

function XiuMumChallengeController:handleFinishChallenge(msg)
	XiuMumChallengeModel.instance:onFinshChallenge(msg)
	BattleFacade.instance:startXiuMumChallengeBattle()
	GlobalDispatcher:dispatch(GlobalNotify.XiuMumChallengeFinishChallenge)
end

XiuMumChallengeController.instance = XiuMumChallengeController.New()

return XiuMumChallengeController
