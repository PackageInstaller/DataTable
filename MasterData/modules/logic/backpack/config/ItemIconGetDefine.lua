-- chunkname: @modules/logic/backpack/config/ItemIconGetDefine.lua

module("modules.logic.backpack.config.ItemIconGetDefine", package.seeall)

local ItemIconGetDefine = class("ItemIconGetDefine", BaseConfig)

function ItemIconGetDefine:ctor()
	self._defineList = {
		[MaterialEnum.MaterialType.Item] = ItemIconGetDefine._getItem,
		[MaterialEnum.MaterialType.Currency] = ItemIconGetDefine._getCurrency,
		[MaterialEnum.MaterialType.PowerPotion] = ItemIconGetDefine._getPowerPotion,
		[MaterialEnum.MaterialType.HeroSkin] = ItemIconGetDefine._getHeroSkin,
		[MaterialEnum.MaterialType.Hero] = ItemIconGetDefine._getHero,
		[MaterialEnum.MaterialType.Equip] = ItemIconGetDefine._getEquip,
		[MaterialEnum.MaterialType.PlayerCloth] = ItemIconGetDefine._getPlayerCloth,
		[MaterialEnum.MaterialType.Building] = ItemIconGetDefine._getBuilding,
		[MaterialEnum.MaterialType.Formula] = ItemIconGetDefine._getFormula,
		[MaterialEnum.MaterialType.BlockPackage] = ItemIconGetDefine._getBlockPackage,
		[MaterialEnum.MaterialType.SpecialBlock] = ItemIconGetDefine._getSpecialBlock,
		[MaterialEnum.MaterialType.RoomTheme] = ItemIconGetDefine._getRoomTheme,
		[MaterialEnum.MaterialType.Explore] = ItemIconGetDefine._getExplore,
		[MaterialEnum.MaterialType.EquipCard] = ItemIconGetDefine._getEquipCard,
		[MaterialEnum.MaterialType.Antique] = ItemIconGetDefine._getAntique,
		[MaterialEnum.MaterialType.V1a5AiZiLa] = ItemIconGetDefine._getV1a5AiZiLaItem,
		[MaterialEnum.MaterialType.Season123EquipCard] = ItemIconGetDefine._getEquipCard,
		[MaterialEnum.MaterialType.NewInsight] = ItemIconGetDefine._getNewInsight,
		[MaterialEnum.MaterialType.Critter] = ItemIconGetDefine._getCritterIcon,
		[MaterialEnum.MaterialType.UnlockVoucher] = ItemIconGetDefine._getUnlockVoucherIcon,
		[MaterialEnum.MaterialType.TalentItem] = ItemIconGetDefine._getTalentItemIcon
	}
end

function ItemIconGetDefine._getItem(config)
	return ResUrl.getPropItemIcon(config.icon)
end

function ItemIconGetDefine._getCurrency(config)
	return ResUrl.getCurrencyItemIcon(config.icon)
end

function ItemIconGetDefine._getPowerPotion(config)
	return ResUrl.getPropItemIcon(config.icon)
end

function ItemIconGetDefine._getHeroSkin(config)
	return ResUrl.getHeadIconSmall(config.headIcon), ResUrl.getHeroSkinPropIcon(config.itemIcon)
end

function ItemIconGetDefine._getHero(config)
	local skinCo = SkinConfig.instance:getSkinCo(config.skinId)

	return ResUrl.getHeadIconSmall(skinCo.headIcon), ResUrl.getHeadIconNew(config.id)
end

function ItemIconGetDefine._getEquip(config)
	return ResUrl.getEquipIcon(config.icon)
end

function ItemIconGetDefine._getPlayerCloth(config)
	return ResUrl.getPlayerClothIcon(config.icon)
end

function ItemIconGetDefine._getBuilding(config)
	return ResUrl.getRoomBuildingPropIcon(config.icon)
end

function ItemIconGetDefine._getFormula(config)
	return ResUrl.getPropItemIcon(config.icon)
end

function ItemIconGetDefine._getBlockPackage(config)
	return ResUrl.getRoomBlockPackagePropIcon(config.icon)
end

function ItemIconGetDefine._getSpecialBlock(config)
	return ResUrl.getRoomBlockPropIcon(config.icon)
end

function ItemIconGetDefine._getRoomTheme(config)
	return ResUrl.getRoomThemePropIcon(config.icon)
end

function ItemIconGetDefine._getExplore(config)
	return ResUrl.getPropItemIcon(config.icon)
end

function ItemIconGetDefine._getEquipCard(config)
	return ResUrl.getSeasonCelebrityCard(config.icon)
end

function ItemIconGetDefine._getAntique(config)
	return ResUrl.getPropItemIcon(config.icon)
end

function ItemIconGetDefine._getV1a5AiZiLaItem(config)
	return ResUrl.getV1a5AiZiLaItemIcon(config.icon)
end

function ItemIconGetDefine._getNewInsight(config)
	return ResUrl.getPropItemIcon(config.icon)
end

function ItemIconGetDefine._getCritterIcon(config)
	return ResUrl.getCritterItemIcon(config.icon)
end

function ItemIconGetDefine._getUnlockVoucherIcon(config)
	return ResUrl.getPropItemIcon(config.icon)
end

function ItemIconGetDefine._getTalentItemIcon(config)
	return ResUrl.getPropItemIcon(config.icon)
end

function ItemIconGetDefine:getItemIconFunc(type)
	type = tonumber(type)

	return self._defineList[type]
end

ItemIconGetDefine.instance = ItemIconGetDefine.New()

return ItemIconGetDefine
