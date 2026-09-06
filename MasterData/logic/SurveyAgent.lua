-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survey/agent/SurveyAgent.lua

module("logic.extensions.survey.agent.SurveyAgent", package.seeall)

local SurveyAgent = class("SurveyAgent", BaseAgent)

SurveyAgent.PM_RecordClientBehaviorRes = "SurveyAgent_PM_RecordClientBehaviorRes"
SurveyAgent.PM_DanMuCheckAndSaveRes = "SurveyAgent_PM_DanMuCheckAndSaveRes"
SurveyAgent.PM_GetAllSurveyStatesRes = "SurveyAgent_PM_GetAllSurveyStatesRes"
SurveyAgent.PM_SaveSurveyRes = "SurveyAgent_PM_SaveSurveyRes"
SurveyAgent.PM_GainSurveyGiftRes = "SurveyAgent_PM_GainSurveyGiftRes"
SurveyAgent.PM_BigOrangeTalkCheckAndSaveRes = "SurveyAgent_PM_BigOrangeTalkCheckAndSaveRes"

function SurveyAgent:ctor()
	return
end

function SurveyAgent:setExtId(extId)
	SurveyAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function SurveyAgent:sendPM_RecordClientBehaviorReq(behavior_pb_Ary, handler, handlerObj, errHandler)
	local req = SurveyExtension_pb.PM_RecordClientBehaviorReq()

	if behavior_pb_Ary ~= nil then
		for i, v1 in ipairs(behavior_pb_Ary) do
			local behavior = req.behavior:add()

			behavior:ParseFromString(v1:SerializeToString())
		end
	end

	self:sendMsg(req)
	self:addEventOnce(SurveyAgent.PM_RecordClientBehaviorRes, handler, handlerObj, errHandler)
end

function SurveyAgent:handlePM_RecordClientBehaviorRes(status, msg)
	self:dispatch(SurveyAgent.PM_RecordClientBehaviorRes, status, msg)
end

function SurveyAgent:sendPM_DanMuCheckAndSaveReq(key, subKey, time, content, handler, handlerObj, errHandler)
	local req = SurveyExtension_pb.PM_DanMuCheckAndSaveReq()

	req.key = key
	req.subKey = subKey
	req.time = time
	req.content = content

	self:sendMsg(req)
	self:addEventOnce(SurveyAgent.PM_DanMuCheckAndSaveRes, handler, handlerObj, errHandler)
end

function SurveyAgent:handlePM_DanMuCheckAndSaveRes(status, msg)
	self:dispatch(SurveyAgent.PM_DanMuCheckAndSaveRes, status, msg)
end

function SurveyAgent:sendPM_GetAllSurveyStatesReq(handler, handlerObj, errHandler)
	local req = SurveyExtension_pb.PM_GetAllSurveyStatesReq()

	self:sendMsg(req)
	self:addEventOnce(SurveyAgent.PM_GetAllSurveyStatesRes, handler, handlerObj, errHandler)
end

function SurveyAgent:handlePM_GetAllSurveyStatesRes(status, msg)
	self:dispatch(SurveyAgent.PM_GetAllSurveyStatesRes, status, msg)
end

function SurveyAgent:sendPM_SaveSurveyReq(surveyId, surveyAnswers_s_Ary, handler, handlerObj, errHandler)
	local req = SurveyExtension_pb.PM_SaveSurveyReq()

	req.surveyId = surveyId

	for i, v2 in ipairs(surveyAnswers_s_Ary) do
		req.surveyAnswers:append(v2)
	end

	self:sendMsg(req)
	self:addEventOnce(SurveyAgent.PM_SaveSurveyRes, handler, handlerObj, errHandler)
end

function SurveyAgent:handlePM_SaveSurveyRes(status, msg)
	self:dispatch(SurveyAgent.PM_SaveSurveyRes, status, msg)
end

function SurveyAgent:sendPM_GainSurveyGiftReq(surveyId, handler, handlerObj, errHandler)
	local req = SurveyExtension_pb.PM_GainSurveyGiftReq()

	req.surveyId = surveyId

	self:sendMsg(req)
	self:addEventOnce(SurveyAgent.PM_GainSurveyGiftRes, handler, handlerObj, errHandler)
end

function SurveyAgent:handlePM_GainSurveyGiftRes(status, msg)
	self:dispatch(SurveyAgent.PM_GainSurveyGiftRes, status, msg)
end

function SurveyAgent:sendPM_BigOrangeTalkCheckAndSaveReq(type, content, handler, handlerObj, errHandler)
	local req = SurveyExtension_pb.PM_BigOrangeTalkCheckAndSaveReq()

	req.type = type
	req.content = content

	self:sendMsg(req)
	self:addEventOnce(SurveyAgent.PM_BigOrangeTalkCheckAndSaveRes, handler, handlerObj, errHandler)
end

function SurveyAgent:handlePM_BigOrangeTalkCheckAndSaveRes(status, msg)
	self:dispatch(SurveyAgent.PM_BigOrangeTalkCheckAndSaveRes, status, msg)
end

function SurveyAgent:sendPM_SignForSdkSurveyReq()
	local req = SurveyExtension_pb.PM_SignForSdkSurveyReq()

	self:sendMsg(req)
end

function SurveyAgent:handlePM_SignForSdkSurveyRes(status, msg)
	if status == 0 then
		SurveyController.instance:onPM_SignForSdkSurveyReq(msg)
	end
end

function SurveyAgent:handlePM_NotifySdkSurveyFinishRes(status, msg)
	if status == 0 then
		-- block empty
	end

	SurveyController.instance:sendPM_SignForSdkSurveyReq()
end

SurveyAgent.instance = SurveyAgent.New()

return SurveyAgent
