-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkPowerView.lua

module("logic.extensions.elementspark.view.ElementSparkPowerView", package.seeall)

local ElementSparkPowerView = class("ElementSparkPowerView", ViewComponent)

function ElementSparkPowerView:ctor()
	ElementSparkPowerView.super.ctor(self)
end

function ElementSparkPowerView:unbindEvents()
	ElementSparkPowerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function ElementSparkPowerView:bindEvents()
	ElementSparkPowerView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function ElementSparkPowerView:buildUI()
	ElementSparkPowerView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._inputField = self:getInput("inputField")
end

function ElementSparkPowerView:onExit()
	ElementSparkPowerView.super.onExit(self)
end

function ElementSparkPowerView:onEnter()
	ElementSparkPowerView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EleSparkModifyMinDefenseFormZdlRes, self.close, self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._power = ElementSparkModel.instance:getPowerValue()
	self._limitWordCount = 7

	self._inputField:SetText(self._power)
	self._inputField:SetCharacterLimit(self._limitWordCount)
end

function ElementSparkPowerView:_onClickSure()
	self._power = checknumber(self._inputField:GetText())

	if self._power <= 0 then
		FloatWordMgr.instance:show("守阵战力值不能小于0哦~")

		return
	end

	if self._power == ElementSparkModel.instance:getPowerValue() then
		FloatWordMgr.instance:show("请设置新的守阵战力值")

		return
	end

	ElementSparkController.instance:sendPM_EleSparkModifyMinDefenseFormZdlReq(self._activityId, self._power)
	self:close()
end

return ElementSparkPowerView
