-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hdsummerlotteryrecommend/agent/QingGuGiftAgent.lua

module("logic.extensions.hdsummerlotteryrecommend.agent.QingGuGiftAgent", package.seeall)

local QingGuGiftAgent = class("QingGuGiftAgent", BaseAgent)

function QingGuGiftAgent:sendPM_QingGuGiftInfoReq(activityId)
	local req = QingGuGiftExtension_pb.PM_QingGuGiftInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function QingGuGiftAgent:handlePM_QingGuGiftInfoRes(status, msg)
	if status == 0 then
		MultiplegiftpacksController.instance:setGiftInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.QingGuGiftInfoRes)
	end
end

function QingGuGiftAgent:sendPM_QingGuGiftBuyReq(activityId)
	local req = QingGuGiftExtension_pb.PM_QingGuGiftBuyReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function QingGuGiftAgent:handlePM_QingGuGiftBuyRes(status, msg)
	if status == 0 then
		local info = {
			bought = true,
			activityId = msg.activityId
		}

		MultiplegiftpacksController.instance:setGiftInfo(info)
		GlobalDispatcher:dispatch(GlobalNotify.QingGuGiftBuyRes)
	end
end

QingGuGiftAgent.instance = QingGuGiftAgent.New()

return QingGuGiftAgent
