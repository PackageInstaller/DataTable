-- chunkname: @modules/logic/tower/view/timelimittower/TowerTimeLimitLevelView.lua

module("modules.logic.tower.view.timelimittower.TowerTimeLimitLevelView", package.seeall)

local TowerTimeLimitLevelView = class("TowerTimeLimitLevelView", BaseView)

function TowerTimeLimitLevelView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "simage_title/timebg/#txt_time")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "score/#simage_icon")
	self._goTaskPointContent = gohelper.findChild(self.viewGO, "score/#go_taskPointContent")
	self._goTaskPointItem = gohelper.findChild(self.viewGO, "score/#go_taskPointContent/#go_taskPointItem")
	self._txtscore = gohelper.findChildText(self.viewGO, "score/#txt_score")
	self._txtTaskNum = gohelper.findChildText(self.viewGO, "score/#txt_taskNum")
	self._btntaskClick = gohelper.findChildButtonWithAudio(self.viewGO, "score/#btn_taskClick")
	self._goBoss = gohelper.findChild(self.viewGO, "root/main/boss")
	self._btnbossClick = gohelper.findChildButtonWithAudio(self.viewGO, "root/main/boss/#btn_bossClick")
	self._gobossContent = gohelper.findChild(self.viewGO, "root/main/boss/#go_bossContent")
	self._gobossItem = gohelper.findChild(self.viewGO, "root/main/boss/#go_bossContent/#go_bossItem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btncloseDetail = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_closeDetail")
	self._godetailInfo = gohelper.findChild(self.viewGO, "root/#go_detailInfo")
	self._goSwitchEfeect = gohelper.findChild(self.viewGO, "root/#go_detailInfo/#go_difficulty/index/vx_refresh")
	self._goTaskReddot = gohelper.findChild(self.viewGO, "score/#go_taskReddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerTimeLimitLevelView:addEvents()
	self._btncloseDetail:AddClickListener(self._btncloseDetailOnClick, self)
	self._btntaskClick:AddClickListener(self._btnTaskClick, self)
	self._btnbossClick:AddClickListener(self._btnBossClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.refreshUI, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnTowerResetSubEpisode, self.refreshUI, self)
end

function TowerTimeLimitLevelView:removeEvents()
	self._btncloseDetail:RemoveClickListener()
	self._btntaskClick:RemoveClickListener()
	self._btnbossClick:RemoveClickListener()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.refreshUI, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnTowerResetSubEpisode, self.refreshUI, self)
end

TowerTimeLimitLevelView.AnimBlockKey = "TowerTimeLimitDetailAnimBlock"
TowerTimeLimitLevelView.EpisodeScaleAnimTime = 0.5
TowerTimeLimitLevelView.OpenDetailTime = 0.25
TowerTimeLimitLevelView.closeDetailTime = 0.167
TowerTimeLimitLevelView.closeToNormalTime = 0.33
TowerTimeLimitLevelView.fadeItemAlpha = 0.6

function TowerTimeLimitLevelView:_btncloseDetailOnClick()
	UIBlockMgr.instance:startBlock(TowerTimeLimitLevelView.AnimBlock)

	if self.isOpenDetail then
		self.rootAnimtorPlayer:Play(UIAnimationName.Close, self.closeDetailFinish, self)
	end

	self.isOpenDetail = false

	TowerTimeLimitLevelModel.instance:setCurSelectEntrance(0)
	self:setCloseOverrideFunc()
	self:refreshDetailShowUI()
	self:playCloseItemAnim()

	self.lastSelectEntranceId = 0

	gohelper.setActive(self._goSwitchEfeect, false)
end

function TowerTimeLimitLevelView:closeDetailFinish()
	UIBlockMgr.instance:endBlock(TowerTimeLimitLevelView.AnimBlock)
	gohelper.setActive(self._btncloseDetail.gameObject, false)
end

function TowerTimeLimitLevelView:_btnEpisodeItemClick(episodeItem)
	TowerTimeLimitLevelModel.instance:setCurSelectEntrance(episodeItem.entranceId)

	if not self.isOpenDetail then
		UIBlockMgr.instance:startBlock(TowerTimeLimitLevelView.AnimBlock)
		self.rootAnimtorPlayer:Play(UIAnimationName.Open, self.openDetailFinish, self)
		self.viewContainer:getTowerTimeLimitLevelInfoView():refreshUI()
	end

	self:playOpenAndSwitchItemAnim(episodeItem)

	self.lastSelectEntranceId = episodeItem.entranceId
	self.isOpenDetail = true

	self:setCloseOverrideFunc()
	self:refreshDetailShowUI()
