-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickupideatipsView.lua

module("logic.extensions.pickupidea.view.PickupideatipsView", package.seeall)

local PickupideatipsView = class("PickupideatipsView", ViewComponent)

function PickupideatipsView:ctor()
	PickupideatipsView.super.ctor(self)
end

function PickupideatipsView:unbindEvents()
	PickupideatipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function PickupideatipsView:bindEvents()
	PickupideatipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickClose, self)
end

function PickupideatipsView:buildUI()
	PickupideatipsView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._txtTime = self:getTxt("btnSure/Text")
end

function PickupideatipsView:onExit()
	PickupideatipsView.super.onExit(self)
	removetimer(self._refresh, self)
	GameUtil.SetGray(self._btnSure.gameObject, false)
end

function PickupideatipsView:onEnter()
	PickupideatipsView.super.onEnter(self)

	self._time = 5
	self._isCanClose = false
	self._txtTime.text = "知道了"

	settimer(1, self._refresh, self, true)
	GameUtil.saveUserData(PickupideagameView.TipsKey, true)
end

function PickupideatipsView:_refresh()
	self._time = self._time - 1

	if self._time <= 0 then
		self._isCanClose = true

		removetimer(self._refresh, self)

		self._txtTime.text = "知道了"

		return
	end

	self._txtTime.text = string.format("知道了(%ds)", self._time)
end

function PickupideatipsView:_onClickClose()
	if self._isCanClose then
		self:close()
	end
end

return PickupideatipsView
