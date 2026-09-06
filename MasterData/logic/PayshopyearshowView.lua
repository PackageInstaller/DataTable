-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopyearshowView.lua

module("logic.extensions.payshop.view.PayshopyearshowView", package.seeall)

local PayshopyearshowView = class("PayshopyearshowView", ViewComponent)

function PayshopyearshowView:ctor()
	PayshopyearshowView.super.ctor(self)
end

function PayshopyearshowView:buildUI()
	PayshopyearshowView.super.buildUI(self)

	self._goToShop = self:getBtn("btnGo")
	self._btnClose = self:getBtn("btnClose")
end

function PayshopyearshowView:bindEvents()
	PayshopyearshowView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._goToShop:AddClickListener(self._onClickGoTo, self)
end

function PayshopyearshowView:unbindEvents()
	PayshopyearshowView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._goToShop:RemoveClickListener()
end

function PayshopyearshowView:destroyUI()
	PayshopyearshowView.super.destroyUI(self)
end

function PayshopyearshowView:onEnter()
	PayshopyearshowView.super.onEnter(self)
end

function PayshopyearshowView:onEnterFinished()
	PayshopyearshowView.super.onEnterFinished(self)
end

function PayshopyearshowView:onExit()
	PayshopyearshowView.super.onExit(self)
end

function PayshopyearshowView:onExitFinished()
	PayshopyearshowView.super.onExitFinished(self)
end

function PayshopyearshowView:_onClickGoTo()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_NIANFEI)
	FuncOpenController.instance:openFunc(144, GameEnum.PrivateMainView.YearCard)
	self:close()
end

return PayshopyearshowView
