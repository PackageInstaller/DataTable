-- chunkname: @modules/logic/seasonver/act166/view/Season166HeroGroupFightViewRule.lua

module("modules.logic.seasonver.act166.view.Season166HeroGroupFightViewRule", package.seeall)

local Season166HeroGroupFightViewRule = class("Season166HeroGroupFightViewRule", BaseView)

function Season166HeroGroupFightViewRule:onInitView()
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#go_container/#scroll_info")
	self._btntargetShow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/txt_target/#btn_targetShow")
	self._gotargetconditionContent = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList")
	self._gotargetcondition = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition")
	self._txttargetcondition = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#txt_targetcondition")
	self._gonormalfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#go_normalfinish")
	self._gonormalunfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#go_normalunfinish")
	self._gobasespotfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#go_basespotfinish")
	self._gobasespotunfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#go_basespotunfinish")
	self._gostrategy = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/strategy")
	self._txtstrategydesc = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/strategy/strategydesc/#txt_strategydesc")
	self._goadditionRule = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule")
	self._gorulelist = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist")
	self._btnadditionRuleclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	self._goruletemp = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp")
	self._imagetagicon = gohelper.findChildImage(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp/#image_tagicon")
	self._btnenemy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemytitle/txten/#btn_enemy")
	self._enemylist = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")
	self._txtrecommendlevel = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	self._goenemyteam = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam")
	self._gorecommendattr = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	self._txtrecommonddes = gohelper.findChildTextMesh(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")
	self._gorulewindow = gohelper.findChild(self.viewGO, "#go_rulewindow")
	self._goruledesc = gohelper.findChild(self.viewGO, "#go_rulewindow/#go_ruledesc")

	gohelper.setActive(self._goruledesc, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166HeroGroupFightViewRule:addEvents()
	self._btntargetShow:AddClickListener(self._btntargetShowOnClick, self)
	self._btnadditionRuleclick:AddClickListener(self._btnadditionRuleOnClick, self)
	self._btnenemy:AddClickListener(self._btnenemyOnClick, self)
	self._enemylist:AddClickListener(self._btnenemyOnClick, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._recommendCareer, self)
end

function Season166HeroGroupFightViewRule:removeEvents()
	self._btntargetShow:RemoveClickListener()
	self._btnadditionRuleclick:RemoveClickListener()
	self._btnenemy:RemoveClickListener()
	self._enemylist:RemoveClickListener()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._recommendCareer, self)
end

function Season166HeroGroupFightViewRule:_btntargetShowOnClick()
	self:checkAndOpenTargetView(true)
end

function Season166HeroGroupFightViewRule:_btnadditionRuleOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = self._ruleList
	})
end

function Season166HeroGroupFightViewRule:_btnenemyOnClick()
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(self.battleId)
end

function Season166HeroGroupFightViewRule:_editableInitView()
	gohelper.setActive(self._gorulewindow, false)
	gohelper.setActive(self._gotargetcondition, true)
	gohelper.setActive(self._goruletemp, false)
	gohelper.setActive(self._goruleitem, false)

	self._rulesimagelineList = self:getUserDataTb_()
end

function Season166HeroGroupFightViewRule:onOpen()
	self:initData()
	self:checkAndOpenTargetView()
	self:refreshTargetCondition()
	self:refreshStrategy()
	self:refreshRuleUI()
	self:_showEnemyList()
	self:_recommendCareer()
end

function Season166HeroGroupFightViewRule:initData()
	self.actId = self.viewParam.actId
	self.context = Season166Model.instance:getBattleContext()
	self.episodeId = self.viewParam.episodeId or Season166HeroGroupModel.instance.episodeId
	self.episodeConfig = DungeonConfig.instance:getEpisodeCO(self.episodeId)
	self.battleId = self.viewParam.battleId or self.episodeConfig.battleId
	self.battleConfig = self.battleId and lua_battle.configDict[self.episodeConfig.battleId]
	self.isTrainEpisode = Season166HeroGroupModel.instance:isSeason166TrainEpisode(self.episodeId)
end

