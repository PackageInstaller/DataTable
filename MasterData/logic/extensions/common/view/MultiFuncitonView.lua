-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/MultiFuncitonView.lua

module("logic.extensions.common.view.MultiFuncitonView", package.seeall)

local M = class("MultiFuncitonView", ViewComponent)

function M:buildUI()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Authority)

	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "common_full_tips_bg/clickExit"))

	goutil.setActive(self._btnClick.gameObject, false)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "allContent/txtTitle")
	self._txtInfo = goutil.findChildTextComponent(self.mainGO, "allContent/txtInfo")
	self._txtContent = goutil.findChildComponent(self.mainGO, "allContent/txtContent", UIComponentType.TextMeshProUGUI)
	self._authorityGo = goutil.findChild(self.mainGO, "allContent/item/authority_node")
	self._skillGo = goutil.findChild(self.mainGO, "allContent/item/skill_item_1")
	self._itemGo = goutil.findChild(self.mainGO, "allContent/item/backpack_item")
	self._breakGo = goutil.findChild(self.mainGO, "allContent/item/break_point")
	self._skillIcon = goutil.findChildImageComponent(self.mainGO, "allContent/item/skill_item_1/imgIcon")
	self._btnSkill = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "allContent/item/skill_item_1/click"))
	self._showCommIcon = goutil.findChildImageComponent(self._authorityGo, "showPoint/imgIcon")
	self._imgSkillSign = goutil.findChild(self._skillGo, "common")
	self._showCommText = goutil.findChildTextComponent(self._authorityGo, "showPoint/txtNum")
	self._upContentGo = goutil.findChild(self.mainGO, "allContent/upContent")
	self._upContentGo2 = goutil.findChild(self.mainGO, "allContent/upContent2")
	self._textSkillDesc1 = goutil.findChildComponent(self.mainGO, "allContent/upContent2/txtDec1", UIComponentType.TextMeshProUGUI)
	self._textSkillDesc2 = goutil.findChildComponent(self.mainGO, "allContent/upContent2/txtDec2", UIComponentType.TextMeshProUGUI)
	self._qualityGo = goutil.findChild(self._itemGo, "imgQuality")
	self._headScaleGo = goutil.findChild(self._itemGo, "headScale")
	self._imgEquipIcon = goutil.findChildImageComponent(self._itemGo, "imgIcon")
	self._txtYiNeng = goutil.findChild(self.mainGO, "allContent/yineng")

	goutil.setActive(self._txtYiNeng, false)

	self._goAllContentTipsText = goutil.findChild(self.mainGO, "allContent/Text1")
	self._groupAllContent = goutil.findChildComponent(self.mainGO, "allContent", ComponentType.CanvasGroup)
	self._groupCardPanel = goutil.findChildComponent(self.mainGO, "cardPanel", ComponentType.CanvasGroup)
	self._groupCardTipsText = goutil.findChildComponent(self.mainGO, "cardPanel/Text2", ComponentType.CanvasGroup)
	self._goEchoCard = goutil.findChild(self.mainGO, "cardPanel/echo_show_card")
end

function M:destroyUI()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Authority)

	self._skillIcon = nil
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onBtnClose, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	self._mo = self:getFirstParam()

	self:_setContent()
end

function M:onExit()
	IconLoader.clearSprite(self._skillIcon)
	IconLoader.clearSprite(self._imgEquipIcon)
	self._btnSkill:RemoveClickListener()

	if self._tweener then
		self._tweener:Kill(false)
	end

	removetimer(self._showEchoCardView, self)

	if self._tweener2 then
		self._tweener2:Kill(false)
	end

	if self._unlockEchoDynamicEffect then
		GlobalDispatcher:dispatchEvent(EventType.MULTI_FUNCITON_VIEW_CLOSE)
	end
end

function M:onExitFinished()
	GlobalDispatcher:dispatchEvent(EventType.CHECK_MONUMENTS_POP_EVENT)
	GlobalDispatcher:dispatchEvent(EventType.HERO_POWER_UPGRADE_TIPS_CLOSE)
end

