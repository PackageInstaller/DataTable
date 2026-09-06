-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/view/LiuDaoLunHuaView.lua

module("logic.extensions.liudao.view.LiuDaoLunHuaView", package.seeall)

local LiuDaoLunHuaView = class("LiuDaoLunHuaView", ViewComponent)

function LiuDaoLunHuaView:ctor()
	LiuDaoLunHuaView.super.ctor(self)
end

function LiuDaoLunHuaView:buildUI()
	LiuDaoLunHuaView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnMask = GameUtil.asBtn(self:getGo("mask"))
end

function LiuDaoLunHuaView:bindEvents()
	LiuDaoLunHuaView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnMask:AddClickListener(self.close, self)
end

function LiuDaoLunHuaView:unbindEvents()
	LiuDaoLunHuaView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnMask:RemoveClickListener()
end

function LiuDaoLunHuaView:onEnter()
	LiuDaoLunHuaView.super.onEnter(self)
end

function LiuDaoLunHuaView:onExit()
	LiuDaoLunHuaView.super.onExit(self)
end

return LiuDaoLunHuaView
