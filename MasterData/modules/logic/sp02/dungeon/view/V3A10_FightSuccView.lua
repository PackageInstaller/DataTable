-- chunkname: @modules/logic/sp02/dungeon/view/V3A10_FightSuccView.lua

module("modules.logic.sp02.dungeon.view.V3A10_FightSuccView", package.seeall)

local V3A10_FightSuccView = class("V3A10_FightSuccView", FightSuccView)

function V3A10_FightSuccView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)

	self._canClick = false
	self._animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	self._animation:Play("fightsucc_in", UnityEngine.PlayMode.StopAll)
	self._animation:PlayQueued("fightsucc_loop", UnityEngine.QueueMode.CompleteOthers, UnityEngine.PlayMode.StopAll)

	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	FightController.instance:checkFightQuitTipViewClose()
	gohelper.setActive(self._bonusItemGo, false)

	self._curEpisodeId = DungeonModel.instance.curSendEpisodeId
	self._curChapterId = DungeonModel.instance.curSendChapterId

	local fightResultModel = FightResultModel.instance
	local curEpisodeConfig = lua_episode.configDict[self._curEpisodeId]
	local curChapterConfig = DungeonConfig.instance:getChapterCO(self._curChapterId)

	if curChapterConfig then
		if not curChapterConfig.type then
			local chapterType = DungeonEnum.ChapterType.Normal

			self._normalMode = chapterType == DungeonEnum.ChapterType.Normal
			self._hardMode = chapterType == DungeonEnum.ChapterType.Hard
			self._simpleMode = chapterType == DungeonEnum.ChapterType.Simple
			self._mode = ActivityConfig.instance:getChapterIdMode(self._curChapterId)

			if self._mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
				self._mode = VersionActivityDungeonBaseEnum.DungeonMode.Story3
			end

			if curEpisodeConfig then
				if not curEpisodeConfig.type then
					self._curEpisodeId = FightResultModel.instance.episodeId
					self.hadHighRareProp = false

					self:_loadBonusItems()
					self:_hideGoDemand()

					local conditionText = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId())
					local platConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(self._curEpisodeId, FightModel.instance:getBattleId())
					local starImage = self._hardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"

					if curChapterConfig and curChapterConfig.type == DungeonEnum.ChapterType.Simple then
						gohelper.setActive(self._goPlatCondition, false)
					else
						self:_showPlatCondition(platConditionText, self._goPlatCondition, starImage, DungeonEnum.StarType.Advanced)
					end

					self:_showPlatCondition(DungeonConfig.instance:getEpisodeAdvancedCondition2Text(self._curEpisodeId, FightModel.instance:getBattleId()), self._goPlatCondition2, starImage, DungeonEnum.StarType.Ultra)

					if string.nilorempty(conditionText) then
						gohelper.setActive(self._goCondition, false)
					else
						gohelper.findChildText(self._goCondition, "condition").text = conditionText

						self:setSP02Progress(self._goCondition, 0.5)
					end

					self._randomEntityMO = self:_getRandomEntityMO()

					self._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
					self._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

					local chapterCO = lua_chapter.configDict[fightResultModel:getChapterId()]
					local episodeCO = lua_episode.configDict[fightResultModel:getEpisodeId()]
					local needShowFbName = chapterCO ~= nil and episodeCO ~= nil

					gohelper.setActive(self._txtFbName.gameObject, needShowFbName)
					gohelper.setActive(self._txtFbNameEn.gameObject, needShowFbName)

					if needShowFbName then
						self:_setFbName(episodeCO)
					end

					local exps = PlayerModel.instance:getExpNowAndMax()

					self._txtLv.text = "<size=36>LV </size>" .. PlayerModel.instance:getPlayerLevel()

					self._sliderExp:SetValue(exps[1] / exps[2])

					self._txtExp.text = exps[1] .. "/" .. exps[2]

					local addExp = fightResultModel:getPlayerExp()

					if addExp and addExp > 0 then
						gohelper.setActive(self._txtAddExp.gameObject, true)

						self._txtAddExp.text = "EXP+" .. addExp
					else
						gohelper.setActive(self._txtAddExp.gameObject, false)
					end

					self:_setSpineVoice()
					NavigateMgr.instance:addEscape(ViewName.FightSuccView, self._onClickClose, self)

					self._canPlayVoice = false

					TaskDispatcher.runDelay(self._setCanPlayVoice, self, 0.9)
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
					self:_checkNewRecord()
					self:_detectCoverRecord()
					self:_checkTypeDetails()
					self:showUnLockCurrentEpisodeNewMode()
					self:_show1_2DailyEpisodeEndNotice()
					self:_show1_6EpisodeMaterial()
					self:_showWeekWalk_2Condition()
					self:_playVictoryAudio_2_7()
				end
			end
		end
	end
end

