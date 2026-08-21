-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/EquipExploreMultiplicityFightTipsView.lua

module("logic.extensions.dungeon.view.equipdungeon.EquipExploreMultiplicityFightTipsView", package.seeall)

local M = class("EquipExploreMultiplicityFightTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._isProxyMode = false
end

function M:buildUI()
	self._textTitle = self:getText("2&universal_second_tips_common_bg_-1535781828")
	self._canvasGroup = goutil.addComponentOnce(self.mainGO.gameObject, ComponentType.CanvasGroup)
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._btnExit = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "universal_second_tips_common_bg/clickExit"))
	self._btnClose = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "universal_second_tips_common_bg/content/btnClose"))
	self._imgCostItem = self:getImage("multiplicity_fight_tips_1178624148")
	self._txtCostItem = self:getText("multiplicity_fight_tips_1535004532")
	self._btnFight = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "allContent/btnChallenge"))
	self._btnMinus = Astral.UILongPressTrigger.Get(self:getGo("multiplicity_fight_tips_-68776577"))
	self._btnAdd = Astral.UILongPressTrigger.Get(self:getGo("multiplicity_fight_tips_-2052577074"))

	local longPressTriggerCfg = {
		0.6,
		0.2,
		0.01
	}

	self._btnAdd:SetTriggerTime(longPressTriggerCfg)
	self._btnMinus:SetTriggerTime(longPressTriggerCfg)

	self._txtDoubleCount = self:getText("multiplicity_fight_tips_1406928334")
	self._btnCancel = self:getBtnByPath("allContent/btnCancle")
	self._txtTips = self:getUIComponent("multiplicity_fight_tips_-520542670", UIComponentType.TextMeshProUGUI)
	self._toggleProxy = self:getUIComponent("multiplicity_fight_tips_439993508", UIComponentType.SpaceXToggle)
	self._goProxy = self._toggleProxy.gameObject
	self._scroll = goutil.findChildComponent(self.mainGO, "allContent/itemList", UIComponentType.ScrollRect)
	self._rectTrScroll = goutil.findChildComponent(self.mainGO, "allContent/itemList", UIComponentType.RectTransform)
	self._rectTrContent = goutil.findChildComponent(self.mainGO, "allContent/itemList/viewport/content", UIComponentType.RectTransform)
	self._gridLayoutContent = goutil.findChildComponent(self.mainGO, "allContent/itemList/viewport/content", UIComponentType.GridLayoutGroup)
	self._loopList = LoopListHelper.New(self._scroll.gameObject)

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._slider = UIComponentType.SliderAdapter(self:getGo("multiplicity_fight_tips_1170307531"))
	self._uiSlider = self:getUIComponent("multiplicity_fight_tips_1170307531", UIComponentType.Slider)
	self._uiSlider.value = 0
end

function M:destroyUI()
	self._btnClose = nil
	self._imgCostItem = nil
	self._txtCostItem = nil
	self._btnFight = nil
	self._btnMinus = nil
	self._btnAdd = nil

	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnExit:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnFight:AddClickListener(self._onClickFight, self)
	self._btnMinus:AddLongPressListener(self._tryMinusOne, self, nil)
	self._btnAdd:AddLongPressListener(self._onLongPressAdd, self, nil)
	self._slider:AddOnValueChanged(self._onSliderValChanged, self)
	self._toggleProxy:AddListener(self._onProxyToggleChange, self)
	GlobalDispatcher:addEventListener(EventType.ON_BLUR_BG_CAPTURE_FINISH, self._handleBlurBgCaptureFinish, self)
end

function M:unbindEvents()
	self._btnExit:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnFight:RemoveClickListener()
	self._btnMinus:RemoveLongPressListener()
	self._btnAdd:RemoveLongPressListener()
	self._slider:RemoveOnValueChanged()
	self._toggleProxy:RemoveListener()
	GlobalDispatcher:removeEventListener(EventType.ON_BLUR_BG_CAPTURE_FINISH, self._handleBlurBgCaptureFinish, self)
end

