-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldentowerlottery/agent/GoldenTowerLotteryAgent.lua

module("logic.extensions.goldentowerlottery.agent.GoldenTowerLotteryAgent", package.seeall)

local GoldenTowerLotteryAgent = class("GoldenTowerLotteryAgent", BaseAgent)

function GoldenTowerLotteryAgent:sendPM_GoldenTowerLotteryGetInfoReq(activityId)
	local req = GoldenTowerLotteryExtension_pb.PM_GoldenTowerLotteryGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoldenTowerLotteryAgent:handlePM_GoldenTowerLotteryGetInfoRes(status, msg)
	if status == 0 then
		GoldenTowerLotteryController.instance:handlePM_GoldenTowerLotteryGetInfoRes(msg)
	end
end

function GoldenTowerLotteryAgent:sendPM_GoldenTowerLotteryLotteryReq(activityId, poolId)
	local req = GoldenTowerLotteryExtension_pb.PM_GoldenTowerLotteryLotteryReq()

	req.activityId = activityId
	req.poolId = poolId

	self:sendMsg(req)
end

function GoldenTowerLotteryAgent:handlePM_GoldenTowerLotteryLotteryRes(status, msg)
	if status == 0 then
		GoldenTowerLotteryController.instance:handlePM_GoldenTowerLotteryLotteryRes(msg)
	end
end

GoldenTowerLotteryAgent.instance = GoldenTowerLotteryAgent.New()

return GoldenTowerLotteryAgent