end

function TowerTimeLimitLevelView:openDetailFinish()
	UIBlockMgr.instance:endBlock(TowerTimeLimitLevelView.AnimBlock)
	gohelper.setActive(self._btncloseDetail.gameObject, true)
end

function TowerTimeLimitLevelView:_btnTaskClick()
	local param = {}

	param.towerType = TowerEnum.TowerType.Limited
	param.towerId = self.seasonId

	TowerController.instance:openTowerTaskView(param)
end

function TowerTimeLimitLevelView:_btnBossClick()
	TowerController.instance:openAssistBossView(nil, nil, TowerEnum.TowerType.Limited, self.seasonId)
end

function TowerTimeLimitLevelView:_editableInitView()
	self.goRoot = gohelper.findChild(self.viewGO, "root")
	self.rootAnimtorPlayer = ZProj.ProjAnimatorPlayer.Get(self.goRoot)
	self.episodeTab = self:getUserDataTb_()
	self.bossItemTab = self:getUserDataTb_()

	self:initEpisodeItem()
	TowerTimeLimitLevelModel.instance:initDifficultyMulti()

	self.isOpenDetail = false

	gohelper.setActive(self._btncloseDetail.gameObject, false)

	self.lastSelectEntranceId = 0
end

function TowerTimeLimitLevelView:initEpisodeItem()
	for i = 1, 3 do
		local episodeItem = {}

		episodeItem.entranceId = i
		episodeItem.go = gohelper.findChild(self.viewGO, "root/main/episodeNode/episode" .. i)
		episodeItem.goSelect = gohelper.findChild(episodeItem.go, "go_select")
		episodeItem.goFinish = gohelper.findChild(episodeItem.go, "go_finish")
		episodeItem.goEnemy = gohelper.findChild(episodeItem.go, "go_finish/group/enemy")
		episodeItem.simageEnemy = gohelper.findChildSingleImage(episodeItem.go, "go_finish/group/enemy/simage_enemy")
		episodeItem.goHeroContent = gohelper.findChild(episodeItem.go, "go_finish/group/hero")
		episodeItem.goHeroItem = gohelper.findChild(episodeItem.go, "go_finish/group/hero/heroItem")
		episodeItem.txtScore = gohelper.findChildText(episodeItem.go, "go_finish/score/txt_score")
		episodeItem.goScore = gohelper.findChild(episodeItem.go, "go_finish/score")
		episodeItem.goPointContent = gohelper.findChild(episodeItem.go, "go_finish/score/go_PointContent")
		episodeItem.goPointItem = gohelper.findChild(episodeItem.go, "go_finish/score/go_PointContent/go_PointItem")
		episodeItem.goPointItemLight = gohelper.findChild(episodeItem.go, "go_finish/score/go_PointContent/go_PointItem/ani")
		episodeItem.goPointItemGrey = gohelper.findChild(episodeItem.go, "go_finish/score/go_PointContent/go_PointItem/grey")
		episodeItem.btnClick = gohelper.findChildButtonWithAudio(episodeItem.go, "click")

		episodeItem.btnClick:AddClickListener(self._btnEpisodeItemClick, self, episodeItem)

		episodeItem.curDifficulty = TowerEnum.Difficulty.Easy
		episodeItem.heroItemTab = self:getUserDataTb_()
		episodeItem.anim = episodeItem.go:GetComponent(gohelper.Type_Animator)
		episodeItem.canvasGroup = episodeItem.go:GetComponent(gohelper.Type_CanvasGroup)
		episodeItem.canvasGroup.alpha = 1

		gohelper.setActive(episodeItem.goHeroItem, false)
		table.insert(self.episodeTab, episodeItem)
	end
end

function TowerTimeLimitLevelView:onUpdateParam()
	return
end

function TowerTimeLimitLevelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mln_day_night)
	RedDotController.instance:addRedDot(self._goTaskReddot, RedDotEnum.DotNode.TowerTask)
	gohelper.setActive(self._godetailInfo.gameObject, false)
	self:refreshUI()
	self:setCloseOverrideFunc()
end

function TowerTimeLimitLevelView:refreshUI()
	local curOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if curOpenMo then
		self.seasonId = curOpenMo.towerId

		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.NewTimeLimitOpen, curOpenMo.id, curOpenMo, TowerEnum.UnlockKey)
	else
		GameFacade.showToast(ToastEnum.TowerTimeLimitEnd)
		self:closeThis()

		return
	end

	self:refreshEpisode()
	self:refreshTotalScore()
	self:refreshRemainTime()
	self:refreshAssistBoss()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
end

function TowerTimeLimitLevelView:refreshEpisode()
	local towerInfoMo = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, self.seasonId)

	self.totalScore = 0

	for entranceId, episodeItem in ipairs(self.episodeTab) do
		local towerCoList = TowerConfig.instance:getTowerLimitedTimeCoList(self.seasonId, entranceId)
		local layerId = towerCoList[1].layerId
		local curMaxScore = towerInfoMo:getLayerScore(layerId)
		local subEpisodeMoList = towerInfoMo:getLayerSubEpisodeList(layerId)

		if subEpisodeMoList then
			if not subEpisodeMoList[1].assistBossId then
				local assistBossId = 0

				if subEpisodeMoList then
					if not subEpisodeMoList[1].heroIds then
						local heroIdList = {}
						local curSelectEntrance = TowerTimeLimitLevelModel.instance.curSelectEntrance

						gohelper.setActive(episodeItem.goSelect, curSelectEntrance == entranceId)
						gohelper.setActive(episodeItem.goFinish, heroIdList and #heroIdList > 0)
						gohelper.setActive(episodeItem.goEnemy, assistBossId > 0)
						gohelper.setActive(episodeItem.goHeroContent, heroIdList and #heroIdList > 0)

						episodeItem.txtScore.text = curMaxScore

						local starLevel = TowerConfig.instance:getScoreToStarConfig(curMaxScore)

						gohelper.setActive(episodeItem.goScore, curMaxScore > 0)
						gohelper.setActive(episodeItem.goPointItemLight, starLevel > 0)
						gohelper.setActive(episodeItem.goPointItemGrey, starLevel == 0)

						if starLevel > 0 then
							local starLevelList = {}

							for i = 1, Mathf.Min(starLevel, TowerEnum.MaxShowStarNum) do
								table.insert(starLevelList, i)
							end

							gohelper.CreateObjList(self, self.scoreStarShow, starLevelList, episodeItem.goPointContent, episodeItem.goPointItem)
						end

						if assistBossId > 0 then
							local assistBossConfig = TowerConfig.instance:getAssistBossConfig(assistBossId)
							local skinConfig = FightConfig.instance:getSkinCO(assistBossConfig.skinId)

							episodeItem.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))
						end

						for index, heroId in ipairs(heroIdList) do
							if not episodeItem.heroItemTab[index] then
								episodeItem.heroItemTab[index] = {}
								episodeItem.heroItemTab[index].go = gohelper.clone(episodeItem.goHeroItem, episodeItem.goHeroContent, "heroItem" .. index)
								episodeItem.heroItemTab[index].simageHero = gohelper.findChildSingleImage(episodeItem.heroItemTab[index].go, "simage_hero")
							end

							gohelper.setActive(episodeItem.heroItemTab[index].go, true)

							local heroMO = HeroModel.instance:getByHeroId(heroId)

							if heroMO then
								local skinConfig = FightConfig.instance:getSkinCO(heroMO.skin)

								episodeItem.heroItemTab[index].simageHero:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))
							else
								local heroCo = HeroConfig.instance:getHeroCO(heroId)
								local skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)

								episodeItem.heroItemTab[index].simageHero:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))
							end
						end

						for i = #heroIdList + 1, #episodeItem.heroItemTab do
							gohelper.setActive(episodeItem.heroItemTab[i].go, false)
						end

						self.totalScore = self.totalScore + curMaxScore
					end
				end
			end
		end
	end
end

function TowerTimeLimitLevelView:scoreStarShow(obj, data, index)
	gohelper.setActive(obj, index <= data)
end

