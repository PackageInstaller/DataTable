-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/model/CkUnionAnswerMO.lua

module("logic.extensions.chuangkongunion.model.CkUnionAnswerMO", package.seeall)

local CkUnionAnswerMO = class("CkUnionAnswerMO")

function CkUnionAnswerMO:ctor()
	self._activityId = 0
	self._taskId = 0
	self._callback = nil
end

function CkUnionAnswerMO:setActivityId(activityId)
	self._activityId = activityId
end

function CkUnionAnswerMO:setTaskId(taskId)
	self._taskId = taskId
end

function CkUnionAnswerMO:getTotalTime()
	return 20
end

function CkUnionAnswerMO:getQuestionList()
	local list = ChuangkongunionModel.instance:getQuestionIdList(self._taskId)
	local resultList = {}

	for i, questionId in ipairs(list) do
		local cfg = ChuangkongunionConfig.instance:getQuestionCfg(questionId)

		if cfg then
			local element = {}

			element.question = cfg.question
			element.answerList = {}
			element.rightAnswer = cfg.rightAnswer

			table.insert(element.answerList, cfg.answerA)
			table.insert(element.answerList, cfg.answerB)
			table.insert(element.answerList, cfg.answerC)
			table.insert(element.answerList, cfg.answerD)
			table.insert(resultList, element)
		else
			printError("CkUnionAnswerMO 配置不存在")
		end
	end

	return resultList
end

function CkUnionAnswerMO:sendAnswerReq(answerList)
	local sweep = false

	ChuangKongUnionAgent.instance:sendPM_CKUDoDailyTaskReq(self._activityId, self._taskId, sweep, answerList)
end

function CkUnionAnswerMO:setOnCloseCallback(callback)
	self._callback = callback
end

function CkUnionAnswerMO:doOnClose()
	GameUtil.callBack(self._callback)
end

return CkUnionAnswerMO
