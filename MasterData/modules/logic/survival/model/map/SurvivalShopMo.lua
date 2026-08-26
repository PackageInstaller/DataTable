-- chunkname: @modules/logic/survival/model/map/SurvivalShopMo.lua

module("modules.logic.survival.model.map.SurvivalShopMo", package.seeall)

local SurvivalShopMo = pureTable("SurvivalShopMo")

function SurvivalShopMo:init(data, reputationId, reputationLevel)
	self.id = data.id

	if self.id and self.id ~= 0 then
		self.shopCfg = lua_survival_shop.configDict[self.id]
		self.shopType = self.shopCfg.type
	end

	self.reputationId = reputationId
	self.reputationLevel = reputationLevel
	self.items = {}
	self.tabItems = {}

	for _, v in ipairs(data.items) do
		local itemMo = SurvivalShopItemMo.New()

		itemMo:init(v, self.id)
		table.insert(self.items, itemMo)

		local tab = itemMo.shopItemCo.type

		if tab > 0 then
			if self.tabItems[tab] == nil then
				self.tabItems[tab] = {}
			end

			table.insert(self.tabItems[tab], itemMo)
		end
	end

	if self.shopType and self.shopType == SurvivalEnum.ShopType.Reputation then
		self.cfgLevelItems = {}
		self.levelItems = {}

		for i, v in ipairs(self.items) do
			local infos = SurvivalConfig.instance:getShopItemUnlock(v.shopItemId)

			if infos then
				local level = infos.level

				if self.levelItems[level] == nil then
					self.levelItems[level] = {}
				end

				table.insert(self.levelItems[level], v)
			end
		end
	end
end

function SurvivalShopMo:isPreExploreShop()
	return self.shopType == SurvivalEnum.ShopType.PreExplore
end

function SurvivalShopMo:isGeneralShop()
	return self.shopType == SurvivalEnum.ShopType.GeneralShop
end

function SurvivalShopMo:reduceItem(uid, count)
	for k, v in ipairs(self.items) do
		if v.uid == uid then
			v.count = v.count - count

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShopItemUpdate, k, v, uid)

			break
		end
	end
end

function SurvivalShopMo:removeItem(uid, count)
	for k, v in ipairs(self.items) do
		if v.uid == uid then
			v.count = v.count - count

			if v.count <= 0 then
				v:ctor()
			end

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShopItemUpdate, k, v, uid)

			break
		end
	end
end

function SurvivalShopMo:getItemByUid(uid)
	for k, v in ipairs(self.items) do
		if v.uid == uid then
			return v
		end
	end
end

function SurvivalShopMo:getItemsByTabId(tabId)
	return self.tabItems[tabId] or {}
end

function SurvivalShopMo:haveTab()
	return tabletool.len(self.tabItems) > 0
end

function SurvivalShopMo:isReputationShopLevelLock(level)
	return level > self.reputationLevel
end

function SurvivalShopMo:getReputationShopItemByGroupId(level)
	if not self:isReputationShopLevelLock(level) then
		return self.levelItems[level] or {}
	else
		if self.cfgLevelItems[level] == nil then
			self.cfgLevelItems[level] = {}

			local cfgs = SurvivalConfig.instance:getShopItemsByLevel(self.reputationId, level)

			for i, cfg in ipairs(cfgs) do
				local itemMo = SurvivalShopItemMo.New()

				itemMo:init({
					uid = 0,
					id = cfg.id,
					itemId = cfg.item,
					count = cfg.maxNum
				}, self.id)
				table.insert(self.cfgLevelItems[level], itemMo)
			end
		end

		return self.cfgLevelItems[level]
	end
end

function SurvivalShopMo:getReputationItemMaxLevel()
	return SurvivalConfig.instance:getReputationItemMaxLevel(self.reputationId)
end

return SurvivalShopMo
