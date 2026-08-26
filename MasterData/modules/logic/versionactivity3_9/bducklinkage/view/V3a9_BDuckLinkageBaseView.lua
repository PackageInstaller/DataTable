-- chunkname: @modules/logic/versionactivity3_9/bducklinkage/view/V3a9_BDuckLinkageBaseView.lua

module("modules.logic.versionactivity3_9.bducklinkage.view.V3a9_BDuckLinkageBaseView", package.seeall)

local V3a9_BDuckLinkageBaseView = class("V3a9_BDuckLinkageBaseView", BaseView)

function V3a9_BDuckLinkageBaseView:onInitView()
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "root/Title/#btn_tips")
	self._txttime = gohelper.findChildText(self.viewGO, "root/Title/time/#txt_time")
	self._gotab1 = gohelper.findChild(self.viewGO, "root/Middle/switch/#go_tab1")
	self._gotab2 = gohelper.findChild(self.viewGO, "root/Middle/switch/#go_tab2")
	self._txtcost = gohelper.findChildText(self.viewGO, "root/Btn/#btn_buy/#txt_cost")
	self._gocostclick = gohelper.findChild(self.viewGO, "root/Btn/#btn_buy/#go_costclick")
	self._goowened = gohelper.findChild(self.viewGO, "root/Btn/#go_owned")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BDuckLinkageBaseView:addEvents()
	self._btntips:AddClickListener(self._btntipsOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.onNorSignActivityRefresh, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self.refreshPrice, self)
end

function V3a9_BDuckLinkageBaseView:removeEvents()
	self._btntips:RemoveClickListener()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.onNorSignActivityRefresh, self)
	self.removeEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self.refreshPrice, self)
end

function V3a9_BDuckLinkageBaseView:_btntipsOnClick()
	local title = CommonConfig.instance:getConstStr(ConstEnum.V3a9_BDuckLinkageTitle)
	local desc = CommonConfig.instance:getConstStr(ConstEnum.V3a9_BDuckLinkageDesc)

	HelpController.instance:openStoreTipView(desc, title)
end

function V3a9_BDuckLinkageBaseView:_editableInitView()
	self._rewardItemList = self:getUserDataTb_()
	self._tabList = self:getUserDataTb_()
	self._goPlayerCard = gohelper.findChild(self.viewGO, "root/Middle/playercard")
	self._goCardEffect = gohelper.findChild(self.viewGO, "root/Middle/cardEffect")
	self._govideo = gohelper.findChild(self.viewGO, "root/Middle/cardEffect/go_video")
	self._videoPlayer = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._govideo, nil, true, V3a7_BDuckLinkageEnum.VideoSize.Width, V3a7_BDuckLinkageEnum.VideoSize.Height)

	self:initTab()

	self._goGiftReward = gohelper.findChild(self.viewGO, "root/giftReward")
	self._chargeGoodsItem = gohelper.findChild(self.viewGO, "root/giftReward/go_rewarditem")

	gohelper.setActive(self._chargeGoodsItem, false)

	self._chargeGoodsRewardItems = self:getUserDataTb_()
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)

	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function V3a9_BDuckLinkageBaseView:initTab()
	local tabGoList = {
		self._gotab1,
		self._gotab2
	}

	for index, tabGo in ipairs(tabGoList) do
		local item = self:getUserDataTb_()

		item.itemGo = tabGo
		item.goSelect = gohelper.findChild(tabGo, "#go_select")
		item.btnClick = gohelper.findChildButtonWithAudio(tabGo, "#btn_tab")

		item.btnClick:AddClickListener(self.onTabClick, {
			target = self,
			index = index
		})

		self._tabList[index] = item
	end
end

function V3a9_BDuckLinkageBaseView.onTabClick(param)
	local target = param.target

	target:clickTab(param.index)
end

function V3a9_BDuckLinkageBaseView:clickTab(index, isOpen)
	if index ~= self.curTabIndex then
		self.curTabIndex = index
	end

	TaskDispatcher.cancelTask(self.onMoveNextTab, self)
	TaskDispatcher.cancelTask(self.onSwitchAnimPlayEnd, self)

	if isOpen then
		self:onSwitchAnimPlayEnd()
	else
		self:lockScreen(true)

		local animator = self._animator

		if animator.enabled == false then
			animator.enabled = true
		end

		self._animator:Play("switch", 0, 0)
		TaskDispatcher.runDelay(self.onSwitchAnimPlayEnd, self, V3a7_BDuckLinkageEnum.SwitchDelay)
	end
