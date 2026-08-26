-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyItemTipView.lua

module("modules.logic.sp01.odyssey.view.OdysseyItemTipView", package.seeall)

local OdysseyItemTipView = class("OdysseyItemTipView", BaseView)

function OdysseyItemTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goitemTip = gohelper.findChild(self.viewGO, "#go_itemTip")
	self._imagerare = gohelper.findChildImage(self.viewGO, "#go_itemTip/title/#image_rare")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_itemTip/title/#simage_icon")
	self._txtitemName = gohelper.findChildText(self.viewGO, "#go_itemTip/title/name/#txt_itemName")
	self._goequipType = gohelper.findChild(self.viewGO, "#go_itemTip/title/name/#go_equipType")
	self._txtequipType = gohelper.findChildText(self.viewGO, "#go_itemTip/title/name/#go_equipType/#txt_equipType")
	self._goequipSuit = gohelper.findChild(self.viewGO, "#go_itemTip/#scroll_desc/Viewport/Content/#go_equipSuit")
	self._txtsuitName = gohelper.findChildText(self.viewGO, "#go_itemTip/#scroll_desc/Viewport/Content/#go_equipSuit/suit/#txt_suitName")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#go_itemTip/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_itemTip/#scroll_desc/Viewport/Content/#txt_desc")
	self._txtdesc1 = gohelper.findChildText(self.viewGO, "#go_itemTip/#scroll_desc/Viewport/Content/#txt_desc1")
	self._btnreplace = gohelper.findChildButtonWithAudio(self.viewGO, "#go_itemTip/Btn/#btn_replace")
	self._btnunload = gohelper.findChildButtonWithAudio(self.viewGO, "#go_itemTip/Btn/#btn_unload")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_itemTip/Btn/#btn_equip")
	self._btnsuit = gohelper.findChildButton(self.viewGO, "#go_itemTip/#scroll_desc/Viewport/Content/#go_equipSuit/#btn_suit")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyItemTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnreplace:AddClickListener(self._btnreplaceOnClick, self)
	self._btnunload:AddClickListener(self._btnunloadOnClick, self)
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnsuit:AddClickListener(self._btnsuitOnClick, self)
	self.addEventCb(self, OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, self.refreshUI, self)
end

function OdysseyItemTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnreplace:RemoveClickListener()
	self._btnunload:RemoveClickListener()
	self._btnequip:RemoveClickListener()
	self._btnsuit:RemoveClickListener()
	self.removeEventCb(self, OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, self.refreshUI, self)
end

OdysseyItemTipView.TipHalfWidth = 419

function OdysseyItemTipView:_btncloseOnClick()
	self:closeThis()
end

function OdysseyItemTipView:_btnsuitOnClick()
	local param = {}

	param.suitId = self.config.suitId
	param.bagType = OdysseyEnum.BagType.Bag
	param.pos = recthelper.uiPosToScreenPos(self._btnsuit.transform)

	OdysseyController.instance:openSuitTipsView(param)
end

function OdysseyItemTipView:_btnreplaceOnClick()
	OdysseyHeroGroupController.instance:replaceOdysseyEquip(self.heroPos, self.equipIndex, self.equipUid)
end

function OdysseyItemTipView:_btnunloadOnClick()
	OdysseyHeroGroupController.instance:unloadOdysseyEquip(self.heroPos, self.equipIndex)
end

function OdysseyItemTipView:_btnequipOnClick()
	OdysseyHeroGroupController.instance:setOdysseyEquip(self.heroPos, self.equipIndex, self.equipUid)
end

function OdysseyItemTipView:_editableInitView()
	self._goBtn = gohelper.findChild(self.viewGO, "#go_itemTip/Btn")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_itemTip/#scroll_desc/Viewport/Content/#go_equipSuit/suit/icon")
end

function OdysseyItemTipView:onUpdateParam()
	return
end

function OdysseyItemTipView:onOpen()
	if self.viewParam and self.viewParam.itemId then
		self:refreshData(self.viewParam)
		self:refreshPos()
		self:refreshUI()
	end
end

function OdysseyItemTipView:refreshData(param)
	self.viewParam = param
	self.itemId = self.viewParam.itemId
	self.clickPos = self.viewParam.clickPos
	self.constPos = self.viewParam.constPos
	self.heroPos = self.viewParam.heroPos
	self.equipUid = self.viewParam.equipUid
	self.equipIndex = self.viewParam.equipIndex
end

