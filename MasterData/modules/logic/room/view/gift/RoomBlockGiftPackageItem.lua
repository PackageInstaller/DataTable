-- chunkname: @modules/logic/room/view/gift/RoomBlockGiftPackageItem.lua

module("modules.logic.room.view.gift.RoomBlockGiftPackageItem", package.seeall)

local RoomBlockGiftPackageItem = class("RoomBlockGiftPackageItem", RoomBlockPackageDetailedItem)

function RoomBlockGiftPackageItem:_onInit(go)
	RoomBlockGiftPackageItem.super._onInit(self, go)
	gohelper.setActive(self._gobirthday, false)

	self._gohasget = gohelper.findChild(go, "item/go_hasget")
	self._imagehasgetIcon = gohelper.findChildSingleImage(go, "item/go_hasget/image_icon")

	gohelper.setActive(self._goempty, false)

	self._btnUIlongPrees = SLFramework.UGUI.UILongPressListener.Get(self._btnItem.gameObject)
	self._btnblockselect = gohelper.findChildButtonWithAudio(self.viewGO, "go_select/#btn_check")
end

function RoomBlockGiftPackageItem:addEventListeners()
	RoomBlockGiftPackageItem.super.addEventListeners(self)

	local _longPressArr = {
		1,
		99999
	}

	self._btnUIlongPrees:SetLongPressTime(_longPressArr)
	self._btnUIlongPrees:AddLongPressListener(self._onbtnlongPrees, self)
	self._btnblockselect:AddClickListener(self._onbtnlongPrees, self)
end

function RoomBlockGiftPackageItem:removeEventListeners()
	self._btnUIlongPrees:RemoveLongPressListener()
	RoomBlockGiftPackageItem.super.removeEventListeners(self)
	self._btnblockselect:RemoveClickListener()
end

function RoomBlockGiftPackageItem:setPackageId(packageId)
	self._packageId = packageId
	self._packageCfg = RoomConfig.instance:getBlockPackageConfig(packageId) or nil
	self._blockNum = self._showPackageMO:getBlockNum()
	self._isCollocted = self._showPackageMO:isCollect()

	self:_refreshUI()
end

function RoomBlockGiftPackageItem:_refreshUI()
	if not self._packageCfg then
		return
	end

	self._txtname.text = self._packageCfg.name
	self._txtnum.text = self._blockNum
	self._txtdegree.text = self._packageCfg.blockBuildDegree * self._blockNum

	gohelper.setActive(self._gohasget, self._isCollocted)
	gohelper.setActive(self._txtnum.gameObject, not self._isCollocted)
	gohelper.setActive(self._txtdegree.gameObject, not self._isCollocted)
	self:_onRefreshUI()
end

function RoomBlockGiftPackageItem:_onRefreshUI()
	self._imageIcon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. self._packageCfg.icon))

	if not RoomBlockPackageEnum.RareBigIcon[self._packageCfg.rare] then
		UISpriteSetMgr.instance:setRoomSprite(self._imagerare, RoomBlockPackageEnum.RareBigIcon[self._packageCfg.rare])

		if self._showPackageMO:isCollect() then
			self._imagehasgetIcon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. self._packageCfg.icon))
		end

		self:onSelect()
	end
end

function RoomBlockGiftPackageItem:_onbtnlongPrees()
	local type = self._showPackageMO.subType
	local id = self._showPackageMO.id
	local data = {
		type = type,
		id = id
	}

	MaterialTipController.instance:showMaterialInfoWithData(type, id, data)
end

function RoomBlockGiftPackageItem:_btnitemOnClick()
	if self._showPackageMO:isCollect() then
		return
	end

	RoomBlockBuildingGiftModel.instance:onSelect(self._showPackageMO)
	RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnSelect, self._showPackageMO)
end

function RoomBlockGiftPackageItem:onSelect()
	self._isSelect = self._showPackageMO.isSelect

	gohelper.setActive(self._goselect, self._isSelect)
end

function RoomBlockGiftPackageItem:setActive(isActive)
	gohelper.setActive(self._go, isActive)
end

return RoomBlockGiftPackageItem
