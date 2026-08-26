-- chunkname: @modules/logic/sp02/linkgift/view/SP02_LinkGiftBaseView.lua

module("modules.logic.sp02.linkgift.view.SP02_LinkGiftBaseView", package.seeall)

local SP02_LinkGiftBaseView = class("SP02_LinkGiftBaseView", BaseView)

function SP02_LinkGiftBaseView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#simage_Title/#btn_detail")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Btn/#btn_buy")
	self._txtbuy = gohelper.findChildText(self.viewGO, "Root/Btn/#btn_buy/#txt_buy")
	self._gohasbuy = gohelper.findChild(self.viewGO, "Root/Btn/#go_hasbuy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SP02_LinkGiftBaseView:addEvents()
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self.onBuyPackage, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.onGetFreeReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.onPackageTaskFinish, self)
end

function SP02_LinkGiftBaseView:removeEvents()
	self._btndetail:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self.removeEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self.onBuyPackage, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.onGetFreeReward, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.onPackageTaskFinish, self)
end

function SP02_LinkGiftBaseView:_btndetailOnClick()
	local title = CommonConfig.instance:getConstStr(ConstEnum.SP02_LinkGiftTitle)
	local desc = CommonConfig.instance:getConstStr(ConstEnum.SP02_LinkGiftDesc)

	HelpController.instance:openStoreTipView(desc, title)
end

function SP02_LinkGiftBaseView:_btnbuyOnClick()
	local chargeGoodsId = self.curChangeGoodsId
	local goodsMo = StoreModel.instance:getGoodsMO(chargeGoodsId)

	if not goodsMo or goodsMo:isSoldOut() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	PayController.instance:startPay(chargeGoodsId)
end

function SP02_LinkGiftBaseView:_editableInitView()
	self:_initItemList()

	self._tempVector4 = Vector4.New(0, 0, 0, 0)
	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

local maxRewardIndex = 3
local itemType = {
	Free = 1,
	LinkGift = 3,
	PackageGoods = 2
}

function SP02_LinkGiftBaseView:_initItemList()
	self.linkGiftRootGoList = self:getUserDataTb_()
	self.linkGiftRewardItemList = {}
	self.totalRewardLineCompList = self:getUserDataTb_()
	self.totalRewardAnimatorList = self:getUserDataTb_()

	for i = 1, maxRewardIndex do
		local rootGo = gohelper.findChild(self.viewGO, "Root/node" .. tostring(i))
		local lineUIMesh = gohelper.findChildComponent(rootGo, "path/path_light", typeof(UIMesh))
		local animator = gohelper.findChildComponent(rootGo, "", gohelper.Type_Animator)

		table.insert(self.totalRewardLineCompList, lineUIMesh)
		table.insert(self.totalRewardAnimatorList, animator)
		table.insert(self.linkGiftRootGoList, rootGo)

		local singleItemList = {}
		local childCount = rootGo.transform.childCount

		for index = 1, childCount - 1 do
			local itemGo = rootGo.transform:GetChild(index).gameObject
			local rewardItem = self:getUserDataTb_()

			rewardItem.itemGo = itemGo
			rewardItem.goSelect = gohelper.findChild(itemGo, "#go_select")
			rewardItem.txtDesc = gohelper.findChildTextMesh(itemGo, "bg/txt_desc")
			rewardItem.goClaim = gohelper.findChild(itemGo, "#go_claim")
			rewardItem.goHasGet = gohelper.findChild(itemGo, "#go_hasget")
			rewardItem.goLock = gohelper.findChild(itemGo, "#go_lock")
			rewardItem.simageIcon = gohelper.findChildSingleImage(itemGo, "bg/icon")
			rewardItem.goPrice = gohelper.findChild(itemGo, "bg/txtbg")
			rewardItem.txtPrice = gohelper.findChildTextMesh(itemGo, "bg/txtbg/txt_free")
			rewardItem.txtNum = gohelper.findChildTextMesh(itemGo, "bg/#txt_num")
			rewardItem.btnClick = gohelper.findChildButton(itemGo, "bg/#btn_select")
			rewardItem.btnClaim = gohelper.findChildButton(itemGo, "#go_claim/#btn_claim")
			rewardItem.btnBuy = SLFramework.UGUI.UIClickListener.Get(rewardItem.goPrice)

			local hasGetChild = rewardItem.goHasGet.transform.childCount > 0 and rewardItem.goHasGet.transform:GetChild(0).gameObject or rewardItem.goHasGet

			rewardItem.hasGetImageIcon = gohelper.findChildImage(hasGetChild, "")
			rewardItem.imageIcon = gohelper.findChildImage(itemGo, "bg/icon")
			rewardItem.imageBuyBg = gohelper.findChildImage(itemGo, "bg/txtbg")
			rewardItem.hasGetImageIcon.raycastTarget = false
			rewardItem.imageIcon.raycastTarget = false
			rewardItem.imageBuyBg.raycastTarget = true
			rewardItem.animator = gohelper.findChildComponent(itemGo, "", gohelper.Type_Animator)

			local param = {}

			param.tabIndex = i
			param.rewardIndex = index
			param.target = self

			rewardItem.btnClick:AddClickListener(self.onClickRewardItem, param)
			rewardItem.btnClaim:AddClickListener(self.onClickRewardItem, param)

			local buyParam = {}

			buyParam.tabIndex = i
			buyParam.rewardIndex = index
			buyParam.target = self
			buyParam.isBuy = true

			rewardItem.btnBuy:AddClickListener(self.onClickRewardItem, buyParam)
			table.insert(singleItemList, rewardItem)
		end

		table.insert(self.linkGiftRewardItemList, singleItemList)
	end
