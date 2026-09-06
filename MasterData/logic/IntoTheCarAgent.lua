-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/run2023/agent/IntoTheCarAgent.lua

module("logic.extensions.run2023.agent.IntoTheCarAgent", package.seeall)

local IntoTheCarAgent = class("IntoTheCarAgent", BaseAgent)

function IntoTheCarAgent:sendPM_IntoTheCarWishTreeInfoReq(activityId)
	local req = IntoTheCarExtension_pb.PM_IntoTheCarWishTreeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function IntoTheCarAgent:handlePM_IntoTheCarWishTreeInfoRes(status, msg)
	if status == 0 then
		WishTreeController.instance:handleWishTreeInfoRes(status, msg)
	end
end

function IntoTheCarAgent:sendPM_IntoTheCarSelectWishPrizeReq(activityId, indexId, prizeId)
	local req = IntoTheCarExtension_pb.PM_IntoTheCarSelectWishPrizeReq()

	req.activityId = activityId
	req.indexId = indexId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function IntoTheCarAgent:handlePM_IntoTheCarSelectWishPrizeRes(status, msg)
	if status == 0 then
		WishTreeController.instance:handleSelectWishPrizeRes(status, msg)
	end
end

function IntoTheCarAgent:sendPM_IntoTheCarWishTreeGainPrizeReq(activityId, indexId)
	local req = IntoTheCarExtension_pb.PM_IntoTheCarWishTreeGainPrizeReq()

	req.activityId = activityId
	req.indexId = indexId

	self:sendMsg(req)
end

function IntoTheCarAgent:handlePM_IntoTheCarWishTreeGainPrizeRes(status, msg)
	if status == 0 then
		WishTreeController.instance:handleWishTreeGainPrizeRes(status, msg)
	end
end

function IntoTheCarAgent:sendPM_IntoTheCarGameInfoReq(activityId)
	local req = IntoTheCarExtension_pb.PM_IntoTheCarGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function IntoTheCarAgent:handlePM_IntoTheCarGameInfoRes(status, msg)
	if status == 0 then
		Run2023Controller.instance:handleGameInfoRes(status, msg)
	end
end

function IntoTheCarAgent:sendPM_IntoTheCarStartGameReq(activityId, clientKey)
	local req = IntoTheCarExtension_pb.PM_IntoTheCarStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function IntoTheCarAgent:handlePM_IntoTheCarStartGameRes(status, msg)
	if status == 0 then
		Run2023Controller.instance:handleStartGameRes(status, msg)
	end
end

function IntoTheCarAgent:sendPM_IntoTheCarEndGameReq(activityId, useTime, encryptedKey)
	local req = IntoTheCarExtension_pb.PM_IntoTheCarEndGameReq()

	req.activityId = activityId
	req.useTime = useTime
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function IntoTheCarAgent:handlePM_IntoTheCarEndGameRes(status, msg)
	if status == 0 then
		Run2023Controller.instance:handleEndGameRes(status, msg)
	end
end

function IntoTheCarAgent:sendPM_IntoTheCarUnLockLabelReq(activityId)
	local req = IntoTheCarExtension_pb.PM_IntoTheCarUnLockLabelReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function IntoTheCarAgent:handlePM_IntoTheCarUnLockLabelRes(status, msg)
	Run2023Controller.instance:handlePM_IntoTheCarUnLockLabelRes(status, msg)
end

function IntoTheCarAgent:sendPM_IntoTheCarGetUnLockLabelsReq(activityId)
	local req = IntoTheCarExtension_pb.PM_IntoTheCarGetUnLockLabelsReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function IntoTheCarAgent:handlePM_IntoTheCarGetUnLockLabelsRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function IntoTheCarAgent:sendPM_IntoTheCarSweepGameReq(activityId, sweepTimes)
	local req = IntoTheCarExtension_pb.PM_IntoTheCarSweepGameReq()

	req.activityId = activityId
	req.sweepTimes = sweepTimes

	self:sendMsg(req)
end

function IntoTheCarAgent:handlePM_IntoTheCarSweepGameRes(status, msg)
	if status == 0 then
		Run2023Controller.instance:handlePM_IntoTheCarSweepGameRes(msg)
	end
end

IntoTheCarAgent.instance = IntoTheCarAgent.New()

return IntoTheCarAgent
