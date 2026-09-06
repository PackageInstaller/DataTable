-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sendflower/view/CharmvalueView.lua

module("logic.extensions.sendflower.view.CharmvalueView", package.seeall)

local CharmvalueView = class("CharmvalueView", ViewComponent)

function CharmvalueView:ctor()
	CharmvalueView.super.ctor(self)
end

function CharmvalueView:buildUI()
	CharmvalueView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnShowHistory = self:getBtn("btnShowHistory")
	self._btnSendHistory = self:getBtn("btnSendHistory")
	self._txtCountTake = self:getTxt("txtCountTake")
	self._txtCountSend = self:getTxt("txtCountSend")
	self._txtCurCharmValue = self:getTxt("txtCurCharmValue")
end

function CharmvalueView:bindEvents()
	CharmvalueView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnShowHistory:AddClickListener(self._onClickBtnShowHistory, self)
	self._btnSendHistory:AddClickListener(self._onClickBtnSendHistory, self)
end

function CharmvalueView:unbindEvents()
	CharmvalueView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnShowHistory:RemoveClickListener()
	self._btnSendHistory:RemoveClickListener()
end

function CharmvalueView:destroyUI()
	CharmvalueView.super.destroyUI(self)
end

function CharmvalueView:onEnter()
	CharmvalueView.super.onEnter(self)

	self._params = self:getOpenParam()
	self._cardInfo = self._params[1]

	SendFlowerAgent.instance:sendPM_GetHistoryInfoReq(self._cardInfo.userId)
	GlobalDispatcher:addListener(SendFlowerController.HandleGetRecord, self._updateUI, self)
end

function CharmvalueView:onEnterFinished()
	CharmvalueView.super.onEnterFinished(self)
end

function CharmvalueView:onExit()
	CharmvalueView.super.onExit(self)
	GlobalDispatcher:removeListener(SendFlowerController.HandleGetRecord, self._updateUI, self)
end

function CharmvalueView:onExitFinished()
	CharmvalueView.super.onExitFinished(self)
end

function CharmvalueView:_updateUI()
	self._txtCountSend.text = checkint(SendFlowerModel.instance:getShowSendCount())
	self._txtCountTake.text = checkint(SendFlowerModel.instance:getShowTakeCount())

	goutil.setActive(self._btnShowHistory.gameObject, self._cardInfo.userId == RoleModel.instance:getUserId())

	self._txtCurCharmValue.text = SendFlowerModel.instance:getCurShowStr(self._cardInfo.charmValue)
end

function CharmvalueView:_onClickBtnShowHistory()
	UIStateManager.instance:push(ViewName.FlowerrecordsView, SendFlowerModel.flowerRecordType.RECEIVE)
end

function CharmvalueView:_onClickBtnSendHistory()
	UIStateManager.instance:push(ViewName.FlowerrecordsView, SendFlowerModel.flowerRecordType.SEND)
end

return CharmvalueView
