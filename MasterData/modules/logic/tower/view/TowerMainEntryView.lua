-- chunkname: @modules/logic/tower/view/TowerMainEntryView.lua

module("modules.logic.tower.view.TowerMainEntryView", package.seeall)

local TowerMainEntryView = class("TowerMainEntryView", BaseView)

function TowerMainEntryView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "#simage_Title")
	self._gotimeLimitEpisode = gohelper.findChild(self.viewGO, "limitTimeEpisode")
	self._gotimeLimitTaskInfo = gohelper.findChild(self.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo")
	self._txttimeLimitNum = gohelper.findChildText(self.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo/#txt_timeLimitNum")
	self._golimitTimeTips = gohelper.findChild(self.viewGO, "limitTimeEpisode/#go_limitTimeTips")
	self._golimitTimeHasNew = gohelper.findChild(self.viewGO, "limitTimeEpisode/#go_limitTimeTips/#go_limitTimeHasNew")
	self._golimitTimeUpdateTime = gohelper.findChild(self.viewGO, "limitTimeEpisode/#go_limitTimeTips/#go_limitTimeUpdateTime")
	self._txtlimitTimeUpdateTime = gohelper.findChildText(self.viewGO, "limitTimeEpisode/#go_limitTimeTips/#go_limitTimeUpdateTime/#txt_limitTimeUpdateTime")
	self._btnlimitTime = gohelper.findChildButtonWithAudio(self.viewGO, "limitTimeEpisode/#btn_limitTime")
	self._gobossEpisode = gohelper.findChild(self.viewGO, "bossEpisode")
	self._gobossTaskInfo = gohelper.findChild(self.viewGO, "bossEpisode/layout/#go_bossTaskInfo")
	self._txtbossNum = gohelper.findChildText(self.viewGO, "bossEpisode/layout/#go_bossTaskInfo/#txt_bossNum")
	self._gobossTips = gohelper.findChild(self.viewGO, "bossEpisode/#go_bossTips")
	self._gobossHasNew = gohelper.findChild(self.viewGO, "bossEpisode/#go_bossTips/#go_bossHasNew")
	self._gobossUpdateTime = gohelper.findChild(self.viewGO, "bossEpisode/#go_bossTips/#go_bossUpdateTime")
	self._txtbossUpdateTime = gohelper.findChildText(self.viewGO, "bossEpisode/#go_bossTips/#go_bossUpdateTime/#txt_bossUpdateTime")
	self._gobossContent = gohelper.findChild(self.viewGO, "bossEpisode/#go_bossContent")
	self._gobossItem = gohelper.findChild(self.viewGO, "bossEpisode/#go_bossContent/#go_bossItem")
	self._goSelected = gohelper.findChild(self.viewGO, "bossEpisode/#go_bossContent/#go_bossItem/#go_Selected")
	self._btnboss = gohelper.findChildButtonWithAudio(self.viewGO, "bossEpisode/#btn_boss")
	self._gorewards = gohelper.findChild(self.viewGO, "Reward/scroll_reward/Viewport/#go_rewards")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Start")
	self._btnLock = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Lock")
	self._txtlockTip = gohelper.findChildText(self.viewGO, "#btn_Lock/#txt_lockTip")
	self._goreddot = gohelper.findChild(self.viewGO, "#btn_Start/#go_reddot")
	self._goupdateReddot = gohelper.findChild(self.viewGO, "black/#go_updateReddot")
	self._gostore = gohelper.findChild(self.viewGO, "store")
	self._gostoreTime = gohelper.findChild(self.viewGO, "store/time")
	self._txtstoreTime = gohelper.findChildText(self.viewGO, "store/time/#txt_storeTime")
	self._txtstoreName = gohelper.findChildText(self.viewGO, "store/#txt_storeName")
	self._txtcoinNum = gohelper.findChildText(self.viewGO, "store/#txt_coinNum")
	self._imagecoin = gohelper.findChildImage(self.viewGO, "store/#txt_coinNum/#image_coin")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "store/#btn_store")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerMainEntryView:addEvents()
	self._btnlimitTime:AddClickListener(self._btnlimitTimeOnClick, self)
	self._btnboss:AddClickListener(self._btnbossOnClick, self)
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.LocalKeyChange, self.onLocalKeyChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.refreshTaskInfo, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStore, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self.refreshStore, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRequestData, self)
end

