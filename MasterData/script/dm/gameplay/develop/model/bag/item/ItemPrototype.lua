-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/bag/item/ItemPrototype.lua

require("dm.gameplay.develop.model.bag.item.AbstractItem")

ItemPrototype = class("ItemPrototype", AbstractItem, _M)
ItemPages = {
	kCurrency = "CURRENCY",
	kCompose = "COMPOSE",
	kFragament = "FRAGMENT",
	kEquip = "EQUIP",
	kConsumable = "CONSUMABLE",
	kOther = "OTHER",
	kStuff = "STUFF",
	kTsoul = "TSOUL"
}
EquipBagShowType = {
	kDecoration = "Decoration",
	kShoes = "Shoes",
	kWeapon = "Weapon",
	kTops = "Tops",
	kAll = "All"
}
ItemTypes = {
	K_EQUIPCURRENCY = "EQUIPCURRENCY",
	K_SOUL = "TSOUL",
	K_PVE = "PVE",
	K_GOLD = "GOLD",
	K_POWER = "POWER",
	K_DIAMOND_ITEM = "DIAMOND_ITEM",
	K_BOX_RANDOM = "BOX_RANDOM",
	K_MASTER_EMBLEM_QUALITY_UP = "MASTEREMBLEM_QUALITY_UP",
	K_EQUIP_EXCHANGE = "EQUIP_EXCHANGE",
	K_EQUIP_NEW = "K_EQUIP_NEW",
	K_HEROSTIVE = "HEROSTIVE",
	K_EQUIP_QUALITYITEM = "EQUIP_QUALITYITEM",
	K_MAPPOWER = "MAPPOWER",
	K_CLUB = "CLUB",
	K_KON = "KON",
	K_HERO_STAR = "HERO_STAR",
	K_DIAMOND_DRAW = "DIAMOND_DRAW",
	K_FRAGMENTCHANGE = "FRAGMENTCHANGE",
	K_SHOPRESET = "SHOPRESET",
	K_PACKAGESHOP = "PACKAGESHOP",
	K_CRYSTAL_ITEM = "CRYSTAL_ITEM",
	K_HERO_F = "HERO_F",
	K_BOX_SELECT = "BOX_SELECT",
	K_MONTHFOREVER = "MONTHFOREVER",
	K_MASTER_STAR = "MASTER_STAR",
	K_ACTIVITY_BLOCK = "ACTIVITYBLOCK",
	K_EQUIP_NEW_ITEM = "K_EQUIP_NEW_ITEM",
	K_EQUIP_EXP = "EQUIP_EXP",
	K_CRYSTAL = "CRYSTAL",
	k_HERO_UR_QUALITY = "HERO_UR_QUALITY",
	K_TOWER = "TOWER",
	k_MINIGAME_TASK = "MiniGameTask",
	K_DIAMOND = "DIAMOND",
	K_GOLD_ITEM = "GOLD_ITEM",
	K_RICH_STONE = "RICH_STONE",
	K_EQUIP_STAREXP = "EQUIP_STAREXP",
	k_MINIGAME_ITEM = "MiniGameItem",
	K_MasterLeadStage = "MasterLeadStage",
	K_EQUIP_DRAW = "EQUIP_DRAW",
	K_EQUIP_QUALITY_UP = "EQUIP_QUALITY_UP",
	K_ORE_COLLECT = "ORE_COLLECT",
	K_HERO_QUALITY_UP = "HERO_QUALITY_UP",
	K_ARENA = "ARENA",
	K_EQUIP_F = "EQUIP_F",
	K_EQUIP_ORNAMENT = "EQUIP_ORNAMENT",
	k_ACTIVITY_ITEM = "ACTIVITY_ITEM",
	K_MASTER_AURAUP = "MASTER_AURAUP",
	K_TECH = "TECH",
	K_HEROSTONE_F = "HEROSTONE_F",
	K_MASTER_F = "MASTER_F",
	k_GALLERY_GIFT = "HEROGIFT",
	K_ARENA_TIMES = "ARENA_TIMES",
	K_BOX_KEY = "BOX_KEY",
	K_GOLD_DRAW = "GOLD_DRAW",
	K_SKILLUPITEM = "SKILLUPITEM",
	K_HERO_QUALITY = "HERO_QUALITY",
	K_EQUIP_STARITEM = "EQUIP_STARITEM",
	K_ARENA_TICKET = "ARENATICKET",
	K_POWER_UP = "POWER_UP",
	K_EMGUARD = "EMGUARD",
	K_MONTHCARD = "MONTHCARD",
	K_EXP_UP = "EXP_UP",
	K_COMPOSE = "COMPOSE",
	k_MAP_IN = "MAP_IN",
	K_EQUIP_STAR = "EQUIP_STAR",
	K_SURFACEPOINT = "SURFACEPOINT",
	K_ACTIVITY = "ACTIVITY"
}
ComsumableKind = {
	kActionPoint = ItemTypes.K_POWER_UP,
	kExp = ItemTypes.K_EXP_UP,
	kGoldSell = ItemTypes.K_GOLD_ITEM,
	kDiamondBox = ItemTypes.K_DIAMOND_ITEM,
	kCrystalItem = ItemTypes.K_CRYSTAL_ITEM,
	kBox = ItemTypes.K_BOX_RANDOM,
	kBoxSelect = ItemTypes.K_BOX_SELECT,
	kArenaTicket = ItemTypes.k_ARENA_TIMES,
	kEquipRecruitKey = ItemTypes.K_EQUIP_DRAW,
	kRecruitKey = ItemTypes.K_DIAMOND_DRAW,
	kGoldRecruitKey = ItemTypes.K_GOLD_DRAW,
	kOreCollect = ItemTypes.K_ORE_COLLECT,
	kGalleryItem = ItemTypes.k_GALLERY_GIFT,
	kBoxKey = ItemTypes.K_BOX_KEY,
	kCOMPOSE_URSelect = ItemTypes.K_COMPOSE,
	kActivityUse = ItemTypes.k_ACTIVITY_ITEM
}
ItemQuality = {
	kQuality1 = 1,
	kQuality5 = 5,
	kQuality4 = 4,
	kQuality6 = 6,
	kQuality3 = 3,
	kQuality2 = 2
}

