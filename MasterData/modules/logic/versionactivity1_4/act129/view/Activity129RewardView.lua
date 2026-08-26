-- chunkname: @modules/logic/versionactivity1_4/act129/view/Activity129RewardView.lua

module("modules.logic.versionactivity1_4.act129.view.Activity129RewardView", package.seeall)

local Activity129RewardView = class("Activity129RewardView", BaseView)

function Activity129RewardView:onInitView()
	self.goRewards = gohelper.findChild(self.viewGO, "#go_Rewards")
	self.goRewardItem = gohelper.findChild(self.goRewards, "#scroll_RewardList/Viewport/Content/#go_RewardItem")
	self.goBuy = gohelper.findChild(self.viewGO, "#go_Rewards/Buy")
	self.inputValue = gohelper.findChildTextMeshInputField(self.goBuy, "ValueBG/#input_Value")
	self.txtCost = gohelper.findChildTextMesh(self.goBuy, "#btn_Buy/#txt_Cost")
	self.simageIcon = gohelper.findChildSingleImage(self.goBuy, "#btn_Buy/#simage_CostIcon")
	self.txtBuy = gohelper.findChildTextMesh(self.goBuy, "#btn_Buy/txt_Buy")
	self.imgBuy = gohelper.findChildImage(self.goBuy, "#btn_Buy")
	self.btnBuy = gohelper.findChildButtonWithAudio(self.goBuy, "#btn_Buy")
	self.btnMax = gohelper.findChildButtonWithAudio(self.goBuy, "#btn_Max")
	self.btnMin = gohelper.findChildButtonWithAudio(self.goBuy, "#btn_Min")
	self.goAdd = gohelper.findChild(self.goBuy, "#btn_Add")
	self.goSub = gohelper.findChild(self.goBuy, "#btn_Sub")
	self.maxDisable = gohelper.findChild(self.goBuy, "#btn_Max/image_Disable")
	self.minDisable = gohelper.findChild(self.goBuy, "#btn_Min/image_Disable")
	self.goBack = gohelper.findChild(self.viewGO, "#go_BackBtns")
	self.goCurreny = gohelper.findChild(self.viewGO, "#go_CurrenyBar")
	self.txtTitleEn = gohelper.findChildTextMesh(self.goRewards, "RewardTitle/image_RewardTitleBG/txt_RewardTitleEn")
	self.txtTitle = gohelper.findChildTextMesh(self.goRewards, "RewardTitle/image_RewardTitleBG/txt_RewardTitle")
	self.anim = self.goRewards:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity129RewardView:addEvents()
	self.inputValue:AddOnValueChanged(self._onValueChanged, self)
	self.addClickCb(self, self.btnBuy, self.onClickBuy, self)
	self.addClickCb(self, self.btnMax, self.onClickMax, self)
	self.addClickCb(self, self.btnMin, self.onClickMin, self)
	self.addEventCb(self, Activity129Controller.instance, Activity129Event.OnEnterPool, self.onEnterPool, self)
	self.addEventCb(self, Activity129Controller.instance, Activity129Event.OnLotterySuccess, self.onLotterySuccess, self)
	self.addEventCb(self, Activity129Controller.instance, Activity129Event.OnLotteryEnd, self.onLotteryEnd, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)

	local timeMatrix = {}

	timeMatrix[1] = 0.5

	for i = 2, 10 do
		local time = 0.7 * timeMatrix[i - 1]

		time = math.max(time, 0.1)

		table.insert(timeMatrix, time)
	end

	self._subPress = SLFramework.UGUI.UILongPressListener.Get(self.goSub)

	self._subPress:SetLongPressTime(timeMatrix)
	self._subPress:AddLongPressListener(self._subLongPressTimeEnd, self)

	self._subClick = SLFramework.UGUI.UIClickListener.Get(self.goSub)

	self._subClick:AddClickListener(self.onClickSub, self)
	self._subClick:AddClickUpListener(self._subClickUp, self)

	self._addPress = SLFramework.UGUI.UILongPressListener.Get(self.goAdd)

	self._addPress:SetLongPressTime(timeMatrix)
	self._addPress:AddLongPressListener(self._addLongPressTimeEnd, self)

	self._addClick = SLFramework.UGUI.UIClickListener.Get(self.goAdd)

	self._addClick:AddClickListener(self.onClickAdd, self)
	self._addClick:AddClickUpListener(self._addClickUp, self)
end

