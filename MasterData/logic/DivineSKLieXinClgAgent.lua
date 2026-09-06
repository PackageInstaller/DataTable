-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineskliexinclg/agent/DivineSKLieXinClgAgent.lua

module("logic.extensions.divineskliexinclg.agent.DivineSKLieXinClgAgent", package.seeall)

local DivineSKLieXinClgAgent = class("DivineSKLieXinClgAgent", BaseAgent)

function DivineSKLieXinClgAgent:sendPM_DivineSKLieXinClgGetInfoReq(activityId)
	local req = DivineSKLieXinClgExtension_pb.PM_DivineSKLieXinClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineSKLieXinClgAgent:handlePM_DivineSKLieXinClgGetInfoRes(status, msg)
	if status == 0 then
		DivineSKLieXinClgController.instance:handlePM_DivineSKLieXinClgGetInfoRes(msg)
	end
end

function DivineSKLieXinClgAgent:sendPM_DivineSKLieXinClgChallengeReq(activityId, stageId, form, tagPosIds)
	local req = DivineSKLieXinClgExtension_pb.PM_DivineSKLieXinClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	for i, v in ipairs(tagPosIds) do
		req.tagPosIds:append(v)
	end

	self:sendMsg(req)
end

function DivineSKLieXinClgAgent:handlePM_DivineSKLieXinClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineSKLieXinClgAgent:handlePM_Notify_DivineSKLieXinClgChallengeRes(status, msg)
	if status == 0 then
		DivineSKLieXinClgController.instance:handlePM_Notify_DivineSKLieXinClgChallengeRes(msg)
	end
end

DivineSKLieXinClgAgent.instance = DivineSKLieXinClgAgent.New()

return DivineSKLieXinClgAgent
