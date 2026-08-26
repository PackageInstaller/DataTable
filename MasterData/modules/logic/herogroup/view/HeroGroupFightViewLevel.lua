-- chunkname: @modules/logic/herogroup/view/HeroGroupFightViewLevel.lua

module("modules.logic.herogroup.view.HeroGroupFightViewLevel", package.seeall)

local HeroGroupFightViewLevel = class("HeroGroupFightViewLevel", BaseView)

function HeroGroupFightViewLevel:onInitView()
	self._gobalanceEffect = gohelper.findChild(self.viewGO, "#go_balance")
	self._simageleft = gohelper.findChildSingleImage(self.viewGO, "#go_balance/#simage_left")
	self._simageright = gohelper.findChildSingleImage(self.viewGO, "#go_balance/#simage_right")
	self._gohardEffect = gohelper.findChild(self.viewGO, "#go_container/#go_hardEffect")
	self._gonormalcondition = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition")
	self._txtnormalcondition = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#txt_normalcondition")
	self._gonormalfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalfinish")
	self._gonormalunfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalunfinish")
	self._goplatinumcondition = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition")
	self._txtplatinumcondition = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#txt_platinumcondition")
	self._goplatinumfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumfinish")
	self._goplatinumunfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumunfinish")
	self._goplatinumcondition2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2")
	self._txtplatinumcondition2 = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#txt_platinumcondition")
	self._goplatinumfinish2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumfinish")
	self._goplatinumunfinish2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumunfinish")
	self._gohardplatinumcondition = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition")
	self._txthardplatinumcondition = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition/#txt_hardplatinumcondition")
	self._gohardplatinumfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition/#go_hardplatinumfinish")
	self._gohardplatinumunfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition/#go_hardunfinish")
	self._gohardcondition = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition")
	self._txthardcondition = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition/#txt_hardcondition")
	self._gohardfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition/#go_hardfinish")
	self._gohardunfinish = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition/#go_hardunfinish")
	self._gohardconditionlock = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardconditionlock")
	self._gotargetlist = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList")
	self._btnenemy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemytitle/txten/#btn_enemy")
	self._enemylist = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")
	self._txtrecommendlevel = gohelper.findChildText(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	self._goenemyteam = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam")
	self._gocount = gohelper.findChild(self.viewGO, "#go_container/btnContain/#go_cost/#go_count")
	self._goReplayBtn = gohelper.findChild(self.viewGO, "#go_container/btnContain/btnReplay")
	self._gorecommendattr = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	self._txtrecommonddes = gohelper.findChildTextMesh(self.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")
	self._goadditionrule = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule")
	self._goplace = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_place")
	self._gostar3 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star3")
	self._gostar2 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star2")
	self._gostar1 = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star1")
	self._btnOffer = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#btn_Offer")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupFightViewLevel:addEvents()
	self._btnenemy:AddClickListener(self._btnenemyOnClick, self)
	self._enemylist:AddClickListener(self._btnenemyOnClick, self)

	if self._btnOffer then
		self._btnOffer:AddClickListener(self._btnOfferOnClick, self)
	end

	self.addEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._refreshUI, self)
end

function HeroGroupFightViewLevel:removeEvents()
	self._btnenemy:RemoveClickListener()
	self._enemylist:RemoveClickListener()

	if self._btnOffer then
		self._btnOffer:RemoveClickListener()
	end

	self.removeEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._refreshUI, self)
end

function HeroGroupFightViewLevel:_btnenemyOnClick()
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	if episodeConfig.type == DungeonEnum.EpisodeType.WeekWalk then
		local mapId = WeekWalkModel.instance:getCurMapId()

		EnemyInfoController.instance:openWeekWalkEnemyInfoView(mapId, self._battleId)

		return
	elseif episodeConfig.type == DungeonEnum.EpisodeType.Cachot then
		-- block empty
	elseif episodeConfig.type == DungeonEnum.EpisodeType.BossRush then
		local actId = BossRushConfig.instance:getActivityId()
		local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(self._episodeId)

		EnemyInfoController.instance:openBossRushEnemyInfoView(actId, stage, layer)

		return
	end

	EnemyInfoController.instance:openEnemyInfoViewByBattleId(self._battleId)
end

function HeroGroupFightViewLevel:_btnOfferOnClick()
	BossRushController.instance:openBossRushOfferRoleView()
