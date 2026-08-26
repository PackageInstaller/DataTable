-- chunkname: @modules/logic/tower/view/TowerMainView.lua

module("modules.logic.tower.view.TowerMainView", package.seeall)

local TowerMainView = class("TowerMainView", BaseView)

function TowerMainView:onInitView()
	self._txttitle = gohelper.findChildText(self.viewGO, "centerTitle/#txt_title")
	self._txttitleEn = gohelper.findChildText(self.viewGO, "centerTitle/#txt_titleEn")
	self._goupdateTime = gohelper.findChild(self.viewGO, "limitTimeEpisode/#go_updateTime")
	self._golimitTimeUpdateTime = gohelper.findChild(self.viewGO, "limitTimeEpisode/#go_limitTimeUpdateTime")
	self._txtlimitTimeUpdateTime = gohelper.findChildText(self.viewGO, "limitTimeEpisode/#go_limitTimeUpdateTime/#txt_limitTimeUpdateTime")
	self._golimitTimeHasNew = gohelper.findChild(self.viewGO, "limitTimeEpisode/#go_limitTimeHasNew")
	self._btnlimitTime = gohelper.findChildButtonWithAudio(self.viewGO, "limitTimeEpisode/#btn_limitTime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "task/#btn_task")
	self._gotaskReddot = gohelper.findChild(self.viewGO, "task/#go_taskReddot")
	self._gotaskNew = gohelper.findChild(self.viewGO, "task/#go_taskNew")
	self._gobossUpdateTime = gohelper.findChild(self.viewGO, "bossEpisode/#go_bossUpdateTime")
	self._txtbossUpdateTime = gohelper.findChildText(self.viewGO, "bossEpisode/#go_bossUpdateTime/#txt_bossUpdateTime")
	self._gobossHasNew = gohelper.findChild(self.viewGO, "bossEpisode/#go_bossHasNew")
	self._btnboss = gohelper.findChildButtonWithAudio(self.viewGO, "bossEpisode/#btn_boss")
	self._gobossContent = gohelper.findChild(self.viewGO, "bossEpisode/#go_bossContent")
	self._gobossItem = gohelper.findChild(self.viewGO, "bossEpisode/#go_bossContent/#go_bossItem")
	self._gobossLockTips = gohelper.findChild(self.viewGO, "bossEpisode/#go_locktips")
	self._txtaltitudeNum = gohelper.findChildText(self.viewGO, "permanentEpisode/progress/#txt_altitudeNum")
	self._goprogressContent = gohelper.findChild(self.viewGO, "permanentEpisode/progress/#go_progressContent")
	self._goprogressItem = gohelper.findChild(self.viewGO, "permanentEpisode/progress/#go_progressContent/#go_progressItem")
	self._btnpermanent = gohelper.findChildButtonWithAudio(self.viewGO, "permanentEpisode/#btn_permanent")
	self._gopermanentReddot = gohelper.findChild(self.viewGO, "permanentEpisode/#btn_permanent/#go_permanentReddot")
	self._goticket = gohelper.findChild(self.viewGO, "permanentEpisode/ticket")
	self._imageticket = gohelper.findChildImage(self.viewGO, "permanentEpisode/ticket/#image_ticket")
	self._txtticketNum = gohelper.findChildText(self.viewGO, "permanentEpisode/ticket/#txt_ticketNum")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._golimitTimeLockTips = gohelper.findChild(self.viewGO, "limitTimeEpisode/#go_limitTimeLockTips")
	self._txtlimitTimeLockTips = gohelper.findChildText(self.viewGO, "limitTimeEpisode/#go_limitTimeLockTips/#txt_limitTimeLockTips")
	self._gobossLockTips = gohelper.findChild(self.viewGO, "bossEpisode/#go_bossLockTips")
	self._txtbossLockTips = gohelper.findChildText(self.viewGO, "bossEpisode/#go_bossLockTips/#txt_bossLockTips")
	self._gomopUpReddot = gohelper.findChild(self.viewGO, "permanentEpisode/ticket/#go_mopupReddot")
	self._btnmopUp = gohelper.findChildButtonWithAudio(self.viewGO, "permanentEpisode/ticket/#btn_mopup")
	self._gostore = gohelper.findChild(self.viewGO, "store")
	self._gostoreTime = gohelper.findChild(self.viewGO, "store/time")
	self._txtstoreTime = gohelper.findChildText(self.viewGO, "store/time/#txt_storeTime")
	self._txtstoreName = gohelper.findChildText(self.viewGO, "store/#txt_storeName")
	self._txtcoinNum = gohelper.findChildText(self.viewGO, "store/#txt_coinNum")
	self._imagecoin = gohelper.findChildImage(self.viewGO, "store/#txt_coinNum/#image_coin")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "store/#btn_store")
	self._goheroTrial = gohelper.findChild(self.viewGO, "heroTrial")
	self._btnheroTrial = gohelper.findChildButtonWithAudio(self.viewGO, "heroTrial/#btn_heroTrial")
	self._goheroTrialNew = gohelper.findChild(self.viewGO, "heroTrial/#go_heroTrialNew")
	self._goheroTrialNewEffect = gohelper.findChild(self.viewGO, "heroTrial/#saoguang")
	self._goachievement = gohelper.findChild(self.viewGO, "achievement")
	self._goachievementIcon = gohelper.findChild(self.viewGO, "achievement/go_icon")
	self._btnachievement = gohelper.findChildButton(self.viewGO, "achievement/#btn_Click")
	self._btntowerCompose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_towercompose")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerMainView:addEvents()
	self._btnlimitTime:AddClickListener(self._btnlimitTimeOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnboss:AddClickListener(self._btnbossOnClick, self)
	self._btnpermanent:AddClickListener(self._btnpermanentOnClick, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self._btnheroTrial:AddClickListener(self._btnheroTrialOnClick, self)
	self._btnmopUp:AddClickListener(self._btnmopupOnClick, self)
	self._btnachievement:AddClickListener(self._btnonachievementClick, self)
	self._btntowerCompose:AddClickListener(self._btntowerComposeOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.onDailyReresh, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.LocalKeyChange, self.onLocalKeyChange, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.refreshRewardTaskInfo, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerMopUp, self.refreshPermanentInfo, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStore, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self.refreshStore, self)
	self.addEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshHeroTrialNew, self.refreshHeroTrialNew, self)
end

function TowerMainView:removeEvents()
	self._btnlimitTime:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btnboss:RemoveClickListener()
	self._btnpermanent:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self._btnheroTrial:RemoveClickListener()
	self._btnmopUp:RemoveClickListener()
	self._btnachievement:RemoveClickListener()
	self._btntowerCompose:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.onDailyReresh, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.LocalKeyChange, self.onLocalKeyChange, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.refreshRewardTaskInfo, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerMopUp, self.refreshPermanentInfo, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStore, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self.refreshStore, self)
	self.removeEventCb(self, TowerComposeController.instance, TowerComposeEvent.RefreshHeroTrialNew, self.refreshHeroTrialNew, self)
	TaskDispatcher.cancelTask(self.refreshTowerState, self)
