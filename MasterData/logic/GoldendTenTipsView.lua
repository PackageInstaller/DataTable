-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendten/view/GoldendTenTipsView.lua

module("logic.extensions.goldendten.view.GoldendTenTipsView", package.seeall)

local GoldendTenTipsView = class("GoldendTenTipsView", ViewComponent)

function GoldendTenTipsView:buildUI()
	GoldendTenTipsView.super.buildUI(self)

	self._inputCode = self:getInput("inputCode")
	self._bg_2 = self:getGo("bg_2")
	self._bg_1 = self:getGo("bg_1")
	self._goInputCode = self:getGo("inputCode")
	self._btnClose = self:getGo("btnClose")
	self._btnBecome = self:getGo("btnBecome")
	self._txtBtnBecome = self:getTxt("btnBecome/txt")
	self._showComs = {}

	for i = 1, 3 do
		self._showComs[i] = self:getGo("showCom_" .. i)
	end
end

function GoldendTenTipsView:bindEvents()
	GoldendTenTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBecome, self._onClickBecome, self)
end

function GoldendTenTipsView:unbindEvents()
	GoldendTenTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBecome)
end

function GoldendTenTipsView:onEnter()
	GoldendTenTipsView.super.onEnter(self)

	local params = self:getOpenParam()

	self._actId = checkint(params[1])
	self._becomeType = checkint(params[2])
	self._copyCode = params[3]

	local showStr = string.nilorempty(self._copyCode) and "" or self._copyCode

	self._inputCode:SetText(showStr)
	GlobalDispatcher:addListener(GlobalNotify.GoldendTenError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.GoldendTenBecomeSuc, self._handleBecomeSuc, self)

	for k, v in ipairs(self._showComs) do
		goutil.setActive(v, k == self._becomeType)
	end

	goutil.setActive(self._goInputCode, self._becomeType ~= 3)

	self._txtBtnBecome.text = self._becomeType ~= 3 and "立即绑定" or "成为圣使"

	goutil.setActive(self._bg_1, self._becomeType ~= 3)
	goutil.setActive(self._bg_2, self._becomeType == 3)
end

function GoldendTenTipsView:onExit()
	GoldendTenTipsView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GoldendTenError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoldendTenBecomeSuc, self._handleBecomeSuc, self)
end

function GoldendTenTipsView:_onClickBecome()
	local code = self._inputCode:GetText()

	if self._becomeType == 1 then
		if string.nilorempty(code) then
			FloatWordMgr.instance:show("当前输入为空")

			return
		end

		GoldendTenController.instance:becomeLeader(self._actId, code)
	elseif self._becomeType == 2 then
		if string.nilorempty(code) then
			FloatWordMgr.instance:show("当前输入为空")

			return
		end

		GoldendTenController.instance:becomeFollower(self._actId, code)
	elseif self._becomeType == 3 then
		GoldendTenController.instance:becomeLeader(self._actId, "")
	end
end

function GoldendTenTipsView:_onError(status)
	return
end

function GoldendTenTipsView:_handleBecomeSuc()
	self:close()
	GoldendTenController.instance:getInfo(self._actId)
end

return GoldendTenTipsView
