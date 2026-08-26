-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191AssistantView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191AssistantView", package.seeall)

local Act191AssistantView = class("Act191AssistantView", BaseView)

function Act191AssistantView:onInitView()
	self._goAssistantItem = gohelper.findChild(self.viewGO, "root/left/scroll_enemy/Viewport/Content/#go_AssistantItem")
	self._simageBoss = gohelper.findChildSingleImage(self.viewGO, "root/left/boss/#simage_Boss")
	self._btnEquip = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/boss/#btn_Equip")
	self._goEquipped = gohelper.findChild(self.viewGO, "root/left/boss/#go_Equipped")
	self._txtName = gohelper.findChildText(self.viewGO, "root/right/Info/#txt_Name")
	self._imageCareer = gohelper.findChildImage(self.viewGO, "root/right/Info/#image_Career")
	self._txtTag = gohelper.findChildText(self.viewGO, "root/right/Info/base/scroll_tag/Viewport/Content/TagItem/#txt_Tag")
	self._imageTag = gohelper.findChildImage(self.viewGO, "root/right/Info/base/scroll_tag/Viewport/Content/TagItem/#txt_Tag/#image_Tag")
	self._goAttribute1 = gohelper.findChild(self.viewGO, "root/right/Info/Attribute/#go_Attribute1")
	self._txtAttack = gohelper.findChildText(self.viewGO, "root/right/Info/Attribute/#go_Attribute1/#txt_Attack")
	self._goAttribute2 = gohelper.findChild(self.viewGO, "root/right/Info/Attribute/#go_Attribute2")
	self._txtDef = gohelper.findChildText(self.viewGO, "root/right/Info/Attribute/#go_Attribute2/#txt_Def")
	self._goAttribute3 = gohelper.findChild(self.viewGO, "root/right/Info/Attribute/#go_Attribute3")
	self._txtTechnic = gohelper.findChildText(self.viewGO, "root/right/Info/Attribute/#go_Attribute3/#txt_Technic")
	self._goAttribute4 = gohelper.findChild(self.viewGO, "root/right/Info/Attribute/#go_Attribute4")
	self._txtHp = gohelper.findChildText(self.viewGO, "root/right/Info/Attribute/#go_Attribute4/#txt_Hp")
	self._goAttribute5 = gohelper.findChild(self.viewGO, "root/right/Info/Attribute/#go_Attribute5")
	self._txtMDef = gohelper.findChildText(self.viewGO, "root/right/Info/Attribute/#go_Attribute5/#txt_MDef")
	self._goPassiveSkill = gohelper.findChild(self.viewGO, "root/right/Info/#go_PassiveSkill")
	self._txtPassiveName = gohelper.findChildText(self.viewGO, "root/right/Info/#go_PassiveSkill/bg/#txt_PassiveName")
	self._btnPassiveSkill = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/Info/#go_PassiveSkill/#btn_PassiveSkill")
	self._goSkill = gohelper.findChild(self.viewGO, "root/right/Info/#go_Skill")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191AssistantView:addEvents()
	self._btnEquip:AddClickListener(self._btnEquipOnClick, self)
	self._btnPassiveSkill:AddClickListener(self._btnPassiveSkillOnClick, self)
end

function Act191AssistantView:removeEvents()
	self._btnEquip:RemoveClickListener()
	self._btnPassiveSkill:RemoveClickListener()
end

function Act191AssistantView:_btnEquipOnClick()
	self.equippedIndex = self.selectIndex

	self:refreshTabEquip()
	self:refreshEquipStatus()
end

function Act191AssistantView:_btnPassiveSkillOnClick()
	local config = self.summonCfgList[self.selectIndex]
	local passiveSkillCount = #self.passiveSkillIds

	for i = 1, passiveSkillCount do
		local passiveSkillId = tonumber(self.passiveSkillIds[i])
		local skillConfig = lua_skill.configDict[passiveSkillId]

		if skillConfig then
			local detailPassiveTable = self._detailPassiveTables[i]

			if not detailPassiveTable then
				local detailPassiveGO = gohelper.cloneInPlace(self.goDetailItem, "item" .. i)

				detailPassiveTable = self:getUserDataTb_()
				detailPassiveTable.go = detailPassiveGO
				detailPassiveTable.name = gohelper.findChildText(detailPassiveGO, "title/txt_name")
				detailPassiveTable.icon = gohelper.findChildSingleImage(detailPassiveGO, "title/simage_icon")
				detailPassiveTable.desc = gohelper.findChildText(detailPassiveGO, "txt_desc")

				SkillHelper.addHyperLinkClick(detailPassiveTable.desc, self.onClickHyperLink, self)

				detailPassiveTable.line = gohelper.findChild(detailPassiveGO, "txt_desc/image_line")

				table.insert(self._detailPassiveTables, detailPassiveTable)
			end

			detailPassiveTable.name.text = skillConfig.name
			detailPassiveTable.desc.text = SkillHelper.getSkillDesc(config.name, skillConfig)

			gohelper.setActive(detailPassiveTable.go, true)
			gohelper.setActive(detailPassiveTable.line, i < passiveSkillCount)
		else
			logError(string.format("被动技能配置没找到, id: %d", passiveSkillId))
		end
	end

	for i = passiveSkillCount + 1, #self._detailPassiveTables do
		gohelper.setActive(self._detailPassiveTables[i].go, false)
	end

	gohelper.setActive(self.goDetail, true)
