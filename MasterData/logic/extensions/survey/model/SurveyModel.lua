-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survey/model/SurveyModel.lua

module("logic.extensions.survey.model.SurveyModel", package.seeall)

local M = class("SurveyModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._ansListData = {}
end

function M:setCacheSurveyId(id)
	self._queryId = id
end

function M:getCacheSurveyId()
	if self._queryId then
		local t = self._queryId

		return t
	end

	return nil
end

function M:setSubAnswer(id, ans)
	ans.subjectId = id
	self._ansListData[id] = ans
end

function M:getSubAnswer(id)
	return self._ansListData[id]
end

function M:clearAnswer()
	self._ansListData = {}
end

M.instance = M.New()

return M