function TowerTimeLimitLevelView:refreshTotalScore()
	local TaskMoList = TowerTaskModel.instance.limitTimeTaskList

	self.taskFinishCount = TowerTaskModel.instance:getTaskItemRewardCount(TaskMoList)

	gohelper.CreateObjList(self, self.taskProgressShow, TaskMoList, self._goTaskPointContent, self._goTaskPointItem)

	self._txtscore.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_curtotalscore"), {
		self.totalScore
	})

	local timeLimitTaskList = TowerTaskModel.instance:getCurTaskList(TowerEnum.TowerType.Limited)
	local finishCount = TowerTaskModel.instance:getTaskItemRewardCount(timeLimitTaskList)

	self._txtTaskNum.text = string.format("%s/%s", finishCount, #timeLimitTaskList)
end

function TowerTimeLimitLevelView:taskProgressShow(obj, data, index)
	local light = gohelper.findChild(obj, "go_light")

	gohelper.setActive(light, index <= self.taskFinishCount)
end

function TowerTimeLimitLevelView:refreshRemainTime()
	local towerOpenMo = TowerModel.instance:getTowerOpenInfo(TowerEnum.TowerType.Limited, self.seasonId, TowerEnum.TowerStatus.Open)
	local remainTimeStamp = towerOpenMo.nextTime / 1000 - ServerTime.now()
	local date, dateformate = TimeUtil.secondToRoughTime2(remainTimeStamp, true)

	self._txttime.text = remainTimeStamp > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
		date,
		dateformate
	}) or ""
end

function TowerTimeLimitLevelView:refreshAssistBoss()
	local limitedTimeCo = TowerConfig.instance:getTowerLimitedTimeCo(self.seasonId)
	local bossIdList = string.splitToNumber(limitedTimeCo.bossPool, "#")

	self.entranceBossUseMap = TowerTimeLimitLevelModel.instance:getEntranceBossUsedMap(self.seasonId)

	gohelper.CreateObjList(self, self.bossItemShow, bossIdList, self._gobossContent, self._gobossItem)

	if ViewMgr.instance:isOpen(ViewName.TowerAssistBossView) then
		TowerController.instance:openAssistBossView(nil, nil, TowerEnum.TowerType.Limited, self.seasonId)
	end
end

function TowerTimeLimitLevelView:bossItemShow(obj, data, index)
	local bossItem = self.bossItemTab[index]

	if not bossItem then
		bossItem = {}
		self.bossItemTab[index] = bossItem
	end

	bossItem.go = obj
	bossItem.simageEnemy = gohelper.findChildSingleImage(bossItem.go, "simage_enemy")
	bossItem.imageCareer = gohelper.findChildImage(bossItem.go, "image_career")
	bossItem.goUsed = gohelper.findChild(bossItem.go, "go_used")
	bossItem.txtOrder = gohelper.findChildText(bossItem.go, "go_used/txt_order")

	local assistBossConfig = TowerConfig.instance:getAssistBossConfig(data)
	local skinConfig = FightConfig.instance:getSkinCO(assistBossConfig.skinId)

	bossItem.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))
	UISpriteSetMgr.instance:setEnemyInfoSprite(bossItem.imageCareer, "sxy_" .. tostring(assistBossConfig.career))

	local usedEntranceId = 0

	for entranceId, bossId in pairs(self.entranceBossUseMap) do
		if bossId == data then
			usedEntranceId = entranceId

			break
		end
	end

	gohelper.setActive(bossItem.goUsed, usedEntranceId > 0)

	bossItem.txtOrder.text = usedEntranceId > 0 and usedEntranceId or ""
end

function TowerTimeLimitLevelView:refreshDetailShowUI()
	gohelper.setActive(self._godetailInfo.gameObject, self.isOpenDetail)
	gohelper.setActive(self._goBoss, not self.isOpenDetail)
	gohelper.setActive(self._btncloseDetail.gameObject, self.isOpenDetail)

	local curSelectEntrance = TowerTimeLimitLevelModel.instance.curSelectEntrance

	for entrance, episodeItem in pairs(self.episodeTab) do
		gohelper.setActive(episodeItem.goSelect, entrance == curSelectEntrance)
	end
end

