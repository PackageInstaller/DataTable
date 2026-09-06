-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/agent/KingSpaceDragonClgAgent.lua

module("logic.extensions.kingspacedragonclg.agent.KingSpaceDragonClgAgent", package.seeall)

local KingSpaceDragonClgAgent = class("KingSpaceDragonClgAgent", BaseAgent)

function KingSpaceDragonClgAgent:sendPM_KingSpaceDragonClgGetInfoReq(activityId)
	local req = KingSpaceDragonClgExtension_pb.PM_KingSpaceDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingSpaceDragonClgAgent:handlePM_KingSpaceDragonClgGetInfoRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId

		KingspacedragonModel.instance:setInfo(msg)
		KingspacedragonController.instance:calRedpoint(activityId)
		GlobalDispatcher:dispatch(GlobalNotify.KingSpaceDragonClgGetInfoRes)
	end
end

function KingSpaceDragonClgAgent:sendPM_KingSpaceDragonClgFightReq(activityId, monsterType, form)
	local req = KingSpaceDragonClgExtension_pb.PM_KingSpaceDragonClgFightReq()

	req.activityId = activityId
	req.monsterType = monsterType

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function KingSpaceDragonClgAgent:handlePM_KingSpaceDragonClgFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.KingSpaceDragonClgFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function KingSpaceDragonClgAgent:handlePM_KingSpaceDragonClgNotifyFightResultRes(status, msg)
	if status == 0 then
		KingspacedragonController.instance:handlePM_KingSpaceDragonClgNotifyFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KingSpaceDragonClgNotifyFightResultRes)
	end
end

function KingSpaceDragonClgAgent:sendPM_KingSpaceDragonClgFightConfirmReq(activityId, confirmNum, save)
	local req = KingSpaceDragonClgExtension_pb.PM_KingSpaceDragonClgFightConfirmReq()

	req.activityId = activityId
	req.confirmNum = confirmNum
	req.save = save

	self:sendMsg(req)
end

function KingSpaceDragonClgAgent:handlePM_KingSpaceDragonClgFightConfirmRes(status, msg)
	if status == 0 then
		KingspacedragonModel.instance:confirmRes(msg)
		KingspacedragonController.instance:calRedpoint(msg.activityId)
		KingspacedragonController.instance:resetNeedConfirm()
		GlobalDispatcher:dispatch(GlobalNotify.KingSpaceDragonClgFightConfirmRes)
	end
end

KingSpaceDragonClgAgent.instance = KingSpaceDragonClgAgent.New()

return KingSpaceDragonClgAgent
