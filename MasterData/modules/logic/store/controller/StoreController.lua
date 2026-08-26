-- chunkname: @modules/logic/store/controller/StoreController.lua

module("modules.logic.store.controller.StoreController", package.seeall)

local StoreController = class("StoreController", BaseController)

function StoreController:onInit()
	self._lastViewStoreId = 0
	self._viewTime = nil
	self._tabTime = nil
	self._lastViewGoodsId = 0
	self._goodsTime = nil
end

function StoreController:onInitFinish()
	self._lastViewStoreId = 0
	self._viewTime = nil
	self._tabTime = nil
end

function StoreController:addConstEvents()
	return
end

function StoreController:reInit()
	self.enteredRecommendStoreIdList = nil
end

function StoreController:checkAndOpenStoreView(jumpTab, jumpGoodsId, isFocus)
	local isCanOpen = false

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Bank) then
		self:openStoreView(jumpTab, jumpGoodsId, isFocus)

		isCanOpen = true
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Bank))
	end

	return isCanOpen
end

function StoreController:openStoreView(jumpTab, jumpGoodsId, isFocus)
	local param = {}

	param.jumpTab = jumpTab
	param.jumpGoodsId = jumpGoodsId
	param.isFocus = isFocus

	ViewMgr.instance:openView(ViewName.StoreView, param)
end

function StoreController:openNormalGoodsView(normalGoodsMO)
	if normalGoodsMO.belongStoreId == StoreEnum.StoreId.NewRoomStore or normalGoodsMO.belongStoreId == StoreEnum.StoreId.OldRoomStore then
		if self:isRoomBlockGift(normalGoodsMO) then
			ViewMgr.instance:openView(ViewName.RoomBlockGiftStoreGoodsView, normalGoodsMO)
		else
			RoomController.instance:openStoreGoodsTipView(normalGoodsMO)
		end
	else
		ViewMgr.instance:openView(ViewName.NormalStoreGoodsView, normalGoodsMO)
	end
end

function StoreController:isRoomBlockGift(normalGoodsMO)
	if string.nilorempty(normalGoodsMO.config.product) then
		return
	end

	local productArr = GameUtil.splitString2(normalGoodsMO.config.product, true)
	local itemType = productArr[1][1]
	local itemId = productArr[1][2]
	local config = ItemModel.instance:getItemConfig(itemType, itemId)

	return config.subType == ItemEnum.SubType.RoomBlockGift or config.subType == ItemEnum.SubType.RoomBlockGiftNew
end

function StoreController:openChargeGoodsView(chargeGoodsMO)
	ViewMgr.instance:openView(ViewName.ChargeStoreGoodsView, chargeGoodsMO)
end

function StoreController:openPackageStoreGoodsView(packageGoodsMO)
	local goodsType = packageGoodsMO.config.type
	local belongStoreId = packageGoodsMO.belongStoreId

	if goodsType == StoreEnum.StoreChargeType.Optional then
		local optionalTypeView = {
			[StoreEnum.chargeOptionalType.PosOption] = ViewName.OptionalChargeView,
			[StoreEnum.chargeOptionalType.GroupOption] = ViewName.OptionalGroupChargeView
		}
		local chargeOptionCoList = StoreConfig.instance:getChargeOptionalGroup(packageGoodsMO.config.id)
		local viewName = chargeOptionCoList and optionalTypeView[chargeOptionCoList[1].type]

		if not viewName then
			logError("充值商品" .. packageGoodsMO.config.id .. "对应的自选礼包或类型配置错误")

			return
		end

		ViewMgr.instance:openView(viewName, packageGoodsMO)
	elseif goodsType == StoreEnum.StoreChargeType.LinkGiftGoods then
		ViewMgr.instance:openView(ViewName.StoreLinkGiftGoodsView, packageGoodsMO)
	elseif goodsType == StoreEnum.StoreChargeType.NationalGift then
		local param = {}

		param.goodMo = packageGoodsMO

		NationalGiftController.instance:openNationalGiftBuyTipView(param)
	elseif belongStoreId == StoreEnum.StoreId.Skin then
		ViewMgr.instance:openView(ViewName.StoreSkinGoodsView2, {
			index = 1,
			goodsMO = packageGoodsMO
		})
	elseif goodsType == StoreEnum.StoreChargeType.SceneUIPackage then
		ViewMgr.instance:openView(ViewName.SceneUIPackageGoodsTipView, {
			canJump = true,
			goodsId = packageGoodsMO.config.id
		})
	elseif PackageStoreEnum.DecorateCombinationIdDic[packageGoodsMO.config.id] then
		ViewMgr.instance:openView(ViewName.StoreDecorateCombinationView, {
			canJump = true,
			goodsId = packageGoodsMO.config.id
		})
	else
		ViewMgr.instance:openView(ViewName.PackageStoreGoodsView, packageGoodsMO)
	end
