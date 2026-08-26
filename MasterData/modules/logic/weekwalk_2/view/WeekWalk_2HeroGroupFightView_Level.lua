-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeroGroupFightView_Level.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeroGroupFightView_Level", package.seeall)

local WeekWalk_2HeroGroupFightView_Level = class("WeekWalk_2HeroGroupFightView_Level", HeroGroupFightViewLevel)

function WeekWalk_2HeroGroupFightView_Level:_refreshTarget()
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
		::label_1_0::

		do
			local hardEpisodeConfig = DungeonConfig.instance:getHardEpisode(normalEpisodeId)

			hardEpisodeId = hardEpisodeConfig and hardEpisodeConfig.id
		end

		if normalEpisodeId then
			::label_1_2::

			local normalEpisodeInfo = DungeonModel.instance:getEpisodeInfo(normalEpisodeId)

			if hardEpisodeId then
				::label_1_3::

				local hardEpisodeInfo = DungeonModel.instance:getEpisodeInfo(hardEpisodeId)

				if normalEpisodeId then
					::label_1_4::

					local passStory = DungeonModel.instance:hasPassLevelAndStory(normalEpisodeId)

					if normalEpisodeId then
						::label_1_5::

						local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(normalEpisodeId)

						if hardEpisodeId then
							::label_1_6::

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
								local condition = DungeonConfig.instance:getFirstEpisodeWinConditionText(normalEpisodeId)

								if BossRushController.instance:isInBossRushInfiniteFight() then
									self._txtnormalcondition.text = luaLang("v1a4_bossrushleveldetail_txt_target")
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
										::label_1_7::

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
								self:_refreshWeekWalkTarget()
							end
						end
					end
				end
			end
		end
	end
end

function WeekWalk_2HeroGroupFightView_Level:_refreshWeekWalkTarget()
	if self._goWeekWalkHeart then
		return
	end

	self._goWeekWalkHeart = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_weekwalkheart")

	gohelper.setActive(self._goWeekWalkHeart, false)

	local mapInfo = WeekWalk_2Model.instance:getCurMapInfo()
	local battleId = HeroGroupModel.instance.battleId
	local battleInfo = mapInfo:getBattleInfoByBattleId(battleId)
	local cupTaskList = WeekWalk_2Config.instance:getCupTask(mapInfo.id, battleInfo.index)

	if not cupTaskList then
		return
	end

	for i, v in ipairs(cupTaskList) do
		self:_showCupTask(v)
	end
end

function WeekWalk_2HeroGroupFightView_Level:_showCupTask(config)
	local list = GameUtil.splitString2(config.cupTask, true, "|", "#")
	local go = gohelper.cloneInPlace(self._goWeekWalkHeart)

	gohelper.setSiblingBefore(go, self._goplace)
	gohelper.setActive(go, true)

	local txt = gohelper.findChildText(go, "txt_desc")

	txt.text = config.desc

	for i, v in ipairs(list) do
		local iconRoot = gohelper.findChild(go, "badgelayout/" .. i)

		gohelper.setActive(iconRoot, true)

		local icon = gohelper.findChildImage(iconRoot, "1")
		local result = v[1]

		icon.enabled = false

		local iconEffect = self.viewContainer:getResInst(self.viewContainer._viewSetting.otherRes.weekwalkheart_star, icon.gameObject)

		WeekWalk_2Helper.setCupEffectByResult(iconEffect, result)
	end

	gohelper.setActive(self._gostar3, false)
end

return WeekWalk_2HeroGroupFightView_Level
