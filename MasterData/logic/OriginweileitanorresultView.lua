-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/view/OriginweileitanorresultView.lua

module("logic.extensions.originweileita.view.OriginweileitanorresultView", package.seeall)

local OriginweileitanorresultView = class("OriginweileitanorresultView", ViewComponent)

function OriginweileitanorresultView:ctor()
	OriginweileitanorresultView.super.ctor(self)
end

function OriginweileitanorresultView:unbindEvents()
	OriginweileitanorresultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function OriginweileitanorresultView:bindEvents()
	OriginweileitanorresultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function OriginweileitanorresultView:buildUI()
	OriginweileitanorresultView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._txtNum = self:getTxt("txtNum")
	self._txtNumMax = self:getTxt("txtNumMax")
end

function OriginweileitanorresultView:onExit()
	OriginweileitanorresultView.super.onExit(self)
end

function OriginweileitanorresultView:onEnter()
	OriginweileitanorresultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._curNum = params[1]
	self._maxNum = params[2]
	self._txtNum.text = self._curNum or 0
	self._txtNumMax.text = self._maxNum or 0
end

function OriginweileitanorresultView:_onClickbtnSure()
	BattleFacade.instance:endBattle()
end

return OriginweileitanorresultView