function TowerTimeLimitLevelView:playOpenAndSwitchItemAnim(episodeItem)
	if self.lastSelectEntranceId ~= episodeItem.entranceId then
		episodeItem.anim:Play(UIAnimationName.Open, 0, 0)

		if self.isOpenDetail then
			if self["itemTweenId" .. episodeItem.entranceId] then
				ZProj.TweenHelper.KillById(self["itemTweenId" .. episodeItem.entranceId])
			end

			self["itemTweenId" .. episodeItem.entranceId] = ZProj.TweenHelper.DOFadeCanvasGroup(self.episodeTab[episodeItem.entranceId].go, TowerTimeLimitLevelView.fadeItemAlpha, 1, TowerTimeLimitLevelView.OpenDetailTime)
		end

		if self.lastSelectEntranceId ~= 0 then
			self.rootAnimtorPlayer:Play(UIAnimationName.Switch)
			self.episodeTab[self.lastSelectEntranceId].anim:Play(UIAnimationName.Close, 0, 0)

			if self["itemTweenId" .. self.lastSelectEntranceId] then
				ZProj.TweenHelper.KillById(self["itemTweenId" .. self.lastSelectEntranceId])
			end

			self["itemTweenId" .. self.lastSelectEntranceId] = ZProj.TweenHelper.DOFadeCanvasGroup(self.episodeTab[self.lastSelectEntranceId].go, 1, TowerTimeLimitLevelView.fadeItemAlpha, TowerTimeLimitLevelView.closeDetailTime)
		end

		for entranceId, item in ipairs(self.episodeTab) do
			if self.lastSelectEntranceId > 0 then
				if entranceId ~= episodeItem.entranceId and entranceId ~= self.lastSelectEntranceId then
					item.anim:Play(UIAnimationName.Idle, 0, 0)

					item.canvasGroup.alpha = TowerTimeLimitLevelView.fadeItemAlpha
				end
			elseif entranceId ~= episodeItem.entranceId then
				if self["itemTweenId" .. entranceId] then
					ZProj.TweenHelper.KillById(self["itemTweenId" .. entranceId])
				end

				self["itemTweenId" .. entranceId] = ZProj.TweenHelper.DOFadeCanvasGroup(self.episodeTab[entranceId].go, 1, TowerTimeLimitLevelView.fadeItemAlpha, TowerTimeLimitLevelView.OpenDetailTime)
			end
		end
	end
end

function TowerTimeLimitLevelView:playCloseItemAnim()
	self.episodeTab[self.lastSelectEntranceId].anim:Play(UIAnimationName.Close, 0, 0)

	for entrance, episodeItem in pairs(self.episodeTab) do
		if entrance ~= self.lastSelectEntranceId then
			if self["itemTweenId" .. entrance] then
				ZProj.TweenHelper.KillById(self["itemTweenId" .. entrance])
			end

			self["itemTweenId" .. entrance] = ZProj.TweenHelper.DOFadeCanvasGroup(episodeItem.go, TowerTimeLimitLevelView.fadeItemAlpha, 1, TowerTimeLimitLevelView.closeToNormalTime)
		end
	end
end

function TowerTimeLimitLevelView:setCloseOverrideFunc()
	if self.isOpenDetail then
		self.viewContainer:setOverrideCloseClick(self._btncloseDetailOnClick, self)
	else
		self.viewContainer:setOverrideCloseClick(self.closeThis, self)
	end
end

function TowerTimeLimitLevelView:onClose()
	TowerTimeLimitLevelModel.instance:cleanData()
	self.rootAnimtorPlayer:Stop()

	for entrance = 1, 3 do
		if self["itemTweenId" .. entrance] then
			ZProj.TweenHelper.KillById(self["itemTweenId" .. entrance])
		end
	end

	TowerModel.instance:cleanTrialData()
end

function TowerTimeLimitLevelView:onDestroyView()
	for index, episodeItem in pairs(self.episodeTab) do
		episodeItem.simageEnemy:UnLoadImage()
		episodeItem.btnClick:RemoveClickListener()

		for _, heroItem in pairs(episodeItem.heroItemTab) do
			heroItem.simageHero:UnLoadImage()
		end
	end

	for index, bossItem in pairs(self.bossItemTab) do
		bossItem.simageEnemy:UnLoadImage()
	end
end

return TowerTimeLimitLevelView
