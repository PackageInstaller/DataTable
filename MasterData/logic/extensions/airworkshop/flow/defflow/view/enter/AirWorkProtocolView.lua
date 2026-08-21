-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/enter/AirWorkProtocolView.lua

module("logic.extensions.airworkshop.flow.defflow.view.enter.AirWorkProtocolView", package.seeall)

local M = class("AirWorkProtocolView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtnByPath("universal_second_tips_common_bg/content/btnClose")
	self._btnRefuse = self:getBtnByPath("allContent/layout/btnList/btnCancel")
	self._btnAgree = self:getBtnByPath("allContent/layout/btnList/btnConfirm")
	self._btnPanelGo = self:getGoByPath("allContent/layout/btnList")
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnRefuse:AddClickListener(self._onClickClose, self)
	self._btnAgree:AddClickListener(self._onClickAgree, self)
	GlobalDispatcher:addEventListener(EventType.AGREE_AIRWORK_PROTOCOL_EVENT, self._onAgreeProtocol, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnRefuse:RemoveClickListener()
	self._btnAgree:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.AGREE_AIRWORK_PROTOCOL_EVENT, self._onAgreeProtocol, self)
end

function M:onEnter()
	self:_refreshView()
end

function M:_refreshView()
	local showBtn = self:getFirstParam()

	goutil.setActive(self._btnPanelGo, showBtn)
end

function M:onExit()
	return
end

function M:_onClickClose()
	self:close()
	ViewMgr.instance:close(ViewName.AirWorkShopDefThemeSelectView)
	GlobalDispatcher:dispatchEvent(EventType.AGREE_AIRWORK_PROTOCOL_EVENT, false)
end

function M:_onClickAgree()
	AirWorkShopDefAgent.instance:sendReadAgreementRequest()
end

function M:_onAgreeProtocol(evt, isAgree)
	if isAgree then
		self:close()
	end
end

return M
