-- chunkname: @modules/logic/activitywelfare/define/DestinyStoneGiftPickChoiceEvent.lua

module("modules.logic.activitywelfare.define.DestinyStoneGiftPickChoiceEvent", package.seeall)

local DestinyStoneGiftPickChoiceEvent = _M

DestinyStoneGiftPickChoiceEvent.hadStoneUp = GameUtil.getUniqueTb()
DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged = GameUtil.getUniqueTb()

return DestinyStoneGiftPickChoiceEvent
