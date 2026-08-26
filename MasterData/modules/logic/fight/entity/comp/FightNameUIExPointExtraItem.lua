-- chunkname: @modules/logic/fight/entity/comp/FightNameUIExPointExtraItem.lua

module("modules.logic.fight.entity.comp.FightNameUIExPointExtraItem", package.seeall)

local FightNameUIExPointExtraItem = class("FightNameUIExPointExtraItem", FightNameUIExPointBaseItem)

function FightNameUIExPointExtraItem:getType()
	return FightNameUIExPointBaseItem.ExPointType.Extra
end

function FightNameUIExPointExtraItem.GetExtraExPointItem(exPointGo)
	local pointItem = FightNameUIExPointExtraItem.New()

	pointItem:init(exPointGo)

	return pointItem
end

return FightNameUIExPointExtraItem
