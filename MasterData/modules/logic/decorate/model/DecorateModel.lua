-- chunkname: @modules/logic/decorate/model/DecorateModel.lua

module("modules.logic.decorate.model.DecorateModel", package.seeall)

local DecorateModel = class("DecorateModel", BaseModel)

function DecorateModel:getItemIcon(itemConfig, goodsId)
	if not itemConfig then
		return
	end

	if itemConfig.subType == ItemEnum.SubType.PlayerBg then
		return ResUrl.getDecorateStoreBuyBannerFullPath(itemConfig.id)
	end

	local itemDecorateCo, classify = self:getItemDecorateCo(itemConfig)

	if itemDecorateCo then
		if itemConfig.subType == ItemEnum.SubType.MainSceneSkin then
			return ResUrl.getMainSceneSwitchIcon(itemDecorateCo.previewIcon)
		end

		if itemConfig.subType == ItemEnum.SubType.MainUISkin then
			if classify == MainSwitchClassifyEnum.Classify.UI then
				return ResUrl.getMainSceneSwitchLangIcon(itemDecorateCo.previewIcon)
			end

			return ResUrl.getMainSceneSwitchIcon(itemDecorateCo.previewIcon)
		end

		if itemConfig.subType == ItemEnum.SubType.FightCard or itemConfig.subType == ItemEnum.SubType.FightFloatType then
			return ResUrl.getMainSceneSwitchIcon(itemDecorateCo.previewImage)
		end
	end

	itemDecorateCo = DecorateStoreConfig.instance:getDecorateConfig(goodsId)

	if itemDecorateCo then
		return ResUrl.getDecorateStoreImg(itemDecorateCo.buylmg)
	end
end

function DecorateModel:getGoodsBuyIcon(itemConfig, goodsId)
	return self:getItemIcon(itemConfig, goodsId)
end

function DecorateModel:getItemDecorateCo(itemConfig)
	if not itemConfig then
		return
	end

	if itemConfig.subType == ItemEnum.SubType.MainSceneSkin then
		return MainSceneSwitchConfig.instance:getConfigByItemId(itemConfig.id)
	end

	if itemConfig.subType == ItemEnum.SubType.MainUISkin then
		local classify = MainSwitchClassifyEnum.Classify.UI
		local uiCo = MainUISwitchConfig.instance:getUISwitchCoByItemId(itemConfig.id)

		if not uiCo then
			uiCo = ClickUISwitchConfig.instance:getClickUICoByItemId(itemConfig.id)
			classify = MainSwitchClassifyEnum.Classify.Click
		end

		return uiCo, classify
	end

	if itemConfig.subType == ItemEnum.SubType.FightCard or itemConfig.subType == ItemEnum.SubType.FightFloatType then
		return FightUISwitchConfig.instance:getStyleCoByItemId(itemConfig.id)
	end
end

function DecorateModel:getItemSource(itemConfig)
	if not itemConfig then
		return
	end

	if itemConfig.subType == ItemEnum.SubType.MainSceneSkin then
		return MainSceneSwitchConfig.instance:getItemSource(itemConfig.id)
	end

	if itemConfig.subType == ItemEnum.SubType.MainUISkin then
		local uiCo = MainUISwitchConfig.instance:getUISwitchCoByItemId(itemConfig.id)

		if uiCo then
			return MainUISwitchConfig.instance:getItemSource(itemConfig.id)
		else
			return ClickUISwitchConfig.instance:getItemSource(itemConfig.id)
		end
	end

	if itemConfig.subType == ItemEnum.SubType.FightCard or itemConfig.subType == ItemEnum.SubType.FightFloatType then
		return FightUISwitchConfig.instance:getItemSource(itemConfig.id)
	end
end

function DecorateModel:isCurMaterial(itemConfig)
	if not itemConfig then
		return
	end

	if itemConfig.subType == ItemEnum.SubType.PlayerBg then
		return StoreModel.instance:isStoreDecorateGoodsValid(itemConfig.id)
	end

	local status = self:getItemStatus(itemConfig)

	if status == DecorateEnum.SceneStutas.Lock then
		return false
	end

	return true
end

function DecorateModel:getItemStatus(itemConfig)
	local config = self:getItemDecorateCo(itemConfig)

	if not config then
		return DecorateEnum.SceneStutas.Lock
	end

	if config.defaultUnlock == 1 then
		return DecorateEnum.SceneStutas.Unlock
	end

	local num = ItemModel.instance:getItemCount(itemConfig.id)

	if num > 0 then
		return DecorateEnum.SceneStutas.Unlock
	end

	if self:canJump(itemConfig) then
		return DecorateEnum.SceneStutas.LockCanGet
	end

	return DecorateEnum.SceneStutas.Lock
end

function DecorateModel:canJump(itemConfig)
	if not itemConfig then
		return
	end

	local sourceTables = self:getItemSource(itemConfig)

	if not sourceTables then
		return
	end

	for i, sourceTable in ipairs(sourceTables) do
		local cantJumpTips, toastParamList = self:getCantJump(sourceTable)

		if not cantJumpTips then
			return true
		end
	end

	return false
end

function DecorateModel:getCantJump(sourceTable)
	if not sourceTable then
		return
	end

	local open = JumpController.instance:isJumpOpen(sourceTable.sourceId)
	local jumpConfig = JumpConfig.instance:getJumpConfig(sourceTable.sourceId)

	if open then
		return JumpController.instance:cantJump(jumpConfig.param)
	end

	return OpenHelper.getToastIdAndParam(jumpConfig.openId)
