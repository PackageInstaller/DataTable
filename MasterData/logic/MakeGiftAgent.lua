-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/celebratebirthday/agent/MakeGiftAgent.lua

module("logic.extensions.makegift.agent.MakeGiftAgent", package.seeall)

local MakeGiftAgent = class("MakeGiftAgent", BaseAgent)

function MakeGiftAgent:sendPM_MakeGiftGetInfoReq(activityId)
	local req = MakeGiftExtension_pb.PM_MakeGiftGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MakeGiftAgent:handlePM_MakeGiftGetInfoRes(status, msg)
	if status == 0 then
		CelebrateBirthdayController.instance:handlePM_MakeGiftGetInfoRes(msg)
	end
end

function MakeGiftAgent:sendPM_MakeGiftMakeReq(activityId)
	local req = MakeGiftExtension_pb.PM_MakeGiftMakeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MakeGiftAgent:handlePM_MakeGiftMakeRes(status, msg)
	if status == 0 then
		CelebrateBirthdayController.instance:handlePM_MakeGiftMakeRes(msg)
	end
end

function MakeGiftAgent:sendPM_MakeGiftGainPrizeReq(activityId, id)
	local req = MakeGiftExtension_pb.PM_MakeGiftGainPrizeReq()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function MakeGiftAgent:handlePM_MakeGiftGainPrizeRes(status, msg)
	if status == 0 then
		CelebrateBirthdayController.instance:handlePM_MakeGiftGainPrizeRes()
	end
end

MakeGiftAgent.instance = MakeGiftAgent.New()

return MakeGiftAgent