function ItemPrototype:initialize(tag)
	super.initialize(self)

	self._itemBase = ConfigReader:getRecordById("ItemConfig", tag)
	self._itemBase.muluse = tonumber(self._itemBase.muluse)
end

function ItemPrototype:getId()
	return self._itemBase.Id
end

function ItemPrototype:getConfigId()
	return self._itemBase.Id
end

function ItemPrototype:getName()
	return Strings:get(self._itemBase.Name)
end

function ItemPrototype:getType()
	return self._itemBase.Page
end

function ItemPrototype:getSubType()
	return self._itemBase.Type
end

function ItemPrototype:getTargetId()
	return self._itemBase.TargetId and self._itemBase.TargetId.id
end

function ItemPrototype:getTargetType()
	return self._itemBase.TargetId and self._itemBase.TargetId.type
end

function ItemPrototype:getTargetNum()
	return (self._itemBase.TargetId or nil) and (self._itemBase.TargetId.num or 0)
end

function ItemPrototype:getSoulExp()
	return self._itemBase.SoulExp
end

function ItemPrototype:getItemExp()
	return nil
end

function ItemPrototype:getUseLevel()
	return self._itemBase.UseLevel
end

function ItemPrototype:getUseVipLevel()
	return self._itemBase.VipLevel or 0
end

function ItemPrototype:getQuality()
	return self._itemBase.Quality
end

function ItemPrototype:getDesc()
	return Strings:get(self._itemBase.Desc)
end

function ItemPrototype:getUrl()
	return self._itemBase.Link
end

function ItemPrototype:getIsShine()
	return self._itemBase.Shine == 1
end

function ItemPrototype:getIsShineInBag()
	return self._itemBase.ShinePack == 1
end

local kConsumableReadRewardTypeMap = {
	[ComsumableKind.kActionPoint] = true,
	[ComsumableKind.kExp] = true,
	[ComsumableKind.kDiamondBox] = true
}

function ItemPrototype:getFunctionDesc()
	local str = Strings:get(self._itemBase.FunctionDesc)
	local value

	if self:getType() == ItemPages.kConsumable then
		if kConsumableReadRewardTypeMap[self:getSubType()] then
			local rewardId = self:getRewardId()

			if rewardId == nil then
				pclog("error:rewardId=nil, id=" .. tostring(self:getId()))
			end

			value = rewardId and self:getFixedAmount(rewardId)
		end
	elseif self:getType() == ItemPages.kFragament and self:getSubType() == ItemTypes.K_HERO_F then
		local heroId = self:getTargetId()
		local heroConfig = ConfigReader:getRecordById("HeroBase", tostring(heroId))

		assert(heroConfig ~= nil, "error:no hero=" .. tostring(heroId))

		value = 0

		local starId = heroConfig.StarId

		for index = 1, heroConfig.BaseStar do
			local config = ConfigReader:getRecordById("HeroStarEffect", starId)

			starId = config.NextId
			value = value + config.StarUpFactor
		end
	end

	if value then
		local templateStr = TextTemplate:new(str or "")

		return (templateStr:stringify({
			value = value
		}))
	else
		return str
	end
end

function ItemPrototype:getFixedAmount(rewardId)
	if rewardId then
		local rewards = RewardSystem:getRewardsById(rewardId)

		if rewards then
			local firstData = rewards[1]

			return firstData and firstData.amount
		end
	end
end

function ItemPrototype:getIcon()
	return self._itemBase.Icon
end

function ItemPrototype:getSellNumber()
	return self._itemBase.SellPrice or 0
end

function ItemPrototype:getMaxNumber()
	return self._itemBase.MaxPile
end

function ItemPrototype:getRewardId(index)
	index = index or 1

	return self._itemBase.Reward[index]
end

function ItemPrototype:getReward()
	return RewardSystem:getRewardsById(self:getRewardId())
end

function ItemPrototype:getSort()
	return self._itemBase.Sort
end

function ItemPrototype:getTypeSort()
	return self._itemBase.Rank
end

function ItemPrototype:canBatchUse()
	return self._itemBase.MultiUse == 1
end

function ItemPrototype:getIsVisible()
	return self._itemBase.Isvisible == 1
end

function ItemPrototype:getRedVisible()
	return self._itemBase.RedTips == 1
end

function ItemPrototype:getFragmentID()
	return self._itemBase.FragmentID
end

function ItemPrototype.class:isItemType(id, itemType)
	local config = ConfigReader:getRecordById("ItemConfig", id)

	if config and next(config) then
		return config.type == itemType
	end

	return false
end

function ItemPrototype.class:isItemHeroPiece(id)
	return self:isItemType(id, ItemTypes.K_HERO_F)
end

function ItemPrototype:getResource()
	return self._itemBase.Resource
end

function ItemPrototype:getCanLock()
	if self._itemBase.Lock and self._itemBase.Lock > 0 then
		return true
	end

	return false
end
