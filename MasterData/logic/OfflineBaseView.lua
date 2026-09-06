-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/view/OfflineBaseView.lua

module("logic.extensions.offline.view.OfflineBaseView", package.seeall)

local OfflineBaseView = class("OfflineBaseView", ViewComponent)

function OfflineBaseView:ctor()
	OfflineBaseView.super.ctor(self)
end

function OfflineBaseView:unbindEvents()
	OfflineBaseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnGoto, self.onClickGoto, self)
end

function OfflineBaseView:bindEvents()
	OfflineBaseView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnGoto, self.onClickGoto, self)
end

function OfflineBaseView:buildUI()
	OfflineBaseView.super.buildUI(self)

	self.reward = self:getGo("reward")
	self.recieve = self:getGo("reward/recieve")
	self.icon = self:getGo("reward/icon")
	self.btnGoto = self:getGo("btnGoto")
end

function OfflineBaseView:onExit()
	OfflineBaseView.super.onExit(self)
	MaterialMgr.clearIcon(self.icon)
	OfflineController.instance:unregisterLocalNotify(OfflineController.ON_GET_PRIZE_INFO, self.onRefreshUI, self)
end

function OfflineBaseView:onEnter()
	OfflineBaseView.super.onEnter(self)

	self.data = self:getFirstParam()

	OfflineController.instance:registerLocalNotify(OfflineController.ON_GET_PRIZE_INFO, self.onRefreshUI, self)
	self:onRefreshUI()
	GameUtil.SetActive(self.reward, false)

	if not string.nilorempty(self.data.prize) then
		GameUtil.SetActive(self.reward, true)
		MaterialMgr.updateItemByStr(self.icon, self.data.prize)
	end

	RedPointController.instance:saveUserOnceRedPoint(self.data.redpoint, true)
end

function OfflineBaseView:onRefreshUI()
	local activityId = OfflineController.instance:getCurrActivityId()
	local hasGet = OfflineModel.instance:checkHasGetPrize(activityId, self.data.id)

	GameUtil.SetActive(self.recieve, hasGet)
end

function OfflineBaseView:onClickGoto()
	local type = GameUtil.getTimePeriodType(self.data.startTime, self.data.endTime)

	if type == GameUtil.inTimePeriod then
		if string.nilorempty(self.data.wet) then
			TipsFacade.instance:openCommonTips(self.data.desc)
		else
			local activityId = OfflineController.instance:getCurrActivityId()

			OfflineController.instance:sendGetPrize(activityId, self.data.id)
			UnityEngine.Application.OpenURL(self.data.wet)
		end
	elseif type == GameUtil.beforeTimePeriod then
		TipsFacade.instance:openCommonTips(self.data.desc)
	elseif type == GameUtil.afterTimePeriod then
		TipsFacade.instance:openCommonTips(self.data.overDesc)
	end
end

return OfflineBaseView
