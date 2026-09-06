-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/agent/XiaoNuoBirthdayGiftAgent.lua

module("logic.extensions.luoshiqiordeal.agent.XiaoNuoBirthdayGiftAgent", package.seeall)

local XiaoNuoBirthdayGiftAgent = class("XiaoNuoBirthdayGiftAgent", BaseAgent)

function XiaoNuoBirthdayGiftAgent:sendPM_XiaoNuoBirthdayGetInfoReq(activityId)
	local req = XiaoNuoBirthdayGiftExtension_pb.PM_XiaoNuoBirthdayGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiaoNuoBirthdayGiftAgent:handlePM_XiaoNuoBirthdayGetInfoRes(status, msg)
	if status == 0 then
		LuoShiQiOrdealModel.instance:onXiaoNuoBirthdayGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoBirthdayGetInfoRes)
	end
end

function XiaoNuoBirthdayGiftAgent:sendPM_XiaoNuoBirthdayStartNormalGameReq(activityId, clientKey, diffLv)
	local req = XiaoNuoBirthdayGiftExtension_pb.PM_XiaoNuoBirthdayStartNormalGameReq()

	req.activityId = activityId
	req.clientKey = clientKey
	req.diffLv = diffLv

	self:sendMsg(req)
end

function XiaoNuoBirthdayGiftAgent:handlePM_XiaoNuoBirthdayStartNormalGameRes(status, msg)
	if status == 0 then
		LuoShiQiOrdealModel.instance:onXiaoNuoBirthdayStartNormalGameRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoBirthdayStartNormalGameRes, msg.serverKey)
	end
end

function XiaoNuoBirthdayGiftAgent:sendPM_XiaoNuoBirthdayEndNormalGameReq(score, encryptedKey)
	local req = XiaoNuoBirthdayGiftExtension_pb.PM_XiaoNuoBirthdayEndNormalGameReq()

	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function XiaoNuoBirthdayGiftAgent:handlePM_XiaoNuoBirthdayEndNormalGameRes(status, msg)
	if status == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		LuoShiQiOrdealModel.instance:onXiaoNuoBirthdayEndNormalGameRes(msg)

		local isSuccess = true

		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoBirthdayEndNormalGameRes, isSuccess)
	else
		local isSuccess = false

		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoBirthdayEndNormalGameRes, isSuccess)
	end
end

function XiaoNuoBirthdayGiftAgent:sendPM_XiaoNuoBirthdayStartCrazyGameReq(activityId, clientKey)
	local req = XiaoNuoBirthdayGiftExtension_pb.PM_XiaoNuoBirthdayStartCrazyGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function XiaoNuoBirthdayGiftAgent:handlePM_XiaoNuoBirthdayStartCrazyGameRes(status, msg)
	if status == 0 then
		LuoShiQiOrdealModel.instance:onXiaoNuoBirthdayStartCrazyGameRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoBirthdayStartCrazyGameRes, msg.serverKey)
	end
end

function XiaoNuoBirthdayGiftAgent:sendPM_XiaoNuoBirthdayEndCrazyGameReq(stageNum, encryptedKey)
	local req = XiaoNuoBirthdayGiftExtension_pb.PM_XiaoNuoBirthdayEndCrazyGameReq()

	req.stageNum = stageNum
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function XiaoNuoBirthdayGiftAgent:handlePM_XiaoNuoBirthdayEndCrazyGameRes(status, msg)
	if status == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		LuoShiQiOrdealModel.instance:onXiaoNuoBirthdayEndCrazyGameRes(msg)

		local isSuccess = true

		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoBirthdayEndCrazyGameRes, isSuccess)
	else
		local isSuccess = false

		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoBirthdayEndCrazyGameRes, isSuccess)
	end
end

function XiaoNuoBirthdayGiftAgent:sendPM_XiaoNuoBirthdayBuyPlayNumReq(activityId)
	local req = XiaoNuoBirthdayGiftExtension_pb.PM_XiaoNuoBirthdayBuyPlayNumReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiaoNuoBirthdayGiftAgent:handlePM_XiaoNuoBirthdayBuyPlayNumRes(status, msg)
	if status == 0 then
		LuoShiQiOrdealModel.instance:onXiaoNuoBirthdayBuyPlayNumRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoBirthdayBuyPlayNumRes)
	end
end

function XiaoNuoBirthdayGiftAgent:sendPM_XiaoNuoBirthdayGameProgressPrizeReq(activityId, prizeId)
	local req = XiaoNuoBirthdayGiftExtension_pb.PM_XiaoNuoBirthdayGameProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function XiaoNuoBirthdayGiftAgent:handlePM_XiaoNuoBirthdayGameProgressPrizeRes(status, msg)
	if status == 0 then
		LuoShiQiOrdealModel.instance:onXiaoNuoBirthdayGameProgressPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoBirthdayGameProgressPrizeRes)
	end
end

function XiaoNuoBirthdayGiftAgent:sendPM_XiaoNuoBirthdayOpenGiftReq(activityId)
	local req = XiaoNuoBirthdayGiftExtension_pb.PM_XiaoNuoBirthdayOpenGiftReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiaoNuoBirthdayGiftAgent:handlePM_XiaoNuoBirthdayOpenGiftRes(status, msg)
	if status == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		LuoShiQiOrdealModel.instance:onXiaoNuoBirthdayOpenGiftRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoBirthdayOpenGiftRes)
	end
end

function XiaoNuoBirthdayGiftAgent:sendPM_XiaoNuoBirthdayGetRankReq(activityId, crazy)
	local req = XiaoNuoBirthdayGiftExtension_pb.PM_XiaoNuoBirthdayGetRankReq()

	req.activityId = activityId
	req.crazy = crazy

	self:sendMsg(req)
end

function XiaoNuoBirthdayGiftAgent:handlePM_XiaoNuoBirthdayGetRankRes(status, msg)
	if status == 0 then
		LuoShiQiOrdealModel.instance:onXiaoNuoBirthdayGetRankRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoBirthdayGetRankRes, msg.crazy)
	end
end

function XiaoNuoBirthdayGiftAgent:sendPM_XiaoNuoBirthdaySweepNormalGameReq(activityId, diffLv, score, times)
	local req = XiaoNuoBirthdayGiftExtension_pb.PM_XiaoNuoBirthdaySweepNormalGameReq()

	req.activityId = activityId
	req.diffLv = diffLv
	req.score = score
	req.times = times

	self:sendMsg(req)
end

function XiaoNuoBirthdayGiftAgent:handlePM_XiaoNuoBirthdaySweepNormalGameRes(status, msg)
	if status == 0 then
		LuoShiQiOrdealController.instance:handlePM_XiaoNuoBirthdaySweepNormalGameRes(msg)
	end
end

function XiaoNuoBirthdayGiftAgent:sendPM_XiaoNuoBirthdaySweepCrazyGameReq(activityId, stageNum, times)
	local req = XiaoNuoBirthdayGiftExtension_pb.PM_XiaoNuoBirthdaySweepCrazyGameReq()

	req.activityId = activityId
	req.stageNum = stageNum
	req.times = times

	self:sendMsg(req)
end

function XiaoNuoBirthdayGiftAgent:handlePM_XiaoNuoBirthdaySweepCrazyGameRes(status, msg)
	if status == 0 then
		LuoShiQiOrdealController.instance:handlePM_XiaoNuoBirthdaySweepCrazyGameRes(msg)
	end
end

XiaoNuoBirthdayGiftAgent.instance = XiaoNuoBirthdayGiftAgent.New()

return XiaoNuoBirthdayGiftAgent