function M:_setContent()
	self._unlockEchoDynamicEffect = false

	local authoritySkillEnhance = self._mo.type == CommEnum.MultiFunctionDataType.AuthoritySkillEnhance

	goutil.setActive(self._authorityGo, self._mo.type == CommEnum.MultiFunctionDataType.AuthorityUp)
	goutil.setActive(self._skillGo, authoritySkillEnhance)
	goutil.setActive(self._txtContent.gameObject, false)
	goutil.setActive(self._txtInfo.gameObject, authoritySkillEnhance)
	goutil.setActive(self._itemGo, self._mo.type == CommEnum.MultiFunctionDataType.EquipStrengthen)
	goutil.setActive(self._breakGo, self._mo.type == CommEnum.MultiFunctionDataType.EchoBreak)
	goutil.setActive(self._upContentGo, self._mo.type == CommEnum.MultiFunctionDataType.AuthorityUp or self._mo.type == CommEnum.MultiFunctionDataType.EchoBreak or self._mo.type == CommEnum.MultiFunctionDataType.EquipStrengthen)
	goutil.setActive(self._upContentGo2, authoritySkillEnhance)
	goutil.setActive(self._goAllContentTipsText, self._mo.type ~= CommEnum.MultiFunctionDataType.EchoBreak)

	self._groupAllContent.alpha = 1
	self._groupCardPanel.alpha = 0
	self._isBlockClick = false

	if authoritySkillEnhance then
		self:_setAuthoritySKill()
	end

	if self._mo.type == CommEnum.MultiFunctionDataType.AuthorityUp then
		self:_setAuthorityCommUp()
	end

	if self._mo.type == CommEnum.MultiFunctionDataType.EquipStrengthen then
		self:_setJSQStrengthen()
	end

	if self._mo.type == CommEnum.MultiFunctionDataType.EchoBreak then
		self:_setEachBreak()
	end
end

function M:_setAuthoritySKill()
	local heroId = self._mo.data.heroId
	local nodeId = self._mo.data.id
	local powerNodeMo = CharacterAuthorityModel.instance:getHeroPowerNodeMO(heroId, nodeId)
	local skillId = powerNodeMo:getSkillId()
	local enhanceSkillId = powerNodeMo:getSkillEnhancedCode()
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)
	local skillCO = skillCOWrapper:getSkillCO()

	self._txtTitle.text = lang("tip_multi_upgrade_title_skill_enhance")
	self._txtInfo.text = skillCOWrapper:getName()
	self._textSkillDesc1.text = skillCOWrapper:getDescription()

	local afterSKillMO = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(heroId, skillId)

	afterSKillMO:rebuild()

	self._textSkillDesc2.text = afterSKillMO:getDescription()

	goutil.setActive(self._imgSkillSign, true)
	IconLoader.setSprite(self._skillIcon, IconType.SkillIcon, ActiveSkillCOUtil.getSkillIcon(skillCO))
	self._btnSkill:AddClickListener(function()
		self:_onSkillClick(heroId, enhanceSkillId, self._skillGo)
	end, self)
	SkillEnhanceMO.releaseSharedMO(afterSKillMO)
end

function M:_setAuthorityCommUp()
	self._txtTitle.text = lang("tip_multi_upgrade_title_authority")

	local heroData = HeroDepotModel.instance:getHeroInfoByID(self._mo.data.heroId)
	local mo = CharacterAuthorityModel.instance:getHeroPowerNodeMO(self._mo.data.heroId, self._mo.data.id)
	local attrs = MultiFunctionUtil.getHeroAttrs(heroData)
	local detailTextLst = mo:getNodeDetailTextLst()
	local powerLvUpNum = self._mo.data.powerLvUpNum

	goutil.setActive(self._txtYiNeng, false)
	goutil.setActive(self._showCommIcon.gameObject, true)
	goutil.setActive(self._showCommText.gameObject, false)

	if powerLvUpNum and powerLvUpNum > 0 then
		goutil.setActive(self._showCommIcon.gameObject, false)
		goutil.setActive(self._showCommText.gameObject, true)

		self._showCommText.text = powerLvUpNum
	else
		IconLoader.setSprite(self._showCommIcon, IconType.DynSpriteAtlas_CharacterSystem_Authority, "qhd_icon_ren")
	end

	while self._upContentGo.transform.childCount < #detailTextLst do
		goutil.cloneAndSetParent(self._upContentGo.transform:GetChild(0).gameObject, self._upContentGo.transform)
	end

	for i = 0, self._upContentGo.transform.childCount - 1 do
		local go = self._upContentGo.transform:GetChild(i).gameObject
		local show = i < #detailTextLst

		if show then
			local txtName = goutil.findChildTextComponent(go, "txtHint")
			local txtBefore = goutil.findChildTextComponent(go, "txtNum1")
			local txtAfter = goutil.findChildTextComponent(go, "txtNum2")
			local img1Go = goutil.findChild(go, "Image1")

			txtName.text = detailTextLst[i + 1].name

			local attrValue = detailTextLst[i + 1].val
			local isContain = string.find(attrValue, "Lv") or string.find(attrValue, "%%")

			goutil.setActive(img1Go, isContain == nil)
			goutil.setActive(txtBefore.gameObject, isContain == nil)

			if isContain then
				txtAfter.text = attrValue
			else
				for ii, vv in ipairs(attrs) do
					local co = AttributeDefineConfig.instance:getAttributePartDefineCO(vv.code)
					local attrName = co and co.name or ""

					if attrName == detailTextLst[i + 1].name then
						attrValue = vv.value
					end
				end

				printWarn("=====_setAuthorityCommUp=====", attrValue, detailTextLst[i + 1].val)

				txtBefore.text = attrValue - detailTextLst[i + 1].val
				txtAfter.text = attrValue
			end
		end

		goutil.setActive(go, show)
	end