end

function DecorateModel:collectSource(itemId)
	local itemConfig = lua_item.configDict[itemId]

	if not itemConfig then
		return
	end

	local sourcesStr = itemConfig.sources
	local sourceTables = {}

	if not string.nilorempty(sourcesStr) then
		local sources = string.split(sourcesStr, "|")

		for i, source in ipairs(sources) do
			local sourceParam = string.splitToNumber(source, "#")
			local sourceTable = {}

			sourceTable.sourceId = sourceParam[1]
			sourceTable.probability = sourceParam[2]
			sourceTable.episodeId = JumpConfig.instance:getJumpEpisodeId(sourceTable.sourceId)

			if sourceTable.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(sourceTable.episodeId) then
				table.insert(sourceTables, sourceTable)
			end
		end
	end

	return sourceTables
end

function DecorateModel:hasSceneGoods(goodsId)
	local goodConfig = StoreConfig.instance:getGoodsConfig(goodsId)
	local productsList = GameUtil.splitString2(goodConfig.product, true, "|", "#")

	for _, v in ipairs(productsList) do
		local itemConfig = ItemModel.instance:getItemConfig(v[1], v[2])

		if itemConfig.subType == ItemEnum.SubType.MainSceneSkin then
			return true
		end
	end

	return false
end

function DecorateModel:getPackageGoodsIds(goodsId)
	local goodsIds = self:getPackageAllGoodsIds(goodsId)
	local ids = {}

	if goodsIds then
		for _, id in ipairs(goodsIds) do
			if self:isCanBuyGoods(id) then
				table.insert(ids, id)
			end
		end
	end

	return ids
end

function DecorateModel:getPackageAllGoodsIds(goodsId)
	self._packageGoodsIds = self._packageGoodsIds or {}

	if not self._packageGoodsIds[goodsId] then
		local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodsId)

		if decorateConfig.bundleType == 2 then
			self._packageGoodsIds[goodsId] = self:_getCanBuyPackageGoods(goodsId)
		elseif decorateConfig.fatherGoods > 0 then
			local fatherConfig = DecorateStoreConfig.instance:getDecorateConfig(decorateConfig.fatherGoods)

			if fatherConfig.bundleType == 2 then
				self._packageGoodsIds[goodsId] = self:_getCanBuyPackageGoods(decorateConfig.fatherGoods)
			end
		end
	end

	return self._packageGoodsIds[goodsId]
end

function DecorateModel:_getCanBuyPackageGoods(goodsId)
	local goodsIds = {}
	local goodConfig = StoreConfig.instance:getGoodsConfig(goodsId)
	local productsList = GameUtil.splitString2(goodConfig.product, true, "|", "#")

	table.insert(goodsIds, goodsId)

	for _, v in ipairs(productsList) do
		local _goodsId = self:_getSingleGoodsIdByMaterialId(v[2])

		if _goodsId and not LuaUtil.tableContains(goodsIds, _goodsId) then
			table.insert(goodsIds, _goodsId)
		end
	end

	table.sort(goodsIds, DecorateModel._sortGoods)

	return goodsIds
end

function DecorateModel._sortGoods(a, b)
	local a_config = StoreConfig.instance:getGoodsConfig(a)
	local b_config = StoreConfig.instance:getGoodsConfig(b)

	if a_config.order ~= b_config.order then
		return a_config.order < b_config.order
	end

	return a < b
end

function DecorateModel:_getSingleGoodsIdByMaterialId(materialId)
	for _, config in ipairs(lua_store_goods.configList) do
		local product = GameUtil.splitString2(config.product, true, "|", "#")

		if #product == 1 and product[1][2] == materialId then
			return config.id
		end
	end
end

function DecorateModel:_isMaterialInGoods(goodConfig, materialType, materialId)
	if not goodConfig or string.nilorempty(goodConfig.product) then
		return
	end

	local product = GameUtil.splitString2(goodConfig.product, true, "|", "#")

	for _, v in ipairs(product) do
		if v[1] == materialType and v[2] == materialId then
			return true
		end
	end
end

function DecorateModel:isCanOpenPreviewView(subType)
	self._canOpenPreviewView = self._canOpenPreviewView or {
		[ItemEnum.SubType.PlayerBg] = true,
		[ItemEnum.SubType.MainSceneSkin] = true,
		[ItemEnum.SubType.MainUISkin] = true,
		[ItemEnum.SubType.FightCard] = true,
		[ItemEnum.SubType.FightFloatType] = true
	}

	return self._canOpenPreviewView[subType]
end

function DecorateModel:isCanBuyGoods(goodsId)
	if not goodsId then
		return false
	end

	local goodsMo = StoreModel.instance:getGoodsMO(goodsId)

	if not goodsMo or goodsMo:isSoldOut() then
		return false
	end

	local storeCo = StoreConfig.instance:getGoodsConfig(goodsId)
	local productsList = GameUtil.splitString2(storeCo.product, true, "|", "#")

	for i, product in ipairs(productsList) do
		local count = ItemModel.instance:getItemQuantity(product[1], product[2])

		if count > 0 then
			return false
		end
	end

	return true
end

DecorateModel.instance = DecorateModel.New()

return DecorateModel
