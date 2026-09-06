-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/disorderpower/agent/DisOrderPowerAgent.lua

module("logic.extensions.disorderpower.agent.DisOrderPowerAgent", package.seeall)

local DisOrderPowerAgent = class("DisOrderPowerAgent", BaseAgent)

function DisOrderPowerAgent:sendPM_DisorderPowerGetInfoReq(activityId)
	local req = DisorderPowerExtension_pb.PM_DisorderPowerGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DisOrderPowerAgent:handlePM_DisorderPowerGetInfoRes(status, msg)
	if status == 0 then
		DisOrderPowerController.instance:handlePM_DisorderPowerGetInfoRes(msg)
	end
end

function DisOrderPowerAgent:sendPM_DisorderPowerLotteryReq(activityId)
	local req = DisorderPowerExtension_pb.PM_DisorderPowerLotteryReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DisOrderPowerAgent:handlePM_DisorderPowerLotteryRes(status, msg)
	if status == 0 then
		DisOrderPowerController.instance:handlePM_DisorderPowerLotteryRes(msg)
	end
end

function DisOrderPowerAgent:sendPM_DisorderPowerFightReq(activityId, form)
	local req = DisorderPowerExtension_pb.PM_DisorderPowerFightReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DisOrderPowerAgent:handlePM_DisorderPowerFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DisOrderPowerAgent:handlePM_DisorderPowerNotifyFightRes(status, msg)
	if status == 0 then
		DisOrderPowerController.instance:handlePM_DisorderPowerNotifyFightRes(msg)
	end
end

function DisOrderPowerAgent:sendPM_DisorderPowerGainPrizeReq(activityId, prizeId)
	local req = DisorderPowerExtension_pb.PM_DisorderPowerGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DisOrderPowerAgent:handlePM_DisorderPowerGainPrizeRes(status, msg)
	if status == 0 then
		DisOrderPowerController.instance:handlePM_DisorderPowerGainPrizeRes(msg)
	end
end

DisOrderPowerAgent.instance = DisOrderPowerAgent.New()

return DisOrderPowerAgent
