-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/agent/GoddessAgent.lua

module("logic.extensions.goddess.agent.GoddessAgent", package.seeall)

local GoddessAgent = class("GoddessAgent", BaseAgent)

function GoddessAgent:sendPM_GoddessGetInfoReq(activityId)
	local req = GoddessExtension_pb.PM_GoddessGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoddessAgent:handlePM_GoddessGetInfoRes(status, msg)
	if status == 0 then
		GoddessController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessError, status)
	end
end

function GoddessAgent:sendPM_GoddessTouchReq(activityId, raceId)
	local req = GoddessExtension_pb.PM_GoddessTouchReq()

	req.activityId = activityId
	req.raceId = raceId

	self:sendMsg(req)
end

function GoddessAgent:handlePM_GoddessTouchRes(status, msg)
	if status == 0 then
		GoddessController.instance:handleTouch(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessError, status)
	end
end

function GoddessAgent:sendPM_GoddessSendFlowerReq(activityId, raceId, flowerId, num)
	local req = GoddessExtension_pb.PM_GoddessSendFlowerReq()

	req.activityId = activityId
	req.raceId = raceId
	req.flowerId = flowerId
	req.num = num

	self:sendMsg(req)
end

function GoddessAgent:handlePM_GoddessSendFlowerRes(status, msg)
	if status == 0 then
		GoddessController.instance:handleSendFlower(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessError, status)
	end
end

function GoddessAgent:sendPM_GoddessChatReq(activityId, raceId, id)
	local req = GoddessExtension_pb.PM_GoddessChatReq()

	req.activityId = activityId
	req.raceId = raceId
	req.id = id

	self:sendMsg(req)
end

function GoddessAgent:handlePM_GoddessChatRes(status, msg)
	if status == 0 then
		GoddessController.instance:handleChatRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessError, status)
	end
end

function GoddessAgent:sendPM_GoddessViewRankReq(activityId)
	local req = GoddessExtension_pb.PM_GoddessViewRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoddessAgent:handlePM_GoddessViewRankRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.GoddessViewRankRes, msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessError, status)
	end
end

function GoddessAgent:sendPM_GoddessGainPrizeReq(activityId, raceId, id)
	local req = GoddessExtension_pb.PM_GoddessGainPrizeReq()

	req.activityId = activityId
	req.raceId = raceId
	req.id = id

	self:sendMsg(req)
end

function GoddessAgent:handlePM_GoddessGainPrizeRes(status, msg)
	if status == 0 then
		GoddessController.instance:handleGainGoodFeelingPrize(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessError, status)
	end
end

function GoddessAgent:sendPM_GoddessStartGameReq(activityId, clientKey)
	local req = GoddessExtension_pb.PM_GoddessStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function GoddessAgent:handlePM_GoddessStartGameRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessError, status)
	end

	GoddessController.instance:handlePM_GoddessStartGameRes(status, msg)
end

function GoddessAgent:sendPM_GoddessEndGameReq(activityId, raceId, scale, clientEncryptedKey)
	local req = GoddessExtension_pb.PM_GoddessEndGameReq()

	req.activityId = activityId
	req.raceId = raceId
	req.scale = scale
	req.clientEncryptedKey = clientEncryptedKey

	self:sendMsg(req)
end

function GoddessAgent:handlePM_GoddessEndGameRes(status, msg)
	if status == 0 then
		GoddessController.instance:handleEndGameRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessError, status)
	end
end

function GoddessAgent:sendPM_GoddessReliveReq(activityId)
	local req = GoddessExtension_pb.PM_GoddessReliveReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoddessAgent:handlePM_GoddessReliveRes(status, msg)
	if status == 0 then
		local relivetimes = msg.reliveTimes

		GoddessController.instance:handleReliveRes(relivetimes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessError, status)
	end
end

GoddessAgent.instance = GoddessAgent.New()

return GoddessAgent