end

function StoreController:openDecorateStoreGoodsView(decorateGoodsMO)
	if DecorateStoreConfig.instance:isFatherOrSonGoods(decorateGoodsMO.config.id) then
		ViewMgr.instance:openView(ViewName.DecorateMultiGoodsTipsView, {
			goodsId = decorateGoodsMO.config.id
		})

		return
	end

	local productsList = GameUtil.splitString2(decorateGoodsMO.config.product, true, "|", "#")

	if #productsList == 1 then
		local products = productsList[1]
		local itemCo = ItemModel.instance:getItemConfig(products[1], products[2])

		if itemCo.subType == ItemEnum.SubType.PlayerBg then
			local param = {
				goodsMo = decorateGoodsMO
			}

			ViewMgr.instance:openView(ViewName.DecorateStoreGoodsBuyView, param)
		elseif SceneUIPackageModel.instance:isInSceneUIPackage(products[2]) then
			ViewMgr.instance:openView(ViewName.MainSceneSkinMaterialTipView2, {
				canJump = true,
				isShowTop = true,
				goodsId = decorateGoodsMO.goodsId
			})
		else
			ViewMgr.instance:openView(ViewName.DecorateStoreGoodsView, decorateGoodsMO)
		end
	elseif #productsList > 1 then
		local goodsId = decorateGoodsMO.goodsId
		local isPackage = SceneUIPackageModel.instance:isPackage(goodsId)

		if isPackage then
			ViewMgr.instance:openView(ViewName.MainSceneSkinMaterialTipView2, {
				canJump = true,
				isShowTop = false,
				goodsId = decorateGoodsMO.goodsId
			})
		end
	end
end

function StoreController:openSummonStoreGoodsView(goodsMO)
	if goodsMO.belongStoreId == StoreEnum.StoreId.RoomStore then
		RoomController.instance:openStoreGoodsTipView(goodsMO)
	else
		ViewMgr.instance:openView(ViewName.SummonStoreGoodsView, goodsMO)
	end
end

function StoreController:buyGoods(storeGoodsMO, quantity, callback, callbackObj, selectCost)
	StoreRpc.instance:sendBuyGoodsRequest(storeGoodsMO.belongStoreId, storeGoodsMO.goodsId, quantity, callback, callbackObj, selectCost)
end

function StoreController:forceReadTab(jumpTab)
	local storeId = StoreModel.instance:jumpTabIdToStoreId(jumpTab)

	self:_readTab(storeId)
end

function StoreController:readTab(jumpTab)
	local storeId = StoreModel.instance:jumpTabIdToStoreId(jumpTab)

	if storeId == self._lastViewStoreId then
		return
	end

	self:_readTab(storeId)
	self:clearMarkedPackageGoodsRedDot()
end

function StoreController:_readTab(storeId)
	local dotInfo = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreGoodsRead)

	if dotInfo then
		local storedotinfos = dotInfo.infos
		local goodsIds = {}

		for _, v in pairs(storedotinfos) do
			local goodsMo = StoreModel.instance:getGoodsMO(v.uid)

			if goodsMo and storeId == goodsMo.belongStoreId then
				table.insert(goodsIds, v.uid)
			end
		end

		if #goodsIds > 0 then
			StoreRpc.instance:sendReadStoreNewRequest(goodsIds)
		end
	end

	dotInfo = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.StoreChargeGoodsRead)

	if dotInfo then
		local storedotinfos = dotInfo.infos
		local goodsIds = {}

		for _, v in pairs(storedotinfos) do
			local goodsMo = StoreModel.instance:getGoodsMO(v.uid)

			if goodsMo and storeId == goodsMo.belongStoreId then
				table.insert(goodsIds, v.uid)
			end
		end

		if #goodsIds > 0 then
			local isPackageStore = StoreConfig.instance:isPackageStore(storeId)

			if not isPackageStore then
				ChargeRpc.instance:sendReadChargeNewRequest(goodsIds)
			else
				local ids = {}

				for _, goodsId in pairs(goodsIds) do
					local storePackageGoodsMO = StoreModel.instance:getGoodsMO(goodsId)
					local serverTime = ServerTime.now()
					local inTime = serverTime >= storePackageGoodsMO.newStartTime and serverTime <= storePackageGoodsMO.newEndTime

					if not inTime then
						table.insert(ids, goodsId)
					end
				end

				if ids and next(ids) then
					ChargeRpc.instance:sendReadChargeNewRequest(ids)
				end
			end
		end
	end
