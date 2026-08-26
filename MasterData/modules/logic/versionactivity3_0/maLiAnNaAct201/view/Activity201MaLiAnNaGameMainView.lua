-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/Activity201MaLiAnNaGameMainView.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaGameMainView", package.seeall)

local Activity201MaLiAnNaGameMainView = class("Activity201MaLiAnNaGameMainView", BaseView)

function Activity201MaLiAnNaGameMainView:onInitView()
	self._simageBG = gohelper.findChildSingleImage(self.viewGO, "#simage_BG")
	self._gov3a0maliannalevelview = gohelper.findChild(self.viewGO, "#go_v3a0_malianna_levelview")
	self._gov3a0maliannanoticeview = gohelper.findChild(self.viewGO, "#go_v3a0_malianna_noticeview")
	self._gov3a0maliannagameview = gohelper.findChild(self.viewGO, "#go_v3a0_malianna_gameview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity201MaLiAnNaGameMainView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function Activity201MaLiAnNaGameMainView:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function Activity201MaLiAnNaGameMainView:_editableInitView()
	self._ani = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function Activity201MaLiAnNaGameMainView:onUpdateParam()
	return
end

function Activity201MaLiAnNaGameMainView:onOpen()
	return
end

function Activity201MaLiAnNaGameMainView:_onCloseView(viewName)
	if viewName == ViewName.Activity201MaLiAnNaGameView and self._ani then
		self._ani:Play("open")
	end
end

function Activity201MaLiAnNaGameMainView:onClose()
	return
end

function Activity201MaLiAnNaGameMainView:onDestroyView()
	return
end

return Activity201MaLiAnNaGameMainView
