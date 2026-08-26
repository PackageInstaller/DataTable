-- chunkname: @modules/logic/versionactivity1_6/enter/view/Va1_6SeasonEnterView.lua

module("modules.logic.versionactivity1_6.enter.view.Va1_6SeasonEnterView", package.seeall)

local Va1_6SeasonEnterView = class("Va1_6SeasonEnterView", VersionActivityEnterBaseSubView)

function Va1_6SeasonEnterView:onInitView()
	self._goStore = gohelper.findChild(self.viewGO, "Right/Store")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Store/#btn_Store")
	self._txtNum = gohelper.findChildTextMesh(self.viewGO, "Right/Store/#btn_Store/#txt_Num")
	self._txtstoretime = gohelper.findChildTextMesh(self.viewGO, "Right/Store/#go_taglimit/#txt_limit")
	self._txttime = gohelper.findChildTextMesh(self.viewGO, "Right/LimitTime/#txt_LimitTime")
	self._btnEnterNormal = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Normal")
	self._btnEnterClose = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Close")
	self._btnEnterUnOpen = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_UnOpen")
	self._txtunlocktips = gohelper.findChildTextMesh(self.viewGO, "Right/#btn_UnOpen/#txt_Tips")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "Right/txtDescr")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Normal/#image_reddot")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self.rewardItems = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Va1_6SeasonEnterView:addEvents()
	self._btnstore:AddClickListener(self._onClickStoreBtn, self)
	self._btnEnterNormal:AddClickListener(self._onClickMainActivity, self)
	self._btnEnterClose:AddClickListener(self._onClickMainActivity, self)
	self._btnEnterUnOpen:AddClickListener(self._onClickMainActivity, self)
end

function Va1_6SeasonEnterView:removeEvents()
	self._btnstore:RemoveClickListener()
	self._btnEnterNormal:RemoveClickListener()
	self._btnEnterClose:RemoveClickListener()
	self._btnEnterUnOpen:RemoveClickListener()
end

function Va1_6SeasonEnterView:_editableInitView()
	self.actId = Activity104Model.instance:getCurSeasonId()

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	RedDotController.instance:addRedDot(self._goreddot, actCo.redDotId)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.refreshUI, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
end

function Va1_6SeasonEnterView:onOpen()
	Va1_6SeasonEnterView.super.onOpen(self)
	self:refreshUI()
	self:refreshRemainTime()
end

function Va1_6SeasonEnterView:onClose()
	Va1_6SeasonEnterView.super.onClose(self)
end

function Va1_6SeasonEnterView:_onRefreshRedDot()
	return
end

function Va1_6SeasonEnterView:onUpdateParam()
	return
end

function Va1_6SeasonEnterView:refreshEnterBtn()
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(self.actId)

	gohelper.setActive(self._btnEnterNormal, status == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(self._btnEnterClose, status ~= ActivityEnum.ActivityStatus.Normal and status ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(self._btnEnterUnOpen, status == ActivityEnum.ActivityStatus.NotUnlock)

	if status == ActivityEnum.ActivityStatus.NotUnlock then
		self._txtunlocktips.text = ToastController.instance:getToastMsgWithTableParam(toastId, toastParamList)
	end

	local storeStatus = ActivityHelper.getActivityStatus(VersionActivity1_6Enum.ActivityId.SeasonStore)

	gohelper.setActive(self._goStore, storeStatus == ActivityEnum.ActivityStatus.Normal)
end

function Va1_6SeasonEnterView:refreshCurrency()
	local currencyId = Activity104Enum.StoreUTTU[self.actId]
	local currencyMO = CurrencyModel.instance:getCurrency(currencyId)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtNum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function Va1_6SeasonEnterView:refreshUI()
	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self._txtdesc.text = actCo.actDesc

	local rewards = GameUtil.splitString2(actCo.activityBonus, true) or {}

	for i = 1, math.max(#rewards, #self.rewardItems) do
		local item = self.rewardItems[i]
		local data = rewards[i]

		if not item then
			item = IconMgr.instance:getCommonItemIcon(self._gorewardcontent)
			self.rewardItems[i] = item
		end

		if data then
			gohelper.setActive(item.go, true)
			item:setMOValue(data[1], data[2], data[3] or 1, nil, true)
			item:hideEquipLvAndCount()
			item:isShowCount(false)
		else
			gohelper.setActive(item.go, false)
		end
	end

	self:refreshEnterBtn()
	self:refreshCurrency()
end

function Va1_6SeasonEnterView:onDestroyView()
	if self.rewardItems then
		for k, v in pairs(self.rewardItems) do
			v:onDestroy()
		end

		self.rewardItems = nil
	end
end

function Va1_6SeasonEnterView:everySecondCall()
	self:refreshRemainTime()
end

function Va1_6SeasonEnterView:_onClickMainActivity()
	Activity104Controller.instance:openSeasonMainView()
end

function Va1_6SeasonEnterView:_onClickStoreBtn()
	Activity104Controller.instance:openSeasonStoreView()
end

function Va1_6SeasonEnterView:refreshRemainTime()
	self:refreshMainTime()
	self:refreshStoreTime()
end

function Va1_6SeasonEnterView:refreshMainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)

	if not actInfoMo then
		self._txttime.text = ""

		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txttime.text = offsetSecond > 0 and TimeUtil.SecondToActivityTimeFormat(offsetSecond) or luaLang("ended")
end

function Va1_6SeasonEnterView:refreshStoreTime()
	local actId = Activity104Enum.SeasonStore[self.actId]
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if not actInfoMo then
		return
	end

	local status = ActivityHelper.getActivityStatusAndToast(actId)

	self._txtstoretime.text = status ~= ActivityEnum.ActivityStatus.Normal and status ~= ActivityEnum.ActivityStatus.NotUnlock and luaLang("turnback_end") or actInfoMo:getRemainTimeStr2ByEndTime(true)
end

return Va1_6SeasonEnterView
