-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/SkinsTryoutsView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.SkinsTryoutsView", package.seeall)

local SkinsTryoutsView = class("SkinsTryoutsView", ViewComponent)

function SkinsTryoutsView:buildUI()
	SkinsTryoutsView.super.buildUI(self)

	self._btnGain = self:getGo("btnGain")
	self._btnPreview = self:getGo("btnPreview")
	self._btnUseTip = self:getGo("btnUseTip")
end

function SkinsTryoutsView:bindEvents()
	SkinsTryoutsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGain, self.onGainWeekPrize, self)
	GameUtil.addClickHandler(self._btnPreview, self.onPreview, self)
	GameUtil.addClickHandler(self._btnUseTip, self.onUseTip, self)
end

function SkinsTryoutsView:unbindEvents()
	SkinsTryoutsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGain)
	GameUtil.rmClickHandler(self._btnPreview)
	GameUtil.rmClickHandler(self._btnUseTip)
end

function SkinsTryoutsView:onEnter()
	SkinsTryoutsView.super.onEnter(self)

	self._actId = ActivitySummaryController.instance:getActivityId()

	GlobalDispatcher:addListener(GlobalNotify.ActivitySummaryUpdate, self.onRefreshUI, self)
	self:onRefreshUI()
end

function SkinsTryoutsView:onExit()
	SkinsTryoutsView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ActivitySummaryUpdate, self.onRefreshUI, self)
end

function SkinsTryoutsView:onRefreshUI()
	local info = ActivitySummaryModel.instance:getSignInfo(self._actId)

	self._hasGainPrize = info and info.hasGainedWeekPrize or true

	GameUtil.SetGray(self._btnGain, self._hasGainPrize)
end

function SkinsTryoutsView:onGainWeekPrize()
	if self._hasGainPrize then
		FloatWordMgr.instance:show("奖励已领取，下周再来领取")
	else
		ActivitySummaryController.instance:getWeekPrize()
	end
end

function SkinsTryoutsView:onPreview()
	local actCfg = XiaonuoBirthConfig.instance:getActivity(self._actId)
	local matStr = actCfg and actCfg.weekPrize

	if not string.nilorempty(matStr) then
		CommonTipsMgr.instance:openTipsByConfStr(self._btnPreview, matStr)
	end
end

function SkinsTryoutsView:onUseTip()
	UIStateManager.instance:push(ViewName.RulesView, "skinstryoutsusetip")
end

return SkinsTryoutsView