function Season166HeroGroupFightViewRule:checkAndOpenTargetView(isManual)
	if self.context and self.context.baseId and self.context.baseId > 0 then
		gohelper.setActive(self._btntargetShow.gameObject, true)

		local tab = Season166Model.instance:getLocalPrefsTab(Season166Enum.EnterSpotKey)
		local isEnter = tab[self.context.baseId] == 1

		if not isEnter or isManual then
			ViewMgr.instance:openView(ViewName.Season166HeroGroupTargetView, {
				actId = self.actId,
				baseId = self.context.baseId
			})
		end

		if not isEnter then
			Season166Model.instance:setLocalPrefsTab(Season166Enum.EnterSpotKey, self.context.baseId, 1)
		end
	else
		gohelper.setActive(self._btntargetShow.gameObject, false)
	end
end

function Season166HeroGroupFightViewRule:refreshTargetCondition()
	if self.context and self.context.baseId and self.context.baseId > 0 then
		local scoreConfigList = {}

		for level = 1, 3 do
			local scoreCo = Season166Config.instance:getSeasonScoreCo(self.actId, level)

			table.insert(scoreConfigList, scoreCo)
		end

		gohelper.CreateObjList(self, self.targetConditionDescShow, scoreConfigList, self._gotargetconditionContent, self._gotargetcondition)
	else
		local condition = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, self.battleId)

		self._txttargetcondition.text = condition or luaLang("season166_herogroup_normalTarget")

		gohelper.setActive(self._gonormalfinish, true)
		gohelper.setActive(self._gonormalunfinish, false)
		gohelper.setActive(self._gobasespotfinish, false)
		gohelper.setActive(self._gobasespotunfinish, false)
	end
end

function Season166HeroGroupFightViewRule:targetConditionDescShow(obj, data, index)
	local txtTargetCondition = gohelper.findChildText(obj, "#txt_targetcondition")
	local gofinish = gohelper.findChild(obj, "#go_normalfinish")
	local gounfinish = gohelper.findChild(obj, "#go_normalunfinish")
	local goBasespotFinish = gohelper.findChild(obj, "#go_basespotfinish")
	local goBasespotUnfinish = gohelper.findChild(obj, "#go_basespotunfinish")
	local descFormat = luaLang("season166_herogroup_fightScoreTarget")

	txtTargetCondition.text = GameUtil.getSubPlaceholderLuaLang(descFormat, {
		data.needScore
	})

	local curScore = Season166BaseSpotModel.instance:getBaseSpotMaxScore(self.actId, self.context.baseId)

	gohelper.setActive(goBasespotFinish, curScore >= data.needScore)
	gohelper.setActive(goBasespotUnfinish, curScore < data.needScore)
	gohelper.setActive(gofinish, false)
	gohelper.setActive(gounfinish, false)
end

function Season166HeroGroupFightViewRule:refreshStrategy()
	if self.context and self.context.baseId and self.context.baseId > 0 then
		local baseConfig = Season166Config.instance:getSeasonBaseSpotCo(self.actId, self.context.baseId)

		self._txtstrategydesc.text = baseConfig.strategy

		gohelper.setActive(self._gostrategy, not string.nilorempty(baseConfig.strategy))
	elseif self.isTrainEpisode and self.context and self.context.trainId and self.context.trainId > 0 then
		local trainConfig = Season166Config.instance:getSeasonTrainCo(self.actId, self.context.trainId)

		self._txtstrategydesc.text = trainConfig.strategy

		gohelper.setActive(self._gostrategy, not string.nilorempty(trainConfig.strategy))
	elseif self.context and self.context.teachId and self.context.teachId > 0 then
		local teachConfig = Season166Config.instance:getSeasonTeachCos(self.context.teachId)

		self._txtstrategydesc.text = teachConfig.strategy

		gohelper.setActive(self._gostrategy, not string.nilorempty(teachConfig.strategy))
	else
		gohelper.setActive(self._gostrategy, false)
	end
end

