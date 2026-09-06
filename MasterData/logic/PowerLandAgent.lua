-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/agent/PowerLandAgent.lua

module("logic.extensions.powerland.agent.PowerLandAgent", package.seeall)

local PowerLandAgent = class("PowerLandAgent", BaseAgent)

function PowerLandAgent:sendPM_PowerLandGetInfoReq(activityId)
	local req = PowerLandExtension_pb.PM_PowerLandGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PowerLandAgent:handlePM_PowerLandGetInfoRes(status, msg)
	if status == 0 then
		PowerLandController.instance:onHandlePowerLandGetInfoRes(msg)
	end
end

function PowerLandAgent:sendPM_PowerLandRefreshReq(activityId)
	local req = PowerLandExtension_pb.PM_PowerLandRefreshReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PowerLandAgent:handlePM_PowerLandRefreshRes(status, msg)
	if status == 0 then
		PowerLandController.instance:onHandlePowerLandRefreshRes(msg)
	end
end

function PowerLandAgent:sendPM_PowerLandStartChallengeReq(activityId)
	local req = PowerLandExtension_pb.PM_PowerLandStartChallengeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PowerLandAgent:handlePM_PowerLandStartChallengeRes(status, msg)
	if status == 0 then
		PowerLandController.instance:onHandlePowerLandStartChallengeRes(msg)
	end
end

function PowerLandAgent:sendPM_PowerLandChallengeReq(activityId, selectPetId, simpleForm)
	local req = PowerLandExtension_pb.PM_PowerLandChallengeReq()

	req.activityId = activityId

	if selectPetId ~= nil then
		req.selectPetId = selectPetId
	end

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function PowerLandAgent:handlePM_PowerLandChallengeRes(status, msg)
	PowerLandController.instance:onHandlePowerLandChallengeRes(status, msg)
end

function PowerLandAgent:sendPM_PowerLandRefreshShopReq(activityId)
	local req = PowerLandExtension_pb.PM_PowerLandRefreshShopReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PowerLandAgent:handlePM_PowerLandRefreshShopRes(status, msg)
	if status == 0 then
		PowerLandController.instance:onHandlePowerLandRefreshShopRes(msg)
	end
end

function PowerLandAgent:handlePM_PowerLandStageOverRes(status, msg)
	if status == 0 then
		PowerLandController.instance:onHandlePowerLandStageOverRes(msg)
	end
end

function PowerLandAgent:sendPM_PowerLandSetFormReq(activityId, simpleForm)
	local req = PowerLandExtension_pb.PM_PowerLandSetFormReq()

	req.activityId = activityId

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function PowerLandAgent:handlePM_PowerLandSetFormRes(status, msg)
	if status == 0 then
		PowerLandController.instance:onHandlePowerLandSetFormRes(msg)
	end
end

PowerLandAgent.instance = PowerLandAgent.New()

return PowerLandAgent
