-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotEquipInfoTeamShowView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEquipInfoTeamShowView", package.seeall)

local V1a6_CachotEquipInfoTeamShowView = class("V1a6_CachotEquipInfoTeamShowView", BaseView)

function V1a6_CachotEquipInfoTeamShowView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagecompare = gohelper.findChildSingleImage(self.viewGO, "#simage_compare")
	self._goleftempty = gohelper.findChild(self.viewGO, "#go_leftempty")
	self._goheroempty = gohelper.findChild(self.viewGO, "#go_leftempty/#go_heroempty")
	self._goequipinfoempty = gohelper.findChild(self.viewGO, "#go_leftempty/#go_equipinfoempty")
	self._goequipempty = gohelper.findChild(self.viewGO, "#go_equipempty")
	self._gocontainer = gohelper.findChild(self.viewGO, "container/#go_container")
	self._gocontainer1 = gohelper.findChild(self.viewGO, "container/#go_container1")
	self._goherocontainer = gohelper.findChild(self.viewGO, "container/#go_container/#go_herocontainer")
	self._txtheroname = gohelper.findChildText(self.viewGO, "container/#go_container/#go_herocontainer/#txt_heroname")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "container/#go_container/#go_herocontainer/mask/#simage_heroicon")
	self._imageherocareer = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_herocontainer/#image_herocareer")
	self._goequipinfo = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo")
	self._txtname = gohelper.findChildText(self.viewGO, "container/#go_container/#go_equipinfo/#txt_name")
	self._txtlevel = gohelper.findChildText(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/#txt_level")
	self._image1 = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_1")
	self._image2 = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_2")
	self._image3 = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_3")
	self._image4 = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_4")
	self._image5 = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_5")
	self._image6 = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_6")
	self._gostrengthenattr = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/attribute/container/#go_strengthenattr")
	self._gobreakeffect = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/attribute/container/#go_breakeffect")
	self._gosuitattribute = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute")
	self._txtattributelv = gohelper.findChildText(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/attributename/#txt_attributelv")
	self._scrolldesccontainer = gohelper.findChildScrollRect(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer")
	self._gosuiteffect = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect")
	self._gobaseskill = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
	self._txteffect = gohelper.findChildText(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/title/#txt_effect")
	self._txtsuiteffect2 = gohelper.findChildText(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/#btn_jump")
	self._gocenter = gohelper.findChild(self.viewGO, "#go_center")
	self._simageequip = gohelper.findChildSingleImage(self.viewGO, "#go_center/#simage_equip")
	self._goequipcontainer = gohelper.findChild(self.viewGO, "#go_equipcontainer")
	self._scrollequip = gohelper.findChildScrollRect(self.viewGO, "#go_equipcontainer/#scroll_equip")
	self._goequipsort = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort")
	self._btnequiplv = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv")
	self._btnequiprare = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter")
	self._gobuttom = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_buttom")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipcontainer/#go_buttom/#btn_cancel")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipcontainer/#go_buttom/#btn_confirm")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gobalance = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_isBalance")
	self._btncompare = gohelper.findChildButtonWithAudio(self.viewGO, "container/#go_container/#go_equipinfo/#go_state/#btn_compare")
	self._btninteam = gohelper.findChildButtonWithAudio(self.viewGO, "container/#go_container/#go_equipinfo/#go_state/#btn_inteam")
	self._btnfold = gohelper.findChildButtonWithAudio(self.viewGO, "container/#go_container/#go_equipinfo/#go_state/#btn_fold")
	self._gointeam = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_inteam")
	self._gointeamheroicon = gohelper.findChildSingleImage(self.viewGO, "container/#go_container/#go_equipinfo/#go_inteam/#simage_inteamHeroIcon")
	self._gointeamheroname = gohelper.findChildText(self.viewGO, "container/#go_container/#go_equipinfo/#go_inteam/#txt_inteamName")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._gotrialtip = gohelper.findChild(self.viewGO, "#go_trialtip")
	self.layoutElement = self._scrolldesccontainer:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	self._goAttr = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr")
	self._goseatlevel = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_level")
	self._seatIcon = gohelper.findChildImage(self.viewGO, "#go_equipcontainer/#go_level/bg/#txt_title/icon")
	self._seatEffect = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_level/bg/#txt_title/quality_effect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotEquipInfoTeamShowView:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btnequiplv:AddClickListener(self._btnequiplvOnClick, self)
	self._btnequiprare:AddClickListener(self._btnequiprareOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncompare:AddClickListener(self._btncompareOnClick, self)
	self._btnfold:AddClickListener(self._btnfoldOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
end

function V1a6_CachotEquipInfoTeamShowView:removeEvents()
	self._btnjump:RemoveClickListener()
	self._btnequiplv:RemoveClickListener()
	self._btnequiprare:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btncompare:RemoveClickListener()
	self._btnfold:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
end

function V1a6_CachotEquipInfoTeamShowView:_btnfilterOnClick()
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		isNotShowObtain = true,
		viewName = self.viewName
	})
end

function V1a6_CachotEquipInfoTeamShowView:_btncompareOnClick()
	if not self.originEquipMo then
		return
	end

	if self.comparing then
		return
	end

	self.comparing = true

	gohelper.setActive(self._gocontainer1, true)
	gohelper.setActive(self._simagecompare.gameObject, true)
	self:refreshSelectStatus()
end

function V1a6_CachotEquipInfoTeamShowView:_btnfoldOnClick()
	if not self.comparing then
		return
	end

	self.comparing = false

	gohelper.setActive(self._gocontainer1, false)
	gohelper.setActive(self._simagecompare.gameObject, false)
	self:refreshSelectStatus()
end

function V1a6_CachotEquipInfoTeamShowView:_btncancelOnClick()
	self:closeThis()
end

function V1a6_CachotEquipInfoTeamShowView:_btnconfirmOnClick()
	local handleFunc = self.handleFuncDict[self.viewParam.fromView]

	handleFunc(self)
end

function V1a6_CachotEquipInfoTeamShowView:_onClickConfirmBtnFromCachotHeroGroupFightView()
	local currentPosEquipList = self.viewContainer.listModel:getGroupCurrentPosEquip()
	local equipUid = currentPosEquipList[1]
	local isReplace = not not (equipUid and (EquipModel.instance:getEquip(equipUid) or HeroGroupTrialModel.instance:getEquipMo(equipUid)))

	EquipChooseListModel.instance:clearTeamInfo()

	local curGroupMO = self.viewContainer.listModel.curGroupMO
	local equipTable = {}

	equipTable.index = self.posIndex

	local var_9_0 = {}

	if self.selectedEquipMo then
		var_9_0[1] = self.selectedEquipMo.uid or "0"
	end

	equipTable.equipUid = var_9_0

	V1a6_CachotHeroGroupModel.instance:replaceEquips(equipTable, curGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, self.posIndex)
	V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup(self.closeThis, self)
end

function V1a6_CachotEquipInfoTeamShowView:_onClickConfirmBtnFromCachotHeroGroupView()
	local currentPosEquipList = self.viewContainer.listModel:getGroupCurrentPosEquip()
	local equipUid = currentPosEquipList[1]
	local isReplace = not not (equipUid and (EquipModel.instance:getEquip(equipUid) or HeroGroupTrialModel.instance:getEquipMo(equipUid)))

	EquipChooseListModel.instance:clearTeamInfo()

	local curGroupMO = self.viewContainer.listModel.curGroupMO
	local equipTable = {}

	equipTable.index = self.posIndex

	local var_10_0 = {}

	if self.selectedEquipMo then
		var_10_0[1] = self.selectedEquipMo.uid or "0"
	end

	equipTable.equipUid = var_10_0

	V1a6_CachotHeroGroupModel.instance:replaceEquips(equipTable, curGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, self.posIndex)
	self:closeThis()
end

function V1a6_CachotEquipInfoTeamShowView:_onClickConfirmBtnFromHeroGroupFightView()
	local currentPosEquipList = self.viewContainer.listModel:getGroupCurrentPosEquip()
	local equipUid = currentPosEquipList[1]
	local isReplace = not not (equipUid and (EquipModel.instance:getEquip(equipUid) or HeroGroupTrialModel.instance:getEquipMo(equipUid)))

	EquipChooseListModel.instance:clearTeamInfo()

	local curGroupMO = self.viewContainer.listModel.curGroupMO
	local equipTable = {}

	equipTable.index = self.posIndex

	local var_11_0 = {}

	if self.selectedEquipMo then
		var_11_0[1] = self.selectedEquipMo.uid or "0"
	end

	equipTable.equipUid = var_11_0

	HeroGroupModel.instance:replaceEquips(equipTable, curGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, self.posIndex)
	HeroGroupModel.instance:saveCurGroupData(self.closeThis, self, curGroupMO)
end

function V1a6_CachotEquipInfoTeamShowView:_onClickConfirmBtnFromCharacterView()
	HeroRpc.instance:setHeroDefaultEquipRequest(self.heroMo.heroId, (self.selectedEquipMo or nil) and (self.selectedEquipMo.uid or "0"))
end

function V1a6_CachotEquipInfoTeamShowView:_btnjumpOnClick()
	if self.selectedEquipMo then
		self._anim:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(function()
			ViewMgr.instance:openView(ViewName.EquipView, {
				equipMO = self.selectedEquipMo,
				defaultTabIds = {
					[2] = 2
				}
			})
		end, nil, 0.07)
	end
end

function V1a6_CachotEquipInfoTeamShowView:_btnequiplvOnClick()
	self.listModel:changeSortByLevel()
	self:refreshBtnStatus()
end

function V1a6_CachotEquipInfoTeamShowView:_btnequiprareOnClick()
	self.listModel:changeSortByRare()
	self:refreshBtnStatus()
end

function V1a6_CachotEquipInfoTeamShowView:onEquipTypeHasChange(viewName)
	if viewName ~= self.viewName then
		return
	end

	self._scrollequip.verticalNormalizedPosition = 1

	if self.heroMo then
		if self.heroMo then
			self.listModel.equipMoList = self.filterMo:checkIsIncludeTag(self.heroMo.config) and {
				self.heroMo
			} or {}
		else
			self.listModel:initEquipList(self.filterMo)
		end

		self.listModel:refreshEquipList()
		self:refreshFilterBtnStatus()
	end
end

function V1a6_CachotEquipInfoTeamShowView:_editableInitView()
	self.goNotFilter = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter/#go_notfilter")
	self.goFilter = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter/#go_filter")
	self.goRareBtnNoSelect = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn1")
	self.goRareBtnSelect = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn2")
	self.goLvBtnNoSelect = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn1")
	self.goLvBtnSelect = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn2")
	self.goRareBtnSelectArrow = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn2/txt/arrow")
	self.goLvBtnSelectArrow = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn2/txt/arrow")
	self.goBaseSkillCanvasGroup = self._gobaseskill:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.imageBreakIcon = gohelper.findChildImage(self._gobreakeffect, "image_icon")
	self.txtBreakAttrName = gohelper.findChildText(self._gobreakeffect, "txt_name")
	self.txtBreakValue = gohelper.findChildText(self._gobreakeffect, "txt_value")

	gohelper.setActive(self._goleftempty, true)
	gohelper.setActive(self._gocontainer1, false)
	gohelper.setActive(self._gostrengthenattr, false)
	gohelper.setActive(self._txtsuiteffect2.gameObject, false)
	gohelper.addUIClickAudio(self._btnjump.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	gohelper.addUIClickAudio(self._btncompare.gameObject, AudioEnum.HeroGroupUI.Play_UI_General_OK)
	gohelper.addUIClickAudio(self._btnfold.gameObject, AudioEnum.HeroGroupUI.Play_UI_General_OK)

	self.strengthenAttrItems = self:getUserDataTb_()
	self.skillAttributeItems = self:getUserDataTb_()
	self.skillDescItems = self:getUserDataTb_()
	self.container1_strengthenAttrItems = self:getUserDataTb_()
	self.container1_skillAttributeItems = self:getUserDataTb_()
	self.container1_skillDescItems = self:getUserDataTb_()

	self.addEventCb(self, EquipController.instance, EquipEvent.ChangeSelectedEquip, self.onSelectEquipChange, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onBreakSuccess, self.onEquipChange, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onEquipStrengthenReply, self.onEquipChange, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onEquipRefineReply, self.onEquipChange, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self.onEquipChange, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onDeleteEquip, self.onDeleteEquip, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self, LuaEventSystem.Low)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successSetDefaultEquip, self.onSuccessSetDefaultEquip, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.OnEquipTypeHasChange, self.onEquipTypeHasChange, self)

	self.txtConfirm = gohelper.findChildText(self._btnconfirm.gameObject, "txt")
	self.comparing = false
	self.handleFuncDict = {
		[EquipEnum.FromViewEnum.FromHeroGroupFightView] = self._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCachotHeroGroupFightView] = self._onClickConfirmBtnFromCachotHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCachotHeroGroupView] = self._onClickConfirmBtnFromCachotHeroGroupView,
		[EquipEnum.FromViewEnum.FromCharacterView] = self._onClickConfirmBtnFromCharacterView,
		[EquipEnum.FromViewEnum.FromSeasonFightView] = self._onClickConfirmBtnFromHeroGroupFightView
	}
end

function V1a6_CachotEquipInfoTeamShowView:onUpdateParam()
	return
end

function V1a6_CachotEquipInfoTeamShowView:onOpenFinish()
	self._anim.enabled = true

	if self.viewParam and self.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.EquipInfo)
	end
end

function V1a6_CachotEquipInfoTeamShowView:_onCloseFullView()
	if self._anim then
		self._anim:Play(UIAnimationName.Open, 0, 0)
	end
end

function V1a6_CachotEquipInfoTeamShowView:onOpen()
	local seatLevel = self.viewParam.seatLevel

	self._seatLevel = seatLevel

	gohelper.setActive(self._goseatlevel, seatLevel)

	if seatLevel then
		UISpriteSetMgr.instance:setV1a6CachotSprite(self._seatIcon, "v1a6_cachot_quality_0" .. seatLevel)

		if not self._qualityEffectList then
			self._qualityEffectList = self:getUserDataTb_()

			local transform = self._seatEffect.transform
			local childCount = transform.childCount

			for i = 1, childCount do
				local child = transform:GetChild(i - 1)

				self._qualityEffectList[child.name] = child
			end
		end

		local targetName = "effect_0" .. seatLevel

		for k, v in pairs(self._qualityEffectList) do
			gohelper.setActive(v, k == targetName)
		end
	end

	self.filterMo = EquipFilterModel.instance:generateFilterMo(self.viewName)
	self.heroMo = self.viewParam.heroMo
	self.posIndex = self.viewParam.posIndex

	self:initOriginEquipMo()

	self.listModel = self.viewContainer:getListModel()

	self.listModel:onOpen(self.viewParam, self.filterMo)

	self.selectedEquipMo = self.listModel:getCurrentSelectEquipMo()

	self._simagebg:LoadImage(ResUrl.getEquipBg("bg_beijingjianbian.png"))
	self._simagecompare:LoadImage(ResUrl.getEquipBg("full/bg_black_mask.png"))
	self:refreshCompareContainerUI()
	self:refreshUI()

	self.txtConfirm.text = luaLang("confirm_text")
end

function V1a6_CachotEquipInfoTeamShowView:initOriginEquipMo()
	self.originEquipMo = nil

	if self.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView then
		self.originEquipMo = self.viewParam.equipMo
	elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		self.originEquipMo = EquipModel.instance:getEquip(self.viewParam.heroMo.defaultEquipUid)
	elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromSeasonFightView then
		self.originEquipMo = self.viewParam.equipMo
	elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupView then
		self.originEquipMo = self.viewParam.equipMo
	elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		self.originEquipMo = self.viewParam.equipMo
	else
		logError("not found from view ...")

		self.originEquipMo = self.viewParam.equipMo
	end
end

function V1a6_CachotEquipInfoTeamShowView:refreshCompareContainerUI()
	local equipMo = self.originEquipMo

	if not equipMo then
		gohelper.setActive(self._gocontainer1, false)
		gohelper.setActive(self._simagecompare.gameObject, false)

		return
	end

	local isBalance = tonumber(equipMo.uid) > 0 and self.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView and HeroGroupBalanceHelper.getIsBalanceMode()

	if isBalance then
		local _, _, equipLv = HeroGroupBalanceHelper.getBalanceLv()

		if equipLv > equipMo.level then
			local newEquipMo = EquipMO.New()

			newEquipMo:initByConfig(nil, equipMo.equipId, equipLv, equipMo.refineLv)

			equipMo = newEquipMo
		else
			isBalance = nil
		end
	end

	self.container1_txtname = self.container1_txtname or gohelper.findChildText(self._gocontainer1, "#go_equipinfo/#txt_name")
	self.container1_txtname.text = equipMo.config.name
	self.container1_txtlevel = self.container1_txtlevel or gohelper.findChildText(self._gocontainer1, "#go_equipinfo/#go_attr/#txt_level")
	self.container1_gobalance = self.container1_gobalance or gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_isBalance")

	gohelper.setActive(self.container1_gobalance, isBalance)

	self.container1_goattr = self.container1_goattr or gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_attr").transform

	local x, y = transformhelper.getLocalPos(self.container1_goattr)

	transformhelper.setLocalPosXY(self.container1_goattr, x, isBalance and -28 or 17.3)

	local equipLevel = equipMo.level
	local currentBreakLvMaxLevel = EquipConfig.instance:getCurrentBreakLevelMaxLevel(equipMo)

	self.container1_txtlevel.text = isBalance and string.format("LV.<color=#8fb1cc>%d</color>/<color=#8fb1cc>%d</color>", equipLevel, currentBreakLvMaxLevel) or string.format("LV.<color=#d9a06f>%d</color>/<color=#777676>%d</color>", equipLevel, currentBreakLvMaxLevel)

	if not self.container1_goStarList then
		self.container1_goStarList = self:getUserDataTb_()

		for i = 1, 6 do
			table.insert(self.container1_goStarList, gohelper.findChild(self._gocontainer1, "#go_equipinfo/go_insigt/#image_" .. i))
		end
	end

	local equipRare = equipMo.config.rare

	for i = 1, 6 do
		gohelper.setActive(self.container1_goStarList[i], i <= equipRare + 1)
	end

	self.container1_gostrengthenattr = self.container1_gostrengthenattr or gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_attr/layout/attribute/container/#go_strengthenattr")

	gohelper.setActive(self.container1_gostrengthenattr, false)

	local _, attrList = EquipConfig.instance:getEquipNormalAttr(equipMo.config.id, equipMo.level, HeroConfig.sortAttrForEquipView)
	local attrConfig, item

	for index, attr in ipairs(attrList) do
		item = self.container1_strengthenAttrItems[index]

		if not self.container1_strengthenAttrItems[index] then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self.container1_gostrengthenattr, "item" .. index)
			item.icon = gohelper.findChildImage(item.go, "image_icon")
			item.name = gohelper.findChildText(item.go, "txt_name")
			item.attr_value = gohelper.findChildText(item.go, "txt_value")
			item.bg = gohelper.findChild(item.go, "bg")

			table.insert(self.container1_strengthenAttrItems, item)
		end

		attrConfig = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(attr.attrType))

		UISpriteSetMgr.instance:setCommonSprite(item.icon, "icon_att_" .. attrConfig.id)

		item.name.text = attrConfig.name
		item.attr_value.text = attr.value

		gohelper.setActive(item.bg, index % 2 == 0)
		gohelper.setActive(item.go, true)
	end

	for i = #attrList + 1, #self.container1_strengthenAttrItems do
		gohelper.setActive(self.container1_strengthenAttrItems[i].go, false)
	end

	if not self.container1_gobreakeffect then
		self.container1_gobreakeffect = gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_attr/layout/attribute/container/#go_breakeffect")
		self.container1_imageBreakIcon = gohelper.findChildImage(self.container1_gobreakeffect, "image_icon")
		self.container1_txtBreakAttrName = gohelper.findChildText(self.container1_gobreakeffect, "txt_name")
		self.container1_txtBreakValue = gohelper.findChildText(self.container1_gobreakeffect, "txt_value")
	end

	local attrId, value = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(equipMo.config, equipMo.breakLv)

	if attrId then
		gohelper.setActive(self.container1_gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(self.container1_imageBreakIcon, "icon_att_" .. attrId)

		self.container1_txtBreakAttrName.text = EquipHelper.getAttrBreakText(attrId)
		self.container1_txtBreakValue.text = EquipHelper.getAttrPercentValueStr(value)

		gohelper.setAsLastSibling(self.container1_gobreakeffect)
	else
		gohelper.setActive(self.container1_gobreakeffect, false)
	end

	self.container1_gosuitattribute = self.container1_gosuitattribute or gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute")

	if equipMo.config.rare <= EquipConfig.instance:getNotShowRefineRare() then
		gohelper.setActive(self.container1_gosuitattribute, false)

		return
	end

	gohelper.setActive(self.container1_gosuitattribute, true)

	self.container1_txtattributelv = self.container1_txtattributelv or gohelper.findChildText(self._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/attributename/#txt_attributelv")
	self.container1_goadvanceskill = self.container1_goadvanceskill or gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill")

	if not self.container1_gobaseskill then
		self.container1_gobaseskill = gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
		self.container1_goBaseSkillCanvasGroup = self.container1_gobaseskill:GetComponent(typeof(UnityEngine.CanvasGroup))
	end

	self.container1_txtsuiteffect2 = self.container1_txtsuiteffect2 or gohelper.findChildText(self._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")

	gohelper.setActive(self.container1_txtsuiteffect2.gameObject, false)

	local skillDesList = EquipHelper.getEquipSkillBaseDes(equipMo.config.id, equipMo.refineLv, "#D9A06F")

	if #skillDesList == 0 then
		gohelper.setActive(self.container1_gobaseskill, false)
	else
		self.container1_txtattributelv.text = equipMo.refineLv

		gohelper.setActive(self.container1_gobaseskill, true)

		local item

		for index, desc in ipairs(skillDesList) do
			item = self.container1_skillDescItems[index]

			if not self.container1_skillDescItems[index] then
				item = self:getUserDataTb_()
				item.itemGo = gohelper.cloneInPlace(self.container1_txtsuiteffect2.gameObject, "item_" .. index)
				item.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(item.itemGo, FixTmpBreakLine)
				item.imagepoint = gohelper.findChildImage(item.itemGo, "#image_point")
				item.txt = item.itemGo:GetComponent(gohelper.Type_TextMesh)

				table.insert(self.container1_skillDescItems, item)
			end

			item.txt.text = desc

			item.fixTmpBreakLine:refreshTmpContent(item.txt)
			gohelper.setActive(item.itemGo, true)
		end

		self.container1_goBaseSkillCanvasGroup.alpha = equipMo and self.heroMo and EquipHelper.detectEquipSkillSuited(self.heroMo.heroId, equipMo.config.id, equipMo.refineLv) and 1 or 0.4

		for i = #skillDesList + 1, #self.container1_skillDescItems do
			gohelper.setActive(self.container1_skillDescItems[i].itemGo, false)
		end
	end
end

function V1a6_CachotEquipInfoTeamShowView:refreshUI()
	self:refreshBtnStatus()
	self:refreshHeroInfo()
	self:refreshLeftUI()
	self:refreshCenterUI()
	self:refreshRightUI()
end

function V1a6_CachotEquipInfoTeamShowView:refreshBtnStatus()
	gohelper.setActive(self.goRareBtnNoSelect, not self.listModel:isSortByRare())
	gohelper.setActive(self.goRareBtnSelect, self.listModel:isSortByRare())
	gohelper.setActive(self.goLvBtnNoSelect, not self.listModel:isSortByLevel())
	gohelper.setActive(self.goLvBtnSelect, self.listModel:isSortByLevel())

	local levelState, rareState = self.listModel:getSortState()

	transformhelper.setLocalScale(self.goRareBtnSelectArrow.transform, 1, rareState, 1)
	transformhelper.setLocalScale(self.goLvBtnSelectArrow.transform, 1, levelState, 1)
	self:refreshFilterBtnStatus()
end

function V1a6_CachotEquipInfoTeamShowView:refreshFilterBtnStatus()
	local isFiltering = self.filterMo:isFiltering()

	gohelper.setActive(self.goNotFilter, not isFiltering)
	gohelper.setActive(self.goFilter, isFiltering)
end

function V1a6_CachotEquipInfoTeamShowView:refreshHeroInfo()
	gohelper.setActive(self._goherocontainer, self.heroMo)
	gohelper.setActive(self._goheroempty, not self.heroMo)

	if not self.heroMo then
		return
	end

	self._simageheroicon:LoadImage(ResUrl.getHandbookheroIcon(self.heroMo.config.skinId))

	self._txtheroname.text = self.heroMo.config.name

	UISpriteSetMgr.instance:setHandBookCareerSprite(self._imageherocareer, "sx_icon_" .. tostring(self.heroMo.config.career))
end

function V1a6_CachotEquipInfoTeamShowView:refreshLeftUI()
	local isTrialDefaultEquip = not not (self.heroMo and self.heroMo.trialEquipMo)
	local var_29_0 = self.selectedEquipMo and (not isTrialDefaultEquip and tonumber(self.selectedEquipMo.uid) > 0 and self.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView and HeroGroupBalanceHelper.getIsBalanceMode() or false)
	local showBalance = true

	goto label_29_0

	::label_29_0::

	self._balanceEquipMo = nil

	if showBalance then
		local _, _, equipLv = HeroGroupBalanceHelper.getBalanceLv()

		if equipLv <= self.selectedEquipMo.level then
			showBalance = nil
		else
			local newEquipMo = EquipMO.New()

			newEquipMo:initByConfig(nil, self.selectedEquipMo.equipId, equipLv, self.selectedEquipMo.refineLv)

			self._balanceEquipMo = newEquipMo
		end
	end

	gohelper.setActive(self._gotrialtip, isTrialDefaultEquip)
	gohelper.setActive(self._goequipinfo, self.selectedEquipMo)
	gohelper.setActive(self._goequipinfoempty, not self.selectedEquipMo)
	gohelper.setActive(self._gobalance, showBalance)

	local x, y = transformhelper.getLocalPos(self._goAttr.transform)

	transformhelper.setLocalPosXY(self._goAttr.transform, x, showBalance and -172.2 or -127)

	self.layoutElement.minHeight = showBalance and 149.5 or 192.19

	if self.selectedEquipMo then
		self._txtname.text = self.selectedEquipMo.config.name

		self:refreshEquipStar()
		self:refreshSelectStatus()
		self:refreshEquipLevel()
		self:refreshEquipNormalAttr()

		if self.selectedEquipMo.config.rare > EquipConfig.instance:getNotShowRefineRare() then
			self:refreshEquipSkillDesc()
			gohelper.setActive(self._gosuitattribute, true)
		else
			gohelper.setActive(self._gosuitattribute, false)
		end

		self:refreshInTeam()
	end

	gohelper.setActive(self._btnjump.gameObject, false)
	gohelper.setActive(self._gobuttom, not isTrialDefaultEquip)
end

function V1a6_CachotEquipInfoTeamShowView:refreshCenterUI()
	if self.selectedEquipMo then
		self._simageequip:LoadImage(ResUrl.getEquipSuit(self.selectedEquipMo.config.icon))
		gohelper.setActive(self._gocenter, true)
	else
		gohelper.setActive(self._gocenter, false)
	end
end

function V1a6_CachotEquipInfoTeamShowView:refreshRightUI()
	local isEmpty = self.listModel:isEmpty()

	gohelper.setActive(self._scrollequip.gameObject, not isEmpty)
	gohelper.setActive(self._goequipempty, isEmpty)

	if not isEmpty then
		self.listModel:refreshEquipList()
	end
end

function V1a6_CachotEquipInfoTeamShowView:refreshEquipStar()
	local equipRare = self.selectedEquipMo.config.rare

	for i = 1, 6 do
		gohelper.setActive(self["_image" .. i].gameObject, i <= equipRare + 1)
	end
end

function V1a6_CachotEquipInfoTeamShowView:refreshSelectStatus()
	if not self.originEquipMo then
		gohelper.setActive(self._btncompare.gameObject, false)
		gohelper.setActive(self._btninteam.gameObject, false)
		gohelper.setActive(self._btnfold.gameObject, false)

		return
	end

	if self.comparing then
		gohelper.setActive(self._btncompare.gameObject, false)
		gohelper.setActive(self._btninteam.gameObject, false)
		gohelper.setActive(self._btnfold.gameObject, true)

		return
	end

	if self.originEquipMo.uid == self.selectedEquipMo.uid then
		gohelper.setActive(self._btncompare.gameObject, false)
		gohelper.setActive(self._btninteam.gameObject, true)
		gohelper.setActive(self._btnfold.gameObject, false)

		return
	end

	gohelper.setActive(self._btncompare.gameObject, true)
	gohelper.setActive(self._btninteam.gameObject, false)
	gohelper.setActive(self._btnfold.gameObject, false)
	gohelper.setActive(self._btncompare.gameObject, false)
end

function V1a6_CachotEquipInfoTeamShowView:refreshEquipLevel()
	if self._balanceEquipMo then
		local equipLevel = self._balanceEquipMo.level
		local currentBreakLvMaxLevel = EquipConfig.instance:getCurrentBreakLevelMaxLevel(self._balanceEquipMo)

		self._txtlevel.text = string.format("LV.<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">%d</color>/<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">%d</color>", equipLevel, currentBreakLvMaxLevel)
	else
		local equipLevel, breakLv = V1a6_CachotTeamModel.instance:getEquipMaxLevel(self.selectedEquipMo, self._seatLevel)
		local currentBreakLvMaxLevel = EquipConfig.instance:_getBreakLevelMaxLevel(self.selectedEquipMo.config.rare, breakLv)

		self._txtlevel.text = string.format("LV.<color=#d9a06f>%d</color>/<color=#777676>%d</color>", equipLevel, currentBreakLvMaxLevel)
	end
end

function V1a6_CachotEquipInfoTeamShowView:refreshEquipNormalAttr()
	if not self._balanceEquipMo then
		local equipMo = self.selectedEquipMo
		local equipLevel = V1a6_CachotTeamModel.instance:getEquipMaxLevel(equipMo, self._seatLevel)
		local _, attrList = EquipConfig.instance:getEquipNormalAttr(equipMo.config.id, equipLevel, HeroConfig.sortAttrForEquipView)
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
				item.bg = gohelper.findChild(item.go, "bg")

				table.insert(self.strengthenAttrItems, item)
			end

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

		local breakLv = equipMo:getBreakLvByLevel(equipLevel)
		local attrId, value = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(equipMo.config, breakLv)

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

function V1a6_CachotEquipInfoTeamShowView:refreshEquipSkillDesc()
	local skillDesList = EquipHelper.getEquipSkillBaseDes(self.selectedEquipMo.config.id, self.selectedEquipMo.refineLv, "#D9A06F")

	if #skillDesList == 0 then
		gohelper.setActive(self._gobaseskill.gameObject, false)
	else
		self._txtattributelv.text = self.selectedEquipMo.refineLv

		gohelper.setActive(self._gobaseskill.gameObject, true)

		local cell, itemGo, iteminfo

		for index, desc in ipairs(skillDesList) do
			cell = self.skillDescItems[index]

			if not self.skillDescItems[index] then
				iteminfo = self:getUserDataTb_()
				itemGo = gohelper.cloneInPlace(self._txtsuiteffect2.gameObject, "item_" .. index)
				iteminfo.itemGo = itemGo
				iteminfo.imagepoint = gohelper.findChildImage(itemGo, "#image_point")
				iteminfo.txt = itemGo:GetComponent(gohelper.Type_TextMesh)
				cell = iteminfo

				table.insert(self.skillDescItems, iteminfo)
			end

			cell.txt.text = desc

			gohelper.setActive(cell.itemGo, true)
		end

		for i = #skillDesList + 1, #self.skillDescItems do
			gohelper.setActive(self.skillDescItems[i].itemGo, false)
		end

		EquipController.instance:dispatchEvent(EquipEvent.equipHasRefine)
	end
end

function V1a6_CachotEquipInfoTeamShowView:refreshInTeam()
	if self.viewParam.fromView ~= EquipEnum.FromViewEnum.FromHeroGroupFightView and self.viewParam.fromView ~= EquipEnum.FromViewEnum.FromSeasonFightView and self.viewParam.fromView ~= EquipEnum.FromViewEnum.FromCachotHeroGroupView and self.viewParam.fromView ~= EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		gohelper.setActive(self._gointeam, false)

		return
	end

	local heroMo = self.viewContainer.listModel:getHeroMoByEquipUid(self.selectedEquipMo.uid)

	if self.heroMo and heroMo and self.selectedEquipMo.equipType == EquipEnum.ClientEquipType.TrialHero then
		heroMo = self.heroMo
	end

	if heroMo then
		gohelper.setActive(self._gointeam, true)

		local skinCo = lua_skin.configDict[heroMo.skin]

		self._gointeamheroicon:LoadImage(ResUrl.getHeadIconSmall(skinCo.headIcon))

		self._gointeamheroname.text = string.format(luaLang("hero_inteam"), heroMo.config.name)
	else
		gohelper.setActive(self._gointeam, false)
	end
end

function V1a6_CachotEquipInfoTeamShowView:onSelectEquipChange()
	self.selectedEquipMo = self.listModel:getCurrentSelectEquipMo()

	self:refreshLeftUI()
	self:refreshCenterUI()
end

function V1a6_CachotEquipInfoTeamShowView:onEquipChange()
	self.listModel:initEquipList(self.filterMo)
	self:refreshLeftUI()
	self:refreshRightUI()
	self:refreshCompareContainerUI()
end

function V1a6_CachotEquipInfoTeamShowView:onDeleteEquip(equipUidList)
	for _, equipUid in ipairs(equipUidList) do
		if self.selectedEquipMo.uid == equipUid then
			self.listModel:setCurrentSelectEquipMo(nil)
			self:onSelectEquipChange()

			break
		end
	end
end

function V1a6_CachotEquipInfoTeamShowView:onSuccessSetDefaultEquip(defaultEquipUid)
	self:closeThis()
end

function V1a6_CachotEquipInfoTeamShowView:onClose()
	self._simageheroicon:UnLoadImage()
	self._simageequip:UnLoadImage()
	self._simagebg:UnLoadImage()
	self._simagecompare:UnLoadImage()
	self.listModel:clear()
	EquipFilterModel.instance:clear(self.viewName)
end

function V1a6_CachotEquipInfoTeamShowView:onDestroyView()
	return
end

return V1a6_CachotEquipInfoTeamShowView
