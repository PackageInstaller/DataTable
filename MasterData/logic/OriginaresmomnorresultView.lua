-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/view/OriginaresmomnorresultView.lua

module("logic.extensions.originaresmom.view.OriginaresmomnorresultView", package.seeall)

local OriginaresmomnorresultView = class("OriginaresmomnorresultView", ViewComponent)

function OriginaresmomnorresultView:ctor()
	OriginaresmomnorresultView.super.ctor(self)
end

function OriginaresmomnorresultView:unbindEvents()
	OriginaresmomnorresultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function OriginaresmomnorresultView:bindEvents()
	OriginaresmomnorresultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function OriginaresmomnorresultView:buildUI()
	OriginaresmomnorresultView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._txtNum = self:getTxt("txtNum")
	self._txtNumMax = self:getTxt("txtNumMax")
end

function OriginaresmomnorresultView:onExit()
	OriginaresmomnorresultView.super.onExit(self)
end

function OriginaresmomnorresultView:onEnter()
	OriginaresmomnorresultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._curNum = params[1]
	self._maxNum = params[2]
	self._txtNum.text = self._curNum
	self._txtNumMax.text = self._maxNum
end

function OriginaresmomnorresultView:_onClickbtnSure()
	BattleFacade.instance:endBattle()
end

return OriginaresmomnorresultView
