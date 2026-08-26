-- chunkname: @modules/logic/survival/model/SurvivalBagItemMo.lua

module("modules.logic.survival.model.SurvivalBagItemMo", package.seeall)

local SurvivalBagItemMo = pureTable("SurvivalBagItemMo")

function SurvivalBagItemMo:ctor()
	self.uid = nil
	self.co = nil
	self.id = 0
	self.count = 0
	self.exScore = 0
	self.equipLevel = 0
	self.source = SurvivalEnum.ItemSource.None
	self.isUnknown = false
end

function SurvivalBagItemMo:init(data)
	self.uid = data.uid
	self.id = data.id

	if data.count then
		self.count = data.count or self.count
	end

	self.param = data.param
	self.bagReason = data.bagReason
	self.co = lua_survival_item.configDict[self.id]

	if self.co and self.co.type == SurvivalEnum.ItemType.Equip then
		self.equipCo = lua_survival_equip.configDict[self.id]
	elseif self.co and self.co.type == SurvivalEnum.ItemType.NPC then
		local npcId = tonumber(self.co.effect) or 0

		self.npcCo = SurvivalConfig.instance:getNpcConfig(npcId)
	end

	self.sellPrice = 0

	if self.co and not string.nilorempty(self.co.sellPrice) then
		local price = string.match(self.co.sellPrice, "^item#1:(.+)$")

		if price then
			self.sellPrice = tonumber(price) or 0
		end
	end

	self.shopPrice = {}

	if self.co and not string.nilorempty(self.co.specialSellPrice) then
		local infos = GameUtil.splitString2(self.co.specialSellPrice, false, ",", "#")

		for i, info in ipairs(infos) do
			local shopId = tonumber(info[1])
			local priceInfo = string.splitToNumber(info[3], ":")

			self.shopPrice[shopId] = {
				price = priceInfo[2]
			}
		end
	end
end

function SurvivalBagItemMo:getSellPrice(shopId)
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()
	local shopType = SurvivalEnum.ShopType.Normal
	local sellPrice = self.sellPrice

	if shopId then
		shopType = SurvivalConfig.instance:getShopType(shopId)

		local info = self.shopPrice[shopId]

		if info then
			sellPrice = info.price
		end
	end

	local attr

	if shopType == SurvivalEnum.ShopType.Normal then
		attr = weekMo:getDerivedAttrFinalValue(SurvivalEnum.DerivedAttr.Sell_Map)
	elseif shopType == SurvivalEnum.ShopType.PreExplore then
		attr = weekMo:getDerivedAttrFinalValue(SurvivalEnum.DerivedAttr.Sell_PreExplore)
	elseif shopType == SurvivalEnum.ShopType.GeneralShop then
		attr = weekMo:getDerivedAttrFinalValue(SurvivalEnum.DerivedAttr.Sell_ComputingCenter)
	end

	local num = sellPrice * attr

	return math.floor(num)
end

function SurvivalBagItemMo:isCurrency()
	return self.co and self.co.type == SurvivalEnum.ItemType.Currency
end

function SurvivalBagItemMo:getMass()
	return self.co.mass * self.count
end

function SurvivalBagItemMo:getRare()
	return self.co.rare
end

function SurvivalBagItemMo:isNPC()
	return self.co.type == SurvivalEnum.ItemType.NPC
end

function SurvivalBagItemMo:isEmpty()
	return self.id == 0 or self.count == 0
end

function SurvivalBagItemMo:isReputationItem()
	if self.co then
		return self.co.type == SurvivalEnum.ItemType.Reputation
	end
end

function SurvivalBagItemMo:canExchangeReputationItem()
	return self.isExchangeReputationItem
end

function SurvivalBagItemMo:getExchangeReputationAmountTotal()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()
	local v = tonumber(self.co.effect)

	v = weekMo:getAttr(SurvivalEnum.AttrType.RenownChangeFix, v)

	return self.count * v
end

function SurvivalBagItemMo:getEquipEffectDesc()
	if not self.equipCo then
		return ""
	end

	local desc = self.equipCo.effectDesc

	if SurvivalModel.instance._isUseSimpleDesc == 1 then
		desc = self.equipCo.effectDesc2
	end

	if not self.equipValues then
		local attrVals = {}
		local list = {}

		if not string.nilorempty(desc) then
			local list1 = {}
			local list2 = {}
			local attrMapTotal

			for i, v in ipairs(string.split(desc, "|")) do
				local val, active = SurvivalDescExpressionHelper.instance:parstDesc(v, attrVals, (self.source == SurvivalEnum.ItemSource.Equip or nil) and SurvivalShelterModel.instance:getWeekInfo().equipBox.values)

				if active then
					table.insert(list1, {
						val,
						active
					})
				else
					table.insert(list2, {
						val,
						active
					})
				end
			end

			tabletool.addValues(list, list1)
			tabletool.addValues(list, list2)
		end

		return list
	end
end

local scoreColor = {
	"#617B8E",
	"#855AA1",
	"#AF490B"
}

function SurvivalBagItemMo:getEquipScoreLevel()
	if not self.equipCo then
		return 1, scoreColor[1]
	end

	local score = self.equipCo.score + self.exScore
	local worldLevel = 1
	local outSideMo = SurvivalModel.instance:getOutSideInfo()

	if outSideMo.inWeek then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			worldLevel = weekInfo:getAttr(SurvivalEnum.AttrType.WorldLevel)
		end
	end

	local str = lua_survival_equip_score.configDict[worldLevel][1].level
	local level = 1

	if not string.nilorempty(str) then
		for i, v in ipairs(string.splitToNumber(str, "#")) do
			if v <= score then
				level = i + 1
			end
		end
	end

	return level, scoreColor[level] or scoreColor[1]
end

function SurvivalBagItemMo:isDisasterRecommendItem(mapId)
	if not self.co then
		return false
	end

	if mapId then
		local weekMo = SurvivalShelterModel.instance:getWeekInfo()
		local mapInfoMo = weekMo:getSurvivalMapInfoMo(mapId)
		local disasterCos = mapInfoMo.disasterCos

		for i, serverDisasterCo in ipairs(disasterCos) do
			if serverDisasterCo.recommend == self.co.id then
				return true
			end
		end
	else
		local sceneMo = SurvivalMapModel.instance:getSceneMo()

		if not sceneMo then
			return false
		end

		local disasterCos = sceneMo._mapInfo.disasterCos

		for i, serverDisasterCo in ipairs(disasterCos) do
			if serverDisasterCo.recommend == self.co.id then
				return true
			end
		end
	end

	return false
end

function SurvivalBagItemMo:isNPCRecommendItem()
	if not self.co then
		return false
	end

	return self.co.type == SurvivalEnum.ItemType.Material and self.co.subType == SurvivalEnum.ItemSubType.Material_NPCItem
end

function SurvivalBagItemMo:getExtendCost()
	if self.co.type == SurvivalEnum.ItemType.Equip then
		return self.equipCo.extendCost
	elseif self.co.type == SurvivalEnum.ItemType.NPC then
		return self.npcCo.extendCost
	end

	return 0
end

function SurvivalBagItemMo:clone()
	local itemMo = SurvivalBagItemMo.New()

	itemMo:init(self)

	return itemMo
end

rawset(SurvivalBagItemMo, "Empty", SurvivalBagItemMo.New())

return SurvivalBagItemMo
