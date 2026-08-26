-- chunkname: @modules/logic/roomfishing/view/RoomFishingResourceItem.lua

module("modules.logic.roomfishing.view.RoomFishingResourceItem", package.seeall)

local RoomFishingResourceItem = class("RoomFishingResourceItem", ListScrollCellExtend)

function RoomFishingResourceItem:onInitView()
	self._imageItemBG = gohelper.findChildImage(self.viewGO, "#image_ItemBG")
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "#simage_Prop")
	self._txtNum = gohelper.findChildText(self.viewGO, "Num/#txt_Num")
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_click")
end

function RoomFishingResourceItem:addEvents()
	self.click:AddClickListener(self._onClick, self)
end

function RoomFishingResourceItem:removeEvents()
	self.click:RemoveClickListener()
end

function RoomFishingResourceItem:_onClick()
	if not self._canClick then
		return
	end

	MaterialTipController.instance:showMaterialInfo(self._mo.type, self._mo.id)
end

function RoomFishingResourceItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshItemInfo()
end

function RoomFishingResourceItem:setCanClick(canClick)
	self._canClick = canClick
end

function RoomFishingResourceItem:refreshItemInfo()
	UISpriteSetMgr.instance:setRoomSprite(self._imageItemBG, "roomfish_itemqualitybg" .. CharacterEnum.Color[self._mo.rare])

	local _, icon = ItemModel.instance:getItemConfigAndIcon(self._mo.type, self._mo.id)

	if not string.nilorempty(icon) then
		self._simageProp:LoadImage(icon)
	end

	self._txtNum.text = GameUtil.numberDisplay(self._mo.quantity)
end

function RoomFishingResourceItem:onDestroyView()
	self._simageProp:UnLoadImage()
end

return RoomFishingResourceItem