end

function HeroGroupFightViewLevel:_editableInitView()
	self._monsterGroupItemList = {}

	gohelper.addUIClickAudio(self._btnenemy.gameObject, AudioEnum.UI.play_ui_formation_monstermessage)
	self._simageleft:LoadImage(ResUrl.getHeroGroupBg("herogroup_bg_balanceleft"))
	self._simageright:LoadImage(ResUrl.getHeroGroupBg("herogroup_bg_balanceright"))
end

function HeroGroupFightViewLevel:_refreshUI()
	self._episodeId = HeroGroupModel.instance.episodeId
	self._battleId = HeroGroupModel.instance.battleId

	local chapterId = DungeonModel.instance.curSendChapterId

	if chapterId then
		local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

		self._isSimple = chapterCo and chapterCo.type == DungeonEnum.ChapterType.Simple
	end

	self:_refreshTarget()
	self:_showEnemyList()
	self:_recommendCareer()
end

function HeroGroupFightViewLevel:_refreshTarget()
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

	gohelper.setActive(self._gotargetlist, true)

	local isHardMode = chapterConfig.type == DungeonEnum.ChapterType.Hard

	gohelper.setActive(self._gohardEffect, isHardMode)
	gohelper.setActive(self._gobalanceEffect, HeroGroupBalanceHelper.getIsBalanceMode())

	self._isHardMode = isHardMode

	local normalEpisodeId, hardEpisodeId

	if isHardMode then
		hardEpisodeId = self._episodeId
		normalEpisodeId = episodeConfig.preEpisode
	else
		normalEpisodeId = self._episodeId
	end

	if self._episodeId then
		::label_8_0::

		do
			local hardEpisodeConfig = DungeonConfig.instance:getHardEpisode(normalEpisodeId)

			hardEpisodeId = hardEpisodeConfig and hardEpisodeConfig.id
		end

		if normalEpisodeId then
			::label_8_2::

			local normalEpisodeInfo = DungeonModel.instance:getEpisodeInfo(normalEpisodeId)

			if hardEpisodeId then
				::label_8_3::

				local hardEpisodeInfo = DungeonModel.instance:getEpisodeInfo(hardEpisodeId)

				if normalEpisodeId then
					::label_8_4::

					local passStory = DungeonModel.instance:hasPassLevelAndStory(normalEpisodeId)

					if normalEpisodeId then
						::label_8_5::

						local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(normalEpisodeId)

						if hardEpisodeId then
							::label_8_6::

							local advancedConditionTextHard = DungeonConfig.instance:getEpisodeAdvancedConditionText(hardEpisodeId)
							local hardOpen = DungeonModel.instance:isOpenHardDungeon(episodeConfig.chapterId)
							local isOnlyShowOneTarget = true

							if isHardMode then
								gohelper.setActive(self._gohardcondition, true)

								self._txthardcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(hardEpisodeId)

								local passHard = hardEpisodeInfo.star >= DungeonEnum.StarType.Normal and passStory

								gohelper.setActive(self._gohardfinish, passHard)
								gohelper.setActive(self._gohardunfinish, not passHard)
								ZProj.UGUIHelper.SetColorAlpha(self._txthardcondition, passHard and 1 or 0.63)
								gohelper.setActive(self._gohardplatinumcondition, not string.nilorempty(advancedConditionTextHard))

								local passAdvanced = hardEpisodeInfo.star >= DungeonEnum.StarType.Advanced and passStory

								if not string.nilorempty(advancedConditionTextHard) then
									self._txthardplatinumcondition.text = advancedConditionTextHard

									gohelper.setActive(self._gohardplatinumfinish, passAdvanced)
									gohelper.setActive(self._gohardplatinumunfinish, not passAdvanced)
									ZProj.UGUIHelper.SetColorAlpha(self._txthardplatinumcondition, passAdvanced and 1 or 0.63)

									isOnlyShowOneTarget = false
								end

								self:_showStar(hardEpisodeInfo, advancedConditionTextHard, passHard, passAdvanced)
							elseif self._isSimple then
								local simpleEpisodeInfo = DungeonModel.instance:getEpisodeInfo(self._episodeId)
								local passSimple = simpleEpisodeInfo and simpleEpisodeInfo.star >= DungeonEnum.StarType.Normal and passStory

								gohelper.setActive(self._gonormalcondition, true)

								self._txtnormalcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(normalEpisodeId)

								gohelper.setActive(self._gonormalfinish, passSimple)
								gohelper.setActive(self._gonormalunfinish, not passSimple)
								ZProj.UGUIHelper.SetColorAlpha(self._txtnormalcondition, passSimple and 1 or 0.63)
								self:_showStar(simpleEpisodeInfo, nil, passSimple)
							else
								gohelper.setActive(self._gonormalcondition, true)

								local condition = DungeonConfig.instance:getFirstEpisodeWinConditionText(normalEpisodeId)
								local _bossRushCondition = BossRushEnum.LevelCondition[chapterConfig.type]

								if not string.nilorempty(_bossRushCondition) then
									self._txtnormalcondition.text = luaLang(_bossRushCondition)
								end

								local passNormal = normalEpisodeInfo and normalEpisodeInfo.star >= DungeonEnum.StarType.Normal and passStory
								local passAdvanced = normalEpisodeInfo and normalEpisodeInfo.star >= DungeonEnum.StarType.Advanced and passStory
								local passUltra = false

								if episodeConfig.type == DungeonEnum.EpisodeType.WeekWalk then
									local mapInfo = WeekWalkModel.instance:getCurMapInfo()
									local battleInfo = mapInfo:getBattleInfo(self._battleId)

									if battleInfo then
										passNormal = battleInfo.star >= DungeonEnum.StarType.Normal
										passAdvanced = battleInfo.star >= DungeonEnum.StarType.Advanced
										passUltra = battleInfo.star >= DungeonEnum.StarType.Ultra
									end

									if normalEpisodeId then
										::label_8_7::

										local advancedCondition2Text = DungeonConfig.instance:getEpisodeAdvancedCondition2Text(normalEpisodeId)

										gohelper.setActive(self._goplatinumcondition2, not string.nilorempty(advancedCondition2Text))

										if not string.nilorempty(advancedCondition2Text) then
											self._txtplatinumcondition2.text = advancedCondition2Text

											gohelper.setActive(self._goplatinumfinish2, passUltra)
											gohelper.setActive(self._goplatinumunfinish2, not passUltra)
											ZProj.UGUIHelper.SetColorAlpha(self._txtplatinumcondition2, passUltra and 1 or 0.63)
										end
									end
								end

								if episodeConfig.type == DungeonEnum.EpisodeType.Jiexika then
									passNormal = false
								end

								gohelper.setActive(self._gonormalfinish, passNormal)
								gohelper.setActive(self._gonormalunfinish, not passNormal)
								ZProj.UGUIHelper.SetColorAlpha(self._txtnormalcondition, passNormal and 1 or 0.63)
								gohelper.setActive(self._goplatinumcondition, not self._isSimple and not string.nilorempty(advancedConditionText))

								if not string.nilorempty(advancedConditionText) then
									self._txtplatinumcondition.text = advancedConditionText

									gohelper.setActive(self._goplatinumfinish, passAdvanced)
									gohelper.setActive(self._goplatinumunfinish, not passAdvanced)
									ZProj.UGUIHelper.SetColorAlpha(self._txtplatinumcondition, passAdvanced and 1 or 0.63)

									isOnlyShowOneTarget = false
								end

								gohelper.setActive(self._goplace, isOnlyShowOneTarget)
								self:_showStar(normalEpisodeInfo, advancedConditionText, passNormal, passAdvanced, passUltra)
							end
						end
					end
				end
			end
		end
	end
