-- chunkname: @modules/logic/enemyinfo/view/EnemyInfoRightView.lua

module("modules.logic.enemyinfo.view.EnemyInfoRightView", package.seeall)

local EnemyInfoRightView = class("EnemyInfoRightView", BaseView)

function EnemyInfoRightView:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_right_container/#go_header/head/#simage_icon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "#go_right_container/#go_header/head/#image_career")
	self._gobosstag = gohelper.findChild(self.viewGO, "#go_right_container/#go_header/head/#go_bosstag")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_right_container/#go_header/#txt_name")
	self._txtlevel = gohelper.findChildText(self.viewGO, "#go_right_container/#go_header/#txt_level")
	self._txthp = gohelper.findChildText(self.viewGO, "#go_right_container/#go_header/hp/hp_label/image_HPFrame/#txt_hp")
	self._gomultihp = gohelper.findChild(self.viewGO, "#go_right_container/#go_header/hp/hp_label/image_HPFrame/#go_multihp")
	self._gomultihpitem = gohelper.findChild(self.viewGO, "#go_right_container/#go_header/hp/hp_label/image_HPFrame/#go_multihp/#go_hpitem")
	self._btnshowAttribute = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right_container/#go_line1/#btn_showAttribute")
	self._gonormalIcon = gohelper.findChild(self.viewGO, "#go_right_container/#go_line1/#btn_showAttribute/#go_normalIcon")
	self._goselectIcon = gohelper.findChild(self.viewGO, "#go_right_container/#go_line1/#btn_showAttribute/#go_selectIcon")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#txt_desc")
	self._goattribute = gohelper.findChild(self.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_attribute")
	self._gobossspecialskill = gohelper.findChild(self.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_bossspecialskill")
	self._goresistance = gohelper.findChild(self.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_resistance")
	self._gopassiveskill = gohelper.findChild(self.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_passiveskill")
	self._gopassiveskillitem = gohelper.findChild(self.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_passiveskill/#go_passiveskillitem")
	self._gonoskill = gohelper.findChild(self.viewGO, "#go_right_container/#go_skill_container/#go_noskill")
	self._goskill = gohelper.findChild(self.viewGO, "#go_right_container/#go_skill_container/#go_skill")
	self._gosuperitem = gohelper.findChild(self.viewGO, "#go_right_container/#go_skill_container/#go_skill/card/scrollview/viewport/content/supers/#go_superitem")
	self._goskillitem = gohelper.findChild(self.viewGO, "#go_right_container/#go_skill_container/#go_skill/card/scrollview/viewport/content/skills/#go_skillitem")
	self._gopassivedescitempool = gohelper.findChild(self.viewGO, "#go_right_container/#go_passivedescitem_pool")
	self._gopassivedescitem = gohelper.findChild(self.viewGO, "#go_right_container/#go_passivedescitem_pool/#go_descitem")
	self._gobufftipitem = gohelper.findChild(self.viewGO, "#go_tip_container/#go_bufftip/#scroll_buff/viewport/content/#go_buffitem")
	self._gomultistage = gohelper.findChild(self.viewGO, "#go_right_container/#go_header/#go_multi_stage")
	self._gostageitem = gohelper.findChild(self.viewGO, "#go_right_container/#go_header/#go_multi_stage/#go_stage_item")
	self._btnstress = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_right_container/#go_header/#btn_stress")
	self._gostress = self._btnstress.gameObject

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EnemyInfoRightView:addEvents()
	self._btnshowAttribute:AddClickListener(self._btnshowAttributeOnClick, self)
	self._btnstress:AddClickListener(self.onClickStress, self)
end

function EnemyInfoRightView:removeEvents()
	self._btnshowAttribute:RemoveClickListener()
	self._btnstress:RemoveClickListener()
end

EnemyInfoRightView.AttrIdList = {
	CharacterEnum.AttrId.Attack,
	CharacterEnum.AttrId.Technic,
	CharacterEnum.AttrId.Defense,
	CharacterEnum.AttrId.Mdefense
}

function EnemyInfoRightView:onClickStress()
	StressTipController.instance:openMonsterStressTip(self.monsterConfig)
end

function EnemyInfoRightView:_btnshowAttributeOnClick()
	self.isShowAttributeInfo = not self.isShowAttributeInfo

	self:refreshAttributeAndDescVisible()
end

function EnemyInfoRightView:onClickBossSpecialSkill()
	if not self.isBoss then
		return
	end

	local specialSkillItem = self.specialSkillItemList[self.useBossSpecialSkillCount]
	local tr = specialSkillItem.go:GetComponent(gohelper.Type_Transform)
	local uiCamera = CameraMgr.instance:getUICamera()
	local anchorX, anchorY = recthelper.worldPosToAnchorPos2(tr.position, self.tipContainerRectTr, uiCamera, uiCamera)

	recthelper.setAnchor(self.buffTipRectTr, anchorX + EnemyInfoEnum.BuffTipOffset.x, anchorY + EnemyInfoEnum.BuffTipOffset.y)
	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.ShowTip, EnemyInfoEnum.Tip.BuffTip)
end

function EnemyInfoRightView:onClickSkillItem(skillItem)
	self.tipViewParam = self.tipViewParam or {}
	self.tipViewParam.super = skillItem.super
	self.tipViewParam.skillIdList = skillItem.skillIdList
	self.tipViewParam.monsterName = FightConfig.instance:getMonsterName(self.monsterConfig)

	ViewMgr.instance:openView(ViewName.SkillTipView3, self.tipViewParam)
end

function EnemyInfoRightView:onClickStageItem(stageItem)
	if self.monsterId == stageItem.monsterId then
		return
	end

	self.monsterId = stageItem.monsterId
	self.monsterConfig = lua_monster.configDict[self.monsterId]
	self.skinConfig = FightConfig.instance:getSkinCO(self.monsterConfig.skinId)

	self:refreshUI()
end

function EnemyInfoRightView:initAttributeItemList()
	self.attributeItemList = {}

	for i = 1, 4 do
		local attributeItem = self:getUserDataTb_()

		attributeItem.go = gohelper.findChild(self._goattribute, "attribute" .. i)
		attributeItem.icon = gohelper.findChildImage(attributeItem.go, "icon")
		attributeItem.name = gohelper.findChildText(attributeItem.go, "name")
		attributeItem.rate = gohelper.findChildImage(attributeItem.go, "rate")

		table.insert(self.attributeItemList, attributeItem)
	end
end

function EnemyInfoRightView:_editableInitView()
	local goRight = gohelper.findChild(self.viewGO, "#go_right_container")

	self.rectTrRight = goRight:GetComponent(gohelper.Type_RectTransform)
	self.rectTrViewGo = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self._gEnemyDesc = self._txtdesc.gameObject
	self.isShowAttributeInfo = false
	self.tipContainerRectTr = gohelper.findChildComponent(self.viewGO, "#go_tip_container", gohelper.Type_RectTransform)
	self.buffTipRectTr = gohelper.findChildComponent(self.viewGO, "#go_tip_container/#go_bufftip", gohelper.Type_RectTransform)
	self.specialSkillItemList = {}
	self.goBossSpecialSkillItem = gohelper.findChild(self.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_bossspecialskill/item")
	self.scrollEnemyInfo = gohelper.findChildScrollRect(self.viewGO, "#go_right_container/#scroll_enemyinfo")

	gohelper.setActive(self.goBossSpecialSkillItem, false)
	gohelper.setActive(self._gosuperitem, false)
	gohelper.setActive(self._goskillitem, false)
	gohelper.setActive(self._gopassiveskillitem, false)
	gohelper.setActive(self._gobufftipitem, false)
	gohelper.setActive(self._gostageitem, false)

	self.bossSpecialClick = gohelper.getClickWithDefaultAudio(self._gobossspecialskill)

	self.bossSpecialClick:AddClickListener(self.onClickBossSpecialSkill, self)

	self.passiveSkillItemList = {}
	self.passiveDescItemPool = {}
	self.passiveDescItemList = {}
	self.trPassiveDescItemPool = self._gopassivedescitempool:GetComponent(gohelper.Type_Transform)

	gohelper.setActive(self._gopassivedescitempool, false)

	self.smallSkillItemList = {}
	self.superSkillItemList = {}
	self.buffTipItemList = {}
	self.stageItemList = {}
	self.multiHpGoList = self:getUserDataTb_()

	table.insert(self.multiHpGoList, self._gomultihpitem)
	self:initAttributeItemList()
	self.addEventCb(self, EnemyInfoController.instance, EnemyInfoEvent.SelectMonsterChange, self.onSelectMonsterChange, self)

	local chapterId = DungeonModel.instance.curSendChapterId

	if chapterId then
		local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

		self.isSimple = chapterCo and chapterCo.type == DungeonEnum.ChapterType.Simple
	end

	self.resistanceComp = FightEntityResistanceComp.New(self._goresistance, self.viewContainer)

	self.resistanceComp:onInitView()
	self.resistanceComp:setParent(self.scrollEnemyInfo.gameObject)

	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function EnemyInfoRightView:onSelectMonsterChange(eventData)
	if not eventData then
		return
	end

	local delayRefresh = false
	local enemyIndex = eventData.enemyIndex

	if self.enemyIndex ~= enemyIndex then
		if self.enemyIndex then
			delayRefresh = true

			self.anim:Play("switch", 0, 0)
		end

		self.enemyIndex = enemyIndex
	end

	local monsterId = eventData.monsterId

	if self.monsterId == monsterId then
		return
	end

	self.monsterId = monsterId
	self.isBoss = eventData.isBoss
	self.monsterConfig = lua_monster.configDict[self.monsterId]
	self.skinConfig = FightConfig.instance:getSkinCO(self.monsterConfig.skinId)

	if delayRefresh then
		TaskDispatcher.runDelay(self.refreshUI, self, 0.16)
	else
		self:refreshUI()
	end
end

function EnemyInfoRightView:refreshUI()
	self:refreshAttributeAndDescVisible()
	self:refreshHeader()
	self:refreshDesc()
	self:refreshAttribute()
	self:refreshBossSpecialSkill()
	self:refreshResistance()
	self:refreshPassiveSkill()
	self:refreshSkill()
end

function EnemyInfoRightView:refreshAttributeAndDescVisible()
	gohelper.setActive(self._gonormalIcon, not self.isShowAttributeInfo)
	gohelper.setActive(self._gEnemyDesc, not self.isShowAttributeInfo)
	gohelper.setActive(self._goselectIcon, self.isShowAttributeInfo)
	gohelper.setActive(self._goattribute, self.isShowAttributeInfo)

	self.scrollEnemyInfo.verticalNormalizedPosition = 1
end

function EnemyInfoRightView:refreshHeader()
	local monsterConfig = self.monsterConfig
	local skinConfig = self.skinConfig

	gohelper.getSingleImage(self._imageicon.gameObject):LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))
	IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(monsterConfig.heartVariantId), self._imageicon)
	gohelper.setActive(self._gobosstag, self.isBoss)

	if self.viewParam and self.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Sodache then
		gohelper.setActive(self._imagecareer, false)
	else
		UISpriteSetMgr.instance:setEnemyInfoSprite(self._imagecareer, "sxy_" .. monsterConfig.career)
	end

	local levelStr = self.isSimple and "levelEasy" or "level"

	self._txtlevel.text = HeroConfig.instance:getLevelDisplayVariant(monsterConfig[levelStr])

	gohelper.setActive(self._txtlevel, self.viewParam.tabEnum ~= EnemyInfoEnum.TabEnum.Act191)

	self._txtname.text = FightConfig.instance:getMonsterName(monsterConfig)

	if self.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Rouge then
		local hpFixRate = self.viewParam.hpFixRate
		local hp = CharacterDataConfig.instance:getMonsterHp(monsterConfig.id, self.isSimple)
		local hpNumber = tonumber(hp)

		self._txthp.text = hpNumber and math.floor(hpNumber * hpFixRate) or hp
	elseif self.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Survival then
		local hpFixRate = self.viewParam.hpFixRate
		local hp = CharacterDataConfig.instance:getMonsterHp(monsterConfig.id, self.isSimple)
		local hpNumber = tonumber(hp)

		self._txthp.text = hpNumber and math.floor(hpNumber * (1 + hpFixRate)) or hp
	elseif self.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Sodache then
		if not self.viewParam.hpFixRate then
			local hpFixRate = 0
			local hp = CharacterDataConfig.instance:getMonsterHp(monsterConfig.id, self.isSimple)
			local hpNumber = tonumber(hp)

			self._txthp.text = hpNumber and math.floor(hpNumber * (1 + hpFixRate)) or hp
		end
	else
		self._txthp.text = self.viewParam.tabEnum == EnemyInfoEnum.TabEnum.TowerCompose and self:getTowerComposeHp() or CharacterDataConfig.instance:getMonsterHp(monsterConfig.id, self.isSimple)
	end

	self:refreshMultiHp()
	self:refreshMultiStage()
	self:refreshStress()
end

function EnemyInfoRightView:getTowerComposeHp()
	local themeId = self.viewParam.themeId
	local episodeId = self.viewParam.episodeId
	local themeConfig = TowerComposeConfig.instance:getThemeConfig(themeId)
	local bossMonsterGroupId = themeConfig.monsterGroupId
	local bossMonsterIdList = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[bossMonsterGroupId].monster, "#")
	local monsterId = self.monsterConfig.id
	local modLevel = TowerComposeModel.instance:getThemePlaneLevel(themeId)

	return (TowerComposeModel.instance:getMonsterHp(bossMonsterIdList, episodeId, modLevel, monsterId))
end

function EnemyInfoRightView:refreshMultiHp()
	local multiHpList = FightConfig.instance:getMultiHpListByMonsterId(self.monsterConfig.id, self.isSimple)

	if not multiHpList then
		gohelper.setActive(self._gomultihp, false)

		return
	end

	gohelper.setActive(self._gomultihp, true)

	local multiHpNum = #multiHpList

	for i = 1, multiHpNum do
		local go = self.multiHpGoList[i]

		if not go then
			go = gohelper.cloneInPlace(self._gomultihpitem)

			table.insert(self.multiHpGoList, go)
		end

		gohelper.setActive(go, true)
	end

	for i = multiHpNum + 1, #self.multiHpGoList do
		gohelper.setActive(self.multiHpGoList[i], false)
	end
end

function EnemyInfoRightView:refreshMultiStage()
	if self.viewParam.tabEnum ~= EnemyInfoEnum.TabEnum.BossRush then
		gohelper.setActive(self._gomultistage, false)

		return
	end

	local battleId = self.enemyInfoMo.battleId
	local countBossCo = lua_activity128_countboss.configDict[battleId]

	if not countBossCo then
		logError("activity128_countboss config not found battle id : " .. tostring(battleId))
		gohelper.setActive(self._gomultistage, false)

		return
	end

	local monsterIdList = string.splitToNumber(countBossCo.monsterId, "#")
	local monsterCount = #monsterIdList

	if monsterCount <= 1 then
		gohelper.setActive(self._gomultistage, false)

		return
	end

	if not tabletool.indexOf(monsterIdList, self.monsterId) then
		gohelper.setActive(self._gomultistage, false)

		return
	end

	gohelper.setActive(self._gomultistage, true)

	for i, monsterId in ipairs(monsterIdList) do
		local stageItem = self.stageItemList[i]

		if not stageItem then
			stageItem = self:getStageItem()

			table.insert(self.stageItemList, stageItem)
		end

		gohelper.setActive(stageItem.go, true)

		stageItem.txt.text = GameUtil.getRomanNums(i)
		stageItem.monsterId = monsterId

		local select = monsterId == self.monsterId

		if select then
			stageItem.txt.color = EnemyInfoEnum.StageColor.Select or EnemyInfoEnum.StageColor.Normal
		end

		gohelper.setActive(stageItem.goSelect, select)

		if select then
			if i == monsterCount then
				UISpriteSetMgr.instance:setEnemyInfoSprite(stageItem.imageSelect, "fight_btn_grip2")
			else
				UISpriteSetMgr.instance:setEnemyInfoSprite(stageItem.imageSelect, "fight_btn_grip1")
			end
		end
	end

	for i = monsterCount + 1, #self.stageItemList do
		gohelper.setActive(self.stageItemList[i].go, false)
	end
end

function EnemyInfoRightView:refreshStress()
	if self.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Rouge then
		local rougeInfo = RougeModel.instance:getRougeInfo()
		local mountDlc = rougeInfo and rougeInfo:checkMountDlc()

		if not mountDlc then
			gohelper.setActive(self._gostress, false)

			return
		end
	end

	local monsterTemplateCo = lua_monster_skill_template.configDict[self.monsterConfig.skillTemplate]
	local maxStress = monsterTemplateCo and monsterTemplateCo.maxStress

	gohelper.setActive(self._gostress, maxStress and maxStress > 0)
end

function EnemyInfoRightView:getStageItem()
	local stageItem = self:getUserDataTb_()

	stageItem.go = gohelper.cloneInPlace(self._gostageitem)
	stageItem.txt = gohelper.findChildText(stageItem.go, "#txt_stage")
	stageItem.imageSelect = gohelper.findChildImage(stageItem.go, "#image_select")
	stageItem.goSelect = gohelper.findChild(stageItem.go, "#image_select")
	stageItem.click = gohelper.getClickWithDefaultAudio(stageItem.go)

	stageItem.click:AddClickListener(self.onClickStageItem, self, stageItem)

	return stageItem
end

function EnemyInfoRightView:refreshDesc()
	local isUseNewConfig = FightConfig.instance:getNewMonsterConfig(self.monsterConfig)

	if isUseNewConfig then
		self._txtdesc.text = self.monsterConfig.highPriorityDes or self.monsterConfig.des
	end
end

function EnemyInfoRightView:refreshAttribute()
	local monsterSkillTemplateConfig = lua_monster_skill_template.configDict[self.monsterConfig.skillTemplate]
	local template = monsterSkillTemplateConfig.template

	if string.nilorempty(template) then
		logError(string.format("怪物模板表, id ： %s, 没有配置属性倾向。", monsterSkillTemplateConfig.id))

		return
	end

	local attrTab = string.splitToNumber(template, "#")

	table.insert(attrTab, 2, table.remove(attrTab, 4))

	for i, attrId in ipairs(EnemyInfoRightView.AttrIdList) do
		local attrItem = self.attributeItemList[i]
		local config = HeroConfig.instance:getHeroAttributeCO(attrId)

		attrItem.name.text = config.name

		UISpriteSetMgr.instance:setCommonSprite(attrItem.icon, "icon_att_" .. config.id)
		UISpriteSetMgr.instance:setCommonSprite(attrItem.rate, "sx_" .. attrTab[i], true)
	end
end

function EnemyInfoRightView:recycleAllBossSpecialSkillItem()
	for _, specialItem in ipairs(self.specialSkillItemList) do
		gohelper.setActive(specialItem.go, false)
	end

	self.useBossSpecialSkillCount = 0
end

function EnemyInfoRightView:getBossSpecialSkillItem()
	if self.useBossSpecialSkillCount < #self.specialSkillItemList then
		self.useBossSpecialSkillCount = self.useBossSpecialSkillCount + 1

		local specialSkillItem = self.specialSkillItemList[self.useBossSpecialSkillCount]

		gohelper.setActive(specialSkillItem.go, true)

		return specialSkillItem
	end

	self.useBossSpecialSkillCount = self.useBossSpecialSkillCount + 1

	local specialSkillItem = self:getUserDataTb_()

	specialSkillItem.go = gohelper.cloneInPlace(self.goBossSpecialSkillItem)
	specialSkillItem.gotag = gohelper.findChild(specialSkillItem.go, "tag")
	specialSkillItem.txttag = gohelper.findChildText(specialSkillItem.go, "tag/#txt_tag")
	specialSkillItem.imageicon = gohelper.findChildImage(specialSkillItem.go, "icon")

	gohelper.setActive(specialSkillItem.go, true)
	table.insert(self.specialSkillItemList, specialSkillItem)

	return specialSkillItem
end

function EnemyInfoRightView:refreshBossSpecialSkill()
	gohelper.setActive(self._gobossspecialskill, self.isBoss)

	if self.isBoss then
		self:recycleAllBossSpecialSkillItem()
		self:recycleBuffTipItem()

		local skillIdList = FightConfig.instance:getPassiveSkillsAfterUIFilter(self.monsterConfig.id)

		for _, skillId in ipairs(skillIdList) do
			local specialSkillCo = lua_skill_specialbuff.configDict[skillId]

			if specialSkillCo and specialSkillCo.isSpecial == 1 then
				local specialSkillItem = self:getBossSpecialSkillItem()

				if string.nilorempty(specialSkillCo.lv) then
					gohelper.setActive(specialSkillItem.gotag, false)
				else
					gohelper.setActive(specialSkillItem.gotag, true)

					specialSkillItem.txttag.text = specialSkillCo.lv
				end

				UISpriteSetMgr.instance:setFightPassiveSprite(specialSkillItem.imageicon, specialSkillCo.icon)

				local buttTipItem = self:getBuffTipItem()
				local skillConfig = lua_skill.configDict[skillId]

				buttTipItem.name.text = skillConfig.name

				local name = FightConfig.instance:getMonsterName(self.monsterConfig)

				buttTipItem.desc.text = SkillHelper.getSkillDesc(name, skillConfig, "#CC492F", "#485E92")

				gohelper.setActive(buttTipItem.goline, true)
				UISpriteSetMgr.instance:setFightPassiveSprite(buttTipItem.bufficon, specialSkillCo.icon)
			end
		end

		if self.useBuffTipCount > 0 then
			local buttTipItem = self.buffTipItemList[self.useBuffTipCount]

			gohelper.setActive(buttTipItem.goline, false)
		else
			gohelper.setActive(self._gobossspecialskill, false)
		end
	end
end

function EnemyInfoRightView:refreshResistance()
	local templateId = self.monsterConfig.skillTemplate
	local templateCo = templateId and lua_monster_skill_template.configDict[templateId]
	local resistanceId = templateCo and templateCo.resistance
	local resistanceCo = resistanceId and lua_resistances_attribute.configDict[resistanceId]

	if resistanceCo then
		self.resistanceDict = self.resistanceDict or {}

		tabletool.clear(self.resistanceDict)

		for resistance, _ in pairs(FightEnum.Resistance) do
			local value = resistanceCo[resistance]

			if value > 0 then
				self.resistanceDict[resistance] = value
			end
		end

		self.resistanceComp:refresh(self.resistanceDict)
	else
		self.resistanceComp:refresh(nil)
	end
end

function EnemyInfoRightView:refreshPassiveSkill()
	self:recycleAllPassiveSkillItem()
	self:recycleAllPassiveDescItem()

	self.exitsTagNameDict = self.exitsTagNameDict or {}

	tabletool.clear(self.exitsTagNameDict)

	local skillIdList = FightConfig.instance:getPassiveSkillsAfterUIFilter(self.monsterConfig.id)

	for _, skillId in ipairs(skillIdList) do
		if self.isBoss then
			local specialSkillCo = lua_skill_specialbuff.configDict[skillId]

			if not specialSkillCo or specialSkillCo.isSpecial ~= 1 then
				self:refreshOnePassiveSkill(skillId)
			end
		else
			self:refreshOnePassiveSkill(skillId)
		end
	end
end

function EnemyInfoRightView:refreshOnePassiveSkill(skillId)
	local skillItem = self:getPassiveSkillItem()
	local skillConfig = lua_skill.configDict[skillId]

	skillItem.name.text = skillConfig.name

	local name = FightConfig.instance:getMonsterName(self.monsterConfig)
	local txt = FightConfig.instance:getSkillEffectDesc(name, skillConfig)
	local passiveDescItem = self:getPassiveDescItem()

	passiveDescItem.tr:SetParent(skillItem.tr)

	passiveDescItem.txt.text = SkillHelper.buildDesc(txt)
end

function EnemyInfoRightView:getPassiveSkillItem()
	if self.usePassiveSkillItemCount < #self.passiveSkillItemList then
		self.usePassiveSkillItemCount = self.usePassiveSkillItemCount + 1

		local skillItem = self.passiveSkillItemList[self.usePassiveSkillItemCount]

		recthelper.setWidth(skillItem.rectTr, self.layoutMo.enemyInfoWidth)
		gohelper.setActive(skillItem.go, true)

		return skillItem
	end

	self.usePassiveSkillItemCount = self.usePassiveSkillItemCount + 1

	local skillItem = self:getUserDataTb_()

	skillItem.go = gohelper.cloneInPlace(self._gopassiveskillitem)
	skillItem.tr = skillItem.go:GetComponent(gohelper.Type_Transform)
	skillItem.rectTr = skillItem.go:GetComponent(gohelper.Type_RectTransform)

	recthelper.setWidth(skillItem.rectTr, self.layoutMo.enemyInfoWidth)

	skillItem.name = gohelper.findChildText(skillItem.go, "bg/name")

	gohelper.setActive(skillItem.go, true)
	table.insert(self.passiveSkillItemList, skillItem)

	return skillItem
end

function EnemyInfoRightView:recycleAllPassiveSkillItem()
	for _, skillItem in ipairs(self.passiveSkillItemList) do
		gohelper.setActive(skillItem.go, false)
	end

	self.usePassiveSkillItemCount = 0
end

function EnemyInfoRightView:getPassiveDescItem()
	if #self.passiveDescItemPool > 0 then
		local descItem = table.remove(self.passiveDescItemPool)

		gohelper.setActive(descItem.go, true)
		recthelper.setWidth(descItem.rectTrTxt, self.layoutMo.enemyInfoWidth - EnemyInfoEnum.SkillDescLeftMargin)
		table.insert(self.passiveDescItemList, descItem)

		return descItem
	end

	local descItem = self:getUserDataTb_()

	descItem.go = gohelper.cloneInPlace(self._gopassivedescitem)
	descItem.tr = descItem.go:GetComponent(gohelper.Type_Transform)
	descItem.txt = gohelper.findChildText(descItem.go, "#txt_desc")
	descItem.rectTrTxt = descItem.txt:GetComponent(gohelper.Type_RectTransform)

	recthelper.setWidth(descItem.rectTrTxt, self.layoutMo.enemyInfoWidth - EnemyInfoEnum.SkillDescLeftMargin)
	gohelper.setActive(descItem.go, true)
	SkillHelper.addHyperLinkClick(descItem.txt, self.onClickPassiveHyper, self)
	table.insert(self.passiveDescItemList, descItem)

	return descItem
end

EnemyInfoRightView.Interval = 80

function EnemyInfoRightView:onClickPassiveHyper(effectId, clickPosition)
	local viewWidth = recthelper.getWidth(self.rectTrViewGo)
	local halfW = viewWidth / 2
	local anchorX = recthelper.getAnchorX(self.rectTrRight)

	self.commonBuffTipAnchorPos = self.commonBuffTipAnchorPos or Vector2()

	self.commonBuffTipAnchorPos:Set(-(halfW - anchorX) + EnemyInfoRightView.Interval, 269.28)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(effectId), self.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right)
