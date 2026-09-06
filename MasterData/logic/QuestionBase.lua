-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/questionnaire/view/QuestionBase.lua

module("logic.extensions.questionnaire.view.QuestionBase", package.seeall)

local QuestionBase = class("QuestionBase")

function QuestionBase:ctor(go)
	self.mainGO = go

	self:buildUI()
end

function QuestionBase:buildUI()
	return
end

function QuestionBase:setActive(isActive)
	goutil.setActive(self.mainGO, isActive)
end

function QuestionBase:onSetMo(cfg)
	self._questionCfg = cfg
	self._planCfgs = QuestionnaireConfig.instance:getPlanCfgsById(self._questionCfg.planId)
	self._planCfg = self._planCfgs[1]
end

function QuestionBase:getResultStr()
	return "", false
end

function QuestionBase:clear()
	return
end

return QuestionBase
