-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/talent/V3a9RacingTalentView.lua

module("modules.logic.versionactivity3_9.racingcar.view.talent.V3a9RacingTalentView", package.seeall)

local V3a9RacingTalentView = class("V3a9RacingTalentView", BaseView)

function V3a9RacingTalentView:onInitView()
	self._gotalentreddot = gohelper.findChild(self.viewGO, "root/toggleGroup/toggleSkill/#go_reddot")
	self._gorolereddot = gohelper.findChild(self.viewGO, "root/toggleGroup/toggleRole/#go_reddot")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._gotopright = gohelper.findChild(self.viewGO, "root/#go_topright")
	self._toggletalent = gohelper.findChildToggle(self.viewGO, "root/toggleGroup/toggleSkill")
	self._togglerole = gohelper.findChildToggle(self.viewGO, "root/toggleGroup/toggleRole")
	self._gocurrency = gohelper.findChild(self.viewGO, "root/#go_topright/#go_currency")
	self._imagecurrency = gohelper.findChildImage(self.viewGO, "root/#go_topright/#go_currency/CurrencyIcon")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/#go_topright/#go_currency/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingTalentView:addEvents()
	self._toggletalent:AddOnValueChanged(self._btnTalentOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refershCurrency, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refershCurrency, self)
end

function V3a9RacingTalentView:removeEvents()
	self._toggletalent:RemoveOnValueChanged()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refershCurrency, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refershCurrency, self)
end

function V3a9RacingTalentView:_btnTalentOnClick()
	self._animPlayer:Play("switch", nil, self)
	TaskDispatcher.runDelay(self._refreshSelectTab, self, 0.16)
end

function V3a9RacingTalentView:_editableInitView()
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function V3a9RacingTalentView:onUpdateParam()
	return
end

function V3a9RacingTalentView:onOpen()
	self._toggletalent.isOn = true

	self:_refreshSelectTab()

	self._actId = self.viewParam.actId

	local currencyID = V3a9RacingTalentModel.instance:getCurrencyId(self._actId)

	self._currencyMO = CurrencyModel.instance:getCurrency(currencyID)

	self:_refershCurrency()
end

function V3a9RacingTalentView:_refershCurrency()
	if self._currencyMO then
		if not self._currencyMO.quantity then
			local quantity = 0

			self._txtnum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function V3a9RacingTalentView:_refreshSelectTab()
	if self._toggletalent.isOn then
		if not V3a9RacingCarEnum.TalentTab.Talent then
			local tab = V3a9RacingCarEnum.TalentTab.Role

			self.viewContainer:selectActTab(tab)
		end
	end
end

function V3a9RacingTalentView:onClose()
	TaskDispatcher.cancelTask(self._refreshSelectTab, self)
end

function V3a9RacingTalentView:onDestroyView()
	return
end

return V3a9RacingTalentView
