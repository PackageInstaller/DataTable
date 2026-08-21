-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/operator/BattleHeroInfoDetailCompBase.lua

module("logic.extensions.battle.viewmain.operator.BattleHeroInfoDetailCompBase", package.seeall)

local M = class("BattleHeroInfoDetailCompBase")
local kColorRed = "#d3564e"
local kColorGreen = "#00FF00"
local kColorBlue = "#628daf"
local kColorWhite = "#FFFFFF"
local kColorGrey = "#9F9F9F"
local kCloseAnimDuaration = 0.2
local kMinActiveSkillCount = 3
local kMinCarrySkillCount = 3
local kDefaultKey = "BattleOperatorUnitInfoView"
local SkillEnum = BattleEnum.SkillCategory
local kCarrySkill2Pos = {
	[SkillEnum.ECHO] = 2,
	[SkillEnum.DEPUTY] = 3,
	[SkillEnum.EQUIPMENT] = 1
}
local heroAttDataDefine = {
	[BattleExtension_pb.Attribute.MOVE] = false,
	[BattleExtension_pb.Attribute.ATK_PHY] = 3,
	[BattleExtension_pb.Attribute.DEF_PHY] = 4,
	[BattleExtension_pb.Attribute.ATK_MAG] = 5,
	[BattleExtension_pb.Attribute.DEF_MAG] = 6,
	[BattleExtension_pb.Attribute.INSPIRATION] = 2
}
local monsterAttDataDefine = {
	[BattleExtension_pb.Attribute.MOVE] = false,
	[BattleExtension_pb.Attribute.INSPIRATION] = 1,
	[BattleExtension_pb.Attribute.ATK_PHY] = 2,
	[BattleExtension_pb.Attribute.DEF_PHY] = 3,
	[BattleExtension_pb.Attribute.ATK_MAG] = 4,
	[BattleExtension_pb.Attribute.DEF_MAG] = 5
}

local function sort_skillWrapper(aWrapper, bWrapper)
	if aWrapper:getSkillType() == bWrapper:getSkillType() then
		return aWrapper:getSkillCode() < bWrapper:getSkillCode()
	else
		return aWrapper:getSkillType() < bWrapper:getSkillType()
	end
end

local function sort_skillMO(aMO, bMO)
	if aMO:getCategory() == bMO:getCategory() then
		return aMO:getSkillId() < bMO:getSkillId()
	else
		return aMO:getCategory() < bMO:getCategory()
	end
end

function M:ctor(gameObject)
	self:buildUI(gameObject)
	self:bindEvents()
end

