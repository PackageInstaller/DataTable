-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyBagEquipDetailItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyBagEquipDetailItem", package.seeall)

local OdysseyBagEquipDetailItem = class("OdysseyBagEquipDetailItem", LuaCompBase)

function OdysseyBagEquipDetailItem:init(go)
	self.viewGO = go
	self._imagerare = gohelper.findChildImage(self.viewGO, "#image_rare")
	self._txtitemName = gohelper.findChildText(self.viewGO, "#txt_itemName")
	self._imageSuitIcon = gohelper.findChildImage(self.viewGO, "#go_equipSuit/suit/icon")
	self._txtequipType = gohelper.findChildText(self.viewGO, "equipType/#txt_equipType")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._goequipSuit = gohelper.findChild(self.viewGO, "#go_equipSuit")
	self._txtsuitName = gohelper.findChildText(self.viewGO, "#go_equipSuit/suit/#txt_suitName")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#scroll_desc/Viewport/Content/#txt_desc")
	self._txtdesc1 = gohelper.findChildText(self.viewGO, "#scroll_desc/Viewport/Content/#txt_desc1")
	self._btnSuit = gohelper.findChildButton(self.viewGO, "#btn_suit")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyBagEquipDetailItem:_editableInitView()
	return
end

function OdysseyBagEquipDetailItem:addEventListeners()
	self._btnSuit:AddClickListener(self.onClickSuit, self)
end

function OdysseyBagEquipDetailItem:removeEventListeners()
	self._btnSuit:RemoveClickListener()
end

function OdysseyBagEquipDetailItem:onClickSuit()
	local param = {}

	param.suitId = self.mo.config.suitId
	param.bagType = OdysseyEnum.BagType.Bag
	param.pos = recthelper.uiPosToScreenPos(self._btnSuit.transform)

	OdysseyController.instance:openSuitTipsView(param)
end

function OdysseyBagEquipDetailItem:setInfo(mo)
	self.mo = mo

	self:refreshUI()
end

function OdysseyBagEquipDetailItem:refreshUI()
	local mo = self.mo
	local itemConfig = mo.config

	if itemConfig.type == OdysseyEnum.ItemType.Item then
		self._simageicon:LoadImage(ResUrl.getPropItemIcon(itemConfig.icon))
	elseif itemConfig.type == OdysseyEnum.ItemType.Equip then
		self._simageicon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(itemConfig.icon))
	end

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imagerare, "odyssey_herogroup_quality_" .. itemConfig.rare)

	self._txtdesc.text = itemConfig.skillDesc
	self._txtitemName.text = itemConfig.name
	self._txtdesc1.text = itemConfig.desc

	local rareDesc = luaLang(OdysseyEnum.EquipTypeLang[itemConfig.rare])
	local rareColorStr = OdysseyEnum.EquipRareColor[itemConfig.rare]

	self._txtequipType.text = string.format("<color=%s>%s</color>", rareColorStr, rareDesc)

	local suitConfig = OdysseyConfig.instance:getEquipSuitConfig(itemConfig.suitId)

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageSuitIcon, suitConfig.icon)

	if suitConfig then
		self._txtsuitName.text = suitConfig.name
	end
end

function OdysseyBagEquipDetailItem:onDestroy()
	return
end

return OdysseyBagEquipDetailItem