end

function SP02_LinkGiftBaseView.onClickRewardItem(param)
	local tabIndex = param.tabIndex
	local rewardIndex = param.rewardIndex
	local target = param.target
	local isBuy = param.isBuy

	target:clickRewardItem(tabIndex, rewardIndex, isBuy)
end

function SP02_LinkGiftBaseView:clickRewardItem(tabIndex, rewardIndex, isBuy)
	local rewardMo = self.rewardDataList[tabIndex][rewardIndex]
	local rewardParam = rewardMo.rewardParam

	if rewardMo.type == itemType.Free then
		if ActivityType101Model.instance:isType101RewardCouldGet(self._actId, rewardMo.signInDay) then
			Activity101Rpc.instance:sendGet101BonusRequest(self._actId, rewardMo.signInDay)

			return
		end
	elseif rewardMo.type == itemType.PackageGoods then
		if isBuy then
			local goodsMo = StoreModel.instance:getGoodsMO(rewardMo.chargeGoodsId)

			if goodsMo and not goodsMo:isSoldOut() then
				PayController.instance:startPay(rewardMo.chargeGoodsId)

				return
			end
		end
	else
		local goodsMo = StoreModel.instance:getGoodsMO(rewardMo.chargeGoodsId)

		if goodsMo and not goodsMo:isSoldOut() then
			MaterialTipController.instance:showMaterialInfo(rewardParam[1], rewardParam[2])

			return
		end

		if StoreCharageConditionalHelper.isHasCanFinishGoodsTask(rewardMo.chargeGoodsId) then
			local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(rewardMo.chargeGoodsId)
			local conditionalConfig = StoreConfig.instance:getChargeConditionalConfig(chargeConfig.taskid)

			if not string.nilorempty(conditionalConfig.signInIdParam) then
				local param = string.splitToNumber(conditionalConfig.signInIdParam, "#")

				if param and param[1] and param[2] and ActivityType101Model.instance:isType101RewardCouldGet(param[1], param[2]) then
					Activity101Rpc.instance:sendGet101BonusRequest(param[1], param[2])
				end
			end

			TaskRpc.instance:sendFinishTaskRequest(chargeConfig.taskid)

			return
		end
	end

	MaterialTipController.instance:showMaterialInfo(rewardParam[1], rewardParam[2])
end

function SP02_LinkGiftBaseView:onUpdateParam()
	return
end

function SP02_LinkGiftBaseView:onOpen()
	self:checkParam()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum3_10.LinkGift.play_ui_qiutu_revelation_open)
	self.animator:Play("open", 0, 0)
end