end

function TowerMainView:_btnonachievementClick()
	ViewMgr.instance:openView(ViewName.AchievementNamePlatePanelView, {
		taskCo = self._maxTaskAchievementCo
	})
end

function TowerMainView:_btnlimitTimeOnClick()
	local curTimeLimitTowerOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if not curTimeLimitTowerOpenMo then
		GameFacade.showToast(ToastEnum.TowerTimeLimitEnd)

		return
	end

	if not TowerController.instance:isTimeLimitTowerOpen() then
		local layerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)

		GameFacade.showToast(ToastEnum.TowerBossLockTips, layerNum)

		return
	end

	TowerController.instance:openTowerTimeLimitLevelView()
end

function TowerMainView:_btntaskOnClick()
	TowerController.instance:openTowerTaskView()
end

function TowerMainView:_btnstoreOnClick()
	TowerController.instance:openTowerStoreView()
end

function TowerMainView:_btnbossOnClick()
	if not TowerController.instance:isBossTowerOpen() then
		local layerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

		GameFacade.showToast(ToastEnum.TowerBossLockTips, layerNum)

		return
	end

	local isBossTowerStateOpen = TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss)

	if not isBossTowerStateOpen then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSelectView)
end

function TowerMainView:_btnpermanentOnClick()
	TowerController.instance:openTowerPermanentView()