end

function EnemyInfoRightView:recycleAllPassiveDescItem()
	for _, descItem in ipairs(self.passiveDescItemList) do
		gohelper.setActive(descItem.go, false)
		descItem.tr:SetParent(self.trPassiveDescItemPool)
		table.insert(self.passiveDescItemPool, descItem)
	end

	tabletool.clear(self.passiveDescItemList)
end

function EnemyInfoRightView:refreshSkill()
	self:refreshSmallSkill()
	self:refreshSuperSkill()

	local hasSkill = not string.nilorempty(self.monsterConfig.activeSkill) or #self.monsterConfig.uniqueSkill > 0

	gohelper.setActive(self._gonoskill, not hasSkill)
	gohelper.setActive(self._goskill, hasSkill)
end

function EnemyInfoRightView:refreshSmallSkill()
	self:recycleAllSmallSkill()

	if string.nilorempty(self.monsterConfig.activeSkill) then
		return
	end

	local skillIdList = GameUtil.splitString2(self.monsterConfig.activeSkill, true)

	for _, skillIdArr in ipairs(skillIdList) do
		table.remove(skillIdArr, 1)

		local skillId = skillIdArr[1]
		local skillConfig = lua_skill.configDict[skillId]
		local skillItem = self:getSmallSkillItem()

		skillItem.icon:LoadImage(ResUrl.getSkillIcon(skillConfig.icon))
		skillItem.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillConfig.showTag))

		skillItem.super = false
		skillItem.skillIdList = skillIdArr
	end
