-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaoxiaoleskin/view/XiaoxiaoleSkinPopupView.lua

module("logic.extensions.xiaoxiaoleskin.view.XiaoxiaoleSkinPopupView", package.seeall)

local XiaoxiaoleSkinPopupView = class("XiaoxiaoleSkinPopupView", ViewComponent)

function XiaoxiaoleSkinPopupView:ctor()
	XiaoxiaoleSkinPopupView.super.ctor(self)
end

function XiaoxiaoleSkinPopupView:unbindEvents()
	XiaoxiaoleSkinPopupView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function XiaoxiaoleSkinPopupView:bindEvents()
	XiaoxiaoleSkinPopupView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function XiaoxiaoleSkinPopupView:onExit()
	XiaoxiaoleSkinPopupView.super.onExit(self)
end

function XiaoxiaoleSkinPopupView:buildUI()
	XiaoxiaoleSkinPopupView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtReward = self:getTxt("txtReward")
end

function XiaoxiaoleSkinPopupView:onEnter()
	XiaoxiaoleSkinPopupView.super.onEnter(self)

	local params = self:getFirstParam()

	self._txtReward.text = string.format("不要担心，送你<color=#a66f35>【%s】</color>", params)
end

return XiaoxiaoleSkinPopupView