end

function M:_setEachBreak()
	self._groupAllContent.alpha = 1
	self._groupCardPanel.alpha = 0

	local echoItemData = self._mo.data.echoItemData

	self._txtTitle.text = langF("tip_multi_upgrade_title_echo", CommEnum.Num2RomeNum[echoItemData:getLevel() - 1])
	self._breakPointView = Astral.LuaComponentContainer.Add(self._breakGo, EchoItemBreakPointView)

	self._breakPointView:setEchoItemLevel(echoItemData:getLevel(), echoItemData:getMaxLevel())
	self._breakPointView:playUpgradeAnim(echoItemData:getLevel())

	if echoItemData:getIsMaxLevel() then
		goutil.setActive(self._txtContent.gameObject, true)
		goutil.setActive(self._upContentGo, false)

		local career = echoItemData:getCareer()
		local skillEnhanceMO = echoItemData:getSkillEnhanceMO()
		local descStr = skillEnhanceMO and skillEnhanceMO:getDescription() or ""
		local campIcon = CommEnum.Career2TmpResName[career] or ""
		local descOver = string.format("%s: %s %s\n%s", lang("t_echo_career_limit"), campIcon, CommEnum.Career2Name[career], descStr)

		self._txtContent.text = descOver

		return
	end

	local showAttrs = self._mo.data.showAttrs
	local changeAttrs = self._mo.data.changeAttrs
	local preAttrs = EchoItemConfig.instance:getAttrLst(echoItemData:getId(), echoItemData:getLevel() - 1)

	while self._upContentGo.transform.childCount < #showAttrs do
		goutil.cloneAndSetParent(self._upContentGo.transform:GetChild(0).gameObject, self._upContentGo.transform)
	end

	for i = 0, self._upContentGo.transform.childCount - 1 do
		local go = self._upContentGo.transform:GetChild(i).gameObject
		local show = i < #changeAttrs
		local data = changeAttrs[i + 1]
		local dataPre = preAttrs and preAttrs[i + 1] or {
			num = 0
		}

		if show then
			local txtName = goutil.findChildTextComponent(go, "txtHint")
			local txtBefore = goutil.findChildTextComponent(go, "txtNum1")
			local txtAfter = goutil.findChildTextComponent(go, "txtNum2")
			local cfg = AttributeDefineConfig.instance:getAttributePartDefineCO(data.id)

			txtName.text = cfg and cfg.name or ""
			txtBefore.text = dataPre.num
			txtAfter.text = data.num

			if dataPre.num < 1 and dataPre.num > 0 then
				txtBefore.text = string.format("%s%%", dataPre.num * 100)
				txtAfter.text = string.format("%s%%", data.num * 100)
			end
		end

		goutil.setActive(go, show)
	end

	local unlockLevel = EchoItemConfig.instance:getUnlockDynamicEffectLevel(echoItemData:getQuality())

	if echoItemData:getLevel() == unlockLevel then
		self._unlockEchoDynamicEffect = true

		goutil.setActive(self._goEchoCard, true)

		if not self._showCardView then
			self._showCardView = Astral.LuaComponentContainer.Add(self._goEchoCard, EchoItemShowCardView)
		end

		self._showCardView:setAddBtnVisible(false)
		self._showCardView:setImgForShowVisible(false)
		self._showCardView:onEnter()
		self._showCardView:showGyros()
		self._showCardView:maskTransition(false)
		self._showCardView:setIsEnableDrag(true)
		self._showCardView:setIsSimulateAllTime(true)
		self._showCardView:refreshView(echoItemData:getItemId())
		settimer(2.2, self._showEchoCardView, self, false)

		self._groupCardTipsText.alpha = 0
		self._isBlockClick = true
	else
		self._groupCardTipsText.alpha = 1
		self._groupCardPanel.alpha = 1

		goutil.setActive(self._goEchoCard, false)
	end
