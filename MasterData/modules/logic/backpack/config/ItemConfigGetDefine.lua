-- chunkname: @modules/logic/backpack/config/ItemConfigGetDefine.lua

module("modules.logic.backpack.config.ItemConfigGetDefine", package.seeall)

local ItemConfigGetDefine = class("ItemConfigGetDefine", BaseConfig)

function ItemConfigGetDefine:ctor()
	self._defineList = {
		[MaterialEnum.MaterialType.Item] = ItemConfigGetDefine._getItem,
		[MaterialEnum.MaterialType.Currency] = ItemConfigGetDefine._getCurrency,
		[MaterialEnum.MaterialType.PowerPotion] = ItemConfigGetDefine._getPowerPotion,
		[MaterialEnum.MaterialType.HeroSkin] = ItemConfigGetDefine._getHeroSkin,
		[MaterialEnum.MaterialType.Hero] = ItemConfigGetDefine._getHero,
		[MaterialEnum.MaterialType.Equip] = ItemConfigGetDefine._getEquip,
		[MaterialEnum.MaterialType.PlayerCloth] = ItemConfigGetDefine._getPlayerCloth,
		[MaterialEnum.MaterialType.Building] = ItemConfigGetDefine._getBuilding,
		[MaterialEnum.MaterialType.Formula] = ItemConfigGetDefine._getFormula,
		[MaterialEnum.MaterialType.BlockPackage] = ItemConfigGetDefine._getBlockPackage,
		[MaterialEnum.MaterialType.SpecialBlock] = ItemConfigGetDefine._getSpecialBlock,
		[MaterialEnum.MaterialType.RoomTheme] = ItemConfigGetDefine._getRoomTheme,
		[MaterialEnum.MaterialType.Explore] = ItemConfigGetDefine._getExplore,
		[MaterialEnum.MaterialType.EquipCard] = ItemConfigGetDefine._getEquipCard,
		[MaterialEnum.MaterialType.Antique] = ItemConfigGetDefine._getAntique,
		[MaterialEnum.MaterialType.V1a5AiZiLa] = ItemConfigGetDefine._getV1a5AiZiLaItem,
		[MaterialEnum.MaterialType.Season123EquipCard] = ItemConfigGetDefine._getSeason123EquipCard,
		[MaterialEnum.MaterialType.NewInsight] = ItemConfigGetDefine._getNewInsight,
		[MaterialEnum.MaterialType.Critter] = ItemConfigGetDefine._getCritter,
		[MaterialEnum.MaterialType.UnlockVoucher] = ItemConfigGetDefine._getUnlockVoucher,
		[MaterialEnum.MaterialType.TalentItem] = ItemConfigGetDefine._getTalentItem,
		[MaterialEnum.MaterialType.SpecialExpiredItem] = ItemConfigGetDefine._getSpecialExpiredItem
	}
end

function ItemConfigGetDefine._getItem(id)
	return ItemConfig.instance:getItemCo(id)
end

function ItemConfigGetDefine._getCurrency(id)
	return CurrencyConfig.instance:getCurrencyCo(id)
end

function ItemConfigGetDefine._getPowerPotion(id)
	return ItemConfig.instance:getPowerItemCo(id)
end

function ItemConfigGetDefine._getHeroSkin(id)
	return SkinConfig.instance:getSkinCo(id)
end

function ItemConfigGetDefine._getHero(id)
	return HeroConfig.instance:getHeroCO(id)
end

function ItemConfigGetDefine._getEquip(id)
	return EquipConfig.instance:getEquipCo(id)
end

function ItemConfigGetDefine._getPlayerCloth(id)
	return PlayerConfig.instance:getPlayerClothConfig(id)
end

function ItemConfigGetDefine._getBuilding(id)
	return RoomConfig.instance:getBuildingConfig(id)
end

function ItemConfigGetDefine._getFormula(id)
	return RoomConfig.instance:getFormulaConfig(id)
end

function ItemConfigGetDefine._getBlockPackage(id)
	return RoomConfig.instance:getBlockPackageConfig(id)
end

function ItemConfigGetDefine._getSpecialBlock(id)
	return RoomConfig.instance:getSpecialBlockConfig(id)
end

function ItemConfigGetDefine._getRoomTheme(id)
	return RoomConfig.instance:getThemeConfig(id)
end

function ItemConfigGetDefine._getV1a5AiZiLaItem(id)
	return AiZiLaConfig.instance:getItemCo(id)
end

function ItemConfigGetDefine._getExplore(id)
	return ExploreConfig.instance:getItemCo(id)
end

function ItemConfigGetDefine._getEquipCard(id)
	return SeasonConfig.instance:getSeasonEquipCo(id)
end

function ItemConfigGetDefine._getAntique(id)
	return AntiqueConfig.instance:getAntiqueCo(id)
end

function ItemConfigGetDefine._getSeason123EquipCard(id)
	return Season123Config.instance:getSeasonEquipCo(id)
end

function ItemConfigGetDefine._getNewInsight(id)
	return ItemConfig.instance:getInsightItemCo(id)
end

function ItemConfigGetDefine._getCritter(id)
	return CritterConfig.instance:getCritterCfg(id)
end

function ItemConfigGetDefine._getUnlockVoucher(id)
	return UnlockVoucherConfig.instance:getUnlockVoucherCfg(id, true)
end

function ItemConfigGetDefine._getTalentItem(id)
	return ItemTalentConfig.instance:getTalentItemCo(id)
end

function ItemConfigGetDefine._getSpecialExpiredItem(id)
	return ItemConfig.instance:getItemSpecialExpiredItemCo(id)
end

function ItemConfigGetDefine:getItemConfigFunc(type)
	type = tonumber(type)

	return self._defineList[type]
end

ItemConfigGetDefine.instance = ItemConfigGetDefine.New()

return ItemConfigGetDefine
