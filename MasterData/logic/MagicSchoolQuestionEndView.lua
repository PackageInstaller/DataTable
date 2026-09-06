-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolQuestionEndView.lua

module("logic.extensions.magicschool.view.MagicSchoolQuestionEndView", package.seeall)

local MagicSchoolQuestionEndView = class("MagicSchoolQuestionEndView", ViewComponent)
local MAGIC_BLACK_CAMP_IDX = 1

function MagicSchoolQuestionEndView:ctor()
	MagicSchoolQuestionEndView.super.ctor(self)
end

function MagicSchoolQuestionEndView:unbindEvents()
	MagicSchoolQuestionEndView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGet)
end

function MagicSchoolQuestionEndView:bindEvents()
	MagicSchoolQuestionEndView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGet, self._onClickBtnGet, self)
end

function MagicSchoolQuestionEndView:buildUI()
	MagicSchoolQuestionEndView.super.buildUI(self)

	self._btnGet = self:getGo("btnGet")
	self._txtResult = self:getTxt("txtResult")
	self._txtCampus = self:getTxt("scrView/Viewport/txtCampus")
	self._imgCampChange = self:getGo("imgCamp"):GetComponent(ComponentType.UIImageSpriteChange)
end

function MagicSchoolQuestionEndView:onExit()
	MagicSchoolQuestionEndView.super.onExit(self)
end

function MagicSchoolQuestionEndView:onEnter()
	MagicSchoolQuestionEndView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 514001
	end

	self._campId = checknumber(params[2])
	self._testAnswer = params[3]
	self._answerCfg = MagicSchoolConfig.instance:getAnswerCfgByAnswer(self._activityId, self._campId, self._testAnswer)

	self:_onSetUI()
end

function MagicSchoolQuestionEndView:_onSetUI()
	local contentStr = self._answerCfg.content

	self._txtResult.text = self._answerCfg.desc
	self._txtCampus.text = string.format(contentStr, (self._campId == MAGIC_BLACK_CAMP_IDX or nil) and "黑")

	self._imgCampChange:SetState(self._campId - 1)
end

function MagicSchoolQuestionEndView:_onClickBtnGet()
	local campKey = "MagicSchoolChallengeView" .. self._activityId .. "#" .. self._campId

	GameUtil.saveUserData(campKey, self._campId)
	UIStateManager.instance:pop()
	self:close()
end

return MagicSchoolQuestionEndView