function Activity129RewardView:removeEvents()
	self.inputValue:RemoveOnValueChanged()
	self:removeClickCb(self.btnBuy)
	self:removeClickCb(self.btnMax)
	self:removeClickCb(self.btnMin)
	self.removeEventCb(self, Activity129Controller.instance, Activity129Event.OnEnterPool, self.onEnterPool, self)
	self.removeEventCb(self, Activity129Controller.instance, Activity129Event.OnLotterySuccess, self.onLotterySuccess, self)
	self.removeEventCb(self, Activity129Controller.instance, Activity129Event.OnLotteryEnd, self.onLotteryEnd, self)
	self.removeEventCb(self, Activity129Controller.instance, Activity129Event.OnLotteryEnd, self.onLotteryEnd, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self._subPress:RemoveLongPressListener()
	self._subClick:RemoveClickListener()
	self._subClick:RemoveClickUpListener()
	self._addPress:RemoveLongPressListener()
	self._addClick:RemoveClickListener()
	self._addClick:RemoveClickUpListener()
end

function Activity129RewardView:_editableInitView()
	self.poolItems = {}
	self.rewardItems = {}

	for i = 1, 2 do
		local go = gohelper.findChild(self.goRewards, string.format("#scroll_RewardList/Viewport/Content/Reward%s", i))
		local param = {}

		param.goItem = self.goRewardItem
		param.itemList = self.rewardItems
		param.rare = i == 1 and 5 or 4
		self.poolItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, Activity129RewardPoolItem, param)
	end
end

function Activity129RewardView:_onCurrencyChange(changeIds)
	if not self.actId then
		return
	end

	local currencyId = Activity129Config.instance:getConstValue1(self.actId, Activity129Enum.ConstEnum.CostId)

	if not changeIds[currencyId] then
		return
	end

	self:refreshBuyButton()
end

function Activity129RewardView:onLotterySuccess()
	gohelper.setActive(self.goBack, false)
	gohelper.setActive(self.goCurreny, false)
	self:setVisible(false)
end

function Activity129RewardView:onLotteryEnd()
	gohelper.setActive(self.goBack, true)
	gohelper.setActive(self.goCurreny, true)
	self:refreshView()
end

function Activity129RewardView:onEnterPool()
	self.curCount = 1

	self:refreshView()
end

function Activity129RewardView:onOpen()
	self.actId = self.viewParam.actId

	self:refreshView()
end

function Activity129RewardView:refreshView()
	local selectPoolId = Activity129Model.instance:getSelectPoolId()

	if not selectPoolId then
		self:setVisible(false)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	self:setVisible(true)
	self:refreshMaxCount()
	self:refreshReward()
	self:refreshBuy()
end

function Activity129RewardView:refreshMaxCount()
	self.maxCount = Activity129Config.instance:getConstValue1(self.actId, Activity129Enum.ConstEnum.MaxMoreDraw)

	local selectPoolId = Activity129Model.instance:getSelectPoolId()

	if not selectPoolId then
		return
	end

	local actMo = Activity129Model.instance:getActivityMo(self.actId)
	local poolMo = actMo:getPoolMo(selectPoolId)
	local drawCount, maxCount = poolMo:getPoolDrawCount()

	if maxCount > 0 then
		local remainCount = maxCount - drawCount

		if remainCount <= 0 then
			remainCount = 1
		end

		self.maxCount = math.min(remainCount, self.maxCount)
	end
end

function Activity129RewardView:refreshReward()
	local selectPoolId = Activity129Model.instance:getSelectPoolId()

	if not selectPoolId then
		return
	end

	for i, v in ipairs(self.rewardItems) do
		v:setHideMark()
	end

	local dict = Activity129Config.instance:getGoodsDict(selectPoolId)
	local rare2Goods = {}

	if dict then
		for rare, co in pairs(dict) do
			rare2Goods[rare] = GameUtil.splitString2(co.goodsId, true)
		end
	end

	for i, item in ipairs(self.poolItems) do
		item:setDict(rare2Goods, self.actId, selectPoolId)
	end

	for i, v in ipairs(self.rewardItems) do
		v:checkHide()
	end

	local poolCfg = Activity129Config.instance:getPoolConfig(self.actId, selectPoolId)

	self.txtTitle.text = poolCfg.name
	self.txtTitleEn.text = poolCfg.nameEn
end

function Activity129RewardView:refreshBuy()
	if not self.curCount then
		local count = self.maxCount

		count = self:getInputCount(0, self.curCount)

		self:setInputTxt(self.curCount)
		self:refreshBuyButton()
	end
end

