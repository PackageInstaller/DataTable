-- chunkname: @modules/logic/versionactivity3_7/skingift/view/V3a7_SkinGiftFullView.lua

module("modules.logic.versionactivity3_7.skingift.view.V3a7_SkinGiftFullView", package.seeall)

local V3a7_SkinGiftFullView = class("V3a7_SkinGiftFullView", BaseView)

function V3a7_SkinGiftFullView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_FullBG")
	self._simagedec = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_dec")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "Root/reward/#btn_reward")
	self._txtname01 = gohelper.findChildText(self.viewGO, "Root/reward/simage_titlebg01/#txt_name01")
	self._btntitle01 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/reward/simage_titlebg01/#btn_title01")
	self._txtname02 = gohelper.findChildText(self.viewGO, "Root/reward/simage_titlebg02/#txt_name02")
	self._btntitle02 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/reward/simage_titlebg02/#btn_title02")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "Root/right/go_reward/#simage_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "Root/right/go_reward/txtbg/#txt_num")
	self._goclaim = gohelper.findChild(self.viewGO, "Root/right/go_reward/#go_claim")
	self._btnclaim = gohelper.findChildButtonWithAudio(self.viewGO, "Root/right/go_reward/#go_claim/#btn_claim")
	self._gohasget = gohelper.findChild(self.viewGO, "Root/right/go_reward/#go_hasget")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "Root/right/Btn/#btn_buy")
	self._txtget = gohelper.findChildText(self.viewGO, "Root/right/Btn/#btn_buy/#txt_get")
	self._gohasbuy = gohelper.findChild(self.viewGO, "Root/right/Btn/#go_hasbuy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_SkinGiftFullView:addEvents()
	self.addEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self.refreshPackageInfo, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.refreshRewardState, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btntitle01:AddClickListener(self._btntitle01OnClick, self)
	self._btntitle02:AddClickListener(self._btntitle02OnClick, self)
	self._btnclaim:AddClickListener(self._btnclaimOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function V3a7_SkinGiftFullView:removeEvents()
	self.removeEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self.refreshPackageInfo, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.refreshRewardState, self)
	self._btnreward:RemoveClickListener()
	self._btntitle01:RemoveClickListener()
	self._btntitle02:RemoveClickListener()
	self._btnclaim:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
end

function V3a7_SkinGiftFullView:_btnrewardOnClick()
	local packageConfig = StoreConfig.instance:getChargeGoodsConfig(self.packageId)

	if not packageConfig or string.nilorempty(packageConfig.product) then
		return
	end

	local product = GameUtil.splitString2(packageConfig.product, true)
	local firstProduct = product[V3a7_SkinGiftEnum.RewardIndex]

	if not firstProduct then
		return
	end

	MaterialTipController.instance:showMaterialInfo(firstProduct[1], firstProduct[2])
end

function V3a7_SkinGiftFullView:_btntitle01OnClick()
	self:showRareInfo()
end

function V3a7_SkinGiftFullView:_btntitle02OnClick()
	self:showRareInfo()
end

function V3a7_SkinGiftFullView:showRareInfo()
	local param = {}

	param.itemId = self.itemId
	param.type = MaterialEnum.MaterialType.Item

	ViewMgr.instance:openView(ViewName.V3a7_SkinGiftCheckView, param)
end

function V3a7_SkinGiftFullView:_btnclaimOnClick()
	local state = ActivityType101Model.instance:getType101InfoState(self.actId, V3a7_SkinGiftEnum.RewardIndex)
	local canGet = state == ActivityEnum.Act101RewardState.Available

	if not canGet then
		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(self.actId, V3a7_SkinGiftEnum.RewardIndex)
end

function V3a7_SkinGiftFullView:_btnbuyOnClick()
	if not self.actId then
		return
	end

	if not ActivityModel.instance:isActOnLine(self.actId) then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	local packageConfig = StoreConfig.instance:getChargeGoodsConfig(self.packageId)

	if not packageConfig then
		return
	end

	local packageMo = StoreModel.instance:getGoodsMO(packageConfig.id)
	local isSoldOut = true

	if not packageMo then
		logNormal("3.7 随机皮肤礼包 缺少礼包数据 id: " .. tostring(packageConfig.id))

		return
	else
		isSoldOut = packageMo:isSoldOut()
	end

	if isSoldOut then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
	PayController.instance:startPay(self.packageId)
end

function V3a7_SkinGiftFullView:_editableInitView()
	return
end

function V3a7_SkinGiftFullView:onUpdateParam()
	return
end

function V3a7_SkinGiftFullView:onOpen()
	self:checkParam()
	self:refreshUI()
	self:setRefreshTimeTask()
end

function V3a7_SkinGiftFullView:checkParam()
	if not self.viewParam or self.viewParam.actId == nil then
		logError("3.7随机皮肤活动 缺少活动参数")

		return
	end

	local parentGo = self.viewParam.parent

	if not gohelper.isNil(parentGo) then
		gohelper.setParent(self.viewGO, parentGo)
	end

	if self.viewParam.actId == nil then
		logError("3.7随机皮肤活动 缺少活动参数")

		return
	end

	self.actId = self.viewParam.actId
	self.packageId = V3a7_SkinGiftEnum.PackageId
	self.itemId = V3a7_SkinGiftEnum.ItemId
end

function V3a7_SkinGiftFullView:refreshUI()
	self:refreshReward()
	self:refreshRewardState()
	self:refreshPackageInfo()
end

function V3a7_SkinGiftFullView:setRefreshTimeTask()
	if not self.packageId then
		return
	end

	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, 1)