end

function StoreController:checkStoreCurrencyExchange(jumpTab)
	local storeId = StoreModel.instance:jumpTabIdToStoreId(jumpTab)

	if storeId == self._lastViewStoreId then
		return
	end

	if not ViewMgr.instance:isOpen(ViewName.StoreView) and ViewMgr.instance:isOpen(ViewName.StoreView) then
		return
	end

	local currencyId = CurrencyExchangeConfig.instance:getExchangeCurrencyIdByStoreId(storeId)

	if not currencyId then
		return
	end

	local exchangeConfig = CurrencyExchangeConfig.instance:getExchangeConfig(currencyId)

	if not exchangeConfig then
		return
	end

	local versionConstConfig = lua_const.configDict[ConstEnum.VersionId]
	local version = tonumber(versionConstConfig.value)

	if exchangeConfig.versionId ~= version then
		return
	end

	local infoMo = CurrencyExchangeModel.instance:getInfoMo(storeId)

	if not infoMo or infoMo:isProped() == true then
		return
	end

	logNormal("打开对应的货币转化弹窗")
	CurrencyExchangeController.instance:setCurrencyExchangeState(exchangeConfig.currencyId)
end

function StoreController:statSwitchStore(jumpTab)
	local storeId = StoreModel.instance:jumpTabIdToStoreId(jumpTab)

	if storeId == self._lastViewStoreId then
		return
	end

	if not self._viewTime then
		StatController.instance:track(StatEnum.EventName.StoreEnter, {
			[StatEnum.EventProperties.StoreId] = tostring(storeId)
		})

		self._viewTime = ServerTime.now()
	else
		StatController.instance:track(StatEnum.EventName.SwitchStore, {
			[StatEnum.EventProperties.BeforeStoreId] = tostring(self._lastViewStoreId),
			[StatEnum.EventProperties.AfterStoreId] = tostring(storeId),
			[StatEnum.EventProperties.Time] = (self._tabTime or nil) and ServerTime.now() - self._tabTime
		})
	end

	self._tabTime = ServerTime.now()
	self._lastViewStoreId = storeId
end

function StoreController:onSwitchTab(jumpTab)
	self:checkStoreCurrencyExchange(jumpTab)
	self:statSwitchStore(jumpTab)
end

function StoreController:statExitStore()
	StatController.instance:track(StatEnum.EventName.StoreExit, {
		[StatEnum.EventProperties.StoreId] = tostring(self._lastViewStoreId),
		[StatEnum.EventProperties.Time] = (self._viewTime or nil) and ServerTime.now() - self._viewTime
	})

	self._lastViewStoreId = 0
	self._viewTime = nil
	self._tabTime = nil
end

function StoreController:statOpenGoods(storeId, goodsConfig)
	if not goodsConfig then
		return
	end

	if ChargePushStatController.instance:statClick(goodsConfig.id) then
		return
	end

	self._lastViewGoodsId = goodsConfig.id
	self._goodsTime = ServerTime.now()

	local product = goodsConfig.product
	local productInfo = string.split(product, "#")
	local itemType = tonumber(productInfo[1])
	local itemId = tonumber(productInfo[2])
	local itemQuantity = tonumber(productInfo[3])
	local itemConfig = ItemModel.instance:getItemConfig(itemType, itemId)
	local var_21_0 = StatEnum.EventName.ClickGoods
	local var_21_1 = {
		[StatEnum.EventProperties.StoreId] = tostring(storeId),
		[StatEnum.EventProperties.GoodsId] = goodsConfig.id
	}

	if itemConfig then
		var_21_1[StatEnum.EventProperties.MaterialName] = itemConfig.name or ""
	end

	var_21_1[StatEnum.EventProperties.MaterialNum] = itemQuantity
	var_21_1[StatEnum.EventProperties.OpenViewList] = self:_copyOpenViewList()

	StatController.instance:track(var_21_0, var_21_1)
