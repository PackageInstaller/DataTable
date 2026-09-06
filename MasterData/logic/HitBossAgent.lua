-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hitboss/agent/HitBossAgent.lua

module("logic.extensions.hitboss.agent.HitBossAgent", package.seeall)

local HitBossAgent = class("HitBossAgent", BaseAgent)

HitBossAgent.HitBossGetInfoRes = "HitBossAgent.HitBossGetInfoRes"
HitBossAgent.HitBossFightRes = "HitBossAgent.HitBossFightRes"
HitBossAgent.HitBossGainPrizeRes = "HitBossAgent.HitBossGainPrizeRes"
HitBossAgent.HitBossGetRankInfoRes = "HitBossAgent.HitBossGetRankInfoRes"
HitBossAgent.Notify_HitbossFightRes = "HitBossAgent.Notify_HitbossFightRes"

function HitBossAgent:sendPM_HitBossGetInfoReq(activityId)
	local req = HitBossExtension_pb.PM_HitBossGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HitBossAgent:handlePM_HitBossGetInfoRes(status, msg)
	if status == 0 then
		HitbossModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(HitBossAgent.HitBossGetInfoRes)
	end
end

function HitBossAgent:sendPM_HitBossFightReq(activityId, form)
	local req = HitBossExtension_pb.PM_HitBossFightReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function HitBossAgent:handlePM_HitBossFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HitBossAgent.HitBossFightRes)
	end
end

function HitBossAgent:sendPM_HitBossGainPrizeReq(activityId, prizeId)
	local req = HitBossExtension_pb.PM_HitBossGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function HitBossAgent:handlePM_HitBossGainPrizeRes(status, msg)
	if status == 0 then
		HitbossController.instance:handlePM_HitBossGainPrizeRes()
		GlobalDispatcher:dispatch(HitBossAgent.HitBossGainPrizeRes)
	end
end

function HitBossAgent:sendPM_HitBossGetRankInfoReq(activityId)
	local req = HitBossExtension_pb.PM_HitBossGetRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HitBossAgent:handlePM_HitBossGetRankInfoRes(status, msg)
	if status == 0 then
		HitbossModel.instance:setRankInfo(msg)
		GlobalDispatcher:dispatch(HitBossAgent.HitBossGetRankInfoRes)
	end
end

function HitBossAgent:handlePM_Notify_HitbossFightRes(status, msg)
	if status == 0 then
		HitbossController.instance:handlePM_Notify_HitbossFightRes(msg)
		GlobalDispatcher:dispatch(HitBossAgent.Notify_HitbossFightRes)
	end
end

HitBossAgent.instance = HitBossAgent.New()

return HitBossAgent
