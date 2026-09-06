-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/PopupItemView.lua

module("logic.extensions.seniorarena.view.PopupItemView", package.seeall)

local PopupItemView = class("PopupItemView", ViewComponent)

function PopupItemView:ctor()
	PopupItemView.super.ctor(self)
end

function PopupItemView:unbindEvents()
	PopupItemView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function PopupItemView:bindEvents()
	PopupItemView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function PopupItemView:onExit()
	PopupItemView.super.onExit(self)
	MaterialMgr.resetAll(self._itemPoint)
end

function PopupItemView:buildUI()
	PopupItemView.super.buildUI(self)

	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtTip")
	self._btnSure = self:getBtn("btnSure")
	self._txtItemNum = goutil.findChildTextComponent(self.mainGO, "haveNum/txtNum")
	self._itemPoint = self:getGo("item")
end

function PopupItemView:onEnter()
	PopupItemView.super.onEnter(self)

	local params = self:getOpenParam()

	self._txtTip.text = params[1] or ""

	local matType, matId, matNum = params[2], params[3], params[4]

	MaterialMgr.resetAll(self._itemPoint)
	MaterialMgr.setCell(matType, matId, self._itemPoint)

	self._txtItemNum.text = string.format("已拥有：%s张", MaterialModel.instance:getMaterialsNumber(matType, matId) - matNum)
	self._clickHandler = params[5]
	self._clickTarget = params[6]
end

function PopupItemView:_onClickSure()
	if self._clickHandler then
		if self._clickTarget then
			self._clickHandler(self._clickTarget)
		else
			self._clickHandler()
		end
	end

	self:close()
end

return PopupItemView
