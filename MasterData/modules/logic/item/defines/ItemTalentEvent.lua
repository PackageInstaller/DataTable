-- chunkname: @modules/logic/item/defines/ItemTalentEvent.lua

module("modules.logic.item.defines.ItemTalentEvent", package.seeall)

local ItemTalentEvent = {}

ItemTalentEvent.UseTalentItemSuccess = GameUtil.getUniqueTb()
ItemTalentEvent.ChooseHeroItem = GameUtil.getUniqueTb()

return ItemTalentEvent
