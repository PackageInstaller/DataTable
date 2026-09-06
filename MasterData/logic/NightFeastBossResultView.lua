-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossResultView.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossResultView", package.seeall)

local NightFeastBossResultView = class("NightFeastBossResultView", ViewComponent)

function NightFeastBossResultView:ctor()
	NightFeastBossResultView.super.ctor(self)
end

function NightFeastBossResultView:buildUI()
	NightFeastBossResultView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._txtNum1 = self:getTxt("txtNum1")
	self._txtNum2 = self:getTxt("txtNum2")
	self._txttips = self:getTxt("txttips")
end

function NightFeastBossResultView:bindEvents()
	NightFeastBossResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function NightFeastBossResultView:unbindEvents()
	NightFeastBossResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnC_btnSurelose)
end

function NightFeastBossResultView:onEnter()
	NightFeastBossResultView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local oldPoint, newPoint = NightFeastBossModel.instance:getNormalBattleBuffPoint(self._activityId)

	self._txtNum1.text = oldPoint
	self._txtNum2.text = newPoint

	local actcfg = NightFeastBossConfig.instance:getActivityCfg(self._activityId)

	self._txttips.text = string.format("获得%s", actcfg.buffPointName)
end

function NightFeastBossResultView:onExit()
	NightFeastBossResultView.super.onExit(self)
end

function NightFeastBossResultView:_onClickSure()
	self:close()
	BattleController.instance:endBattle()
end

return NightFeastBossResultView