function SP02_LinkGiftBaseView:checkParam()
	if not self.viewParam or not self.viewParam.actId then
		logError("SP02链式礼包 缺少活动配置")

		return
	end

	self._actId = self.viewParam.actId

	self:initShowData()
end

function SP02_LinkGiftBaseView:initShowData()
	self.rewardDataList = {}

	local actConfig = ActivityConfig.instance:getActivityCo(self._actId)
	local chargeGoodsIdList = string.splitToNumber(actConfig.patFaceParam, "#")

	self._chargeGoodsIdList = chargeGoodsIdList

	for _, chargeGoods in ipairs(chargeGoodsIdList) do
		local rewardMoList = {}
		local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(chargeGoods)
		local lingGiftConfig = StoreConfig.instance:getChargeConditionalConfig(chargeConfig.taskid)

		if not string.nilorempty(lingGiftConfig.signInIdParam) then
			local signInParam = string.splitToNumber(lingGiftConfig.signInIdParam, "#")
			local signInDay = signInParam[2]

			if signInDay and signInDay ~= 0 then
				local act101Config = ActivityType101Config.instance:getDayCO(self._actId, signInDay)
				local freeItemMo = {}

				freeItemMo.type = itemType.Free
				freeItemMo.signInDay = signInDay

				local rewardParamList = GameUtil.splitString2(act101Config.bonus, true)

				freeItemMo.rewardParam = rewardParamList[1]

				table.insert(rewardMoList, freeItemMo)
			end
		end

		local rewardList = GameUtil.splitString2(chargeConfig.product, true)
		local itemMo = {}

		itemMo.type = itemType.PackageGoods
		itemMo.rewardParam = rewardList[1]
		itemMo.chargeGoodsId = chargeGoods

		table.insert(rewardMoList, itemMo)

		local rewardParamList = GameUtil.splitString2(lingGiftConfig.bonus, true)

		for _, rewardData in ipairs(rewardParamList) do
			local linkGiftRewardMo = {}

			linkGiftRewardMo.type = itemType.LinkGift
			linkGiftRewardMo.rewardParam = rewardData
			linkGiftRewardMo.chargeGoodsId = chargeGoods

			table.insert(rewardMoList, linkGiftRewardMo)
		end

		table.insert(self.rewardDataList, rewardMoList)
	end
end

function SP02_LinkGiftBaseView:refreshUI()
	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneSecond)
	self:refreshReward()
end

function SP02_LinkGiftBaseView:refreshReward()
	local curRewardIndex = self:_getCurRewardIndex()
	local rewardDataList = self.rewardDataList[curRewardIndex]
	local rewardItemList = self.linkGiftRewardItemList[curRewardIndex]

	self.curChangeGoodsId = self._chargeGoodsIdList[curRewardIndex]

	local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(self.curChangeGoodsId)
	local lingGiftConfig = StoreConfig.instance:getChargeConditionalConfig(chargeConfig.taskid)

	self.signInParam = string.splitToNumber(lingGiftConfig.signInIdParam, "#")

	if curRewardIndex ~= self.curRewardIndex then
		for index, rootGo in ipairs(self.linkGiftRootGoList) do
			gohelper.setActive(rootGo, index == curRewardIndex)
		end

		for index, rewardData in ipairs(rewardDataList) do
			self:refreshSingleItem(rewardItemList[index], rewardData)
		end
	end

	self.curRewardIndex = curRewardIndex

	self:refreshRewardState()
end

