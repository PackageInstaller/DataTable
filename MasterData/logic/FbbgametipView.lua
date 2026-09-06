-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/FbbgametipView.lua

module("logic.extensions.fbbchallenge.view.FbbgametipView", package.seeall)

local FbbgametipView = class("FbbgametipView", ViewComponent)

function FbbgametipView:ctor()
	FbbgametipView.super.ctor(self)
end

function FbbgametipView:buildUI()
	FbbgametipView.super.buildUI(self)

	self._btnContinue = self:getBtn("btnComs/btnContinue")
	self._btnCancel = self:getBtn("btnComs/btnCancel")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "title/txtTitle")
	self._txtBtnCancel = goutil.findChildTextComponent(self.mainGO, "btnComs/btnCancel/Text")
	self._txtBtnOk = goutil.findChildTextComponent(self.mainGO, "btnComs/btnContinue/Text")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtTip")
end

function FbbgametipView:bindEvents()
	FbbgametipView.super.bindEvents(self)
	self._btnContinue:AddClickListener(self._onClickbtnContinue, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function FbbgametipView:unbindEvents()
	FbbgametipView.super.unbindEvents(self)
	self._btnContinue:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function FbbgametipView:destroyUI()
	FbbgametipView.super.destroyUI(self)
end

function FbbgametipView:onEnter()
	FbbgametipView.super.onEnter(self)

	local params = self:getOpenParam()

	self._titleStr = params[1]
	self._tipStr = params[2]
	self._okFunc = params[3]
	self._cancelFunc = params[4]
	self._okBtnStr = params[5] or "确定"
	self._cancelBtnStr = params[6] or "取消"
	self._txtTitle.text = self._titleStr
	self._txtTip.text = self._tipStr
	self._txtBtnOk.text = self._okBtnStr
	self._txtBtnCancel.text = self._cancelBtnStr

	goutil.setActive(self._btnCancel.gameObject, self._cancelFunc)
	goutil.setActive(self._btnContinue.gameObject, self._okFunc)
end

function FbbgametipView:onEnterFinished()
	FbbgametipView.super.onEnterFinished(self)
end

function FbbgametipView:onExit()
	FbbgametipView.super.onExit(self)
end

function FbbgametipView:onExitFinished()
	FbbgametipView.super.onExitFinished(self)
end

function FbbgametipView:_onClickbtnContinue()
	if self._okFunc then
		self._okFunc()
	end

	self:close()
end

function FbbgametipView:_onClickbtnCancel()
	if self._cancelFunc then
		self._cancelFunc()
	end

	self:close()
end

return FbbgametipView
