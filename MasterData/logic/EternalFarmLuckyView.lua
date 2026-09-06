-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/view/EternalFarmLuckyView.lua

module("logic.extensions.eternalfarm.view.EternalFarmLuckyView", package.seeall)

local EternalFarmLuckyView = class("EternalFarmLuckyView", ViewComponent)

function EternalFarmLuckyView:ctor()
	EternalFarmLuckyView.super.ctor(self)
end

function EternalFarmLuckyView:unbindEvents()
	EternalFarmLuckyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function EternalFarmLuckyView:bindEvents()
	EternalFarmLuckyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function EternalFarmLuckyView:buildUI()
	EternalFarmLuckyView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtReward = self:getTxt("txtReward")
end

function EternalFarmLuckyView:onExit()
	EternalFarmLuckyView.super.onExit(self)
end

function EternalFarmLuckyView:onEnter()
	EternalFarmLuckyView.super.onEnter(self)

	local ultimateCropCount = EternalFarmController.instance:ultimateCropCount()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.EternalFarm)

	self._txtReward.text = EternalFarmController.instance:ultimateCropInfo(activityId)
end

return EternalFarmLuckyView