end

function TowerMainView:_btnheroTrialOnClick()
	TowerController.instance:openTowerHeroTrialView({
		trialType = TowerEnum.HeroTrialEntranceType.Normal
	})
	self:saveHeroTrialNew()
	gohelper.setActive(self._goheroTrialNew, false)
end

function TowerMainView:_btnmopupOnClick()
	TowerController.instance:openTowerMopUpView()
end

function TowerMainView:_btntowerComposeOnClick()
	local param = {}

	param.targetModeType = TowerComposeEnum.TowerMainType.NewTower
	param.needCloseViewName = ViewName.TowerMainView

	self.viewAnim:Play("change", 0, 0)
	self.viewAnim:Update(0)
	TowerComposeController.instance:openTowerModeChangeView(param)
end

function TowerMainView:_editableInitView()
	self.bossItemTab = self:getUserDataTb_()

	self:_initLevelItems()
	gohelper.setActive(self._goheroTrialNewEffect, false)

	self._goLimitTimeEpisode = gohelper.findChild(self.viewGO, "limitTimeEpisode")
	self._goTask = gohelper.findChild(self.viewGO, "task")
	self.viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function TowerMainView:_initLevelItems()
	self.levelItemList = {}

	for i = 1, 3 do
		local item = {}

		item.go = gohelper.findChild(self._goachievementIcon, "level" .. i)
		item.unlock = gohelper.findChild(item.go, "#go_UnLocked")
		item.lock = gohelper.findChild(item.go, "#go_Locked")
		item.gounlockbg = gohelper.findChild(item.unlock, "#simage_bg")
		item.simageunlocktitle = gohelper.findChildSingleImage(item.unlock, "#simage_title")
		item.txtunlocklevel = gohelper.findChildText(item.unlock, "#txt_level")
		item.simagelockbg = gohelper.findChildSingleImage(item.lock, "#simage_bg")
		item.simagelocktitle = gohelper.findChildSingleImage(item.lock, "#simage_title")
		item.txtlocklevel = gohelper.findChildText(item.lock, "#txt_level")

		gohelper.setActive(item.go, false)
		table.insert(self.levelItemList, item)
	end
end

function TowerMainView:onDailyReresh()
	self:refreshUI()
end

function TowerMainView:onLocalKeyChange()
	self:refreshBossNewTag()
	self:refreshLimitedActTaskNew()
end

function TowerMainView:onUpdateParam()
	self:checkJump()
end

function TowerMainView:onOpen()
	TowerModel.instance:cleanTrialData()
	self:checkJump()
	self:refreshUI()
	self:initReddot()
	TaskDispatcher.runDelay(self.checkShowEffect, self, 0.6)

	if ViewMgr.instance:isOpen(ViewName.TowerModeChangeView) then
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.CloseModeChangeView)
	end
end

function TowerMainView:checkShowEffect()
	local saveShowTrialHeroEffect = TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.TowerMainHeroTrialEffect, 0)
	local canShowTrialHeroEffect = saveShowTrialHeroEffect == 0

	gohelper.setActive(self._goheroTrialNewEffect, canShowTrialHeroEffect)
end

function TowerMainView:initReddot()
	RedDotController.instance:addRedDot(self._gomopUpReddot, RedDotEnum.DotNode.TowerMopUp)
	RedDotController.instance:addRedDot(self._gotaskReddot, RedDotEnum.DotNode.TowerTask)
	RedDotController.instance:addRedDot(self._gopermanentReddot, RedDotEnum.DotNode.TowerDeepTask)
	TowerController.instance:saveNewUpdateTowerReddot()
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTowerReddot)
	TowerController.instance:checkNewUpdateTowerRddotShow()
end