end

function V3a9_BDuckLinkageBaseView:onSwitchAnimPlayEnd()
	TaskDispatcher.cancelTask(self.onSwitchAnimPlayEnd, self)
	self:refreshTabSelect()
	self:switchContent(self.curTabIndex)
	self:lockScreen(false)
	TaskDispatcher.runDelay(self.onMoveNextTab, self, V3a7_BDuckLinkageEnum.MoveToNextTime)
end

function V3a9_BDuckLinkageBaseView:onMoveNextTab()
	local nextIndex = self.curTabIndex

	nextIndex = self.curTabIndex >= V3a7_BDuckLinkageEnum.ShowCount and V3a7_BDuckLinkageEnum.FirstShowIndex or nextIndex + 1

	self:clickTab(nextIndex)
end

function V3a9_BDuckLinkageBaseView:refreshTabSelect()
	for index, item in ipairs(self._tabList) do
		gohelper.setActive(item.goSelect, self.curTabIndex == index)
	end
end

function V3a9_BDuckLinkageBaseView:switchContent(index)
	local videoName = V3a7_BDuckLinkageEnum.VideoName[index]
	local showVideo = not string.nilorempty(videoName)

	gohelper.setActive(self._goCardEffect, showVideo)
	gohelper.setActive(self._goPlayerCard, not showVideo)

	if not showVideo then
		self._videoPlayer:pause()
	else
		self:lockScreen(true)
		self._videoPlayer:play(videoName, true, self._videoStatusUpdate, self)
	end
end

function V3a9_BDuckLinkageBaseView:lockScreen(isLock)
	if isLock then
		logNormal("锁屏")
		UIBlockMgr.instance:startBlock(self.viewName)
		TaskDispatcher.runDelay(self.onLockTimeForceEnd, self, V3a7_BDuckLinkageEnum.ForceEndLockScreenTime)
	else
		logNormal("不锁屏")
		UIBlockMgr.instance:endBlock(self.viewName)
		TaskDispatcher.cancelTask(self.onLockTimeForceEnd, self)
	end
end

function V3a9_BDuckLinkageBaseView:onLockTimeForceEnd()
	logError("锁屏超时,强制关闭锁屏")
	self:lockScreen(false)
end

function V3a9_BDuckLinkageBaseView:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.Started or status == VideoEnum.PlayerStatus.Unpaused then
		self:lockScreen(false)
	end
end

function V3a9_BDuckLinkageBaseView:checkParam()
	if self.viewParam then
		self.signActId = self.viewParam.actId

		local activityConfig = ActivityConfig.instance:getActivityCo(self.signActId)
		local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(tonumber(activityConfig.param))

		self._chargeGoodsRewardList = GameUtil.splitString2(chargeConfig.product, true)
		self.chargeConfig = chargeConfig
	end
end

function V3a9_BDuckLinkageBaseView:refreshTime()
	if not self.signActId then
		return
	end

	local actInfoMo = ActivityModel.instance:getActMO(self.signActId)

	if not actInfoMo then
		self._txttime.text = luaLang("ended")

		return
	end

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(self.signActId)

	if status ~= ActivityEnum.ActivityStatus.Normal and toastId then
		self._txttime.text = status == ActivityEnum.ActivityStatus.Expired and luaLang("ended") or luaLang("notOpen")
	else
		local nowTime = ServerTime.now()
		local offsetTime = actInfoMo.endTime / TimeUtil.OneSecondMilliSecond - nowTime

		self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetTime)
	end
end

function V3a9_BDuckLinkageBaseView:refreshPrice()
	local goodMo = StoreModel.instance:getGoodsMO(self.chargeConfig.id)
	local isSoldOut = goodMo and goodMo:isSoldOut()

	for index, rewardInfo in ipairs(self._chargeGoodsRewardList) do
		local item = self._chargeGoodsRewardItems[index]

		if not item then
			local itemGo = gohelper.clone(self._chargeGoodsItem, self._goGiftReward, "rewarditem_" .. tostring(index))

			item = self:initChargeGoodsRewardItem(itemGo, rewardInfo)
			self._chargeGoodsRewardItems[index] = item
		end

		gohelper.setActive(item.itemGo, true)
		self:refreshChargeGoodsState(item, isSoldOut)
	end
end

