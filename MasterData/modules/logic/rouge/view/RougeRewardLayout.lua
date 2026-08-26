-- chunkname: @modules/logic/rouge/view/RougeRewardLayout.lua

module("modules.logic.rouge.view.RougeRewardLayout", package.seeall)

local RougeRewardLayout = class("RougeRewardLayout", LuaCompBase)

function RougeRewardLayout:initcomp(go, co, index)
	self._go = go

	gohelper.setActive(self._go, false)

	self._config = co

	for _, co in ipairs(co) do
		self._stage = co.stage

		break
	end

	self._index = index
	self._imgSlider = gohelper.findChildImage(go, "Slider/image_SliderFG")
	self._imgSliderIcon = gohelper.findChildImage(go, "Slider/image_SliderFG/image_SliderFGIcon")
	self._goVxLight = gohelper.findChild(go, "Slider/image_SliderFG/image_SliderFGIcon/vx_light")
	self._goReward = gohelper.findChild(go, "Layout/#go_Reward")
	self._goExchange = gohelper.findChild(go, "Layout/#go_Exchange")
	self._btnExchange = gohelper.findChildButtonWithAudio(go, "Layout/#go_Exchange/btn")
	self._txtCost = gohelper.findChildText(go, "Layout/#go_Exchange/#txt_Cost")
	self._imgIcon = gohelper.findChildImage(go, "Layout/#go_Exchange/#txt_Cost/costIcon")
	self._animator = self._go:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._goVxLight, false)
	self:addEvents()

	self._rewardList = {}
	self._costConfig = RougeConfig.instance:getOutSideConstValueByID(RougeEnum.OutsideConst.RewardCost)

	local temp = string.split(self._costConfig, "#")

	self._costType, self._costId, self._costNum = temp[1], temp[2], temp[3]
	self._click = false
	self._currentSelectIndex = 1
	self._currentSelectId = nil
	self._longPressArr = {
		0.5,
		99999
	}

	self:_initItems()
	self:refreshSlider(self._config)

	self.itemspace = 186
	self._spacetime = 0.03
end

function RougeRewardLayout:refreshcomp(config)
	self._config = config

	local stage

	for _, co in ipairs(config) do
		stage = co.stage

		break
	end

	if stage ~= self._stage then
		self:_onSwitchAnim(true)
		self:hideExchangeBtn()

		self._stage = stage
		self._lastRate = nil
	else
		self:refreshItem()
		self:refreshSlider()
	end
end

function RougeRewardLayout:refreshItem()
	for index, co in ipairs(self._config) do
		local item = self._rewardList[index]
		local temp = string.split(co.value, "#")
		local type, id, num = temp[1], temp[2], temp[3]
		local itemConfig, itemIcon = ItemModel.instance:getItemConfigAndIcon(type, id, true)

		item.co = co
		item.id = co.id
		item.index = index
		item._txtNum.text = num

		item._simageItem:LoadImage(itemIcon)
		UISpriteSetMgr.instance:setRougeSprite(item._imgQuality, "rouge_reward_quality" .. itemConfig.rare)

		local isGet = RougeRewardModel.instance:checkRewardGot(co.stage, co.id)

		gohelper.setActive(item._goClaimed, isGet)
		item._long:RemoveLongPressListener()

		function self.LongPressFunc()
			MaterialTipController.instance:showMaterialInfo(type, id)
		end

		item._long:AddLongPressListener(self.LongPressFunc, self)

		item._isLongPress = false

		if isGet then
			local temp = string.split(co.value, "#")
			local type, id, num = temp[1], temp[2], temp[3]

			local function func()
				MaterialTipController.instance:showMaterialInfo(type, id)
			end

			item._btn:AddClickListener(func, self, item)
		else
			item._btn:AddClickListener(self._btnOnClick, self, item)
		end

		if isGet then
			item._imgQuality.color = RougeRewardLayout.Get or RougeRewardLayout.noGet
		end

		if isGet then
			item._imgItem.color = RougeRewardLayout.Get or RougeRewardLayout.noGet
		end
	end
end

function RougeRewardLayout:hideExchangeBtn()
	if self._click then
		gohelper.setActive(self._goExchange, false)

		self._click = false

		self:_refreshReward(false)
	end
end

