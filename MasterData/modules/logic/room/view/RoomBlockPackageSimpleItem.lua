-- chunkname: @modules/logic/room/view/RoomBlockPackageSimpleItem.lua

module("modules.logic.room.view.RoomBlockPackageSimpleItem", package.seeall)

local RoomBlockPackageSimpleItem = class("RoomBlockPackageSimpleItem", RoomBlockPackageItem)

function RoomBlockPackageSimpleItem:_onInit(go)
	self._goreddot = gohelper.findChild(self.viewGO, "item/go_reddot")
end

function RoomBlockPackageSimpleItem:_onRefreshUI()
	if not RoomBlockPackageEnum.RareIcon[self._packageCfg.rare] then
		UISpriteSetMgr.instance:setRoomSprite(self._imagerare, RoomBlockPackageEnum.RareIcon[self._packageCfg.rare])
	end
end

function RoomBlockPackageSimpleItem:_onSelectUI()
	recthelper.setAnchorX(self._txtname.transform, self._isSelect and -175 or -197)
end

return RoomBlockPackageSimpleItem
