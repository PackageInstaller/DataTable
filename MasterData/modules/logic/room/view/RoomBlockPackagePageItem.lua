-- chunkname: @modules/logic/room/view/RoomBlockPackagePageItem.lua

module("modules.logic.room.view.RoomBlockPackagePageItem", package.seeall)

local RoomBlockPackagePageItem = class("RoomBlockPackagePageItem", LuaCompBase)

function RoomBlockPackagePageItem:init(go)
	self._go = go
	self._goselect = gohelper.findChild(self._go, "go_select")
	self._goitem = gohelper.findChild(self._go, "image")
end

function RoomBlockPackagePageItem:getGO()
	return self._go
end

function RoomBlockPackagePageItem:setShowIcon(isShowIcon)
	self._isShowIcon = isShowIcon

	gohelper.setActive(self._imageIcon.gameObject, isShowIcon and true or false)
end

function RoomBlockPackagePageItem:setSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goselect, isSelect and true or false)
end

function RoomBlockPackagePageItem:beforeDestroy()
	gohelper.setActive(self._goitem, false)
	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._go, true)
end

return RoomBlockPackagePageItem
