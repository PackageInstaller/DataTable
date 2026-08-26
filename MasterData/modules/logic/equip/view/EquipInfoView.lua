-- chunkname: @modules/logic/equip/view/EquipInfoView.lua

module("modules.logic.equip.view.EquipInfoView", package.seeall)

local EquipInfoView = class("EquipInfoView", BaseView)

function EquipInfoView:onInitView()
	self._goprogress = gohelper.findChild(self.viewGO, "#go_progress")
	self._txtcurlevel = gohelper.findChildText(self.viewGO, "#go_progress/#txt_curlevel")
	self._txttotallevel = gohelper.findChildText(self.viewGO, "#go_progress/#txt_curlevel/#txt_totallevel")
	self._goinsigt = gohelper.findChild(self.viewGO, "#go_progress/#txt_curlevel/go_insigt")
	self._image1 = gohelper.findChildImage(self.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_1")
	self._image2 = gohelper.findChildImage(self.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_2")
	self._image3 = gohelper.findChildImage(self.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_3")
	self._image4 = gohelper.findChildImage(self.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_4")
	self._image5 = gohelper.findChildImage(self.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_5")
	self._imagelock = gohelper.findChildImage(self.viewGO, "#go_progress/#image_lock")
	self._goType = gohelper.findChild(self.viewGO, "layout/type")
	self._goTypeItem = gohelper.findChild(self.viewGO, "layout/type/#go_typeItem")
	self._goattribute = gohelper.findChild(self.viewGO, "layout/attribute")
	self._gostrengthenattr = gohelper.findChild(self.viewGO, "layout/attribute/container/#go_strengthenattr")
	self._gobreakeffect = gohelper.findChild(self.viewGO, "layout/attribute/container/#go_breakeffect")
	self._goSkill = gohelper.findChild(self.viewGO, "layout/#go_skill")
	self._txtattributelv = gohelper.findChildText(self.viewGO, "layout/#go_skill/attributename/#txt_attributelv")
	self._goSkillContainer = gohelper.findChild(self.viewGO, "layout/#go_skill")
	self._goSkillItem = gohelper.findChild(self.viewGO, "layout/#go_skill/#scroll_desccontainer/Viewport/#go_skillContainer/#go_SkillItem")
	self._gotip = gohelper.findChild(self.viewGO, "#go_tip")
	self._btnmaxlevel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_maxlevel")
	self._imagemaxleveltip = gohelper.findChildImage(self.viewGO, "#btn_maxlevel")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipInfoView:addEvents()
	self._btnmaxlevel:AddClickListener(self._onClickMaxLevelBtn, self)
end

function EquipInfoView:removeEvents()
	self._btnmaxlevel:RemoveClickListener()
end

function EquipInfoView:_onClickMaxLevelBtn()
	self._showMax = not self._showMax

	self._animator:Play("switch", 0, 0)
	self:refreshMaxLevelImage(0)

	self._equipMO = self._hadEquip and (self._showMax and EquipHelper.createMaxLevelEquipMo(self._equipId, self._equipMO.id) or self.viewContainer.viewParam.equipMO) or self._showMax and EquipHelper.createMaxLevelEquipMo(self._equipId) or EquipHelper.createMinLevelEquipMo(self._equipId)

	self:refreshUI()
end

function EquipInfoView:_editableInitView()
	self.strengthenAttrItemList = {}
	self.tagItemList = {}
	self.skillItemList = {}

	gohelper.setActive(self._gostrengthenattr, false)
	gohelper.setActive(self._goSkillItem, false)
	gohelper.setActive(self._goTypeItem, false)

	self._click = gohelper.getClickWithAudio(self._imagelock.gameObject)

	self._click:AddClickListener(self._onClick, self)
	gohelper.addUIClickAudio(self._btnmaxlevel.gameObject, AudioEnum.UI.play_ui_admission_open)

	self.imageBreakIcon = gohelper.findChildImage(self._gobreakeffect, "image_icon")
	self.txtBreakAttrName = gohelper.findChildText(self._gobreakeffect, "txt_name")
	self.txtBreakValue = gohelper.findChildText(self._gobreakeffect, "txt_value")
	self._animator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
	self.txtTitle = gohelper.findChildText(self.viewGO, "layout/#go_skill/attributename/txttitle")
	self._btnMaxLevelAnim = gohelper.onceAddComponent(self._btnmaxlevel.gameObject, typeof(UnityEngine.Animator))
end

function EquipInfoView:_onHyperLinkClick()
	EquipController.instance:openEquipSkillTipView({
		self._equipMO,
		self._equipId,
		true
	})
end

function EquipInfoView:_onClick()
	self._lock = not self._lock

	UISpriteSetMgr.instance:setEquipSprite(self._imagelock, self._lock and "xinxiang_suo" or "xinxiang_jiesuo", false)
	EquipRpc.instance:sendEquipLockRequest(self._equipMO.id, self._lock)

	if self._lock then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Lock)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Unlock)
	end
end

function EquipInfoView:onUpdateParam()
	return
end

function EquipInfoView:onOpen()
	self._equipMO = self.viewContainer.viewParam.equipMO

	if self._equipMO then
		self._equipId = self._equipMO.config.id or self.viewContainer.viewParam.equipId
	end

	self._hadEquip = true

	if not self._equipMO and self._equipId then
		self._hadEquip = false
		self._equipMO = EquipHelper.createMinLevelEquipMo(self._equipId)
	end

	self._config = self._equipMO.config

	local heroMO = EquipTeamListModel.instance:getHero()

	self._heroId = heroMO and heroMO.heroId
	self._isNormalEquip = EquipHelper.isNormalEquip(self._config)

	gohelper.setActive(self._btnmaxlevel.gameObject, self._isNormalEquip)

	self._showMax = false
	self._lock = self._equipMO.isLock

	gohelper.setActive(self._imagelock.gameObject, self._hadEquip and self._isNormalEquip)

	if self._hadEquip and self._isNormalEquip then
		UISpriteSetMgr.instance:setEquipSprite(self._imagelock, self._lock and "xinxiang_suo" or "xinxiang_jiesuo", false)
	end

	gohelper.setActive(self._goprogress, self._isNormalEquip)
	gohelper.setActive(self._goattribute, self._isNormalEquip)
	gohelper.setActive(self._txtattributelv.gameObject, self._isNormalEquip)
	self:refreshMaxLevelImage(1)
	self:refreshTxtTitle()
	self:refreshUI()

	if self.viewContainer:getIsOpenLeftBackpack() then
		self.viewContainer.equipView:showTitleAndCenter()
	end

	self._animator:Play(UIAnimationName.Open)
end

function EquipInfoView:refreshMaxLevelImage(offset)
	self._btnMaxLevelAnim:Play(self._showMax and "open" or "close", 0, offset)
end

function EquipInfoView:refreshTxtTitle()
	self.txtTitle.text = EquipHelper.isExpEquip(self._config) and luaLang("p_equipinfo_exp_title") or (EquipHelper.isRefineUniversalMaterials(self._config.id) or EquipHelper.isSpRefineEquip(self._config)) and luaLang("p_equipinfo_refine_title") or luaLang("p_equipinfo_normal_title")
end

function EquipInfoView:refreshUI()
	self:refreshTag()
	self:refreshBaseAttr()

	if not self._isNormalEquip or self._isNormalEquip and self._equipMO.config.rare > EquipConfig.instance:getNotShowRefineRare() then
		gohelper.setActive(self._goSkillContainer, true)

		self._txtattributelv.text = self._equipMO.refineLv

		self:refreshSkillDesc()
	else
		gohelper.setActive(self._goSkillContainer, false)
	end

	self:showProgress()
end

function EquipInfoView:refreshTag()
	local tagStr = self._config.tag

	if string.nilorempty(tagStr) then
		gohelper.setActive(self._goType, false)

		return
	end

	gohelper.setActive(self._goType, true)

	local tagList = EquipConfig.instance:getTagList(self._config)
	local tagItem

	for index, tagId in ipairs(tagList) do
		tagItem = self.tagItemList[index]

		if not self.tagItemList[index] then
			tagItem = self:getUserDataTb_()
			tagItem.go = gohelper.cloneInPlace(self._goTypeItem)
			tagItem.txt = tagItem.go:GetComponent(gohelper.Type_TextMesh)

			table.insert(self.tagItemList, tagItem)
		end

		gohelper.setActive(tagItem.go, true)

		tagItem.txt.text = EquipConfig.instance:getTagName(tagId)
	end

	for i = #tagList + 1, #self.tagItemList do
		gohelper.setActive(self.tagItemList[i].go, false)
	end
end

function EquipInfoView:refreshBaseAttr()
	local attr_dic, attr_list

	if self._equipMO then
		attr_dic, attr_list = EquipConfig.instance:getEquipNormalAttr(self._equipId, self._equipMO.level, HeroConfig.sortAttrForEquipView)
	else
		attr_dic, attr_list = EquipConfig.instance:getMaxEquipNormalAttr(self._equipId, HeroConfig.sortAttrForEquipView)
	end

	local attrItem

	for index, attr in ipairs(attr_list) do
		attrItem = self.strengthenAttrItemList[index]

		if not self.strengthenAttrItemList[index] then
			attrItem = self:getUserDataTb_()
			attrItem.go = gohelper.cloneInPlace(self._gostrengthenattr)
			attrItem.icon = gohelper.findChildImage(attrItem.go, "image_icon")
			attrItem.name = gohelper.findChildText(attrItem.go, "txt_name")
			attrItem.value = gohelper.findChildText(attrItem.go, "txt_value")
			attrItem.goBg = gohelper.findChild(attrItem.go, "go_bg")

			table.insert(self.strengthenAttrItemList, attrItem)
		end

		gohelper.setActive(attrItem.go, true)
		gohelper.setActive(attrItem.goBg, index % 2 == 0)

		local config = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(attr.attrType))

		UISpriteSetMgr.instance:setCommonSprite(attrItem.icon, "icon_att_" .. config.id)

		attrItem.name.text = config.name
		attrItem.value.text = attr.value
	end

	for i = #attr_list + 1, #self.strengthenAttrItemList do
		gohelper.setActive(self.strengthenAttrItemList[i].go, false)
	end

	local attrId, value = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(self._config, self._equipMO.breakLv)

	if attrId then
		gohelper.setActive(self._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(self.imageBreakIcon, "icon_att_" .. attrId)

		self.txtBreakAttrName.text = EquipHelper.getAttrBreakText(attrId)
		self.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(value)

		gohelper.setAsLastSibling(self._gobreakeffect)
	else
		gohelper.setActive(self._gobreakeffect, false)
	end
end

function EquipInfoView:refreshSkillDesc()
	local skillDescList = EquipHelper.getEquipSkillDescList(self._config.id, self._equipMO.refineLv, "#D9A06F")

	if not next(skillDescList) then
		gohelper.setActive(self._goSkill, false)
	else
		gohelper.setActive(self._goSkill, true)

		local skillItem

		for index, desc in ipairs(skillDescList) do
			skillItem = self.skillItemList[index]

			if not self.skillItemList[index] then
				skillItem = self:getUserDataTb_()
				skillItem.itemGo = gohelper.cloneInPlace(self._goSkillItem)
				skillItem.txt = gohelper.findChildText(skillItem.itemGo, "skill_desc")

				SkillHelper.addHyperLinkClick(skillItem.txt, self.onClickSkillDescHyperLink, self)

				skillItem.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(skillItem.txt.gameObject, FixTmpBreakLine)

				table.insert(self.skillItemList, skillItem)
			end

			skillItem.txt.text = EquipHelper.getEquipSkillDesc(desc)

			skillItem.fixTmpBreakLine:refreshTmpContent(skillItem.txt)
			gohelper.setActive(skillItem.itemGo, true)
		end

		for i = #skillDescList + 1, #self.skillItemList do
			gohelper.setActive(self.skillItemList[i].itemGo, false)
		end
	end
end

function EquipInfoView:onClickSkillDescHyperLink(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(effId, {
		x = -321,
		y = -129.5
	})
end

function EquipInfoView:showProgress()
	if self._showMax then
		for i = 1, 5 do
			UISpriteSetMgr.instance:setEquipSprite(self["_image" .. i], "bg_xinxiang_dengji")
		end

		gohelper.setActive(self._txttotallevel.gameObject, false)
	elseif self._isNormalEquip then
		self._txttotallevel.text = string.format("/%s", EquipConfig.instance:getCurrentBreakLevelMaxLevel(self._equipMO))

		gohelper.setActive(self._txttotallevel.gameObject, true)

		for i = 1, 5 do
			UISpriteSetMgr.instance:setEquipSprite(self["_image" .. i], i <= self._equipMO.refineLv and "bg_xinxiang_dengji" or "bg_xinxiang_dengji_dis")
		end
	else
		gohelper.setActive(self._txttotallevel.gameObject, false)
	end

	self._txtcurlevel.text = self._equipMO.level

	gohelper.setActive(self._gotip, self._showMax and not EquipHelper.isConsumableEquip(self._equipMO.equipId))
end

function EquipInfoView:onOpenFinish()
	return
end

function EquipInfoView:onClose()
	self:playCloseAnimation()
end

function EquipInfoView:playCloseAnimation()
	self._animator:Play(UIAnimationName.Close)
end

function EquipInfoView:onDestroyView()
	if self._itemList then
		for i, v in ipairs(self._itemList) do
			v:destroyView()
		end
	end

	self._click:RemoveClickListener()

	self.strengthenAttrItemList = nil
	self.tagItemList = nil
	self.skillItemList = nil
end

return EquipInfoView
