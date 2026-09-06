-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/agent/DivineDragonAryaClgAgent.lua

module("logic.extensions.divinedragonaryaclg.agent.DivineDragonAryaClgAgent", package.seeall)

local DivineDragonAryaClgAgent = class("DivineDragonAryaClgAgent", BaseAgent)

function DivineDragonAryaClgAgent:ctor()
	return
end

function DivineDragonAryaClgAgent:setExtId(extId)
	DivineDragonAryaClgAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function DivineDragonAryaClgAgent:sendPM_DivineDragonAryaClgGetInfoReq(activityId)
	local req = DivineDragonAryaClgExtension_pb.PM_DivineDragonAryaClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineDragonAryaClgAgent:handlePM_DivineDragonAryaClgGetInfoRes(status, msg)
	if status == 0 then
		ShenyaolongzunshengzhuController.instance:onGetInfo(msg)
	end
end

function DivineDragonAryaClgAgent:sendPM_DivineDragonAryaClgFightReq(activityId, stageId, form_pb)
	local req = DivineDragonAryaClgExtension_pb.PM_DivineDragonAryaClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineDragonAryaClgAgent:handlePM_DivineDragonAryaClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineDragonAryaClgAgent:sendPM_DivineDragonAryaClgGetGodRankReq(activityId)
	local req = DivineDragonAryaClgExtension_pb.PM_DivineDragonAryaClgGetGodRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineDragonAryaClgAgent:handlePM_DivineDragonAryaClgGetGodRankRes(status, msg)
	if status == 0 then
		ShenyaolongzunshengzhuController.instance:onGetGodRank(msg)
	end
end

function DivineDragonAryaClgAgent:sendPM_DivineDragonAryaClgGetDailyRankReq(activityId)
	local req = DivineDragonAryaClgExtension_pb.PM_DivineDragonAryaClgGetDailyRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineDragonAryaClgAgent:handlePM_DivineDragonAryaClgGetDailyRankRes(status, msg)
	if status == 0 then
		ShenyaolongzunshengzhuController.instance:onGetDayRank(msg)
	end
end

function DivineDragonAryaClgAgent:handlePM_DivineDragonAryaClgNotifyFightResultRes(status, msg)
	ShenyaolongzunshengzhuController.instance:setLastFightInfo(msg)
end

DivineDragonAryaClgAgent.instance = DivineDragonAryaClgAgent.New()

return DivineDragonAryaClgAgent
