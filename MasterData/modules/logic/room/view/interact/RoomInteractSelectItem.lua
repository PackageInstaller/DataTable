-- chunkname: @modules/logic/room/view/interact/RoomInteractSelectItem.lua

module("modules.logic.room.view.interact.RoomInteractSelectItem", package.seeall)

local RoomInteractSelectItem = class("RoomInteractSelectItem", ListScrollCellExtend)

function RoomInteractSelectItem:onInitView()
	self._gohas = gohelper.findChild(self.viewGO, "#go_has")
	self._goheroicon = gohelper.findChild(self.viewGO, "#go_has/#go_heroicon")
	self._goloading = gohelper.findChild(self.viewGO, "#go_loading")
	self._goheroicon2 = gohelper.findChild(self.viewGO, "#go_loading/#go_heroicon")
	self._gonone = gohelper.findChild(self.viewGO, "#go_none")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._gotag = gohelper.findChild(self.viewGO, "#go_tag")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInteractSelectItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RoomInteractSelectItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RoomInteractSelectItem:_btnclickOnClick()
	if self._view and self._view.viewContainer and self._characterMO then
		self._view.viewContainer:dispatchEvent(RoomEvent.InteractBuildingSelectHero, self._characterMO.heroId)
	end
end

function RoomInteractSelectItem:_editableInitView()
	gohelper.setActive(self._gotag, false)
	gohelper.setActive(self._goloading, false)

	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_has/#go_heroicon")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "#go_loading/#go_heroicon")
end

function RoomInteractSelectItem:_editableAddEvents()
	return
end

function RoomInteractSelectItem:_editableRemoveEvents()
	return
end

function RoomInteractSelectItem:onUpdateMO(mo)
	self._characterMO = mo

	self:refreshUI()
end

function RoomInteractSelectItem:onSelect(isSelect)
	return
end

function RoomInteractSelectItem:onDestroyView()
	self._simageicon:UnLoadImage()
	self._simageicon2:UnLoadImage()
end

function RoomInteractSelectItem:refreshUI()
	local mo = self._characterMO
	local isHas = not not mo

	if self._lastIsHas ~= isHas then
		self._lastIsHas = isHas

		gohelper.setActive(self._gohas, isHas)
		gohelper.setActive(self._gonone, not isHas)
	end

	if isHas and self._lastMOid ~= mo.id then
		self._lastMOid = mo.id

		local headUrl = ResUrl.getRoomHeadIcon(mo.skinConfig.headIcon)

		self._simageicon:LoadImage(headUrl)
		self._simageicon2:LoadImage(headUrl)
	end
end

return RoomInteractSelectItem