function M:buildUI(gameObject)
	self.mainGO = gameObject
	self._sanity = UIBattleSanity.New(goutil.findChild(self.mainGO, "sanity_copy"))
	self._txtLevelOfType2 = goutil.findChildTextComponent(self.mainGO, "txtLv")
	self._txtNameOfType2 = goutil.findChildTextComponent(self.mainGO, "nameHint/txtName")
	self._careerOfType2 = UIBattleCareer.New(goutil.findChild(self.mainGO, "nameHint/career"))
	self._trailLabel = goutil.findChild(self.mainGO, "nameHint/com_label")
	self._txtLabelOfType2 = goutil.findChildTextComponent(self.mainGO, "nameHint/txtName/label/txtLabel")
	self._txtlabelRoot = goutil.findChild(self.mainGO, "nameHint/txtName/label")
	self._txtMove = goutil.findChildTextComponent(self.mainGO, "infoPanel/txtMoveValue")
	self._txtRange = goutil.findChildTextComponent(self.mainGO, "infoPanel/txtRangeValue")
	self._txtAttack = goutil.findChildTextComponent(self.mainGO, "infoPanel/attack/txtValue")
	self._txtDefence = goutil.findChildTextComponent(self.mainGO, "infoPanel/defence/txtValue")
	self._txtInspiration = goutil.findChildTextComponent(self.mainGO, "infoPanel/critical/txtValue")
	self._txtMagAttack = goutil.findChildTextComponent(self.mainGO, "infoPanel/ethericAttack/txtValue")
	self._txtMagDefence = goutil.findChildTextComponent(self.mainGO, "infoPanel/ethericDefence/txtValue")
	self._txtLevel = {
		goutil.findChildTextComponent(self.mainGO, "infoPanel/attack/txtLv"),
		goutil.findChildTextComponent(self.mainGO, "infoPanel/defence/txtLv"),
		goutil.findChildTextComponent(self.mainGO, "infoPanel/ethericAttack/txtLv"),
		goutil.findChildTextComponent(self.mainGO, "infoPanel/ethericDefence/txtLv"),
		goutil.findChildTextComponent(self.mainGO, "infoPanel/critical/txtLv")
	}
	self._imgS = {
		goutil.findChild(self.mainGO, "infoPanel/attack/imgS"),
		goutil.findChild(self.mainGO, "infoPanel/defence/imgS"),
		goutil.findChild(self.mainGO, "infoPanel/ethericAttack/imgS"),
		goutil.findChild(self.mainGO, "infoPanel/ethericDefence/imgS"),
		goutil.findChild(self.mainGO, "infoPanel/critical/imgS")
	}
	self._goSkillPanelGo = goutil.findChild(self.mainGO, "skillPanel")
	self._guiTimeline = self._goSkillPanelGo:GetComponent(typeof(Astral.GUITimelineAniLua))
	self._goTalentRoot = goutil.findChild(self.mainGO, "skillPanel/objSkill/talentIcon/talent")
	self._goSkillRoot = goutil.findChild(self.mainGO, "skillPanel/objSkill")
	self._goSkillListRoot = goutil.findChild(self.mainGO, "skillPanel/objSkill/scrollView/viewPort/skillList")
	self._goPassiveRoot = goutil.findChild(self.mainGO, "skillPanel/objPassive")
	self._goPassiveEmptyGo = goutil.findChild(self.mainGO, "skillPanel/objPassive/txtNone")
	self._goPassiveScrollGo = goutil.findChild(self.mainGO, "skillPanel/objPassive/scrollView")
	self._goPassiveSkillRoot = goutil.findChild(self.mainGO, "skillPanel/objPassive/scrollView/viewPort/content")
	self._goCarryRoot = goutil.findChild(self.mainGO, "skillPanel/objEquip")
	self._goCarrySkillRoot = goutil.findChild(self.mainGO, "skillPanel/objEquip/equipList")
	self._goNormalScrollGo = goutil.findChild(self._goSkillRoot, "scrollView")
	self._scrollNormalSkill = goutil.findChildComponent(self._goSkillRoot, "scrollView", UIComponentType.ScrollRect)
	self._scrollPassiveSkill = self._goPassiveScrollGo:GetComponent(UIComponentType.ScrollRect)
	self._goBuffRoot2 = goutil.findChild(self.mainGO, "buffList")
	self._buffTipsBtn2 = Astral.ButtonAdapter.Get(self._goBuffRoot2)
	self._goBuffBind = goutil.findChild(self.mainGO, "skillPanel/buffTipsBindGo")
	self._goSkillBind = goutil.findChild(self.mainGO, "skillPanel/skillTipsBindGo")
	self._buffIconList2 = {}
	self._skillIconList = {
		talentSkillIcon = {},
		carrySkillIcon = {}
	}
	self._normalSkillDataList = {}
	self._passiveSkillDataList = {}
	self._normalTalentBgGo = goutil.findChild(self.mainGO, "skillPanel/img1")
	self._tabSkill = goutil.findChildComponent(self.mainGO, "skillPanel/tabList/tab_1", UIComponentType.SpaceXToggle)
	self._tabPassiveSkill = goutil.findChildComponent(self.mainGO, "skillPanel/tabList/tab_2", UIComponentType.SpaceXToggle)
	self._tabCarrySkill = goutil.findChildComponent(self.mainGO, "skillPanel/tabList/tab_3", UIComponentType.SpaceXToggle)
	self._weakPointPanelGo = goutil.findChild(self.mainGO, "weak_fill")
	self._weakPointNormal = goutil.findChild(self._weakPointPanelGo, "normal")
	self._weakPointTxt = goutil.findChildComponent(self._weakPointPanelGo, "normal/txtFill", typeof(TMPro.TMP_Text))
	self._weakPointBroken = goutil.findChild(self._weakPointPanelGo, "tingzhi")
	self._goTalent = goutil.findChild(self.mainGO, "skillPanel/objSkill/talentIcon/talent_skill_item1")

	local goSelectTalent = goutil.findChild(self.mainGO, "skillPanel/objSkill/talentIcon/select")

	self._talentSkill = Astral.LuaComponentContainer.Add(self._goTalent, TalentSkillItem)

	self._talentSkill:setSelectGo(goSelectTalent)
	self._talentSkill:setNativeSize(true)
	self._talentSkill:setScaleChanged(true)

	self._normalSkillLoopGridView = LoopGridViewHelper.New(self._goNormalScrollGo)

	self._normalSkillLoopGridView:InitGridView(0, self._updateNormalSkill, self)

	self._passiveSkillLoopGridView = LoopGridViewHelper.New(self._goPassiveScrollGo)

	self._passiveSkillLoopGridView:InitGridView(0, self._updatePassiveSkill, self)

	self._timeWaiter = TimeWaiter.New()
	self._originScales = {}

	self:setVisible(false)
end