function SP02_LinkGiftBaseView:onGetFreeReward()
	local isGetReward = false
	local singleItemList = self.linkGiftRewardItemList[self.curRewardIndex]
	local singleRewardList = self.rewardDataList[self.curRewardIndex]

	for index, rewardData in ipairs(singleRewardList) do
		local item = singleItemList[index]

		if rewardData.type == itemType.Free and ActivityType101Model.instance:isType101RewardGet(self._actId, rewardData.signInDay) and item.previousParam and item.previousParam.isGet == false then
			isGetReward = true

			break
		end
	end

	if not isGetReward then
		return
	end

	self:clearFlowSequence()
	logNormal("SP02_LinkGiftBaseView:onGetFreeReward")

	local goodsMo = StoreModel.instance:getGoodsMO(self.curChangeGoodsId)
	local isPackageSoldOut = goodsMo:isSoldOut()

	PopupController.instance:setPause(SP02_LinkGiftEnum.PopPauseKey, true)

	local flowSequence = FlowSequence.New()
	local firstIndex

	for index, rewardData in ipairs(singleRewardList) do
		local item = singleItemList[index]

		if rewardData.type == itemType.Free then
			firstIndex = firstIndex or index

			local param = {}

			param.go = item.itemGo
			param.animName = "hasget"

			gohelper.setActive(item.goHasGet, true)
			gohelper.setActive(item.goClaim, false)
			flowSequence:addWork(FunctionWork.New(function()
				AudioMgr.instance:trigger(AudioEnum3_10.LinkGift.play_ui_rewards)
			end))

			local animatorWork = AnimatorWork.New(param)

			flowSequence:addWork(animatorWork)

			if not isPackageSoldOut then
				flowSequence:addWork(FunctionWork.New(function()
					PopupController.instance:setPause(SP02_LinkGiftEnum.PopPauseKey, false)
				end))
				flowSequence:addWork(PopupViewFinishWork.New())
			end
		elseif rewardData.type == itemType.PackageGoods then
			if not isPackageSoldOut then
				local originValue = SP02_LinkGiftEnum.LineProgress[self.curRewardIndex][firstIndex]
				local targetValue = SP02_LinkGiftEnum.LineProgress[self.curRewardIndex][index]
				local time = SP02_LinkGiftEnum.DelayTime.HasGetDelay
				local floatWork = TweenWork.New({
					type = "DOTweenFloat",
					from = originValue,
					to = targetValue,
					t = time,
					frameCb = self.setProgressLine,
					cbObj = self,
					ease = EaseType.OutCubic
				})

				flowSequence:addWork(floatWork)

				local param = {}

				param.go = item.itemGo
				param.animName = "unlock"

				gohelper.setActive(item.goLock, true)
				flowSequence:addWork(FunctionWork.New(function()
					AudioMgr.instance:trigger(AudioEnum3_10.LinkGift.play_ui_shuori_qiyuan_down)
				end))

				local animatorWork = AnimatorWork.New(param)

				flowSequence:addWork(animatorWork)
			end

			break
		end
	end

	self.flowSequence = flowSequence

	self.flowSequence:registerDoneListener(self.onFlowSequenceDone, self)
	self.flowSequence:start()
	UIBlockHelper.instance:startBlock(SP02_LinkGiftEnum.UI_Block_Key, SP02_LinkGiftEnum.DelayTime.BuyAnimDelay)
end

function SP02_LinkGiftBaseView:onPackageTaskFinish()
	logNormal("SP02_LinkGiftBaseView:onPackageTaskFinish")

	if self.isInTaskFinish then
		return
	end

	self.isInTaskFinish = true

	local singleItemList = self.linkGiftRewardItemList[self.curRewardIndex]
	local singleRewardList = self.rewardDataList[self.curRewardIndex]
	local flowSequence
	local haveFlowSequence = self.flowSequence ~= nil

	if not haveFlowSequence then
		self.flowSequence = FlowSequence.New()

		self.flowSequence:registerDoneListener(self.onFlowSequenceDone, self)
		PopupController.instance:setPause(SP02_LinkGiftEnum.PopPauseKey, true)
		logNormal("SP02_LinkGiftBaseView:onPackageTaskFinish FlowSequence.New")
	else
		self.flowSequence:stop()
		logNormal("SP02_LinkGiftBaseView:onPackageTaskFinish FlowSequence.stop")
	end

	flowSequence = self.flowSequence

	local linkGiftCount = 0

	for index, rewardData in ipairs(singleRewardList) do
		local item = singleItemList[index]

		if rewardData.type == itemType.LinkGift then
			local param = {}

			param.animator = item.animator
			param.animName = "hasget"

			local delayFuncWork = DelayDoFuncWork.New(function()
				self:playAnim(param)
				gohelper.setActive(item.goHasGet, true)
				gohelper.setActive(item.goClaim, false)
			end, nil, linkGiftCount * SP02_LinkGiftEnum.DelayTime.UnlockAnimDelay, nil)

			flowSequence:addWork(delayFuncWork)

			linkGiftCount = linkGiftCount + 1
		end
	end

	flowSequence:addWork(DelayWork.New(linkGiftCount * SP02_LinkGiftEnum.DelayTime.UnlockAnimDelay + SP02_LinkGiftEnum.DelayTime.HasGetDelay))
	flowSequence:addWork(FunctionWork.New(function()
		PopupController.instance:setPause(SP02_LinkGiftEnum.PopPauseKey, false)
		logNormal("SP02_LinkGiftBaseView:onPackageTaskFinish setPause false")
	end))
	flowSequence:addWork(PopupViewFinishWork.New())

	if haveFlowSequence then
		flowSequence:resume()
	else
		flowSequence:start()
	end
