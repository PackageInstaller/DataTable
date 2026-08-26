-- chunkname: @modules/logic/room/view/trade/RoomDailyOrderItem.lua

module("modules.logic.room.view.trade.RoomDailyOrderItem", package.seeall)

local RoomDailyOrderItem = class("RoomDailyOrderItem", LuaCompBase)

function RoomDailyOrderItem:onInitView()
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#simage_normalbg")
	self._simagespecialbg = gohelper.findChildSingleImage(self.viewGO, "#simage_specialbg")
	self._simageheadicon = gohelper.findChildSingleImage(self.viewGO, "customer/#simage_headicon")
	self._txtcustomername = gohelper.findChildText(self.viewGO, "customer/#txt_customername")
	self._btnrefresh = gohelper.findChildButtonWithAudio(self.viewGO, "refresh/#btn_refresh")
	self._gocanrefresh = gohelper.findChild(self.viewGO, "refresh/#btn_refresh/#go_refresh")
	self._golockrefresh = gohelper.findChild(self.viewGO, "refresh/#btn_refresh/#go_lock")
	self._gotime = gohelper.findChild(self.viewGO, "refresh/#go_time")
	self._txttime = gohelper.findChildText(self.viewGO, "refresh/#go_time/#txt_time")
	self._gostuffitem = gohelper.findChild(self.viewGO, "stuff/#go_stuffitem")
	self._gomaterial = gohelper.findChild(self.viewGO, "stuff/#go_material")
	self._simagerewardicon = gohelper.findChildSingleImage(self.viewGO, "reward/#simage_rewardicon")
	self._txtrewardcount = gohelper.findChildText(self.viewGO, "reward/#txt_rewardcount")
	self._gotips = gohelper.findChild(self.viewGO, "reward/#go_tips")
	self._txtnum = gohelper.findChildText(self.viewGO, "reward/#go_tips/#txt_num")
	self._btnlocked = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_lock")
	self._golocked = gohelper.findChild(self.viewGO, "#btn_lock/#go_locked")
	self._gounlocked = gohelper.findChild(self.viewGO, "#btn_lock/#go_unlocked")
	self._gounselect = gohelper.findChild(self.viewGO, "btn/traced/#go_unselect")
	self._gounselecticon = gohelper.findChild(self.viewGO, "btn/traced/#go_unselect/icon")
	self._goselect = gohelper.findChild(self.viewGO, "btn/traced/#go_select")
	self._btntraced = gohelper.findChildButtonWithAudio(self.viewGO, "btn/traced/#btn_traced")
	self._btnunconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_unconfirm")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_confirm")
	self._btnwrongjump = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_wrongjump")
	self._txtwrongtip = gohelper.findChildText(self.viewGO, "btn/#btn_wrongjump/#txt_wrong")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomDailyOrderItem:addEvents()
	self._btnrefresh:AddClickListener(self._btnrefreshOnClick, self)
	self._btntraced:AddClickListener(self._btntracedOnClick, self)
	self._btnlocked:AddClickListener(self._btnlockedOnClick, self)
	self._btnunconfirm:AddClickListener(self._btnunconfirmOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnwrongjump:AddClickListener(self._btnwrongjumpOnClick, self)
end

function RoomDailyOrderItem:removeEvents()
	self._btnrefresh:RemoveClickListener()
	self._btntraced:RemoveClickListener()
	self._btnlocked:RemoveClickListener()
	self._btnunconfirm:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btnwrongjump:RemoveClickListener()
end

function RoomDailyOrderItem:_btntracedOnClick()
	if not self._mo then
		return
	end

	if self.isWrong then
		GameFacade.showToast(ToastEnum.RoomOrderTracedWrong)
	else
		local isTraced = not self._mo.isTraced

		RoomTradeController.instance:tracedDailyOrder(self._mo.orderId, isTraced)

		if isTraced then
			GameFacade.showToast(ToastEnum.RoomOrderTraced)
		else
			GameFacade.showToast(ToastEnum.RoomOrderNotTraced)
		end
	end
end

function RoomDailyOrderItem:_btnlockedOnClick()
	if not self._mo then
		return
	end

	local isLocked = not self._mo:getLocked()

	RoomTradeController.instance:lockedDailyOrder(self._mo.orderId, isLocked)

	if isLocked then
		GameFacade.showToast(ToastEnum.RoomOrderLocked)
	else
		GameFacade.showToast(ToastEnum.RoomOrderUnlocked)
	end
end

function RoomDailyOrderItem:_btnrefreshOnClick()
	if not self._mo or self:isHasRefreshTime() then
		return
	end

	if self._mo:getLocked() then
		GameFacade.showToast(ToastEnum.RoomOrderLockedWrong)

		return
	end

	if not RoomTradeModel.instance:isCanRefreshDailyOrder() then
		GameFacade.showToast(ToastEnum.RoomDailyOrderRefreshLimit)

		return
	end

	self._mo:setWaitRefresh(true)

	local guideId = GuideModel.instance:getLockGuideId()

	if guideId == GuideEnum.GuideId.RoomDailyOrder then
		local guideMO = GuideModel.instance:getById(guideId)
		local curStep = guideMO.currStepId

		RoomTradeController.instance:refreshDailyOrder(self._mo.orderId, guideId, curStep)
	else
		RoomTradeController.instance:refreshDailyOrder(self._mo.orderId)
	end
end

function RoomDailyOrderItem:_btnunconfirmOnClick()
	GameFacade.showToast(ToastEnum.RoomOrderNotCommit)
end

function RoomDailyOrderItem:_btnconfirmOnClick()
	if not self._mo then
		return
	end

	RoomTradeController.instance:finishDailyOrder(RoomTradeEnum.Mode.DailyOrder, self._mo.orderId)
end

function RoomDailyOrderItem:_btnwrongjumpOnClick()
	if not self.isWrong then
		return
	end

	if self.wrongBuildingUid then
		ManufactureController.instance:jumpToManufactureBuildingLevelUpView(self.wrongBuildingUid)
	else
		ManufactureController.instance:jump2PlaceManufactureBuildingView()
	end
end

function RoomDailyOrderItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function RoomDailyOrderItem:addEventListeners()
	self:addEvents()
end

function RoomDailyOrderItem:removeEventListeners()
	self:removeEvents()
	TaskDispatcher.cancelTask(self.showItem, self)
	TaskDispatcher.cancelTask(self._reallyPlayOpenAnim, self)
end

function RoomDailyOrderItem:_editableInitView()
	self._imgconfirm = gohelper.findChildImage(self.viewGO, "btn/#btn_confirm")
	self._gorefresh = gohelper.findChild(self.viewGO, "refresh")

	gohelper.setActive(self._gostuffitem, false)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function RoomDailyOrderItem:onDestroy()
	self._simageheadicon:UnLoadImage()
	self._simagerewardicon:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTimeCB, self)