end

function V3a7_SkinGiftFullView:refreshTime()
	if not self.actId then
		self._txtLimitTime.text = luaLang("ended")

		return
	end

	if not ActivityModel.instance:isActOnLine(self.actId) then
		self._txtLimitTime.text = luaLang("ended")

		return
	end

	local endTime = ActivityModel.instance:getActEndTime(self.actId) / TimeUtil.OneSecondMilliSecond
	local nowTime = ServerTime.now()

	self._txtLimitTime.text = endTime <= nowTime and luaLang("ended") or TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)
end

function V3a7_SkinGiftFullView:refreshReward()
	local rewardConfig = ActivityType101Config.instance:getDayCO(self.actId, V3a7_SkinGiftEnum.RewardIndex)
	local param = GameUtil.splitString2(rewardConfig.bonus, true)
	local showReward = param[V3a7_SkinGiftEnum.RewardIndex]
	local type = showReward[1]
	local itemId = showReward[2]
	local num = showReward[3]
	local _, icon = ItemModel.instance:getItemConfigAndIcon(type, itemId, true)

	self._simageicon:LoadImage(icon)

	self._txtnum.text = string.format("x%s", tostring(num))
end

function V3a7_SkinGiftFullView:refreshRewardState()
	local state = ActivityType101Model.instance:getType101InfoState(self.actId, V3a7_SkinGiftEnum.RewardIndex)
	local isGet = state == ActivityEnum.Act101RewardState.Received
	local canGet = state == ActivityEnum.Act101RewardState.Available

	gohelper.setActive(self._gohasget, isGet)
	gohelper.setActive(self._goclaim, canGet)
end

function V3a7_SkinGiftFullView:refreshPackageInfo()
	local packageConfig = StoreConfig.instance:getChargeGoodsConfig(self.packageId)

	if not packageConfig then
		return
	end

	local packageMo = StoreModel.instance:getGoodsMO(packageConfig.id)
	local isSoldOut = true

	if not packageMo then
		logNormal("3.7 随机皮肤礼包 缺少礼包数据 id: " .. tostring(packageConfig.id))
	else
		isSoldOut = packageMo:isSoldOut()
	end

	gohelper.setActive(self._gohasbuy, isSoldOut)
	gohelper.setActive(self._btnbuy, not isSoldOut)

	self._txtget.text = PayModel.instance:getProductPriceScaledSymbol(packageConfig.id, 31)
end

function V3a7_SkinGiftFullView:onClose()
	return
end

function V3a7_SkinGiftFullView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

return V3a7_SkinGiftFullView
