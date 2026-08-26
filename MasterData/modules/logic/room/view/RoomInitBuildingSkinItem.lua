-- chunkname: @modules/logic/room/view/RoomInitBuildingSkinItem.lua

module("modules.logic.room.view.RoomInitBuildingSkinItem", package.seeall)

local RoomInitBuildingSkinItem = class("RoomInitBuildingSkinItem", ListScrollCellExtend)

function RoomInitBuildingSkinItem:onInitView()
	self._imagequalitybg = gohelper.findChildImage(self.viewGO, "#image_qualitybg")
	self._imagebuilding = gohelper.findChildImage(self.viewGO, "#image_building")
	self._txtskinname = gohelper.findChildText(self.viewGO, "#txt_skinname")
	self._goequiped = gohelper.findChild(self.viewGO, "#go_equiped")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")
	self._bgClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInitBuildingSkinItem:addEvents()
	self._bgClick:AddClickListener(self.onClickBg, self)
	self.addEventCb(self, RoomSkinController.instance, RoomSkinEvent.ChangeEquipRoomSkin, self.onChangeEquipSkin, self)
end

function RoomInitBuildingSkinItem:removeEvents()
	self._bgClick:RemoveClickListener()
	self.removeEventCb(self, RoomSkinController.instance, RoomSkinEvent.ChangeEquipRoomSkin, self.onChangeEquipSkin, self)
end

function RoomInitBuildingSkinItem:onClickBg()
	if not self.id then
		return
	end

	RoomSkinController.instance:selectPreviewRoomSkin(self.id)
end

function RoomInitBuildingSkinItem:onChangeEquipSkin()
	self:refreshState()
end

function RoomInitBuildingSkinItem:_editableInitView()
	return
end

function RoomInitBuildingSkinItem:onUpdateMO(mo)
	if not mo then
		return
	end

	self.id = mo.id

	self:refresh()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.RoomNewSkinItem, self.id)
end

function RoomInitBuildingSkinItem:refresh()
	self:refreshInfo()
	self:refreshState()
end

function RoomInitBuildingSkinItem:refreshInfo()
	if not self.id then
		return
	end

	self._txtskinname.text = RoomConfig.instance:getRoomSkinName(self.id)

	local icon = RoomConfig.instance:getRoomSkinIcon(self.id)

	if not string.nilorempty(icon) then
		UISpriteSetMgr.instance:setRoomSprite(self._imagebuilding, icon)
	end

	local rare = RoomConfig.instance:getRoomSkinRare(self.id)

	if not string.nilorempty(rare) then
		UISpriteSetMgr.instance:setRoomSprite(self._imagequalitybg, "room_qualityframe_" .. rare)
	end
end

function RoomInitBuildingSkinItem:refreshState()
	local isUnlock = RoomSkinModel.instance:isUnlockRoomSkin(self.id)

	if isUnlock then
		local isEquipped = RoomSkinModel.instance:isEquipRoomSkin(self.id)

		gohelper.setActive(self._goequiped, isEquipped)
	end

	gohelper.setActive(self._golocked, not isUnlock)
end

function RoomInitBuildingSkinItem:onSelect(isSelect)
	gohelper.setActive(self._goselected, isSelect)
end

function RoomInitBuildingSkinItem:onDestroy()
	self.id = nil
end

return RoomInitBuildingSkinItem
