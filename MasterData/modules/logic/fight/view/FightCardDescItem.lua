-- chunkname: @modules/logic/fight/view/FightCardDescItem.lua

module("modules.logic.fight.view.FightCardDescItem", package.seeall)

local FightCardDescItem = class("FightCardDescItem", ListScrollCellExtend)

function FightCardDescItem:onInitView()
	self._gonormalcard = gohelper.findChild(self.viewGO, "#go_normalcard")
	self._gosupercard = gohelper.findChild(self.viewGO, "#go_supercard")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightCardDescItem:addEvents()
	return
end

function FightCardDescItem:removeEvents()
	return
end

function FightCardDescItem:_editableInitView()
	self._simageList = self:getUserDataTb_()
end

function FightCardDescItem:_editableAddEvents()
	return
end

function FightCardDescItem:_editableRemoveEvents()
	return
end

function FightCardDescItem:onUpdateMO(mo, isSuperCard)
	self._mo = mo
	self._isSuperCard = isSuperCard

	if self._isSuperCard then
		self:onRefreshUI(self._gosupercard)
	else
		self:onRefreshUI(self._gonormalcard)
	end

	gohelper.setActive(self._gonormalcard, not self._isSuperCard)
	gohelper.setActive(self._gosupercard, self._isSuperCard)
end

function FightCardDescItem:onRefreshUI(go)
	local cardIcon = gohelper.findChildSingleImage(go, "card")
	local attribute = gohelper.findChildSingleImage(go, "attribute")
	local nameen = gohelper.findChildText(go, "nameen")
	local name = gohelper.findChildText(go, "nameen/name")
	local desc = gohelper.findChildText(go, "desc")
	local tagIcon = gohelper.findChildImage(go, "tagIcon")

	cardIcon:LoadImage(ResUrl.getFightCardDescIcon(self._mo.card1))

	if not string.nilorempty(self._mo.attribute) then
		attribute:LoadImage(ResUrl.getAttributeIcon(self._mo.attribute))
	end

	nameen.text = self._mo.cardname_en
	name.text = self._mo.cardname
	desc.text = self._mo.carddescription2

	UISpriteSetMgr.instance:setFightSprite(tagIcon, self._mo.card2)
	gohelper.setActive(attribute.gameObject, not self._isSuperCard)
	gohelper.setActive(tagIcon.gameObject, not self._isSuperCard)
	table.insert(self._simageList, cardIcon)
	table.insert(self._simageList, attribute)
end

function FightCardDescItem:onSelect(isSelect)
	return
end

function FightCardDescItem:onDestroyView()
	for k, v in pairs(self._simageList) do
		v:UnLoadImage()
	end
end

return FightCardDescItem
