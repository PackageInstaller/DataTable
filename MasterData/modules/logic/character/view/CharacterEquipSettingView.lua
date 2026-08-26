-- chunkname: @modules/logic/character/view/CharacterEquipSettingView.lua

module("modules.logic.character.view.CharacterEquipSettingView", package.seeall)

local CharacterEquipSettingView = class("CharacterEquipSettingView", BaseView)

function CharacterEquipSettingView:onInitView()
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bottom")
	self._simagetop = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_top")
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "#go_left/lefttop/#simage_heroicon")
	self._imageherocareer = gohelper.findChildImage(self.viewGO, "#go_left/lefttop/#image_herocareer")
	self._goequipinfo = gohelper.findChild(self.viewGO, "#go_left/#go_equipinfo")
	self._txtlevel = gohelper.findChildText(self.viewGO, "#go_left/#go_equipinfo/#txt_level")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_left/#go_equipinfo/#txt_name")
	self._image1 = gohelper.findChildImage(self.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_1")
	self._image2 = gohelper.findChildImage(self.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_2")
	self._image3 = gohelper.findChildImage(self.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_3")
	self._image4 = gohelper.findChildImage(self.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_4")
	self._image5 = gohelper.findChildImage(self.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_5")
	self._image6 = gohelper.findChildImage(self.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_6")
	self._gostrengthenattr = gohelper.findChild(self.viewGO, "#go_left/#go_equipinfo/layout/attribute/container/#go_strengthenattr")
	self._gosuitattribute = gohelper.findChild(self.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute")
	self._scrolldesccontainer = gohelper.findChildScrollRect(self.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer")
	self._gosuiteffect = gohelper.findChild(self.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect")
	self._goadvanceskill = gohelper.findChild(self.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill")
	self._txtattributelv = gohelper.findChildText(self.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill/title/#txt_attributelv")
	self._txtsuiteffect1 = gohelper.findChildText(self.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill/#txt_suiteffect1")
	self._gobaseskill = gohelper.findChild(self.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
	self._txtbasedestitle = gohelper.findChildText(self.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/title/#txt_basedestitle")
	self._txtsuiteffect2 = gohelper.findChildText(self.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	self._gotip = gohelper.findChild(self.viewGO, "#go_left/#go_equipinfo/#go_tip")
	self._gosortbtns = gohelper.findChild(self.viewGO, "#go_sortbtns")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_sortbtns/#btn_rarerank")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_sortbtns/#btn_lvrank")
	self._scrollequip = gohelper.findChildScrollRect(self.viewGO, "#scroll_equip")
	self._btnsetting = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_setting")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._goleftempty = gohelper.findChild(self.viewGO, "#go_empty/#go_leftempty")
	self._gorightempty = gohelper.findChild(self.viewGO, "#go_empty/#go_rightempty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterEquipSettingView:addEvents()
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnlvrank:AddClickListener(self._btnlvrankOnClick, self)
	self._btnsetting:AddClickListener(self._btnsettingOnClick, self)
end

function CharacterEquipSettingView:removeEvents()
	self._btnrarerank:RemoveClickListener()
	self._btnlvrank:RemoveClickListener()
	self._btnsetting:RemoveClickListener()
end

function CharacterEquipSettingView:_btnrarerankOnClick()
	CharacterEquipSettingListModel.instance:changeSortByRare()
	self:refreshBtnStatus()
end

function CharacterEquipSettingView:_btnlvrankOnClick()
	CharacterEquipSettingListModel.instance:changeSortByLevel()
	self:refreshBtnStatus()
end

function CharacterEquipSettingView:_btnsettingOnClick()
	if not self.selectedEquipMo then
		GameFacade.showToast(ToastEnum.CharacterEquipSetting1)

		return
	end

	HeroRpc.instance:setHeroDefaultEquipRequest(self.heroMo.heroId, self.selectedEquipMo.uid)
end

function CharacterEquipSettingView:_editableInitView()
	self.goRareBtnNoSelect = gohelper.findChild(self.viewGO, "#go_sortbtns/#btn_rarerank/btn1")
	self.goRareBtnSelect = gohelper.findChild(self.viewGO, "#go_sortbtns/#btn_rarerank/btn2")
	self.goLvBtnNoSelect = gohelper.findChild(self.viewGO, "#go_sortbtns/#btn_lvrank/btn1")
	self.goLvBtnSelect = gohelper.findChild(self.viewGO, "#go_sortbtns/#btn_lvrank/btn2")
	self.goRareBtnNoSelectArrow = gohelper.findChild(self.viewGO, "#go_sortbtns/#btn_rarerank/btn1/arrow")
	self.goRareBtnSelectArrow = gohelper.findChild(self.viewGO, "#go_sortbtns/#btn_rarerank/btn2/arrow")
	self.goLvBtnNoSelectArrow = gohelper.findChild(self.viewGO, "#go_sortbtns/#btn_lvrank/btn1/arrow")
	self.goLvBtnSelectArrow = gohelper.findChild(self.viewGO, "#go_sortbtns/#btn_lvrank/btn2/arrow")

	gohelper.setActive(self._gostrengthenattr, false)
	gohelper.setActive(self._txtsuiteffect1.gameObject, false)
	gohelper.setActive(self._txtsuiteffect2.gameObject, false)
	gohelper.addUIClickAudio(self._btnsetting.gameObject, AudioEnum.UI.Play_UI_General_shutdown)

	self.strengthenAttrItems = self:getUserDataTb_()
	self.skillAttributeItems = self:getUserDataTb_()
	self.skillDescItems = self:getUserDataTb_()

	CharacterController.instance:registerCallback(CharacterEvent.DefaultEquipViewEquipSelectChange, self.onSelectEquipChange, self)
	CharacterController.instance:registerCallback(CharacterEvent.successSetDefaultEquip, self.onSuccessSetDefaultEquip, self)
	self._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function CharacterEquipSettingView:onSelectEquipChange()
	self.selectedEquipMo = CharacterEquipSettingListModel.instance:getCurrentSelectEquipMo()

	self:refreshLeftUI()
	self:refreshSetBtn()
end

function CharacterEquipSettingView:onUpdateParam()
	return
end

function CharacterEquipSettingView:onOpen()
	self.heroMo = self.viewParam.heroMo

	CharacterEquipSettingListModel.instance:initEquipList()

	self.selectedEquipMo = CharacterEquipSettingListModel.instance:getCurrentSelectEquipMo()

	self:refreshUI()
end

function CharacterEquipSettingView:refreshUI()
	self:refreshHeroInfo()
	self:refreshLeftUI()
	self:refreshRightUI()
	self:refreshBtnStatus()
	self:refreshSetBtn()
end

function CharacterEquipSettingView:refreshLeftUI()
	gohelper.setActive(self._goleftempty, not self.selectedEquipMo)
	gohelper.setActive(self._goequipinfo, self.selectedEquipMo)

	if self.selectedEquipMo then
		self._txtname.text = self.selectedEquipMo.config.name

		self:refreshEquipStar()
		self:refreshEquipLevel()
		self:refreshEquipNormalAttr()
		self:refreshEquipSkillAttribute()
		self:refreshEquipSkillDesc()
	end
end

function CharacterEquipSettingView:refreshRightUI()
	local hasNormalEquip = CharacterEquipSettingListModel.instance:hasNormalEquip()

	gohelper.setActive(self._gorightempty, not hasNormalEquip)
	gohelper.setActive(self._scrollequip.gameObject, hasNormalEquip)

	if hasNormalEquip then
		CharacterEquipSettingListModel.instance:refreshEquipList()
	end
end

function CharacterEquipSettingView:refreshBtnStatus()
	gohelper.setActive(self.goRareBtnNoSelect, not CharacterEquipSettingListModel.instance:isSortByRare())
	gohelper.setActive(self.goRareBtnSelect, CharacterEquipSettingListModel.instance:isSortByRare())
	gohelper.setActive(self.goLvBtnNoSelect, not CharacterEquipSettingListModel.instance:isSortByLevel())
	gohelper.setActive(self.goLvBtnSelect, CharacterEquipSettingListModel.instance:isSortByLevel())

	local levelState, rareState = CharacterEquipSettingListModel.instance:getSortState()

	transformhelper.setLocalScale(self.goRareBtnNoSelectArrow.transform, 1, rareState, 1)
	transformhelper.setLocalScale(self.goRareBtnSelectArrow.transform, 1, rareState, 1)
	transformhelper.setLocalScale(self.goLvBtnNoSelectArrow.transform, 1, levelState, 1)
	transformhelper.setLocalScale(self.goLvBtnSelectArrow.transform, 1, levelState, 1)
end

function CharacterEquipSettingView:refreshHeroInfo()
	self._simageheroicon:LoadImage(ResUrl.getHandbookheroIcon(self.heroMo.config.skinId))
	UISpriteSetMgr.instance:setHandBookCareerSprite(self._imageherocareer, "sx_icon_" .. tostring(self.heroMo.config.career))
end

function CharacterEquipSettingView:refreshEquipStar()
	local equipRare = self.selectedEquipMo.config.rare

	for i = 1, 6 do
		gohelper.setActive(self["_image" .. i].gameObject, i <= equipRare + 1)
	end
end

function CharacterEquipSettingView:refreshEquipLevel()
	local equipLevel = self.selectedEquipMo.level
	local currentBreakLvMaxLevel = EquipConfig.instance:getCurrentBreakLevelMaxLevel(self.selectedEquipMo)

	self._txtlevel.text = string.format("LV.<color=#9a551b>%d</color>/%d", equipLevel, currentBreakLvMaxLevel)
end

function CharacterEquipSettingView:refreshEquipNormalAttr()
	local _, attrList = EquipConfig.instance:getEquipNormalAttr(self.selectedEquipMo.config.id, self.selectedEquipMo.level, HeroConfig.sortAttrForEquipView)
	local item, attrConfig

	for index, attr in ipairs(attrList) do
		item = self.strengthenAttrItems[index]

		if not self.strengthenAttrItems[index] then
			item = {
				go = gohelper.cloneInPlace(self._gostrengthenattr, "item" .. index)
			}
			item.icon = gohelper.findChildImage(item.go, "image_icon")
			item.name = gohelper.findChildText(item.go, "txt_name")
			item.attr_value = gohelper.findChildText(item.go, "txt_value")

			table.insert(self.strengthenAttrItems, item)
		end

		attrConfig = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(attr.attrType))

		UISpriteSetMgr.instance:setCommonSprite(item.icon, "icon_att_" .. attrConfig.id)

		item.name.text = attrConfig.name
		item.attr_value.text = attr.value

		gohelper.setActive(item.go, true)
	end

	for i = #attrList + 1, #self.strengthenAttrItems do
		gohelper.setActive(self.strengthenAttrItems[i].go, false)
	end
end

function CharacterEquipSettingView:refreshEquipSkillAttribute()
	local skillAttributeDescList = EquipHelper.getEquipSkillAdvanceAttrDesTab(self.selectedEquipMo.config.id, self.selectedEquipMo.refineLv, "#985630")

	if skillAttributeDescList and #skillAttributeDescList > 0 then
		gohelper.setActive(self._goadvanceskill, true)

		self._txtattributelv.text = self.selectedEquipMo.refineLv

		local item, go

		for index, skillAttributeDesc in ipairs(skillAttributeDescList) do
			item = self.skillAttributeItems[index]

			if not self.skillAttributeItems[index] then
				item = gohelper.cloneInPlace(self._txtsuiteffect1.gameObject, "item" .. index):GetComponent(gohelper.Type_TextMesh)

				table.insert(self.skillAttributeItems, item)
			end

			gohelper.setActive(item.gameObject, true)

			item.text = skillAttributeDesc
		end

		for i = #skillAttributeDescList + 1, #self.skillAttributeItems do
			gohelper.setActive(self.skillAttributeItems[i].gameObject, false)
		end
	else
		gohelper.setActive(self._goadvanceskill, false)
	end
end

function CharacterEquipSettingView:refreshEquipSkillDesc()
	local skillDesList, careerIconName, skillNameColor = EquipHelper.getSkillBaseDescAndIcon(self.selectedEquipMo.config.id, self.selectedEquipMo.refineLv, "#985630")

	if #skillDesList == 0 then
		gohelper.setActive(self._gobaseskill.gameObject, false)
	else
		gohelper.setActive(self._gobaseskill.gameObject, true)

		self._txtbasedestitle.text = string.format("<%s>%s</color>", self:getSkillNameColor(EquipHelper.getEquipSkillCareer(self.selectedEquipMo.config.id, self.selectedEquipMo.refineLv)), self.selectedEquipMo.config.skillName)

		local cell

		for index, desc in ipairs(skillDesList) do
			cell = self.skillDescItems[index]

			if not self.skillDescItems[index] then
				local iteminfo = {}
				local itemGo = gohelper.cloneInPlace(self._txtsuiteffect2.gameObject, "item_" .. index)

				iteminfo.itemGo = itemGo
				iteminfo._imagebasedesicon = gohelper.findChildImage(itemGo, "#image_basedesicon")
				iteminfo.txt = itemGo:GetComponent(gohelper.Type_TextMesh)
				iteminfo.skillDescCanvasGroup = itemGo:GetComponent(typeof(UnityEngine.CanvasGroup))
				cell = iteminfo

				table.insert(self.skillDescItems, iteminfo)
			end

			cell.txt.text = desc
			cell.skillDescCanvasGroup.alpha = self.selectedEquipMo and EquipHelper.detectEquipSkillSuited(self.heroMo.heroId, self.selectedEquipMo.config.id, self.selectedEquipMo.refineLv) and 1 or 0.45

			UISpriteSetMgr.instance:setCommonSprite(cell._imagebasedesicon, careerIconName)
			gohelper.setActive(cell.itemGo, true)
		end

		for i = #skillDesList + 1, #self.skillDescItems do
			gohelper.setActive(self.skillDescItems[i].itemGo, false)
		end
	end
end

function CharacterEquipSettingView:onSuccessSetDefaultEquip()
	GameFacade.showToast(ToastEnum.CharacterEquipSetting2)
	self:refreshSetBtn()
end

function CharacterEquipSettingView:refreshSetBtn()
	if not self.selectedEquipMo then
		gohelper.setActive(self._btnsetting.gameObject, true)
		ZProj.UGUIHelper.SetGrayscale(self._btnsetting.gameObject, true)

		return
	end

	local isHeroDefaultEquip = self.heroMo.defaultEquipUid == self.selectedEquipMo.uid

	gohelper.setActive(self._btnsetting.gameObject, not isHeroDefaultEquip)
	ZProj.UGUIHelper.SetGrayscale(self._btnsetting.gameObject, false)
end

function CharacterEquipSettingView:getSkillNameColor(career)
	local color = {
		["0"] = "#FFFFFF",
		["1"] = "#8b704e",
		["5|6"] = "#6b536e",
		["2"] = "#4e607b",
		["3"] = "#476f4b",
		["4"] = "#9b4f4b"
	}

	return (string.nilorempty(career) or nil) and (color["0"] or color[career])
end

function CharacterEquipSettingView:onClose()
	self._simageheroicon:UnLoadImage()
	CharacterController.instance:unregisterCallback(CharacterEvent.DefaultEquipViewEquipSelectChange, self.onSelectEquipChange, self)
	CharacterController.instance:unregisterCallback(CharacterEvent.successSetDefaultEquip, self.onSuccessSetDefaultEquip, self)
end

function CharacterEquipSettingView:onDestroyView()
	self._simagebottom:UnLoadImage()
	self._simagetop:UnLoadImage()
end

return CharacterEquipSettingView
