-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/agent/OriginDragonAryaClgAgent.lua

module("logic.extensions.origindragonaryaclg.agent.OriginDragonAryaClgAgent", package.seeall)

local OriginDragonAryaClgAgent = class("OriginDragonAryaClgAgent", BaseAgent)

function OriginDragonAryaClgAgent:sendPM_OriginDragonAryaClgGetInfoReq(activityId)
	local req = OriginDragonAryaClgExtension_pb.PM_OriginDragonAryaClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginDragonAryaClgAgent:handlePM_OriginDragonAryaClgGetInfoRes(status, msg)
	if status == 0 then
		OriginLongzhuController.instance:onGetInfo(msg)
	end
end

function OriginDragonAryaClgAgent:sendPM_OriginDragonAryaClgChallengeReq(activityId, stageId, form_pb, scoreTypes_i32_Ary)
	local req = OriginDragonAryaClgExtension_pb.PM_OriginDragonAryaClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	for i, v1 in ipairs(scoreTypes_i32_Ary) do
		req.scoreTypes:append(v1)
	end

	self:sendMsg(req)
end

function OriginDragonAryaClgAgent:handlePM_OriginDragonAryaClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginDragonAryaClgAgent:sendPM_OriginDragonAryaClgResetReq(activityId, stageId)
	local req = OriginDragonAryaClgExtension_pb.PM_OriginDragonAryaClgResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginDragonAryaClgAgent:handlePM_OriginDragonAryaClgResetRes(status, msg)
	if status == 0 then
		OriginLongzhuController.instance:onResetFight(msg)
	end
end

function OriginDragonAryaClgAgent:handlePM_Notify_OriginDragonAryaClgChallengeResultRes(status, msg)
	if status == 0 then
		OriginLongzhuController.instance:handleFightRes(msg)
	end
end

function OriginDragonAryaClgAgent:sendPM_OriginDragonAryaClgViewAnnuityGodRankReq(activityId)
	local req = OriginDragonAryaClgExtension_pb.PM_OriginDragonAryaClgViewAnnuityGodRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginDragonAryaClgAgent:handlePM_OriginDragonAryaClgViewAnnuityGodRankRes(status, msg)
	if status == 0 then
		OriginLongzhuModel.instance:onGetGodRankInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GODDAILYRANK_ZHOUNIAN_GODRANKVIEW_INFO)
	end
end

OriginDragonAryaClgAgent.instance = OriginDragonAryaClgAgent.New()

return OriginDragonAryaClgAgent
