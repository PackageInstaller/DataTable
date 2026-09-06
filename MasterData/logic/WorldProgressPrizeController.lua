-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldprogressprize/controller/WorldProgressPrizeController.lua

module("logic.extensions.worldprogressprize.controller.WorldProgressPrizeController", package.seeall)

local WorldProgressPrizeController = class("WorldProgressPrizeController", BaseController)

function WorldProgressPrizeController:onInit()
	return
end

function WorldProgressPrizeController:onReset()
	return
end

function WorldProgressPrizeController:sendPM_WorldProgressPrizeGetInfoReq(activityId)
	WorldProgressPrizeAgent.instance:sendPM_WorldProgressPrizeGetInfoReq(activityId)
end

function WorldProgressPrizeController:handlePM_WorldProgressPrizeGetInfoRes(msg)
	local mo = self:getWorldProgressPrizeMo(msg.activityId)

	mo:handlePM_WorldProgressPrizeGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_WorldProgressPrizeGetInfoRes)
end

function WorldProgressPrizeController:sendPM_WorldProgressPrizeGainPrizeReq(activityId, progressId, prizeId)
	WorldProgressPrizeAgent.instance:sendPM_WorldProgressPrizeGainPrizeReq(activityId, progressId, prizeId)
end

function WorldProgressPrizeController:handlePM_WorldProgressPrizeGainPrizeRes(msg)
	local mo = self:getWorldProgressPrizeMo(msg.activityId)

	mo:handlePM_WorldProgressPrizeGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_WorldProgressPrizeGainPrizeRes)
end

function WorldProgressPrizeController:sendPM_WorldProgressOneClickGainPrizeReq(activityId, progressId)
	WorldProgressPrizeAgent.instance:sendPM_WorldProgressOneClickGainPrizeReq(activityId, progressId)
end

function WorldProgressPrizeController:handlePM_WorldProgressOneClickGainPrizeRes(msg)
	local mo = self:getWorldProgressPrizeMo(msg.activityId)

	mo:handlePM_WorldProgressOneClickGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_WorldProgressOneClickGainPrizeRes)
end

function WorldProgressPrizeController:getWorldProgressPrizeMo(activityId)
	return WorldProgressPrizeModel.instance:getWorldProgressPrizeMo(activityId)
end

function WorldProgressPrizeController:getProgress(activityId, progressId)
	local mo = self:getWorldProgressPrizeMo(activityId)

	return mo:getProgress(progressId)
end

WorldProgressPrizeController.instance = WorldProgressPrizeController.New()

return WorldProgressPrizeController
