-- chunkname: @modules/logic/sp02/paomian/enter/view/Sp02_PaoMianShopEntryItem.lua

module("modules.logic.sp02.paomian.enter.view.Sp02_PaoMianShopEntryItem", package.seeall)

local Sp02_PaoMianShopEntryItem = class("Sp02_PaoMianShopEntryItem", LuaCompBase)

function Sp02_PaoMianShopEntryItem.Get(go, actId)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Sp02_PaoMianShopEntryItem, actId)
end

function Sp02_PaoMianShopEntryItem:ctor(actId)
	self._actId = actId
	self._activityCo = ActivityConfig.instance:getActivityCo(self._actId)
	self._activityName = self._activityCo and self._activityCo.name
	self._goodsId = self._activityCo and tonumber(self._activityCo.param)
end

function Sp02_PaoMianShopEntryItem:init(go)
	self.go = go
	self._goLock = gohelper.findChild(self.go, "go_Lock")
	self._goNormal = gohelper.findChild(self.go, "go_Normal")
	self._goExpired = gohelper.findChild(self.go, "go_Expired")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click")
	self._goReddot = gohelper.findChild(self.go, "go_Reddot")
	self._goCanGet = gohelper.findChild(self.go, "go_Normal/go_CanGet")
	self._goCanBuy1 = gohelper.findChild(self.go, "go_Lock/bottombg/go_CanBuy")
	self._goHasBuy1 = gohelper.findChild(self.go, "go_Lock/bottombg/go_HasBuy")
	self._txtTime1 = gohelper.findChildText(self.go, "go_Lock/bottombg/go_CanBuy/txt_Time")
	self._goCanBuy2 = gohelper.findChild(self.go, "go_Normal/bottombg/go_CanBuy")
	self._goHasBuy2 = gohelper.findChild(self.go, "go_Normal/bottombg/go_HasBuy")
	self._txtTime2 = gohelper.findChildText(self.go, "go_Normal/bottombg/go_CanBuy/txt_Time")
	self._goCanBuy3 = gohelper.findChild(self.go, "go_Expired/bottombg/go_CanBuy")
	self._goHasBuy3 = gohelper.findChild(self.go, "go_Expired/bottombg/go_HasBuy")
	self._txtTime3 = gohelper.findChildText(self.go, "go_Expired/bottombg/go_CanBuy/txt_Time")
end

function Sp02_PaoMianShopEntryItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshUI, self)
end

function Sp02_PaoMianShopEntryItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Sp02_PaoMianShopEntryItem:_btnClickOnClick()
	SDKDataTrackMgr.instance:trackClickEnterActivityButton("Sp02_PaoMian_MainView", "store")

	local status, toastId = ActivityHelper.getActivityStatusAndToast(self._actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId and toastId ~= 0 then
			GameFacade.showToast(toastId)
		end

		return
	end

	Sp02_PaoMianController.instance:openShopView(self._actId, self._goodsId)
end

function Sp02_PaoMianShopEntryItem:onUpdateMO()
	self._actMo = ActivityModel.instance:getActMO(self._actId)
	self._status = ActivityHelper.getActivityStatus(self._actId)
	self._isNormal = self._status == ActivityEnum.ActivityStatus.Normal
	self._isExpired = self._status == ActivityEnum.ActivityStatus.Expired
	self._isLock = not self._isNormal and not self._isExpired

	self:refreshUI()
end

function Sp02_PaoMianShopEntryItem:refreshUI()
	gohelper.setActive(self._goLock, self._isLock)
	gohelper.setActive(self._goNormal, self._isNormal)
	gohelper.setActive(self._goExpired, self._isExpired)
	self:refreshRemainTime()
end

function Sp02_PaoMianShopEntryItem:refreshRemainTime()
	gohelper.setActive(self._goHasBuy1, false)
	gohelper.setActive(self._goCanBuy1, true)
	gohelper.setActive(self._goHasBuy2, false)
	gohelper.setActive(self._goCanBuy2, true)
	gohelper.setActive(self._goHasBuy3, false)
	gohelper.setActive(self._goCanBuy3, true)

	local timeStr = ""

	if self._status == ActivityEnum.ActivityStatus.NotOpen then
		local openTime = self._actMo and self._actMo:getRealStartTimeStamp() or 0
		local remainTime = openTime - ServerTime.now()

		timeStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_paomian_mainview_open"), TimeUtil.SecondToActivityTimeFormat(remainTime))
	elseif self._status == ActivityEnum.ActivityStatus.Normal then
		local isCanBuy = DecorateStoreModel.instance:isCanBuyGoods(self._goodsId)

		gohelper.setActive(self._goHasBuy1, not isCanBuy)
		gohelper.setActive(self._goCanBuy1, isCanBuy)
		gohelper.setActive(self._goHasBuy2, not isCanBuy)
		gohelper.setActive(self._goCanBuy2, isCanBuy)
		gohelper.setActive(self._goHasBuy3, not isCanBuy)
		gohelper.setActive(self._goCanBuy3, isCanBuy)

		if isCanBuy then
			timeStr = ActivityHelper.getActivityRemainTimeStr(self._actId)
		end
	elseif self._status == ActivityEnum.ActivityStatus.NotUnlock then
		if self._activityCo and self._activityCo.openId ~= 0 then
			timeStr = OpenHelper.getActivityUnlockTxt(self._activityCo.openId)
		end
	else
		timeStr = luaLang("turnback_end")
	end

	self._txtTime1.text = timeStr
	self._txtTime2.text = timeStr
	self._txtTime3.text = timeStr

	local canGet = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(self._actId)

	gohelper.setActive(self._goCanGet, canGet)
end

function Sp02_PaoMianShopEntryItem:onDestroy()
	return
end

return Sp02_PaoMianShopEntryItem
