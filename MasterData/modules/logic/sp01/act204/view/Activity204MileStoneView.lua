-- chunkname: @modules/logic/sp01/act204/view/Activity204MileStoneView.lua

module("modules.logic.sp01.act204.view.Activity204MileStoneView", package.seeall)

local Activity204MileStoneView = class("Activity204MileStoneView", BaseView)

function Activity204MileStoneView:onInitView()
	self.btnStoneCanget = gohelper.findChildButtonWithAudio(self.viewGO, "root/leftReward/#btn_click")
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
	self.imageSpBonusRare = gohelper.findChildImage(self.viewGO, "root/bonusNode/bubble/#image_rare")
	self.goreward = gohelper.findChild(self.viewGO, "root/bonusNode/bubble/goreward")

	gohelper.setActive(self.goBubble, false)

	self.cellSpace = 0
	self.bonusAnim = gohelper.findChildComponent(self.viewGO, "root/bonusNode", gohelper.Type_Animator)
	self.gocangetdaily = gohelper.findChild(self.viewGO, "root/leftReward/dailyreward/canget")
	self.txtdailynum = gohelper.findChildText(self.viewGO, "root/leftReward/dailyreward/canget/numbg/#txt_num")
	self.gohasgetdaily = gohelper.findChild(self.viewGO, "root/leftReward/dailyreward/hasget")
	self.txtcangettips = gohelper.findChildText(self.viewGO, "root/leftReward/dailyreward/hasget/txt_canget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity204MileStoneView:addEvents()
	self.scroll:AddOnValueChanged(self.onValueChanged, self)
	self.addClickCb(self, self.btnStoneCanget, self.onClickBtnStoneCanget, self)
	self.addClickCb(self, self.btnSpBonus, self.onClickBtnSpBonus, self)
	self.addEventCb(self, Activity204Controller.instance, Activity204Event.GetDailyCollection, self.onGetDailyCollection, self)
	self.addEventCb(self, Activity204Controller.instance, Activity204Event.GetMilestoneReward, self.onGetMilestoneReward, self)
	self.addEventCb(self, Activity204Controller.instance, Activity204Event.UpdateInfo, self.onUpdateInfo, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onCurrencyChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseView, self)
end

function Activity204MileStoneView:removeEvents()
	self.scroll:RemoveOnValueChanged()
end

function Activity204MileStoneView:_editableInitView()
	return
end

function Activity204MileStoneView:onValueChanged()
	self:refreshSpBonusReward()
end

function Activity204MileStoneView:onClickBtnStoneCanget()
	if self.actMo.getDailyCollection then
		return
	end

	Activity204Rpc.instance:sendGetAct204DailyCollectionRequest(self.actId)
end

function Activity204MileStoneView:onClickBtnSpBonus()
	self:_moveToIndex(self._spBonusIndex)
end

function Activity204MileStoneView:onCloseView(viewName)
	if viewName == ViewName.CommonPropView and self._waitRefresh then
		self:refreshView()
	end
end

function Activity204MileStoneView:onCurrencyChange(changeIds)
	if not changeIds then
		return
	end

	local currencyId = Activity204Config.instance:getConstNum(Activity204Enum.ConstId.CurrencyId)

	if changeIds[currencyId] then
		self._waitRefresh = true
	end
end

function Activity204MileStoneView:onGetMilestoneReward()
	self:refreshList()
end

function Activity204MileStoneView:onUpdateInfo()
	self:refreshView()
end

function Activity204MileStoneView:onGetDailyCollection()
	self:refreshStone()
end

function Activity204MileStoneView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function Activity204MileStoneView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function Activity204MileStoneView:refreshParam()
	self.actId = self.viewParam.actId
	self.actMo = Activity204Model.instance:getById(self.actId)

	Activity204MileStoneListModel.instance:init(self.actMo)
end

function Activity204MileStoneView:refreshView()
	self._waitRefresh = false

	self:refreshList()
	self:refreshStone()
end

function Activity204MileStoneView:refreshStone()
	local hasGetReward = self.actMo.getDailyCollection
	local dailyGetCfg = string.splitToNumber(Activity204Config.instance:getConstStr(Activity204Enum.ConstId.DailyStoneCount), "#")
	local dailyCanGetNum = dailyGetCfg and dailyGetCfg[3]

	self.txtdailynum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), dailyCanGetNum)

	gohelper.setActive(self.gohasgetdaily, hasGetReward)
	gohelper.setActive(self.gocangetdaily, not hasGetReward)

	if hasGetReward then
		self.txtcangettips.text = luaLangUTC("activity204taskview_dailyget")
	end

	local maxMileStoneValue = Activity204MileStoneListModel.instance:getMaxMileStoneValue()
	local currencyId = Activity204Config.instance:getConstNum(Activity204Enum.ConstId.CurrencyId)
	local currencyMo = CurrencyModel.instance:getCurrency(currencyId)

	if currencyMo then
		if not currencyMo.quantity then
			local curMilestoneValue = 0

			self.txtStoneProgress.text = string.format("%s/%s", curMilestoneValue, maxMileStoneValue)
		end
	end
