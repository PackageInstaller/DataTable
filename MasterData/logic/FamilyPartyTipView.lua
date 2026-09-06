-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyparty/view/FamilyPartyTipView.lua

module("logic.extensions.familyparty.view.FamilyPartyTipView", package.seeall)

local FamilyPartyTipView = class("FamilyPartyTipView", ViewComponent)

function FamilyPartyTipView:ctor()
	FamilyPartyTipView.super.ctor(self)
end

function FamilyPartyTipView:buildUI()
	FamilyPartyTipView.super.buildUI(self)

	self._answerTip = self:getGo("answerTip")
	self._answerStart = self:getGo("answerTip/answerStart")
	self._answerEnd = self:getGo("answerTip/answerEnd")
	self._imgTxtStart = self:getImg("answerTip/answerStart/img")
	self._imgTxtEnd = self:getImg("answerTip/answerEnd/img")
	self._imgStart = self._answerStart:GetComponent(goutil.Type_UIImage)
	self._imgEnd = self._answerEnd:GetComponent(goutil.Type_UIImage)
end

function FamilyPartyTipView:bindEvents()
	FamilyPartyTipView.super.bindEvents(self)
end

function FamilyPartyTipView:unbindEvents()
	FamilyPartyTipView.super.unbindEvents(self)
end

function FamilyPartyTipView:onEnter()
	FamilyPartyTipView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FamilyPartyNotifyNextQuestionRes, self._onNotifyNextQuestionRes, self)
	self.addGEvent(self, GlobalNotify.FamilyPartyNotifyQuestionResultRes, self._onNotifyQuestionResultRes, self)

	self._answerShowTime = checknumber(FamilyPartyConfig.instance:getCommonValue("QUESTION_CORRECT_ANSWER_SHOW"))

	self:_initView()
end

function FamilyPartyTipView:onExit()
	FamilyPartyTipView.super.onExit(self)
end

function FamilyPartyTipView:_initView()
	self:_clearTween()
	GameUtil.SetActive(self._answerTip, true)
	GameUtil.SetActive(self._answerStart, false)
	GameUtil.SetActive(self._answerEnd, false)
end

function FamilyPartyTipView:_clearTween()
	if self._startTween then
		self._startTween:Kill()
	end

	if self._endTween then
		self._endTween:Kill()
	end

	if self._tweenDelay then
		self._tweenDelay:Kill()

		self._tweenDelay = nil
	end
end

function FamilyPartyTipView:_playStartTween()
	uGuiUtil.setImageAlpha(self._imgStart, 1)
	uGuiUtil.setImageAlpha(self._imgTxtStart, 1)
	GameUtil.SetActive(self._answerStart, true)

	local tween1 = self._imgStart:DOFade(0, 1):SetDelay(1)
	local tween2 = self._imgTxtStart:DOFade(0, 1):SetDelay(1)

	tween2:OnComplete(function()
		GameUtil.SetActive(self._answerStart, false)
	end)

	self._startTween = tween2
end

function FamilyPartyTipView:_playEndTween()
	uGuiUtil.setImageAlpha(self._imgEnd, 1)
	uGuiUtil.setImageAlpha(self._imgTxtEnd, 1)
	GameUtil.SetActive(self._answerEnd, true)

	local tween1 = self._imgEnd:DOFade(0, 1):SetDelay(1)
	local tween2 = self._imgTxtEnd:DOFade(0, 1):SetDelay(1)

	tween2:OnComplete(function()
		GameUtil.SetActive(self._answerEnd, false)
	end)

	self._endTween = tween2
end

function FamilyPartyTipView:_onNotifyNextQuestionRes()
	local curIndex = FamilyPartyModel.instance:getAnswerQuestionCurIndex()

	if curIndex == 1 then
		printInfo("test FamilyPartyTipView:_onNotifyNextQuestionRes 答题开始")
		self:_playStartTween()
	end
end

function FamilyPartyTipView:_onNotifyQuestionResultRes()
	if FamilyPartyModel.instance:isAnswerEnd() then
		self:_playDelayTween()
	end
end

function FamilyPartyTipView:_playDelayTween()
	self._tweenDelay = TweenUtil.DoDelay(self._answerShowTime, function()
		self._tweenDelay = nil

		printInfo("test FamilyPartyTipView:_onNotifyQuestionResultRes 答题结束")
		self:_playEndTween()
	end)
end

return FamilyPartyTipView
