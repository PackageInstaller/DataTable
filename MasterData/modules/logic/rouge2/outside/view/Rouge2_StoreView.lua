-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_StoreView.lua

module("modules.logic.rouge2.outside.view.Rouge2_StoreView", package.seeall)

local Rouge2_StoreView = class("Rouge2_StoreView", BaseView)

function Rouge2_StoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goRight = gohelper.findChild(self.viewGO, "Right")
	self._goFinalInfo = gohelper.findChild(self.viewGO, "Right/#go_FinalInfo")
	self._txttime = gohelper.findChildText(self.viewGO, "Right/#go_FinalInfo/image_LimitTimeBG/#txt_time")
	self._simageReward = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Reward")
	self._btnfinalRewardDetail = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#simage_Reward/#btn_finalRewardDetail")
	self._txtRewardName = gohelper.findChildText(self.viewGO, "Right/#go_FinalInfo/image_RewardNameBG/#txt_RewardName")
	self._txtScoreNum = gohelper.findChildText(self.viewGO, "Right/#go_FinalInfo/Slider/txt_Score/#txt_ScoreNum")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_FinalInfo/#btn_Claim")
	self._gofinalRewardNormalBg = gohelper.findChild(self.viewGO, "Right/#go_FinalInfo/#btn_Claim/#go_finalRewardNormalBg")
	self._gofinalRewardSpecialBg = gohelper.findChild(self.viewGO, "Right/#go_FinalInfo/#btn_Claim/#go_finalRewardSpecialBg")
	self._gohasget = gohelper.findChild(self.viewGO, "Right/#go_FinalInfo/#go_hasget")
	self._scrollRewardNode = gohelper.findChildScrollRect(self.viewGO, "#scroll_RewardNode")
	self._goStageItem = gohelper.findChild(self.viewGO, "#scroll_RewardNode/Viewport/content/#go_StageItem")
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "#scroll_store")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	self._gostoregoodsitem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_StoreView:addEvents()
	self._btnfinalRewardDetail:AddClickListener(self._btnfinalRewardDetailOnClick, self)
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectStoreStage, self.onStageSelect, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnBuyStoreGoodsSuccess, self.OnBuyStoreGoodsSuccess, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnStorePointUpdate, self.refreshFinalReward, self)
	self._scrollstore:AddOnValueChanged(self._onScrollValueChanged, self)
end

function Rouge2_StoreView:removeEvents()
	self._btnfinalRewardDetail:RemoveClickListener()
	self._btnClaim:RemoveClickListener()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectStoreStage, self.onStageSelect, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnBuyStoreGoodsSuccess, self.OnBuyStoreGoodsSuccess, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnStorePointUpdate, self.refreshFinalReward, self)
	self._scrollstore:RemoveOnValueChanged()
end

function Rouge2_StoreView:_btnfinalRewardDetailOnClick()
	local finalRewardConfig = self.finalRewardConfig

	if not finalRewardConfig then
		return
	end

	local isClaimed = Rouge2_StoreModel.instance:getGoodsBuyCount(finalRewardConfig.id) >= finalRewardConfig.maxBuyCount

	if not isClaimed then
		local curScore = Rouge2_StoreModel.instance:getCurUseScore()
		local targetScore = finalRewardConfig.rewardScore

		if targetScore <= curScore then
			Rouge2OutsideRpc.instance:sendRouge2RewardRequest(finalRewardConfig.id, finalRewardConfig.maxBuyCount)

			return
		end
	end

	local param = string.splitToNumber(finalRewardConfig.value, "#")

	MaterialTipController.instance:showMaterialInfo(param[1], param[2], false)
end

function Rouge2_StoreView:_editableInitView()
	gohelper.setActive(self._gostoreItem, false)
	gohelper.setActive(self._goStageItem, false)

	self._goStageItemParent = self._goStageItem.transform.parent.gameObject
	self.storeItemList = self:getUserDataTb_()
	self.rectTrContent = self._goContent:GetComponent(gohelper.Type_RectTransform)
	self.storeStageItemList = self:getUserDataTb_()
	self.finalRewardProgress = gohelper.findChildImage(self.viewGO, "Right/#go_FinalInfo/Slider/Slider/FG")
	self._gofinalReddot = gohelper.findChild(self.viewGO, "Right/#go_FinalInfo/#btn_Claim/#go_reddot")

	RedDotController.instance:addRedDot(self._gofinalReddot, RedDotEnum.DotNode.V3a2_Rouge_Store_FinalReward, 0)
end

