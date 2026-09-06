-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailongevolve/agent/NaiLongEvolveAgent.lua

module("logic.extensions.nailongevolve.agent.NaiLongEvolveAgent", package.seeall)

local NaiLongEvolveAgent = class("NaiLongEvolveAgent", BaseAgent)

function NaiLongEvolveAgent:sendPM_MilkDragonClgGetInfoReq(activityId)
	local req = MilkDragonClgExtension_pb.PM_MilkDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NaiLongEvolveAgent:handlePM_MilkDragonClgGetInfoRes(status, msg)
	if status == 0 then
		NaiLongEvolveController.instance:handlePM_MilkDragonClgGetInfoRes(msg)
	end
end

function NaiLongEvolveAgent:sendPM_MilkDragonClgSignInReq(activityId)
	local req = MilkDragonClgExtension_pb.PM_MilkDragonClgSignInReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NaiLongEvolveAgent:handlePM_MilkDragonClgSignInRes(status, msg)
	if status == 0 then
		NaiLongEvolveController.instance:handlePM_MilkDragonClgSignInRes(msg)
	end
end

function NaiLongEvolveAgent:sendPM_MilkDragonClgPosLvlUpReq(activityId, posType)
	local req = MilkDragonClgExtension_pb.PM_MilkDragonClgPosLvlUpReq()

	req.activityId = activityId
	req.posType = posType

	self:sendMsg(req)
end

function NaiLongEvolveAgent:handlePM_MilkDragonClgPosLvlUpRes(status, msg)
	if status == 0 then
		NaiLongEvolveController.instance:handlePM_MilkDragonClgPosLvlUpRes(msg)
	end
end

function NaiLongEvolveAgent:sendPM_MilkDragonClgResetPosLvlReq(activityId)
	local req = MilkDragonClgExtension_pb.PM_MilkDragonClgResetPosLvlReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NaiLongEvolveAgent:handlePM_MilkDragonClgResetPosLvlRes(status, msg)
	if status == 0 then
		NaiLongEvolveController.instance:handlePM_MilkDragonClgResetPosLvlRes(msg)
	end
end

function NaiLongEvolveAgent:sendPM_MilkDragonFightReq(activityId, form)
	local req = MilkDragonClgExtension_pb.PM_MilkDragonFightReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function NaiLongEvolveAgent:handlePM_MilkDragonFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function NaiLongEvolveAgent:handlePM_NotifyMilkDragonFightEndRes(status, msg)
	if status == 0 then
		NaiLongEvolveController.instance:handlePM_NotifyMilkDragonFightEndRes(msg)
	end
end

NaiLongEvolveAgent.instance = NaiLongEvolveAgent.New()

return NaiLongEvolveAgent