function TowerMainView:refreshUI()
	gohelper.setActive(self._golimitTimeHasNew, false)
	gohelper.setActive(self._golimitTimeUpdateTime, false)
	gohelper.setActive(self._gobossHasNew, false)
	gohelper.setActive(self._gobossUpdateTime, false)
	self:refreshPermanentInfo()
	self:initTaskInfo()
	self:refreshRewardTaskInfo()
	self:refreshBossInfo()
	self:refreshBossNewTag()
	self:refreshEntranceUI()
	self:refreshTowerState()
	self:refreshStore()
	self:refreshHeroTrialNew()
	self:refreshLimitedActTaskNew()
	self:refreshNamePlate()
	TaskDispatcher.cancelTask(self.refreshTowerState, self)
	TaskDispatcher.runRepeat(self.refreshTowerState, self, 1)
end

function TowerMainView:refreshNamePlate()
	local config = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.Tower)
	local achievementJumpId = config and config.achievementJumpId
	local jumpCo = JumpConfig.instance:getJumpConfig(achievementJumpId)
	local jumpParam = jumpCo and jumpCo.param

	self._maxTaskAchievementCo = nil

	if not string.nilorempty(jumpParam) then
		local temp = string.splitToNumber(jumpParam, "#")
		local achievementId = temp and temp[3]
		local achievementCfg = AchievementConfig.instance:getAchievement(achievementId)

		if not string.nilorempty(achievementId) then
			self._maxTaskAchievementCo = AchievementController.instance:getMaxLevelFinishTask(achievementId)

			local taskMO = AchievementModel.instance:getById(self._maxTaskAchievementCo.id)
			local taskHasFinished = taskMO and taskMO.hasFinished
			local item = self.levelItemList[self._maxTaskAchievementCo.level]

			gohelper.setActive(item.go, true)
			gohelper.setActive(item.unlock, taskHasFinished)
			gohelper.setActive(item.lock, not taskHasFinished)

			local prefabName, titlebgName, bgName

			if self._maxTaskAchievementCo.image and not string.nilorempty(self._maxTaskAchievementCo.image) then
				local temp = string.split(self._maxTaskAchievementCo.image, "#")

				prefabName = temp[1]
				titlebgName = temp[2]
				bgName = temp[3]
			end

			if taskHasFinished then
				local function callback()
					local go = item._bgLoader:getInstGO()
				end

				item._bgLoader = PrefabInstantiate.Create(item.gounlockbg)

				item._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(prefabName), callback, self)
				item.simageunlocktitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))
			else
				item.simagelockbg:LoadImage(ResUrl.getAchievementIcon(bgName))
				item.simagelocktitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))
			end

			local listenerType = self._maxTaskAchievementCo.listenerType
			local maxProgress = AchievementUtils.getAchievementProgressBySourceType(achievementCfg.rule)
			local num

			if listenerType and listenerType == "TowerPassLayer" then
				if self._maxTaskAchievementCo.listenerParam and not string.nilorempty(self._maxTaskAchievementCo.listenerParam) then
					local temp = string.split(self._maxTaskAchievementCo.listenerParam, "#")

					num = temp and temp[3]
					num = num * 10
				end
			else
				num = self._maxTaskAchievementCo and self._maxTaskAchievementCo.maxProgress
			end

			if taskHasFinished then
				item.txtunlocklevel.text = num < maxProgress and maxProgress or num
				item.txtlocklevel.text = num < maxProgress and maxProgress or num
			else
				item.txtunlocklevel.text = num < maxProgress and num or maxProgress
				item.txtlocklevel.text = num < maxProgress and num or maxProgress
			end
		end
	end
end

function TowerMainView:checkJump()
	if not self.viewParam then
		return
	end

	local fightParam = TowerModel.instance:getRecordFightParam()
	local jumpId = self.viewParam.jumpId

	if jumpId == TowerEnum.JumpId.TowerPermanent then
		if tabletool.len(fightParam) > 0 and (fightParam.towerType == TowerEnum.TowerType.Normal or not fightParam.towerType) then
			TowerPermanentModel.instance:setLastPassLayer(fightParam.layerId)
			TowerController.instance:openTowerPermanentView(fightParam)
		else
			self:_btnpermanentOnClick()
		end
	elseif jumpId == TowerEnum.JumpId.TowerBoss then
		if not self.viewParam.towerId then
			ViewMgr.instance:openView(ViewName.TowerBossSelectView)
		else
			TowerController.instance:openBossTowerEpisodeView(TowerEnum.TowerType.Boss, self.viewParam.towerId, {
				passLayerId = self.viewParam.passLayerId
			})
		end
	elseif jumpId == TowerEnum.JumpId.TowerLimited then
		self:_btnlimitTimeOnClick()
	elseif jumpId == TowerEnum.JumpId.TowerBossTeach then
		local lastFightTeachId = TowerBossTeachModel.instance:getLastFightTeachId()

		TowerController.instance:openBossTowerEpisodeView(TowerEnum.TowerType.Boss, self.viewParam.towerId, {
			isTeach = true,
			lastFightTeachId = lastFightTeachId
		})
		TowerBossTeachModel.instance:setLastFightTeachId(0)
	end

	if self.viewParam.jumpId then
		self.viewParam.jumpId = nil
	end
