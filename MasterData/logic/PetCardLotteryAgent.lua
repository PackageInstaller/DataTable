-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcardlottery/agent/PetCardLotteryAgent.lua

module("logic.extensions.petcardlottery.agent.PetCardLotteryAgent", package.seeall)

local PetCardLotteryAgent = class("PetCardLotteryAgent", BaseAgent)

function PetCardLotteryAgent:sendPM_PetCardLotteryGetInfoReq(activityId)
	local req = PetCardLotteryExtension_pb.PM_PetCardLotteryGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PetCardLotteryAgent:handlePM_PetCardLotteryGetInfoRes(status, msg)
	if status == 0 then
		PetCardLotteryController.instance:handlePM_PetCardLotteryGetInfoRes(status, msg)
	end
end

function PetCardLotteryAgent:sendPM_PetCardLotterySelectCardReq(activityId, selectedPetIds)
	local req = PetCardLotteryExtension_pb.PM_PetCardLotterySelectCardReq()

	req.activityId = activityId

	for i, v in ipairs(selectedPetIds) do
		req.selectedPetIds:append(v)
	end

	self:sendMsg(req)
end

function PetCardLotteryAgent:handlePM_PetCardLotterySelectCardRes(status, msg)
	if status == 0 then
		PetCardLotteryController.instance:handlePM_PetCardLotterySelectCardRes(status, msg)
	end
end

function PetCardLotteryAgent:sendPM_PetCardLotteryGainPrizeReq(activityId, dateInt)
	local req = PetCardLotteryExtension_pb.PM_PetCardLotteryGainPrizeReq()

	req.activityId = activityId
	req.dateInt = dateInt

	self:sendMsg(req)
end

function PetCardLotteryAgent:handlePM_PetCardLotteryGainPrizeRes(status, msg)
	if status == 0 then
		PetCardLotteryController.instance:handlePM_PetCardLotteryGainPrizeRes(status, msg)
	end
end

PetCardLotteryAgent.instance = PetCardLotteryAgent.New()

return PetCardLotteryAgent
