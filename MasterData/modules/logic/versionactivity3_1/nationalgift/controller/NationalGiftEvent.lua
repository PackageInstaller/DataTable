-- chunkname: @modules/logic/versionactivity3_1/nationalgift/controller/NationalGiftEvent.lua

module("modules.logic.versionactivity3_1.nationalgift.controller.NationalGiftEvent", package.seeall)

local NationalGiftEvent = _M

NationalGiftEvent.onAct212InfoGet = GameUtil.getUniqueTb()
NationalGiftEvent.onAct212InfoUpdate = GameUtil.getUniqueTb()
NationalGiftEvent.OnAct212BonusUpdate = GameUtil.getUniqueTb()

return NationalGiftEvent
