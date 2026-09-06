-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/view/LiuDaoYuanSuShiView.lua

module("logic.extensions.liudao.view.LiuDaoYuanSuShiView", package.seeall)

local LiuDaoYuanSuShiView = class("LiuDaoYuanSuShiView", ViewComponent)

function LiuDaoYuanSuShiView:ctor()
	LiuDaoYuanSuShiView.super.ctor(self)
end

function LiuDaoYuanSuShiView:buildUI()
	LiuDaoYuanSuShiView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnMask = GameUtil.asBtn(self:getGo("mask"))
end

function LiuDaoYuanSuShiView:bindEvents()
	LiuDaoYuanSuShiView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnMask:AddClickListener(self.close, self)
end

function LiuDaoYuanSuShiView:unbindEvents()
	LiuDaoYuanSuShiView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnMask:RemoveClickListener()
end

function LiuDaoYuanSuShiView:onEnter()
	LiuDaoYuanSuShiView.super.onEnter(self)
end

function LiuDaoYuanSuShiView:onExit()
	LiuDaoYuanSuShiView.super.onExit(self)
end

return LiuDaoYuanSuShiView
