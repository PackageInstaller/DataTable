-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesswaken/agent/GoddessWakenAgent.lua

module("logic.extensions.goddesswaken.agent.GoddessWakenAgent", package.seeall)

local GoddessWakenAgent = class("GoddessWakenAgent", BaseAgent)

function GoddessWakenAgent:sendPM_GoddessWakenGetInfoReq(activityId)
	local req = GoddessWakenExtension_pb.PM_GoddessWakenGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoddessWakenAgent:handlePM_GoddessWakenGetInfoRes(status, msg)
	if status == 0 then
		GoddessWakenModel.instance:onGoddessWakenGetInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GoddessWakenGetInfo)
	end
end

function GoddessWakenAgent:sendPM_GoddessWakenInjectPowerReq(activityId, goddessId, injectNum)
	local req = GoddessWakenExtension_pb.PM_GoddessWakenInjectPowerReq()

	req.activityId = activityId
	req.goddessId = goddessId
	req.injectNum = injectNum

	self:sendMsg(req)
end

function GoddessWakenAgent:handlePM_GoddessWakenInjectPowerRes(status, msg)
	if status == 0 then
		GoddessWakenModel.instance:onGoddessWakenInjectPower(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GoddessWakenInjectPower)
	end
end

function GoddessWakenAgent:sendPM_GoddessWakenGainTaskPrizeReq(activityId, taskId)
	local req = GoddessWakenExtension_pb.PM_GoddessWakenGainTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function GoddessWakenAgent:handlePM_GoddessWakenGainTaskPrizeRes(status, msg)
	if status == 0 then
		GoddessWakenModel.instance:onGoddessWakenGainTaskPrize(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GoddessWakenGainTaskPrize)
	end
end

function GoddessWakenAgent:sendPM_GoddessWakenGainProgressPrizeReq(activityId, goddessId, prizeId)
	local req = GoddessWakenExtension_pb.PM_GoddessWakenGainProgressPrizeReq()

	req.activityId = activityId
	req.goddessId = goddessId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function GoddessWakenAgent:handlePM_GoddessWakenGainProgressPrizeRes(status, msg)
	if status == 0 then
		local goddessId = msg.goddessId
		local qualityId = msg.prizeId

		GoddessWakenModel.instance:onGoddessWakenGainProgressPrize(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GoddessWakenGainProgressPrize, goddessId, qualityId)
	end
end

GoddessWakenAgent.instance = GoddessWakenAgent.New()

return GoddessWakenAgent
