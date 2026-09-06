-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewHandSelectPassView.lua

module("logic.extensions.newhandwelfare.view.NewHandSelectPassView", package.seeall)

local NewHandSelectPassView = class("NewHandSelectPassView", ViewComponent)

function NewHandSelectPassView:buildUI()
	NewHandSelectPassView.super.buildUI(self)

	self._selectA = self:getGo("selectA")
	self._selectB = self:getGo("selectB")
	self._imgChooseA = self:getGo("selectA/imgChoose")
	self._imgChooseB = self:getGo("selectB/imgChoose")
	self._btnSure = self:getGo("btnSure")
end

function NewHandSelectPassView:bindEvents()
	NewHandSelectPassView.super.bindEvents(self)
	GameUtil.addClickHandler(self._selectA, GameUtil.handler(self._onClickSelect, self, 0))
	GameUtil.addClickHandler(self._selectB, GameUtil.handler(self._onClickSelect, self, 1))
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function NewHandSelectPassView:unbindEvents()
	NewHandSelectPassView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._selectA)
	GameUtil.rmClickHandler(self._selectB)
	GameUtil.rmClickHandler(self._btnSure)
end

function NewHandSelectPassView:onEnter()
	NewHandSelectPassView.super.onEnter(self)

	self._selectMode = 0

	self:_onUpdateUI()
	self.addGEvent(self, GlobalNotify.HandlePM_SelectGuideModeRes, self._handlePM_SelectGuideModeRes, self)
end

function NewHandSelectPassView:onExit()
	NewHandSelectPassView.super.onExit(self)
end

function NewHandSelectPassView:_handlePM_SelectGuideModeRes(status)
	self:close()
end

function NewHandSelectPassView:_onUpdateUI()
	GameUtil.SetActive(self._imgChooseA, self._selectMode == 0)
	GameUtil.SetActive(self._imgChooseB, self._selectMode == 1)
end

function NewHandSelectPassView:_onClickSelect(mode)
	self._selectMode = mode

	self:_onUpdateUI()
end

function NewHandSelectPassView:_onClickSure()
	GlobalDispatcher:dispatch(GlobalNotify.MainActivityViewStartFuncFlyAnimMask, 10)
	RoleController.instance:sendPM_SelectGuideModeReq(self._selectMode)
end

return NewHandSelectPassView
