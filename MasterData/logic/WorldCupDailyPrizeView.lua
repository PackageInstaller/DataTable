-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupDailyPrizeView.lua

module("logic.extensions.worldcup.view.WorldCupDailyPrizeView", package.seeall)

local WorldCupDailyPrizeView = class("WorldCupDailyPrizeView", ViewComponent)

function WorldCupDailyPrizeView:ctor()
	WorldCupDailyPrizeView.super.ctor(self)
end

function WorldCupDailyPrizeView:unbindEvents()
	WorldCupDailyPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
end

function WorldCupDailyPrizeView:bindEvents()
	WorldCupDailyPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function WorldCupDailyPrizeView:buildUI()
	WorldCupDailyPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._con = self:getGo("con")
end

function WorldCupDailyPrizeView:onExit()
	WorldCupDailyPrizeView.super.onExit(self)
	MaterialMgr.resetAll(self._con)
end

function WorldCupDailyPrizeView:onEnter()
	WorldCupDailyPrizeView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	local prizeCfg = WorldCupController.instance:getSignInPrize(self._activityId)

	MaterialMgr.setCellByCfg(prizeCfg.signInPrize, self._con)
end

function WorldCupDailyPrizeView:_onClickSure()
	if WorldCupModel.instance:isGainDailyPrize(self._activityId) then
		FloatWordMgr.instance:show(lang("今日已领取"))
	else
		WorldCupAgent.instance:sendPM_WorldCupGainDailyPrizeReq(self._activityId)
	end

	self:close()
end

return WorldCupDailyPrizeView