function Activity129RewardView:refreshBuyButton()
	local selectPoolId = Activity129Model.instance:getSelectPoolId()

	if not selectPoolId then
		return
	end

	local poolCfg = Activity129Config.instance:getPoolConfig(self.actId, selectPoolId)
	local cost = poolCfg.cost
	local txt = self.inputValue:GetText()
	local count = tonumber(txt)
	local costData = string.splitToNumber(cost, "#")
	local costQuantity = costData[3] * count
	local config, icon = ItemModel.instance:getItemConfigAndIcon(costData[1], costData[2], true)

	self.simageIcon:LoadImage(icon)

	local quantity = ItemModel.instance:getItemQuantity(costData[1], costData[2])
	local isEnough = costQuantity <= quantity

	self.txtCost.text = isEnough and tostring(costQuantity) or string.format("<color=#d33838>%s</color>", costQuantity)
	self.txtBuy.text = formatLuaLang("v1a4_tokenstore_confirm", GameUtil.getNum2Chinese(count))

	gohelper.setActive(self.maxDisable, false)
	gohelper.setActive(self.minDisable, false)
end

function Activity129RewardView:_onValueChanged()
	local txt = self.inputValue:GetText()
	local count = tonumber(txt)

	if not count or count < 1 or count > self.maxCount then
		count = self:getInputCount(0, count)

		self:setInputTxt(count)
	end

	self:refreshBuyButton()
end

function Activity129RewardView:onClickBuy()
	local selectPoolId = Activity129Model.instance:getSelectPoolId()

	if not selectPoolId then
		return
	end

	if Activity129Model.instance:checkPoolIsEmpty(self.actId, selectPoolId) then
		GameFacade.showToast(ToastEnum.Activity129PoolIsEmpty)
		Activity129Controller.instance:dispatchEvent(Activity129Event.OnClickEmptyPool)

		return
	end

	local poolCfg = Activity129Config.instance:getPoolConfig(self.actId, selectPoolId)
	local cost = poolCfg.cost
	local txt = self.inputValue:GetText()
	local count = tonumber(txt) or 1
	local costData = string.splitToNumber(cost, "#")
	local consumeCos = {}
	local o = {}

	o.type = costData[1]
	o.id = costData[2]
	o.quantity = costData[3] * count

	table.insert(consumeCos, o)

	local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(consumeCos)

	if not enough then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, notEnoughItemName)

		return
	end

	local selectPoolId = Activity129Model.instance:getSelectPoolId()

	if not selectPoolId then
		return
	end

	Activity129Rpc.instance:sendAct129LotteryRequest(self.actId, selectPoolId, count)
end

function Activity129RewardView:onClickMin()
	self:setInputTxt(1)
end

function Activity129RewardView:onClickMax()
	self:setInputTxt(self.maxCount)
end

function Activity129RewardView:setInputTxt(txt)
	self.curCount = tonumber(txt)

	self.inputValue:SetText(tostring(txt))
end

function Activity129RewardView:getInputCount(offset, input)
	input = input or tonumber(self.inputValue:GetText()) or self.curCount or 1
	offset = offset or 0

	return Mathf.Clamp(input + offset, 1, self.maxCount)
end

function Activity129RewardView:onClickAdd()
	self:setInputTxt(self:getInputCount(1))
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function Activity129RewardView:onClickSub()
	self:setInputTxt(self:getInputCount(-1))
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function Activity129RewardView:_subLongPressTimeEnd()
	local isLongPress = self._isLongPress

	self._isLongPress = true

	self:setInputTxt(self:getInputCount(-1))

	if not isLongPress then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function Activity129RewardView:_subClickUp()
	self._isLongPress = false
end

function Activity129RewardView:_addLongPressTimeEnd()
	local isLongPress = self._isLongPress

	self._isLongPress = true

	self:setInputTxt(self:getInputCount(1))

	if not isLongPress then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function Activity129RewardView:_addClickUp()
	self._isLongPress = false
end

function Activity129RewardView:setVisible(isVisible)
	TaskDispatcher.cancelTask(self._hide, self)

	if isVisible then
		gohelper.setActive(self.goRewards, true)
	else
		self.anim:Play("close")
		TaskDispatcher.runDelay(self._hide, self, 0.17)
	end
end

function Activity129RewardView:_hide()
	gohelper.setActive(self.goRewards, false)
end

function Activity129RewardView:onClose()
	TaskDispatcher.cancelTask(self._hide, self)
end

function Activity129RewardView:onDestroyView()
	self.simageIcon:UnLoadImage()
end

return Activity129RewardView
