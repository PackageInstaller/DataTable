-- chunkname: @modules/logic/season/view1_6/Season1_6HeroGroupFightViewRule.lua

module("modules.logic.season.view1_6.Season1_6HeroGroupFightViewRule", package.seeall)

local Season1_6HeroGroupFightViewRule = class("Season1_6HeroGroupFightViewRule", BaseView)

function Season1_6HeroGroupFightViewRule:onInitView()
	self._gorules = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_rules")
	self._goimagenormal = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_rules/title/text/#image_normalicondition")
	self._goimagerare = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_rules/title/text/#image_rarecondition")
	self._goruleitem = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_rules/rulelist/#go_ruleitem")
	self._gonormal = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_rules/rulelist/#go_ruleitem/image_normal")
	self._gorare = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_rules/rulelist/#go_ruleitem/image_rare")
	self._txtruleinfo = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/#go_rules/rulelist/#go_ruleitem/txt_ruleinfo")
	self._goadditionRule = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule")
	self._goruletemp = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp")
	self._imagetagicon = gohelper.findChildImage(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp/#image_tagicon")
	self._gorulelist = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist")
	self._btnadditionRuleclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	self._gocontainer2 = gohelper.findChild(self.viewGO, "#go_container2")
	self._goruledesc = gohelper.findChild(self.viewGO, "#go_container2/#go_ruledesc")
	self._btncloserule = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container2/#go_ruledesc/#btn_closerule")
	self._goruleitem2 = gohelper.findChild(self.viewGO, "#go_container2/#go_ruledesc/bg/#go_ruleitem")
	self._goruleDescList = gohelper.findChild(self.viewGO, "#go_container2/#go_ruledesc/bg/#go_ruleDescList")
	self._btnenemy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemytitle/txten/#btn_enemy")
	self._enemylist = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")
	self._txtrecommendlevel = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	self._goenemyteam = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam")
	self._gorecommendattr = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	self._txtrecommonddes = gohelper.findChildTextMesh(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")
	self._btnadditionruledetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_additionruletips/tips/#btn_additionruledetail")
	self._goTask = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_task")
	self._txtTask = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/#go_task/#go_taskitem/#txt_task")

	gohelper.setActive(self._goTask, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_6HeroGroupFightViewRule:addEvents()
	self._btnadditionRuleclick:AddClickListener(self._btnadditionRuleOnClick, self)
	self._btncloserule:AddClickListener(self._btncloseruleOnClick, self)
	self._btnenemy:AddClickListener(self._btnenemyOnClick, self)
	self._enemylist:AddClickListener(self._btnenemyOnClick, self)
	self._btnadditionruledetail:AddClickListener(self._btnAdditionRuleDetailOnClick, self)
end

function Season1_6HeroGroupFightViewRule:removeEvents()
	self._btnadditionRuleclick:RemoveClickListener()
	self._btncloserule:RemoveClickListener()
	self._btnenemy:RemoveClickListener()
	self._enemylist:RemoveClickListener()
	self._btnadditionruledetail:RemoveClickListener()
end

function Season1_6HeroGroupFightViewRule:_btncloseruleOnClick()
	if self._ruleItemClick then
		self._ruleItemClick = false

		return
	end

	gohelper.setActive(self._goruledesc, false)
end

function Season1_6HeroGroupFightViewRule:_btnadditionRuleOnClick()
	self._ruleItemClick = self._goruledesc.activeSelf

	gohelper.setActive(self._goruledesc, true)
end

function Season1_6HeroGroupFightViewRule:_btnenemyOnClick()
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(HeroGroupModel.instance.battleId)
end

function Season1_6HeroGroupFightViewRule:_btnAdditionRuleDetailOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()
	local param = {
		actId = actId
	}

	Activity104Controller.instance:openSeasonAdditionRuleTipView(param)
end

function Season1_6HeroGroupFightViewRule:_editableInitView()
	gohelper.addUIClickAudio(self._btnenemy.gameObject, AudioEnum.UI.play_ui_formation_monstermessage)
	gohelper.setActive(self._goruleitem2, false)
	gohelper.setActive(self._goruletemp, false)
	gohelper.setActive(self._goruledesc, false)

	self._monsterGroupItemList = {}
	self._rulesimageList = self:getUserDataTb_()
	self._rulesimagelineList = self:getUserDataTb_()
	self._simageList = self:getUserDataTb_()
end

function Season1_6HeroGroupFightViewRule:onOpen()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._recommendCareer, self)
	self:_refreshUI()
end

function Season1_6HeroGroupFightViewRule:_refreshUI()
	self:_refreshRules()
	self:_refreshAddition()
	self:_refreshEnemy()
	self:_recommendCareer()
	self:_refreshTask()
end

function Season1_6HeroGroupFightViewRule:_refreshTask()
	local taskCo = Activity126Config.instance:getDramlandTask(HeroGroupModel.instance.battleId)

	if taskCo then
		gohelper.setActive(self._goTask, true)

		self._txtTask.text = taskCo.desc
	else
		gohelper.setActive(self._goTask, false)
	end
end

function Season1_6HeroGroupFightViewRule:_refreshRules()
	local episodeId = HeroGroupModel.instance.episodeId
	local isRetail = DungeonConfig.instance:getEpisodeCO(episodeId).type == DungeonEnum.EpisodeType.SeasonRetail
	local retailMo = Activity104Model.instance:getEpisodeRetail(episodeId)

	gohelper.setActive(self._gorules, isRetail and retailMo.advancedId ~= 0)
	gohelper.setActive(self._goruleitem, true)

	if isRetail then
		gohelper.setActive(self._goimagenormal, retailMo.advancedRare == 1)
		gohelper.setActive(self._goimagerare, retailMo.advancedRare == 2)
		gohelper.setActive(self._gonormal, retailMo.advancedRare == 1)
		gohelper.setActive(self._gorare, retailMo.advancedRare == 2)

		self._txtruleinfo.text = retailMo.advancedId and retailMo.advancedId ~= 0 and lua_condition.configDict[retailMo.advancedId].desc or ""
	end
end

function Season1_6HeroGroupFightViewRule:_refreshAddition()
	local episodeId = HeroGroupModel.instance.episodeId
	local additionRule = DungeonConfig.instance:getEpisodeAdditionRule(episodeId)
	local ruleList = GameUtil.splitString2(additionRule, true, "|", "#")

	if not ruleList or #ruleList == 0 then
		gohelper.setActive(self._goadditionRule, false)

		return
	end

	gohelper.setActive(self._goadditionRule, true)

	local list = SeasonConfig.instance:filterRule(ruleList)

	for i, v in ipairs(list) do
		local targetId = v[1]
		local ruleId = v[2]
		local ruleCo = lua_rule.configDict[ruleId]

		if ruleCo then
			self:_addRuleItem(ruleCo, targetId)
			self:_setRuleDescItem(ruleCo, targetId)
		end

		if i == #list then
			gohelper.setActive(self._rulesimagelineList[i], false)
		end
	end
end

function Season1_6HeroGroupFightViewRule:_addRuleItem(ruleCo, targetId)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	gohelper.setActive(go, true)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)
end

function Season1_6HeroGroupFightViewRule:_setRuleDescItem(ruleCo, targetId)
	local tagColor = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local go = gohelper.clone(self._goruleitem2, self._goruleDescList, ruleCo.id)

	gohelper.setActive(go, true)

	local icon = gohelper.findChildImage(go, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(icon, ruleCo.icon)

	local line = gohelper.findChild(go, "line")

	table.insert(self._rulesimagelineList, line)

	local tag = gohelper.findChildImage(go, "tag")

	UISpriteSetMgr.instance:setCommonSprite(tag, "wz_" .. targetId)

	local desc = gohelper.findChildText(go, "desc")

	SkillHelper.addHyperLinkClick(desc)

	local srcDesc = ruleCo.desc
	local descContent = SkillHelper.buildDesc(srcDesc, nil, "#6680bd")
	local wordContent = "\n" .. SkillHelper.getTagDescRecursion(srcDesc, "#6680bd")
	local side = luaLang("dungeon_add_rule_target_" .. targetId)
	local color = tagColor[targetId]

	desc.text = string.format("<color=%s>[%s]</color>%s%s", color, side, descContent, wordContent)
end

function Season1_6HeroGroupFightViewRule:_refreshEnemy()
	local fightParam = FightModel.instance:getFightParam()
	local bossCareerDict = {}
	local enemyCareerDict = {}
	local enemyList = {}
	local enemyBossList = {}

	for i, v in ipairs(fightParam.monsterGroupIds) do
		local bossId = lua_monster_group.configDict[v].bossId
		local ids = string.splitToNumber(lua_monster_group.configDict[v].monster, "#")

		for index, id in ipairs(ids) do
			local enemyCareer = lua_monster.configDict[id].career

			if FightHelper.isBossId(bossId, id) then
				bossCareerDict[enemyCareer] = (bossCareerDict[enemyCareer] or 0) + 1

				table.insert(enemyBossList, id)
			else
				enemyCareerDict[enemyCareer] = (enemyCareerDict[enemyCareer] or 0) + 1

				table.insert(enemyList, id)
			end
		end
	end

	local enemyCareerList = {}

	for k, v in pairs(bossCareerDict) do
		table.insert(enemyCareerList, {
			career = k,
			count = v
		})
	end

	self._enemyBossEndIndex = #enemyCareerList

	for k, v in pairs(enemyCareerDict) do
		table.insert(enemyCareerList, {
			career = k,
			count = v
		})
	end

	gohelper.CreateObjList(self, self._onEnemyItemShow, enemyCareerList, gohelper.findChild(self._goenemyteam, "enemyList"), gohelper.findChild(self._goenemyteam, "enemyList/go_enemyitem"))

	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local level = 0

	if episodeConfig.type == DungeonEnum.EpisodeType.Season then
		local layer = Activity104Model.instance:getBattleFinishLayer()

		level = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), layer).level
	elseif episodeConfig.type == DungeonEnum.EpisodeType.SeasonRetail then
		local stage = Activity104Model.instance:getRetailStage()

		level = SeasonConfig.instance:getSeasonRetailCo(Activity104Model.instance:getCurSeasonId(), stage).level
	elseif episodeConfig.type == DungeonEnum.EpisodeType.SeasonSpecial then
		local layer = Activity104Model.instance:getBattleFinishLayer()

		level = SeasonConfig.instance:getSeasonSpecialCo(Activity104Model.instance:getCurSeasonId(), layer).level
	else
		level = FightHelper.getBattleRecommendLevel(fightParam.battleId)
	end

	self._txtrecommendlevel.text = #enemyBossList > 0 and HeroConfig.instance:getCommonLevelDisplay(level) or #enemyList > 0 and HeroConfig.instance:getCommonLevelDisplay(level) or ""
end

function Season1_6HeroGroupFightViewRule:_recommendCareer()
	local recommended, counter = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, gohelper.findChild(self._gorecommendattr.gameObject, "attrlist"), self._goattritem)

	self._txtrecommonddes.text = #recommended == 0 and luaLang("new_common_none") or ""
end

function Season1_6HeroGroupFightViewRule:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function Season1_6HeroGroupFightViewRule:_onEnemyItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")
	local kingIcon = gohelper.findChild(obj, "icon/kingIcon")
	local enemy_count = gohelper.findChildTextMesh(obj, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(icon, "lssx_" .. tostring(data.career))

	enemy_count.text = data.count > 1 and luaLang("multiple") .. data.count or ""

	gohelper.setActive(kingIcon, index <= self._enemyBossEndIndex)
end

function Season1_6HeroGroupFightViewRule:onClose()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._recommendCareer, self)
end

function Season1_6HeroGroupFightViewRule:onDestroyView()
	return
end

return Season1_6HeroGroupFightViewRule
