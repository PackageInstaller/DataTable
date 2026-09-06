-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishiclg/agent/DragonKingARuiShiClgAgent.lua

module("logic.extensions.dragonkingaruishiclg.agent.DragonKingARuiShiClgAgent", package.seeall)

local DragonKingARuiShiClgAgent = class("DragonKingARuiShiClgAgent", BaseAgent)

function DragonKingARuiShiClgAgent:sendPM_DragonKingARuiShiClgInfoReq(activityId)
	local req = DragonKingARuiShiClgExtension_pb.PM_DragonKingARuiShiClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonKingARuiShiClgAgent:handlePM_DragonKingARuiShiClgInfoRes(status, msg)
	if status == 0 then
		DragonKingARuiShiClgController.instance:handlePM_DragonKingARuiShiClgInfoRes(msg)
	end
end

function DragonKingARuiShiClgAgent:sendPM_DragonKingARuiShiClgChallengeReq(activityId, stageId, form)
	local req = DragonKingARuiShiClgExtension_pb.PM_DragonKingARuiShiClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DragonKingARuiShiClgAgent:handlePM_DragonKingARuiShiClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DragonKingARuiShiClgAgent:handlePM_NotifyDragonKingARuiShiClgChallengeEndRes(status, msg)
	if status == 0 then
		DragonKingARuiShiClgController.instance:handlePM_NotifyDragonKingARuiShiClgChallengeEndRes(msg)
	end
end

DragonKingARuiShiClgAgent.instance = DragonKingARuiShiClgAgent.New()

return DragonKingARuiShiClgAgent