end

function EnemyInfoRightView:refreshSuperSkill()
	self:recycleAllSuperSkill()

	local uniqueSkillList = self.monsterConfig.uniqueSkill

	for _, skillId in ipairs(uniqueSkillList) do
		local skillItem = self:getSuperSkillItem()
		local skillConfig = lua_skill.configDict[skillId]

		skillItem.icon:LoadImage(ResUrl.getSkillIcon(skillConfig.icon))
		skillItem.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillConfig.showTag))

		skillItem.super = true

		table.insert(skillItem.skillIdList, skillId)
	end
end

function EnemyInfoRightView:recycleAllSmallSkill()
	for _, skillItem in ipairs(self.smallSkillItemList) do
		gohelper.setActive(skillItem.go, false)
	end

	self.useSmallSkillItemCount = 0
end

function EnemyInfoRightView:getSmallSkillItem()
	if self.useSmallSkillItemCount < #self.smallSkillItemList then
		self.useSmallSkillItemCount = self.useSmallSkillItemCount + 1

		local skillItem = self.smallSkillItemList[self.useSmallSkillItemCount]

		gohelper.setActive(skillItem.go, true)

		return skillItem
	end

	self.useSmallSkillItemCount = self.useSmallSkillItemCount + 1

	local skillItem = self:getUserDataTb_()

	skillItem.go = gohelper.cloneInPlace(self._goskillitem)
	skillItem.icon = gohelper.findChildSingleImage(skillItem.go, "imgIcon")
	skillItem.tag = gohelper.findChildSingleImage(skillItem.go, "tag/tagIcon")
	skillItem.btn = gohelper.findChildButtonWithAudio(skillItem.go, "bg", AudioEnum.UI.Play_UI_Activity_tips)

	skillItem.btn:AddClickListener(self.onClickSkillItem, self, skillItem)
	gohelper.setActive(skillItem.go, true)
	table.insert(self.smallSkillItemList, skillItem)

	return skillItem