end

local refreshTime = 0.16

function RoomDailyOrderItem:onUpdateMo(mo)
	self._mo = mo
	self.isWrong = false
	self.wrongBuildingUid = nil
	self.refreshTime = self._mo:getRefreshTime()

	if mo.isFinish then
		self:playFinishAnim()
	elseif mo.isNewRefresh or mo:isWaitRefresh() then
		self:playRefreshAnim()
		TaskDispatcher.cancelTask(self.showItem, self)
		TaskDispatcher.runDelay(self.showItem, self, refreshTime)
		mo:cancelNewRefresh()
	else
		self:showItem()
	end
end

function RoomDailyOrderItem:showItem()
	local buyerId = self._mo.buyerId
	local heroConfig = HeroConfig.instance:getHeroCO(buyerId)
	local skinId = heroConfig.skinId
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)

	self._simageheadicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))

	self._txtcustomername.text = heroConfig.name

	self:setPrice()
	self:onRefresh()

	local langpriceratio = luaLang("room_wholesaleorder_priceratio")

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLangOneParam(langpriceratio, self._mo:getAdvancedRate() * 100)

	gohelper.setActive(self._simagenormalbg.gameObject, not self._mo.isAdvanced)
	gohelper.setActive(self._simagespecialbg.gameObject, self._mo.isAdvanced)
	gohelper.setActive(self._gotips.gameObject, self._mo.isAdvanced)

	local btnIcon = self._mo.isAdvanced and "room_trade_btn_spsubmit" or "room_trade_btn_submit"

	UISpriteSetMgr.instance:setRoomSprite(self._imgconfirm, btnIcon)
	gohelper.setActive(self.viewGO, true)
end

function RoomDailyOrderItem:onRefresh()
	if not self._mo then
		return
	end

	self:onRefreshMaterials()
	self:refreshConfirmBtn()
	self:refreshTraced()
	self:refreshLocked()
	self:checkRefreshTime()
end

function RoomDailyOrderItem:setPrice()
	local price = string.split(self._mo:getPrice(), "#")
	local type, id, quantity = price[1], price[2], price[3]
	local _, icon = ItemModel.instance:getItemConfigAndIcon(type, id)

	self._simagerewardicon:LoadImage(icon)

	self._txtrewardcount.text = self._mo:getPriceCount()

	self._txtrewardcount:SetLayoutDirty()
end

function RoomDailyOrderItem:getMaterialItem(index)
	self._materialItem = self._materialItem or self:getUserDataTb_()

	local item = self._materialItem[index]

	if not item then
		item = {}

		local obj = gohelper.clone(self._gostuffitem, self._gomaterial)

		item.go = obj
		item.icon = gohelper.findChild(obj, "icon")
		item.txt = gohelper.findChildText(obj, "count")
		item.itemIcon = IconMgr.instance:getCommonItemIcon(item.icon)
		item.goWrong = gohelper.findChild(obj, "#go_wrong")
		self._materialItem[index] = item
	end

	return item
end

