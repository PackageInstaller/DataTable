-- chunkname: @modules/logic/partycloth/controller/PartyClothEvent.lua

module("modules.logic.partycloth.controller.PartyClothEvent", package.seeall)

local PartyClothEvent = _M
local _get = GameUtil.getUniqueTb()

PartyClothEvent.ClothInfoUpdate = _get()
PartyClothEvent.WearClothUpdate = _get()
PartyClothEvent.SummonReply = _get()
PartyClothEvent.ClickClothPartItem = _get()
PartyClothEvent.ClickClothSuitItem = _get()
PartyClothEvent.GetWearInfoReply = _get()
PartyClothEvent.NewTagChange = _get()

return PartyClothEvent