end

function EnemyInfoRightView:recycleAllSuperSkill()
	for _, skillItem in ipairs(self.superSkillItemList) do
		gohelper.setActive(skillItem.go, false)

		skillItem.super = nil

		tabletool.clear(skillItem.skillIdList)
	end

	self.useSuperSkillItemCount = 0
end

function EnemyInfoRightView:getSuperSkillItem()
	if self.useSuperSkillItemCount < #self.superSkillItemList then
		self.useSuperSkillItemCount = self.useSuperSkillItemCount + 1

		local skillItem = self.superSkillItemList[self.useSuperSkillItemCount]

		gohelper.setActive(skillItem.go, true)

		return skillItem
	end

	self.useSuperSkillItemCount = self.useSuperSkillItemCount + 1

	local skillItem = self:getUserDataTb_()

	skillItem.go = gohelper.cloneInPlace(self._gosuperitem)
	skillItem.icon = gohelper.findChildSingleImage(skillItem.go, "imgIcon")
	skillItem.tag = gohelper.findChildSingleImage(skillItem.go, "tag/tagIcon")
	skillItem.btn = gohelper.findChildButtonWithAudio(skillItem.go, "bg", AudioEnum.UI.Play_UI_Activity_tips)

	skillItem.btn:AddClickListener(self.onClickSkillItem, self, skillItem)

	skillItem.skillIdList = {}

	gohelper.setActive(skillItem.go, true)
	table.insert(self.superSkillItemList, skillItem)

	return skillItem