function RoomDailyOrderItem:onRefreshMaterials()
	if not self._mo then
		return
	end

	local moList = self._mo.goodsInfo

	for i, mo in ipairs(moList) do
		local item = self:getMaterialItem(i)

		transformhelper.setLocalScale(item.itemIcon.go.transform, 0.5, 0.5, 1)

		local type, id, quantity = mo:getItem()

		item.itemIcon:setMOValue(type, id, quantity, nil, true)
		item.itemIcon:isShowQuality(false)
		item.itemIcon:isShowCount(false)

		item.txt.text = mo:getQuantityStr()

		local isEnoughCount = mo:isEnoughCount()

		gohelper.setActive(item.goWrong, (not isEnoughCount or nil) and (not mo:isPlacedProduceBuilding() or mo:checkProduceBuildingLevel()))
	end

	if self._materialItem then
		for i = 1, #self._materialItem do
			gohelper.setActive(self._materialItem[i].go, i <= #moList)
		end
	end
end

function RoomDailyOrderItem:refreshConfirmBtn()
	local wrongTip, wrongBuildingUid = self._mo:checkGoodsCanProduct()

	self.isWrong = not string.nilorempty(wrongTip)
	self.wrongBuildingUid = wrongBuildingUid

	local isCanConfirm = self._mo:isCanConfirm()

	if not isCanConfirm and self.isWrong then
		gohelper.setActive(self._btnunconfirm.gameObject, false)
		gohelper.setActive(self._btnconfirm.gameObject, false)

		self._txtwrongtip.text = wrongTip

		gohelper.setActive(self._btnwrongjump.gameObject, true)
	else
		gohelper.setActive(self._btnunconfirm.gameObject, not isCanConfirm)
		gohelper.setActive(self._btnconfirm.gameObject, isCanConfirm)
		gohelper.setActive(self._btnwrongjump.gameObject, false)
	end
end

function RoomDailyOrderItem:refreshTraced()
	local goUnTraced = self._gounselect
	local goTraced = self._goselect

	if self.isWrong then
		gohelper.setActive(goUnTraced, true)
		gohelper.setActive(goTraced, false)
		ZProj.UGUIHelper.SetGrayscale(self._gounselecticon, true)
	else
		local isTraced = self._mo.isTraced

		gohelper.setActive(goUnTraced, not isTraced)
		gohelper.setActive(goTraced, isTraced)
		ZProj.UGUIHelper.SetGrayscale(self._gounselecticon, false)
	end
end

function RoomDailyOrderItem:refreshLocked()
	local isLocked = self._mo:getLocked()

	gohelper.setActive(self._golocked, isLocked)
	gohelper.setActive(self._gounlocked, not isLocked)

	if isLocked then
		gohelper.setActive(self._gotime, false)
	else
		self:checkRefreshTime()
	end

	gohelper.setActive(self._gocanrefresh, not isLocked)
	gohelper.setActive(self._golockrefresh, isLocked)
end

function RoomDailyOrderItem:_refreshTimeCB()
	if not self:isHasRefreshTime() then
		if self._mo:getRefreshTime() <= 0 then
			TaskDispatcher.cancelTask(self._refreshTimeCB, self)
			gohelper.setActive(self._gotime, false)

			self.refreshTime = 0

			return
		else
			self.refreshTime = 0
		end
	else
		self.refreshTime = self.refreshTime - 1
	end

	self:_updateTime()
end

function RoomDailyOrderItem:_updateTime()
	self._txttime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_dailyorder_refreshtime"), self.refreshTime)
end

function RoomDailyOrderItem:isHasRefreshTime()
	return self.refreshTime and self.refreshTime > 0
end

function RoomDailyOrderItem:checkRefreshTime()
	self.refreshTime = self._mo:getRefreshTime()

	local isHasRefreshTime = self:isHasRefreshTime()

	TaskDispatcher.cancelTask(self._refreshTimeCB, self)
	gohelper.setActive(self._gotime, isHasRefreshTime)

	if isHasRefreshTime then
		self:_updateTime()
		TaskDispatcher.runRepeat(self._refreshTimeCB, self, 1)
	end

	local isCanRefresh = RoomTradeModel.instance:isCanRefreshDailyOrder()

	gohelper.setActive(self._gorefresh, isCanRefresh)
end

function RoomDailyOrderItem:playOpenAnim(index)
	self._canvasGroup = self._canvasGroup or self.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._animator.enabled = false
	self._canvasGroup.alpha = 0

	TaskDispatcher.cancelTask(self._reallyPlayOpenAnim, self)
	TaskDispatcher.runDelay(self._reallyPlayOpenAnim, self, (index - 1) * 0.06)
end

function RoomDailyOrderItem:_reallyPlayOpenAnim()
	self._animator.enabled = true

	self._animator:Play(RoomTradeEnum.TradeDailyOrderAnim.Open, 0, 0)
end

function RoomDailyOrderItem:playRefreshAnim()
	self._animator.enabled = true

	self._animator:Play(RoomTradeEnum.TradeDailyOrderAnim.Update, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_order)
end

function RoomDailyOrderItem:playFinishAnim()
	self._animator.enabled = true

	self._animator:Play(RoomTradeEnum.TradeDailyOrderAnim.Delivery, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_order)
end

RoomDailyOrderItem.ResUrl = "ui/viewres/room/trade/roomdailyorderitem.prefab"

return RoomDailyOrderItem