function M:onEnter()
	local info = self:getFirstParam()

	self:setDungeonId(info.dungeonId)

	local dungeonId = self:getDungeonId()

	self._dungeonMo = DungeonModel.instance:getDungeonMoById(dungeonId)

	if not self._dungeonMo then
		printError(string.format("无法从DungeonModel找到dungeonId[%s]的数据", dungeonId))
		self:close()

		return
	end

	self._gamePlay = info.gamePlay

	self:_init(info.maxMultiCount, info.canProxy)

	local heros = DungeonModel.instance:getRecordLastTeam(dungeonId)

	self._herosData = {}

	if heros then
		for _, heroId in ipairs(heros) do
			local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

			table.insert(self._herosData, heroData)
		end
	end
end

function M:_init(maxMultiCount, canProxy)
	self:_setEvent(true)
	self:setCanvasInteractable(true)

	self._costItemId = CommEnum.CurrencyCodeEnum.TlCode
	self._baseCostItemCount = self._dungeonMo:getPointCost()
	self._maxDoubleCount = maxMultiCount
	self._minDoubleCount = 1
	self._curDoubleCount = self._minDoubleCount
	self._uiSlider.minValue = self._minDoubleCount
	self._uiSlider.maxValue = self._maxDoubleCount

	self._slider:SetValue(self._curDoubleCount)

	local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._costItemId)

	IconLoader.setSprite(self._imgCostItem, IconType.ItemIcon, itemCo.icon)

	self._costItemName = itemCo and itemCo.name or ""

	self._guiAnimation:StopTimelineAni()

	local hasRecord = DungeonModel.instance:getDungeonPassDataByDungeonId(self._dungeonId).hasRecord

	self._toggleProxy.IsOn = canProxy and hasRecord or false

	if self._gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		goutil.setActive(self._goProxy, false)
	else
		self._textTitle.text = lang("multi_fight_title")

		goutil.setActive(self._goProxy, canProxy and hasRecord)
	end

	self:_initRewardView()
	self:updateShow()
end

function M:_handleBlurBgCaptureFinish(e, viewName)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:onExit()
	self:_setEvent(false)
	self:setCanvasInteractable(false)

	self._minDoubleCount = nil
	self._maxDoubleCount = nil
	self._curDoubleCount = nil

	self:setDungeonId(nil)

	self._dungeonMo = nil
	self._costItemId = nil
	self._baseCostItemCount = nil

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")
end

function M:onExitFinished()
	self._loopList:ClearCells()

	self._rewardList = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._healthChange, self)
		GlobalDispatcher:addEventListener(EventType.HEALTH_EXCHANGE_DRUG_LST_CHANGE, self._healthChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._healthChange, self)
		GlobalDispatcher:removeEventListener(EventType.HEALTH_EXCHANGE_DRUG_LST_CHANGE, self._healthChange, self)
	end
end

function M:_onSliderValChanged(val)
	self:setCurDoubleCount(val)
end

function M:_onProxyToggleChange(tog, isOn, isEnable)
	self._isProxyMode = isOn
end

function M:_initRewardView()
	self._rewardList = DungeonUtil.getRewardLstNormal(self._dungeonMo)

	self:_mergeList(self._rewardList, DungeonUtil.getRewardLstRandom(self._dungeonMo))
	table.sort(self._rewardList, ItemUtil.commonSortFunc)

	local len = self._rewardList and #self._rewardList or 0

	self._canScroll = len > 7

	if len > 0 then
		self._scroll.enabled = self._canScroll

		self._loopList:SetListItemCount(len, true)
		self._loopList:RefreshAllShownItem()

		local layoutEnabled = not self._canScroll

		self._gridLayoutContent.enabled = false
		self._gridLayoutContent.enabled = layoutEnabled

		if layoutEnabled then
			local width = RectTransformUtils.GetWidth(self._rectTrScroll)

			RectTransformUtils.SetWidth(self._rectTrContent, width)
		end
	else
		self._loopList:ClearCells()
	end
end

