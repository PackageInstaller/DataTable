-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/seasonS2/SeasonS2BossChallengeView.lua

module("logic.extensions.season.view.seasonS2.SeasonS2BossChallengeView", package.seeall)

local SeasonS2BossChallengeView = class("SeasonS2BossChallengeView", ViewComponent)

function SeasonS2BossChallengeView:ctor()
	SeasonS2BossChallengeView.super.ctor(self)
end

function SeasonS2BossChallengeView:unbindEvents()
	SeasonS2BossChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function SeasonS2BossChallengeView:bindEvents()
	SeasonS2BossChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickSure, self)
end

function SeasonS2BossChallengeView:buildUI()
	SeasonS2BossChallengeView.super.buildUI(self)

	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnClose = self:getBtn("btnClose")
	self._doppelgangerGo = {}

	for i = 1, 3 do
		self._doppelgangerGo[i] = self:getGo("doppelganger" .. i)
	end

	self._effect = self:getGo("effect")
end

function SeasonS2BossChallengeView:onExit()
	SeasonS2BossChallengeView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end
end

function SeasonS2BossChallengeView:onEnter()
	SeasonS2BossChallengeView.super.onEnter(self)

	self._phaseCfg = SeasonConfig.instance:getBossPhaseConfigs(SeasonModel.instance:getSeasonId())

	local params = self:getFirstParam()

	self._isReachBossPhase = SeasonModel.instance.bossMo.phaseId == SeasonPVEBossController.instance:getBossPhaseId()

	GameUtil.SetActive(self._btnChallenge, not params.bHideSure and self._isReachBossPhase)
	self:_updateDoppelanger()

	self._sureCallback = params.sureCallback
end

function SeasonS2BossChallengeView:_showEffect()
	local effectPath = "20221028/shengjingtiaozhan/fx_ui_shengjingtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effectPath, self._effect, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self._effect.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function SeasonS2BossChallengeView:_onClickSure()
	self:close()
	GameUtil.callBack(self._sureCallback)
end

function SeasonS2BossChallengeView:_updateDoppelanger()
	local doppelangersCfg = SeasonPVEBossController.instance:getDoppelgangerReadOnlyPointIds()

	for i, v in ipairs(self._doppelgangerGo) do
		local completeGo = goutil.findChild(v, "winGo")
		local headIcon = goutil.findChild(v, "headIcon")

		GameUtil.SetActive(v, not self._isReachBossPhase)

		local plusCfg = SeasonConfig.instance:getBossPlusCfg(SeasonModel.instance:getSeasonId(), doppelangersCfg[i])

		if plusCfg and checknumber(plusCfg.skinId) > 0 then
			MaterialMgr.setIcon(headIcon, MatType.Pet, plusCfg.skinId)
		end

		GameUtil.SetActive(completeGo, SeasonModel.instance:isOccupied(checknumber(doppelangersCfg[i])))
	end
end

return SeasonS2BossChallengeView
