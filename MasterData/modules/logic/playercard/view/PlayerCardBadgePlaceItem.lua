-- chunkname: @modules/logic/playercard/view/PlayerCardBadgePlaceItem.lua

module("modules.logic.playercard.view.PlayerCardBadgePlaceItem", package.seeall)

local PlayerCardBadgePlaceItem = class("PlayerCardBadgePlaceItem", ListScrollCellExtend)

function PlayerCardBadgePlaceItem:onInitView()
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._imagebadge = gohelper.findChildImage(self.viewGO, "#image_badge")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._goorder = gohelper.findChild(self.viewGO, "orderbg")
	self._txtorder = gohelper.findChildText(self.viewGO, "orderbg/#txt_order")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardBadgePlaceItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function PlayerCardBadgePlaceItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function PlayerCardBadgePlaceItem:_btnclickOnClick()
	if self._cardInfo then
		local badgeIds, isModify = self._cardInfo:modifyEquipBadges(self._id)

		if isModify then
			PlayerCardRpc.instance:sendSetPlayerCardBadgeRequest(badgeIds)
		else
			GameFacade.showToast(ToastEnum.MaxEquipBadgeTip)
		end
	end

	PlayerCardBadgeListModel.instance:onModelUpdate()
end

function PlayerCardBadgePlaceItem:_editableInitView()
	return
end

function PlayerCardBadgePlaceItem:_editableAddEvents()
	return
end

function PlayerCardBadgePlaceItem:_editableRemoveEvents()
	return
end

function PlayerCardBadgePlaceItem:onUpdateMO(mo)
	self._cardInfo = PlayerCardModel.instance:getCardInfo()
	self._id = mo.id
	self._mo = mo
	self._txtname.text = mo.co.name

	UISpriteSetMgr.instance:setPlayerCard2Sprite(self._imagebadge, mo.co.icon)

	local isEquip = false

	if self._cardInfo then
		local equipIndex = self._cardInfo:getEquipIndexBadge(self._id)

		isEquip = equipIndex > 0

		if isEquip then
			self._txtorder.text = equipIndex
		end
	end

	gohelper.setActive(self._goorder, isEquip)
	gohelper.setActive(self._goselected, isEquip)
end

function PlayerCardBadgePlaceItem:onSelect(isSelect)
	return
end

function PlayerCardBadgePlaceItem:onDestroyView()
	return
end

return PlayerCardBadgePlaceItem
