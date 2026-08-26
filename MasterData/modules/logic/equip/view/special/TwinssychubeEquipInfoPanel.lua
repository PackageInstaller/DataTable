-- chunkname: @modules/logic/equip/view/special/TwinssychubeEquipInfoPanel.lua

module("modules.logic.equip.view.special.TwinssychubeEquipInfoPanel", package.seeall)

local TwinssychubeEquipInfoPanel = class("TwinssychubeEquipInfoPanel", LuaCompBase)

function TwinssychubeEquipInfoPanel:init(go)
	self.viewGO = go
	self._txtTilte = gohelper.findChildText(self.viewGO, "#txt_title")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._goequipinfo = gohelper.findChild(self.viewGO, "#go_container/#go_equipinfo")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_container/#go_equipinfo/#txt_name")
	self._image1 = gohelper.findChildImage(self.viewGO, "#go_container/#go_equipinfo/go_insigt/#image_1")
	self._image2 = gohelper.findChildImage(self.viewGO, "#go_container/#go_equipinfo/go_insigt/#image_2")
	self._image3 = gohelper.findChildImage(self.viewGO, "#go_container/#go_equipinfo/go_insigt/#image_3")
	self._image4 = gohelper.findChildImage(self.viewGO, "#go_container/#go_equipinfo/go_insigt/#image_4")
	self._image5 = gohelper.findChildImage(self.viewGO, "#go_container/#go_equipinfo/go_insigt/#image_5")
	self._image6 = gohelper.findChildImage(self.viewGO, "#go_container/#go_equipinfo/go_insigt/#image_6")
	self._gointeam = gohelper.findChild(self.viewGO, "#go_container/#go_equipinfo/#go_inteam")
	self._simageinteamHeroIcon = gohelper.findChildSingleImage(self.viewGO, "#go_container/#go_equipinfo/#go_inteam/#simage_inteamHeroIcon")
	self._txtinteamName = gohelper.findChildText(self.viewGO, "#go_container/#go_equipinfo/#go_inteam/#txt_inteamName")
	self._gostate = gohelper.findChild(self.viewGO, "#go_container/#go_equipinfo/#go_state")
	self._btncompare = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_equipinfo/#go_state/#btn_compare")
	self._btninteam = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_equipinfo/#go_state/#btn_inteam")
	self._btnfold = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_equipinfo/#go_state/#btn_fold")
	self._goisBalance = gohelper.findChild(self.viewGO, "#go_container/#go_equipinfo/#go_isBalance")
	self._goattr = gohelper.findChild(self.viewGO, "#go_container/#go_equipinfo/#go_attr")
	self._txtlevel = gohelper.findChildText(self.viewGO, "#go_container/#go_equipinfo/#go_attr/#txt_level")
	self._gostrengthenattr = gohelper.findChild(self.viewGO, "#go_container/#go_equipinfo/#go_attr/layout/attribute/container/#go_strengthenattr")
	self._gobreakeffect = gohelper.findChild(self.viewGO, "#go_container/#go_equipinfo/#go_attr/layout/attribute/container/#go_breakeffect")
	self._gosuitattribute = gohelper.findChild(self.viewGO, "#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute")
	self._txtattributelv = gohelper.findChildText(self.viewGO, "#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/attributename/#txt_attributelv")
	self._scrolldesccontainer = gohelper.findChildScrollRect(self.viewGO, "#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer")
	self._gosuiteffect = gohelper.findChild(self.viewGO, "#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect")
	self._gobaseskill = gohelper.findChild(self.viewGO, "#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
	self._txtsuiteffect2 = gohelper.findChildText(self.viewGO, "#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	self._imagepoint = gohelper.findChildImage(self.viewGO, "#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2/#image_point")
	self._btnmaxlevel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_equipinfo/#btn_maxlevel")
	self._imagearrow = gohelper.findChildImage(self.viewGO, "#image_arrow")
	self._btnImprint = gohelper.findChildButtonWithAudio(self.viewGO, "btn/btn_Imprint")
	self._txtImprint = gohelper.findChildText(self._btnImprint.gameObject, "txt_Imprint")
	self._btnEquip = gohelper.findChildButtonWithAudio(self.viewGO, "btn/btn_Equip")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "btn/btn_Buy")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animEvent = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TwinssychubeEquipInfoPanel:addEventListeners()
	self._btncompare:AddClickListener(self._btncompareOnClick, self)
	self._btninteam:AddClickListener(self._btninteamOnClick, self)
	self._btnfold:AddClickListener(self._btnfoldOnClick, self)
	self._btnmaxlevel:AddClickListener(self._btnmaxlevelOnClick, self)
	self._btnImprint:AddClickListener(self._btnjumpOnClick, self)
	self._btnEquip:AddClickListener(self._btnEquipOnClick, self)
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
end

function TwinssychubeEquipInfoPanel:removeEventListeners()
	self._btncompare:RemoveClickListener()
	self._btninteam:RemoveClickListener()
	self._btnfold:RemoveClickListener()
	self._btnmaxlevel:RemoveClickListener()
	self._btnImprint:RemoveClickListener()
	self._btnEquip:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._animEvent:RemoveEventListener(self._animkey)
end

function TwinssychubeEquipInfoPanel:_btnEquipOnClick()
	EquipController.instance:openEquipInfoTeamView({
		heroMo = self._heroMo,
		equipMo = self._equipMo,
		fromView = EquipEnum.FromViewEnum.FromTwinssychubeEquipInfoView
	})
end

function TwinssychubeEquipInfoPanel:_btncompareOnClick()
	return
end

function TwinssychubeEquipInfoPanel:_btninteamOnClick()
	return
end

function TwinssychubeEquipInfoPanel:_btnfoldOnClick()
	return
end

function TwinssychubeEquipInfoPanel:_btnjumpOnClick()
	if self._equipMo then
		ViewMgr.instance:openView(ViewName.EquipView, {
			equipMO = self._equipMo,
			defaultTabIds = {
				[2] = 2
			}
		})
	end
end

function TwinssychubeEquipInfoPanel:_btnmaxlevelOnClick()
	return
end

function TwinssychubeEquipInfoPanel:_btnlockOnClick()
	return
end

function TwinssychubeEquipInfoPanel:_btnnotownedOnClick()
	return
end

function TwinssychubeEquipInfoPanel:_btnBuyOnClick()
	local goods = self:_getEquipGoodsMo()

	if not goods then
		return
	end

	ViewMgr.instance:openView(ViewName.NormalStoreGoodsView, goods)
end

function TwinssychubeEquipInfoPanel:_editableInitView()
	self.strengthenAttrItems = self:getUserDataTb_()
	self.skillAttributeItems = self:getUserDataTb_()
	self.skillDescItems = self:getUserDataTb_()
	self.imageBreakIcon = gohelper.findChildImage(self._gobreakeffect, "image_icon")
	self.txtBreakAttrName = gohelper.findChildText(self._gobreakeffect, "txt_name")
	self.txtBreakValue = gohelper.findChildText(self._gobreakeffect, "txt_value")
	self._infoCanvasGroup = self._goequipinfo:GetComponent(gohelper.Type_CanvasGroup)

	gohelper.setActive(self._gostrengthenattr, false)
	gohelper.setActive(self._txtsuiteffect2.gameObject, false)
end

function TwinssychubeEquipInfoPanel:initPanel(index, euqipId)
	self._euqipId = euqipId
	self._index = index
	self._quipConfig = EquipConfig.instance:getEquipCo(self._euqipId)
	self._animkey = "switch_panel0" .. self._index

	self._animEvent:AddEventListener(self._animkey, self._refreshView, self)

	self._equipMo = EquipModel.instance:getTwinssychubeEquipMo(euqipId)
end

function TwinssychubeEquipInfoPanel:setBalanceEquipMo(equipMo)
	self._balanceEquipMo = equipMo

	gohelper.setActive(self._goisBalance, self._balanceEquipMo ~= nil)
	self:_refreshView()
end

function TwinssychubeEquipInfoPanel:onUpdateMO(heroMo, isOpen)
	self._heroMo = heroMo

	self:_refresh(isOpen)
end

function TwinssychubeEquipInfoPanel:_refresh(isOpen)
	if not self._heroMo then
		return
	end

	self._traialEquipMo = self._heroMo:getTrialEquipMo()
	self._heroEquipMo = not string.nilorempty(self._heroMo.defaultEquipUid) and EquipModel.instance:getEquip(self._heroMo.defaultEquipUid)
	self._equipMo = EquipModel.instance:getTwinssychubeEquipMo(self._euqipId)

	gohelper.setActive(self._goisBalance, false)
	self:_refreshView(isOpen)
end

function TwinssychubeEquipInfoPanel:_getEquipMo()
	return self._traialEquipMo or self._balanceEquipMo or self._equipMo
end

function TwinssychubeEquipInfoPanel:_refreshView(isOpen)
	local equipMo = self:_getEquipMo()
	local had = equipMo ~= nil
	local isActivate = EquipModel.instance:isActivateTwinssychubeEquip(self._heroMo)

	if not self._traialEquipMo then
		local heroEquipMo = self._heroEquipMo
		local isEquiped = heroEquipMo and heroEquipMo.config.id == self._euqipId
		local isNewUnlock = GameUtil.playerPrefsGetNumberByUserId(EquipEnum.sp02TwinssychubeUnlockKey .. self._euqipId, 0) == 0
		local isPlayUnlock = isActivate or isEquiped

		if isPlayUnlock then
			if isOpen then
				if isNewUnlock then
					TaskDispatcher.runDelay(self._playUnlockAnim, self, 0.6)

					had = false
				end
			elseif not self._isPlayUnlock then
				self:_playUnlockAnim()
				GameUtil.playerPrefsSetNumberByUserId(EquipEnum.sp02TwinssychubeUnlockKey .. self._euqipId, 1)
			end
		end

		self._isPlayUnlock = isPlayUnlock
		self._infoCanvasGroup.alpha = isPlayUnlock and 1 or 0.5

		local title = had and (isEquiped and "sp02_twinspsychubeequipinfoview_title_euiped" or isActivate and "sp02_twinspsychubeequipinfoview_title_unlock" or "p_sp02_twinspsychubeequipinfoview_1") or "sp02_twinspsychubeequipinfoview_title_lock"

		self._txtname.text = self._quipConfig.name

		self:refreshEquipLevel()
		self:_refreshEquipNormalAttr()
		self:_refreshEquipSkillDesc()
		self:_refreshEquipStar()

		self._txtTilte.text = luaLang(title)

		if equipMo then
			if not equipMo.level then
				local level = 1
				local isMaxLevel = false
				local isShowBuy = false

				if had then
					local maxLv = EquipConfig.instance:getMaxLevel(self._quipConfig)

					isMaxLevel = maxLv <= level
				else
					local storeActId = VersionActivity3_10Enum.ActivityId.DungeonStore

					if not ActivityHelper.isOpen(storeActId) and self:_getEquipGoodsMo() then
						isShowBuy = true
					end
				end

				gohelper.setActive(self._btnImprint.gameObject, (isActivate or isEquiped) and not isMaxLevel)
				gohelper.setActive(self._btnEquip.gameObject, had and not isActivate and not isEquiped)
				gohelper.setActive(self._btnBuy.gameObject, isShowBuy)

				if (isActivate or isEquiped) and not isMaxLevel then
					local txtImprint = level == EquipConfig.instance:getCurrentBreakLevelMaxLevel(equipMo) and "p_equipstrengthen_break" or "p_equip_11"

					self._txtImprint.text = luaLang(txtImprint)
				end
			end
		end
	end
end

function TwinssychubeEquipInfoPanel:_getEquipGoodsMo()
	local storeMo = StoreModel.instance:getStoreMO(StoreEnum.StoreId.TwinssychubeEquipStore)

	if storeMo then
		local goodsList = storeMo:getGoodsList()

		if goodsList then
			for _, goods in ipairs(goodsList) do
				local product = goods.config.product
				local productArr = GameUtil.splitString2(product, true)
				local itemType = productArr[1][1]
				local itemId = productArr[1][2]

				if itemType == MaterialEnum.MaterialType.Equip and itemId == self._euqipId then
					return goods
				end
			end
		end
	end
end

function TwinssychubeEquipInfoPanel:_playUnlockAnim()
	self._anim:Play("unlock", 0, 0)
	GameUtil.playerPrefsSetNumberByUserId(EquipEnum.sp02TwinssychubeUnlockKey .. self._euqipId, 1)
	AudioMgr.instance:trigger(AudioEnum3_10.Twinssychube.play_ui_langchao_link_refresh_light)
end

function TwinssychubeEquipInfoPanel:refreshEquipLevel()
	if self._balanceEquipMo then
		if not HeroGroupBalanceHelper.BalanceColor then
			local color1 = "#d9a06f"

			if self._balanceEquipMo then
				if not HeroGroupBalanceHelper.BalanceColor then
					local color2 = "#777676"
					local equipMo = self:_getEquipMo()

					if equipMo then
						if not equipMo.level then
							local level = 1

							if equipMo then
								local var_22_3 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(equipMo)

								if not var_22_3 then
									var_22_3 = EquipConfig.instance:getMaxLevel(self._quipConfig)

									local maxLevel = var_22_3

									self._txtlevel.text = string.format("LV.<color=%s>%d</color>/<color=%s>%d</color>", color1, level, color2, maxLevel)
								end
							end
						end
					end
				end
			end
		end
	end
end

function TwinssychubeEquipInfoPanel:_refreshEquipNormalAttr()
	local equipMo = self:_getEquipMo()

	if equipMo then
		if not equipMo.level then
			local level = 1
			local _, attrList = EquipConfig.instance:getEquipNormalAttr(self._euqipId, level, HeroConfig.sortAttrForEquipView)
			local item, attrConfig

			for index, attr in ipairs(attrList) do
				item = self:_getAttrItem(index)
				attrConfig = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(attr.attrType))

				UISpriteSetMgr.instance:setCommonSprite(item.icon, "icon_att_" .. attrConfig.id)

				item.name.text = attrConfig.name
				item.attr_value.text = attr.value

				gohelper.setActive(item.bg, index % 2 == 0)
				gohelper.setActive(item.go, true)
			end

			for i = #attrList + 1, #self.strengthenAttrItems do
				gohelper.setActive(self.strengthenAttrItems[i].go, false)
			end

			if equipMo then
				if not equipMo.breakLv then
					local breakLv = 0
					local attrId, value = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(self._quipConfig, breakLv)

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
			end
		end
	end
