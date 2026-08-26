-- chunkname: @modules/logic/room/view/interact/RoomInteractCharacterItem.lua

module("modules.logic.room.view.interact.RoomInteractCharacterItem", package.seeall)

local RoomInteractCharacterItem = class("RoomInteractCharacterItem", ListScrollCellExtend)

function RoomInteractCharacterItem:onInitView()
	self._goonbirthdayicon = gohelper.findChild(self.viewGO, "#go_onbirthdayicon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInteractCharacterItem:addEvents()
	return
end

function RoomInteractCharacterItem:removeEvents()
	return
end

function RoomInteractCharacterItem:_btnclickOnClick()
	if self._view and self._view.viewContainer and self._mo then
		self._view.viewContainer:dispatchEvent(RoomEvent.InteractBuildingSelectHero, self._mo.heroId)
	end
end

function RoomInteractCharacterItem:_editableInitView()
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "role/heroicon")
	self._gobeplaced = gohelper.findChild(self.viewGO, "placeicon")
	self._goclick = gohelper.findChild(self.viewGO, "go_click")
	self._goselect = gohelper.findChild(self.viewGO, "select")
	self._gotrust = gohelper.findChild(self.viewGO, "trust")
	self._txttrust = gohelper.findChildText(self.viewGO, "trust/txt_trust")
	self._gorole = gohelper.findChild(self.viewGO, "role")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "role/career")
	self._imagerare = gohelper.findChildImage(self.viewGO, "role/rare")
	self._txtname = gohelper.findChildText(self.viewGO, "role/name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "role/name/nameEn")
	self._canvasGroup = self._gorole:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.addUIClickAudio(self._goclick, AudioEnum.UI.UI_Common_Click)

	self._uiclick = SLFramework.UGUI.UIClickListener.Get(self._goclick)

	self._uiclick:AddClickListener(self._btnclickOnClick, self)
	gohelper.setActive(self._gotrust, false)
	gohelper.setActive(self._gobeplaced, false)
	gohelper.setActive(gohelper.findChild(self._gobeplaced, "icon"), false)
end

function RoomInteractCharacterItem:_editableAddEvents()
	return
end

function RoomInteractCharacterItem:_editableRemoveEvents()
	return
end

function RoomInteractCharacterItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshUI()
end

function RoomInteractCharacterItem:onSelect(isSelect)
	return
end

function RoomInteractCharacterItem:onDestroyView()
	self._uiclick:RemoveClickListener()
	self._simageicon:UnLoadImage()
end

function RoomInteractCharacterItem:_refreshUI()
	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(self._mo.skinConfig.headIcon))
	gohelper.setActive(self._gobeplaced, self._mo.use)

	local isOnBirthday = RoomCharacterModel.instance:isOnBirthday(self._mo.heroConfig.id)

	gohelper.setActive(self._goonbirthdayicon, isOnBirthday)

	self._canvasGroup.alpha = self._mo.use and 0.7 or 1

	gohelper.addUIClickAudio(self._goclick, (self._mo.use or nil) and (AudioEnum.UI.UI_Common_Click or AudioEnum.UI.Play_UI_Copies))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. self._mo.heroConfig.career)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. CharacterEnum.Color[self._mo.heroConfig.rare])

	self._txtname.text = self._mo.heroConfig.name
	self._txtnameen.text = self._mo.heroConfig.nameEng
end

RoomInteractCharacterItem.prefabUrl = "ui/viewres/room/roomcharacterplaceitem.prefab"

return RoomInteractCharacterItem
