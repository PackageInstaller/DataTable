-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plantgodtree/controller/PlantGodTreeController.lua

module("logic.extensions.planetarium.controller.PlantGodTreeController", package.seeall)

local PlantGodTreeController = class("PlantGodTreeController", BaseController)

PlantGodTreeController.dragType = {
	CutWeed = 1,
	WaterTree = 2,
	FertilizeTree = 3
}
PlantGodTreeController.eventType = {
	Water = 1,
	Grass = 2
}

function PlantGodTreeController:onInit()
	self:onReset()
end

function PlantGodTreeController:onReset()
	self._grassMap = {}
end

function PlantGodTreeController:sendPM_PlantGodTreeGetInfoReq(activityId)
	PlantGodTreeAgent.instance:sendPM_PlantGodTreeGetInfoReq(activityId)
end

function PlantGodTreeController:handlePM_PlantGodTreeGetInfoRes(status, msg)
	if status == 0 then
		PlantGodTreeModel.instance:handlePM_PlantGodTreeGetInfoRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_PlantGodTreeGetInfoRes)
end

function PlantGodTreeController:sendPM_PlantGodTreePushStepReq(activityId, treeId)
	PlantGodTreeAgent.instance:sendPM_PlantGodTreePushStepReq(activityId, treeId)
end

function PlantGodTreeController:handlePM_PlantGodTreePushStepRes(status, msg)
	if status == 0 then
		PlantGodTreeModel.instance:handlePM_PlantGodTreePushStepRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_PlantGodTreePushStepRes)
end

function PlantGodTreeController:sendPM_PlantGodTreeDoEventReq(activityId, treeId, eventId, count)
	PlantGodTreeAgent.instance:sendPM_PlantGodTreeDoEventReq(activityId, treeId, eventId, count)
end

function PlantGodTreeController:handlePM_PlantGodTreeDoEventRes(status, msg)
	if status == 0 then
		PlantGodTreeModel.instance:handlePM_PlantGodTreeDoEventRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_PlantGodTreeDoEventRes)
end

function PlantGodTreeController:sendPM_PlantGodTreeGainPrizeReq(activityId, treeId, eventId)
	PlantGodTreeAgent.instance:sendPM_PlantGodTreeGainPrizeReq(activityId, treeId, eventId)
end

function PlantGodTreeController:handlePM_PlantGodTreeGainPrizeRes(status, msg)
	if status == 0 then
		PlantGodTreeModel.instance:handlePM_PlantGodTreeGainPrizeRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_PlantGodTreeGainPrizeRes)
end

function PlantGodTreeController:addEventMapData(activityId, treeId, eventId, addTimeStamp)
	local eventInfoMap = PlantGodTreeModel.instance:getEventInfoMap(activityId)
	local eventMap = eventInfoMap and eventInfoMap[treeId]
	local eventInfo = eventMap and eventMap[eventId]

	if eventInfo then
		eventInfo.needFinishTimes = eventInfo.needFinishTimes + 1
		eventInfo.lastEffectMillis = addTimeStamp
	end
end

PlantGodTreeController.instance = PlantGodTreeController.New()

return PlantGodTreeController
