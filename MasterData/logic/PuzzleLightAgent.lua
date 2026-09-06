-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualactivity/agent/PuzzleLightAgent.lua

module("logic.extensions.annualactivity.agent.PuzzleLightAgent", package.seeall)

local PuzzleLightAgent = class("PuzzleLightAgent", BaseAgent)

function PuzzleLightAgent:sendPM_GetPuzzleInfoReq(activityId)
	local req = PuzzleLightExtension_pb.PM_GetPuzzleInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PuzzleLightAgent:handlePM_GetPuzzleInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.Grateful_UpdataGratefulPuzzleInfo, msg)
	end
end

function PuzzleLightAgent:sendPM_ActivatePuzzleReq(activityId, puzzleId)
	local req = PuzzleLightExtension_pb.PM_ActivatePuzzleReq()

	req.activityId = activityId
	req.puzzleId = puzzleId

	self:sendMsg(req)
end

function PuzzleLightAgent:handlePM_ActivatePuzzleRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.Grateful_UpdataGratefulPuzzleLight, checknumber(msg.puzzleId))
	end
end

function PuzzleLightAgent:sendPM_GainGroupPrizeReq(activityId, groupPrizeId)
	local req = PuzzleLightExtension_pb.PM_GainGroupPrizeReq()

	req.activityId = activityId
	req.groupPrizeId = groupPrizeId

	self:sendMsg(req)
end

function PuzzleLightAgent:handlePM_GainGroupPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.Grateful_UpdataGratefulPuzzlePrize, checknumber(msg.groupPrizeId))
	end
end

function PuzzleLightAgent:sendPM_GainBigPrizeReq(activityId)
	local req = PuzzleLightExtension_pb.PM_GainBigPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PuzzleLightAgent:handlePM_GainBigPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.Grateful_UpdataGratefulPuzzlePrize)
	end
end

PuzzleLightAgent.instance = PuzzleLightAgent.New()

return PuzzleLightAgent
