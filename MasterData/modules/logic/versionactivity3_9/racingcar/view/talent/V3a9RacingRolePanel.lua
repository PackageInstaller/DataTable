-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/talent/V3a9RacingRolePanel.lua

module("modules.logic.versionactivity3_9.racingcar.view.talent.V3a9RacingRolePanel", package.seeall)

local V3a9RacingRolePanel = class("V3a9RacingRolePanel", BaseView)

function V3a9RacingRolePanel:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingRolePanel:addEvents()
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.onUnlockRole, self._onUnlockRole, self)
end

function V3a9RacingRolePanel:removeEvents()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.removeEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.onUnlockRole, self._onUnlockRole, self)
end

function V3a9RacingRolePanel:_onCurrencyChange(ids)
	self._currencyId = self._currencyId or V3a9RacingTalentModel.instance:getCurrencyId(self._actId)

	if not ids[self._currencyId] then
		return
	end

	self:_refreshItem()
end

function V3a9RacingRolePanel:_onUnlockRole()
	self:_refreshItem()
end

function V3a9RacingRolePanel:_editableInitView()
	V3a9RacingRoleListModel.instance:setMoList()
end

function V3a9RacingRolePanel:onUpdateParam()
	return
end

function V3a9RacingRolePanel:onOpen()
	self._actId = self.viewParam.actId or V3a9RacingTalentModel.instance:getActId()
end

function V3a9RacingRolePanel:_refreshItem()
	V3a9RacingRoleListModel.instance:onModelUpdate()
end

function V3a9RacingRolePanel:onClose()
	return
end

function V3a9RacingRolePanel:onDestroyView()
	return
end

return V3a9RacingRolePanel