end

function StoreController:statOpenChargeGoods(storeId, goodsConfig)
	if not goodsConfig then
		return
	end

	if ChargePushStatController.instance:statClick(goodsConfig.id) then
		return
	end

	self._lastViewGoodsId = goodsConfig.id
	self._goodsTime = ServerTime.now()

	local var_22_0 = StatEnum.EventName.ClickGoods
	local var_22_1 = {
		[StatEnum.EventProperties.StoreId] = tostring(storeId),
		[StatEnum.EventProperties.GoodsId] = goodsConfig.id
	}

	if goodsConfig then
		var_22_1[StatEnum.EventProperties.MaterialName] = goodsConfig.name or ""
	end

	var_22_1[StatEnum.EventProperties.MaterialNum] = 1
	var_22_1[StatEnum.EventProperties.OpenViewList] = self:_copyOpenViewList()

	StatController.instance:track(var_22_0, var_22_1)
end

function StoreController:statStartPay(goodsId)
	StatController.instance:track(StatEnum.EventName.GameOrder, {
		[StatEnum.EventProperties.Gearid] = tostring(goodsId),
		[StatEnum.EventProperties.OpenViewList] = self:_copyOpenViewList()
	})
end

function StoreController:_copyOpenViewList()
	local openViewList = {}

	tabletool.addValues(openViewList, ViewMgr.instance:getOpenViewNameList())

	return openViewList
end

function StoreController:statCloseGoods(goodsConfig)
	if not goodsConfig then
		return
	end

	if self._lastViewGoodsId ~= goodsConfig.id then
		return
	end

	local duration = 0

	if self._goodsTime then
		duration = ServerTime.now() - self._goodsTime
	end

	self._lastViewGoodsId = 0
end

function StoreController:recordExchangeSkinDiamond(diamondQuantity)
	self.exchangeDiamondQuantity = diamondQuantity
end

function StoreController:statBuyGoods(storeId, goodsId, buyCount, existBuyCount, selectCost)
	selectCost = selectCost or 1

	local goodsConfig = StoreConfig.instance:getGoodsConfig(goodsId)
	local productItem = goodsConfig.product
	local cost

	if storeId == StoreEnum.StoreId.RoomStore then
		productItem = self.roomStoreCanBuyGoodsStr
		cost = self:_itemsMultipleWithBuyCount(self.recordCostItem, buyCount, existBuyCount)
	elseif storeId == StoreEnum.StoreId.Skin and self.exchangeDiamondQuantity and self.exchangeDiamondQuantity > 0 then
		local arr = string.splitToNumber(goodsConfig.cost, "#")
		local srcType, srcId, costTotalQuantity = arr[1], arr[2], arr[3]
		local cost1 = {
			type = MaterialEnum.MaterialType.Currency,
			id = CurrencyEnum.CurrencyType.Diamond,
			quantity = self.exchangeDiamondQuantity
		}
		local cost2 = {
			type = srcType,
			id = srcId,
			quantity = costTotalQuantity - self.exchangeDiamondQuantity
		}

		cost = self:_generateItemListJson({
			cost1,
			cost2
		})
		self.exchangeDiamondQuantity = 0
	else
		cost = self:_itemsMultipleWithBuyCount(goodsConfig.cost, buyCount, existBuyCount)
	end

	local product = self:_itemsMultiple(productItem, buyCount)

	StatController.instance:track(StatEnum.EventName.ServerBuyGoods, {
		[StatEnum.EventProperties.ServerStoreId] = tostring(storeId),
		[StatEnum.EventProperties.ServerCost] = cost,
		[StatEnum.EventProperties.ServerGoodsId] = goodsConfig.id,
		[StatEnum.EventProperties.ServerBuyCount] = buyCount,
		[StatEnum.EventProperties.ServerGainMaterial] = product
	})
end

function StoreController:statVersionActivityBuyGoods(activityId, goodsId, buyCount, existBuyCount)
	local goodsConfig = ActivityStoreConfig.instance:getStoreConfig(activityId, goodsId)
	local cost = self:_itemsMultipleWithBuyCount(goodsConfig.cost, buyCount, existBuyCount)
	local product = self:_itemsMultiple(goodsConfig.product, buyCount)

	StatController.instance:track(StatEnum.EventName.ServerBuyGoods, {
		[StatEnum.EventProperties.ServerStoreId] = tostring(activityId),
		[StatEnum.EventProperties.ServerCost] = cost,
		[StatEnum.EventProperties.ServerGoodsId] = goodsId,
		[StatEnum.EventProperties.ServerBuyCount] = buyCount,
		[StatEnum.EventProperties.ServerGainMaterial] = product
	})
