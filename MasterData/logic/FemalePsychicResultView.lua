-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/view/FemalePsychicResultView.lua

module("logic.extensions.femalepsychic.view.FemalePsychicResultView", package.seeall)

local FemalePsychicResultView = class("FemalePsychicResultView", ViewComponent)

function FemalePsychicResultView:ctor()
	FemalePsychicResultView.super.ctor(self)
end

function FemalePsychicResultView:unbindEvents()
	FemalePsychicResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function FemalePsychicResultView:bindEvents()
	FemalePsychicResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancle, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function FemalePsychicResultView:buildUI()
	FemalePsychicResultView.super.buildUI(self)

	self._btnsGroup = self:getGo("btns"):GetComponent(ComponentType.UILayoutSingleLine)
	self._btnCancel = self:getBtn("btns/btnCancel")
	self._btnSure = self:getBtn("btns/btnSure")
	self._txtBeforeScore = self:getTxt("txtBeforeScore")
	self._txtForwardScore = self:getTxt("txtForwardScore")
	self._txtCurScore = self:getTxt("txtCurScore")
	self._txtNextScore = self:getTxt("txtNextScore")
	self._txtSure = self:getTxt("btns/btnSure/text")
	self._txtTip = self:getTxt("txtTip")
end

function FemalePsychicResultView:onExit()
	FemalePsychicResultView.super.onExit(self)
end

function FemalePsychicResultView:onEnter()
	FemalePsychicResultView.super.onEnter(self)

	self._result = FemalePsychicModel.instance:getChallengeResult()
	self._battleInfo = FemalePsychicModel.instance:getBattleInfo()
	self._beforLevelScore = FemalePsychicModel.instance:getCurLevelScore(self._battleInfo.layerId, self._battleInfo.levelId)
	self._forwardLevelScore = FemalePsychicModel.instance:getCurLevelScore(self._battleInfo.layerId, self._battleInfo.levelId - 1)
	self._nextLevelScore = FemalePsychicModel.instance:getCurLevelScore(self._battleInfo.layerId, self._battleInfo.levelId + 1)
	self._isCanSaveData = FemalePsychicModel.instance:canSaveData()
	self._txtBeforeScore.text = self._beforLevelScore
	self._txtCurScore.text = self._result.score

	if self._forwardLevelScore > 0 then
		self._txtForwardScore.text = self._forwardLevelScore or "暂无"
	end

	if self._nextLevelScore > 0 then
		self._txtNextScore.text = self._nextLevelScore or "暂无"
	end

	self._txtSure.text = self._isCanSaveData and "确定" or "知道了"

	GameUtil.SetActive(self._btnCancel, self._isCanSaveData)
	self._btnsGroup:Layout()

	self._txtTip.text = self._isCanSaveData and "是否覆盖上次挑战通灵积分" or "本关分数不大于上一关分数不符合覆盖条件"
end

function FemalePsychicResultView:_onClickCancle()
	self:close()
end

function FemalePsychicResultView:_onClickSure()
	if self._isCanSaveData then
		FemalePsychicController.instance:sendPM_FemalePsychicChallengeConformResultReq(self._battleInfo.activityId, true)
		self:close()
	else
		self:close()
	end
end

return FemalePsychicResultView
