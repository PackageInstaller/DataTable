-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/controller/JieShenEventController.lua

module("logic.extensions.jieshenevent.controller.JieShenEventController", package.seeall)

local JieShenEventController = class("JieShenEventController", BaseController)

function JieShenEventController:onInit()
	self:onReset()
end

function JieShenEventController:onReset()
	return
end

function JieShenEventController:_handlePM_JieShenEventGetInfoRes(msg)
	JieShenEventModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_JieShenEventGetInfoRes)
end

function JieShenEventController:_handlePM_JieShenEventFinishGameRes(msg)
	JieShenEventModel.instance:saveInfo(msg)

	if msg.changeSetId then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_JieShenEventFinishGameRes, msg.informerId)
end

function JieShenEventController:_handlePM_JieShenEvnetGainTimelinePrizeRes(msg)
	JieShenEventModel.instance:saveTimelinInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_JieShenEvnetGainTimelinePrizeRes)
end

function JieShenEventController:_handlePM_JieShenEvnetComboClueRes(status, msg)
	if status == 0 then
		JieShenEventModel.instance:saveClueInfo(msg)
		UIStateManager.instance:push(ViewName.JieShenEventClueTipsView, msg.activityId, msg.targetClueId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_JieShenEvnetComboClueRes, status)
end

function JieShenEventController:_handlePM_JieShenEvnetGainCluePrizeRes(msg)
	JieShenEventModel.instance:saveClueTabInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_JieShenEvnetGainCluePrizeRes)
end

function JieShenEventController:sendPassMiniGame(activityId, informerId, map, road)
	local req = JieShenEventExtension_pb.PM_JieShenEventFinishGameReq()
	local arr = {}

	if map and #map > 0 then
		for i = 1, #map do
			local param = req.blockList:add()

			param.id = map[i].id
			param.times = map[i].time

			table.insert(arr, param)
		end
	end

	JieShenEventAgent.instance:sendPM_JieShenEventFinishGameReq(activityId, informerId, arr, road)
end

function JieShenEventController:isTabCollectClueComplete(activityId, tabId)
	local tabCfg = JieShenEventConfig.instance:getClueTabCfg(activityId, tabId)
	local isCanGainPrize = true

	for i, v in ipairs(tabCfg.clueIds) do
		if not JieShenEventModel.instance:isGainClue(activityId, v) then
			isCanGainPrize = false

			break
		end
	end

	return isCanGainPrize
end

JieShenEventController.instance = JieShenEventController.New()

return JieShenEventController
