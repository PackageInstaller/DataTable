-- chunkname: @modules/logic/activity/view/v4a0_sixstargift/V4a0_SixStarGiftImpl.lua

module("modules.logic.activity.view.v4a0_sixstargift.V4a0_SixStarGiftImpl", package.seeall)

local V4a0_SixStarGiftImpl = class("V4a0_SixStarGiftImpl", BaseView)

function V4a0_SixStarGiftImpl:ctor()
	V4a0_SixStarGiftImpl.super.ctor(self)

	self._itemList = {}
	self._rewardItemList = {}
end

function V4a0_SixStarGiftImpl:_getSelectedDay()
	return 1
end

function V4a0_SixStarGiftImpl:_sendGet101BonusRequest(cb, cbObj)
	return self.viewContainer:sendGet101BonusRequest(self:_getSelectedDay(), cb, cbObj)
end

function V4a0_SixStarGiftImpl:_isType101RewardCouldGet()
	return self.viewContainer:isType101RewardCouldGet(self:_getSelectedDay())
end

function V4a0_SixStarGiftImpl:_isType101RewardGet()
	return self.viewContainer:isType101RewardGet(self:_getSelectedDay())
end

function V4a0_SixStarGiftImpl:_isDayOpen()
	return self.viewContainer:isDayOpen(self:_getSelectedDay())
end

function V4a0_SixStarGiftImpl:_btncheckOnClick()
	return
end

function V4a0_SixStarGiftImpl:_btnclaimOnClick()
	return
end

function V4a0_SixStarGiftImpl:_btnbuyOnClick()
	local lua_store_charge_goods_id = self.viewContainer:getSixStarGiftStoreChargeId()

	PayController.instance:startPay(lua_store_charge_goods_id)
end

function V4a0_SixStarGiftImpl:_btnGotoOnClick()
	local jumpId = self.viewContainer:getJumpId()

	if GameFacade.jump(jumpId) then
		-- block empty
	end
end

function V4a0_SixStarGiftImpl:_btntipOnClick()
	local _, actId2 = self.viewContainer:_actId()

	SummonSimulationPickController.instance:openSummonTips(actId2)
end

function V4a0_SixStarGiftImpl:_onClaimCb()
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")

	self._frameTimer = FrameTimerController.instance:register(function()
		if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.RoomBlockPackageGetView) then
			FrameTimerController.onDestroyViewMember(self, "_frameTimer")
			self:_playAnim_hasget()
		end
	end, nil, 6, 6)

	self._frameTimer:Start()
end

function V4a0_SixStarGiftImpl:_playAnim_hasget()
	for _, item in ipairs(self._rewardItemList or {}) do
		item:playAnim_hasget()
	end
end

function V4a0_SixStarGiftImpl:_btnCloseOnClick()
	self:closeThis()
end

function V4a0_SixStarGiftImpl:_btncloseOnClick()
	self:closeThis()
end

function V4a0_SixStarGiftImpl:_onRefreshNorSignActivity()
	self:_refreshRewardList()
end

function V4a0_SixStarGiftImpl:_onPayFinished()
	self:_setActive_gohasbuy(true)
end

function V4a0_SixStarGiftImpl:_refresh()
	self:_refreshRewardList()
	self:_setActive_gohasbuy(self.viewContainer:isSoldOut())
end

function V4a0_SixStarGiftImpl:onUpdateParam()
	self:_refresh()
	self:_refreshTimeTick()
end

