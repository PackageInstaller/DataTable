-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonsoulvote/agent/DSoulPredictAgent.lua

module("logic.extensions.dsoulpredict.agent.DSoulPredictAgent", package.seeall)

local DSoulPredictAgent = class("DSoulPredictAgent", BaseAgent)

function DSoulPredictAgent:sendPM_DSoulPredictGetInfoReq(activityId)
	local req = DSoulPredictExtension_pb.PM_DSoulPredictGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DSoulPredictAgent:handlePM_DSoulPredictGetInfoRes(status, msg)
	if status == 0 then
		DragonSoulVoteController.instance:onGetInfo(msg)
	end
end

function DSoulPredictAgent:sendPM_DSoulPredictPredictReq(activityId, predict_pb, msgId)
	local req = DSoulPredictExtension_pb.PM_DSoulPredictPredictReq()

	req.activityId = activityId

	if predict_pb ~= nil then
		req.predict:ParseFromString(predict_pb:SerializeToString())
	end

	req.msgId = msgId

	self:sendMsg(req)
end

function DSoulPredictAgent:handlePM_DSoulPredictPredictRes(status, msg)
	if status == 0 then
		DragonSoulVoteController.instance:onMakeRole(msg)
	end
end

function DSoulPredictAgent:sendPM_DSoulPredictVoteReq(activityId, item_pb, voteCount)
	local req = DSoulPredictExtension_pb.PM_DSoulPredictVoteReq()

	req.activityId = activityId

	if item_pb ~= nil then
		req.item:ParseFromString(item_pb:SerializeToString())
	end

	req.voteCount = voteCount

	self:sendMsg(req)
end

function DSoulPredictAgent:handlePM_DSoulPredictVoteRes(status, msg)
	if status == 0 then
		DragonSoulVoteController.instance:onVote(msg)
	end
end

function DSoulPredictAgent:sendPM_DSoulPredictGainPrizeReq(activityId, prizeId)
	local req = DSoulPredictExtension_pb.PM_DSoulPredictGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DSoulPredictAgent:handlePM_DSoulPredictGainPrizeRes(status, msg)
	if status == 0 then
		DragonSoulVoteController.instance:onGetPrize(msg)
	end
end

DSoulPredictAgent.instance = DSoulPredictAgent.New()

return DSoulPredictAgent
