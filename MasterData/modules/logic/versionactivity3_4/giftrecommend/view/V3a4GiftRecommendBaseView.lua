-- chunkname: @modules/logic/versionactivity3_4/giftrecommend/view/V3a4GiftRecommendBaseView.lua

module("modules.logic.versionactivity3_4.giftrecommend.view.V3a4GiftRecommendBaseView", package.seeall)

local V3a4GiftRecommendBaseView = class("V3a4GiftRecommendBaseView", BaseView)

function V3a4GiftRecommendBaseView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "root/timebg/#txt_time")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_check")
end

function V3a4GiftRecommendBaseView:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self._btnframe:AddClickListener(self.btnframeOnClick, self)
	self._btnbackground:AddClickListener(self.btnbackgroundOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.refreshView, self)
end

function V3a4GiftRecommendBaseView:removeEvents()
	self._btncheck:RemoveClickListener()
	self._btnframe:RemoveClickListener()
	self._btnbackground:RemoveClickListener()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.refreshView, self)
end

function V3a4GiftRecommendBaseView:btnbackgroundOnClick()
	local sceneCo = self:_getSceneGoodsSwitchCO(self._goodsIds[2])
	local sceneSkinId = sceneCo.id

	ViewMgr.instance:openView(ViewName.MainSceneSwitchInfoView, {
		isPreview = true,
		noInfoEffect = true,
		sceneSkinId = sceneSkinId
	})
end

function V3a4GiftRecommendBaseView:btnframeOnClick()
	local UICo = self:_getUIGoodsSwitchCO(self._goodsIds[3])
	local uiSkinId = UICo.id

	MainUISwitchController.instance:openMainUISwitchInfoView(uiSkinId, true, false, true)
end

function V3a4GiftRecommendBaseView:_btncheckOnClick()
	local sceneId, uiId = self:getSceneUI()

	MainUISwitchController.instance:openMainUISwitchInfoViewGiftSet(uiId, sceneId, false)
end

function V3a4GiftRecommendBaseView:_btnRewardOnClick(index)
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, index)

	if couldGet then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, index)
	end
end

function V3a4GiftRecommendBaseView:_editableInitView()
	self._rewardItem = self:getUserDataTb_()

	for i = 1, V3a4GiftRecommendEnum.SignCount do
		local go = gohelper.findChild(self.viewGO, "root/reward" .. i)
		local item = self:getUserDataTb_()

		item.go = go
		item.icon = gohelper.findChildSingleImage(go, "#image_icon")
		item.gocanget = gohelper.findChild(go, "go_canget")
		item.goreceive = gohelper.findChild(go, "go_receive")
		item.gotomorrow = gohelper.findChild(go, "go_tomorrow")
		item.btnClick = gohelper.findChildButtonWithAudio(go, "#btn_click")

		item.btnClick:AddClickListener(self._btnRewardOnClick, self, i)

		self._rewardItem[i] = item
	end

	self._btnframe = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_frame")
	self._btnbackground = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_background")
	self._goframereceive = gohelper.findChild(self.viewGO, "root/go_frame/go_receive")
	self._gobackgroundreceive = gohelper.findChild(self.viewGO, "root/go_background/go_receive")
	self._goodsIds = DecorateStoreModel.instance:getV3a4PackageStoreGoodsIds()
end

function V3a4GiftRecommendBaseView:_getSceneGoodsSwitchCO(goodsId)
	local goodsConfig = goodsId and lua_store_goods.configDict[goodsId]
	local product = goodsConfig and goodsConfig.product

	if not product then
		return nil
	end

	for i, v in ipairs(lua_scene_switch.configList) do
		if string.find(product, v.itemId) then
			return v
		end
	end

	return lua_scene_switch.configDict[5]
end

function V3a4GiftRecommendBaseView:_getUIGoodsSwitchCO(goodsId)
	local goodsConfig = goodsId and lua_store_goods.configDict[goodsId]
	local product = goodsConfig and goodsConfig.product

	if not product then
		return nil
	end

	for i, v in ipairs(lua_scene_ui.configList) do
		if string.find(product, v.itemId) then
			return v
		end
	end

	return lua_scene_ui.configDict[2]
end

function V3a4GiftRecommendBaseView:refreshReceive()
	local hasScene = DecorateStoreModel.instance:isDecorateGoodItemHas(self._goodsIds[2])
	local hasUI = DecorateStoreModel.instance:isDecorateGoodItemHas(self._goodsIds[3])

	gohelper.setActive(self._goframereceive, hasUI)
	gohelper.setActive(self._gobackgroundreceive, hasScene)
end

function V3a4GiftRecommendBaseView:onOpen()
	if self.viewParam then
		self._actId = self.viewParam.actId or ActivityEnum.Activity.V3a4_GiftRecommend
	end

	self._txttime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)

	Activity101Rpc.instance:sendGet101InfosRequest(self._actId)
end

function V3a4GiftRecommendBaseView:refreshView()
	self:refreshSignReward()
	self:refreshReceive()
end

function V3a4GiftRecommendBaseView:refreshSignReward()
	for i, item in ipairs(self._rewardItem) do
		local rewardGet = ActivityType101Model.instance:isType101RewardGet(self._actId, i)
		local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, i)
		local totalday = ActivityType101Model.instance:getType101LoginCount(self._actId)

		gohelper.setActive(item.gocanget, couldGet)
		gohelper.setActive(item.goreceive, rewardGet)
		gohelper.setActive(item.gotomorrow, totalday + 1 == i)

		local co = ActivityConfig.instance:getNorSignActivityCo(self._actId, i)

		if co and not string.nilorempty(co.bonus) then
			local bonus = string.splitToNumber(co.bonus, "#")
			local _, icon = ItemModel.instance:getItemConfigAndIcon(bonus[1], bonus[2])

			item.icon:LoadImage(icon)
		end
	end
end

function V3a4GiftRecommendBaseView:getSceneUI()
	local sceneId, uiId
	local goodsId = self._goodsIds[1]
	local storeGoodsCo = StoreConfig.instance:getGoodsConfig(goodsId)
	local productArr = GameUtil.splitString2(storeGoodsCo.product, true, "|", "#")

	for _, arr in ipairs(productArr) do
		local itemConfig = ItemModel.instance:getItemConfig(arr[1], arr[2])

		if itemConfig.subType == ItemEnum.SubType.MainUISkin then
			local co = MainUISwitchConfig.instance:getUISwitchCoByItemId(arr[2])

			uiId = co.id
		elseif itemConfig.subType == ItemEnum.SubType.MainSceneSkin then
			local co = MainSceneSwitchConfig.instance:getConfigByItemId(arr[2])

			sceneId = co.id
		end
	end

	return sceneId, uiId
end

function V3a4GiftRecommendBaseView:onClose()
	return
end

function V3a4GiftRecommendBaseView:onDestroyView()
	for i, item in ipairs(self._rewardItem) do
		item.btnClick:RemoveClickListener()
		item.icon:UnLoadImage()
	end
end

return V3a4GiftRecommendBaseView
