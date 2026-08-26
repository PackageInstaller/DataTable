-- chunkname: @modules/logic/room/view/building/RoomFormulaMsgBoxItem.lua

module("modules.logic.room.view.building.RoomFormulaMsgBoxItem", package.seeall)

local RoomFormulaMsgBoxItem = class("RoomFormulaMsgBoxItem", ListScrollCell)

function RoomFormulaMsgBoxItem:init(go)
	self._go = go
	self._imagerare = gohelper.findChildImage(self._go, "#image_rare")
	self._simageproduceitem = gohelper.findChildSingleImage(self._go, "#simage_produceitem")
	self._txtNum = gohelper.findChildText(self._go, "image_NumBG/#txt_Num")
end

function RoomFormulaMsgBoxItem:onUpdateMO(mo)
	local config, icon = ItemModel.instance:getItemConfigAndIcon(mo.type, mo.id)

	self._simageproduceitem:LoadImage(icon)
	UISpriteSetMgr.instance:setRoomSprite(self._imagerare, "bg_wupindi_" .. tostring(ItemEnum.Color[config.rare]))

	local numDisplay = GameUtil.numberDisplay(mo.quantity)

	self._txtNum.text = luaLang("multiple") .. tostring(numDisplay)
end

function RoomFormulaMsgBoxItem:onDestroy()
	self._simageproduceitem:UnLoadImage()
end

return RoomFormulaMsgBoxItem