end

function StoreController:recordRoomStoreCurrentCanBuyGoods(goodsId, selectCost, costNum)
	local goodsConfig = StoreConfig.instance:getGoodsConfig(goodsId)

	self.recordCostItem = selectCost == 1 and goodsConfig.cost or selectCost == 2 and goodsConfig.cost2 or goodsConfig.cost
	self.roomStoreCanBuyGoodsStr = goodsConfig.product

	local productList = string.split(goodsConfig.product, "|")

	if #productList > 1 then
		local costTab = string.split(self.recordCostItem, "#")
		local canBuyItemList = {}

		costTab[3] = costNum

		for index, product in ipairs(productList) do
			local productArr = string.splitToNumber(product, "#")
			local hasQuantity = ItemModel.instance:getItemQuantity(productArr[1], productArr[2])
			local itemConfig = ItemModel.instance:getItemConfig(productArr[1], productArr[2])

			if itemConfig then
				if not itemConfig.numLimit then
					local numLimit = 1

					if numLimit == 0 or hasQuantity < numLimit then
						table.insert(canBuyItemList, string.format("%s#%s#%s", productArr[1], productArr[2], numLimit - hasQuantity))
					end
				end
			end
		end

		self.recordCostItem = table.concat(costTab, "#")
		self.roomStoreCanBuyGoodsStr = table.concat(canBuyItemList, "|")
	end
end

function StoreController:_itemsMultiple(item, buyCount)
	if string.nilorempty(item) or buyCount <= 0 then
		return {}
	end

	local items = GameUtil.splitString2(item, true)
	local result = {}

	for i, itemParams in ipairs(items) do
		local item = {
			type = itemParams[1],
			id = itemParams[2],
			quantity = itemParams[3] * buyCount
		}

		table.insert(result, item)
	end

	return self:_generateItemListJson(result)
end

