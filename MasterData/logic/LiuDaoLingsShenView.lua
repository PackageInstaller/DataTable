-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/view/LiuDaoLingsShenView.lua

module("logic.extensions.liudao.view.LiuDaoLingsShenView", package.seeall)

local LiuDaoLingsShenView = class("LiuDaoLingsShenView", ViewComponent)

function LiuDaoLingsShenView:ctor()
	LiuDaoLingsShenView.super.ctor(self)
end

function LiuDaoLingsShenView:buildUI()
	LiuDaoLingsShenView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnMask = GameUtil.asBtn(self:getGo("mask"))
end

function LiuDaoLingsShenView:bindEvents()
	LiuDaoLingsShenView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnMask:AddClickListener(self.close, self)
end

function LiuDaoLingsShenView:unbindEvents()
	LiuDaoLingsShenView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnMask:RemoveClickListener()
end

function LiuDaoLingsShenView:onEnter()
	LiuDaoLingsShenView.super.onEnter(self)
end

function LiuDaoLingsShenView:onExit()
	LiuDaoLingsShenView.super.onExit(self)
end

return LiuDaoLingsShenView
