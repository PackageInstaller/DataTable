-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityMileStoneView.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityMileStoneView", package.seeall)

local AtomicOperationActivityMileStoneView = class("AtomicOperationActivityMileStoneView", BaseView)

function AtomicOperationActivityMileStoneView:onInitView()
	self.btnStoneCanget = gohelper.findChildButtonWithAudio(self.viewGO, "root/bonusNode/milestone/go_canget")
	self.txtStoneProgress = gohelper.findChildTextMesh(self.viewGO, "root/bonusNode/milestone/progress/txtprogress")
	self.itemGO = gohelper.findChild(self.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content/rewarditem")

	gohelper.setActive(self.itemGO, false)

	self.goLine = gohelper.findChild(self.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content/#go_normalline")
	self.trsLine = self.goLine.transform
	self.goContent = gohelper.findChild(self.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content")
	self.contentTransform = self.goContent.transform
	self.goScroll = gohelper.findChild(self.viewGO, "root/bonusNode/#scroll_reward")
	self.scroll = gohelper.findChildScrollRect(self.viewGO, "root/bonusNode/#scroll_reward")
	self.scrollRect = gohelper.findChildComponent(self.viewGO, "root/bonusNode/#scroll_reward", typeof(ZProj.LimitedScrollRect))
	self.scrollWidth = recthelper.getWidth(self.goScroll.transform)
	self.goBubble = gohelper.findChild(self.viewGO, "root/bonusNode/bubble")
	self.btnSpBonus = gohelper.findChildButtonWithAudio(self.viewGO, "root/bonusNode/bubble/btn")
	self.goreward = gohelper.findChild(self.viewGO, "root/bonusNode/bubble/goreward")

	gohelper.setActive(self.goBubble, false)

	self.cellSpace = 136
	self.bonusAnim = gohelper.findChildComponent(self.viewGO, "root/bonusNode", gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicOperationActivityMileStoneView:addEvents()
	self.scroll:AddOnValueChanged(self.onValueChanged, self)
	self.addClickCb(self, self.btnSpBonus, self.onClickBtnSpBonus, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.GetDailyCollection, self.onGetDailyCollection, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.GetMilestoneReward, self.onGetMilestoneReward, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.UpdateInfo, self.onUpdateInfo, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onCurrencyChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseView, self)
end

function AtomicOperationActivityMileStoneView:removeEvents()
	self.scroll:RemoveOnValueChanged()
	self.addClickCb(self, self.btnSpBonus, self.onClickBtnSpBonus, self)
	self.removeEventCb(self, Activity186Controller.instance, Activity186Event.GetDailyCollection, self.onGetDailyCollection, self)
	self.removeEventCb(self, Activity186Controller.instance, Activity186Event.GetMilestoneReward, self.onGetMilestoneReward, self)
	self.removeEventCb(self, Activity186Controller.instance, Activity186Event.UpdateInfo, self.onUpdateInfo, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onCurrencyChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseView, self)
end

function AtomicOperationActivityMileStoneView:_editableInitView()
	self.scrollBonusCanvasGroup = self.goScroll:GetComponent(gohelper.Type_CanvasGroup)
end

function AtomicOperationActivityMileStoneView:onValueChanged()
	self:refreshSpBonusReward()
end

function AtomicOperationActivityMileStoneView:onClickBtnSpBonus()
	self:_moveToIndex(self._spBonusIndex)
end

function AtomicOperationActivityMileStoneView:onCloseView(viewName)
	if viewName == ViewName.CommonPropView and self._waitRefresh then
		self:refreshView()
	end
end

function AtomicOperationActivityMileStoneView:onCurrencyChange(changeIds)
	if not changeIds then
		return
	end

	local currencyId = Activity186Config.instance:getConstNum(self.actId, Activity186Enum.ConstId.CurrencyId)

	if changeIds[currencyId] then
		self._waitRefresh = true
	end
end

function AtomicOperationActivityMileStoneView:onGetMilestoneReward()
	self:refreshList()
end

function AtomicOperationActivityMileStoneView:onUpdateInfo()
	self:refreshView()
end

function AtomicOperationActivityMileStoneView:onGetDailyCollection()
	self:refreshStone()
end

function AtomicOperationActivityMileStoneView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function AtomicOperationActivityMileStoneView:onOpen()
	self:refreshParam()
	self:refreshView()

	self.scrollBonusCanvasGroup.blocksRaycasts = false

	TaskDispatcher.runDelay(self.onOpenAnimPlayFinish, self, 1.33)
end

function AtomicOperationActivityMileStoneView:onOpenAnimPlayFinish()
	self.scrollBonusCanvasGroup.blocksRaycasts = true
end

function AtomicOperationActivityMileStoneView:refreshParam()
	self.actId = self.viewParam.actId
	self.actMo = Activity186Model.instance:getById(self.actId)

	AtomicOperationActivityMileStoneListModel.instance:init(self.actMo)
end

function AtomicOperationActivityMileStoneView:refreshView()
	self._waitRefresh = false

	self:refreshList()
	self:refreshStone()
end

function AtomicOperationActivityMileStoneView:refreshStone()
	local maxMileStoneValue = AtomicOperationActivityMileStoneListModel.instance:getMaxMileStoneValue()
	local currencyParam = AtomicOperationActivityConfig.instance:getConstStr(AtomicOperationActivityEnum.ConstId.CurrencyId)
	local currencyData = string.splitToNumber(currencyParam, "#")
	local currencyId = currencyData[2]
	local currencyMo = CurrencyModel.instance:getCurrency(currencyId)

	if currencyMo then
		if not currencyMo.quantity then
			local curMilestoneValue = 0

			self.txtStoneProgress.text = string.format("%s/%s", curMilestoneValue, maxMileStoneValue)
		end
	end
end

function AtomicOperationActivityMileStoneView:refreshList()
	AtomicOperationActivityMileStoneListModel.instance:refresh()
	TaskDispatcher.cancelTask(self.refreshLine, self)
	TaskDispatcher.runDelay(self.refreshLine, self, 0.01)
end

function AtomicOperationActivityMileStoneView:refreshLine()
	local index = AtomicOperationActivityMileStoneListModel.instance:caleProgressIndex()
	local indexValue = math.floor(index)
	local itemWidth = self:getItemWidth(indexValue)
	local width = self:getItemPosX(indexValue)
	local percent = index - indexValue

	if percent > 0 then
		local nextWidth = self:getItemWidth(indexValue + 1)

		width = indexValue > 0 and width + (nextWidth + self.cellSpace) * percent or 72 * percent
	end

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	if self._lineWith and self._lineWith ~= width then
		self._lineWith = width
		self._moveTweenId = ZProj.TweenHelper.DOWidth(self.trsLine, width, 2)

		self.bonusAnim:Play("get", 0, 0)
	else
		self.bonusAnim:Play("idle")

		self._lineWith = width

		recthelper.setWidth(self.trsLine, width)
	end

	if not self.isOpen then
		self.isOpen = true

		self:moveToDefaultPos()
	end

	self:onValueChanged()
end

function AtomicOperationActivityMileStoneView:caleProgressIndex(list)
	local index = 0
	local currencyParam = AtomicOperationActivityConfig.instance:getConstStr(AtomicOperationActivityEnum.ConstId.CurrencyId)
	local currencyData = string.splitToNumber(currencyParam, "#")
	local currencyId = currencyData[2]
	local hasCurrencyNum = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, currencyId)
	local lastCoinNum = 0

	for i, v in ipairs(list) do
		local coinNum = v.coinNum

		if hasCurrencyNum < coinNum then
			index = i + (hasCurrencyNum - lastCoinNum) / (coinNum - lastCoinNum) - 1

			return i + (hasCurrencyNum - lastCoinNum) / (coinNum - lastCoinNum) - 1
		end

		lastCoinNum = coinNum
	end

	local listLen = #list

	lastCoinNum = list[listLen - 1] and list[listLen - 1].coinNum or 0

	local loopConfig = list[listLen]
	local progress = self.actMo.getMilestoneProgress

	if not loopConfig.loopBonusIntervalNum then
		local loopNum = 1
		local coinNum = loopConfig.coinNum

		if progress < coinNum then
			index = listLen
		else
			local canGetTimesValue = (hasCurrencyNum - coinNum) / loopNum
			local canGetTimes = math.floor(canGetTimesValue)
			local getTimes = math.floor((progress - coinNum) / loopNum)

			index = getTimes < canGetTimes and listLen or listLen - 1 + canGetTimesValue - canGetTimes
		end

		return index
	end
end

function AtomicOperationActivityMileStoneView:refreshSpBonusReward()
	local index = self:getSpBonusIndex()

	if self._spBonusIndex == index then
		return
	end

	self._spBonusIndex = index

	gohelper.setActive(self.goBubble, index ~= nil)

	if index ~= nil then
		local list = Activity186Config.instance:getMileStoneList(self.actId)
		local config = list[index]

		if config then
			local rewards = GameUtil.splitString2(config.bonus, true)
			local itemCo = rewards[1]

			self.itemIcon = self.itemIcon or IconMgr.instance:getCommonPropItemIcon(self.goreward)

			self.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3])
			self.itemIcon:isShowQuality(false)
			self.itemIcon:isShowEquipAndItemCount(false)
			self.itemIcon:setCanShowDeadLine(false)
		end
	end
end

function AtomicOperationActivityMileStoneView:getSpBonusIndex()
	local contentX = recthelper.getAnchorX(self.contentTransform)
	local maxAnchorX = -(contentX - self.scrollWidth)
	local minAnchorX = -contentX
	local list = AtomicOperationActivityMileStoneListModel.instance:getList()

	for i, mo in ipairs(list) do
		if mo.isSpBonus then
			local itemPosX = self:getItemPosX(i)
			local status = self.actMo:getMilestoneRewardStatus(mo.rewardId)

			if minAnchorX <= itemPosX and itemPosX <= maxAnchorX and status == Activity186Enum.RewardStatus.Canget then
				return
			end

			if maxAnchorX < itemPosX and status ~= Activity186Enum.RewardStatus.Hasget then
				return i
			end
		end
	end
end

function AtomicOperationActivityMileStoneView:getItemPosX(index)
	if index <= 0 then
		return 0
	end

	local col = index - 1

	return col * (210 + self.cellSpace) + 280
end

function AtomicOperationActivityMileStoneView:getItemWidth(index)
	if not index then
		return 0
	end

	local list = AtomicOperationActivityMileStoneListModel.instance:getList()

	if list[index] then
		return 210
	end

	return 0
end

function AtomicOperationActivityMileStoneView:moveToDefaultPos()
	local list = Activity186Config.instance:getMileStoneList(self.actId)
	local index = 1

	for i, config in ipairs(list) do
		local status = self.actMo:getMilestoneRewardStatus(config.rewardId)

		if status ~= Activity186Enum.RewardStatus.Hasget then
			index = i

			break
		end
	end

	if index == 1 then
		self.scroll.horizontalNormalizedPosition = 0
	else
		self:_moveToIndex(index)
	end
end

function AtomicOperationActivityMileStoneView:_moveToIndex(index)
	if not index then
		return
	end

	self.viewContainer.mileStoneScrollView:moveToByIndex(index)
	self:onValueChanged()
end

function AtomicOperationActivityMileStoneView:onClose()
	return
end

function AtomicOperationActivityMileStoneView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshLine, self)

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	TaskDispatcher.cancelTask(self.onOpenAnimPlayFinish, self)
end

return AtomicOperationActivityMileStoneView