function StoreController:_itemsMultipleWithBuyCount(items, buyCount, existBuyCount)
	if string.nilorempty(items) or buyCount <= 0 then
		return {}
	end

	local result = {}
	local costs = string.split(items, "|")

	for index = existBuyCount + 1, existBuyCount + buyCount do
		if not costs[index] then
			local costParam = costs[#costs]
			local costInfo = string.splitToNumber(costParam, "#")

			if index >= #costs then
				table.insert(result, {
					type = costInfo[1],
					id = costInfo[2],
					quantity = costInfo[3] * (existBuyCount + buyCount - index + 1)
				})

				break
			else
				table.insert(result, {
					type = costInfo[1],
					id = costInfo[2],
					quantity = costInfo[3]
				})
			end
		end
	end

	if #result <= 0 then
		return {}
	end

	local merged = {}

	for i, item in ipairs(result) do
		merged[item.type] = merged[item.type] or {}
		merged[item.type][item.id] = (merged[item.type][item.id] or 0) + item.quantity
	end

	result = {}

	for type, dict in pairs(merged) do
		for id, quantity in pairs(dict) do
			table.insert(result, {
				type = type,
				id = id,
				quantity = quantity
			})
		end
	end

	return self:_generateItemListJson(result)
end

function StoreController:_generateItemListJson(result)
	if not result or #result <= 0 then
		return {}
	end

	local itemListJson = {}

	for i, item in ipairs(result) do
		local config = ItemModel.instance:getItemConfig(item.type, item.id)
		local var_32_0 = {}

		if config then
			var_32_0.materialname = config.name or ""
		end

		var_32_0.materialtype = item.type
		var_32_0.materialnum = item.quantity

		table.insert(itemListJson, var_32_0)
	end

	return itemListJson
end

function StoreController:isNeedShowRedDotNewTag(recommendStoreConfig)
	return recommendStoreConfig and recommendStoreConfig.type == 0 and not string.nilorempty(recommendStoreConfig.onlineTime)
end

function StoreController:initEnteredRecommendStoreList()
	local key = PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId()
	local str = PlayerPrefsHelper.getString(key, "")

	if string.nilorempty(str) then
		self.enteredRecommendStoreIdList = {}

		return
	end

	self.enteredRecommendStoreIdList = string.splitToNumber(str, ";")
end

function StoreController:enterRecommendStore(storeId)
	if not self.enteredRecommendStoreIdList then
		self:initEnteredRecommendStoreList()
	end

	if tabletool.indexOf(self.enteredRecommendStoreIdList, storeId) then
		return
	end

	table.insert(self.enteredRecommendStoreIdList, storeId)
	ActivityController.instance:dispatchEvent(ActivityEvent.ChangeActivityStage)

	local key = PlayerPrefsKey.EnteredRecommendStoreKey .. PlayerModel.instance:getMyUserId()

	PlayerPrefsHelper.setString(key, table.concat(self.enteredRecommendStoreIdList, ";"))
end

function StoreController:isEnteredRecommendStore(storeId)
	if not self.enteredRecommendStoreIdList then
		self:initEnteredRecommendStoreList()
	end

	return tabletool.indexOf(self.enteredRecommendStoreIdList, storeId)
end

function StoreController:getRecommendStoreTime(config)
	if not config then
		return
	end

	if string.nilorempty(config.showOnlineTime) then
		if not config.onlineTime then
			local configStartTime = config.showOnlineTime

			if string.nilorempty(config.showOfflineTime) then
				if not config.offlineTime then
					local configEndTime = config.showOfflineTime
					local onlineTimeStamp = TimeUtil.stringToTimestamp(configStartTime) + ServerTime.clientToServerOffset()
					local offlineTimeStamp = TimeUtil.stringToTimestamp(configEndTime) + ServerTime.clientToServerOffset()
					local startMonth = tonumber(os.date("%m", onlineTimeStamp))
					local startDay = tonumber(os.date("%d", onlineTimeStamp))
					local startHour = tonumber(os.date("%H", onlineTimeStamp))
					local startMinute = string.format("%02d", tonumber(os.date("%M", onlineTimeStamp)))
					local endMonth = tonumber(os.date("%m", offlineTimeStamp))
					local endDay = tonumber(os.date("%d", offlineTimeStamp))
					local endHour = tonumber(os.date("%H", offlineTimeStamp))
					local endMinute = string.format("%02d", tonumber(os.date("%M", offlineTimeStamp)))

					return GameUtil.getSubPlaceholderLuaLang(luaLang("store_recommendTime"), {
						startMonth,
						startDay,
						startHour,
						startMinute,
						endMonth,
						endDay,
						endHour,
						endMinute
					})
				end
			end
		end
	end
end

function StoreController:onUseItemInStore(msg)
	if not msg then
		return
	end

	if msg.entry and msg.entry[1].materialId and (msg.entry[1].materialId == StoreEnum.NormalRoomTicket or msg.entry[1].materialId == StoreEnum.TopRoomTicket) and ViewMgr.instance:isOpen(ViewName.StoreView) then
		StoreController.instance:dispatchEvent(StoreEvent.GoodsModelChanged, tonumber(msg.targetId))
	end
end

function StoreController:statOnClickPowerPotion(powerPotionName)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotion, {
		[StatEnum.EventProperties.WindowName] = powerPotionName
	})
end

function StoreController:statOnClickPowerPotionJump(powerPotionName, jumpName)
	StatController.instance:track(StatEnum.EventName.ClickPowerPotionJump, {
		[StatEnum.EventProperties.WindowName] = powerPotionName,
		[StatEnum.EventProperties.JumpName] = jumpName
	})
end

function StoreController:needHideHome()
	if self._needHideBackHomeViews == nil then
		self._needHideBackHomeViews = {
			ViewName.SummonResultView,
			ViewName.SummonADView
		}
	end

	for i = 1, #self._needHideBackHomeViews do
		if ViewMgr.instance:isOpen(self._needHideBackHomeViews[i]) then
			return true
		end
	end

	return false
end

function StoreController:clearMarkedPackageGoodsRedDot()
	local goodsDic = StoreModel.instance:getMarkedPackageGoodsNewRedDot()

	if goodsDic and next(goodsDic) then
		local ids = {}

		for goodsId, _ in pairs(goodsDic) do
			logNormal("清除充值礼包红点标记 id:" .. tostring(goodsId))
			table.insert(ids, goodsId)
		end

		ChargeRpc.instance:sendReadChargeNewRequest(ids)
		StoreModel.instance:clearMarkedPackageGoodsNewRedDot()
	end
end

StoreController.instance = StoreController.New()

return StoreController