function RougeRewardLayout:refreshSlider()
	if not self._config then
		return
	end

	local num = #self._config
	local finish = 0

	for index, co in ipairs(self._config) do
		if RougeRewardModel.instance:checkRewardGot(co.stage, co.id) then
			finish = finish + 1
		end
	end

	local rate = finish / num

	if not self._lastRate then
		self._lastRate = rate
	elseif self._lastRate ~= rate and rate == 1 then
		self._showAnim = true
		self._lastRate = rate
	else
		self._showAnim = false
	end

	if not self._showAnim then
		self._imgSlider.fillAmount = rate

		if self._imgSlider.fillAmount == 1 then
			UISpriteSetMgr.instance:setRougeSprite(self._imgSliderIcon, "rouge_reward_key1")
		else
			UISpriteSetMgr.instance:setRougeSprite(self._imgSliderIcon, "rouge_reward_key0")
		end
	end
end

RougeRewardLayout.noGet = Color(1, 1, 1, 1)
RougeRewardLayout.Get = Color(0.3, 0.3, 0.3, 1)

function RougeRewardLayout:_initItems()
	for index, co in ipairs(self._config) do
		local item = self._rewardList[index]
		local temp = string.split(co.value, "#")
		local type, id, num = temp[1], temp[2], temp[3]
		local itemConfig, itemIcon = ItemModel.instance:getItemConfigAndIcon(type, id, true)

		if not item then
			item = self:getUserDataTb_()

			local go = gohelper.cloneInPlace(self._goReward, "reward" .. index)

			gohelper.setActive(go, true)

			item.go = go
			item.index = index
			item.co = co
			item.id = co.id
			item._imgQuality = gohelper.findChildImage(go, "#img_Quality")
			item._simageItem = gohelper.findChildSingleImage(go, "#simage_Item")
			item._imgItem = item._simageItem:GetComponent(gohelper.Type_Image)
			item._goSelected1 = gohelper.findChild(go, "#go_Selected1")
			item._goSelected2 = gohelper.findChild(go, "#go_Selected2")
			item._txtNum = gohelper.findChildText(go, "image_NumBG/#txt_Num")
			item._goClaimed = gohelper.findChild(go, "#go_Claimed")
			item._gobtn = gohelper.findChild(go, "btn")
			item._btn = gohelper.findChildButtonWithAudio(go, "btn")

			item._btn:AddClickListener(self._btnOnClick, self, item)

			item._long = SLFramework.UGUI.UILongPressListener.Get(item._btn.gameObject)

			item._long:SetLongPressTime(self._longPressArr)

			function self.LongPressFunc()
				MaterialTipController.instance:showMaterialInfo(type, id)
			end

			item._long:AddLongPressListener(self.LongPressFunc, self)

			item._isLongPress = false

			table.insert(self._rewardList, item)
		end

		item._txtNum.text = num

		item._simageItem:LoadImage(itemIcon)
		UISpriteSetMgr.instance:setRougeSprite(item._imgQuality, "rouge_reward_quality" .. itemConfig.rare)

		local isGet = RougeRewardModel.instance:checkRewardGot(co.stage, co.id)

		gohelper.setActive(item._goClaimed, isGet)

		if isGet then
			item._imgQuality.color = RougeRewardLayout.Get or RougeRewardLayout.noGet
		end

		if isGet then
			item._imgItem.color = RougeRewardLayout.Get or RougeRewardLayout.noGet
		end
	end

	self:_onSwitchAnim(false)
	gohelper.setAsLastSibling(self._goExchange)
	self._btnExchange:AddClickListener(self._onClickExChangeBtn, self)
end

function RougeRewardLayout:_onEnterAnim()
	TaskDispatcher.cancelTask(self._onEnterAnim, self)
	gohelper.setActive(self._go, true)
	self._animator:Update(0)
	self._animator:Play("in", 0, 0)
	self:refreshItem()
	self:refreshSlider()
end

function RougeRewardLayout:_onSwitchAnim(islate)
	self._animator:Update(0)
	self._animator:Play("out", 0, 0)

	local spacetime = 0.03 * self._index
	local outtime = islate and 0.167 or 0
	local delayTime = spacetime + outtime

	TaskDispatcher.runDelay(self._onEnterAnim, self, delayTime)
end

function RougeRewardLayout:addEvents()
	self.addEventCb(self, RougeController.instance, RougeEvent.OnClickReward, self.refreshLayout, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnGetRougeReward, self.OnGetRougeReward, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function RougeRewardLayout:_btnOnClick(item)
	if self._currentSelectIndex ~= item.index then
		if self._click then
			local needNum = self:_getUnlockNum(item.index)

			self._click = not self._click

			gohelper.setActive(self._goExchange, self._click)

			local posx = (item.index - 1) * self.itemspace - self.itemspace / 2

			recthelper.setAnchorX(self._goExchange.transform, posx)

			if needNum > 0 then
				local needCost = needNum * self._costNum

				self._txtCost.text = needCost

				local haveNum = RougeRewardModel.instance:getRewardPoint()

				self._txtCost.color = haveNum < needCost and GameUtil.parseColor("#9F342C") or GameUtil.parseColor("#E99B56")

				local str = string.format("%s_1", self._costId)

				UISpriteSetMgr.instance:setCurrencyItemSprite(self._imgIcon, str)
			end
		end

		self._currentSelectIndex = item.index
	end

	if self._currentSelectId ~= item.id then
		self._currentSelectId = item.id
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnClickReward, self._index)
end

