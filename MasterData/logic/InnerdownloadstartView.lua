-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/innerdownload/view/InnerdownloadstartView.lua

module("logic.extensions.innerdownload.view.InnerdownloadstartView", package.seeall)

local InnerdownloadstartView = class("InnerdownloadstartView", ViewComponent)

function InnerdownloadstartView:ctor()
	InnerdownloadstartView.super.ctor(self)
end

function InnerdownloadstartView:unbindEvents()
	InnerdownloadstartView.super.unbindEvents(self)
end

function InnerdownloadstartView:bindEvents()
	InnerdownloadstartView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickStart, self)
end

function InnerdownloadstartView:buildUI()
	InnerdownloadstartView.super.buildUI(self)

	self._btnCancel = self:getGo("btnCancel")
	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtDesc = self:getTxt("txtDesc")
end

function InnerdownloadstartView:onExit()
	InnerdownloadstartView.super.onExit(self)
end

function InnerdownloadstartView:onEnter()
	InnerdownloadstartView.super.onEnter(self)
end

function InnerdownloadstartView:_onClickStart()
	InnerDownloadController.instance:resumeAllDownload()
	self:close()
end

return InnerdownloadstartView