function Rouge2_StoreView:_btnClaimOnClick()
	local finalRewardConfig = self.finalRewardConfig
	local isClaimed = Rouge2_StoreModel.instance:getGoodsBuyCount(finalRewardConfig.id) >= finalRewardConfig.maxBuyCount

	if isClaimed then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	local curScore = Rouge2_StoreModel.instance:getCurUseScore()
	local targetScore = finalRewardConfig.rewardScore

	if curScore < targetScore then
		GameFacade.showToast(ToastEnum.Rouge2StoreScoreTip)

		return
	end

	Rouge2OutsideRpc.instance:sendRouge2RewardRequest(finalRewardConfig.id, finalRewardConfig.maxBuyCount)
end

function Rouge2_StoreView:onUpdateParam()
	return
end

function Rouge2_StoreView:onUpdateParam()
	return
end

function Rouge2_StoreView:_onScrollValueChanged()
	if #self.storeItemList > 0 then
		for k, v in ipairs(self.storeItemList) do
			if k == 1 then
				v:refreshTagClip(self._scrollstore)
			end
		end
	end
end

function Rouge2_StoreView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	self:refreshStage()
	self:refreshFinalReward()
	self:refreshTime()
	self:onStageSelect(self._curState)
	self:_onScrollValueChanged()
end

function Rouge2_StoreView:onStoreInfoUpdate()
	self:refreshStage()
	self:refreshFinalReward()
	self:refreshTime()
	self:onStageSelect(self._curState)
end

function Rouge2_StoreView:refreshStage()
	local stageList = Rouge2_StoreModel.instance:getOpenStageIdList()

	if stageList and #stageList > 0 then
		local curState = self:getFirstNoSellOutStage(stageList)

		self._curState = curState

		Rouge2_StoreModel.instance:setCurStageId(curState)

		for index, stageId in ipairs(stageList) do
			local stageItem

			if self.storeStageItemList[index] == nil then
				local stageGo = gohelper.clone(self._goStageItem, self._goStageItemParent)

				stageItem = MonoHelper.addNoUpdateLuaComOnceToGo(stageGo, Rouge2_StoreStageItem)

				table.insert(self.storeStageItemList, stageItem)
			else
				stageItem = self.storeStageItemList[index]
			end

			stageItem:setActive(true)
			stageItem:setInfo(stageId)
		end
	else
		logError("Rouge2 Have no open store stage")

		return
	end

	TaskDispatcher.cancelTask(self.refreshTime, self)
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
end

function Rouge2_StoreView:onStageSelect(stageId)
	local storeGroupDict = Rouge2_OutSideConfig.instance:getRewardConfigListByStage(stageId)

	if storeGroupDict == nil then
		logError("have no such stage id:" .. stageId)

		return
	end

	self._curState = stageId

	Rouge2_StoreModel.instance:setCurStageId(self._curState)

	for _, stageItem in ipairs(self.storeStageItemList) do
		stageItem:setSelect(stageId)
	end

	self:refreshStoreContent()
end

function Rouge2_StoreView:OnBuyStoreGoodsSuccess(id)
	if self.finalRewardConfig and id == self.finalRewardConfig.id then
		self:refreshFinalReward()
	end
end

function Rouge2_StoreView:onStorePointUpdate()
	self:refreshFinalReward()
end

function Rouge2_StoreView:refreshStoreContent()
	local storeGroupDict = Rouge2_OutSideConfig.instance:getRewardConfigListByStage(self._curState)
	local storeItem

	for i = 1, #storeGroupDict do
		storeItem = self.storeItemList[i]

		if not self.storeItemList[i] then
			storeItem = Rouge2_StoreItem.New()

			storeItem:onInitView(gohelper.cloneInPlace(self._gostoreItem))
			table.insert(self.storeItemList, storeItem)
		end

		storeItem:updateInfo(i, storeGroupDict[i])
	end

	self:scrollToFirstNoSellOutStore()
end

