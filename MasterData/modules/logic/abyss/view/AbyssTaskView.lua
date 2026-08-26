-- chunkname: @modules/logic/abyss/view/AbyssTaskView.lua

module("modules.logic.abyss.view.AbyssTaskView", package.seeall)

local AbyssTaskView = class("AbyssTaskView", BaseView)

function AbyssTaskView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_reward")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "right/#scroll_reward/viewport/#go_rewardcontent")
	self._txtcountday = gohelper.findChildText(self.viewGO, "title/timebg/#txt_countday")
	self._gostatlistitem = gohelper.findChild(self.viewGO, "starlayout/#go_statlistitem")
	self._gostaritem = gohelper.findChild(self.viewGO, "starlayout/#go_statlistitem/starbg/#go_staritem")
	self._gostar = gohelper.findChild(self.viewGO, "starlayout/#go_statlistitem/starbg/#go_staritem/#go_star")
	self._txtchapternum = gohelper.findChildText(self.viewGO, "starlayout/#go_statlistitem/starbg/#txt_chapternum")
	self._gostore = gohelper.findChild(self.viewGO, "store")
	self._gostoreTime = gohelper.findChild(self.viewGO, "store/time")
	self._txtstoreTime = gohelper.findChildText(self.viewGO, "store/time/#txt_storeTime")
	self._txtstoreName = gohelper.findChildText(self.viewGO, "store/#txt_storeName")
	self._txtcoinNum = gohelper.findChildText(self.viewGO, "store/#txt_coinNum")
	self._imagecoin = gohelper.findChildImage(self.viewGO, "store/#txt_coinNum/#image_coin")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "store/#btn_store")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssTaskView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStore, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self.refreshStore, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnAbyssTaskUpdate, self.onAbyssTaskUpdate, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnGetTaskReward, self._getTaskBouns, self)
end

function AbyssTaskView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStore, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self.refreshStore, self)
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnAbyssTaskUpdate, self.onAbyssTaskUpdate, self)
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnGetTaskReward, self._getTaskBouns, self)
end

function AbyssTaskView:_btncloseOnClick()
	self:closeThis()
end

function AbyssTaskView:_btnstoreOnClick()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreId.TowerStore)
end

function AbyssTaskView:_editableInitView()
	gohelper.setActive(self._txtstoreTime, true)
end

function AbyssTaskView:onUpdateParam()
	return
end

function AbyssTaskView:onOpen()
	self:checkParam()
	self:refreshUI()
end

function AbyssTaskView:checkParam()
	self.actId = AbyssModel.instance:getCurActId()
	self.actInfoMo = AbyssModel.instance:getCurInfoMo()
end

AbyssTaskView.RefreshTimeDuration = 1

function AbyssTaskView:refreshUI()
	self:refreshStageInfo()
	AbyssTaskListModel.instance:initList(self.actId)
	self:refreshTime()
	self:refreshStore()
	TaskDispatcher.runRepeat(self.refreshTime, self, AbyssTaskView.RefreshTimeDuration)
end

function AbyssTaskView:refreshStore()
	local currencyIcon = TowerStoreModel.instance:getCurrencyIcon()

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecoin, currencyIcon)

	self._txtcoinNum.text = TowerStoreModel.instance:getCurrencyCount()

	gohelper.setActive(self._gostore, true)
	self:refreshStoreTime()
end

function AbyssTaskView:refreshStoreTime(useEn)
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local actStatues = actInfoMo and ActivityHelper.getActivityStatus(self.actId)

	if actInfoMo and actStatues ~= ActivityEnum.ActivityStatus.Expired then
		self._txtstoreTime.text = actInfoMo:getRemainTimeStr2ByEndTime(useEn)

		return
	end

	self._txtstoreTime.text = ""
end

function AbyssTaskView:refreshTime()
	self:refreshStoreTime()

	if not self.actId then
		self._txtcountday.text = luaLang("ended")

		return
	end

	if not ActivityModel.instance:isActOnLine(self.actId) then
		self._txtcountday.text = luaLang("ended")

		return
	end

	local endTime = ActivityModel.instance:getActEndTime(self.actId) / TimeUtil.OneSecondMilliSecond
	local nowTime = ServerTime.now()

	self._txtcountday.text = endTime <= nowTime and luaLang("ended") or TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)
end

function AbyssTaskView:onAbyssTaskUpdate()
	if not self._getTaskBonusItem then
		return
	end

	self._getTaskBonusItem:playOutAnim()

	self._getTaskBonusItem = nil

	UIBlockMgr.instance:startBlock("AbyssTaskView bonus")
	TaskDispatcher.runDelay(self._showRewards, self, 0.3)
end

function AbyssTaskView:_getTaskBouns(taskItem)
	self._getTaskBonusItem = taskItem
end

function AbyssTaskView:_showRewards()
	self:refreshUI()
	UIBlockMgr.instance:endBlock("AbyssTaskView bonus")

	local list = AbyssTaskListModel.instance:getTaskRewardList()

	if MaterialRpc.instance:isShowBadgeGetView(list) then
		return
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, list)
end

function AbyssTaskView:refreshStageInfo()
	local infoMo = self.actInfoMo

	gohelper.CreateObjList(self, self.onCreateStageItem, infoMo.stageInfoList, nil, self._gostatlistitem, AbyssTaskStageItem)
end

function AbyssTaskView:onCreateStageItem(item, stageInfoMo, index)
	item:setInfo(stageInfoMo, index)
end

function AbyssTaskView:onClose()
	TaskDispatcher.cancelTask(self._showRewards, self)
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function AbyssTaskView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return AbyssTaskView