end

function TowerMainView:refreshEntranceUI()
	local permanentPassLayerNum = TowerPermanentModel.instance:getCurPermanentPassLayer()
	local taskRewardOpenLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TaskRewardOpen)
	local limitTaskList = TowerTaskModel.instance.limitTimeTaskList
	local bossTaskList = TowerTaskModel.instance.bossTaskList
	local taskNum = tabletool.len(limitTaskList) + tabletool.len(bossTaskList)
	local mopUpOpenLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)

	gohelper.setActive(self._goticket, permanentPassLayerNum >= tonumber(mopUpOpenLayerNum))
end

function TowerMainView:initTaskInfo()
	local towerTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}

	TowerTaskModel.instance:setTaskInfoList(towerTasks)
	TowerDeepTaskModel.instance:setTaskInfoList()
end

function TowerMainView:refreshPermanentInfo()
	local curMopUpTimes = TowerModel.instance:getMopUpTimes()
	local maxMopUpTimes = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)

	self._txtticketNum.text = string.format("<color=#EA9465>%s</color>/%s", curMopUpTimes, maxMopUpTimes)

	local ticketId = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageticket, ticketId .. "_1", true)

	self.curPassLayer = TowerPermanentModel.instance.curPassLayer

	local permanentCo = TowerConfig.instance:getPermanentEpisodeCo(self.curPassLayer)
	local nextPermanentCo = TowerConfig.instance:getPermanentEpisodeCo(self.curPassLayer + 1)
	local curMaxPassEpisodeId = TowerPermanentModel.instance:getCurPassEpisodeId()

	if curMaxPassEpisodeId == 0 then
		self._txtaltitudeNum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_defaultlayer"), {
			0
		})
	else
		local maxDeepHigh = TowerPermanentDeepModel.instance:getCurMaxDeepHigh()
		local defaultDeep = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)
		local isOpenEndless = TowerPermanentDeepModel.instance.isOpenEndless

		if defaultDeep < maxDeepHigh or isOpenEndless then
			self._txtaltitudeNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towermain_deeplayer"), maxDeepHigh)
		else
			local episodeConfig = DungeonConfig.instance:getEpisodeCO(curMaxPassEpisodeId)

			self._txtaltitudeNum.text = episodeConfig.name
		end
	end

	local stageCount = TowerPermanentModel.instance:getStageCount()

	if permanentCo then
		if not permanentCo.stageId then
			local curStageId = 1

			if nextPermanentCo then
				if not nextPermanentCo.stageId then
					local nextStageId = curStageId + 1
					local stageInfoList = {}

					for i = 1, stageCount do
						local stageInfo = {}

						stageInfo.curstageId = curStageId == nextStageId and curStageId or nextStageId

						table.insert(stageInfoList, stageInfo)
					end

					gohelper.CreateObjList(self, self.progressItemShow, stageInfoList, self._goprogressContent, self._goprogressItem)
				end
			end
		end
	end
end

function TowerMainView:progressItemShow(obj, data, index)
	local goNormal = gohelper.findChild(obj, "go_normal")
	local goFinish = gohelper.findChild(obj, "go_finish")
	local curStageId = data.curstageId

	gohelper.setActive(goNormal, curStageId <= index)
	gohelper.setActive(goFinish, index < curStageId)
end

function TowerMainView:refreshRewardTaskInfo()
	return
end

