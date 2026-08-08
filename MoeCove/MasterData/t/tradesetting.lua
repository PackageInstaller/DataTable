local TradeSetting = {}

local setting = {
	mainType = {ItemType.Weapon, ItemType.Equip, ItemType.Consumables, ItemType.Material },
}

TradeSetting.setting = setting

setting.subType = {
	[ItemType.Weapon] 	   = {ItemSubType.Fist, ItemSubType.Knife, ItemSubType.Sword, ItemSubType.Spear, ItemSubType.Stick, ItemSubType.Whip, ItemSubType.Dart,},
	[ItemType.Equip]  	   = {ItemSubType.Head, ItemSubType.Neck, ItemSubType.Wrist, ItemSubType.Clothes, ItemSubType.Ring, ItemSubType.Cloak, ItemSubType.Shoe,},
	[ItemType.Consumables] = {ItemSubType.Medicine, ItemSubType.Tools, ItemSubType.Scroll, ItemSubType.Canzhang, ItemSubType.Miji, ItemSubType.Baodian, ItemSubType.Knowledge},
	[ItemType.Material]    = {ItemSubType.Butcher, ItemSubType.Fishman, ItemSubType.Stithy, ItemSubType.WoodStore, ItemSubType.ClothStore, ItemSubType.GreenGrocer, ItemSubType.Eatery},
}

function TradeSetting.GetActualPrice(price, tradePoint)
	return math.ceil(price * (1 + tradePoint / 10))
end

function TradeSetting.GetTax(price) -- 总价
	return math.ceil(price * 0.05)
end
-- 现在listType就为item的id


-- subType不存在键的就表示用id作为listType的key，因为物品id都在10000以上，所以不会和FuncType冲突
-- setting.listType = {
-- 	[ItemSubType.Medicine] = {FuncType.RecoverEnergy, FuncType.RecoverHp, FuncType.RecoverSpirit, FuncType.RecoverMp, FuncType.RecoverStatus},
-- 	[ItemSubType.Tools]    = {FuncType.LiveTools, },
-- }


-- local funcMapListType = {
-- 	[FuncType.RecoverInnerInjure] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverPoison] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverLoseBalance] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverBleed] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverComa] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverChaos] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverInfatuated] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverMaxEnergy] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverMaxHp] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverMaxSpirit] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverMaxMp] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverYinInner] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverYangInner] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverAllInner] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverChiLian] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverLiveDie] = FuncType.RecoverStatus,
-- 	[FuncType.YuFengJiangMed] = FuncType.RecoverStatus,
-- 	[FuncType.RecoverAllStatus] = FuncType.RecoverStatus,
	
-- 	[FuncType.Lumber] = FuncType.LiveTools,
-- 	[FuncType.LumberChark] = FuncType.LiveTools,
-- 	[FuncType.CraftsEquip] = FuncType.LiveTools,
-- 	[FuncType.CraftsDefence] = FuncType.LiveTools,
-- 	[FuncType.Weave] = FuncType.LiveTools,
-- 	[FuncType.WeaveSpin] = FuncType.LiveTools,
-- 	[FuncType.Hunt] = FuncType.LiveTools,
-- 	[FuncType.HunterBake] = FuncType.LiveTools,
-- 	[FuncType.Mine] = FuncType.LiveTools,
-- 	[FuncType.MinerDistill] = FuncType.LiveTools,
-- 	[FuncType.ForgeIron] = FuncType.LiveTools,
-- 	[FuncType.WeaponMake] = FuncType.LiveTools,
-- 	[FuncType.Farm] = FuncType.LiveTools,
-- 	[FuncType.Fish] = FuncType.LiveTools,
-- 	[FuncType.Cook] = FuncType.LiveTools,
-- 	[FuncType.Tailor] = FuncType.LiveTools,
-- }

-- function TradeSetting.GetListType(id, subType, funcType)
-- 	if not setting.listType[subType] then
-- 		return id
-- 	end

-- 	local listType = funcMapListType[funcType]
-- 	if listType then
-- 		return listType
-- 	end

-- 	return funcType
-- end

return TradeSetting