end

function SP02_LinkGiftBaseView:onBuyPackage()
	logNormal("SP02_LinkGiftBaseView:onBuyPackage")

	if self.isInTaskFinish then
		return
	end

	self:clearFlowSequence()

	local animator = self.totalRewardAnimatorList[self.curRewardIndex]

	animator:Play("buy", 0, 0)

	local flowSequence = FlowSequence.New()
	local singleItemList = self.linkGiftRewardItemList[self.curRewardIndex]
	local singleRewardList = self.rewardDataList[self.curRewardIndex]
	local canFinish = StoreCharageConditionalHelper.isHasCanFinishGoodsTask(self.curChangeGoodsId)

	PopupController.instance:setPause(SP02_LinkGiftEnum.PopPauseKey, true)

	if canFinish then
		local lastIndex = #singleRewardList
		local linkGiftCount = 0

		for index, rewardData in ipairs(singleRewardList) do
			if rewardData.type == itemType.PackageGoods then
				local item = singleItemList[index]
				local param = {}

				param.go = item.itemGo
				param.animName = "hasget"

				gohelper.setActive(item.goHasGet, true)
				gohelper.setActive(item.goClaim, false)

				local animatorWork = AnimatorWork.New(param)

				flowSequence:addWork(animatorWork)
				flowSequence:addWork(FunctionWork.New(function()
					PopupController.instance:setPause(SP02_LinkGiftEnum.PopPauseKey, false)
				end))
				flowSequence:addWork(PopupViewFinishWork.New())
				flowSequence:addWork(FunctionWork.New(function()
					local originValue = SP02_LinkGiftEnum.LineProgress[self.curRewardIndex][index]
					local targetValue = SP02_LinkGiftEnum.LineProgress[self.curRewardIndex][lastIndex]

					self:tweenProgressLine(originValue, targetValue, SP02_LinkGiftEnum.DelayTime.BuyAnimDelay)
				end))
				flowSequence:addWork(FunctionWork.New(function()
					AudioMgr.instance:trigger(AudioEnum3_10.LinkGift.play_ui_qiutu_award_all)
				end))
			elseif rewardData.type == itemType.LinkGift then
				local item = singleItemList[index]
				local param = {}

				param.animator = item.animator
				param.animName = "unlock"

				local delayFuncWork = DelayDoFuncWork.New(self.playAnim, self, linkGiftCount * SP02_LinkGiftEnum.DelayTime.UnlockAnimDelay, param)

				flowSequence:addWork(delayFuncWork)

				linkGiftCount = linkGiftCount + 1
			end
		end
	end

	self.flowSequence = flowSequence

	self.flowSequence:registerDoneListener(self.onFlowSequenceDone, self)
	self.flowSequence:start()
	UIBlockHelper.instance:startBlock(SP02_LinkGiftEnum.UI_Block_Key, SP02_LinkGiftEnum.DelayTime.BuyAnimDelay)
end

function SP02_LinkGiftBaseView:playAnim(param)
	local animator = param.animator
	local animaName = param.animName

	if animator and not string.nilorempty(animaName) then
		logNormal("SP02_LinkGiftBaseView PlayAnim name: " .. tostring(animator) .. " animaName: " .. tostring(animaName) .. " time: " .. tostring(UnityEngine.Time.unscaledDeltaTime))
		animator:Play(animaName, 0, 0)
	end
