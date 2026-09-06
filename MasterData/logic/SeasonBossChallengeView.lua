-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonBossChallengeView.lua

module("logic.extensions.season.view.SeasonBossChallengeView", package.seeall)

local SeasonBossChallengeView = class("SeasonBossChallengeView", ViewComponent)

function SeasonBossChallengeView:ctor()
	SeasonBossChallengeView.super.ctor(self)
end

function SeasonBossChallengeView:unbindEvents()
	SeasonBossChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function SeasonBossChallengeView:bindEvents()
	SeasonBossChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickSure, self)
end

function SeasonBossChallengeView:buildUI()
	SeasonBossChallengeView.super.buildUI(self)

	self._btnChallenge = self:getGo("btnChallenge")
	self._btnClose = self:getGo("btnClose")
	self._txtPower = self:getTxt("txtPower")
	self._effect = self:getGo("effect")
end

function SeasonBossChallengeView:onExit()
	SeasonBossChallengeView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end
end

function SeasonBossChallengeView:onEnter()
	SeasonBossChallengeView.super.onEnter(self)

	local params = self:getFirstParam()

	GameUtil.SetActive(self._btnChallenge, not params.bHideSure)

	self._sureCallback = params.sureCallback
	self._txtPower.text = langPara("推荐战力：%s", params.recommendZdl or 0)

	self:_showEffect()
end

function SeasonBossChallengeView:_showEffect()
	local effectPath = "20221028/shengjingtiaozhan/fx_ui_shengjingtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effectPath, self._effect, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self._effect.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function SeasonBossChallengeView:_onClickSure()
	self:close()
	GameUtil.callBack(self._sureCallback)
end

return SeasonBossChallengeView
