-- chunkname: @modules/logic/bossrush/view/v1a6/V1a6_BossRush_EnterView.lua

module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_EnterView", package.seeall)

local V1a6_BossRush_EnterView = class("V1a6_BossRush_EnterView", VersionActivityEnterBaseSubView)

function V1a6_BossRush_EnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageBOSS = gohelper.findChildSingleImage(self.viewGO, "#simage_BOSS")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_Title")
	self._simageTitle_Layer4 = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_TitleLayer4")
	self._simageFullBGLayer4 = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBGLayer4")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/#txt_LimitTime")
	self._btnStore = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Store/#btn_Store/click")
	self._simageProp = gohelper.findChildImage(self.viewGO, "Right/Store/#btn_Store/#simage_Prop")
	self._txtNum = gohelper.findChildText(self.viewGO, "Right/Store/#btn_Store/#txt_Num")
	self._btnNormal = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Normal/click")
	self._btnUnOpen = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_UnOpen/click")
	self._txtTips = gohelper.findChildText(self.viewGO, "Right/#btn_UnOpen/image_TIps/#txt_Tips")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self._goStoreTip = gohelper.findChild(self.viewGO, "Right/Store/image_Tips")
	self._txtStore = gohelper.findChildText(self.viewGO, "Right/Store/#btn_Store/txt_Store")
	self._txtActDesc = gohelper.findChildText(self.viewGO, "Left/txtDescr")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_BossRush_EnterView:addEvents()
	self._btnStore:AddClickListener(self._btnStoreOnClick, self)
	self._btnNormal:AddClickListener(self._btnNormalOnClick, self)
	self._btnUnOpen:AddClickListener(self._btnUnOpenOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshStoreTag, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self._refreshStoreTag, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnEnterStoreView, self._refreshStoreTag, self)
end

function V1a6_BossRush_EnterView:removeEvents()
	self._btnStore:RemoveClickListener()
	self._btnNormal:RemoveClickListener()
	self._btnUnOpen:RemoveClickListener()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshStoreTag, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self._refreshStoreTag, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.OnEnterStoreView, self._refreshStoreTag, self)
end

function V1a6_BossRush_EnterView:_btnUnOpenOnClick()
	BossRushController.instance:openMainView()
end

function V1a6_BossRush_EnterView:_btnStoreOnClick()
	BossRushController.instance:openBossRushStoreView(self.actId)
end

function V1a6_BossRush_EnterView:_btnNormalOnClick()
	BossRushController.instance:openMainView()
end

function V1a6_BossRush_EnterView:_editableInitView()
	local nameCn, nameEn = V1a6_BossRush_StoreModel.instance:getStoreGroupName(StoreEnum.BossRushStore.ManeTrust)

	self._txtStore.text = nameCn
	self._itemObjects = {}

	local actInfoMo = BossRushModel.instance:getActivityMo()

	if actInfoMo then
		self._txtActDesc.text = actInfoMo.config.actDesc

		local rewards = GameUtil.splitString2(actInfoMo.config.activityBonus, true)

		if rewards then
			for i, reward in ipairs(rewards) do
				local item = self._itemObjects[i]

				if not item then
					item = IconMgr.instance:getCommonPropItemIcon(self._gorewardcontent)

					table.insert(self._itemObjects, item)
				end

				item:setMOValue(reward[1], reward[2], 1)
				item:isShowCount(false)
			end
		end

		if actInfoMo.config.openId and actInfoMo.config.openId > 0 then
			self._txtTips.text = OpenHelper.getActivityUnlockTxt(actInfoMo.config.openId)
		end
	end
end

function V1a6_BossRush_EnterView:onUpdateParam()
	return
end

function V1a6_BossRush_EnterView:onOpen()
	V1a6_BossRush_EnterView.super.onOpen(self)

	self.actId = BossRushConfig.instance:getActivityId()

	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local isOpen = actInfoMo and ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal
	local goGo = gohelper.findChild(self.viewGO, "Right/#btn_Normal")
	local goUnOpen = gohelper.findChild(self.viewGO, "Right/#btn_UnOpen")
	local goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Normal/#go_reddot")

	gohelper.setActive(goGo, isOpen)
	gohelper.setActive(goUnOpen, not isOpen)

	local defineId = RedDotEnum.DotNode.BossRushEnter

	RedDotController.instance:addRedDot(goreddot, defineId)

	if not actInfoMo then
		self._txtLimitTime.text = ""
	end

	self:_refreshCurrency()
	self:_refreshTime()
	V1a6_BossRush_StoreModel.instance:readAllStoreGroupNewData()
	V1a6_BossRush_StoreModel.instance:checkStoreNewGoods()
	self:_refreshStoreTag()

	local isSpecialAct = false

	gohelper.setActive(self._simageTitle.gameObject, not isSpecialAct)
	gohelper.setActive(self._simageTitle_Layer4.gameObject, isSpecialAct)
	gohelper.setActive(self._simageFullBGLayer4.gameObject, isSpecialAct)
end

function V1a6_BossRush_EnterView:onClose()
	V1a6_BossRush_EnterView.super.onClose(self)
end

function V1a6_BossRush_EnterView:onDestroyView()
	if self.rewardItems then
		for k, v in pairs(self.rewardItems) do
			v:onDestroy()
		end

		self.rewardItems = nil
	end
end

function V1a6_BossRush_EnterView:_refreshStoreTag()
	local isNew = V1a6_BossRush_StoreModel.instance:isHasNewGoodsInStore()

	gohelper.setActive(self._goStoreTip, isNew)
end

function V1a6_BossRush_EnterView:_refreshTime()
	local actInfoMo = BossRushModel.instance:getActivityMo()

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end
	end
end

function V1a6_BossRush_EnterView:_refreshCurrency()
	local count = V1a6_BossRush_StoreModel.instance:getCurrencyCount(self.actId)

	if count then
		self._txtNum.text = count
	end
end

function V1a6_BossRush_EnterView:everySecondCall()
	self:_refreshTime()
end

return V1a6_BossRush_EnterView
