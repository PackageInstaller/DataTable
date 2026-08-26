-- chunkname: @modules/logic/room/view/RoomBlockPackageDetailedItem.lua

module("modules.logic.room.view.RoomBlockPackageDetailedItem", package.seeall)

local RoomBlockPackageDetailedItem = class("RoomBlockPackageDetailedItem", RoomBlockPackageItem)

function RoomBlockPackageDetailedItem:_onInit(go)
	local itemgo = gohelper.findChild(go, "item")

	self._itemCanvasGroup = itemgo:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._imageIcon = gohelper.findChildSingleImage(go, "item/image_icon")
	self._gobirthday = gohelper.findChild(go, "item/go_birthday")
	self._txtbirthName = gohelper.findChildText(go, "item/go_birthday/txt_birthName")
end

function RoomBlockPackageDetailedItem:_onRefreshUI()
	self._imageIcon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. self._packageCfg.icon))

	if self._packageCfg.id == RoomBlockPackageEnum.ID.RoleBirthday then
		local nameStr = self:_getNearBlockName()

		gohelper.setActive(self._gobirthday, nameStr ~= nil)

		if nameStr then
			self._txtbirthName.text = nameStr
		end
	else
		gohelper.setActive(self._gobirthday, false)
	end

	if not RoomBlockPackageEnum.RareBigIcon[self._packageCfg.rare] then
		local splitName = RoomBlockPackageEnum.RareBigIcon[1]

		UISpriteSetMgr.instance:setRoomSprite(self._imagerare, splitName)
	end
end

function RoomBlockPackageDetailedItem:_getNearBlockName()
	local infoList = RoomModel.instance:getSpecialBlockInfoList()
	local nearInfo

	for _, tInfo in ipairs(infoList) do
		local cfg = RoomConfig.instance:getBlock(tInfo.blockId)

		if cfg and cfg.packageId == RoomBlockPackageEnum.ID.RoleBirthday and (nearInfo == nil or nearInfo.createTime < tInfo.createTime) then
			nearInfo = tInfo
		end
	end

	if nearInfo then
		local sbCfg = RoomConfig.instance:getSpecialBlockConfig(nearInfo.blockId)

		return sbCfg and sbCfg.name
	end

	return nil
end

function RoomBlockPackageDetailedItem:_onSelectUI()
	return
end

function RoomBlockPackageDetailedItem:onDestroyView()
	RoomBlockPackageDetailedItem.super.onDestroyView(self)
	self._imageIcon:UnLoadImage()
end

return RoomBlockPackageDetailedItem