end

function SP02_LinkGiftBaseView:setProgressLine(value)
	local lineComp = self.totalRewardLineCompList[self.curRewardIndex]

	if lineComp then
		local material = lineComp.material

		self._tempVector4.x = value

		material:SetVector("_DissolveControl", self._tempVector4)
	end
end

function SP02_LinkGiftBaseView:tweenProgressLine(from, to, duration)
	if self._progressTweenId then
		ZProj.TweenHelper.KillById(self._progressTweenId)
	end

	self._progressTweenId = ZProj.TweenHelper.DOTweenFloat(from, to, duration, self.setProgressLine, nil, self, nil, EaseType.OutCubic)
end

function SP02_LinkGiftBaseView:onFlowSequenceDone()
	logNormal("SP02_LinkGiftBaseView:onFlowSequenceDone")
	self:clearFlowSequence()
	TaskDispatcher.cancelTask(self.onSwitchTimeEnd, self)

	local curRewardIndex = self:_getCurRewardIndex()

	if curRewardIndex == self.curRewardIndex then
		self:refreshRewardState()
		UIBlockHelper.instance:endBlock(SP02_LinkGiftEnum.UI_Block_Key)
	else
		self.animator:Play("open", 0, 0)
		TaskDispatcher.runDelay(self.onSwitchTimeEnd, self, SP02_LinkGiftEnum.DelayTime.Switch)
	end

	self.isInTaskFinish = false
end

function SP02_LinkGiftBaseView:clearFlowSequence()
	if self.flowSequence then
		self.flowSequence:unregisterDoneListener(self.onFlowSequenceDone, self)
		self.flowSequence:clearWork()

		self.flowSequence = nil
	end
end

function SP02_LinkGiftBaseView:onSwitchTimeEnd()
	UIBlockHelper.instance:endBlock(SP02_LinkGiftEnum.UI_Block_Key)
	AudioMgr.instance:trigger(AudioEnum3_10.LinkGift.play_ui_qiutu_revelation_open)
	self:refreshReward()
end

function SP02_LinkGiftBaseView:refreshRewardState()
	local curRewardIndex = self.curRewardIndex
	local rewardDataList = self.rewardDataList[curRewardIndex]
	local rewardItemList = self.linkGiftRewardItemList[curRewardIndex]
	local curSelectIndex

	for index, rewardData in ipairs(rewardDataList) do
		local item = rewardItemList[index]
		local notGet = self:refreshSingleRewardState(item, rewardData, curRewardIndex)

		if not curSelectIndex and notGet then
			curSelectIndex = index
		end
	end

	for index, rewardData in ipairs(rewardDataList) do
		local item = rewardItemList[index]

		gohelper.setActive(item.goSelect, index == curSelectIndex)
	end

	curSelectIndex = curSelectIndex or #rewardDataList + 1

	local lineComp = self.totalRewardLineCompList[curRewardIndex]
	local progressValue = SP02_LinkGiftEnum.LineProgress[curRewardIndex][curSelectIndex]

	if lineComp then
		local material = lineComp.material
		local tempVector4 = material:GetVector("_DissolveControl")

		self._tempVector4.x = tempVector4.x
		self._tempVector4.y = tempVector4.y
		self._tempVector4.z = tempVector4.z
		self._tempVector4.w = tempVector4.w
	end

	self:setProgressLine(progressValue)
	self:refreshGoodsInfo()
end

function SP02_LinkGiftBaseView:refreshGoodsInfo()
	local goodsMo = StoreModel.instance:getGoodsMO(self.curChangeGoodsId)
	local isSoldOut = goodsMo and goodsMo:isSoldOut()

	gohelper.setActive(self._btnbuy, not isSoldOut)
	gohelper.setActive(self._gohasbuy, isSoldOut)

	if isSoldOut then
		return
	end

	self._txtbuy.text = PayModel.instance:getProductPrice(self.curChangeGoodsId)
end

