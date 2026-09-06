-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luotiandajiao/view/LTDaJiaoBuffView.lua

module("logic.extensions.luotiandajiao.view.LTDaJiaoBuffView", package.seeall)

local LTDaJiaoBuffView = class("LTDaJiaoBuffView", ViewComponent)

function LTDaJiaoBuffView:buildUI()
	LTDaJiaoBuffView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtDesc = self:getTxt("desc")
end

function LTDaJiaoBuffView:bindEvents()
	LTDaJiaoBuffView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function LTDaJiaoBuffView:unbindEvents()
	LTDaJiaoBuffView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function LTDaJiaoBuffView:onEnter()
	LTDaJiaoBuffView.super.onEnter(self)

	self._txtDesc.text = self:getFirstParam()
end

function LTDaJiaoBuffView:onExit()
	LTDaJiaoBuffView.super.onExit(self)
end

function LTDaJiaoBuffView:_onClickClose()
	self:close()
end

return LTDaJiaoBuffView