function V3a9_BDuckLinkageBaseView:refreshReward()
	if not self.signActId then
		return
	end

	local rewardInfoList = ActivityType101Model.instance:getType101Info(self.signActId)

	if not rewardInfoList or next(rewardInfoList) == nil then
		logError("V3a9_BDuckLinkageBaseView 签到奖励为空")

		return
	end

	for index, info in ipairs(rewardInfoList) do
		local item

		if not self._rewardItemList[index] then
			local itemGo = gohelper.findChild(self.viewGO, string.format("root/signReward/day_%s", tostring(index)))

			if not itemGo then
				break
			end

			item = self:initRewardItem(itemGo, info)

			table.insert(self._rewardItemList, item)
		else
			item = self._rewardItemList[index]
		end

		local preInfo = rewardInfoList[index - 1]

		self:refreshSingleRewardItem(item, info, preInfo)
	end
end

function V3a9_BDuckLinkageBaseView:refreshChargeGoodsReward()
	if not self._chargeGoodsRewardList or next(self._chargeGoodsRewardList) == nil then
		return
	end

	local goodMo = StoreModel.instance:getGoodsMO(self.chargeConfig.id)
	local isSoldOut = goodMo and goodMo:isSoldOut()

	for index, rewardInfo in ipairs(self._chargeGoodsRewardList) do
		local item = self._chargeGoodsRewardItems[index]

		if not item then
			local itemGo = gohelper.clone(self._chargeGoodsItem, self._goGiftReward, "rewarditem_" .. tostring(index))

			item = self:initChargeGoodsRewardItem(itemGo, rewardInfo)
			self._chargeGoodsRewardItems[index] = item
		end

		gohelper.setActive(item.itemGo, true)
		self:refreshSingleChargeGoodsRewardItem(item, rewardInfo)
		self:refreshChargeGoodsState(item, isSoldOut)
	end

	for i = #self._chargeGoodsRewardList + 1, #self._chargeGoodsRewardItems do
		gohelper.setActive(self._chargeGoodsRewardItems[i].itemGo, false)
	end
end

function V3a9_BDuckLinkageBaseView:refreshChargeGoodsState(item, isSoldOut)
	gohelper.setActive(item.goReceive, isSoldOut)
end

function V3a9_BDuckLinkageBaseView:initChargeGoodsRewardItem(itemGo, rewardInfo, index)
	local item = self:getUserDataTb_()

	item.itemGo = itemGo
	item.simage_icon = gohelper.findChildSingleImage(itemGo, "#simage_icon")
	item.txt_num = gohelper.findChildText(itemGo, "#txt_num")
	item.btn_check = gohelper.findChildButtonWithAudio(itemGo, "#btn_check")
	item.goReceive = gohelper.findChild(itemGo, "go_receive")

	item.btn_check:AddClickListener(self.onChargeGoodsRewardItemClick, {
		target = self,
		rewardInfo = rewardInfo
	})

	return item
end

function V3a9_BDuckLinkageBaseView:refreshSingleChargeGoodsRewardItem(item, rewardInfo, isSoldOut)
	local itemConfig, icon = ItemModel.instance:getItemConfigAndIcon(rewardInfo[1], rewardInfo[2], true)

	if not itemConfig then
		logError("V3a9_BDuckLinkageBaseView 不存在的道具id type:" .. tostring(rewardInfo[1]) .. " id: " .. tostring(rewardInfo[2]))

		return
	end

	if item.simage_icon then
		item.simage_icon:LoadImage(icon)
	end

	if item.txt_num then
		item.txt_num.text = "×" .. tostring(rewardInfo[3])
	end
end

function V3a9_BDuckLinkageBaseView.onChargeGoodsRewardItemClick(param)
	local target = param.target

	target:onChargeGoodsRewardClick(param.rewardInfo)
end

function V3a9_BDuckLinkageBaseView:onChargeGoodsRewardClick(rewardInfo)
	MaterialTipController.instance:showMaterialInfo(rewardInfo[1], rewardInfo[2])
end

function V3a9_BDuckLinkageBaseView:initRewardItem(itemGo, info)
	local item = self:getUserDataTb_()

	item.itemGo = itemGo
	item.goCanGet = gohelper.findChild(itemGo, "go_canget")
	item.goReceive = gohelper.findChild(itemGo, "go_receive") or gohelper.findChild(itemGo, "go_hasget")
	item.goTomorrow = gohelper.findChild(itemGo, "go_tomorrow")
	item.btnClick = gohelper.findChildButton(itemGo, "")

	item.btnClick:AddClickListener(self.onRewardItemOnClick, {
		target = self,
		id = info.id
	})

	item.go_icon = gohelper.findChild(itemGo, "#go_icon")
	item.simage_icon = gohelper.findChildSingleImage(itemGo, "#go_icon/#simage_icon")

	return item