function M:_updateNormalSkill(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._normalSkillLoopGridView:NewListViewItem("skill_item_1")
	local skillIcon = Astral.LuaComponentContainer.Add(item.gameObject, BattleSkillIcon)
	local skillData = self._normalSkillDataList[curIndex]
	local skillId = skillData and skillData.skillId or false
	local heroId = skillData and skillData.heroId or false
	local status = skillData and skillData.status or false
	local enhanceCodes = skillData and skillData.enhanceCodes or false
	local cd = skillData and skillData.cd or false
	local entityId = self._unit and self._unit.property:getEntityId()

	if not skillId or skillId <= 0 then
		skillIcon:setEmpty(BattleEnum.SkillType.NORMAL)
		skillIcon:setSelected(false)
	else
		skillIcon:setSkillInfo(heroId, skillId, status, enhanceCodes, entityId)
		skillIcon:setCd(cd)
		skillIcon:setClickListener(self._onClickSkillIcon, self)
		skillIcon:setSelected(self._selectedSkillId == skillId and self._isSkillTipsOpen)
	end

	return item
end

function M:_updatePassiveSkill(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._passiveSkillLoopGridView:NewListViewItem("skill_item_1")
	local skillIcon = Astral.LuaComponentContainer.Add(item.gameObject, BattleSkillIcon)
	local skillData = self._passiveSkillDataList[curIndex]
	local skillId = skillData and skillData.skillId or false
	local heroId = skillData and skillData.heroId or false
	local status = skillData and skillData.status or false
	local enhanceCodes = skillData and skillData.enhanceCodes or false
	local cd = skillData and skillData.cd or false
	local entityId = self._unit and self._unit.property:getEntityId()

	if not skillId or skillId <= 0 then
		skillIcon:setEmpty(BattleEnum.SkillType.NORMAL)
		skillIcon:setSelected(false)
	else
		skillIcon:setSkillInfo(heroId, skillId, status, enhanceCodes, entityId)
		skillIcon:setCd(cd)
		skillIcon:setClickListener(self._onClickSkillIcon, self)
		skillIcon:setSelected(self._selectedSkillId == skillId and self._isSkillTipsOpen)
	end

	return item
end

function M:destroyUI()
	self:unbindEvents()
	self._normalSkillLoopGridView:Dispose()
	self._passiveSkillLoopGridView:Dispose()
	self._talentSkill:destroy()
	self._sanity:destroy()
	self._careerOfType2:destroy()

	self._txtLevelOfType2 = nil
	self._txtNameOfType2 = nil
	self._careerOfType2 = nil
	self._txtLabelOfType2 = nil
	self._sanity = nil
	self._txtMove = nil
	self._txtRange = nil
	self._txtAttack = nil
	self._txtDefence = nil
	self._txtInspiration = nil
	self._txtMagAttack = nil
	self._txtMagDefence = nil
	self._goTalentRoot = nil
	self._goSkillListRoot = nil
	self._goBuffRoot2 = nil
	self._goBuffBind = nil
	self._skillIconList = nil
	self._clickFunc = nil
	self._clickHandler = nil
end

function M:bindEvents()
	self._tabSkill:AddListener(function(_, isOn, _)
		self:_onSkillTab(BattleEnum.SkillType.NORMAL, isOn)
	end, nil)
	self._tabCarrySkill:AddListener(function(_, isOn, _)
		self:_onSkillTab(BattleEnum.SkillType.CARRY, isOn)
	end, nil)
	self._tabPassiveSkill:AddListener(function(_, isOn, _)
		self:_onSkillTab(BattleEnum.SkillType.PASSIVE, isOn)
	end, nil)
end

function M:unbindEvents()
	self._tabSkill:RemoveListener()
	self._tabCarrySkill:RemoveListener()
	self._tabPassiveSkill:RemoveListener()
end

function M:onEnter()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)
	self._timeWaiter:clear()
	self:clearOperateUnit()

	self._originScales = {}
end

function M:setVisible(visible)
	self._visible = visible

	self:_setActive(self.mainGO, visible)
	self:_setActive(self._bgGo, visible)
end

function M:getVisible()
	return self._visible
end

function M:_setActive(go, visible)
	goutil.setActive(go, visible)
end

function M:setOperateUnit(unit)
	self._unit = unit

	self:_updateViewInfoOfType2()
end

function M:getOperateUnit()
	return self._unit
end

function M:clearOperateUnit()
	self:_clearBuffIconList2()
	self:_clearSkillIconList()

	self._unit = false
end

function M:setSelectedHero(heroId)
	self:_clearBuffIconList2()

	self._selectedHeroId = heroId

	self:setVisible(true)
	self:_updateViewById()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, self._onSkillTipsCloseOrOpen, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, self._onSkillTipsCloseOrOpen, self)
	end
end

function M:_updateViewById()
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(self._selectedHeroId)

	if not heroMO then
		local settingModel = BattleMgr.instance:getSettingModel()
		local trialList = settingModel:getTrialHeroList()

		for _, item in ipairs(trialList) do
			if item:getId() == self._selectedHeroId then
				heroMO = item

				break
			end
		end
	end

	if not heroMO then
		return
	end

	self._unit = false

	self:_updateBaseInfo(heroMO, nil)
	self:_updateInfoPanel(heroMO, nil)
	self:_updateSkillPanel(heroMO, nil)
	self:_updateSanity()
end

