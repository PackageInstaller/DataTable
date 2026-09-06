-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xplanarchives/agent/XPlanArchivesAgent.lua

module("logic.extensions.xplanarchives.agent.XPlanArchivesAgent", package.seeall)

local XPlanArchivesAgent = class("XPlanArchivesAgent", BaseAgent)

function XPlanArchivesAgent:sendPM_XPlanArchivesInfoReq(activityId)
	local req = XPlanArchivesExtension_pb.PM_XPlanArchivesInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XPlanArchivesAgent:handlePM_XPlanArchivesInfoRes(status, msg)
	if status == 0 then
		XplanarchivesModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XPlanArchivesInfoRes)
	end
end

function XPlanArchivesAgent:sendPM_XPlanArchivesFinishReq(activityId, typeId, id)
	local req = XPlanArchivesExtension_pb.PM_XPlanArchivesFinishReq()

	req.activityId = activityId
	req.typeId = typeId
	req.id = id

	self:sendMsg(req)
end

function XPlanArchivesAgent:handlePM_XPlanArchivesFinishRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local typeId = msg.typeId
		local id = msg.id

		XplanarchivesModel.instance:unlockArchives(activityId, typeId, id)
		GlobalDispatcher:dispatch(GlobalNotify.XPlanArchivesFinishRes)
	end
end

function XPlanArchivesAgent:sendPM_XPlanArchivesGainPrizeReq(activityId, prizeId)
	local req = XPlanArchivesExtension_pb.PM_XPlanArchivesGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function XPlanArchivesAgent:handlePM_XPlanArchivesGainPrizeRes(status, msg)
	if status == 0 then
		XplanarchivesModel.instance:updateGainPrizeId(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XPlanArchivesGainPrizeRes)
	end
end

XPlanArchivesAgent.instance = XPlanArchivesAgent.New()

return XPlanArchivesAgent
