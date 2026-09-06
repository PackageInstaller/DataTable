-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanshenglong/agent/CiYuanHolyDragonClgAgent.lua

module("logic.extensions.ciyuanholydragonclg.agent.CiYuanHolyDragonClgAgent", package.seeall)

local CiYuanHolyDragonClgAgent = class("CiYuanHolyDragonClgAgent", BaseAgent)

function CiYuanHolyDragonClgAgent:ctor()
	return
end

function CiYuanHolyDragonClgAgent:setExtId(extId)
	CiYuanHolyDragonClgAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function CiYuanHolyDragonClgAgent:sendPM_CiYuanHolyDragonClgGetInfoReq(activityId)
	local req = CiYuanHolyDragonClgExtension_pb.PM_CiYuanHolyDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CiYuanHolyDragonClgAgent:handlePM_CiYuanHolyDragonClgGetInfoRes(status, msg)
	if status == 0 then
		CiyuanshenglongController.instance:handlePM_CiYuanHolyDragonClgGetInfoRes(msg)
	end
end

function CiYuanHolyDragonClgAgent:sendPM_CiYuanHolyDragonClgFightReq(activityId, stageId, form_pb)
	local req = CiYuanHolyDragonClgExtension_pb.PM_CiYuanHolyDragonClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function CiYuanHolyDragonClgAgent:handlePM_CiYuanHolyDragonClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		if checknumber(status) == -1902 then
			FloatWordMgr.instance:show(lang("不在开放时间内"))
		end

		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function CiYuanHolyDragonClgAgent:sendPM_CiYuanHolyDragonClgGetHistoryRankReq(activityId)
	local req = CiYuanHolyDragonClgExtension_pb.PM_CiYuanHolyDragonClgGetHistoryRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CiYuanHolyDragonClgAgent:handlePM_CiYuanHolyDragonClgGetHistoryRankRes(status, msg)
	if status == 0 then
		CiyuanshenglongController.instance:handlePM_CiYuanHolyDragonClgGetHistoryRankRes(msg)
	end
end

function CiYuanHolyDragonClgAgent:sendPM_CiYuanHolyDragonClgGetDailyRankReq(activityId)
	local req = CiYuanHolyDragonClgExtension_pb.PM_CiYuanHolyDragonClgGetDailyRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CiYuanHolyDragonClgAgent:handlePM_CiYuanHolyDragonClgGetDailyRankRes(status, msg)
	if status == 0 then
		CiyuanshenglongController.instance:handlePM_CiYuanHolyDragonClgGetDailyRankRes(msg)
	end
end

function CiYuanHolyDragonClgAgent:handlePM_CiYuanHolyDragonClgNotifyFightResultRes(status, msg)
	CiyuanshenglongController.instance:handlePM_CiYuanHolyDragonClgNotifyFightResultRes(msg)
end

CiYuanHolyDragonClgAgent.instance = CiYuanHolyDragonClgAgent.New()

return CiYuanHolyDragonClgAgent
