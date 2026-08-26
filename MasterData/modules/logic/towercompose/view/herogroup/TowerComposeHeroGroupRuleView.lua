-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposeHeroGroupRuleView.lua

module("modules.logic.towercompose.view.herogroup.TowerComposeHeroGroupRuleView", package.seeall)

local TowerComposeHeroGroupRuleView = class("TowerComposeHeroGroupRuleView", BaseView)

function TowerComposeHeroGroupRuleView:onInitView()
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._gotopbtns = gohelper.findChild(self.viewGO, "#go_container/#go_topbtns")
	self._btnrecommend = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_topbtns/#btn_recommend")
	self._btnRestraintInfo = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_topbtns/#btn_RestraintInfo")
	self._txtclothName = gohelper.findChildText(self.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName")
	self._txtclothNameEn = gohelper.findChildText(self.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#go_container/#scroll_info")
	self._gostar1 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star1")
	self._gostar2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star2")
	self._gostar3 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star3")
	self._gonormalcondition = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition")
	self._txtnormalcondition = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#txt_normalcondition")
	self._gonormalfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalfinish")
	self._gonormalunfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalunfinish")
	self._goplace = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_place")
	self._goadditionRule = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule")
	self._gorulelist = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist")
	self._btnadditionRuleclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	self._goruletemp = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp")
	self._imagetagicon = gohelper.findChildImage(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp/#image_tagicon")
	self._btnenemy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemytitle/txten/#btn_enemy")
	self._goenemyteam = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam")
	self._txtrecommendLevel = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	self._gorecommendAttr = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	self._txtrecommonddes = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeHeroGroupRuleView:addEvents()
	self._btnrecommend:AddClickListener(self._btnrecommendOnClick, self)
	self._btnRestraintInfo:AddClickListener(self._btnRestraintInfoOnClick, self)
	self._btnadditionRuleclick:AddClickListener(self._btnadditionRuleclickOnClick, self)
	self._btnenemy:AddClickListener(self._btnenemyOnClick, self)
	self._enemylist:AddClickListener(self._btnenemyOnClick, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self.recommendCareer, self)
	self.addEventCb(self, HelpController.instance, HelpEvent.RefreshHelp, self.isShowHelpBtnIcon, self)
end

function TowerComposeHeroGroupRuleView:removeEvents()
	self._btnrecommend:RemoveClickListener()
	self._btnRestraintInfo:RemoveClickListener()
	self._btnadditionRuleclick:RemoveClickListener()
	self._btnenemy:RemoveClickListener()
	self._enemylist:RemoveClickListener()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self.recommendCareer, self)
	self.removeEventCb(self, HelpController.instance, HelpEvent.RefreshHelp, self.isShowHelpBtnIcon, self)
end

function TowerComposeHeroGroupRuleView:_btnrecommendOnClick()
	FightFailRecommendController.instance:onClickRecommend()
	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(self.episodeId, self._receiveRecommend, self)
end

function TowerComposeHeroGroupRuleView:_btnRestraintInfoOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function TowerComposeHeroGroupRuleView:_btnadditionRuleclickOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = self.ruleList,
		offSet = {
			0,
			-155
		}
	})
end

function TowerComposeHeroGroupRuleView:_btnenemyOnClick()
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(self.battleId)
end

function TowerComposeHeroGroupRuleView:_editableInitView()
	self.ruleItemList = self:getUserDataTb_()
	self._enemylist = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")

	gohelper.setActive(self._goruletemp, false)
	gohelper.setActive(self._btnrecommend.gameObject, false)
end

function TowerComposeHeroGroupRuleView:onUpdateParam()
	return
end

function TowerComposeHeroGroupRuleView:onOpen()
	self.recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	self.themeId = self.recordFightParam.themeId
	self.layerId = self.recordFightParam.layerId
	self.towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(self.themeId, self.layerId)
	self.dungeonEpisodeCo = DungeonConfig.instance:getEpisodeCO(self.towerEpisodeConfig.episodeId)
	self.episodeId = self.towerEpisodeConfig.episodeId
	self.battleId = self.dungeonEpisodeCo.battleId

	self:refreshUI()
	self:isShowHelpBtnIcon()
end

function TowerComposeHeroGroupRuleView:refreshUI()
	if self.towerEpisodeConfig.plane > 0 then
		return
	end

	gohelper.setActive(self._gotopbtns, false)
	gohelper.setActive(self._scrollinfo, true)

	self.chapterConfig = DungeonConfig.instance:getChapterCO(self.dungeonEpisodeCo.chapterId)

	gohelper.setActive(self._btnrecommend.gameObject, false)
	self:refreshAdditionRule()
	self:refreshNormalCondition()
	self:showEnemyList()
	self:recommendCareer()
end

