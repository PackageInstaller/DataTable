-- chunkname: @modules/logic/room/view/backpack/RoomBackpackPropItem.lua

module("modules.logic.room.view.backpack.RoomBackpackPropItem", package.seeall)

local RoomBackpackPropItem = class("RoomBackpackPropItem", ListScrollCellExtend)

function RoomBackpackPropItem:onInitView()
	self._imgquality = gohelper.findChildImage(self.viewGO, "#image_quality")
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._itemIcon = IconMgr.instance:getCommonItemIcon(self._goicon)

	local countBg = self._itemIcon:getCountBg()
	local count = self._itemIcon:getCount()
	local transCountBg = countBg.transform
	local transCount = count.transform

	recthelper.setAnchorY(transCountBg, RoomManufactureEnum.ItemCountBgY)
	recthelper.setAnchorY(transCount, RoomManufactureEnum.ItemCountY)
end

function RoomBackpackPropItem:addEvents()
	return
end

function RoomBackpackPropItem:removeEvents()
	return
end

function RoomBackpackPropItem:onUpdateMO(propItem)
	self._mo = propItem

	self._itemIcon:setMOValue(self._mo.type, self._mo.id, self._mo.quantity)
	self._itemIcon:isShowQuality(false)
	self._itemIcon:isShowName(false)

	local rare = self._itemIcon:getRare()
	local qualityImg = RoomManufactureEnum.RareImageMap[rare]

	UISpriteSetMgr.instance:setCritterSprite(self._imgquality, qualityImg)
end

function RoomBackpackPropItem:onDestroyView()
	return
end

return RoomBackpackPropItem
