-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangzhengli/agent/ChuangZhengliClgAgent.lua

module("logic.extensions.chuangzhengliclg.agent.ChuangZhengliClgAgent", package.seeall)

local ChuangZhengliClgAgent = class("ChuangZhengliClgAgent", BaseAgent)

function ChuangZhengliClgAgent:sendPM_ChuangZhengliClgGetInfoReq(activityId)
	local req = ChuangZhengliClgExtension_pb.PM_ChuangZhengliClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChuangZhengliClgAgent:handlePM_ChuangZhengliClgGetInfoRes(status, msg)
	if status == 0 then
		ChuangzhengliModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ChuangZhengliClgGetInfoRes)
	end
end

function ChuangZhengliClgAgent:sendPM_ChuangZhengliClgChallengeReq(activityId, stageId, teamIndex, form)
	local req = ChuangZhengliClgExtension_pb.PM_ChuangZhengliClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamIndex = teamIndex

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function ChuangZhengliClgAgent:handlePM_ChuangZhengliClgChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ChuangZhengliClgChallengeRes)
	end
end

function ChuangZhengliClgAgent:sendPM_ChuangZhengliClgResetStageReq(activityId, stageId)
	local req = ChuangZhengliClgExtension_pb.PM_ChuangZhengliClgResetStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function ChuangZhengliClgAgent:handlePM_ChuangZhengliClgResetStageRes(status, msg)
	if status == 0 then
		ChuangzhengliModel.instance:onResetStage(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ChuangZhengliClgResetStageRes)
	end
end

function ChuangZhengliClgAgent:handlePM_Notify_ChuangZhengliClgChallengeEndRes(status, msg)
	if status == 0 then
		ChuangzhengliModel.instance:onClgEndRes(msg)

		local params = {
			title = "印记",
			content = string.format("本局获得印记%s", checknumber(msg.score))
		}

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.Chuangezhengli, params)
		UIJumper.instance:pushOneStack(ViewName.ChuangzhenglimainView, nil, msg.activityId)
		UIJumper.instance:pushOneStack(ViewName.ChuangzhengliclgView, nil, msg.activityId)
		GlobalDispatcher:dispatch(GlobalNotify.Notify_ChuangZhengliClgChallengeEndRes)
	end
end

ChuangZhengliClgAgent.instance = ChuangZhengliClgAgent.New()

return ChuangZhengliClgAgent
