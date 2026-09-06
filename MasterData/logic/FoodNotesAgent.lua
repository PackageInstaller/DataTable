-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessdelicacy/agent/FoodNotesAgent.lua

module("logic.extensions.goddessdelicacy.agent.FoodNotesAgent", package.seeall)

local FoodNotesAgent = class("FoodNotesAgent", BaseAgent)

function FoodNotesAgent:sendPM_FoodNotesGetInfoReq(activityId)
	local req = FoodNotesExtension_pb.PM_FoodNotesGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FoodNotesAgent:handlePM_FoodNotesGetInfoRes(status, msg)
	if status == 0 then
		GoddessDelicacyController.instance:scPushFoodNotesGetInfo(msg)
	end
end

function FoodNotesAgent:sendPM_FoodNotesCookReq(req)
	self:sendMsg(req)
end

function FoodNotesAgent:handlePM_FoodNotesCookRes(status, msg)
	if status == 0 then
		GoddessDelicacyController.instance:scPushFoodNotesCook(msg)
	end
end

function FoodNotesAgent:sendPM_FoodNotesGainPrizeReq(activityId, prizeId)
	local req = FoodNotesExtension_pb.PM_FoodNotesGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function FoodNotesAgent:handlePM_FoodNotesGainPrizeRes(status, msg)
	if status == 0 then
		GoddessDelicacyController.instance:scPushFoodNotesGainPrize(msg)
	end
end

FoodNotesAgent.instance = FoodNotesAgent.New()

return FoodNotesAgent
