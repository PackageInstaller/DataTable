-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wandererpass/agent/WandererPassAgent.lua

module("logic.extensions.wandererpass.agent.WandererPassAgent", package.seeall)

local WandererPassAgent = class("WandererPassAgent", BaseAgent)

function WandererPassAgent:sendPM_WandererPassGetInfoReq(activityId)
	local req = WandererPassExtension_pb.PM_WandererPassGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WandererPassAgent:handlePM_WandererPassGetInfoRes(status, msg)
	if status == 0 then
		WandererpassModel.instance:onGetInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ON_WANDERER_PASS_GET_INFO)
	end
end

function WandererPassAgent:handlePM_Notify_WandererPassPaySucResult(status, msg)
	if status == 0 then
		WandererpassModel.instance:setInfoHasGain(msg.activityId)
		GlobalDispatcher:dispatch(GlobalNotify.ON_WANDERER_PASS_GET_INFO)
	end
end

WandererPassAgent.instance = WandererPassAgent.New()

return WandererPassAgent
