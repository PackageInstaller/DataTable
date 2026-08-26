-- chunkname: @modules/logic/popup/controller/PopupEvent.lua

module("modules.logic.popup.controller.PopupEvent", package.seeall)

local PopupEvent = _M
local _get = GameUtil.getUniqueTb()

PopupEvent.OnPopupFinish = _get()
PopupEvent.OnMaterialChangePush = _get()

return PopupEvent