end

function EnemyInfoRightView:recycleBuffTipItem()
	for _, buttTipItem in ipairs(self.buffTipItemList) do
		gohelper.setActive(buttTipItem.go, false)
	end

	self.useBuffTipCount = 0
end

function EnemyInfoRightView:getBuffTipItem()
	if self.useBuffTipCount < #self.buffTipItemList then
		self.useBuffTipCount = self.useBuffTipCount + 1

		local buffTipItem = self.buffTipItemList[self.useBuffTipCount]

		gohelper.setActive(buffTipItem.go, true)
		gohelper.setActive(buffTipItem.goline, true)

		return buffTipItem
	end

	self.useBuffTipCount = self.useBuffTipCount + 1

	local buffTipItem = self:getUserDataTb_()

	buffTipItem.go = gohelper.cloneInPlace(self._gobufftipitem)
	buffTipItem.bufficon = gohelper.findChildImage(buffTipItem.go, "title/simage_icon")
	buffTipItem.goline = gohelper.findChild(buffTipItem.go, "txt_desc/image_line")
	buffTipItem.name = gohelper.findChildText(buffTipItem.go, "title/txt_name")
	buffTipItem.desc = gohelper.findChildText(buffTipItem.go, "txt_desc")

	SkillHelper.addHyperLinkClick(buffTipItem.desc, self.onClickHyperLink, self)
	gohelper.setActive(buffTipItem.go, true)
	gohelper.setActive(buffTipItem.goline, true)
	table.insert(self.buffTipItemList, buffTipItem)

	return buffTipItem
