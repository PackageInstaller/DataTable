-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/agent/DivineWaterTianYanClgAgent.lua

module("logic.extensions.divinewatertianyanclg.agent.DivineWaterTianYanClgAgent", package.seeall)

local DivineWaterTianYanClgAgent = class("DivineWaterTianYanClgAgent", BaseAgent)

function DivineWaterTianYanClgAgent:sendPM_DivineWaterTianYanClgGetInfoReq(activityId)
	local req = DivineWaterTianYanClgExtension_pb.PM_DivineWaterTianYanClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineWaterTianYanClgAgent:handlePM_DivineWaterTianYanClgGetInfoRes(status, msg)
	if status == 0 then
		DivinewatertianyanModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineWaterTianYanClgGetInfoRes)
	end
end

function DivineWaterTianYanClgAgent:sendPM_DivineWaterTianYanClgFightReq(activityId, stageId, form)
	local req = DivineWaterTianYanClgExtension_pb.PM_DivineWaterTianYanClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineWaterTianYanClgAgent:handlePM_DivineWaterTianYanClgFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineWaterTianYanClgFightRes)
	end
end

function DivineWaterTianYanClgAgent:handlePM_DivineWaterTianYanClgNotifyFightRes(status, msg)
	if status == 0 then
		DivinewatertianyanController.instance:onClgNotifyFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineWaterTianYanClgNotifyFightRes)
	end
end

function DivineWaterTianYanClgAgent:sendPM_DivineWaterTianYanClgUnlockBuffReq(activityId, buffId)
	local req = DivineWaterTianYanClgExtension_pb.PM_DivineWaterTianYanClgUnlockBuffReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function DivineWaterTianYanClgAgent:handlePM_DivineWaterTianYanClgUnlockBuffRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("解锁成功")
		DivinewatertianyanModel.instance:onUnlockBuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineWaterTianYanClgUnlockBuffRes)
	end
end

DivineWaterTianYanClgAgent.instance = DivineWaterTianYanClgAgent.New()

return DivineWaterTianYanClgAgent