end

function Activity204MileStoneView:refreshList()
	Activity204MileStoneListModel.instance:refresh()
	TaskDispatcher.cancelTask(self.refreshLine, self)
	TaskDispatcher.runDelay(self.refreshLine, self, 0.01)
end

function Activity204MileStoneView:refreshLine()
	local index = Activity204MileStoneListModel.instance:caleProgressIndex()
	local indexValue = math.floor(index)
	local width = Activity204MileStoneListModel.instance:getItemPosX(indexValue)
	local percent = index - indexValue

	if percent > 0 then
		local curWidth = Activity204MileStoneListModel.instance:getItemWidth(indexValue)
		local nextWidth = Activity204MileStoneListModel.instance:getItemWidth(indexValue + 1)

		width = width + (curWidth + nextWidth) / 2 * percent
	end

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	if self._lineWith and self._lineWith ~= width then
		gohelper.setActive(self.trsLine.gameObject, false)
		gohelper.setActive(self.trsLine.gameObject, true)

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

function Activity204MileStoneView:refreshSpBonusReward()
	local index = self:getSpBonusIndex()

	if self._spBonusIndex == index then
		return
	end

	self._spBonusIndex = index

	gohelper.setActive(self.goBubble, index ~= nil)

	if index ~= nil then
		local list = Activity204Config.instance:getMileStoneList(self.actId)
		local config = list[index]

		if config then
			local rewards = GameUtil.splitString2(config.bonus, true)
			local itemCo = rewards[1]

			self.itemIcon = self.itemIcon or IconMgr.instance:getCommonPropItemIcon(self.goreward)

			self.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
			self.itemIcon:isShowQuality(false)
			self.itemIcon:isShowEquipAndItemCount(false)
			self.itemIcon:setCanShowDeadLine(false)

			local config = ItemModel.instance:getItemConfigAndIcon(itemCo[1], itemCo[2], true)

			if config then
				if not config.rare then
					local rare = 5

					UISpriteSetMgr.instance:setOptionalGiftSprite(self.imageSpBonusRare, "bg_pinjidi_" .. tostring(rare))
				end
			end
		end
	end
end

function Activity204MileStoneView:getSpBonusIndex()
	local contentX = recthelper.getAnchorX(self.contentTransform)
	local maxAnchorX = -(contentX - self.scrollWidth)
	local minAnchorX = -contentX
	local list = Activity204MileStoneListModel.instance:getList()

	for i, mo in ipairs(list) do
		if mo.isSpBonus then
			local itemPosX = Activity204MileStoneListModel.instance:getItemPosX(i)
			local status = self.actMo:getMilestoneRewardStatus(mo.rewardId)

			if minAnchorX <= itemPosX and itemPosX <= maxAnchorX and status == Activity204Enum.RewardStatus.Canget then
				return
			end

			if maxAnchorX < itemPosX and status ~= Activity204Enum.RewardStatus.Hasget then
				return i
			end
		end
	end
end

function Activity204MileStoneView:moveToDefaultPos()
	local list = Activity204Config.instance:getMileStoneList(self.actId)
	local index = 1

	for i, config in ipairs(list) do
		local status = self.actMo:getMilestoneRewardStatus(config.rewardId)

		if status ~= Activity204Enum.RewardStatus.Hasget then
			index = i

			break
		end
	end

	self:_moveToIndex(index)
end

function Activity204MileStoneView:_moveToIndex(index)
	if not index then
		return
	end

	self:moveToByIndex(index)
	self:onValueChanged()
end

function Activity204MileStoneView:moveToByIndex(moveIndex)
	local scrollGo = self.viewContainer.mileStoneScrollView._csMixScroll.gameObject
	local pos = Activity204MileStoneListModel.instance:getItemFocusPosX(moveIndex)
	local scrollRect = scrollGo:GetComponent(gohelper.Type_ScrollRect)
	local content = scrollRect.content
	local contentWidth = recthelper.getWidth(content)
	local scrollWidth = recthelper.getWidth(scrollRect.transform)
	local widthOffset = contentWidth - scrollWidth

	pos = math.min(math.max(0, widthOffset), pos)
	pos = -pos

	recthelper.setAnchorX(content, pos)
end

function Activity204MileStoneView:onClose()
	return
end

function Activity204MileStoneView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshLine, self)

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end
end

return Activity204MileStoneView