end

function HeroGroupFightViewLevel:_initStars()
	if self._starList then
		return
	end

	local starNum = 2
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	if episodeConfig.type == DungeonEnum.EpisodeType.WeekWalk then
		local mapInfo = WeekWalkModel.instance:getCurMapInfo()

		starNum = mapInfo:getStarNumConfig()
	end

	if self._isSimple then
		starNum = 1
	end

	gohelper.setActive(self._gostar1, starNum == 1)
	gohelper.setActive(self._gostar2, starNum == 2)
	gohelper.setActive(self._gostar3, starNum == 3)

	if starNum == 1 then
		local var_9_0 = self._gostar1

		if not self._gostar1 then
			if starNum == 2 then
				var_9_0 = self._gostar2

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

function HeroGroupFightViewLevel:_showStar(episodeInfo, advancedConditionText, passNormal, passAdvanced, passUltra)
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

function HeroGroupFightViewLevel:_setStar(image, light, double)
	local color = "#87898C"

	if light then
		color = self._isHardMode and "#FF4343" or "#F77040"
	end

	UISpriteSetMgr.instance:setCommonSprite(image, self._isHardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001", true)
	SLFramework.UGUI.GuiHelper.SetColor(image, color)
end

function HeroGroupFightViewLevel:_refreshMonster()
	local battleConfig = lua_battle.configDict[self._battleId]
	local monsterGroupIdsParam = battleConfig.monsterGroupIds
	local monsterGroupIds = {}

	if not string.nilorempty(monsterGroupIdsParam) then
		monsterGroupIds = string.splitToNumber(monsterGroupIdsParam, "#")
	end

	for i, monsterGroupId in ipairs(monsterGroupIds) do
		local monsterGroupConfig = lua_monster_group.configDict[monsterGroupId]
		local monsterGroupItem = self._monsterGroupItemList[i]

		if not monsterGroupItem then
			monsterGroupItem = self:getUserDataTb_()
			monsterGroupItem.go = gohelper.cloneInPlace(self._goenemyteam, "item" .. i)
			monsterGroupItem.goenemyitem = gohelper.findChild(monsterGroupItem.go, "enemyList/go_enemyitem")
			monsterGroupItem.monsterItemList = {}

			gohelper.setActive(monsterGroupItem.goenemyitem, false)
			table.insert(self._monsterGroupItemList, monsterGroupItem)
		end

		self:_refreshMonsterItem(monsterGroupItem, monsterGroupConfig)
		gohelper.setActive(monsterGroupItem.go, true)
	end

	for i = #monsterGroupIds + 1, #self._monsterGroupItemList do
		local monsterGroupItem = self._monsterGroupItemList[i]

		gohelper.setActive(monsterGroupItem.go, false)
	end
end

function HeroGroupFightViewLevel:_refreshMonsterItem(monsterGroupItem, monsterGroupConfig)
	local monsterItemList = monsterGroupItem.monsterItemList
	local goenemyitem = monsterGroupItem.goenemyitem
	local monsterIdsParam = monsterGroupConfig.monster
	local monsterIds = {}

	if not string.nilorempty(monsterIdsParam) then
		monsterIds = string.splitToNumber(monsterIdsParam, "#")
	end

	local spMonsterIds = string.nilorempty(monsterGroupConfig.spMonster) and {} or string.splitToNumber(monsterGroupConfig.spMonster, "#")

	for _, spMonsterId in ipairs(spMonsterIds) do
		table.insert(monsterIds, spMonsterId)
	end

	local bossCareer = 0
	local monsterCareersDict = {}
	local monsterCareers = {}

	if not string.nilorempty(monsterGroupConfig.bossId) then
		local bossIds = string.splitToNumber(monsterGroupConfig.bossId, "#")
		local monsterConfig = lua_monster.configDict[bossIds[1]]

		bossCareer = monsterConfig.career
	end

	for i, monsterId in ipairs(monsterIds) do
		local monsterConfig = lua_monster.configDict[monsterId]

		if not monsterCareersDict[monsterConfig.career] then
			monsterCareersDict[monsterConfig.career] = true

			table.insert(monsterCareers, monsterConfig.career)
		end
	end

	for i, monsterCareer in ipairs(monsterCareers) do
		local monsterItem = monsterItemList[i]

		if not monsterItem then
			monsterItem = self:getUserDataTb_()
			monsterItem.go = gohelper.cloneInPlace(goenemyitem, "item" .. i)
			monsterItem.icon = gohelper.findChildImage(monsterItem.go, "icon")
			monsterItem.kingIcon = gohelper.findChild(monsterItem.go, "icon/kingIcon")

			table.insert(monsterItemList, monsterItem)
		end

		UISpriteSetMgr.instance:setCommonSprite(monsterItem.icon, "lssx_" .. tostring(monsterCareer))
		gohelper.setActive(monsterItem.kingIcon, monsterCareer == bossCareer)
		gohelper.setActive(monsterItem.go, true)
	end

	for i = #monsterCareers + 1, #monsterItemList do
		local monsterItem = monsterItemList[i]

		gohelper.setActive(monsterItem.go, false)
	end
end

function HeroGroupFightViewLevel:_getSumCE()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local heroList = curGroupMO:getMainList()
	local subHeroList = curGroupMO:getSubList()
	local allEquips = curGroupMO:getAllHeroEquips()
	local battleId = HeroGroupModel.instance.battleId

	return CharacterModel.instance:getSumCE(heroList, subHeroList, allEquips, battleId, true)
end

function HeroGroupFightViewLevel:onOpen()
	self:_refreshUI()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._recommendCareer, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.ShowEnemyInfoViewByGuide, self._btnenemyOnClick, self)

	if BossRushController.instance:isInBossRushFight(true) then
		local stage, layer = BossRushModel.instance:getBattleStageAndLayer()
		local isEnhanceRole = BossRushModel.instance:isEnhanceRole(stage, layer)

		if self._btnOffer then
			gohelper.setActive(self._btnOffer.gameObject, isEnhanceRole)
		end
	end