function V4a0_SixStarGiftImpl:onOpen()
	self._txtLimitTime.text = ""

	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)

	if self.viewParam.parent then
		gohelper.addChild(self.viewParam.parent, self.viewGO)
	end

	self:onUpdateParam()
	self:_refreshItemList()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)
	PayController.instance:registerCallback(PayEvent.PayFinished, self._onPayFinished, self)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function V4a0_SixStarGiftImpl:onClose()
	PayController.instance:unregisterCallback(PayEvent.PayFinished, self._onPayFinished, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V4a0_SixStarGiftImpl:onDestroyView()
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	GameUtil.onDestroyViewMemberList(self, "_rewardItemList")
	GameUtil.onDestroyViewMemberList(self, "_itemList")
end

function V4a0_SixStarGiftImpl:_refreshItemList()
	local itemIdList = self.viewContainer:getPreviewItemIdList()
	local maxCount = #itemIdList

	for i = 1, maxCount do
		local item = self._itemList[i]

		if not item then
			if isDebugBuild then
				logError("present item count out of range! index:" .. i)
			end

			break
		end

		local mo = itemIdList[i]

		item:onUpdateMO(mo)
		item:setActive(true)
	end

	for i = maxCount + 1, #self._itemList do
		local item = self._itemList[i]

		item:setActive(false)
	end
end

function V4a0_SixStarGiftImpl:_refreshRewardList(day)
	day = day or self:_getSelectedDay()

	local dayBonusList = self.viewContainer:getDayBonusList(day)
	local maxCount = #dayBonusList

	for i = 1, maxCount do
		local item = self._rewardItemList[i]
		local itemCO = dayBonusList[i]

		if not item then
			if isDebugBuild then
				logError("reward item count out of range! index:" .. i)
			end

			break
		end

		item:onUpdateMO(itemCO)
		item:setActive(true)
	end

	for i = maxCount + 1, #self._rewardItemList do
		local item = self._rewardItemList[i]

		item:setActive(false)
	end
end

function V4a0_SixStarGiftImpl:_refreshTimeTick()
	self._txtLimitTime.text = self.viewContainer:getRemainTimeStr()
end

function V4a0_SixStarGiftImpl:_create_V4a0_SixStarGiftItem(srcGo, index)
	local item = V4a0_SixStarGiftItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(srcGo)

	return item
end

function V4a0_SixStarGiftImpl:_create_V4a0_SixStarGiftRewardItem(srcGo, index)
	local item = V4a0_SixStarGiftRewardItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(srcGo)

	return item
end

function V4a0_SixStarGiftImpl:onPresentBtnClick(item)
	local mo = item._mo
	local itemType = mo[1]
	local itemId = mo[2]

	MaterialTipController.instance:showMaterialInfo(itemType, itemId)
end

function V4a0_SixStarGiftImpl:onRewardItemClick(item)
	local mo = item._mo

	if not mo then
		return
	end

	local isClaimable = self:_isType101RewardCouldGet()

	if isClaimable then
		self._sendGet101BonusRequest(self, self._onClaimCb, self)

		return
	end

	local itemType = mo[1]
	local itemId = mo[2]

	MaterialTipController.instance:showMaterialInfo(itemType, itemId)
end

function V4a0_SixStarGiftImpl:_setActive_gohasbuy(bActive)
	gohelper.setActive(self._gohasbuy, bActive)
	gohelper.setActive(self._btnbuy, not bActive)
end

function V4a0_SixStarGiftImpl:_editableInitView()
	local lua_store_charge_goods_id = self.viewContainer:getSixStarGiftStoreChargeId()

	self._txt_get = gohelper.findChildText(self.viewGO, "Root/Right/Btn/#btn_buy/txt_get")
	self._txt_get.text = PayModel.instance:getProductPrice(lua_store_charge_goods_id)

	self:_setActive_gohasbuy(false)
	self:_editableInitView_itemList()
	self:_editableInitView_rewardItemList()
end

function V4a0_SixStarGiftImpl:_editableInitView_itemList()
	self._itemList = {}

	local i = 1

	repeat
		local go = gohelper.findChild(self.viewGO, string.format("Root/reward%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:_create_V4a0_SixStarGiftItem(go, i)

			table.insert(self._itemList, item)
		end

		i = i + 1
	until isNil
end

function V4a0_SixStarGiftImpl:_editableInitView_rewardItemList()
	local i = 1

	repeat
		local go = gohelper.findChild(self.viewGO, string.format("Root/Right/#go_reward%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:_create_V4a0_SixStarGiftRewardItem(go, i)

			table.insert(self._rewardItemList, item)
		elseif i == 1 then
			local go = gohelper.findChild(self.viewGO, string.format("Root/Right/#go_reward"))
			local item = self:_create_V4a0_SixStarGiftRewardItem(go, i)

			table.insert(self._rewardItemList, item)
		end

		i = i + 1
	until isNil
end

return V4a0_SixStarGiftImpl
