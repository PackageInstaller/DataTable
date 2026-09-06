-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkTipsView.lua

module("logic.extensions.elementspark.view.ElementSparkTipsView", package.seeall)

local ElementSparkTipsView = class("ElementSparkTipsView", ViewComponent)

function ElementSparkTipsView:ctor()
	ElementSparkTipsView.super.ctor(self)
end

function ElementSparkTipsView:unbindEvents()
	ElementSparkTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function ElementSparkTipsView:bindEvents()
	ElementSparkTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickClose, self)
end

function ElementSparkTipsView:buildUI()
	ElementSparkTipsView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._txtTime = self:getTxt("btnSure/Text")
end

function ElementSparkTipsView:onExit()
	ElementSparkTipsView.super.onExit(self)
	removetimer(self._refresh, self)
	GameUtil.SetGray(self._btnSure.gameObject, false)
end

function ElementSparkTipsView:onEnter()
	ElementSparkTipsView.super.onEnter(self)

	self._stage = self:getFirstParam()
	self._isSignUp = ElementSparkModel.instance:getRegisterInfo()
	self._time = 10
	self._isCanClose = self._isSignUp
	self._txtTime.text = "知道了"

	if not self._isSignUp and self._stage == 1 then
		settimer(1, self._refresh, self, true)
		GameUtil.SetGray(self._btnSure.gameObject, true)
	else
		self._isCanClose = true
	end
end

function ElementSparkTipsView:_refresh()
	self._time = self._time - 1

	if self._time <= 0 then
		self._isCanClose = true

		GameUtil.SetGray(self._btnSure.gameObject, false)
		removetimer(self._refresh, self)

		self._txtTime.text = "知道了"

		return
	end

	self._txtTime.text = string.format("知道了(%ds)", self._time)
end

function ElementSparkTipsView:_onClickClose()
	if self._isCanClose then
		self:close()
	end
end

return ElementSparkTipsView
