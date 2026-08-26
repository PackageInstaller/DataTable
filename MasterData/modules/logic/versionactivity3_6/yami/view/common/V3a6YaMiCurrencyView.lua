-- chunkname: @modules/logic/versionactivity3_6/yami/view/common/V3a6YaMiCurrencyView.lua

module("modules.logic.versionactivity3_6.yami.view.common.V3a6YaMiCurrencyView", package.seeall)

local V3a6YaMiCurrencyView = class("V3a6YaMiCurrencyView", BaseView)

function V3a6YaMiCurrencyView:onInitView()
	self._txtfundingnormal = gohelper.findChildText(self.viewGO, "bg/#txt_fundingnormal")
	self._txtfundingnotenough = gohelper.findChildText(self.viewGO, "bg/#txt_fundingnotenough")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiCurrencyView:addEvents()
	return
end

function V3a6YaMiCurrencyView:removeEvents()
	return
end

function V3a6YaMiCurrencyView:_editableInitView()
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onRefreshCurrency, self._refreshCurrncy, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onConfirmMatrials, self._refreshCurrncy, self)

	self._txtfundingnotenough.text = ""
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function V3a6YaMiCurrencyView:onUpdateParam()
	return
end

function V3a6YaMiCurrencyView:onOpen()
	self:_refreshCurrncy()
end

function V3a6YaMiCurrencyView:_refreshCurrncy()
	local currency = V3a6YaMiModel.instance:getCurrencyNum()
	local status = V3a6YaMiModel.instance:getCurGameStatus()

	if status ~= V3a6YaMiEnum.GameStatus.Performing then
		local curCost = V3a6YaMiModel.instance:getCurSelectMaterialCost()

		currency = currency - curCost
	end

	self._txtfundingnormal.text = currency
end

function V3a6YaMiCurrencyView:checkPlayAddAnim()
	local currency = V3a6YaMiModel.instance:getCurrencyNum()

	if currency > GameUtil.playerPrefsGetNumberByUserId(V3a6YaMiEnum.PrefsKey.Currency, 0) then
		AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_shouji)
		self._anim:Play("add", 0, 0)
	end

	GameUtil.playerPrefsSetNumberByUserId(V3a6YaMiEnum.PrefsKey.Currency, currency)
end

function V3a6YaMiCurrencyView:onClose()
	return
end

function V3a6YaMiCurrencyView:onDestroyView()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onRefreshCurrency, self._refreshCurrncy, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onConfirmMatrials, self._refreshCurrncy, self)
end

return V3a6YaMiCurrencyView
