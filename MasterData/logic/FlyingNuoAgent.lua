-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/agent/FlyingNuoAgent.lua

module("logic.extensions.flyingnuo.agent.FlyingNuoAgent", package.seeall)

local FlyingNuoAgent = class("FlyingNuoAgent", BaseAgent)

FlyingNuoAgent.GetInfoRes = "FlyingNuoAgent.GetInfoRes"
FlyingNuoAgent.BuyRes = "FlyingNuoAgent.BuyRes"
FlyingNuoAgent.ReliveRes = "FlyingNuoAgent.ReliveRes"
FlyingNuoAgent.GetRankInfoRes = "FlyingNuoAgent.GetRankInfoRes"

function FlyingNuoAgent:sendPM_GetInfoReq(activityId)
	local req = FlyingNuoExtension_pb.PM_GetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FlyingNuoAgent:handlePM_GetInfoRes(status, msg)
	if status == 0 then
		local info = msg.info

		FlyNuoModel.instance:setActivityInfo(info)
		GlobalDispatcher:dispatch(FlyingNuoAgent.GetInfoRes, info)
	end
end

function FlyingNuoAgent:sendPM_BuyReq(activityId, type)
	local req = FlyingNuoExtension_pb.PM_BuyReq()

	req.activityId = activityId
	req.type = type

	self:sendMsg(req)
end

function FlyingNuoAgent:handlePM_BuyRes(status, msg)
	if status == 0 then
		local activityid = msg.activityId
		local type = msg.type
		local times = msg.times

		FlyNuoModel.instance:setBuySuccessed(activityid, type, times)
	end

	GlobalDispatcher:dispatch(FlyingNuoAgent.BuyRes, status)
end

function FlyingNuoAgent:sendPM_StartGameReq(activityId, isUseGameStartItem, clientKey)
	local req = FlyingNuoExtension_pb.PM_StartGameReq()

	req.activityId = activityId
	req.isUseGameStartItem = isUseGameStartItem
	req.clientKey = clientKey

	self:sendMsg(req)
end

function FlyingNuoAgent:handlePM_StartGameRes(status, msg)
	if status == 0 then
		local activityid = msg.activityId
		local clientkey = msg.clientKey
		local encryptedkey = msg.encryptedKey

		FlyNuoController.instance:startGame(activityid, clientkey, encryptedkey)
	end
end

function FlyingNuoAgent:sendPM_ReliveReq()
	local req = FlyingNuoExtension_pb.PM_ReliveReq()

	self:sendMsg(req)
end

function FlyingNuoAgent:handlePM_ReliveRes(status, msg)
	if status == 0 then
		local relivetimes = msg.reliveTimes

		FlyNuoModel.instance:relive(relivetimes)
		GlobalDispatcher:dispatch(FlyingNuoAgent.ReliveRes)
	end
end

function FlyingNuoAgent:sendPM_EndGameReq(itemScore, distanceScore, clientEncryptedKey)
	local req = FlyingNuoExtension_pb.PM_EndGameReq()

	req.itemScore = itemScore
	req.distanceScore = distanceScore
	req.clientEncryptedKey = clientEncryptedKey

	self:sendMsg(req)
end

function FlyingNuoAgent:handlePM_EndGameRes(status, msg)
	if status == 0 then
		local info = msg.info

		FlyNuoController.instance:endGameShowReward(info)
		FlyNuoGameController.instance:realEngGame()
	end
end

function FlyingNuoAgent:sendPM_GetRankInfoReq(startRank, endRank)
	local req = FlyingNuoExtension_pb.PM_GetRankInfoReq()

	req.startRank = startRank
	req.endRank = endRank

	self:sendMsg(req)
end

function FlyingNuoAgent:handlePM_GetRankInfoRes(status, msg)
	if status == 0 then
		local ranklist = msg.rankList
		local ranksize = msg.rankSize
		local myrank = msg.myRank

		FlyNuoModel.instance:setRankInfo(ranklist, ranksize, myrank)
		GlobalDispatcher:dispatch(FlyingNuoAgent.GetRankInfoRes)
	end
end

function FlyingNuoAgent:showChangeSet(changeSetId, name)
	if name == "handlePM_EndGameRes" then
		return
	else
		FlyingNuoAgent.super.showChangeSet(self, changeSetId, name)
	end
end

FlyingNuoAgent.instance = FlyingNuoAgent.New()

return FlyingNuoAgent