function M:_updateSanity()
	if not self._unit then
		self._sanity:setSanity(0, false, true)

		return
	end

	local property = self._unit.property
	local isInStrengthen = BattleUnitUtil.isUnitStrengthening(self._unit)

	self._sanity:setVisible(BattleUnitUtil.isSanityVisibleBySystemOpen(self._unit), BattleConst.SystemOpenKey)
	self._sanity:setSanity(property:getSanity(), isInStrengthen, true)
end

function M:updateViewInfoOnStrengthenChange(sanity, isInStrengthen, isImmediately)
	self._sanity:setSanity(sanity, isInStrengthen, isImmediately)
end

function M:_checkSkillSystemOpen(skillType, isSelfCamp)
	if not isSelfCamp then
		return true
	end

	if skillType == SkillEnum.NORMAL then
		return SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightNormalSkill, false)
	elseif skillType == SkillEnum.SPECIAL then
		return SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightSpecialSkill, false)
	elseif skillType == SkillEnum.TRUMP then
		return SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightTrumpSkill, false)
	end

	return true
end

function M:_updateViewInfoOfType2()
	self:_updateBaseInfo(nil, self._unit)
	self:_updateInfoPanel(nil, self._unit)
	self:_updateSkillPanel(nil, self._unit)
	self:_updateBuffers(self._unit)
	self:_updateSanity()
end

function M:_updateBaseInfo(heroMO, unit)
	local name, level, curHp, maxHp, hpPercent, relationType, isInStrengthen, sanity, career, colorType, modelCO

	if heroMO then
		name = heroMO:getName()
		level = heroMO:getLevel()
		maxHp = heroMO:getAttribute(BattleExtension_pb.Attribute.MAX_HP)
		curHp = maxHp
		hpPercent = 1
		relationType = BattleUISettings.WhiteSetting.relationType
		isInStrengthen = false
		sanity = heroMO:getAttribute(BattleExtension_pb.Attribute.CURRENT_SAN)
		career = heroMO:getCareer()
		colorType = heroMO:getColorType()
		modelCO = heroMO:getModelCo()
	else
		local property = unit.property

		name = property:getName()
		level = property:getLevel()
		curHp = property:getHp()
		maxHp = property:getMaxHp()
		hpPercent = curHp / maxHp
		relationType = BattleUISettingUtil.getRelationType(property:getCampId())
		career = property:getCareer()
		colorType = property:getColorType()
		isInStrengthen = BattleUnitUtil.isUnitStrengthening(unit)
		modelCO = ModelConfig.instance:getModelConfig(property:getModelCode())

		if property:getFaction() == GameEnum.CampEnum.Grox and self._txtLabelOfType2 then
			self._txtLabelOfType2.text = "造物"
		elseif property:getFaction() == GameEnum.CampEnum.Myth and self._txtLabelOfType2 then
			self._txtLabelOfType2.text = "异种"
		elseif self._txtLabelOfType2 then
			self._txtLabelOfType2.text = "人型"
		end
	end

	local isShowLabel = false

	if unit and (unit.property:getBattleCamp() == BattleEnum.MonsterCampType.NORMAL or unit.property:getBattleCamp() == BattleEnum.MonsterCampType.FRIEND) then
		isShowLabel = true
	end

	goutil.setActive(self._txtlabelRoot, isShowLabel)

	self._txtNameOfType2.text = name
	self._txtLevelOfType2.text = level

	goutil.setActive(self._trailLabel, heroMO and heroMO.isTrial)

	local showWeakPoint = unit and unit.property:isShowWeakPoint()

	self:_updateHp(curHp, maxHp, showWeakPoint)
	self:_setActive(self._weakPointPanelGo, showWeakPoint)

	if showWeakPoint then
		local maxHp = unit.property:getWeakPointMaxHp()
		local curHp = unit.property:getWeakPointHp()

		self:_setActive(self._weakPointBroken, curHp <= 0)
		self:_setActive(self._weakPointNormal, curHp > 0)

		if curHp > 0 then
			local weakValue = BattleUnitUtil.formatWeakPointValue(curHp / maxHp)

			self._weakPointTxt.text = string.format("%d%%", weakValue)
		end
	end

	self._careerOfType2:setCareerAndColorType(career, colorType)
end

function M:_updateHp(curHp, maxHp, showWeakPoint)
	return
end