function Rouge2_StoreView:refreshFinalReward()
	local finalRewardConstConfig = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.StoreFinalReward)
	local finalRewardId = finalRewardConstConfig and tonumber(finalRewardConstConfig.value) or 0
	local finalRewardConfig = Rouge2_OutSideConfig.instance:getRewardConfigById(finalRewardId)

	self.finalRewardConfig = finalRewardConfig

	local hasFinalReward = self.finalRewardConfig ~= nil

	gohelper.setActive(self._goFinalInfo, hasFinalReward)

	if not hasFinalReward then
		return
	end

	local isClaimed = Rouge2_StoreModel.instance:getGoodsBuyCount(finalRewardConfig.id) >= finalRewardConfig.maxBuyCount
	local curScore = Rouge2_StoreModel.instance:getCurUseScore()
	local targetScore = finalRewardConfig.rewardScore

	self._txtScoreNum.text = string.format("%s/%s", tostring(curScore), tostring(targetScore))

	local canGet = not isClaimed and targetScore <= curScore
	local progress = curScore == 0 and curScore or math.min(1, curScore / targetScore)

	self.finalRewardProgress.fillAmount = Mathf.Clamp(progress, 0, 1)

	gohelper.setActive(self._gohasget, isClaimed)
	gohelper.setActive(self._btnClaim, not isClaimed)

	if not isClaimed then
		gohelper.setActive(self._gofinalRewardNormalBg, not canGet)
		gohelper.setActive(self._gofinalRewardSpecialBg, canGet)
	end

	self.isFinalClaimed = isClaimed

	local attribute = string.splitToNumber(finalRewardConfig.value, "#")
	local itemType = attribute[1]
	local itemId = attribute[2]
	local itemCo = ItemModel.instance:getItemConfigAndIcon(itemType, itemId)

	self._txtRewardName.text = itemCo.name

	self._simageReward:LoadImage(ResUrl.getRouge2Icon("store/" .. finalRewardConfig.rewardImage))
end

function Rouge2_StoreView:onRewardIconLoad()
	self._simageReward.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function Rouge2_StoreView:scrollToFirstNoSellOutStore()
	local index = self:getFirstNoSellOutGroup()

	if index < 1 then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)

	local viewPortTr = gohelper.findChildComponent(self.viewGO, "#scroll_store/Viewport", gohelper.Type_RectTransform)
	local viewPortHeight = recthelper.getHeight(viewPortTr)
	local contentHeight = recthelper.getHeight(self.rectTrContent)
	local maxAnchorY = contentHeight - viewPortHeight
	local height = 0

	for _index, storeItem in ipairs(self.storeItemList) do
		if index <= _index then
			break
		end

		height = height + storeItem:getHeight()
	end

	recthelper.setAnchorY(self.rectTrContent, math.min(height, maxAnchorY))
end

function Rouge2_StoreView:getFirstNoSellOutGroup()
	local storeGroupDict = Rouge2_OutSideConfig.instance:getRewardConfigListByStage(self._curState)

	for index, groupGoodsCoList in ipairs(storeGroupDict) do
		for _, goodsCo in ipairs(groupGoodsCoList) do
			if goodsCo.maxBuyCount == 0 then
				return index
			end

			if goodsCo.maxBuyCount - Rouge2_StoreModel.instance:getGoodsBuyCount(goodsCo.id) > 0 then
				return index
			end
		end
	end

	return 0
end

function Rouge2_StoreView:getFirstNoSellOutStage(stageList)
	for _, stageId in ipairs(stageList) do
		if not Rouge2_StoreModel.instance:isStoreAllClaimed(stageId) then
			return stageId
		end
	end

	return stageList[1]
end

function Rouge2_StoreView:refreshTime()
	for _, stageItem in ipairs(self.storeStageItemList) do
		if stageItem.isOpen == false then
			stageItem:refreshUI()
		end
	end

	local stageConfig = Rouge2_OutSideConfig.instance:getRewardStageConfigById(self._curState)
	local curStageEndTime = TimeUtil.stringToTimestamp(stageConfig.endTime)
	local offsetSecond = math.max(0, curStageEndTime - ServerTime.now())

	if offsetSecond <= 0 then
		self._txttime.text = luaLang("ended")

		return
	end

	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

	if day >= 1 then
		self._txttime.text = string.format(luaLang("remain"), string.format("%s%s%s%s", day, luaLang("time_day"), hour, luaLang("time_hour2")))

		return
	end

	if hour >= 1 then
		self._txttime.text = string.format(luaLang("remain"), hour .. luaLang("time_hour2"))

		return
	end

	local minuteSecond = hourSecond % TimeUtil.OneHourSecond
	local minute = Mathf.Floor(minuteSecond / TimeUtil.OneMinuteSecond)

	if minute >= 1 then
		self._txttime.text = string.format(luaLang("remain"), minute .. luaLang("time_minute2"))

		return
	end

	self._txttime.text = string.format(luaLang("remain"), "<1" .. luaLang("time_minute2"))
end

function Rouge2_StoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function Rouge2_StoreView:onDestroyView()
	self._simagebg:UnLoadImage()

	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:onDestroy()
	end
end

return Rouge2_StoreView
