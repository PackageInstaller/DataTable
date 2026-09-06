-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FmtUnlockView.lua

module("logic.extensions.formation.view.FmtUnlockView", package.seeall)

local FmtUnlockView = class("FmtUnlockView", ViewComponent)

function FmtUnlockView:ctor()
	FmtUnlockView.super.ctor(self)
end

function FmtUnlockView:buildUI()
	FmtUnlockView.super.buildUI(self)

	self._closeButton = self:getBtn("main/btnClose")
	self._btnBg = self:getBtn("btnBg")
	self._levelNode = self:getGo("main/levelNode")
	self._petNumNode = self:getGo("main/petNumNode")
	self._btnTask = self:getBtn("main/levelNode/btnTask")
	self._btnWay1 = self:getBtn("main/petNumNode/btnWay1")
	self._btnWay2 = self:getBtn("main/petNumNode/btnWay2")
end

function FmtUnlockView:bindEvents()
	FmtUnlockView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnBg:AddClickListener(self._onClickClose, self)
	self._btnTask:AddClickListener(self._onClickTask, self)
	self._btnWay1:AddClickListener(self._onClickWay1, self)
	self._btnWay2:AddClickListener(self._onClickWay2, self)
end

function FmtUnlockView:unbindEvents()
	FmtUnlockView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnBg:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnWay1:RemoveClickListener()
	self._btnWay2:RemoveClickListener()
end

function FmtUnlockView:onEnter()
	FmtUnlockView.super.onEnter(self)

	local param = self:getFirstParam()

	if param.type == 1 then
		self._levelNode.gameObject:SetActive(true)
		self._petNumNode.gameObject:SetActive(false)
	elseif param.type == 2 then
		self._levelNode.gameObject:SetActive(false)
		self._petNumNode.gameObject:SetActive(true)
	end
end

function FmtUnlockView:onExit()
	FmtUnlockView.super.onExit(self)
end

function FmtUnlockView:_onClickClose()
	self:close()
end

function FmtUnlockView:_onClickTask()
	self:_onClickClose()
	UIStateManager.instance:clear(true)
	UIStateManager.instance:push(ViewName.diamondtask)
end

function FmtUnlockView:_onClickWay1()
	self:_onClickClose()
	UIStateManager.instance:clear(true)
	UIStateManager.instance:push(ViewName.Lottery)
end

function FmtUnlockView:_onClickWay2()
	self:_onClickClose()
	UIStateManager.instance:clear(true)
	UIStateManager.instance:push(ViewName.Handbook)
end

return FmtUnlockView
