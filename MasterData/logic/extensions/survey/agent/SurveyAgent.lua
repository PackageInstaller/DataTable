-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survey/agent/SurveyAgent.lua

module("logic.extensions.survey.agent.SurveyAgent", package.seeall)

local M = class("SurveyAgent", BaseAgent)

function M:sendCommitSurveyRequest(survey)
	local msg = SurveyExtension_pb.CommitSurveyRequest()

	msg.actId = survey.actId
	msg.finishSeconds = survey.finishSeconds

	for _, ans in pairs(survey.answer) do
		local item = SurveyExtension_pb.AnswerNO()

		item.subjectId = ans.subjectId

		for i, v in pairs(ans.selection) do
			table.insert(item.selection, v - 1)
		end

		if ans.textContent then
			item.textContent = ans.textContent
		end

		table.insert(msg.answer, item)
	end

	self:sendMsg(msg)
	SurveyModel.instance:setCacheSurveyId(nil)
end

function M:handleCommitSurveyReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:handleAvailableSurveyPush(status, msg)
	if status == 0 and msg and msg.actId[1] then
		SurveyModel.instance:setCacheSurveyId(msg.actId[1])
	end
end

function M:sendGetQuestionnaireParamsRequest()
	return
end

function M:handleGetQuestionnaireParamsReply(status, msg)
	if status == 0 then
		printWarn("===params====", msg.params)
		SurveyHtmlUtil.setSurveyParamWithSign(msg.params)
		SurveyHtmlUtil.requestSurveyData()
	end
end

M.instance = M.New()

return M
