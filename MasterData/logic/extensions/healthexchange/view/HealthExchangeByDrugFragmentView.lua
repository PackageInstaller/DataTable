-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/healthexchange/view/HealthExchangeByDrugFragmentView.lua

module("logic.extensions.healthexchange.view.HealthExchangeByDrugFragmentView", package.seeall)

local M = class("HealthExchangeByDrugFragmentView")
local longClickIntervalTime = 0.3

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local registry = self._registry
	local mainGO = self._mainGO

	self._goPanel = registry:findUIElement("health_exchange_tips_1010175278")
	self._txtCurEnergy = registry:findUIElement("health_exchange_tips_-1618018733", UIComponentType.Text)
	self._txtWantAddEnergy = registry:findUIElement("health_exchange_tips_-204869103", UIComponentType.Text)
	self._txtMaxEnergy = registry:findUIElement("health_exchange_tips_1708112615", UIComponentType.Text)

	TextUtils.SetColor(self._txtMaxEnergy, MoneyUtil.MaxEnergyColor)

	self._noDrugTipsGo = goutil.findChild(mainGO, "content/empty_unit")
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(mainGO, "content/btnUse"), CommButton)
	self._scroll = registry:findUIElement("health_exchange_tips_1743409645", UIComponentType.ScrollRect)
	self._rectTrScroll = registry:findUIElement("health_exchange_tips_1743409645", UIComponentType.RectTransform)
	self._gridLayoutContent = registry:findUIElement("health_exchange_tips_53575384", UIComponentType.GridLayoutGroup)
	self._rectTrContent = registry:findUIElement("health_exchange_tips_53575384", UIComponentType.RectTransform)
	self._loopGridView = LoopGridViewHelper.New(self._scroll.gameObject)

	self._loopGridView:InitGridView(0, self._onCellUpdate, self)

	self._energyRecoverMax = ConstConfig.instance:getNumValueByKey("EnergyAddLimit")
	self._energyMax = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.EnergyMax)
end

function M:destroyUI()
	self._scroll = nil

	self._loopGridView:Dispose()

	self._loopGridView = nil
	self._txtWantAddEnergy = nil
	self._txtMaxEnergy = nil
	self._noDrugTipsGo = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._isEnter = true

	self:setEvent(true)
	self:prepareData()
	self:_refreshView()
	self:_refreshEnergyDrugScrollView()
	self._btnConfirm:setText("使用")
end

function M:onExit()
	self._isEnter = false

	self:setEvent(false)
	removetimer(self._longClickItemTimer, self)
	removetimer(self._longClickReduceTimer, self)
	self._loopGridView:ClearCells()
	goutil.setActive(self._scroll.gameObject, false)
	goutil.setActive(self._noDrugTipsGo, false)

	for _uuid, data in pairs(self._itemUseData or {}) do
		data.hasAddCount = 0
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HEALTH_EXCHANGE_DRUG_LST_CHANGE, self._handleHealthExchagneDrugLstChange, self)
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_VIEW_CLOSE, self._handleGainItemViewClose, self)
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HEALTH_EXCHANGE_DRUG_LST_CHANGE, self._handleHealthExchagneDrugLstChange, self)
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_VIEW_CLOSE, self._handleGainItemViewClose, self)
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_ADD_EVENT, self._handleGainItemAdd, self)
	end
end

function M:_handleHealthExchagneDrugLstChange()
	self:prepareData()

	if not self._isEnter then
		return
	end

	self:_refreshView()
	self:_refreshEnergyDrugScrollView()
end

function M:_handleGainItemAdd(e, params)
	if not self._isEnter then
		return
	end

	self:_refreshView()
	self:_refreshEnergyDrugScrollView()
end

function M:_handleGainItemViewClose()
	self:prepareData()

	if not self._isEnter then
		return
	end

	self:_refreshView()
	self:_refreshEnergyDrugScrollView()
end

function M:setBtnConfirmInteractable(active)
	self._btnConfirm:setActiveState(active)
end

