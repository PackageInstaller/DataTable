-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zijiedatatransfer/view/ZijiedatatransferView.lua

module("logic.extensions.zijiedatatransfer.view.ZijiedatatransferView", package.seeall)

local ZijiedatatransferView = class("ZijiedatatransferView", ViewComponent)

function ZijiedatatransferView:ctor()
	ZijiedatatransferView.super.ctor(self)
end

function ZijiedatatransferView:unbindEvents()
	ZijiedatatransferView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTianti)
	GameUtil.rmClickHandler(self._btnDownload)
end

function ZijiedatatransferView:bindEvents()
	ZijiedatatransferView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTianti, self.onClickTianti, self)
	GameUtil.addClickHandler(self._btnDownload, self.onClickDownLoad, self)
end

function ZijiedatatransferView:buildUI()
	ZijiedatatransferView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTianti = self:getGo("btnTianti")
	self._btnDownload = self:getGo("btnDownload")
end

function ZijiedatatransferView:onExit()
	ZijiedatatransferView.super.onExit(self)
	GlobalDispatcher:removeListener(ByteDanceTransferController.ON_MAIN_VIEW_RES, self.onRefreshUI, self)
	ByteDanceTransferController.instance:onSetMainMsg(nil)
	ByteDanceTransferController.instance:clearWebTime()
end

function ZijiedatatransferView:onEnter()
	ZijiedatatransferView.super.onEnter(self)
	GlobalDispatcher:addListener(ByteDanceTransferController.ON_MAIN_VIEW_RES, self.onRefreshUI, self)
	ByteDanceTransferController.instance:tryOpenMainView()
	self:onRefreshUI()
end

function ZijiedatatransferView:onRefreshUI()
	self.msg = ByteDanceTransferController.instance:getMainMsg()

	GameUtil.SetActive(self._btnTianti, self.msg ~= nil)

	if self.msg then
		local bind = self.msg.bind

		GameUtil.SetGray(self._btnTianti, checkbool(bind))
	end
end

function ZijiedatatransferView:onClickTianti()
	if checkbool(self.msg.bind) then
		local content = langPara("已经绑定了手机号：%s", self.msg.tiantiMobile)

		TipsFacade.instance:openCommonTips(content)
	else
		ByteDanceTransferController.instance:tryOpenInnerWeb()
	end
end

function ZijiedatatransferView:onClickDownLoad()
	local url = "https://www.100bt.com/tianti/dl/?gameId=100044&deliverId=20820627"

	UnityEngine.Application.OpenURL(url)
end

return ZijiedatatransferView