end

function HeroGroupFightViewLevel:onOpenFinish()
	UIBlockMgr.instance:startBlock("HeroGroupFightViewLevel tryShowFirstHelp")
	TaskDispatcher.runDelay(self._tryShowFirstHelp, self, 0.2)
end

function HeroGroupFightViewLevel:_tryShowFirstHelp()
	UIBlockMgr.instance:endBlock("HeroGroupFightViewLevel tryShowFirstHelp")
	self:_showHelp()
end

function HeroGroupFightViewLevel:_showHelp()
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
	local isHardMode = chapterConfig.type == DungeonEnum.ChapterType.Hard
	local normalGuideId = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideNormal)
	local hardGuideId = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideHard)

	if isHardMode then
		if GuideModel.instance:isGuideFinish(hardGuideId) then
			HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.HeroGroupHard)
		end
	elseif GuideModel.instance:isGuideFinish(normalGuideId) then
		HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.HeroGroupNormal)
	end
end

function HeroGroupFightViewLevel:_showEnemyList()
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

	local career8Num = 0

	for i = #enemy_career_list, 1, -1 do
		local career = enemy_career_list[i].career

		if career == 8 then
			table.remove(enemy_career_list, i)

			career8Num = career8Num + 1
		end
	end

	gohelper.CreateObjList(self, self._onEnemyItemShow, enemy_career_list, gohelper.findChild(self._goenemyteam, "enemyList"), gohelper.findChild(self._goenemyteam, "enemyList/go_enemyitem"))

	local recommendLevel = FightHelper.getBattleRecommendLevel(fight_param.battleId, self._isSimple)

	self._txtrecommendlevel.text = recommendLevel >= 0 and HeroConfig.instance:getLevelDisplayVariant(recommendLevel) or ""

	local obj = gohelper.findChild(self._goenemyteam, "enemynum")

	if #enemy_career_list == 0 and career8Num > 0 then
		gohelper.setActive(obj, true)

		local text = gohelper.findChildText(obj, "#txt_enemynum")

		if text then
			text.text = #enemy_list + #enemy_boss_list
		else
			logError("战斗页面没有适配韧性条UI,请检查")
		end
	else
		gohelper.setActive(obj, false)
	end
end

function HeroGroupFightViewLevel:_onEnemyItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")
	local kingIcon = gohelper.findChild(obj, "icon/kingIcon")
	local enemy_count = gohelper.findChildTextMesh(obj, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(icon, "lssx_" .. tostring(data.career))

	enemy_count.text = data.count > 1 and luaLang("multiple") .. data.count or ""

	gohelper.setActive(kingIcon, index <= self._enemy_boss_end_index)
end

function HeroGroupFightViewLevel:_recommendCareer()
	local recommended, counter = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, gohelper.findChild(self._gorecommendattr.gameObject, "attrlist"), self._goattritem)

	self._txtrecommonddes.text = #recommended == 0 and luaLang("new_common_none") or ""
end

function HeroGroupFightViewLevel:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function HeroGroupFightViewLevel:onClose()
	UIBlockMgr.instance:endBlock("HeroGroupFightViewLevel tryShowFirstHelp")
	TaskDispatcher.cancelTask(self._tryShowFirstHelp, self)
end

function HeroGroupFightViewLevel:onDestroyView()
	self._simageleft:UnLoadImage()
	self._simageright:UnLoadImage()
end

return HeroGroupFightViewLevel