end

function EnemyInfoRightView:onClickHyperLink(effectId, clickPosition)
	CommonBuffTipController:openCommonTipViewWithCustomPosCallback(tonumber(effectId), self.onSetScrollCallback, self)
end

function EnemyInfoRightView:onSetScrollCallback(rectTrViewGo, rectTrScroll)
	local width = recthelper.getWidth(rectTrScroll)

	rectTrScroll.pivot = CommonBuffTipEnum.Pivot.Left

	local anchorX = recthelper.getAnchorX(self.buffTipRectTr)
	local anchorY = recthelper.getAnchorY(self.buffTipRectTr)
	local defaultIntervalX = 10

	anchorX = anchorX - width - defaultIntervalX

	recthelper.setAnchor(rectTrScroll, anchorX, anchorY)
end

function EnemyInfoRightView:onClose()
	return
end

function EnemyInfoRightView:onDestroyView()
	self.bossSpecialClick:RemoveClickListener()

	for _, skillItem in ipairs(self.smallSkillItemList) do
		skillItem.btn:RemoveClickListener()
		skillItem.icon:UnLoadImage()
		skillItem.tag:UnLoadImage()
	end

	self.smallSkillItemList = nil

	for _, skillItem in ipairs(self.superSkillItemList) do
		skillItem.btn:RemoveClickListener()
		skillItem.icon:UnLoadImage()
		skillItem.tag:UnLoadImage()
	end

	self.superSkillItemList = nil

	for _, stageItem in ipairs(self.stageItemList) do
		stageItem.click:RemoveClickListener()
	end

	self.resistanceComp:destroy()

	self.resistanceComp = nil
	self.stageItemList = nil

	TaskDispatcher.cancelTask(self.refreshUI, self)
end

return EnemyInfoRightView