function M:_updateInfoPanel(heroMO, unit)
	local Attribute = BattleExtension_pb.Attribute

	if heroMO then
		self._txtRange.text = heroMO:getAtkRange()

		self:_setTextByHeroMO(self._txtMove, heroMO, Attribute.MOVE, kColorWhite)
		self:_setTextByHeroMO(self._txtAttack, heroMO, Attribute.ATK_PHY, kColorGrey, self._txtLevel[1], self._imgS[1])
		self:_setTextByHeroMO(self._txtDefence, heroMO, Attribute.DEF_PHY, kColorGrey, self._txtLevel[2], self._imgS[2])
		self:_setTextByHeroMO(self._txtMagAttack, heroMO, Attribute.ATK_MAG, kColorGrey, self._txtLevel[3], self._imgS[3])
		self:_setTextByHeroMO(self._txtMagDefence, heroMO, Attribute.DEF_MAG, kColorGrey, self._txtLevel[4], self._imgS[4])
		self:_setTextByHeroMO(self._txtInspiration, heroMO, Attribute.INSPIRATION, kColorGrey, self._txtLevel[5], self._imgS[5])
	else
		local property = unit.property
		local rang = unit.skill:getNormalSkill():getReleaseDistance()

		self._txtRange.text = checkint(rang)

		self:_setTextByProperty(self._txtMove, property, Attribute.MOVE, kColorWhite)
		self:_setTextByProperty(self._txtAttack, property, Attribute.ATK_PHY, kColorGrey, self._txtLevel[1], self._imgS[1])
		self:_setTextByProperty(self._txtDefence, property, Attribute.DEF_PHY, kColorGrey, self._txtLevel[2], self._imgS[2])
		self:_setTextByProperty(self._txtMagAttack, property, Attribute.ATK_MAG, kColorGrey, self._txtLevel[3], self._imgS[3])
		self:_setTextByProperty(self._txtMagDefence, property, Attribute.DEF_MAG, kColorGrey, self._txtLevel[4], self._imgS[4])
		self:_setTextByProperty(self._txtInspiration, property, Attribute.INSPIRATION, kColorGrey, self._txtLevel[5], self._imgS[5])
	end
end

function M:_setTextByHeroMO(text, heroMO, attributeKey, color, txtLevel, imgS)
	local value = heroMO:getAttribute(attributeKey)

	text.text = value

	TextUtils.SetColor(text, color)
	self:_setAttrGrade(heroMO, txtLevel, imgS, attributeKey)
end

function M:_setTextByProperty(text, property, attributeKey, defaultColor, txtLevel, imgS)
	local defaultValue = property:getBaseAttribute(attributeKey)
	local curValue = property:getAttribute(attributeKey)
	local color = defaultColor

	if defaultValue < curValue then
		color = kColorBlue
	elseif curValue < defaultValue then
		color = kColorRed
	end

	text.text = checkint(curValue)

	TextUtils.SetColor(text, color)
	self:_setAttrGrade(false, txtLevel, imgS, attributeKey)
end

function M:_setAttrGrade(heroMO, txtLevel, imgS, attributeKey)
	if not txtLevel or not imgS then
		return
	end

	local heroId = false

	if heroMO then
		heroId = heroMO:getId()
	elseif self._unit.property:getEntityType() == BattleEnum.EntityType.Hero then
		heroId = self._unit.property:getEntityCode()
	end

	if heroMO and heroMO.isTrial then
		local value = heroMO.attributeGrade[monsterAttDataDefine[attributeKey]]

		if value then
			txtLevel.text = value

			goutil.setActive(imgS, value == "S")
			goutil.setActive(txtLevel.gameObject, value ~= "S")
		end
	elseif heroId then
		local conf = BackpackConfig.instance:getConfigByKey(ConfigName.Character, heroId)
		local value = conf.attributeGrade[heroAttDataDefine[attributeKey]]

		if value then
			txtLevel.text = value

			goutil.setActive(imgS, value == "S")
			goutil.setActive(txtLevel.gameObject, value ~= "S")
		end
	else
		local monsterCO = BattleConfigUtil.getEntityConfig(self._unit.property:getEntityCode(), self._unit.property:getEntityType())

		if monsterCO then
			local value = false

			if self._unit.property:getEntityType() == BattleEnum.EntityType.Summon then
				value = monsterCO.attributeGrade[heroAttDataDefine[attributeKey]]
			else
				value = monsterCO.attributeGrade[monsterAttDataDefine[attributeKey]]
			end

			if value then
				txtLevel.text = value

				goutil.setActive(imgS, value == "S")
				goutil.setActive(txtLevel.gameObject, value ~= "S")
			end
		else
			goutil.setActive(imgS, false)
			goutil.setActive(txtLevel.gameObject, false)
		end
	end
end

