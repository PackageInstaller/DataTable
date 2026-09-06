-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/WaterLightHeroTowerAgent.lua

module("logic.extensions.waterlightherotower.agent.WaterLightHeroTowerAgent", package.seeall)

local WaterLightHeroTowerAgent = class("WaterLightHeroTowerAgent", BaseAgent)

function WaterLightHeroTowerAgent:sendPM_WaterLightHeroTowerInfoReq(challengeId)
	local req = WaterLightHeroTowerExtension_pb.PM_WaterLightHeroTowerInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function WaterLightHeroTowerAgent:handlePM_WaterLightHeroTowerInfoRes(status, msg)
	if status == 0 then
		AthenaController.instance:handlePM_WaterLightHeroTowerInfoRes(msg)
	end
end

function WaterLightHeroTowerAgent:sendPM_WaterLightHeroTowerPowerChallengeReq(challengeId)
	local req = WaterLightHeroTowerExtension_pb.PM_WaterLightHeroTowerPowerChallengeReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function WaterLightHeroTowerAgent:handlePM_WaterLightHeroTowerPowerChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function WaterLightHeroTowerAgent:sendPM_WaterLightHeroTowerWisdomChallengeReq(challengeId, form)
	local req = WaterLightHeroTowerExtension_pb.PM_WaterLightHeroTowerWisdomChallengeReq()

	req.challengeId = challengeId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function WaterLightHeroTowerAgent:handlePM_WaterLightHeroTowerWisdomChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function WaterLightHeroTowerAgent:sendPM_WaterLightHeroTowerBuyTimesReq(challengeId)
	local req = WaterLightHeroTowerExtension_pb.PM_WaterLightHeroTowerBuyTimesReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function WaterLightHeroTowerAgent:handlePM_WaterLightHeroTowerBuyTimesRes(status, msg)
	if status == 0 then
		AthenaController.instance:handlePM_WaterLightHeroTowerBuyTimesRes(msg)
	end
end

function WaterLightHeroTowerAgent:sendPM_WaterLightHeroTowerGainPrizeReq(challengeId, prizeId)
	local req = WaterLightHeroTowerExtension_pb.PM_WaterLightHeroTowerGainPrizeReq()

	req.challengeId = challengeId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function WaterLightHeroTowerAgent:handlePM_WaterLightHeroTowerGainPrizeRes(status, msg)
	if status == 0 then
		AthenaController.instance:handlePM_WaterLightHeroTowerGainPrizeRes(msg)
	end
end

function WaterLightHeroTowerAgent:sendPM_WaterLightHeroTowerOnKeyPassWisdomReq(challengeId)
	local req = WaterLightHeroTowerExtension_pb.PM_WaterLightHeroTowerOnKeyPassWisdomReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function WaterLightHeroTowerAgent:handlePM_WaterLightHeroTowerOnKeyPassWisdomRes(status, msg)
	if status == 0 then
		AthenaController.instance:handlePM_WaterLightHeroTowerOnKeyPassWisdomRes(msg)
	end
end

function WaterLightHeroTowerAgent:handlePM_NotifyPowerTowerFightEndRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function WaterLightHeroTowerAgent:handlePM_NotifyWisdomTowerFightEndRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function WaterLightHeroTowerAgent:sendPM_WaterLightHeroTowerGainBuffReq(challengeId)
	local req = WaterLightHeroTowerExtension_pb.PM_WaterLightHeroTowerGainBuffReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function WaterLightHeroTowerAgent:handlePM_WaterLightHeroTowerGainBuffRes(status, msg)
	if status == 0 then
		AthenaController.instance:handlePM_WaterLightHeroTowerGainBuffRes(msg)
	end
end

function WaterLightHeroTowerAgent:sendPM_WaterLightHeroTowerOnKeyPassWisdomStageReq(challengeId)
	local req = WaterLightHeroTowerExtension_pb.PM_WaterLightHeroTowerOnKeyPassWisdomStageReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function WaterLightHeroTowerAgent:handlePM_WaterLightHeroTowerOnKeyPassWisdomStageRes(status, msg)
	if status == 0 then
		AthenaController.instance:handlePM_WaterLightHeroTowerOnKeyPassWisdomStageRes(msg)
	end
end

WaterLightHeroTowerAgent.instance = WaterLightHeroTowerAgent.New()

return WaterLightHeroTowerAgent