function TowerMainView:refreshBossInfo()
	local bossTowerOpenMoList = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)
	local bossList = {}

	if #bossTowerOpenMoList > 0 then
		table.sort(bossTowerOpenMoList, TowerAssistBossModel.sortBossList)

		for i = 1, 3 do
			if bossTowerOpenMoList[i] then
				table.insert(bossList, bossTowerOpenMoList[i])
			end
		end
	end

	self.bossEpisodeMo = TowerModel.instance:getEpisodeMoByTowerType(TowerEnum.TowerType.Boss)

	gohelper.CreateObjList(self, self.bossItemShow, bossList, self._gobossContent, self._gobossItem)

	local bossIsOpen = TowerController.instance:isBossTowerOpen()

	gohelper.setActive(self._gobossContent, bossIsOpen)
	gohelper.setActive(self._gobossLockTips, not bossIsOpen)
end

function TowerMainView:refreshBossNewTag()
	local hasNew = false

	gohelper.setActive(self._gobossHasNew, hasNew)
end

function TowerMainView:bossItemShow(obj, data, index)
	local bossItem = self.bossItemTab[index]

	if not bossItem then
		bossItem = {}
		self.bossItemTab[index] = bossItem
	end

	bossItem.go = obj
	bossItem.simageEnemy = gohelper.findChildSingleImage(bossItem.go, "Mask/image_bossIcon")
	bossItem.goSelected = gohelper.findChild(bossItem.go, "#go_Selected")

	local bossConfig = TowerConfig.instance:getBossTowerConfig(data.id)
	local bossId = bossConfig.bossId
	local assistBossConfig = TowerConfig.instance:getAssistBossConfig(bossId)
	local skinConfig = FightConfig.instance:getSkinCO(assistBossConfig.skinId)

	bossItem.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(skinConfig and skinConfig.headIcon))

	local isPassAll = self.bossEpisodeMo:isPassAllUnlockLayers(data.id)

	gohelper.setActive(bossItem.goSelected, not isPassAll)
end

function TowerMainView:refreshTowerState()
	local curTimeLimitTowerOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local isTimeLimitTowerOpenLayer = TowerController.instance:isTimeLimitTowerOpen()
	local localTimeNewState = TowerEnum.LockKey
	local timeLimitTimeStamp = 0

	if curTimeLimitTowerOpenMo then
		localTimeNewState = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewTimeLimitOpen, curTimeLimitTowerOpenMo.id, curTimeLimitTowerOpenMo, TowerEnum.LockKey)
		timeLimitTimeStamp = curTimeLimitTowerOpenMo.nextTime / 1000 - ServerTime.now()

		local date, dateformate = TimeUtil.secondToRoughTime2(timeLimitTimeStamp)

		self._txtlimitTimeUpdateTime.text = timeLimitTimeStamp > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
			date,
			dateformate
		}) or ""
	end

	gohelper.setActive(self._golimitTimeHasNew, false)
	gohelper.setActive(self._golimitTimeUpdateTime, false)

	local timeLimitLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)

	if not curTimeLimitTowerOpenMo then
		local minTimeStampMo = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Limited)

		if minTimeStampMo then
			local minTimeLimitTimeStamp = minTimeStampMo.nextTime / 1000 - ServerTime.now()
			local minDate, minDateformate = TimeUtil.secondToRoughTime2(minTimeLimitTimeStamp)

			self._txtlimitTimeLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				minDate,
				minDateformate
			})
		else
			self._txtlimitTimeLockTips.text = luaLang("towermain_entrancelock")
		end

		gohelper.setActive(self._goLimitTimeEpisode, false)
		gohelper.setActive(self._goTask, false)
	elseif not isTimeLimitTowerOpenLayer then
		self._txtlimitTimeLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceUnlock"), {
			timeLimitLayerNum * 10
		})
	end

	gohelper.setActive(self._golimitTimeLockTips, not curTimeLimitTowerOpenMo or not isTimeLimitTowerOpenLayer)

	local hasNewBossOpen = TowerModel.instance:hasNewBossOpen()
	local isBossTowerOpenLayer = TowerController.instance:isBossTowerOpen()
	local isBossTowerStateOpen = TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss)
	local bossTowerOpenList = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)
	local minRemainTimeStamp = -1

	for index, openInfoMO in ipairs(bossTowerOpenList) do
		local remainTimeStamp = openInfoMO.nextTime / 1000 - ServerTime.now()

		if remainTimeStamp < minRemainTimeStamp or minRemainTimeStamp <= 0 then
			minRemainTimeStamp = remainTimeStamp
		end
	end

	local bossDate, bossDateformate = TimeUtil.secondToRoughTime2(minRemainTimeStamp)

	self._txtbossUpdateTime.text = minRemainTimeStamp > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
		bossDate,
		bossDateformate
	}) or ""

	gohelper.setActive(self._gobossHasNew, false)
	gohelper.setActive(self._gobossUpdateTime, false)
	gohelper.setActive(self._gobossContent, isBossTowerOpenLayer)

	local bossLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

	if not isBossTowerStateOpen then
		local minTimeStampMo = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Boss)

		if minTimeStampMo then
			local minTimeLimitTimeStamp = minTimeStampMo.nextTime / 1000 - ServerTime.now()
			local minDate, minDateformate = TimeUtil.secondToRoughTime2(minTimeLimitTimeStamp)

			self._txtbossLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				minDate,
				minDateformate
			})
		else
			self._txtbossLockTips.text = luaLang("towermain_entrancelock")
		end
	elseif not isBossTowerOpenLayer then
		self._txtbossLockTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceUnlock"), {
			bossLayerNum * 10
		})
	end

	gohelper.setActive(self._gobossLockTips, not isBossTowerStateOpen or not isBossTowerOpenLayer)
	self:refreshStoreTime()