function TowerMainEntryView:removeEvents()
	self._btnlimitTime:RemoveClickListener()
	self._btnboss:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.LocalKeyChange, self.onLocalKeyChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.refreshTaskInfo, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStore, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self.refreshStore, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.dailyRequestData, self)
	TaskDispatcher.cancelTask(self.refreshTowerState, self)
end

function TowerMainEntryView:_btnlimitTimeOnClick()
	local curTimeLimitTowerOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if not curTimeLimitTowerOpenMo then
		return
	end

	TowerController.instance:openTowerTimeLimitLevelView()
end

function TowerMainEntryView:_btnbossOnClick()
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

function TowerMainEntryView:_btnStartOnClick()
	TowerComposeController.instance:openTowerMainSelectView()
end

function TowerMainEntryView:_btnstoreOnClick()
	if not self.isTowerOpen then
		local notJumpTips = OpenHelper.getToastIdAndParam(OpenEnum.UnlockFunc.Tower)

		GameFacade.showToast(notJumpTips)

		return
	end

	TowerController.instance:openTowerStoreView()
end

function TowerMainEntryView:onLocalKeyChange()
	self:refreshBossNewTag()
end

function TowerMainEntryView:_onCloseView(viewName)
	if viewName == "TowerMainView" then
		self:refreshTowerState()
	end
end

function TowerMainEntryView:dailyRequestData()
	TowerRpc.instance:sendGetTowerInfoRequest(self.towerTaskDataRequest, self)
end

function TowerMainEntryView:towerTaskDataRequest()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, self.dailyRefresh, self)
end

function TowerMainEntryView:dailyRefresh()
	self:refreshUI()
	TowerController.instance:dispatchEvent(TowerEvent.DailyReresh)
end

function TowerMainEntryView:_editableInitView()
	self.rewardItemTab = self:getUserDataTb_()
	self.bossItemTab = self:getUserDataTb_()
	self._animView = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local towerTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}

	TowerTaskModel.instance:setTaskInfoList(towerTasks)
	TowerDeepTaskModel.instance:setTaskInfoList()
end

function TowerMainEntryView:onUpdateParam()
	return
end

function TowerMainEntryView:onOpen()
	self._animView:Play(UIAnimationName.Open, 0, 0)

	self.actId = ActivityEnum.Activity.Tower
	self.actConfig = ActivityConfig.instance:getActivityCo(self.actId)

	self:refreshUI()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.TowerMainEntry)
	RedDotController.instance:addRedDot(self._goupdateReddot, RedDotEnum.DotNode.TowerNewUpdate)
	TowerController.instance:saveNewUpdateTowerReddot()
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTowerReddot)
	TowerController.instance:checkNewUpdateTowerRddotShow()
end

function TowerMainEntryView:refreshUI()
	self:refreshReward()

	self.isTowerOpen = TowerController.instance:isOpen()

	gohelper.setActive(self._btnStart.gameObject, self.isTowerOpen)
	gohelper.setActive(self._btnLock.gameObject, not self.isTowerOpen)
	gohelper.setActive(self._golimitTimeHasNew, false)
	gohelper.setActive(self._golimitTimeUpdateTime, false)
	gohelper.setActive(self._gobossHasNew, false)
	self:refreshStore()

	if self.isTowerOpen then
		self:refreshEntranceUI()
		self:refreshBossInfo()
		self:refreshBossNewTag()
		self:refreshTowerState()
		self:refreshTaskInfo()
		TaskDispatcher.cancelTask(self.refreshTowerState, self)
		TaskDispatcher.runRepeat(self.refreshTowerState, self, 1)
	else
		gohelper.setActive(self._gobossEpisode, false)
		gohelper.setActive(self._gotimeLimitEpisode, false)

		local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(self.actId)

		if status ~= ActivityEnum.ActivityStatus.Normal then
			local tip = ToastConfig.instance:getToastCO(toastId).tips

			tip = GameUtil.getSubPlaceholderLuaLang(tip, toastParam)
			self._txtlockTip.text = tip
		end
	end
