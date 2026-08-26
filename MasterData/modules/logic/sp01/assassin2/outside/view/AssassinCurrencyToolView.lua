-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinCurrencyToolView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinCurrencyToolView", package.seeall)

local AssassinCurrencyToolView = class("AssassinCurrencyToolView", BaseViewExtended)

function AssassinCurrencyToolView:onInitView()
	self._txtnum = gohelper.findChildText(self.viewGO, "txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinCurrencyToolView:addEvents()
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UpdateCoinNum, self.onCurrencyChanged, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, self.onCurrencyChanged, self)
end

function AssassinCurrencyToolView:removeEvents()
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.UpdateCoinNum, self.onCurrencyChanged, self)
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, self.onCurrencyChanged, self)
end

function AssassinCurrencyToolView:_editableInitView()
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:checkPlayGet()
end

function AssassinCurrencyToolView:onOpen()
	self:refreshAssassinCurrency()
end

function AssassinCurrencyToolView:refreshAssassinCurrency()
	self._txtnum.text = AssassinController.instance:getCoinNum()
end

function AssassinCurrencyToolView:onCurrencyChanged()
	self:refreshAssassinCurrency()
end

function AssassinCurrencyToolView:checkPlayGet()
	local isNeedPlay = AssassinOutsideModel.instance:getIsNeedPlayGetCoin()

	if isNeedPlay then
		self:playGetAnim()
	end
end

function AssassinCurrencyToolView:playGetAnim()
	if not self.animator then
		return
	end

	self.animator:Play("get", 0, 0)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_taskring)
	AssassinOutsideModel.instance:updateIsNeedPlayGetCoin()
end

function AssassinCurrencyToolView:definePrefabUrl()
	self:setPrefabUrl(AssassinEnum.CurrencyToolPrefabPath)
end

function AssassinCurrencyToolView:onClose()
	return
end

function AssassinCurrencyToolView:onDestroyView()
	return
end

return AssassinCurrencyToolView
