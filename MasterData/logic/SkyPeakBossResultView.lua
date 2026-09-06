-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/view/SkyPeakBossResultView.lua

module("logic.extensions.skypeak.view.SkyPeakBossResultView", package.seeall)

local SkyPeakBossResultView = class("SkyPeakBossResultView", ViewComponent)

function SkyPeakBossResultView:ctor()
	SkyPeakBossResultView.super.ctor(self)
end

function SkyPeakBossResultView:unbindEvents()
	SkyPeakBossResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function SkyPeakBossResultView:bindEvents()
	SkyPeakBossResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function SkyPeakBossResultView:buildUI()
	SkyPeakBossResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._markNotGain = self:getGo("markNotGain")
	self._showCon = self:getGo("showCon")
	self._sliderHp = self:getSlider("hp/slider")
	self._txtHp = self:getTxt("hp/txt")
end

function SkyPeakBossResultView:onExit()
	SkyPeakBossResultView.super.onExit(self)
	MaterialMgr.resetAll(self._showCon)
end

function SkyPeakBossResultView:onEnter()
	SkyPeakBossResultView.super.onEnter(self)

	self._resultInfo = SkyPeakModel.instance:getLastBossChallengeResult()

	if self._resultInfo == nil then
		self:_onClickSure()

		return
	end

	self._activityId = self._resultInfo.activityId
	self._bossId = self._resultInfo.bossId
	self._bossLeftHp = checknumber(self._resultInfo.bossLeftHp)

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function SkyPeakBossResultView:_updateUIByCfg()
	local actCfg = SkyPeakConfig.instance:getActivityCfg(self._activityId)
	local bossCfg = SkyPeakConfig.instance:getBossCfgById(self._activityId, self._bossId)

	if actCfg and bossCfg then
		local showItemStr = string.format("%s:%s", actCfg.scoreShowItem or "", bossCfg.buffScore)

		MaterialMgr.setCellByCfg(showItemStr, self._showCon)
	end
end

function SkyPeakBossResultView:_updateUIByInfo()
	self._bossTotalHp = SkyPeakModel.instance:getBossTotalHp(self._activityId, self._bossId)

	local hpPercent = 0

	if self._bossTotalHp > 0 then
		hpPercent = math.floor(self._bossLeftHp / self._bossTotalHp * 100)

		if hpPercent <= 0 and self._bossLeftHp > 0 then
			hpPercent = 1
		elseif hpPercent > 100 then
			hpPercent = 100
		end
	else
		hpPercent = 0
	end

	self._txtHp.text = langPara("%s%%", hpPercent)

	goutil.setActive(self._markNotGain, self._bossLeftHp > 0)
	goutil.setActive(self._showCon, self._bossLeftHp <= 0)
	self._sliderHp:SetValue(hpPercent / 100)
end

function SkyPeakBossResultView:_onClickSure()
	self:close()
	BattleController.instance:endBattle()
end

return SkyPeakBossResultView