function TowerComposeHeroGroupRuleView:refreshAdditionRule()
	local battleCo = lua_battle.configDict[self.dungeonEpisodeCo.battleId]

	if battleCo then
		if not battleCo.additionRule then
			local additionRule = ""

			self.ruleList = FightStrUtil.instance:getSplitString2Cache(additionRule, true, "|", "#")

			for index, ruleData in ipairs(self.ruleList) do
				local targetId = ruleData[1]
				local ruleId = ruleData[2]
				local ruleCo = lua_rule.configDict[ruleId]

				if ruleCo then
					local ruleItem = self.ruleItemList[index]

					if not ruleItem then
						ruleItem = {
							config = ruleCo,
							go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)
						}
						ruleItem.tagicon = gohelper.findChildImage(ruleItem.go, "#image_tagicon")
						ruleItem.simage = gohelper.findChildImage(ruleItem.go, "")
						self.ruleItemList[index] = ruleItem
					end

					gohelper.setActive(ruleItem.go, true)
					UISpriteSetMgr.instance:setCommonSprite(ruleItem.tagicon, "wz_" .. targetId)
					UISpriteSetMgr.instance:setDungeonLevelRuleSprite(ruleItem.simage, ruleCo.icon)
				end
			end

			for index = #self.ruleList + 1, #self.ruleItemList do
				gohelper.setActive(self.ruleItemList[index].go, false)
			end
		end
	end
end

function TowerComposeHeroGroupRuleView:_receiveRecommend(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, msg)
end

function TowerComposeHeroGroupRuleView:refreshNormalCondition()
	gohelper.setActive(self._gonormalcondition, true)

	self._txtnormalcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(self.episodeId)

	local simpleEpisodeInfo = DungeonModel.instance:getEpisodeInfo(self.episodeId)

	if self.episodeId then
		local passStory = DungeonModel.instance:hasPassLevelAndStory(self.episodeId)
		local passSimple = simpleEpisodeInfo and simpleEpisodeInfo.star >= DungeonEnum.StarType.Normal and passStory

		gohelper.setActive(self._gonormalfinish, passSimple)
		gohelper.setActive(self._gonormalunfinish, not passSimple)
		ZProj.UGUIHelper.SetColorAlpha(self._txtnormalcondition, passSimple and 1 or 0.63)

		self._isSimple = self.chapterConfig and self.chapterConfig.type == DungeonEnum.ChapterType.Simple

		self:_showStar(simpleEpisodeInfo, nil, passSimple)
	end
end

function TowerComposeHeroGroupRuleView:_showStar(episodeInfo, advancedConditionText, passNormal, passAdvanced, passUltra)
	self:_initStars()
	gohelper.setActive(self._starList[1], true)
	self:_setStar(self._starList[1], passNormal)

	if not self._isSimple then
		if string.nilorempty(advancedConditionText) then
			gohelper.setActive(self._starList[2], false)
		else
			gohelper.setActive(self._starList[2], true)
			self:_setStar(self._starList[2], passAdvanced)

			if self._starList[3] then
				gohelper.setActive(self._starList[3], true)
				self:_setStar(self._starList[3], passUltra)
			end
		end
	end
end

function TowerComposeHeroGroupRuleView:_initStars()
	if self._starList then
		return
	end

	local starNum = 2

	if self._isSimple then
		starNum = 1
	end

	gohelper.setActive(self._gostar1, starNum == 1)
	gohelper.setActive(self._gostar2, starNum == 2)
	gohelper.setActive(self._gostar3, starNum == 3)

	if starNum == 1 then
		local var_16_0 = self._gostar1

		if not self._gostar1 then
			if starNum == 2 then
				var_16_0 = self._gostar2

				if not self._gostar2 then
					local starGo = self._gostar3

					self._starList = self:getUserDataTb_()

					for i = 1, starNum do
						local star = gohelper.findChildImage(starGo, "star" .. i)

						table.insert(self._starList, star)
					end
				end
			end
		end
	end
end

function TowerComposeHeroGroupRuleView:_setStar(image, light)
	local color = light and "#F77040" or "#87898C"

	UISpriteSetMgr.instance:setCommonSprite(image, "zhuxianditu_pt_xingxing_001", true)
	SLFramework.UGUI.GuiHelper.SetColor(image, color)
end

function TowerComposeHeroGroupRuleView:showEnemyList()
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

	self._txtrecommendLevel.text = recommendLevel >= 0 and HeroConfig.instance:getLevelDisplayVariant(recommendLevel) or ""
end

function TowerComposeHeroGroupRuleView:_onEnemyItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")
	local kingIcon = gohelper.findChild(obj, "icon/kingIcon")
	local enemy_count = gohelper.findChildTextMesh(obj, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(icon, "lssx_" .. tostring(data.career))

	enemy_count.text = data.count > 1 and luaLang("multiple") .. data.count or ""

	gohelper.setActive(kingIcon, index <= self._enemy_boss_end_index)
end

function TowerComposeHeroGroupRuleView:recommendCareer()
	local recommended, counter = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, gohelper.findChild(self._gorecommendAttr.gameObject, "attrlist"), self._goattritem)

	self._txtrecommonddes.text = #recommended == 0 and luaLang("new_common_none") or ""
end

function TowerComposeHeroGroupRuleView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function TowerComposeHeroGroupRuleView:isShowHelpBtnIcon()
	local helpId = self.viewContainer:getHelpId()

	recthelper.setAnchorX(self._gotopbtns.transform, helpId and 419.88 or 271.2)
end

function TowerComposeHeroGroupRuleView:onClose()
	return
end

function TowerComposeHeroGroupRuleView:onDestroyView()
	return
end

return TowerComposeHeroGroupRuleView