function M:_mergeList(mainList, addList)
	if not addList or #addList == 0 then
		return
	end

	mainList = mainList or {}

	local existMap = {}

	for _, _itemData in ipairs(mainList) do
		existMap[_itemData:getItemId()] = 1
	end

	for _, _itemData in ipairs(addList) do
		if not existMap[_itemData:getItemId()] then
			existMap[_itemData:getItemId()] = 1

			table.insert(mainList, _itemData)
		end
	end
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local itemData = self._rewardList[curIndex]
	local item = self._loopList:NewListViewItem("backpack_item")
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, RewardCell)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, RewardCell)
	end

	local rewardData = RewardData.New({
		code = itemData:getItemId(),
		count = itemData.count
	})

	shower:updateData(rewardData)

	if not self._canScroll then
		item.transform:SetSiblingIndex(curIndex)
	end

	return item
end

function M:_onClickClose()
	self:close()
end

function M:_onToggleQuickFight(e, isOn)
	self._quickFightToggle = isOn
end

function M:_onClickFight()
	if self:isItemEnough() then
		if not self:_checkIsCanAddBackPack() then
			return
		end

		local info = {}

		info.dungeonId = self:getDungeonId()
		info.multiCount = self:getCurDoubleCount()
		info.quickFight = self:getQuickFightOn()
		info.gamePlay = self:getProxyOn() and self._gamePlay or BattleEnum.GamePlayType.NORMAL

		GlobalDispatcher:dispatchEvent(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, info)
		self:close()
	else
		ToolTipsMgr.showHealthExchangeTips()
	end
end

function M:_checkIsCanAddBackPack()
	local rewards = self._dungeonMo:getNormalReward() or {}

	for i = 1, #rewards do
		local isCanAdd, tips = MainBackpackModel.instance:isCanAddToBackPackById(rewards[i])

		if not isCanAdd then
			FloatWordMgr.instance:show(tips)

			return false
		end
	end

	return true
end

function M:_onClickMax()
	self:setCurDoubleCount(self._maxDoubleCount)
end

function M:_onLongPressAdd()
	self:_tryAddOne(true)
end

function M:_tryAddOne(showToast)
	local curDoubleCount = self:getCurDoubleCount()

	if curDoubleCount >= self._maxDoubleCount then
		return
	end

	local _readyNum = curDoubleCount + 1

	self._slider:SetValue(_readyNum)
end

function M:_tryMinusOne()
	local curDoubleCount = self:getCurDoubleCount()

	if curDoubleCount <= self._minDoubleCount then
		return
	end

	self._slider:SetValue(curDoubleCount - 1)
end

function M:updateShow()
	local curDoubleCount = self:getCurDoubleCount()
	local curItemNum = self:getCurItemNum()
	local willCostItemNum = self:getWillCostItemNum(curDoubleCount)

	self._txtDoubleCount.text = string.format("%s", curDoubleCount)

	if self._gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		self._txtTips.text = langF("tip_consecutive_fight", willCostItemNum, self._costItemName, curDoubleCount)
	else
		self._txtTips.text = langF("tip_multi_fight", willCostItemNum, curDoubleCount)
	end

	if self:isItemEnough() then
		self._txtCostItem.text = willCostItemNum
	else
		self._txtCostItem.text = string.format("<color=#ff3e48>%d</color>", willCostItemNum)
	end
end

function M:getQuickFightOn()
	return self._quickFightToggle
end

function M:getProxyOn()
	return self._isProxyMode
end

function M:setDungeonId(dungeonId)
	self._dungeonId = dungeonId
end

function M:getDungeonId()
	return self._dungeonId
end

function M:getCurDoubleCount()
	return self._curDoubleCount or 1
end

function M:setCurDoubleCount(count)
	self._curDoubleCount = count

	self:updateShow()
end

function M:getCurItemNum()
	return ItemModel.instance:getItemCountByItemId(self._costItemId)
end

function M:getWillCostItemNum(doubleCount)
	return doubleCount * self._baseCostItemCount
end

function M:isItemEnough()
	return self:getCurItemNum() >= self:getWillCostItemNum(self:getCurDoubleCount())
end

function M:setCanvasInteractable(active)
	self._canvasGroup.interactable = active
	self._canvasGroup.blocksRaycasts = active
end

function M:_healthChange()
	self:updateShow()
end

return M