function RougeRewardLayout:_onClickExChangeBtn()
	local haveNum = RougeRewardModel.instance:getRewardPoint()
	local needNum = self:_getUnlockNum(self._currentSelectIndex)

	if needNum > 0 then
		if needNum * self._costNum <= haveNum then
			local season = RougeOutsideModel.instance:season()

			RougeOutsideRpc.instance:sendRougeReceivePointBonusRequest(season, self._currentSelectId)
		else
			GameFacade.showToast(ToastEnum.ExchangeFreeDiamond)
		end

		AudioMgr.instance:trigger(AudioEnum.UI.RewardCommonClick)
	end
end

function RougeRewardLayout:refreshLayout(layoutindex)
	if self._index == layoutindex then
		for index, item in ipairs(self._rewardList) do
			local co = item.co
			local isGet = RougeRewardModel.instance:checkRewardGot(co.stage, co.id)

			if index == self._currentSelectIndex and not isGet then
				local needNum = self:_getUnlockNum(index)

				self._click = not self._click

				gohelper.setActive(self._goExchange, self._click)

				local posx = (self._currentSelectIndex - 1) * self.itemspace - self.itemspace / 2

				recthelper.setAnchorX(self._goExchange.transform, posx)

				if needNum > 0 then
					local needCost = needNum * self._costNum

					self._txtCost.text = needCost

					local haveNum = RougeRewardModel.instance:getRewardPoint()

					self._txtCost.color = haveNum < needCost and GameUtil.parseColor("#9F342C") or GameUtil.parseColor("#E99B56")

					local str = string.format("%s_1", self._costId)

					UISpriteSetMgr.instance:setCurrencyItemSprite(self._imgIcon, str)
				end
			end
		end

		self:_refreshReward(self._click)

		local config = RougeRewardConfig.instance:getStageToLayourConfig(self._stage, self._index)

		self:refreshSlider(config)
	else
		gohelper.setActive(self._goExchange, false)

		self._click = false

		self:_refreshReward(false)
	end
end

function RougeRewardLayout:_refreshReward(stage)
	if stage then
		for _, item in ipairs(self._rewardList) do
			local co = item.co
			local isGet = RougeRewardModel.instance:checkRewardGot(co.stage, co.id)

			if not isGet then
				local isCurrent = item.index == self._currentSelectIndex

				if item.index <= self._currentSelectIndex then
					gohelper.setActive(item._goSelected1, not isCurrent)
					gohelper.setActive(item._goSelected2, isCurrent)
				else
					gohelper.setActive(item._goSelected1, false)
					gohelper.setActive(item._goSelected2, false)
				end
			else
				gohelper.setActive(item._goSelected1, false)
				gohelper.setActive(item._goSelected2, false)
			end
		end
	else
		for index, item in ipairs(self._rewardList) do
			gohelper.setActive(item._goSelected1, stage)
			gohelper.setActive(item._goSelected2, stage)
		end
	end
end

function RougeRewardLayout:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		gohelper.setActive(self._goVxLight, self._showAnim)

		self._imgSlider.fillAmount = self._lastRate

		if self._imgSlider.fillAmount == 1 then
			UISpriteSetMgr.instance:setRougeSprite(self._imgSliderIcon, "rouge_reward_key1")
		else
			UISpriteSetMgr.instance:setRougeSprite(self._imgSliderIcon, "rouge_reward_key0")
		end
	end
end

function RougeRewardLayout:OnGetRougeReward(rewardID)
	self._click = false

	gohelper.setActive(self._goExchange, self._click)
	self:_refreshReward(false)
end

function RougeRewardLayout:_getUnlockNum(index)
	local needNum = 0

	for i = 1, index do
		local co = self._rewardList[i].co

		if not RougeRewardModel.instance:checkRewardGot(co.stage, co.id) then
			needNum = needNum + 1
		end
	end

	return needNum
end

function RougeRewardLayout:onDestroy()
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnClickReward, self.refreshLayout, self)
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnGetRougeReward, self.OnGetRougeReward, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	TaskDispatcher.cancelTask(self._onEnterAnim, self)

	for key, item in pairs(self._rewardList) do
		item._btn:RemoveClickListener()
		item._long:RemoveLongPressListener()
	end

	self._btnExchange:RemoveClickListener()
end

return RougeRewardLayout
