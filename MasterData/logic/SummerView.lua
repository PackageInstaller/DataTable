-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summer/view/SummerView.lua

module("logic.extensions.summer.view.SummerView", package.seeall)

local SummerView = class("SummerView", ViewComponent)

function SummerView:ctor()
	SummerView.super.ctor(self)
end

function SummerView:buildUI()
	SummerView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnGo1 = self:getBtn("btnGo1")
	self._btnGo2 = self:getBtn("btnGo2")
	self._btnGo3 = self:getBtn("btnGo3")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._effect = self:getGo("effect")
end

function SummerView:bindEvents()
	SummerView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnGo1:AddClickListener(function()
		ViewMgr.instance:open(ViewName.GashaponView)
	end)
	self._btnGo2:AddClickListener(function()
		ViewMgr.instance:open(ViewName.GashaponView)
	end)
	self._btnGo3:AddClickListener(function()
		ViewMgr.instance:open(ViewName.GashaponView)
	end)
end

function SummerView:unbindEvents()
	SummerView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnGo1:RemoveClickListener()
	self._btnGo2:RemoveClickListener()
	self._btnGo3:RemoveClickListener()
end

function SummerView:destroyUI()
	SummerView.super.destroyUI(self)
end

function SummerView:onEnter()
	SummerView.super.onEnter(self)
end

function SummerView:onEnterFinished()
	SummerView.super.onEnterFinished(self)
end

function SummerView:onExit()
	SummerView.super.onExit(self)
end

function SummerView:onExitFinished()
	SummerView.super.onExitFinished(self)
end

return SummerView