function Season166HeroGroupFightViewRule:refreshRuleUI()
	local battleCo = lua_battle.configDict[self.battleId]

	if battleCo then
		if not battleCo.additionRule then
			local additionRule = ""
			local ruleList = FightStrUtil.instance:getSplitString2Cache(additionRule, true, "|", "#")

			if not ruleList or #ruleList == 0 then
				gohelper.setActive(self._goadditionRule, false)

				return
			end

			self._cloneRuleGos = self._cloneRuleGos or self:getUserDataTb_()

			self:_clearRules()
			gohelper.setActive(self._goadditionRule, true)

			self._ruleList = ruleList

			for i, v in ipairs(ruleList) do
				local targetId = v[1]
				local ruleId = v[2]
				local ruleCo = lua_rule.configDict[ruleId]

				if ruleCo then
					self:_addRuleItem(ruleCo, targetId)
				end

				if i == #ruleList then
					gohelper.setActive(self._rulesimagelineList[i], false)
				end
			end
		end
	end
end

function Season166HeroGroupFightViewRule:_addRuleItem(ruleCo, targetId)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	gohelper.setActive(go, true)
	table.insert(self._cloneRuleGos, go)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)
end

function Season166HeroGroupFightViewRule:_clearRules()
	for i = #self._cloneRuleGos, 1, -1 do
		gohelper.destroy(self._cloneRuleGos[i])

		self._cloneRuleGos[i] = nil
	end
end

function Season166HeroGroupFightViewRule:_showEnemyList()
	local fight_param = FightModel.instance:getFightParam()
	local boss_career_dic = {}
	local enemy_career_dic = {}
	local enemy_list = {}
	local enemy_boss_list = {}

	for i, v in ipairs(fight_param.monsterGroupIds) do
		local boss_id = lua_monster_group.configDict[v].bossId
		local ids = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[v].monster, "#")

		for index, id in ipairs(ids) do
			local enemy_career = lua_monster.configDict[id].career

			if FightHelper.isBossId(boss_id, id) then
				boss_career_dic[enemy_career] = (boss_career_dic[enemy_career] or 0) + 1

				table.insert(enemy_boss_list, id)
			else
				enemy_career_dic[enemy_career] = (enemy_career_dic[enemy_career] or 0) + 1

				table.insert(enemy_list, id)
			end
		end
	end

	local enemy_career_list = {}

	for k, v in pairs(boss_career_dic) do
		table.insert(enemy_career_list, {
			career = k,
			count = v
		})
	end

	self._enemy_boss_end_index = #enemy_career_list

	for k, v in pairs(enemy_career_dic) do
		table.insert(enemy_career_list, {
			career = k,
			count = v
		})
	end

	gohelper.CreateObjList(self, self._onEnemyItemShow, enemy_career_list, gohelper.findChild(self._goenemyteam, "enemyList"), gohelper.findChild(self._goenemyteam, "enemyList/go_enemyitem"))

	local recommendLevel = FightHelper.getBattleRecommendLevel(fight_param.battleId, self._isSimple)

	self._txtrecommendlevel.text = recommendLevel >= 0 and HeroConfig.instance:getLevelDisplayVariant(recommendLevel) or ""
end

function Season166HeroGroupFightViewRule:_onEnemyItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")
	local kingIcon = gohelper.findChild(obj, "icon/kingIcon")
	local enemy_count = gohelper.findChildTextMesh(obj, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(icon, "lssx_" .. tostring(data.career))

	enemy_count.text = data.count > 1 and luaLang("multiple") .. data.count or ""

	gohelper.setActive(kingIcon, index <= self._enemy_boss_end_index)
end

function Season166HeroGroupFightViewRule:_recommendCareer()
	local recommended, counter = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, gohelper.findChild(self._gorecommendattr.gameObject, "attrlist"), self._goattritem)

	self._txtrecommonddes.text = #recommended == 0 and luaLang("new_common_none") or ""
end

function Season166HeroGroupFightViewRule:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function Season166HeroGroupFightViewRule:onClose()
	return
end

function Season166HeroGroupFightViewRule:onDestroyView()
	return
end

return Season166HeroGroupFightViewRule
