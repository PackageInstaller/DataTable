-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PsyearinstallmentView.lua

module("logic.extensions.payshop.view.PsyearinstallmentView", package.seeall)

local PsyearinstallmentView = class("PsyearinstallmentView", ViewComponent)

function PsyearinstallmentView:ctor()
	PsyearinstallmentView.super.ctor(self)
end

function PsyearinstallmentView:buildUI()
	PsyearinstallmentView.super.buildUI(self)

	self._btn6 = self:getBtn("btn6")
	self._btn30 = self:getBtn("btn30")
	self._goBtn30 = goutil.findChild(self.mainGO, "btn30")
	self._btnCloseInstall = self:getBtn("btnClose")
	self._txtDetails = goutil.findChildTextComponent(self.mainGO, "txtDetails")
end

function PsyearinstallmentView:bindEvents()
	PsyearinstallmentView.super.bindEvents(self)
	self._btn6:AddClickListener(function()
		PayShopController.instance:sendBuyYearReq(2)
	end)
	self._btn30:AddClickListener(function()
		PayShopController.instance:sendBuyYearReq(3)
	end)
	self._btnCloseInstall:AddClickListener(self.close, self)
end

function PsyearinstallmentView:unbindEvents()
	PsyearinstallmentView.super.unbindEvents(self)
	self._btnCloseInstall:RemoveClickListener()
end

function PsyearinstallmentView:destroyUI()
	PsyearinstallmentView.super.destroyUI(self)
end

function PsyearinstallmentView:onEnter()
	PsyearinstallmentView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refresh, self)
	self:_refresh()
end

function PsyearinstallmentView:onEnterFinished()
	PsyearinstallmentView.super.onEnterFinished(self)
end

function PsyearinstallmentView:onExit()
	PsyearinstallmentView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refresh, self)
end

function PsyearinstallmentView:onExitFinished()
	PsyearinstallmentView.super.onExitFinished(self)
end

function PsyearinstallmentView:_refresh()
	local annuityId = PayShopModel.instance:getCurAnnuityId()
	local data = PayShopModel.instance:getAnnuityInfo(annuityId)

	if data then
		goutil.setActive(self._goBtn30, cfg.price - data.money >= 30)

		local cfg = PayShopConfig.instance:getAnnuityCfgById(annuityId)
		local money = tostring(checknumber(data.money))
		local doneMoney = cfg.price
		local need = math.floor(cfg.price - data.money)

		self._txtDetails.text = string.format("当前已分期金额：%s元\n还需充值金额：%s元\n分期购买至%s元后，可立即享受年卡功能", money, need, doneMoney)
	end
end

return PsyearinstallmentView