function M:prepareData()
	self._itemLst = {}
	self._itemUseData = {}

	local curTime = ServerTime.now() * 1000
	local _drugInBackPack = ItemModel.instance:getItemsByTS(GameEnum.ItemTypeEnum.PropItemType, GameEnum.PropSubTypeEnum.PowerProp)

	if _drugInBackPack and #_drugInBackPack > 0 then
		table.sort(_drugInBackPack, ItemUtil.sortItemsCompare)

		for k, v in pairs(_drugInBackPack) do
			local itemCount = v:getCount()

			if itemCount > 0 then
				local itemExpireTime = v:getExpireTime()

				itemExpireTime = tonumber(itemExpireTime)

				if itemExpireTime == 0 or curTime < itemExpireTime then
					local uuid = v:getUuid()

					table.insert(self._itemLst, v)

					self._itemUseData[uuid] = {
						hasAddCount = 0,
						id = v:getItemId(),
						uuid = uuid,
						itemCount = itemCount,
						exInfo = tonumber(v:getExtrInfo()),
						expireTime = itemExpireTime
					}
				end
			end
		end
	end
end

function M:getItemLst()
	return self._itemLst
end

function M:getCurWantAddEnergyNum()
	local addNum = 0

	for _uuid, data in pairs(self._itemUseData or {}) do
		if data.hasAddCount > 0 then
			addNum = addNum + data.exInfo * data.hasAddCount
		end
	end

	return addNum
end

function M:_refreshView()
	local energyMaxPlayer = PlayerModel.instance:getEnergyLimit()
	local finalWantAddEnergyNum = self:getCurWantAddEnergyNum()
	local curEnergyNum = HealthExchangeModel.instance:getCurEnergy()
	local finalEnergy = curEnergyNum + finalWantAddEnergyNum
	local isMaxEnergy = energyMaxPlayer < finalEnergy

	self._txtWantAddEnergy.text = string.format("%s", finalEnergy)

	if isMaxEnergy then
		self._txtWantAddEnergy.color = parsecolor(MoneyUtil.CurEnergyReachMaxColor)
	else
		self._txtWantAddEnergy.color = parsecolor(MoneyUtil.CurEnergyNormalColor)
	end

	self._txtMaxEnergy.text = string.format("/%s", energyMaxPlayer)
	self._txtCurEnergy.text = curEnergyNum

	self:setBtnConfirmInteractable(finalWantAddEnergyNum > 0)
end

function M:_refreshEnergyDrugScrollView()
	local len = self._itemLst and #self._itemLst or 0

	self._canScroll = len > 6

	goutil.setActive(self._scroll.gameObject, len > 0)
	goutil.setActive(self._noDrugTipsGo, len == 0)
	goutil.setActive(self._goPanel, len > 0)

	if len > 0 then
		self._cellIndex = {}

		if not self._canScroll then
			for _, _itemData in ipairs(self._itemLst) do
				table.insert(self._cellIndex, _itemData:getUuid())
			end
		end

		self._scroll.enabled = self._canScroll

		if self._loopGridView:GetLoopGridView().ItemTotalCount ~= len then
			self._loopGridView:SetListItemCount(len, true)
		else
			self._loopGridView:RefreshAllShownItem()
		end

		self:_dealScrollContent()
	else
		self._loopGridView:ClearCells()
	end
end

function M:_dealScrollContent()
	if goutil.isNil(self._gridLayoutContent) then
		return
	end

	if goutil.isNil(self._rectTrScroll) then
		return
	end

	local layoutEnabled = not self._canScroll

	self._gridLayoutContent.enabled = false
	self._gridLayoutContent.enabled = layoutEnabled

	if layoutEnabled then
		local width = RectTransformUtils.GetWidth(self._rectTrScroll)

		RectTransformUtils.SetWidth(self._rectTrContent, width)
	end
end

function M:onClickConfirm()
	local readyNum = self:getCurWantAddEnergyNum()

	if readyNum == 0 then
		ToolTipsMgr.showCharacterTopToast(lang("tip_power_no_select"), CommEnum.CharacterTopToastIcon.Info, 1)
	else
		HealthExchangeModel.instance:prepareUseDrug(self._itemUseData)
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._loopGridView:NewListViewItem("backpack_item")
	local itemData = self._itemLst[curIndex]
	local count = itemData:getCount()
	local shower = Astral.SimpleLuaComponentContainer.Get(item.gameObject, ItemCell)

	if not shower then
		shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, ItemCell)

		shower:getComponent("normal"):setClickListener(self._onItemClick, self)

		local compSign = shower:getComponent("sign")

		if not compSign then
			shower:_addComponent("sign", BackpackSignComponent)

			compSign = shower:getComponent("sign")

			compSign:onInit()
		end
	end

	shower:updateData(itemData)
	shower:setShowTipsPassEvent(false)
	shower:setShowSelectedEffect(false)
	shower:getComponent("num"):setNumBgNodeVisible(false)
	shower:getComponent("num"):setCountText(count > 0 and count or tostring(count))
	self:_updateCellOperate(shower)

	if not self._canScroll then
		local _index = table.indexof(self._cellIndex, itemData:getUuid())

		item.transform:SetSiblingIndex(_index)
	end

	return item