end

function TowerMainView:refreshStore()
	local isStoreOpen = TowerController.instance:isTowerStoreOpen()

	gohelper.setActive(self._gostore, isStoreOpen)

	local currencyIcon = TowerStoreModel.instance:getCurrencyIcon()

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecoin, currencyIcon)

	self._txtcoinNum.text = TowerStoreModel.instance:getCurrencyCount()

	self:refreshStoreTime()
end

function TowerMainView:refreshStoreTime()
	local isUpdateStoreEmpty = TowerStoreModel.instance:isUpdateStoreEmpty()

	gohelper.setActive(self._gostoreTime, not isUpdateStoreEmpty)

	if isUpdateStoreEmpty then
		return
	end

	self._txtstoreTime.text = TowerStoreModel.instance:getUpdateStoreRemainTime()
end

function TowerMainView:saveHeroTrialNew()
	local trialSeason = TowerModel.instance:getTrialHeroSeason()

	TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewHeroTrial, trialSeason)
	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.RefreshHeroTrialNew)
end

function TowerMainView:refreshHeroTrialNew()
	local saveSeason = TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewHeroTrial, 0)
	local curSeason = TowerModel.instance:getTrialHeroSeason()
	local heroTrialList = TowerHeroTrialListModel.instance:getEntranceHeroTrialList(TowerEnum.HeroTrialEntranceType.Normal)

	gohelper.setActive(self._goheroTrial, #heroTrialList > 0)
	gohelper.setActive(self._goheroTrialNew, saveSeason ~= curSeason and curSeason > 0)
end

function TowerMainView:refreshLimitedActTaskNew()
	local actTaskList = TowerTaskModel.instance.actTaskList
	local saveKey = TowerEnum.LocalPrefsKey.ReddotNewLimitedActTask
	local saveTaskActId = TowerController.instance:getPlayerPrefs(saveKey, 0)

	if #actTaskList > 0 then
		if not actTaskList[1].config.activityId then
			local curActTaskActId = 0
			local canShowNew = saveTaskActId ~= curActTaskActId and curActTaskActId > 0

			gohelper.setActive(self._gotaskNew, canShowNew)
			gohelper.setActive(self._gotaskReddot, not canShowNew)
		end
	end
end

function TowerMainView:onClose()
	TowerTaskModel.instance:cleanData()
	TaskDispatcher.cancelTask(self.refreshTowerState, self)
	TaskDispatcher.cancelTask(self.checkShowEffect, self)
	TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.TowerMainHeroTrialEffect, 1)
end

function TowerMainView:onDestroyView()
	for index, bossItem in pairs(self.bossItemTab) do
		bossItem.simageEnemy:UnLoadImage()
	end
end

return TowerMainView
