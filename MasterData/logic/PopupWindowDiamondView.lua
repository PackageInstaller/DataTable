-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupWindowDiamondView.lua

module("logic.extensions.tips.view.PopupWindowDiamondView", package.seeall)

local PopupWindowDiamondView = class("PopupWindowDiamondView", TipsViewBase)

function PopupWindowDiamondView:ctor()
	PopupWindowDiamondView.super.ctor(self)
end

function PopupWindowDiamondView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickBtn, self)
end

function PopupWindowDiamondView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function PopupWindowDiamondView:buildUI()
	self._closeButton = self:getBtn("Main/btnClose")
	self._txtTitle = self:getGo("Main/txtTitle"):GetComponent("Text")
	self._txtContent = self:getGo("Main/txtContent"):GetComponent("Text")
	self._btnSure = self:getBtn("Main/btnSure")
	self._txtDiamondNum = self:getGo("diamond/txtNum"):GetComponent("Text")
	self._txtDiamondLockedNum = self:getGo("diamondLocked/txtNum"):GetComponent("Text")
end

function PopupWindowDiamondView:destroyUI()
	return
end

function PopupWindowDiamondView:onEnter()
	self._paramDatas = self._viewPresentor._openParam[1]
	self._txtTitle.text = self._paramDatas.title
	self._txtContent.text = self._paramDatas.content
	self._txtDiamondNum.text = RoleModel.instance:getPayDiamond()
	self._txtDiamondLockedNum.text = RoleModel.instance:getPresentDiamond()
end

function PopupWindowDiamondView:onEnterFinished()
	return
end

function PopupWindowDiamondView:onExit()
	return
end

function PopupWindowDiamondView:onExitFinished()
	return
end

function PopupWindowDiamondView:_onClickClose()
	self:close()
end

function PopupWindowDiamondView:_onClickBtn()
	self._paramDatas.btnCallBack()
	self:close()
end

return PopupWindowDiamondView
