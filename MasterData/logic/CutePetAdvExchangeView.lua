-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/adventure/CutePetAdvExchangeView.lua

module("logic.extensions.cutepet.view.CutePetAdvExchangeView", package.seeall)

local CutePetAdvExchangeView = class("CutePetAdvExchangeView", ViewComponent)

function CutePetAdvExchangeView:buildUI()
	CutePetAdvExchangeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._txtDescOther = goutil.findChildTextComponent(self.mainGO, "txtDescOther")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._txtOldValue = goutil.findChildTextComponent(self.mainGO, "valueCol/txtOldValue")
	self._txtNewValue = goutil.findChildTextComponent(self.mainGO, "valueCol/txtNewValue")
end

function CutePetAdvExchangeView:bindEvents()
	CutePetAdvExchangeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function CutePetAdvExchangeView:unbindEvents()
	CutePetAdvExchangeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function CutePetAdvExchangeView:onEnter()
	CutePetAdvExchangeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	if not params[1] then
		local info = {}

		self._closeCallBack = info.closeCallBack
		self._sureCallBack = info.sureCallBack
		self._cancelCallBack = info.cancelCallBack
		self._oldValue = info.oldValue
		self._newValue = info.newValue
		self._txtDesc.text = info.content
		self._txtOldValue.text = self._oldValue
		self._txtNewValue.text = self._newValue
		self._txtDescOther.text = info.content2
	end
end

function CutePetAdvExchangeView:onExit()
	CutePetAdvExchangeView.super.onExit(self)
end

function CutePetAdvExchangeView:_onClickBtnClose()
	GameUtil.callBack(self._closeCallBack)
	self:close()
end

function CutePetAdvExchangeView:_onClickBtnSure()
	GameUtil.callBack(self._sureCallBack)
	self:close()
end

function CutePetAdvExchangeView:_onClickBtnCancel()
	GameUtil.callBack(self._cancelCallBack)
	self:close()
end

return CutePetAdvExchangeView