function OdysseyItemTipView:refreshPos()
	if self.clickPos then
		local isClickRight = GameUtil.checkClickPositionInRight(self.clickPos)
		local posX, posY = recthelper.screenPosToAnchorPos2(self.clickPos, self.viewGO.transform)

		if isClickRight then
			if not (posX - OdysseyItemTipView.TipHalfWidth) then
				local tipPosX = posX + OdysseyItemTipView.TipHalfWidth

				self:setTipPos(tipPosX, posY)
				gohelper.fitScreenOffset(self._goitemTip.transform)
			end
		end
	elseif self.constPos then
		local posX, posY = recthelper.screenPosToAnchorPos2(self.constPos, self.viewGO.transform)

		self:setTipPos(posX, posY)
		gohelper.fitScreenOffset(self._goitemTip.transform)
	end
end

function OdysseyItemTipView:refreshUI()
	self:refreshItemInfo()
	self:refreshBtnState()
end

function OdysseyItemTipView:refreshItemInfo()
	self._scrolldesc.verticalNormalizedPosition = 1
	self.config = OdysseyConfig.instance:getItemConfig(self.itemId)

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imagerare, "odyssey_herogroup_quality_" .. tostring(self.config.rare))
	gohelper.setActive(self._goequipType, self.config.type == OdysseyEnum.ItemType.Equip)
	gohelper.setActive(self._goequipSuit, self.config.type == OdysseyEnum.ItemType.Equip)
	gohelper.setActive(self._txtdesc1.gameObject, self.config.type == OdysseyEnum.ItemType.Equip)

	self._txtitemName.text = self.config.name

	if self.config.type == OdysseyEnum.ItemType.Item then
		self:refreshDesc(self._txtdesc, self.config.desc)
		self._simageicon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(self.config.icon))
	elseif self.config.type == OdysseyEnum.ItemType.Equip then
		self._simageicon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(self.config.icon))

		local suitId = self.config.suitId
		local suitConfig = OdysseyConfig.instance:getEquipSuitConfig(suitId)

		self._txtsuitName.text = suitConfig.name

		self:refreshDesc(self._txtdesc, self.config.skillDesc)
		self:refreshDesc(self._txtdesc1, self.config.desc)

		local rareDesc = luaLang(OdysseyEnum.EquipTypeLang[self.config.rare])
		local rareColorStr = OdysseyEnum.EquipRareColor[self.config.rare]

		self._txtequipType.text = string.format("<color=%s>%s</color>", rareColorStr, rareDesc)

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageicon, suitConfig.icon)
	end
end

function OdysseyItemTipView:refreshDesc(textItem, desc)
	textItem.text = SkillHelper.buildDesc(desc)

	local fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(textItem.gameObject, FixTmpBreakLine)

	SkillHelper.addHyperLinkClick(textItem, self._onHyperLinkClick, self)
	fixTmpBreakLine:refreshTmpContent(textItem)
end

function OdysseyItemTipView:_onHyperLinkClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipView(tonumber(effId), clickPosition)
end

function OdysseyItemTipView:refreshBtnState()
	local noEquip = self.equipUid == nil or self.equipUid == 0

	gohelper.setActive(self._goBtn, not noEquip)

	if noEquip then
		return
	end

	local heroGroupMo = OdysseyHeroGroupModel.instance:getCurHeroGroup()
	local heroPos = self.heroPos
	local equipIndex = self.equipIndex
	local equipUidMo = heroGroupMo:getOdysseyEquips(heroPos - 1)
	local curEquipUid = equipUidMo.equipUid[equipIndex]
	local state
	local equipUid = self.equipUid

	state = (curEquipUid == nil or curEquipUid == 0) and OdysseyEnum.EquipOptionType.Equip or curEquipUid == equipUid and OdysseyEnum.EquipOptionType.Unload or OdysseyEnum.EquipOptionType.Replace

	gohelper.setActive(self._btnequip, state == OdysseyEnum.EquipOptionType.Equip)
	gohelper.setActive(self._btnunload, state == OdysseyEnum.EquipOptionType.Unload)
	gohelper.setActive(self._btnreplace, state == OdysseyEnum.EquipOptionType.Replace)
end

function OdysseyItemTipView:setTipPos(x, y)
	transformhelper.setLocalPosXY(self._goitemTip.transform, x, y)
end

function OdysseyItemTipView:onClose()
	self._simageicon:UnLoadImage()
end

function OdysseyItemTipView:onDestroyView()
	return
end

return OdysseyItemTipView