end

function TowerMainEntryView:refreshEntranceUI()
	local isBossOpen = TowerController.instance:isBossTowerOpen()

	gohelper.setActive(self._gobossEpisode, isBossOpen)

	local isTimeLimitOpen = TowerController.instance:isTimeLimitTowerOpen()
	local curTimeLimitTowerOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	gohelper.setActive(self._gotimeLimitEpisode, isTimeLimitOpen and curTimeLimitTowerOpenMo)
end

function TowerMainEntryView:refreshTaskInfo()
	local timeLimitTaskList = TowerTaskModel.instance:getCurTaskList(TowerEnum.TowerType.Limited)

	self._gotimeLimitTaskInfo = gohelper.findChild(self.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo")
	self._txttimeLimitNum = gohelper.findChildText(self.viewGO, "limitTimeEpisode/#go_timeLimitTaskInfo/#txt_timeLimitNum")

	if not timeLimitTaskList or #timeLimitTaskList == 0 then
		gohelper.setActive(self._gotimeLimitTaskInfo, false)
	else
		gohelper.setActive(self._gotimeLimitTaskInfo, true)

		local finishCount = TowerTaskModel.instance:getTaskItemRewardCount(timeLimitTaskList)

		self._txttimeLimitNum.text = string.format("%s/%s", finishCount, #timeLimitTaskList)
	end

	local bossTaskList = TowerTaskModel.instance.bossTaskList

	if not bossTaskList or #bossTaskList == 0 then
		gohelper.setActive(self._gobossTaskInfo, false)
	else
		gohelper.setActive(self._gobossTaskInfo, true)

		local allBossTaskList = {}

		for towerId, taskList in pairs(bossTaskList) do
			for i = 1, #taskList do
				table.insert(allBossTaskList, taskList[i])
			end
		end

		local finishCount = TowerTaskModel.instance:getTaskItemRewardCount(allBossTaskList)

		self._txtbossNum.text = string.format("%s/%s", finishCount, #allBossTaskList)
	end
end

function TowerMainEntryView:refreshBossInfo()
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
end

function TowerMainEntryView:refreshBossNewTag()
	local hasNew = false

	gohelper.setActive(self._gobossHasNew, hasNew)
end

function TowerMainEntryView:bossItemShow(obj, data, index)
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

	bossItem.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))

	local isPassAll = self.bossEpisodeMo:isPassAllUnlockLayers(data.id)

	gohelper.setActive(bossItem.goSelected, not isPassAll)
end

function TowerMainEntryView:refreshReward()
	local activityBonus = self.actConfig.activityBonus
	local rewardList = GameUtil.splitString2(activityBonus, true)

	for index, rewardData in ipairs(rewardList) do
		local rewardItem = self.rewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				itemIcon = IconMgr.instance:getCommonPropItemIcon(self._gorewards)
			}
			self.rewardItemTab[index] = rewardItem
		end

		rewardItem.itemIcon:setMOValue(rewardData[1], rewardData[2], rewardData[3] or 0)
		rewardItem.itemIcon:isShowCount(false)
		rewardItem.itemIcon:setHideLvAndBreakFlag(true)
		rewardItem.itemIcon:hideEquipLvAndBreak(true)
	end

	for index = #rewardList + 1, #self.rewardItemTab do
		local rewardItem = self.rewardItemTab[index]

		if rewardItem then
			gohelper.setActive(rewardItem.itemIcon.gameObject, false)
		end
	end
