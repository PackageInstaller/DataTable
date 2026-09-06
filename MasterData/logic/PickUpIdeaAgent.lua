-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/agent/PickUpIdeaAgent.lua

module("logic.extensions.pickupidea.agent.PickUpIdeaAgent", package.seeall)

local PickUpIdeaAgent = class("PickUpIdeaAgent", BaseAgent)

function PickUpIdeaAgent:sendPM_PickUpIdeaGetInfoReq(activityId)
	local req = PickUpIdeaExtension_pb.PM_PickUpIdeaGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PickUpIdeaAgent:handlePM_PickUpIdeaGetInfoRes(status, msg)
	if status == 0 then
		PickupideaModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PickUpIdeaGetInfoRes)
	end
end

function PickUpIdeaAgent:sendPM_PickUpIdeaStartGameReq(activityId, clientKey)
	local req = PickUpIdeaExtension_pb.PM_PickUpIdeaStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function PickUpIdeaAgent:handlePM_PickUpIdeaStartGameRes(status, msg)
	if status == 0 then
		PickupideaController.instance:handlePM_PickUpIdeaStartGameRes(msg.serverKey)
		GlobalDispatcher:dispatch(GlobalNotify.PickUpIdeaStartGameRes)
	end
end

function PickUpIdeaAgent:sendPM_PickUpIdeaEndGameReq(score, encryptedKey)
	local req = PickUpIdeaExtension_pb.PM_PickUpIdeaEndGameReq()

	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function PickUpIdeaAgent:handlePM_PickUpIdeaEndGameRes(status, msg)
	if status == 0 then
		local pass = msg.pass

		if pass then
			FloatWordMgr.instance:show("已通关")
		else
			FloatWordMgr.instance:show("未达到通关分数")
		end

		GlobalDispatcher:dispatch(GlobalNotify.PickUpIdeaEndGameRes)
	end
end

function PickUpIdeaAgent:sendPM_PickUpIdeaGainProgressPrizeReq(activityId, prizeId)
	local req = PickUpIdeaExtension_pb.PM_PickUpIdeaGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function PickUpIdeaAgent:handlePM_PickUpIdeaGainProgressPrizeRes(status, msg)
	if status == 0 then
		PickupideaModel.instance:gainPrizeId(msg.prizeId)
		GlobalDispatcher:dispatch(GlobalNotify.PickUpIdeaGainProgressPrizeRes)
	end
end

function PickUpIdeaAgent:sendPM_PickUpIdeaGetRankInfoReq(activityId)
	local req = PickUpIdeaExtension_pb.PM_PickUpIdeaGetRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PickUpIdeaAgent:handlePM_PickUpIdeaGetRankInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PickUpIdeaGetRankInfoRes, msg)
	end
end

function PickUpIdeaAgent:sendPM_PickUpIdeaReliveReq()
	local req = PickUpIdeaExtension_pb.PM_PickUpIdeaReliveReq()

	self:sendMsg(req)
end

function PickUpIdeaAgent:handlePM_PickUpIdeaReliveRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.PickUpIdeaReliveRes, status)
end

PickUpIdeaAgent.instance = PickUpIdeaAgent.New()

return PickUpIdeaAgent