function M:_updateSkillPanel(heroMO, unit)
	self:_clearSkillIconList()

	self._hasTalentSkill = false

	if heroMO then
		self:_updateSkillByHero(heroMO)
	else
		self:_updateSkillByUnit(unit)
	end

	self._tabSkill.IsOn = true

	self:_checkNormalEmptySkill()
	self:_addSkillIconToParent()
	self._normalSkillLoopGridView:SetListItemCount(#self._normalSkillDataList)
	self._normalSkillLoopGridView:RefreshAllShownItem()
	self._passiveSkillLoopGridView:SetListItemCount(#self._passiveSkillDataList)
	self._passiveSkillLoopGridView:RefreshAllShownItem()
	self:_checkSkillScroll()
end

function M:_checkNormalEmptySkill()
	local normalCount = #self._normalSkillDataList

	if normalCount < 3 then
		for i = normalCount + 1, 3 do
			self:_addNormalSkillIconById(SkillEnum.NORMAL, false, false)
		end
	end
end

function M:_checkSkillScroll()
	local passiveCount = #self._passiveSkillDataList

	goutil.setActive(self._goPassiveEmptyGo, passiveCount == 0)
	goutil.setActive(self._goPassiveScrollGo, passiveCount ~= 0)

	self._scrollPassiveSkill.enabled = passiveCount > 3

	local normalCount = #self._normalSkillDataList

	self._scrollNormalSkill.enabled = normalCount > 3
end

function M:_updateSkillByHero(heroMO)
	local normalSkills = heroMO:getSkills()
	local skillWrapperList = BattleTableUtil.getTempList()

	for _, skill in ipairs(normalSkills) do
		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skill.key)

		table.insert(skillWrapperList, skillCOWrapper)
	end

	table.sort(skillWrapperList, sort_skillWrapper)

	local characterCO = CharacterConfig.instance:getCharacterItemInfo(self._selectedHeroId)

	if characterCO and characterCO.battleTalent then
		local talentSkills = characterCO.battleTalent

		self:_addTalentSkillIcon(self._selectedHeroId, talentSkills[1], SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(self._selectedHeroId, talentSkills[1]):getAllSkillEnhanceCode(), SkillEnum.Normal)
	elseif heroMO.isTrial and heroMO:talentBaseSkillId() then
		local talentSkills = heroMO:getBattleTalent()

		if talentSkills[1] ~= 0 then
			self:_addTalentSkillIcon(self._selectedHeroId, talentSkills[1], SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(self._selectedHeroId, talentSkills[1]):getAllSkillEnhanceCode(), SkillEnum.Normal)
		end
	end

	for _, skillCOWrapper in ipairs(skillWrapperList) do
		local skillType = skillCOWrapper:getSkillType()

		if self:_checkSkillSystemOpen(skillType, true) then
			if skillType == SkillEnum.NORMAL or skillType == SkillEnum.SPECIAL or skillType == SkillEnum.TRUMP then
				local enhanceMO = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(self._selectedHeroId, skillCOWrapper:getSkillCode())

				self:_addNormalSkillIconById(skillType, self._selectedHeroId, skillCOWrapper:getSkillCode(), 0, BattleEnum.SkillStatus.Normal, enhanceMO:getAllSkillEnhanceCode())
			elseif skillType == SkillEnum.ECHO or skillType == SkillEnum.DEPUTY or skillType == SkillEnum.EQUIPMENT then
				self:_addCarrySkillIcon(skillType, self._selectedHeroId, skillCOWrapper:getSkillCode())
			elseif skillType == SkillEnum.PASSIVE then
				self:_addPassiveSkillIconById(skillType, self._selectedHeroId, skillCOWrapper:getSkillCode(), 0, BattleEnum.SkillStatus.Normal, false)
			end
		end
	end

	self:_fillTalentSkillEmpty(self._selectedHeroId)
	self:_fillCarrySkillEmpty(self._selectedHeroId)
	BattleTableUtil.releaseTempList(skillWrapperList)
end

function M:_fillTalentSkillEmpty(heroId)
	if not self._hasTalentSkill then
		self:_addTalentSkillIcon(heroId, false, false, false)
	end
end

function M:_fillCarrySkillEmpty(heroId)
	for i = 1, kMinCarrySkillCount do
		local skillType = SkillEnum.ECHO + i - 1

		if not self._skillIconList.carrySkillIcon[kCarrySkill2Pos[skillType]] then
			self:_addCarrySkillIcon(skillType, heroId, false)
		end
	end
end

function M:_updateSkillByUnit(unit)
	local skillComp = unit.skill
	local heroId = unit.property:getEntityCode()
	local skillMOList = BattleTableUtil.getTempList()

	BattleTableUtil.insertto(skillMOList, skillComp:getActiveSkillList())
	table.sort(skillMOList, sort_skillMO)

	local isSelfCamp = BattleCampRelationUtil.isSameOfOperateCamp(unit)

	for _, skillMO in ipairs(skillMOList) do
		local skillType = skillMO:getCategory()

		if self:_checkSkillSystemOpen(skillType, isSelfCamp) then
			if skillType == SkillEnum.TALENT then
				local entityId = self._unit and self._unit.property:getEntityId()

				self:_addTalentSkillIcon(heroId, skillMO:getSkillId(), skillMO:getEnhanceCodes(), skillComp:getSkillStatus(), entityId)
			elseif skillType == SkillEnum.NORMAL or skillType == SkillEnum.SPECIAL or skillType == SkillEnum.TRUMP then
				self:_addNormalSkillIcon(skillType, heroId, skillMO)
			elseif skillType == SkillEnum.ECHO or skillType == SkillEnum.DEPUTY or skillType == SkillEnum.EQUIPMENT then
				self:_addCarrySkillIcon(skillType, heroId, skillMO:getSkillId())
			elseif skillType == SkillEnum.PASSIVE then
				self:_addPassiveSkillIcon(skillType, heroId, skillMO)
			end
		end
	end

	self:_fillCarrySkillEmpty()
	self:_fillTalentSkillEmpty(heroId)
	BattleTableUtil.releaseTempList(skillMOList)
end

function M:_updateBuffers(unit)
	local buffComp = unit.buff

	self:_clearBuffIconList2()

	local count = 0

	for _, buffMO in pairs(buffComp:getAllBuff()) do
		count = count + 1

		local buffIcon = BattleBuffIcon:createInstance()

		table.insert(self._buffIconList2, buffIcon)
		goutil.addChildToParent(buffIcon.mainGO, self._goBuffRoot2)
		buffIcon:setClickListener(self._onClickBuffIcon, self)

		if count <= 4 then
			buffIcon:setBuffMO(buffMO)
		else
			buffIcon:setMoreSign(true)

			break
		end
	end
end

function M:_addSkillIcon(skillType, heroId, skill, idx)
	if not skill or not skill:isValid() then
		return self:_addSkillIconById(1, heroId, false, false, false, false, idx)
	end

	return self:_addSkillIconById(skillType, heroId, skill:getSkillId(), skill:getCd(), self._unit.skill:getSkillStatus(), skill:getEnhanceCodes(), idx)
end

function M:_addSkillIconById(skillType, heroId, skillId, cd, status, enhanceCodes)
	local skillIcon

	if skillType == SkillEnum.TALENT then
		skillIcon = BattleTalentSkillIcon:createInstance()

		skillIcon:setTipsPopType(CommEnum.TipsPopType.Right)
	else
		skillIcon = BattleSkillIcon:createInstance()
	end

	local entityId = self._unit and self._unit.property:getEntityId()

	if not skillId or skillId <= 0 then
		skillIcon:setEmpty(skillType)
	else
		skillIcon:setSkillInfo(heroId, skillId, status, enhanceCodes, entityId)
		skillIcon:setCd(cd)
		skillIcon:setClickListener(self._onClickSkillIcon, self)
	end

	return skillIcon
end

function M:_addTalentSkillIcon(heroId, skillId, enhanceCodes, skillStatus, entityId)
	self._hasTalentSkill = true

	local isCharacter = ItemUtil.isCharacterById(heroId)

	goutil.setActive(self._normalTalentBgGo, false)
	goutil.setActive(self._goTalent, true)

	if isCharacter then
		local characterCO = CharacterConfig.instance:getCharacterItemInfo(heroId)
		local awakeStatus = TacitModel.instance:isAwakeTalentSkill(heroId, true)
		local talentSkills = characterCO.battleTalent

		self._talentSkill:setHeroAndSkillId(characterCO.id, talentSkills[1], talentSkills[awakeStatus])
		self._talentSkill:setEnhanceCodesAndStatus(enhanceCodes, skillStatus)
		self._talentSkill:setAwakeStatus(awakeStatus)
	else
		self._talentSkill:setHeroAndSkillId(heroId, skillId)
		self._talentSkill:setEnhanceCodesAndStatus(enhanceCodes, skillStatus)
		self._talentSkill:setAwakeStatus(CommEnum.TalentSkillAwakeStatus.None)
	end

	self._talentSkill:setEntityId(entityId)
	self._talentSkill:setClickListener(self._onClickSkillIcon, self)
	self._talentSkill:setNameVisible(false)
	self._talentSkill:setIsBattleView(true)
	self._talentSkill:setPopupSkillItemPassEvent(true)
end

function M:_addNormalSkillIcon(skillType, heroId, skillMO)
	table.insert(self._normalSkillDataList, self:_addSkillData(skillType, heroId, skillMO))
end

function M:_addPassiveSkillIcon(skillType, heroId, skillMO)
	table.insert(self._passiveSkillDataList, self:_addSkillData(skillType, heroId, skillMO))
end

function M:_addNormalSkillIconById(skillType, heroId, skillId, cd, status, enhanceCodes)
	table.insert(self._normalSkillDataList, self:_addSkillDataById(skillType, heroId, skillId, cd, status, enhanceCodes))
end

function M:_addPassiveSkillIconById(skillType, heroId, skillId, cd, status, enhanceCodes)
	table.insert(self._passiveSkillDataList, self:_addSkillDataById(skillType, heroId, skillId, cd, status, enhanceCodes))
end

function M:_addSkillData(skillType, heroId, skillMO)
	if not skillMO or not skillMO:isValid() then
		return self:_addSkillDataById(1, heroId)
	else
		return self:_addSkillDataById(skillType, heroId, skillMO:getSkillId(), skillMO:getCd(), self._unit.skill:getSkillStatus(), skillMO:getEnhanceCodes())
	end
end

function M:_addSkillDataById(skillType, heroId, skillId, cd, status, enhanceCodes)
	return {
		skillType = skillType,
		heroId = heroId,
		skillId = skillId,
		cd = cd,
		status = status,
		enhanceCodes = enhanceCodes
	}
end

function M:_addCarrySkillIcon(skillType, heroId, skillId)
	local skillIcon = BattleCarrySkillIcon:createInstance()

	if skillId and skillId > 0 then
		skillIcon:setSkillInfo(heroId, skillId)
		skillIcon:setClickListener(self._onClickSkillIcon, self)
	else
		skillIcon:setEmpty(skillType)
	end

	self._skillIconList.carrySkillIcon[kCarrySkill2Pos[skillType]] = skillIcon
end

function M:_addSkillIconToParent()
	self:_skillIconToParent(self._skillIconList.talentSkillIcon, self._goTalentRoot)
	self:_skillIconToParent(self._skillIconList.carrySkillIcon, self._goCarrySkillRoot)
end

function M:_skillIconToParent(skillIconList, parent)
	for _, skillIcon in ipairs(skillIconList) do
		goutil.addChildToParent(skillIcon.mainGO, parent)
	end
end

function M:_clearBuffIconList2()
	BattleTableUtil.clearReusableTable(self._buffIconList2)
end

function M:_clearSkillIconList()
	BattleTableUtil.clearReusableTable(self._skillIconList.talentSkillIcon)
	BattleTableUtil.clearReusableTable(self._skillIconList.carrySkillIcon)
	BattleTableUtil.clearTable(self._normalSkillDataList)
	BattleTableUtil.clearTable(self._passiveSkillDataList)
end

function M:setClickHandler(func, handler)
	self._clickFunc = func
	self._clickHandler = handler
end

function M:_onClickClose()
	if self._clickFunc then
		self._clickFunc(self._clickHandler)
	end
end

function M:_onClickBuffIcon()
	local buffTable = self._unit.buff:getAllBuff()

	if #buffTable > 0 then
		local forceAlign = UnityEngine.TextAnchor.LowerLeft
		local forceTipsAlignVer = CommEnum.TipsAlignType.Up

		ToolTipsMgr.showBattleBuffTips(self._unit, self._goBuffBind, forceAlign, forceTipsAlignVer)
	end
end

function M:_onClickSkillIcon(skillInfo, cellGo)
	local bindGo = self._goSkillBind

	self._selectedHeroId = skillInfo.heroId
	self._selectedSkillId = skillInfo.skillId
	skillInfo.hangGO = bindGo
	skillInfo.hideEnhanceDetail = false
	skillInfo.hasDispatch = true
	skillInfo.simulateCloseWhenDraging = true
	skillInfo.offsetY = 0
	skillInfo.offsetX = 0
	skillInfo.forceAlign = UnityEngine.TextAnchor.LowerLeft
	skillInfo.forceTipsAlignVer = CommEnum.TipsAlignType.Up

	BattleMainViewFacade.instance:showSkillTipsOfOperateUnit(skillInfo)
end

function M:_onSkillTipsCloseOrOpen(_, isEnter, viewName)
	self._isSkillTipsOpen = isEnter

	local heroId = self._talentSkill:getHeroId()
	local skillId = self._talentSkill:getSkillId()

	if isEnter and heroId and skillId and heroId == self._selectedHeroId and skillId == self._selectedSkillId then
		self._talentSkill:setSelected(true)
	else
		self._talentSkill:setSelected(false)
	end

	if viewName == ViewName.ToolTipsCharacterSkillDetailViewPresentor then
		self:_setSkillIconCloseOrOpen(self._skillIconList.talentSkillIcon, isEnter)
		self:_setSkillIconCloseOrOpen(self._skillIconList.carrySkillIcon, isEnter)
		self._normalSkillLoopGridView:RefreshAllShownItem()
		self._passiveSkillLoopGridView:RefreshAllShownItem()
	end
end

function M:_setSkillIconCloseOrOpen(skillList, isEnter)
	for _, skillIcon in pairs(skillList) do
		local heroId = skillIcon:getHeroId()
		local skillId = skillIcon:getSkillId()

		if isEnter and heroId and skillId and heroId == self._selectedHeroId and skillId == self._selectedSkillId then
			skillIcon:setSelected(true)
		else
			skillIcon:setSelected(false)
		end
	end
end

function M:_onSkillTab(skillTabType, isOn)
	self._guiTimeline:StopTimelineAni()

	if skillTabType == BattleEnum.SkillType.NORMAL then
		goutil.setActive(self._goSkillRoot, isOn)

		self._scrollNormalSkill.horizontalNormalizedPosition = 0

		self._guiTimeline:PlayAniByName("jineng")
	elseif skillTabType == BattleEnum.SkillType.CARRY then
		goutil.setActive(self._goCarryRoot, isOn)
		self._guiTimeline:PlayAniByName("zhuangbei")
	elseif skillTabType == BattleEnum.SkillType.PASSIVE then
		goutil.setActive(self._goPassiveRoot, isOn)
		self._guiTimeline:PlayAniByName("beidong")

		self._scrollPassiveSkill.horizontalNormalizedPosition = 0
	end
end

function M:activekillAnimation()
	self._guiTimeline:PlayAniByName("jineng")
end

return M