end

function TowerMainEntryView:refreshTowerState()
	local curTimeLimitTowerOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if curTimeLimitTowerOpenMo then
		local timeLimitTimeStamp = curTimeLimitTowerOpenMo.nextTime / 1000 - ServerTime.now()
		local date, dateformate = TimeUtil.secondToRoughTime2(timeLimitTimeStamp)

		self._txtlimitTimeUpdateTime.text = timeLimitTimeStamp > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
			date,
			dateformate
		}) or ""

		local localTimeNewState = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewTimeLimitOpen, curTimeLimitTowerOpenMo.id, curTimeLimitTowerOpenMo, TowerEnum.LockKey)

		gohelper.setActive(self._golimitTimeHasNew, false)
		gohelper.setActive(self._golimitTimeUpdateTime, false)
	else
		local minTimeStampMo = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Limited)

		if minTimeStampMo then
			local minTimeLimitTimeStamp = minTimeStampMo.nextTime / 1000 - ServerTime.now()
			local minDate, minDateformate = TimeUtil.secondToRoughTime2(minTimeLimitTimeStamp)

			self._txtlimitTimeUpdateTime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				minDate,
				minDateformate
			})
		else
			self._txtlimitTimeUpdateTime.text = luaLang("towermain_entrancelock")
		end

		gohelper.setActive(self._gotimeLimitEpisode, false)
		gohelper.setActive(self._golimitTimeHasNew, false)
		gohelper.setActive(self._golimitTimeUpdateTime, true)
	end

	local hasNewBossOpen = TowerModel.instance:hasNewBossOpen()
	local isBossTowerStateOpen = TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss)

	if isBossTowerStateOpen then
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
		}) or luaLang("towermain_entrancelock")

		gohelper.setActive(self._gobossHasNew, false)
		gohelper.setActive(self._gobossUpdateTime, false)
	else
		local minTimeStampMo = TowerModel.instance:getFirstUnOpenTowerInfo(TowerEnum.TowerType.Boss)

		if minTimeStampMo then
			local minTimeLimitTimeStamp = minTimeStampMo.nextTime / 1000 - ServerTime.now()
			local minDate, minDateformate = TimeUtil.secondToRoughTime2(minTimeLimitTimeStamp)

			self._txtbossUpdateTime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towermain_entranceTimeUnlock"), {
				minDate,
				minDateformate
			})
		else
			self._txtbossUpdateTime.text = luaLang("towermain_entrancelock")
		end

		gohelper.setActive(self._gobossHasNew, false)
		gohelper.setActive(self._gobossUpdateTime, true)
	end

	self:refreshStoreTime()
end

function TowerMainEntryView:refreshStore()
	local currencyIcon = TowerStoreModel.instance:getCurrencyIcon()

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecoin, currencyIcon)

	self._txtcoinNum.text = TowerStoreModel.instance:getCurrencyCount()

	local isStoreOpen = TowerController.instance:isTowerStoreOpen()

	gohelper.setActive(self._gostore, isStoreOpen)
	self:refreshStoreTime()
end

function TowerMainEntryView:refreshStoreTime()
	local isUpdateStoreEmpty = TowerStoreModel.instance:isUpdateStoreEmpty()

	gohelper.setActive(self._gostoreTime, not isUpdateStoreEmpty)

	if isUpdateStoreEmpty then
		return
	end

	self._txtstoreTime.text = TowerStoreModel.instance:getUpdateStoreRemainTime(false, true)
end

function TowerMainEntryView:onClose()
	TaskDispatcher.cancelTask(self.refreshTowerState, self)
end

function TowerMainEntryView:onDestroyView()
	return
end

return TowerMainEntryView
