-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3EnemyView.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3EnemyView", package.seeall)

local Season123_2_3EnemyView = class("Season123_2_3EnemyView", BaseView)

function Season123_2_3EnemyView:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "#simage_rightbg")
	self._goenemygroupitem = gohelper.findChild(self.viewGO, "#scroll_enemy/viewport/content/#go_enemygroupitem")
	self._simageicon = gohelper.findChildImage(self.viewGO, "enemyinfo/#simage_icon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "enemyinfo/#image_career")
	self._txtlevel = gohelper.findChildText(self.viewGO, "enemyinfo/#txt_level")
	self._txtname = gohelper.findChildText(self.viewGO, "enemyinfo/#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "enemyinfo/#txt_nameen")
	self._txthp = gohelper.findChildText(self.viewGO, "enemyinfo/#txt_hp")
	self._godescscrollview = gohelper.findChild(self.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_descscrollview")
	self._txtdesc = gohelper.findChildText(self.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_descscrollview/#txt_desc")
	self._goattribute = gohelper.findChild(self.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_attribute")
	self._gopassiveskill = gohelper.findChild(self.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_passiveskill")
	self._gopassiveskillitem = gohelper.findChild(self.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_passiveskill/passiveSkills/item")
	self._btnpassiveskill = gohelper.findChildButtonWithAudio(self.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_passiveskill/passiveSkills/btn_passiveclick")
	self._btnshowattribute = gohelper.findChildButton(self.viewGO, "enemyinfo/#btn_showAttribute")
	self._gonormalicon = gohelper.findChild(self.viewGO, "enemyinfo/#btn_showAttribute/#go_normalIcon")
	self._goselecticon = gohelper.findChild(self.viewGO, "enemyinfo/#btn_showAttribute/#go_selectIcon")
	self._goenemypassiveitem = gohelper.findChild(self.viewGO, "enemyinfo/#go_desccontainer/Viewport/#go_desccontainer/#go_monster_desccontainer/#go_enemypassiveitem")
	self._gonoskill = gohelper.findChild(self.viewGO, "enemyinfo/noskill")
	self._goskill = gohelper.findChild(self.viewGO, "enemyinfo/skill")
	self._goskillitem = gohelper.findChild(self.viewGO, "enemyinfo/skill/card/scrollview/viewport/content/skills/#go_skillitem")
	self._gosuperitem = gohelper.findChild(self.viewGO, "enemyinfo/skill/card/scrollview/viewport/content/supers/#go_superitem")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._scrollskill = gohelper.findChildScrollRect(self.viewGO, "enemyinfo/skill/card/scrollview")
	self._gocareercontent = gohelper.findChild(self.viewGO, "careerContent/#go_careercontent")
	self._gobuffpassiveview = gohelper.findChild(self.viewGO, "enemyinfo/#go_buffpassiveview")
	self._btnclosepassiveview = gohelper.findChildButton(self.viewGO, "enemyinfo/#go_buffpassiveview/#btn_closeview")
	self._gobuffpassiveitem = gohelper.findChild(self.viewGO, "enemyinfo/#go_buffpassiveview/#scroll_buff/viewport/content/#go_buffitem")
	self.bossSkillInfos = {}
	self.isopenpassiveview = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_3EnemyView:addEvents()
	self._btnshowattribute:AddClickListener(self._onClickShowAttribute, self)
	self._btnclosepassiveview:AddClickListener(self._onClickClosePassiveView, self)
end

function Season123_2_3EnemyView:removeEvents()
	self._btnshowattribute:RemoveClickListener()
	self._btnpassiveskill:RemoveClickListener()
	self._btnclosepassiveview:RemoveClickListener()
end

function Season123_2_3EnemyView:_editableInitView()
	gohelper.addUIClickAudio(self._btnshowattribute.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)

	self._imageSelectEnemy = gohelper.findChildImage(self.viewGO, "enemyinfo/#simage_icon")
	self._gosupers = gohelper.findChild(self.viewGO, "enemyinfo/skill/card/scrollview/viewport/content/supers")

	self._simagerightbg:LoadImage(ResUrl.getDungeonIcon("bg_battledetail"))

	self._enemyGroupItemGOs = {}
	self._passiveSkillGOs = {}
	self._skillGOs = {}
	self._superItemList = {}
	self._specialskillIconGOs = self:getUserDataTb_()
	self._enemybuffpassiveGOs = self:getUserDataTb_()
	self._passiveSkillImgs = self:getUserDataTb_()
	self._passiveiconImgs = self:getUserDataTb_()
	self._isShowAttributeInfo = false

	gohelper.setActive(self._goenemygroupitem, false)
	gohelper.setActive(self._goenemypassiveitem, false)
	gohelper.setActive(self._goskillitem, false)
	gohelper.setActive(self._gosuperitem, false)
	gohelper.setActive(self._gonormalicon, not self._isShowAttributeInfo)
	gohelper.setActive(self._godescscrollview, not self._isShowAttributeInfo)
	gohelper.setActive(self._goselecticon, self._isShowAttributeInfo)
	gohelper.setActive(self._goattribute, self._isShowAttributeInfo)

	for i = 1, 6 do
		local career = gohelper.findChildImage(self._gocareercontent, "career" .. i)

		UISpriteSetMgr.instance:setCommonSprite(career, "lssx_" .. i)
	end

	self.scrollDescContainer = gohelper.findChildScrollRect(self.viewGO, "enemyinfo/#go_desccontainer")
end

function Season123_2_3EnemyView:onDestroyView()
	self._simagerightbg:UnLoadImage()

	self._simagerightbg = nil

	if self._enemyGroupItemGOs then
		for i = 1, #self._enemyGroupItemGOs do
			local itemGroup = self._enemyGroupItemGOs[i]

			if itemGroup.enemyItems then
				for j = 1, #itemGroup.enemyItems do
					local itemEnemy = itemGroup.enemyItems[j]

					itemEnemy.btn:RemoveClickListener()
				end
			end
		end
	end

	if self._skillGOs then
		for i = 1, #self._skillGOs do
			local skillTable = self._skillGOs[i]

			skillTable.tag:UnLoadImage()
			skillTable.icon:UnLoadImage()
			skillTable.btn:RemoveClickListener()
		end
	end

	for _, superItem in ipairs(self._superItemList) do
		superItem.btn:RemoveClickListener()
	end

	Season123EnemyController.instance:onCloseView()
end

function Season123_2_3EnemyView:onOpen()
	self.addEventCb(self, Season123Controller.instance, Season123Event.EnemyDetailSwitchTab, self.refreshUI, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.EnemyDetailSelectEnemy, self.handleClickMonster, self)
	Season123EnemyController.instance:onOpenView(self.viewParam.actId, self.viewParam.stage, self.viewParam.layer)
	self:refreshUI()
end

function Season123_2_3EnemyView:onClose()
	self.removeEventCb(self, Season123Controller.instance, Season123Event.EnemyDetailSwitchTab, self.refreshUI, self)
	self.removeEventCb(self, Season123Controller.instance, Season123Event.EnemyDetailSelectEnemy, self.handleClickMonster, self)
end

function Season123_2_3EnemyView:handleClickMonster()
	self:refreshMonsterSelect()
	self:refreshEnemyInfo()
end

function Season123_2_3EnemyView:_onClickClosePassiveView()
	gohelper.setActive(self._gobuffpassiveview, false)

	self.isopenpassiveview = false
end

function Season123_2_3EnemyView:refreshUI()
	local monsterGroupIds = Season123EnemyModel.instance:getCurrentBattleGroupIds()

	self._enemyItemIndex = 1

	local len = #monsterGroupIds

	for i = 1, len do
		local itemGroup = self:getOrCreateGroupItem(i)

		self:refreshEnemyGroup(i, monsterGroupIds, itemGroup)
		gohelper.setActive(itemGroup.go, true)
	end

	for i = len + 1, #self._enemyGroupItemGOs do
		gohelper.setActive(self._enemyGroupItemGOs[i].go, false)
	end
end

function Season123_2_3EnemyView:getOrCreateGroupItem(i)
	local item = self._enemyGroupItemGOs[i]

	if not item then
		local enemyGroupItemGO = gohelper.cloneInPlace(self._goenemygroupitem, "item" .. i)

		item = self:getUserDataTb_()
		item.go = enemyGroupItemGO
		item.txttitlenum = gohelper.findChildText(enemyGroupItemGO, "#txt_titlenum")
		item.goenemyitem = gohelper.findChild(enemyGroupItemGO, "content/enemyitem")
		item.enemyItems = {}

		gohelper.setActive(item.goenemyitem, false)

		self._enemyGroupItemGOs[i] = item
		item.txttitlenum.text = tostring(i)
	end

	return item
end

function Season123_2_3EnemyView:refreshEnemyGroup(i, monsterGroupIds, enemyGroupItemTable)
	local isBoss = false
	local monsterGroupId = monsterGroupIds[i]
	local monsterIds = Season123EnemyModel.instance:getMonsterIds(monsterGroupId)
	local len = #monsterIds

	for j = 1, len do
		local monsterId = tonumber(monsterIds[j])
		local itemMonster = self:getOrCreateEnemyItem(enemyGroupItemTable, i, j)

		itemMonster.monsterId = monsterId

		local monsterConfig = lua_monster.configDict[monsterId]
		local skinConfig = FightConfig.instance:getSkinCO(monsterConfig.skinId)

		self:refreshEnemyItem(itemMonster, monsterId, i, j)
		gohelper.setActive(itemMonster.go, true)

		local monsterGroupConfig = lua_monster_group.configDict[monsterGroupId]

		if not isBoss and monsterGroupConfig and FightHelper.isBossId(monsterGroupConfig.bossId, monsterId) then
			isBoss = true

			gohelper.setActive(itemMonster.bosstag, true)
		else
			gohelper.setActive(itemMonster.bosstag, false)
		end

		self._enemyItemIndex = self._enemyItemIndex + 1
	end

	for j = len + 1, #enemyGroupItemTable.enemyItems do
		gohelper.setActive(enemyGroupItemTable.enemyItems[j].go, false)
	end
end

function Season123_2_3EnemyView:getOrCreateEnemyItem(itemGroup, groupIndex, itemIndex)
	local item = itemGroup.enemyItems[itemIndex]

	if not item then
		local itemGO = gohelper.cloneInPlace(itemGroup.goenemyitem, "item" .. tostring(itemIndex))

		item = self:getUserDataTb_()
		item.go = itemGO
		item.iconframe = gohelper.findChildImage(itemGO, "iconframe")
		item.icon = gohelper.findChildImage(itemGO, "icon")
		item.career = gohelper.findChildImage(itemGO, "career")
		item.selectframe = gohelper.findChild(itemGO, "selectframe")
		item.bosstag = gohelper.findChild(itemGO, "bosstag")
		item.btn = gohelper.findChildButtonWithAudio(itemGO, "btn_click", AudioEnum.UI.Play_UI_Tags)

		local clickInfo = {
			index = itemIndex,
			groupIndex = groupIndex
		}

		item.btn:AddClickListener(self.onClickMonsterIcon, self, clickInfo)

		itemGroup.enemyItems[itemIndex] = item
	end

	return item
end

function Season123_2_3EnemyView:onClickMonsterIcon(clickInfo)
	local groupIndex = clickInfo.groupIndex
	local itemIndex = clickInfo.index

	Season123EnemyController.instance:selectMonster(groupIndex, itemIndex)
end

function Season123_2_3EnemyView:refreshEnemyItem(enemyItemTable, monsterId, groupIndex)
	local monsterConfig = lua_monster.configDict[monsterId]
	local skinConfig = FightConfig.instance:getSkinCO(monsterConfig.skinId)

	gohelper.setActive(enemyItemTable.selectframe, monsterId == Season123EnemyModel.instance.selectMonsterId)

	enemyItemTable.index = self._enemyItemIndex
	enemyItemTable.groupIndex = groupIndex
	enemyItemTable.monsterId = monsterId

	gohelper.getSingleImage(enemyItemTable.icon.gameObject):LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))
	UISpriteSetMgr.instance:setEnemyInfoSprite(enemyItemTable.career, "sxy_" .. tostring(monsterConfig.career))

	if monsterConfig.heartVariantId ~= 0 then
		IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(monsterConfig.heartVariantId), enemyItemTable.icon)
	end
end

function Season123_2_3EnemyView:refreshMonsterSelect()
	local monsterGroupIds = Season123EnemyModel.instance:getCurrentBattleGroupIds()
	local selectMonsterId = Season123EnemyModel.instance.selectMonsterId

	for i, itemGroup in pairs(self._enemyGroupItemGOs) do
		local groupId = monsterGroupIds[i]

		if groupId then
			local monsterIds = Season123EnemyModel.instance:getMonsterIds(groupId)

			for monsterIndex, item in pairs(itemGroup.enemyItems) do
				local monsterId = monsterIds[monsterIndex]

				if monsterId then
					gohelper.setActive(item.selectframe, selectMonsterId == monsterId)
				end
			end
		end
	end
end

function Season123_2_3EnemyView:refreshEnemyInfo()
	local monsterId = Season123EnemyModel.instance.selectMonsterId
	local groupIndex = Season123EnemyModel.instance.selectMonsterGroupIndex
	local monsterConfig = lua_monster.configDict[monsterId]
	local skinConfig = FightConfig.instance:getSkinCO(monsterConfig.skinId)

	gohelper.getSingleImage(self._simageicon.gameObject):LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))

	if monsterConfig.heartVariantId ~= 0 then
		IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(monsterConfig.heartVariantId), self._imageSelectEnemy)
	end

	UISpriteSetMgr.instance:setEnemyInfoSprite(self._imagecareer, "sxy_" .. tostring(monsterConfig.career))

	self._txtlevel.text = HeroConfig.instance:getCommonLevelDisplay(monsterConfig.level)

	local isUseNewConfig = FightConfig.instance:getNewMonsterConfig(monsterConfig)

	if isUseNewConfig then
		self._txtname.text = monsterConfig.highPriorityName or monsterConfig.name
	end

	if isUseNewConfig then
		self._txtnameen.text = monsterConfig.highPriorityNameEng or monsterConfig.nameEng
	end

	self._txthp.text = string.format(luaLang("maxhp"), CharacterDataConfig.instance:getMonsterHp(monsterId))

	if isUseNewConfig then
		self._txtdesc.text = monsterConfig.highPriorityDes or monsterConfig.des
	end

	self.bossSkillInfos = {}

	local bossId = Season123EnemyModel.instance:getBossId(groupIndex)

	if bossId and FightHelper.isBossId(bossId, monsterConfig.id) then
		self:_refreshSpeicalSkillIcon(monsterConfig)
	else
		gohelper.setActive(self._gopassiveskill, false)
	end

	self:_refreshPassiveSkill(monsterConfig, groupIndex)
	self:_refreshSkill(monsterConfig)
	self:_refreshSuper(monsterConfig)
	self:_refreshAttribute(monsterConfig)

	self._scrollskill.horizontalNormalizedPosition = 0

	local notSmallSkill = string.nilorempty(monsterConfig.activeSkill)
	local notUniqueSkill = #monsterConfig.uniqueSkill < 1
	local IsNotSkill = notSmallSkill and notUniqueSkill

	gohelper.setActive(self._gonoskill, IsNotSkill)
	gohelper.setActive(self._goskill, not IsNotSkill)
end

function Season123_2_3EnemyView:_refreshSpeicalSkillIcon(monsterConfig)
	local skills = FightConfig.instance:getPassiveSkillsAfterUIFilter(monsterConfig.id)

	skills = FightConfig.instance:_filterSpeicalSkillIds(skills, true)

	for i = 1, #skills do
		local skillId = skills[i]
		local specialco = lua_skill_specialbuff.configDict[skillId]

		if specialco then
			local specialSkillTable = self._specialskillIconGOs[i]

			if not specialSkillTable then
				specialSkillTable = self:getUserDataTb_()
				specialSkillTable.go = gohelper.cloneInPlace(self._gopassiveskillitem, "item" .. i)
				specialSkillTable._gotag = gohelper.findChild(specialSkillTable.go, "tag")
				specialSkillTable._txttag = gohelper.findChildText(specialSkillTable.go, "tag/#txt_tag")

				table.insert(self._specialskillIconGOs, specialSkillTable)

				local img = gohelper.findChildImage(specialSkillTable.go, "icon")

				table.insert(self._passiveiconImgs, img)
				gohelper.setActive(specialSkillTable.go, true)
			else
				gohelper.setActive(specialSkillTable.go, true)
			end

			if not string.nilorempty(specialco.lv) then
				gohelper.setActive(specialSkillTable._gotag, true)

				specialSkillTable._txttag.text = specialco.lv
			else
				gohelper.setActive(specialSkillTable._gotag, false)
			end

			local info = self.bossSkillInfos[i]

			if info == nil then
				self.bossSkillInfos[i] = {
					skillId = skillId,
					icon = specialco.icon
				}
			end

			if string.nilorempty(specialco.icon) then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. specialco.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(self._passiveiconImgs[i], specialco.icon)
		end
	end

	if #skills < #self._specialskillIconGOs then
		for i = #skills + 1, #self._specialskillIconGOs do
			gohelper.setActive(self._specialskillIconGOs[i].go, false)
		end
	end

	if #self._specialskillIconGOs > 0 then
		gohelper.setActive(self._gopassiveskill, true)
	end

	gohelper.setAsLastSibling(self._btnpassiveskill.gameObject)
	self._btnpassiveskill:AddClickListener(self._onBuffPassiveSkillClick, self)
end

function Season123_2_3EnemyView:_onBuffPassiveSkillClick()
	if self.bossSkillInfos then
		local skillId

		for i, skillInfo in pairs(self.bossSkillInfos) do
			skillId = skillInfo.skillId

			local passiveSkillGO = self._enemybuffpassiveGOs[i]

			if not passiveSkillGO then
				passiveSkillGO = gohelper.cloneInPlace(self._gobuffpassiveitem, "item" .. i)

				table.insert(self._enemybuffpassiveGOs, passiveSkillGO)

				local img = gohelper.findChildImage(passiveSkillGO, "title/simage_icon")

				table.insert(self._passiveSkillImgs, img)
				gohelper.setActive(passiveSkillGO, true)
			else
				gohelper.setActive(passiveSkillGO, true)
			end

			local line = gohelper.findChild(passiveSkillGO, "txt_desc/image_line")

			gohelper.setActive(line, true)
			self:_setPassiveSkillTip(passiveSkillGO, skillInfo)
			UISpriteSetMgr.instance:setFightPassiveSprite(self._passiveSkillImgs[i], skillInfo.icon)
		end

		if #self.bossSkillInfos < #self._enemybuffpassiveGOs then
			for i = #self.bossSkillInfos + 1, #self._enemybuffpassiveGOs do
				gohelper.setActive(self._enemybuffpassiveGOs[i], false)
			end
		end

		local line = gohelper.findChild(self._enemybuffpassiveGOs[#self.bossSkillInfos], "txt_desc/image_line")

		gohelper.setActive(line, false)
		gohelper.setActive(self._gobuffpassiveview, true)

		self.isopenpassiveview = false
	end
end

function Season123_2_3EnemyView:_setPassiveSkillTip(skillgo, skillInfo)
	local name = gohelper.findChildText(skillgo, "title/txt_name")
	local desc = gohelper.findChildText(skillgo, "txt_desc")
	local skillCO = lua_skill.configDict[skillInfo.skillId]

	name.text = skillCO.name
	desc.text = HeroSkillModel.instance:skillDesToSpot(skillCO.desc, "#CC492F", "#485E92")
end

function Season123_2_3EnemyView:_refreshPassiveSkill(monsterConfig, groupIndex)
	local passiveSkillIds = FightConfig.instance:getPassiveSkillsAfterUIFilter(monsterConfig.id)

	if FightHelper.isBossId(Season123EnemyModel.instance:getBossId(groupIndex), monsterConfig.id) then
		passiveSkillIds = FightConfig.instance:_filterSpeicalSkillIds(passiveSkillIds, false)
	end

	if passiveSkillIds and #passiveSkillIds > 0 then
		local tagNameExistDict = {}

		for i = 1, #passiveSkillIds do
			local passiveSkillTable = self._passiveSkillGOs[i]

			if not passiveSkillTable then
				local passiveSkillGO = gohelper.cloneInPlace(self._goenemypassiveitem, "item" .. i)

				passiveSkillTable = self:getUserDataTb_()
				passiveSkillTable.go = passiveSkillGO
				passiveSkillTable.name = gohelper.findChildText(passiveSkillGO, "bg/bg/name")
				passiveSkillTable.desc = gohelper.findChildText(passiveSkillGO, "desc")
				passiveSkillTable.descicon = gohelper.findChild(passiveSkillGO, "desc/icon")
				passiveSkillTable.detailPassiveStateTables = self:getUserDataTb_()

				table.insert(self._passiveSkillGOs, passiveSkillTable)
			end

			local passiveSkillId = tonumber(passiveSkillIds[i])
			local skillConfig = lua_skill.configDict[passiveSkillId]

			if not skillConfig then
				logError("找不到技能配置, id: " .. tostring(passiveSkillId))
			end

			passiveSkillTable.name.text = skillConfig.name

			local txt = skillConfig.desc
			local matches = HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(txt)
			local showCount = 0

			for k = 1, #matches do
				local name = SkillConfig.instance:getSkillEffectDescCo(matches[k]).name
				local canShowSkillTag = HeroSkillModel.instance:canShowSkillTag(name)

				if canShowSkillTag and not tagNameExistDict[name] then
					showCount = showCount + 1
					tagNameExistDict[name] = true

					local desc = SkillConfig.instance:getSkillEffectDescCo(matches[k]).desc
					local detailPassiveState = passiveSkillTable.detailPassiveStateTables[showCount]

					if not detailPassiveState then
						local detailPassiveStateGO = gohelper.cloneInPlace(passiveSkillTable.desc.gameObject, "state")

						detailPassiveState = self:getUserDataTb_()
						detailPassiveState.go = detailPassiveStateGO
						detailPassiveState.desc = detailPassiveStateGO:GetComponent(gohelper.Type_TextMesh)

						gohelper.setActive(detailPassiveState.go, false)

						detailPassiveState.desc.text = ""
						passiveSkillTable.detailPassiveStateTables[showCount] = detailPassiveState
					end

					gohelper.setActive(detailPassiveState.go, true)

					detailPassiveState.desc.text = HeroSkillModel.instance:skillDesToSpot(string.format("[%s]:%s", SkillConfig.instance:processSkillDesKeyWords(name), SkillConfig.instance:processSkillDesKeyWords(desc)))
				end
			end

			for k = showCount + 1, #passiveSkillTable.detailPassiveStateTables do
				if passiveSkillTable.detailPassiveStateTables[k] then
					gohelper.setActive(passiveSkillTable.detailPassiveStateTables[k].go, false)
				end
			end

			passiveSkillTable.desc.text = HeroSkillModel.instance:skillDesToSpot(txt)

			gohelper.setActive(passiveSkillTable.descicon, not string.nilorempty(passiveSkillTable.desc.text))
			gohelper.setActive(passiveSkillTable.go, true)
		end
	end

	for i = #passiveSkillIds + 1, #self._passiveSkillGOs do
		gohelper.setActive(self._passiveSkillGOs[i].go, false)
	end
end

function Season123_2_3EnemyView:_refreshSkill(monsterConfig)
	local skillIds = {}

	if not string.nilorempty(monsterConfig.activeSkill) then
		skillIds = string.split(monsterConfig.activeSkill, "|")

		for i = 1, #skillIds do
			local skillTable = self._skillGOs[i]

			if not skillTable then
				local skillGO = gohelper.cloneInPlace(self._goskillitem, "item" .. i)

				skillTable = self:getUserDataTb_()
				skillTable.go = skillGO
				skillTable.icon = gohelper.findChildSingleImage(skillGO, "imgIcon")
				skillTable.btn = gohelper.findChildButtonWithAudio(skillGO, "bg", AudioEnum.UI.Play_UI_Activity_tips)

				skillTable.btn:AddClickListener(function(skillTable)
					ViewMgr.instance:openView(ViewName.SkillTipView3, skillTable.info)
				end, skillTable)

				skillTable.tag = gohelper.findChildSingleImage(skillGO, "tag/tagIcon")

				table.insert(self._skillGOs, skillTable)
			end

			local skillIdList = string.splitToNumber(skillIds[i], "#")
			local skillId = skillIdList[2]
			local skillConfig = lua_skill.configDict[skillId]

			skillTable.icon:LoadImage(ResUrl.getSkillIcon(skillConfig.icon))
			skillTable.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillConfig.showTag))

			local info = {}

			info.super = false

			table.remove(skillIdList, 1)

			info.skillIdList = skillIdList
			skillTable.info = info

			gohelper.setActive(skillTable.go, true)
		end
	end

	for i = #skillIds + 1, #self._skillGOs do
		gohelper.setActive(self._skillGOs[i].go, false)
	end
end

function Season123_2_3EnemyView:_refreshSuper(monsterConfig)
	local uniqueSkillList = monsterConfig.uniqueSkill
	local superItem, skillId, skillConfig, info

	for i = 1, #uniqueSkillList do
		superItem = self._superItemList[i]

		if not self._superItemList[i] then
			superItem = self:createSuperItem()

			table.insert(self._superItemList, superItem)
		end

		skillId = uniqueSkillList[i]

		superItem.icon:LoadImage(ResUrl.getSkillIcon(lua_skill.configDict[uniqueSkillList[i]].icon))
		superItem.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. lua_skill.configDict[uniqueSkillList[i]].showTag))

		info = {}
		info.super = true
		info.skillIdList = {
			skillId
		}
		superItem.info = info

		gohelper.setActive(superItem.go, true)
	end

	gohelper.setActive(self._gosupers, #uniqueSkillList > 0)

	for i = #uniqueSkillList + 1, #self._superItemList do
		gohelper.setActive(self._superItemList[i].go, false)
	end
end

function Season123_2_3EnemyView:createSuperItem()
	local superItem = self:getUserDataTb_()

	superItem.go = gohelper.cloneInPlace(self._gosuperitem)
	superItem.icon = gohelper.findChildSingleImage(superItem.go, "imgIcon")
	superItem.tag = gohelper.findChildSingleImage(superItem.go, "tag/tagIcon")
	superItem.btn = gohelper.findChildButtonWithAudio(superItem.go, "bg", AudioEnum.UI.Play_UI_Activity_tips)

	superItem.btn:AddClickListener(function(item)
		ViewMgr.instance:openView(ViewName.SkillTipView3, item.info)
	end, superItem)

	return superItem
end

function Season123_2_3EnemyView:_refreshAttribute(monsterConfig)
	local attrTab = CharacterDataConfig.instance:getMonsterAttributeScoreList(monsterConfig.id)

	table.insert(attrTab, 2, table.remove(attrTab, 4))

	local attrType = {
		"atk",
		"technic",
		"def",
		"mdef"
	}
	local data = {}

	for i, v in ipairs(attrTab) do
		table.insert(data, {
			id = HeroConfig.instance:getIDByAttrType(attrType[i]),
			value = v
		})
	end

	gohelper.CreateObjList(self, self._onMonsterAttrItemShow, data, self._goattribute)
end

function Season123_2_3EnemyView:_onMonsterAttrItemShow(obj, data, index)
	local transform = obj.transform
	local icon = transform:Find("icon"):GetComponent(gohelper.Type_Image)
	local name = transform:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local rate = transform:Find("rate"):GetComponent(gohelper.Type_Image)
	local config = HeroConfig.instance:getHeroAttributeCO(data.id)

	name.text = config.name

	UISpriteSetMgr.instance:setCommonSprite(icon, "icon_att_" .. config.id)
	UISpriteSetMgr.instance:setCommonSprite(rate, "sx_" .. data.value, true)
end

function Season123_2_3EnemyView:_onClickShowAttribute()
	self._isShowAttributeInfo = not self._isShowAttributeInfo

	gohelper.setActive(self._gonormalicon, not self._isShowAttributeInfo)
	gohelper.setActive(self._godescscrollview, not self._isShowAttributeInfo)
	gohelper.setActive(self._goselecticon, self._isShowAttributeInfo)
	gohelper.setActive(self._goattribute, self._isShowAttributeInfo)

	self.scrollDescContainer.verticalNormalizedPosition = 1
end

return Season123_2_3EnemyView