end

function M:_updateCellOperate(cell)
	local itemData = cell:getData()
	local itemId = itemData:getItemId()
	local uuid = itemData:getUuid()
	local useData = self._itemUseData[uuid]
	local hasAddCount = useData.hasAddCount
	local compOperate = cell:getComponent("operate")

	if not compOperate then
		cell:_addComponent("operate", LongClickComponent)

		compOperate = cell:getComponent("operate")

		compOperate:onInit()
		compOperate:setAddCallback(self._onItemAdd, self)
		compOperate:setReduceCallback(self._onItemMinus, self)
		compOperate:setBtnCutGoVisible(false)
		compOperate:setBtnCutMoreGoVisible(true)
		compOperate:setCountGoVisible(true)
	end

	compOperate:setCount(hasAddCount)
	compOperate:setImgOperateGoVisible(hasAddCount > 0)
end

function M:_onItemClick(cell)
	local itemData = cell:getData()
	local itemId = itemData:getItemId()
	local uuid = itemData:getUuid()
	local _ownNum = ItemModel.instance:getItemDataByUuid(uuid):getCount()

	if _ownNum > 0 then
		local canAdd, overRecoverMax, overMax = self:_tryAddItem(itemId, uuid, true)

		if not canAdd then
			return
		end

		cell:getComponent("operate"):setImgOperateGoVisible(true)
		self:_onItemAdd(cell)
	else
		cell:dealSelect()
	end
end

function M:_onItemAdd(cell)
	local itemData = cell:getData()

	if not itemData then
		return
	end

	local itemId = itemData:getItemId()
	local uuid = itemData:getUuid()

	itemData = ItemModel.instance:getItemDataByUuid(uuid)

	local useData = self._itemUseData[uuid]
	local wantedAdd = useData.hasAddCount + 1
	local enoughToAdd = wantedAdd <= itemData:getCount()

	if not enoughToAdd then
		return
	end

	local canAdd, overRecoverMax, overMax = self:_tryAddItem(itemId, uuid, true)

	if not canAdd then
		return
	end

	self._itemUseData[uuid].hasAddCount = wantedAdd

	self:_updateCellOperate(cell)
	self:_refreshView()
end

function M:_onItemMinus(cell)
	local itemData = cell:getData()
	local itemId = itemData:getItemId()
	local uuid = itemData:getUuid()
	local useData = self._itemUseData[uuid]
	local wantedAdd = useData.hasAddCount - 1

	if wantedAdd < 0 then
		return
	end

	self._itemUseData[uuid].hasAddCount = wantedAdd

	self:_updateCellOperate(cell)
	self:_refreshView()
end

function M:_tryAddItem(itemId, uuid, showToast)
	local data = self._itemUseData[uuid]
	local energy = data.exInfo
	local canAdd, overRecoverMax, overMax = true, false, false

	if energy > 0 then
		local _curEnergy = HealthExchangeModel.instance:getCurEnergy()
		local _curAdd = self:getCurWantAddEnergyNum()

		if _curEnergy + _curAdd + energy > self._energyRecoverMax then
			canAdd = false
			overRecoverMax = true
			overMax = false
		elseif _curEnergy + _curAdd + energy > self._energyMax then
			canAdd = false
			overRecoverMax = false
			overMax = true
		end
	end

	if showToast and not ViewMgr.instance:isOpen(ViewName.CharacterTopToastTips) then
		if overRecoverMax then
			ToolTipsMgr.showCharacterTopToast(langF("tip_power_add_fail_by_recover_limit", self._energyRecoverMax), CommEnum.CharacterTopToastIcon.Fail, 1)
		elseif overMax then
			ToolTipsMgr.showCharacterTopToast(lang("tip_power_max"), CommEnum.CharacterTopToastIcon.Fail, 1)
		end
	end

	return canAdd, overRecoverMax, overMax
end

return M
