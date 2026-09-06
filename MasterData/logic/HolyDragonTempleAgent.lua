-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/agent/HolyDragonTempleAgent.lua

module("logic.extensions.holydragontemple.agent.HolyDragonTempleAgent", package.seeall)

local HolyDragonTempleAgent = class("HolyDragonTempleAgent", BaseAgent)

function HolyDragonTempleAgent:sendPM_HolyDragonTempleInfoReq(activityId)
	local req = HolyDragonTempleExtension_pb.PM_HolyDragonTempleInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HolyDragonTempleAgent:handlePM_HolyDragonTempleInfoRes(status, msg)
	if status == 0 then
		HolyDragonTempleController.instance:handlePM_HolyDragonTempleInfoRes(msg)
	end
end

function HolyDragonTempleAgent:sendPM_HolyDragonTempleChallengeReq(activityId, form, floorId, stageId)
	local req = HolyDragonTempleExtension_pb.PM_HolyDragonTempleChallengeReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.floorId = floorId
	req.stageId = stageId

	self:sendMsg(req)
end

function HolyDragonTempleAgent:handlePM_HolyDragonTempleChallengeRes(status, msg)
	if status == 0 then
		HolyDragonTempleController.instance:handlePM_HolyDragonTempleChallengeRes(msg)
	end
end

function HolyDragonTempleAgent:handlePM_HolyDragonTempleNotifyChallengeRes(status, msg)
	if status == 0 then
		HolyDragonTempleController.instance:handlePM_HolyDragonTempleNotifyChallengeRes(msg)
	end
end

function HolyDragonTempleAgent:sendPM_HolyDragonTempleSignInReq(activityId, floorId)
	local req = HolyDragonTempleExtension_pb.PM_HolyDragonTempleSignInReq()

	req.activityId = activityId
	req.floorId = floorId

	self:sendMsg(req)
end

function HolyDragonTempleAgent:handlePM_HolyDragonTempleSignInRes(status, msg)
	if status == 0 then
		HolyDragonTempleController.instance:handlePM_HolyDragonTempleSignInRes(msg)
	end
end

HolyDragonTempleAgent.instance = HolyDragonTempleAgent.New()

return HolyDragonTempleAgent