end

function TwinssychubeEquipInfoPanel:_refreshEquipSkillDesc()
	local equipMo = self:_getEquipMo()

	if equipMo then
		if not equipMo.refineLv then
			local refineLv = 1
			local skillDesList = EquipHelper.getEquipSkillBaseDes(self._euqipId, refineLv, "#D9A06F")
			local count = 0

			if #skillDesList == 0 then
				gohelper.setActive(self._gobaseskill.gameObject, false)
			else
				gohelper.setActive(self._gobaseskill.gameObject, true)

				for index, desc in ipairs(skillDesList) do
					local item = self:_getSkillDescItem(index)

					item.txt.text = EquipHelper.getEquipSkillDesc(desc)
					count = count + 1
				end
			end

			for i = 1, #self.skillDescItems do
				gohelper.setActive(self.skillDescItems[i].itemGo, i <= count)
			end

			self._txtattributelv.text = refineLv
		end
	end
end

function TwinssychubeEquipInfoPanel:_getAttrItem(index)
	local item = self.strengthenAttrItems[index]

	if not item then
		item = {
			go = gohelper.cloneInPlace(self._gostrengthenattr, "item" .. index)
		}
		item.icon = gohelper.findChildImage(item.go, "image_icon")
		item.name = gohelper.findChildText(item.go, "txt_name")
		item.attr_value = gohelper.findChildText(item.go, "txt_value")
		item.bg = gohelper.findChild(item.go, "bg")

		table.insert(self.strengthenAttrItems, item)
	end

	return item
end

function TwinssychubeEquipInfoPanel:_getSkillDescItem(index)
	local item = self.skillDescItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._txtsuiteffect2.gameObject, "item_" .. index)

		item.itemGo = go
		item.imagepoint = gohelper.findChildImage(go, "#image_point")
		item.txt = go:GetComponent(gohelper.Type_TextMesh)

		SkillHelper.addHyperLinkClick(item.txt)
		table.insert(self.skillDescItems, item)
	end

	return item
end

function TwinssychubeEquipInfoPanel:_refreshEquipStar()
	local equipRare = self._quipConfig.rare

	for i = 1, 6 do
		gohelper.setActive(self["_image" .. i].gameObject, i <= equipRare + 1)
	end
end

function TwinssychubeEquipInfoPanel:onDestroy()
	TaskDispatcher.cancelTask(self._playUnlockAnim, self)
end

return TwinssychubeEquipInfoPanel
