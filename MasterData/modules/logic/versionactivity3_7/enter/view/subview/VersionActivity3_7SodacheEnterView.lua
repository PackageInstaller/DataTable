-- chunkname: @modules/logic/versionactivity3_7/enter/view/subview/VersionActivity3_7SodacheEnterView.lua

module("modules.logic.versionactivity3_7.enter.view.subview.VersionActivity3_7SodacheEnterView", package.seeall)

local VersionActivity3_7SodacheEnterView = class("VersionActivity3_7SodacheEnterView", VersionActivityEnterBaseSubView)
local EnterViewBlockKey = "VersionActivity3_7SodacheEnterView"

function VersionActivity3_7SodacheEnterView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/image_LimitTimeBG/#txt_LimitTime")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._goReddot = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_Reddot")
	self._btnStore = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Store")
	self._txtCurrency = gohelper.findChildText(self.viewGO, "Right/#btn_Store/normal/#txt_Currency")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_7SodacheEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnStore:AddClickListener(self._btnStoreOnClick, self)
end

function VersionActivity3_7SodacheEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnStore:RemoveClickListener()
end

function VersionActivity3_7SodacheEnterView:_btnStoreOnClick()
	SodacheController.instance:openStoreView(VersionActivity3_7Enum.ActivityId.SodacheStore)
end

function VersionActivity3_7SodacheEnterView:_btnEnterOnClick()
	GameUtil.setActiveUIBlock(EnterViewBlockKey, true, false)
	self.anim:Play("switch", 0, 0)
	self.animEnterView:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.delayEnter, self, 0.5)
	TaskDispatcher.runDelay(self.delayReset, self, 0.7)
end

function VersionActivity3_7SodacheEnterView:delayReset()
	self.anim:Play("open", 0, 1)
	self.animEnterView:Play("open", 0, 1)
	GameUtil.setActiveUIBlock(EnterViewBlockKey, false, true)
end

function VersionActivity3_7SodacheEnterView:delayEnter()
	SodacheController.instance:enterScene()
end

function VersionActivity3_7SodacheEnterView:_editableInitView()
	self.anim = gohelper.findComponentAnim(self.viewGO)
	self.animEnterView = gohelper.findComponentAnim(self.viewContainer.viewGO)
end

function VersionActivity3_7SodacheEnterView:onOpen()
	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString("music_vocal_filter"), AudioMgr.instance:getIdFromString("original"))

	self.actId = self.viewContainer.activityId

	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	VersionActivity3_7SodacheEnterView.super.onOpen(self)
	self:refreshStoreCurrency()
end

function VersionActivity3_7SodacheEnterView:onDestroyView()
	TaskDispatcher.cancelTask(self.delayEnter, self)
	TaskDispatcher.cancelTask(self.delayReset, self)

	if UIBlockMgr.instance:isKeyBlock(EnterViewBlockKey) then
		GameUtil.setActiveUIBlock(EnterViewBlockKey, false, true)
	end
end

function VersionActivity3_7SodacheEnterView:everySecondCall()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function VersionActivity3_7SodacheEnterView:refreshStoreCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Sodache)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtCurrency.text = GameUtil.numberDisplay(quantity)
		end
	end
end

return VersionActivity3_7SodacheEnterView