end

function M:_showEchoCardView()
	if self._tweener then
		self._tweener:Kill(false)
	end

	self._tweener = DoTweenUtil.ToWithEase(0, 1, 1, DG.Tweening.Ease.OutQuad, function(value)
		self._groupAllContent.alpha = 1 - value
		self._groupCardPanel.alpha = value
	end)

	self._tweener:OnComplete(function()
		self:_showEchoCard()
	end)
	self._tweener:SetTarget(self._goAnimation)
end

function M:_showEchoCard()
	if self._tweener2 then
		self._tweener2:Kill(false)
	end

	self._tweener2 = DoTweenUtil.ToWithEase(-1, 2, 4, DG.Tweening.Ease.InOutSine, function(value)
		if value > 1 then
			value = 2 - value
		end

		GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_SIMULATE, MainPerformEnum.GyrosEventTyp.Echo, true, value, 0, 0)
	end):SetDelay(0.5)

	self._tweener2:OnComplete(function()
		self._groupCardTipsText.alpha = 1
		self._isBlockClick = false
	end)
	self._tweener2:SetTarget(self._groupCardTipsText.gameObject)
end

function M:_setJSQStrengthen()
	self._txtTitle.text = lang("tip_multi_upgrade_title_equip")

	goutil.setActive(self._qualityGo, false)
	goutil.setActive(self._headScaleGo, false)

	local oldEquip = EquipIntensifyModel.instance:getEquipBeforeUpdate()
	local newEquip = EquipIntensifyModel.instance:getOperatingEquip()

	IconLoader.setSprite(self._imgEquipIcon, IconType.EquipIcon, newEquip:getIcon())

	local showAttrsOld = oldEquip:getAttrList()
	local showAttrsNew = newEquip:getAttrList()

	while self._upContentGo.transform.childCount < #showAttrsNew do
		goutil.cloneAndSetParent(self._upContentGo.transform:GetChild(0).gameObject, self._upContentGo.transform)
	end

	for i = 0, self._upContentGo.transform.childCount - 1 do
		local go = self._upContentGo.transform:GetChild(i).gameObject
		local show = i < #showAttrsNew
		local data = showAttrsNew[i + 1]
		local dataPre = showAttrsOld[i + 1]

		if show then
			local txtName = goutil.findChildTextComponent(go, "txtHint")
			local txtBefore = goutil.findChildTextComponent(go, "txtNum1")
			local txtAfter = goutil.findChildTextComponent(go, "txtNum2")

			txtName.text = data:getName()
			txtBefore.text = dataPre and dataPre:getValue() or 0
			txtAfter.text = data:getValue()
		end

		goutil.setActive(go, show)
	end
end

function M:_onSkillClick(heroId, skillId, cellGo)
	do return end

	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = heroId
	skillInfo.skillId = skillId
	skillInfo.defaultShowAll = false
	skillInfo.hangGO = cellGo
	skillInfo.awakeStatus = TacitModel.instance:isAwakeTalentSkill(heroId, true)

	ToolTipsMgr.showManualSkillTips(skillInfo)
end

function M:onClickOutside(isOpenAniFinish)
	if isOpenAniFinish and not self._isBlockClick then
		self:close()
	end
end

function M:_onBtnClose()
	if self._isBlockClick then
		return
	end

	self._groupCardPanel.alpha = 0

	self:close()
end

return M