end

function V3a9_BDuckLinkageBaseView:refreshSingleRewardItem(item, info, preInfo)
	local isUnlock = info.state == ActivityEnum.Act101RewardState.Available
	local isGet = info.state == ActivityEnum.Act101RewardState.Received

	if item.goCanGet then
		gohelper.setActive(item.goCanGet, isUnlock and not isGet)
	end

	if item.goReceive then
		gohelper.setActive(item.goReceive, isGet)
	end

	if item.goTomorrow then
		gohelper.setActive(item.goTomorrow, not isUnlock and not isGet and preInfo ~= nil and preInfo.state ~= ActivityEnum.Act101RewardState.None)
	end

	local config = ActivityType101Config.instance:getDayCO(self.signActId, info.id)

	if not config then
		return
	end

	local bonusParamStr = string.split(config.bonus, "|")[1]
	local bonusParam = string.split(bonusParamStr, "#")
	local itemConfig, icon = ItemModel.instance:getItemConfigAndIcon(bonusParam[1], bonusParam[2], true)

	if item.simage_icon then
		item.simage_icon:LoadImage(icon)
	end
end

function V3a9_BDuckLinkageBaseView.onRewardItemOnClick(param)
	local target = param.target

	target:onItemRewardClick(param.id)
end

function V3a9_BDuckLinkageBaseView:onItemRewardClick(id)
	local infos = ActivityType101Model.instance:getType101Info(self.signActId)

	if not infos then
		return
	end

	local info = infos[id]

	if not info or info.state ~= ActivityEnum.Act101RewardState.Available then
		local config = ActivityType101Config.instance:getDayCO(self.signActId, id)

		if not config then
			return
		end

		local bonusParamStr = string.split(config.bonus, "|")[1]
		local bonusParam = string.split(bonusParamStr, "#")

		MaterialTipController.instance:showMaterialInfo(bonusParam[1], bonusParam[2])

		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(self.signActId, id)
end

function V3a9_BDuckLinkageBaseView:onNorSignActivityRefresh()
	self:refreshReward()
end

function V3a9_BDuckLinkageBaseView:onUpdateParam()
	return
end

function V3a9_BDuckLinkageBaseView:onOpen()
	self:checkParam()
	self:refreshUI()
	self._animator:Play("open", 0, 0)
end

function V3a9_BDuckLinkageBaseView:refreshUI()
	self:refreshTime()
	self:refreshReward()
	self:refreshChargeGoodsReward()
	self:clickTab(V3a7_BDuckLinkageEnum.FirstShowIndex)
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneSecond)
end

function V3a9_BDuckLinkageBaseView:onClose()
	return
end

function V3a9_BDuckLinkageBaseView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTime, self)

	if self._tabList and next(self._tabList) then
		for _, item in ipairs(self._tabList) do
			if item.btnClick then
				item.btnClick:RemoveClickListener()
			end
		end
	end

	tabletool.clear(self._tabList)

	self._tabList = nil

	if self._rewardItemList and next(self._rewardItemList) then
		for _, item in ipairs(self._rewardItemList) do
			if item.btnClick then
				item.btnClick:RemoveClickListener()
			end

			if item.simage_icon then
				item.simage_icon:UnLoadImage()
			end
		end
	end

	tabletool.clear(self._rewardItemList)

	self._rewardItemList = nil

	if self._chargeGoodsRewardItems and next(self._chargeGoodsRewardItems) then
		for _, item in ipairs(self._chargeGoodsRewardItems) do
			if item.btn_check then
				item.btn_check:RemoveClickListener()
			end

			if item.simage_icon then
				item.simage_icon:UnLoadImage()
			end
		end
	end

	tabletool.clear(self._chargeGoodsRewardItems)

	self._chargeGoodsRewardItems = nil

	if self._videoPlayer then
		if not BootNativeUtil.isIOS() then
			self._videoPlayer:stop()
		end

		self._videoPlayer:clear()

		self._videoPlayer = nil
	end

	TaskDispatcher.cancelTask(self.onMoveNextTab, self)
	TaskDispatcher.cancelTask(self.onSwitchAnimPlayEnd, self)
end

return V3a9_BDuckLinkageBaseView