end

function Act191AssistantView:_btnCloseDetailOnClick()
	gohelper.setActive(self.goDetail, false)
end

function Act191AssistantView:_editableInitView()
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.assistantItemList = {}
	self.attributeTexts = {}

	for i = 1, 5 do
		local go = gohelper.findChild(self._goAttribute, "attribute" .. i)

		self.attributeTexts[i] = gohelper.findChild(go, "num")
	end

	self._detailPassiveTables = {}
	self.goDetail = gohelper.findChild(self.viewGO, "root/right/go_DetailView")
	self.btnCloseDetail = gohelper.findChildButtonWithAudio(self.goDetail, "btn_DetailClose")
	self.goDetailItem = gohelper.findChild(self.goDetail, "scroll_content/viewport/content/go_detailpassiveitem")

	self.addClickCb(self, self.btnCloseDetail, self._btnCloseDetailOnClick, self)

	self.skillName = gohelper.findChild(self._goSkill, "skillcn")
	self.skillItemList = {}

	local skillRoot = gohelper.findChild(self._goSkill, "line/go_skills")

	for i = 1, 3 do
		local skillItem = self:getUserDataTb_()
		local go = gohelper.findChild(skillRoot, "skillicon" .. tostring(i))

		skillItem.go = go
		skillItem.icon = gohelper.findChildSingleImage(go, "imgIcon")
		skillItem.tag = gohelper.findChildSingleImage(go, "tag/tagIcon")

		local btn = gohelper.findChildButtonWithAudio(go, "bg", AudioEnum.UI.Play_ui_role_description)

		self.addClickCb(self, btn, self._onSkillCardClick, self, i)

		self.skillItemList[i] = skillItem
	end
end

function Act191AssistantView:onOpen()
	self.summonCfgList = {}

	for k, v in ipairs(self.viewParam) do
		self.summonCfgList[k] = lua_activity191_summon.configDict[v]
	end

	self:initAssistantItem()
	self:_btnTabItemOnClick(1, true)
	self:_btnEquipOnClick()
end

function Act191AssistantView:onDestroyView()
	TaskDispatcher.cancelTask(self.delaySwitch, self)
end

function Act191AssistantView:initAssistantItem()
	for i = 1, #self.summonCfgList do
		local config = self.summonCfgList[i]
		local go = gohelper.cloneInPlace(self._goAssistantItem)
		local item = self:getUserDataTb_()

		item.index = i
		item.goNormal = gohelper.findChild(go, "normal")
		item.goEquipped = gohelper.findChild(go, "equipped")
		item.goSelect = gohelper.findChild(go, "select")

		local icon = gohelper.findChildSingleImage(go, "icon")

		icon:LoadImage(ResUrl.monsterHeadIcon(config.headIcon))

		local career = gohelper.findChildImage(go, "career")

		UISpriteSetMgr.instance:setEnemyInfoSprite(career, "sxy_" .. config.career)

		item.goNew = gohelper.findChild(go, "new")

		local btnClick = gohelper.findChildButtonWithAudio(go, "click")

		item.config = config

		self.addClickCb(self, btnClick, self._btnTabItemOnClick, self, i)

		self.assistantItemList[i] = item
	end

	gohelper.setActive(self._goAssistantItem, false)
end

function Act191AssistantView:_btnTabItemOnClick(index, manually)
	if self.selectIndex == index then
		return
	end

	self.selectIndex = index

	if manually then
		self:delaySwitch()
	else
		self.anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(self.delaySwitch, self, 0.16)
	end
end

function Act191AssistantView:delaySwitch()
	self:refreshTabSelect()
	self:refreshEquipStatus()
	self:refreshAssistantInfo()