function SP02_LinkGiftBaseView:refreshSingleItem(item, rewardData)
	local rewardParam = rewardData.rewardParam
	local config, icon = ItemModel.instance:getItemConfigAndIcon(rewardParam[1], rewardParam[2], true)

	item.simageIcon:LoadImage(icon)

	local type = rewardData.type
	local showPrice = type == itemType.PackageGoods
	local isFree = type ~= itemType.PackageGoods

	gohelper.setActive(item.goPrice, isFree or showPrice)

	if showPrice then
		item.txtPrice.text = PayModel.instance:getProductPriceScaledSymbol(rewardData.chargeGoodsId, 45)
	end

	item.txtNum.text = string.format("×%s", rewardParam[3])
end

function SP02_LinkGiftBaseView:refreshSingleRewardState(item, rewardData, index)
	local isUnlock = false
	local isGet = false
	local canGet = false
	local canFinish = StoreCharageConditionalHelper.isHasCanFinishGoodsTask(self.curChangeGoodsId)

	if rewardData.type == itemType.Free then
		isUnlock = ActivityType101Model.instance:isDayOpen(self._actId, rewardData.signInDay)
		canGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, rewardData.signInDay)
		isGet = ActivityType101Model.instance:isType101RewardGet(self._actId, rewardData.signInDay)
	elseif rewardData.type == itemType.PackageGoods then
		local goodsMo = StoreModel.instance:getGoodsMO(rewardData.chargeGoodsId)

		isGet = goodsMo and goodsMo.buyCount > 0
		isUnlock = isGet or ActivityType101Model.instance:isType101RewardGet(self.signInParam[1], self.signInParam[2])
		canGet = false
	else
		canGet = canFinish
		isUnlock = canFinish
		isGet = StoreCharageConditionalHelper.isCharageTaskFinish(self.curChangeGoodsId)
	end

	gohelper.setActive(item.goHasGet, isGet)
	gohelper.setActive(item.goLock, not isUnlock and not isGet)
	gohelper.setActive(item.goClaim, canGet)

	local previousParam = {}

	previousParam.isUnlock = isUnlock
	previousParam.isGet = isGet
	previousParam.canGet = canGet
	item.previousParam = previousParam

	return not isGet
end

function SP02_LinkGiftBaseView:_getCurRewardIndex()
	for index, chargeGoods in ipairs(self._chargeGoodsIdList) do
		local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(chargeGoods)
		local lingGiftConfig = StoreConfig.instance:getChargeConditionalConfig(chargeConfig.taskid)
		local signInParam = string.splitToNumber(lingGiftConfig.signInIdParam, "#")

		if ActivityType101Model.instance:isType101RewardCouldGet(signInParam[1], signInParam[2]) then
			return index
		end

		local goodsMo = StoreModel.instance:getGoodsMO(chargeGoods)

		if goodsMo and goodsMo.buyCount <= 0 then
			return index
		end

		if StoreCharageConditionalHelper.isHasCanFinishGoodsTask(chargeGoods) then
			return index
		end
	end

	return #self._chargeGoodsIdList
end

function SP02_LinkGiftBaseView:refreshTime()
	local actId = self._actId
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if not actInfoMo then
		self._txtLimitTime.text = luaLang("ended")

		return
	end

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal and toastId then
		self._txtLimitTime.text = status == ActivityEnum.ActivityStatus.Expired and luaLang("ended") or luaLang("notOpen")
	else
		local nowTime = ServerTime.now()
		local offsetTime = actInfoMo.endTime / TimeUtil.OneSecondMilliSecond - nowTime

		self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetTime)
	end
end

function SP02_LinkGiftBaseView:onClose()
	return
end

function SP02_LinkGiftBaseView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTime, self)

	for _, singleItemList in ipairs(self.linkGiftRewardItemList) do
		for _, item in ipairs(singleItemList) do
			item.btnClaim:RemoveClickListener()
			item.btnClick:RemoveClickListener()
			item.btnBuy:RemoveClickListener()
		end

		tabletool.clear(singleItemList)
	end

	tabletool.clear(self.rewardDataList)

	if self._progressTweenId then
		ZProj.TweenHelper.KillById(self._progressTweenId)
	end

	self:clearFlowSequence()
	TaskDispatcher.cancelTask(self.onSwitchTimeEnd, self)
end

return SP02_LinkGiftBaseView
