-- chunkname: @modules/logic/fight/controller/FightQteEntityItemHelper.lua

module("modules.logic.fight.controller.FightQteEntityItemHelper", package.seeall)

local FightQteEntityItemHelper = _M
local EntityItemPrefab = {
	[3066] = "ui/viewres/fight/fightbreakthroughheroitem_1.prefab",
	[3155] = "ui/viewres/fight/fightbreakthroughheroitem_2.prefab"
}
local EntityItemCls = {
	[3155] = FightQteEntityItemHNJ,
	[3066] = FightQteEntityItem37
}

function FightQteEntityItemHelper.createEntityItem(entityMo, useType)
	if not entityMo then
		return
	end

	local heroId = entityMo.modelId
	local entityItemCls = EntityItemCls[heroId]

	entityItemCls = entityItemCls or FightQteEntityItemBase

	local entityItem = entityItemCls.New()

	entityItem:init(entityMo, useType)

	local prefabPath = EntityItemPrefab[heroId]

	if prefabPath then
		entityItem:setPrefabPath(prefabPath)
	end

	return entityItem
end

local CostType2Image = {
	[CharacterEnum.CareerType.Yan] = "fight_breakthrough_point_1_1",
	[CharacterEnum.CareerType.Xing] = "fight_breakthrough_point_2_1"
}

function FightQteEntityItemHelper.getCostTypeImage(costType)
	return CostType2Image[costType]
end

local SmallCostType2Image = {
	[CharacterEnum.CareerType.Yan] = "fight_breakthrough_point_1",
	[CharacterEnum.CareerType.Xing] = "fight_breakthrough_point_2"
}

function FightQteEntityItemHelper.getSmallCostTypeImage(costType)
	return SmallCostType2Image[costType]
end

return FightQteEntityItemHelper