end

function Act191AssistantView:refreshTabSelect()
	for k, item in ipairs(self.assistantItemList) do
		gohelper.setActive(item.goNormal, k ~= self.selectIndex)
		gohelper.setActive(item.goSelect, k == self.selectIndex)
	end
end

function Act191AssistantView:refreshTabEquip()
	for k, item in ipairs(self.assistantItemList) do
		gohelper.setActive(item.goEquipped, k == self.equippedIndex)
	end
end

function Act191AssistantView:refreshEquipStatus()
	gohelper.setActive(self._btnEquip, false)
	gohelper.setActive(self._goEquipped, true)
end

function Act191AssistantView:refreshAssistantInfo()
	self.skillIds = {}

	local config = self.summonCfgList[self.selectIndex]

	self._txtName.text = config.name

	local relationCo = Activity191Config.instance:getRelationCo(config.relation)

	self._txtTag.text = relationCo.name

	Activity191Helper.setFetterIcon(self._imageTag, relationCo.icon)
	self._simageBoss:LoadImage(ResUrl.getAct191SingleBg(string.format("boss/%s", config.icon)))
	UISpriteSetMgr.instance:setCommonSprite(self._imageCareer, "lssx_" .. config.career)

	if config.summonType == Activity191Enum.SummonType.Boss then
		local bossCo = lua_activity191_assist_boss.configDict[config.id]

		self.passiveSkillIds = string.splitToNumber(bossCo.passiveSkills, "|")
		self.skillIds[1] = tonumber(bossCo.activeSkill1)
		self.skillIds[2] = tonumber(bossCo.activeSkill2)
		self.skillIds[3] = tonumber(bossCo.uniqueSkill)

		local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
		local a, t = gameInfo:getBossAttr()

		self._txtAttack.text = a
		self._txtTechnic.text = t

		gohelper.setActive(self._goAttribute2, false)
		gohelper.setActive(self._goAttribute4, false)
		gohelper.setActive(self._goAttribute5, false)
	elseif config.summonType == Activity191Enum.SummonType.Monster then
		local monsterCo = lua_monster.configDict[config.monsterId]
		local templateCo = lua_monster_template.configDict[monsterCo.template]
		local skillTemplateCo = lua_monster_skill_template.configDict[monsterCo.skillTemplate]

		self.passiveSkillIds = string.splitToNumber(skillTemplateCo.passiveSkill, "|")
		self.skillIds[1] = tonumber(skillTemplateCo.activeSkill)
		self.skillIds[3] = tonumber(skillTemplateCo.uniqueSkill)
		self._txtAttack.text = templateCo.attack
		self._txtHp.text = templateCo.life
		self._txtDef.text = templateCo.defense
		self._txtMDef.text = templateCo.mdefense
		self._txtTechnic.text = templateCo.technic

		gohelper.setActive(self._goAttribute2, true)
		gohelper.setActive(self._goAttribute4, true)
		gohelper.setActive(self._goAttribute5, true)
	end

	if next(self.passiveSkillIds) then
		local passiveSkillCo = lua_skill.configDict[self.passiveSkillIds[1]]

		if passiveSkillCo then
			self._txtPassiveName.text = passiveSkillCo.name
		end

		gohelper.setActive(self._goPassiveSkill, true)
	else
		gohelper.setActive(self._goPassiveSkill, false)
	end

	for i = 1, 3 do
		local skillItem = self.skillItemList[i]
		local skillId = self.skillIds[i]

		if skillId and skillId ~= 0 then
			local skillCfg = lua_skill.configDict[skillId]

			if skillCfg then
				skillItem.icon:LoadImage(ResUrl.getSkillIcon(skillCfg.icon))
				skillItem.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillCfg.showTag))
			else
				logError(string.format("skillId not found : %s", skillId))
			end
		end

		gohelper.setActive(skillItem.go, skillId and skillId ~= 0)
	end
end

function Act191AssistantView:_onSkillCardClick(index)
	local config = self.summonCfgList[self.selectIndex]
	local info = {}

	info.super = index == 3
	info.skillIndex = index
	info.skillIdList = {
		self.skillIds[index]
	}
	info.monsterName = config.name
	info.isDeviceSkill = true

	ViewMgr.instance:openView(ViewName.SkillTipView, info)
end

function Act191AssistantView:onClickHyperLink(effectId)
	local pos = Vector2.New(40, 0)

	CommonBuffTipController:openCommonTipViewWithCustomPos(effectId, pos)
end

return Act191AssistantView