function V3A10_FightSuccView:setSP02Progress(go, progress)
	local goProgressItem = gohelper.findChild(go, "#go_progressitem")

	for i = 1, 3 do
		local goIcon = gohelper.findChild(goProgressItem, "image_icon" .. i)

		if i == self._mode then
			gohelper.setActive(goIcon, true)

			local img = gohelper.findChildImage(goIcon, "#image_fg")

			img.fillAmount = progress
		else
			gohelper.setActive(goIcon, false)
		end
	end
end

function V3A10_FightSuccView:_showPlatCondition(platConditionText, go, starImage, targetStarNum)
	if string.nilorempty(platConditionText) then
		gohelper.setActive(go, false)
	else
		gohelper.setActive(go, true)

		local resultStar = tonumber(FightResultModel.instance.star) or 0

		gohelper.findChildText(go, "condition").text = resultStar < targetStarNum and gohelper.getRichColorText(platConditionText, "#6C6C6B") or gohelper.getRichColorText(platConditionText, "#C4C0BD")

		self:setSP02Progress(go, targetStarNum <= resultStar and 1 or 0)
	end
end

function V3A10_FightSuccView:_setEpisodeName(episodeCO, episodeIndex, normalEpisodeCO)
	V3A10_FightSuccView.super._setEpisodeName(self, episodeCO, episodeIndex, normalEpisodeCO)

	local index = tonumber(self._txtEpisodeIndex.text) or 0

	self._txtEpisodeIndex.text = index - 1
end

function V3A10_FightSuccView:_addItem(material, customRefreshCallback, customRefreshCallbackParam)
	local go = gohelper.clone(self._bonusItemGo, self._bonusItemContainer, material.id)
	local itemIconGO = gohelper.findChild(go, "container/itemIcon")
	local itemIcon = IconMgr.instance:getCommonPropItemIcon(itemIconGO)
	local tagGO = gohelper.findChild(go, "container/tag")
	local imgFirstGO = gohelper.findChild(go, "container/tag/imgFirst")
	local imgFirstHardGO = gohelper.findChild(go, "container/tag/imgFirstHard")
	local imgFirstSimpleGO = gohelper.findChild(go, "container/tag/imgFirstSimple")
	local imgNormalGO = gohelper.findChild(go, "container/tag/imgNormal")
	local imgAdvanceGO = gohelper.findChild(go, "container/tag/imgAdvance")
	local imgEquipDailyGO = gohelper.findChild(go, "container/tag/imgEquipDaily")
	local imgTimeFirstGO = gohelper.findChild(go, "container/tag/limitfirstbg")
	local actTagGo = gohelper.findChild(go, "container/tag/imgact")
	local containerGO = gohelper.findChild(go, "container")

	gohelper.setActive(containerGO, false)
	gohelper.setActive(tagGO, material.bonusTag)

	if material.bonusTag then
		gohelper.setActive(imgFirstGO, material.bonusTag == FightEnum.FightBonusTag.FirstBonus and self._normalMode)
		gohelper.setActive(imgFirstHardGO, material.bonusTag == FightEnum.FightBonusTag.FirstBonus and self._hardMode)
		gohelper.setActive(imgNormalGO, false)

		local showTag = material.bonusTag == FightEnum.FightBonusTag.AdvencedBonus or material.bonusTag == FightEnum.FightBonusTag.FirstBonus

		gohelper.setActive(imgAdvanceGO, showTag)

		if showTag then
			for i = 1, 3 do
				local go = gohelper.findChild(imgAdvanceGO, string.format("#go_progressitem/image_icon%s", i))

				gohelper.setActive(go, i == self._mode)
			end
		end

		gohelper.setActive(imgEquipDailyGO, material.bonusTag == FightEnum.FightBonusTag.EquipDailyFreeBonus)
		gohelper.setActive(imgTimeFirstGO, material.bonusTag == FightEnum.FightBonusTag.TimeFirstBonus)
		gohelper.setActive(actTagGo, material.bonusTag == FightEnum.FightBonusTag.ActBonus)
		gohelper.setActive(imgFirstSimpleGO, material.bonusTag ~= FightEnum.FightBonusTag.SimpleBouns and FightEnum.FightBonusTag.FirstBonus and self._simpleMode or true)
	end

	material.isIcon = true

	itemIcon:onUpdateMO(material)
	itemIcon:setCantJump(true)
	itemIcon:setCountFontSize(40)
	itemIcon:setAutoPlay(true)
	itemIcon:isShowEquipRefineLv(true)
	itemIcon:isShowAddition((material.bonusTag and material.bonusTag == FightEnum.FightBonusTag.AdditionBonus or nil) and true)

	if customRefreshCallback then
		customRefreshCallback(self, itemIcon, customRefreshCallbackParam)
	end

	gohelper.setActive(go, false)

	local canvasGroup = tagGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	canvasGroup.alpha = 0

	self:applyBonusVfx(material, go)

	return containerGO, go
end

return V3A10_FightSuccView
