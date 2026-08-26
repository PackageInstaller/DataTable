-- chunkname: @modules/logic/tower/view/TowerTaskView.lua

module("modules.logic.tower.view.TowerTaskView", package.seeall)

local TowerTaskView = class("TowerTaskView", BaseView)

function TowerTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._goFullBg2 = gohelper.findChild(self.viewGO, "#simage_FullBG2")
	self._goLeft = gohelper.findChild(self.viewGO, "Left")
	self._scrolltower = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_tower")
	self._gotowerContent = gohelper.findChild(self.viewGO, "Left/#scroll_tower/Viewport/#go_towerContent")
	self._gotowerItem = gohelper.findChild(self.viewGO, "Left/#scroll_tower/Viewport/#go_towerContent/#go_towerItem")
	self._txttime = gohelper.findChildText(self.viewGO, "Left/#scroll_tower/Viewport/#go_towerContent/#go_timeTowerItem/normal/time/#txt_time")
	self._goRight = gohelper.findChild(self.viewGO, "Right")
	self._scrolltaskList = gohelper.findChildScrollRect(self.viewGO, "Right/#scroll_taskList")
	self._gotaskContent = gohelper.findChild(self.viewGO, "Right/#scroll_taskList/Viewport/#go_taskContent")
	self._gotips = gohelper.findChild(self.viewGO, "Right/#go_tips")
	self._gotimeTowerScore = gohelper.findChild(self.viewGO, "Right/#go_tips/#go_timeTowerScore")
	self._txttimeTowerScore = gohelper.findChildText(self.viewGO, "Right/#go_tips/#go_timeTowerScore/#txt_timeTowerScore")
	self._txttimeTowerTime = gohelper.findChildText(self.viewGO, "Right/#go_tips/#go_timeTowerScore/layout/#txt_timeTowerTime")
	self._gobossTowerTips = gohelper.findChild(self.viewGO, "Right/#go_tips/#go_bossTowerTips")
	self._txtbossTowerTip = gohelper.findChildText(self.viewGO, "Right/#go_tips/#go_bossTowerTips/#txt_bossTowerTip")
	self._txtbossTowerTime = gohelper.findChildText(self.viewGO, "Right/#go_tips/#go_bossTowerTips/layout/#txt_bossTowerTime")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._goactReward = gohelper.findChild(self.viewGO, "Right/#go_actReward")
	self._simageRewardIcon = gohelper.findChildSingleImage(self.viewGO, "Right/#go_actReward/#simage_rewardicon")
	self._btnShowRewardInfo = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_actReward/#btn_showRewardInfo")
	self._txtRewardCount = gohelper.findChildText(self.viewGO, "Right/#go_actReward/#txt_rewardCount")
	self._txtactReward = gohelper.findChildText(self.viewGO, "Right/#go_actReward/#txt_actReward")
	self._goactPointContent = gohelper.findChild(self.viewGO, "Right/#go_actReward/#go_actPointContent")
	self._goactPointItem = gohelper.findChild(self.viewGO, "Right/#go_actReward/#go_actPointContent/#go_actPointItem")
	self._btnactNormal = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_actReward/#btn_actNormal")
	self._btnCanget = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_actReward/#btn_actCanget")
	self._goactHasget = gohelper.findChild(self.viewGO, "Right/#go_actReward/#go_actHasget")
	self._animActReward = self._goactReward:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerTaskView:addEvents()
	self.addEventCb(self, TowerController.instance, TowerEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerRefreshTask, self.refreshTaskPos, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerRefreshTask, self.InitTowerItemData, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerRefreshTask, self.refreshLeftUI, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerRefreshTask, self.refreshActReward, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnTaskRewardGetFinish, self.refreshActReward, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.refreshUI, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.refreshUI, self)
	self._btnCanget:AddClickListener(self._btnActCangetOnClick, self)
	self._btnactNormal:AddClickListener(self._btnActNormalOnClick, self)
	self._btnShowRewardInfo:AddClickListener(self._btnShowRewardInfoOnClick, self)
end

function TowerTaskView:removeEvents()
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerRefreshTask, self.refreshTaskPos, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerRefreshTask, self.InitTowerItemData, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerRefreshTask, self.refreshLeftUI, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerRefreshTask, self.refreshActReward, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnTaskRewardGetFinish, self.refreshActReward, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.refreshUI, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.refreshUI, self)
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	self._btnCanget:RemoveClickListener()
	self._btnactNormal:RemoveClickListener()
	self._btnShowRewardInfo:RemoveClickListener()
end

TowerTaskView.TaskMaskTime = 0.65
TowerTaskView.TaskGetAnimTime = 0.567
TowerTaskView.EnterViewAnimBlock = "playEnterTowerTaskViewAnim"
TowerTaskView.MoreTaskPosY = 14
TowerTaskView.NormalTaskPosY = 14
TowerTaskView.NormalTaskCount = 4
TowerTaskView.NormalTaskScrollHeight = 1044
TowerTaskView.ActTaskScrollHeight = 860

function TowerTaskView:onTowerItemClick(towerItem)
	if towerItem.select then
		return
	end

	TowerTaskModel.instance:setCurSelectTowerTypeAndId(towerItem.data.type, towerItem.data.towerId)
	self:refreshSelectState()
	self:refreshRemainTime()
	self:refreshTaskPos()
	self:refreshReddot()
	self:refreshActReward()
end

function TowerTaskView:_btnActCangetOnClick()
	local taskId = self.actRewardTaskMO.config.id

	TaskRpc.instance:sendFinishTaskRequest(taskId)
	self._animActReward:Play(UIAnimationName.Finish, 0, 0)
end

function TowerTaskView:_btnActNormalOnClick()
	if not self.actRewardTaskMO then
		return
	end

	GameFacade.showToast(ToastEnum.TowerTaskActRewardNormalClick, self.actRewardTaskMO.config.desc)
end

function TowerTaskView:_btnShowRewardInfoOnClick()
	local rewardList = string.split(self.actRewardTaskMO.config.bonus, "#")

	MaterialTipController.instance:showMaterialInfo(rewardList[1], rewardList[2])
end

function TowerTaskView:_editableInitView()
	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self.viewContainer.scrollView)

	self._taskAnimRemoveItem:setMoveInterval(0)
	self._taskAnimRemoveItem:setMoveAnimationTime(TowerTaskView.TaskMaskTime - TowerTaskView.TaskGetAnimTime)

	self.towerItemTab = self:getUserDataTb_()
	self.removeIndexTab = {}

	gohelper.setActive(self._gotowerItem, false)

	self.showActRewardEnter = true
end

function TowerTaskView:onUpdateParam()
	return
end

function TowerTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_task_entry)
	TaskDispatcher.runDelay(self.endEnterAnimBlock, self, 0.8)
	UIBlockMgr.instance:startBlock(TowerTaskView.EnterViewAnimBlock)
	self:selectDefaultTaskCategory()
	self:refreshUI()
	self:saveLimitedActTaskNew()

	self.showActRewardEnter = false
end

function TowerTaskView:selectDefaultTaskCategory()
	local defaultTowerType = self.viewParam.towerType
	local defaultTowerId = self.viewParam.towerId

	if not defaultTowerType or not defaultTowerId then
		if #TowerTaskModel.instance.actTaskList > 0 then
			local actTaskMO = TowerTaskModel.instance.actTaskList[1]
			local actId = actTaskMO.config.activityId
			local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

			if actInfoMo:isOpen() and not actInfoMo:isExpired() then
				defaultTowerType = TowerEnum.ActTaskType
				defaultTowerId = actId
			end
		else
			local curOpenTimeLimitTowerMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

			if curOpenTimeLimitTowerMo then
				if not curOpenTimeLimitTowerMo.towerId then
					defaultTowerType = TowerEnum.TowerType.Limited
					defaultTowerId = 1
				end
			end
		end
	end

	TowerTaskModel.instance:setCurSelectTowerTypeAndId(defaultTowerType, defaultTowerId)

	self.viewParam.towerType = nil
	self.viewParam.towerId = nil
end

function TowerTaskView:refreshUI()
	self:InitTowerItemData()
	self:refreshSelectState()
	self:refreshRemainTime()
	self:refreshTaskPos()
	self:refreshLeftUI()
	self:refreshReddot()
	self:refreshActReward()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
end

function TowerTaskView:saveLimitedActTaskNew()
	local actTaskList = TowerTaskModel.instance.actTaskList

	if #actTaskList > 0 then
		TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.ReddotNewLimitedActTask, actTaskList[1].config.activityId)
	end
end

function TowerTaskView:InitTowerItemData()
	local towerItemDataList = {}
	local limitTimeTaskList = TowerTaskModel.instance.limitTimeTaskList
	local actTaskList = TowerTaskModel.instance.actTaskList
	local bossTaskList = {}
	local keyList = {}

	for key in pairs(TowerTaskModel.instance.bossTaskList) do
		table.insert(keyList, key)
	end

	table.sort(keyList)

	for _, key in ipairs(keyList) do
		table.insert(bossTaskList, TowerTaskModel.instance.bossTaskList[key])
	end

	local limitTimeTowerData = self:buildTowerItemData(limitTimeTaskList, TowerEnum.TowerType.Limited)

	if limitTimeTowerData then
		table.insert(towerItemDataList, limitTimeTowerData)
	end

	for _, bossTaskMoList in ipairs(bossTaskList) do
		local bossTowerData = self:buildTowerItemData(bossTaskMoList, TowerEnum.TowerType.Boss)

		if bossTowerData then
			table.insert(towerItemDataList, bossTowerData)
		end
	end

	local actTowerData = self:buildTowerItemData(actTaskList, TowerEnum.ActTaskType)

	if actTowerData then
		table.insert(towerItemDataList, actTowerData)
	end

	if #limitTimeTaskList == 0 then
		GameFacade.showToast(ToastEnum.TowerTimeLimitEnd)
		self:closeThis()

		return
	end

	self:createOrRefreshTowerItem(towerItemDataList)
end

function TowerTaskView:buildTowerItemData(TaskMoList, type)
	local towerData = {}

	if not TaskMoList or tabletool.len(TaskMoList) == 0 then
		return nil
	end

	towerData.taskList = TaskMoList
	towerData.taskCount = #TaskMoList
	towerData.finishCount = TowerTaskModel.instance:getTaskItemRewardCount(TaskMoList)
	towerData.type = type

	if type == TowerEnum.TowerType.Limited then
		towerData.timeConfig = TowerConfig.instance:getTowerLimitedCoByTaskGroupId(TaskMoList[1].config.taskGroupId)
		towerData.towerId = towerData.timeConfig.season
	elseif type == TowerEnum.TowerType.Boss then
		towerData.timeConfig = TowerConfig.instance:getTowerBossTimeCoByTaskGroupId(TaskMoList[1].config.taskGroupId)
		towerData.towerId = towerData.timeConfig.towerId
	elseif type == TowerEnum.ActTaskType then
		towerData.towerId = TaskMoList[1].config.activityId
		towerData.timeConfig = TaskMoList[1].config
	end

	towerData.towerOpenMo = TowerModel.instance:getTowerOpenInfo(type, towerData.towerId, TowerEnum.TowerStatus.Open)

	return towerData
end

function TowerTaskView:createOrRefreshTowerItem(towerItemDataList)
	self.towerItemList = self:getUserDataTb_()

	local hasExpired = false

	for index, towerItemData in ipairs(towerItemDataList) do
		self.towerItemTab[towerItemData.type] = self.towerItemTab[towerItemData.type] or {}

		if tabletool.len(self.towerItemTab[towerItemData.type]) > 0 then
			for _, towerItem in pairs(self.towerItemTab[towerItemData.type]) do
				local data = towerItem.data
				local hasItem = false

				for _, towerData in pairs(towerItemDataList) do
					if towerData.towerId == data.towerId and towerData.type == data.type then
						hasItem = true
					end
				end

				if not hasItem then
					towerItem.btnClick:RemoveClickListener()
					gohelper.destroy(towerItem.go)

					self.towerItemTab[towerItemData.type][data.towerId] = nil
					hasExpired = true
				end
			end

			if hasExpired then
				self:selectDefaultTaskCategory()
			end
		end

		local towerItem = self.towerItemTab[towerItemData.type][towerItemData.towerId]

		if not towerItem then
			towerItem = self:getUserDataTb_()
			towerItem.go = gohelper.clone(self._gotowerItem, self._gotowerContent, string.format("tower%s_%s", towerItemData.type, towerItemData.towerId))
			towerItem.goTimeTower = gohelper.findChild(towerItem.go, "go_timeTowerItem")
			towerItem.goBossTower = gohelper.findChild(towerItem.go, "go_bossTowerItem")
			towerItem.goActTower = gohelper.findChild(towerItem.go, "go_actTowerItem")
			towerItem.btnClick = gohelper.findChildButtonWithAudio(towerItem.go, "btn_click")

			towerItem.btnClick:AddClickListener(self.onTowerItemClick, self, towerItem)

			towerItem.timeTowerUI = self:findTowerItemUI(towerItem.goTimeTower)
			towerItem.bossTowerUI = self:findTowerItemUI(towerItem.goBossTower)
			towerItem.actTowerUI = self:findTowerItemUI(towerItem.goActTower)
			towerItem.select = false
			towerItem.data = towerItemData
			self.towerItemTab[towerItemData.type][towerItemData.towerId] = towerItem

			gohelper.setAsLastSibling(towerItem.go)
		end

		towerItem.towerItemUI = towerItemData.type == TowerEnum.TowerType.Boss and towerItem.bossTowerUI or towerItemData.type == TowerEnum.ActTaskType and towerItem.actTowerUI or towerItem.timeTowerUI

		self:refreshTowerItem(towerItem)
		table.insert(self.towerItemList, towerItem)
	end

	for index, towerItem in pairs(self.towerItemList) do
		if towerItem.data.type == TowerEnum.TowerType.Limited then
			gohelper.setAsFirstSibling(towerItem.go)

			break
		end
	end

	for index, towerItem in pairs(self.towerItemList) do
		if towerItem.data.type == TowerEnum.ActTaskType then
			gohelper.setAsFirstSibling(towerItem.go)

			break
		end
	end

	for i = #towerItemDataList + 1, #self.towerItemList do
		gohelper.setActive(self.towerItemList[i].go, false)
	end
end

function TowerTaskView:refreshTowerItem(towerItem)
	local curSelectTowerType = TowerTaskModel.instance.curSelectTowerType
	local curSelectToweId = TowerTaskModel.instance.curSelectToweId

	towerItem.select = curSelectTowerType == towerItem.data.type and curSelectToweId == towerItem.data.towerId

	local isBossType = towerItem.data.type == TowerEnum.TowerType.Boss
	local isActType = towerItem.data.type == TowerEnum.ActTaskType

	gohelper.setActive(towerItem.go, true)
	gohelper.setActive(towerItem.goTimeTower, not isBossType and not isActType)
	gohelper.setActive(towerItem.goBossTower, isBossType)
	gohelper.setActive(towerItem.goActTower, isActType)
	gohelper.setActive(towerItem.towerItemUI.normalGO, not towerItem.select)
	gohelper.setActive(towerItem.towerItemUI.selectGO, towerItem.select)
	gohelper.setActive(towerItem.towerItemUI.goNormalIconMask, isBossType)
	gohelper.setActive(towerItem.towerItemUI.goSelectIconMask, isBossType)
	gohelper.setActive(towerItem.towerItemUI.imageNormalIcon, not isBossType)
	gohelper.setActive(towerItem.towerItemUI.imageSelectIcon, not isBossType)

	if isBossType then
		local bossTowerConfig = TowerConfig.instance:getBossTowerConfig(towerItem.data.towerId)
		local assistBossConfig = TowerConfig.instance:getAssistBossConfig(bossTowerConfig.bossId)
		local skinConfig = FightConfig.instance:getSkinCO(assistBossConfig.skinId)

		towerItem.towerItemUI.simageNormalIcon:LoadImage(ResUrl.monsterHeadIcon(skinConfig and skinConfig.headIcon))
		towerItem.towerItemUI.simageSelectIcon:LoadImage(ResUrl.monsterHeadIcon(skinConfig and skinConfig.headIcon))
	else
		UISpriteSetMgr.instance:setTowerSprite(towerItem.towerItemUI.imageNormalIcon, isActType and "tower_tasktimeicon_2" or "tower_tasktimeicon_1")
		UISpriteSetMgr.instance:setTowerSprite(towerItem.towerItemUI.imageSelectIcon, isActType and "tower_tasktimeicon_2" or "tower_tasktimeicon_1")
	end

	local bossTowerConfig = TowerConfig.instance:getBossTowerConfig(towerItem.data.towerId)
	local var_17_0 = towerItem.towerItemUI.txtNormalName
	local var_17_1

	if isBossType then
		var_17_1 = bossTowerConfig.name

		if not bossTowerConfig.name then
			if isActType then
				var_17_1 = luaLang("towertask_act_name") or luaLang("towertask_timelimited_name")
			end
		end
	end

	var_17_0.text = var_17_1

	local var_17_2 = towerItem.towerItemUI.txtSelectName
	local var_17_3

	if isBossType then
		var_17_3 = bossTowerConfig.name

		if not bossTowerConfig.name then
			if isActType then
				var_17_3 = luaLang("towertask_act_name") or luaLang("towertask_timelimited_name")
			end
		end
	end

	var_17_2.text = var_17_3

	local var_17_4 = towerItem.towerItemUI.txtNameEn
	local var_17_5

	if isBossType then
		var_17_5 = bossTowerConfig.nameEn

		if not bossTowerConfig.nameEn then
			if isActType then
				var_17_5 = luaLang("towertask_act_nameEn") or luaLang("towertask_timelimited_nameEn")
			end
		end
	end

	var_17_4.text = var_17_5
	towerItem.towerItemUI.txtNormalTaskNum.text = string.format("%s/%s", towerItem.data.finishCount, #towerItem.data.taskList)
	towerItem.towerItemUI.txtSelectTaskNum.text = string.format("%s/%s", towerItem.data.finishCount, #towerItem.data.taskList)
end

function TowerTaskView:findTowerItemUI(towerItemGO)
	local towerItemUI = self:getUserDataTb_()

	towerItemUI.normalGO = gohelper.findChild(towerItemGO, "normal")
	towerItemUI.selectGO = gohelper.findChild(towerItemGO, "select")
	towerItemUI.imageNormalIcon = gohelper.findChildImage(towerItemUI.normalGO, "image_icon")
	towerItemUI.imageSelectIcon = gohelper.findChildImage(towerItemUI.selectGO, "image_icon")
	towerItemUI.goNormalIconMask = gohelper.findChild(towerItemUI.normalGO, "Mask")
	towerItemUI.goSelectIconMask = gohelper.findChild(towerItemUI.selectGO, "Mask")
	towerItemUI.simageNormalIcon = gohelper.findChildSingleImage(towerItemUI.normalGO, "Mask/image_bossIcon")
	towerItemUI.simageSelectIcon = gohelper.findChildSingleImage(towerItemUI.selectGO, "Mask/image_bossIcon")
	towerItemUI.txtNormalName = gohelper.findChildText(towerItemUI.normalGO, "txt_name")
	towerItemUI.txtSelectName = gohelper.findChildText(towerItemUI.selectGO, "txt_name")
	towerItemUI.txtNormalTaskNum = gohelper.findChildText(towerItemUI.normalGO, "txt_taskNum")
	towerItemUI.txtSelectTaskNum = gohelper.findChildText(towerItemUI.selectGO, "txt_taskNum")
	towerItemUI.goNormalReddot = gohelper.findChild(towerItemUI.normalGO, "go_reddot")
	towerItemUI.goSelectReddot = gohelper.findChild(towerItemUI.selectGO, "go_reddot")
	towerItemUI.txtTime = gohelper.findChildText(towerItemUI.normalGO, "time/txt_time")
	towerItemUI.goSelectTime = gohelper.findChild(towerItemUI.selectGO, "time")
	towerItemUI.txtSelectTime = gohelper.findChildText(towerItemUI.selectGO, "time/txt_time")
	towerItemUI.txtNameEn = gohelper.findChildText(towerItemUI.selectGO, "txt_en")

	return towerItemUI
end

function TowerTaskView:taskProgressShow(obj, data, index)
	local light = gohelper.findChild(obj, "go_light")
	local taskFinishCount = data.finishCount

	gohelper.setActive(light, index <= taskFinishCount)
end

function TowerTaskView:refreshSelectState()
	local curSelectTowerType = TowerTaskModel.instance.curSelectTowerType
	local curSelectToweId = TowerTaskModel.instance.curSelectToweId

	TowerTaskModel.instance:refreshList(curSelectTowerType)

	for _, towerItem in ipairs(self.towerItemList) do
		towerItem.select = curSelectTowerType == towerItem.data.type and curSelectToweId == towerItem.data.towerId

		gohelper.setActive(towerItem.towerItemUI.normalGO, not towerItem.select)
		gohelper.setActive(towerItem.towerItemUI.selectGO, towerItem.select)
	end

	gohelper.setActive(self._gobossTowerTips, curSelectTowerType == TowerEnum.TowerType.Boss)
	gohelper.setActive(self._gotimeTowerScore, curSelectTowerType == TowerEnum.TowerType.Limited)

	local towerMo = TowerModel.instance:getTowerInfoById(curSelectTowerType, curSelectToweId)

	if curSelectTowerType == TowerEnum.TowerType.Boss then
		local towerConfig = TowerConfig.instance:getBossTowerConfig(curSelectToweId)
		local bossMo = TowerAssistBossModel.instance:getById(towerConfig.bossId)

		if bossMo then
			if not bossMo.level then
				local bossLev = 0
				local maxLev = TowerConfig.instance:getAssistBossMaxLev(towerConfig.bossId)

				self._txtbossTowerTip.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerbossepisodepasscount"), bossLev, maxLev)
			end
		end
	elseif curSelectTowerType == TowerEnum.TowerType.Limited then
		local maxScore = TowerTimeLimitLevelModel.instance:getHistoryHighScore()
		local starLevel = TowerConfig.instance:getScoreToStarConfig(maxScore)

		self._txttimeTowerScore.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towertask_currenthighscore_level"), {
			starLevel
		})
	end
end

function TowerTaskView:refreshRemainTime()
	for _, towerItem in ipairs(self.towerItemList) do
		local towerOpenMo = towerItem.data.towerOpenMo
		local remainTimeStamp = towerOpenMo and towerOpenMo.taskEndTime / 1000 - ServerTime.now() or 0
		local date, dateformate = TimeUtil.secondToRoughTime2(remainTimeStamp, true)

		gohelper.setActive(towerItem.towerItemUI.goSelectTime, towerItem.data.type == TowerEnum.ActTaskType)

		if towerItem.data.type == TowerEnum.ActTaskType then
			local actId = towerItem.data.timeConfig.activityId
			local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

			if actInfoMo and actInfoMo:isOpen() and not actInfoMo:isExpired() then
				local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
				local data = TimeUtil.SecondToActivityTimeFormat(offsetSecond, true)

				towerItem.towerItemUI.txtTime.text = offsetSecond > 0 and data or ""
				towerItem.towerItemUI.txtSelectTime.text = offsetSecond > 0 and data or ""

				gohelper.setActive(towerItem.towerItemUI.txtTime.gameObject, offsetSecond > 0)
			else
				towerItem.towerItemUI.txtTime.text = ""
				towerItem.towerItemUI.txtSelectTime.text = ""

				gohelper.setActive(towerItem.towerItemUI.txtTime.gameObject, false)
			end
		else
			towerItem.towerItemUI.txtTime.text = remainTimeStamp > 0 and string.format("%s%s", date, dateformate) or ""
			towerItem.towerItemUI.txtSelectTime.text = remainTimeStamp > 0 and string.format("%s%s", date, dateformate) or ""

			gohelper.setActive(towerItem.towerItemUI.txtTime.gameObject, remainTimeStamp > 0)
		end
	end

	local curSelectTowerType = TowerTaskModel.instance.curSelectTowerType
	local curSelectToweId = TowerTaskModel.instance.curSelectToweId
	local towerOpenMo = TowerModel.instance:getTowerOpenInfo(curSelectTowerType, curSelectToweId, TowerEnum.TowerStatus.Open)
	local remainTimeStamp = towerOpenMo and towerOpenMo.taskEndTime / 1000 - ServerTime.now() or 0
	local date, dateformate = TimeUtil.secondToRoughTime2(remainTimeStamp, true)

	if curSelectTowerType == TowerEnum.TowerType.Boss then
		self._txtbossTowerTime.text = remainTimeStamp > 0 and string.format("%s%s", date, dateformate) or ""

		gohelper.setActive(self._txtbossTowerTime.gameObject, remainTimeStamp > 0)
	elseif curSelectTowerType == TowerEnum.TowerType.Limited then
		self._txttimeTowerTime.text = remainTimeStamp > 0 and string.format("%s%s", date, dateformate) or ""

		gohelper.setActive(self._txttimeTowerTime.gameObject, remainTimeStamp > 0)
	end
end

function TowerTaskView:refreshTaskPos()
	self._scrolltaskList.verticalNormalizedPosition = 1

	local taskCount = TowerTaskModel.instance:getCount()

	recthelper.setAnchorY(self._goRight.transform, (taskCount > TowerTaskView.NormalTaskCount or nil) and (TowerTaskView.MoreTaskPosY or TowerTaskView.NormalTaskPosY))

	local curSelectTowerType = TowerTaskModel.instance.curSelectTowerType
	local isSelectActType = curSelectTowerType == TowerEnum.ActTaskType

	recthelper.setHeight(self._scrolltaskList.gameObject.transform, (isSelectActType or nil) and (TowerTaskView.ActTaskScrollHeight or TowerTaskView.NormalTaskScrollHeight))
end

function TowerTaskView:refreshLeftUI()
	local hasBossTask = TowerTaskModel.instance:checkHasBossTask()

	gohelper.setActive(self._simageFullBG.gameObject, hasBossTask)
	gohelper.setActive(self._goLeft, hasBossTask)
	gohelper.setActive(self._goFullBg2, not hasBossTask)
end

function TowerTaskView:refreshReddot()
	for type, towerItemTab in pairs(self.towerItemTab) do
		for towerId, towerItem in pairs(towerItemTab) do
			local canShowReddot = TowerTaskModel.instance:canShowReddot(type, towerId)

			gohelper.setActive(towerItem.timeTowerUI.goNormalReddot, canShowReddot and type == TowerEnum.TowerType.Limited)
			gohelper.setActive(towerItem.timeTowerUI.goSelectReddot, canShowReddot and type == TowerEnum.TowerType.Limited)
			gohelper.setActive(towerItem.bossTowerUI.goNormalReddot, canShowReddot and type == TowerEnum.TowerType.Boss)
			gohelper.setActive(towerItem.bossTowerUI.goSelectReddot, canShowReddot and type == TowerEnum.TowerType.Boss)
			gohelper.setActive(towerItem.actTowerUI.goNormalReddot, canShowReddot and type == TowerEnum.ActTaskType)
			gohelper.setActive(towerItem.actTowerUI.goSelectReddot, canShowReddot and type == TowerEnum.ActTaskType)
		end
	end
end

function TowerTaskView:refreshActReward()
	local curSelectTowerType = TowerTaskModel.instance.curSelectTowerType
	local isSelectActType = curSelectTowerType == TowerEnum.ActTaskType

	self.actRewardTaskMO = TowerTaskModel.instance:getActRewardTask()

	gohelper.setActive(self._goactReward, isSelectActType and self.actRewardTaskMO)

	if not isSelectActType or not self.actRewardTaskMO then
		return
	end

	if self.showActRewardEnter then
		self._animActReward:Play(UIAnimationName.Open, 0, 0)
	else
		self._animActReward:Play(UIAnimationName.Idle, 0, 0)
	end

	self._txtactReward.text = self.actRewardTaskMO.config.desc

	local rewardList = string.split(self.actRewardTaskMO.config.bonus, "#")
	local config, icon = ItemModel.instance:getItemConfigAndIcon(rewardList[1], rewardList[2])

	self._simageRewardIcon:LoadImage(icon)

	self._txtRewardCount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), rewardList[3])

	local actTaskFinishList = {}

	for i = 1, self.actRewardTaskMO.config.maxProgress do
		table.insert(actTaskFinishList, i <= self.actRewardTaskMO.progress and 1 or 0)
	end

	gohelper.setActive(self._btnactNormal.gameObject, not TowerTaskModel.instance:isTaskFinished(self.actRewardTaskMO) and not self.actRewardTaskMO.hasFinished)
	gohelper.setActive(self._btnCanget.gameObject, self.actRewardTaskMO.hasFinished)
	gohelper.setActive(self._goactHasget, TowerTaskModel.instance:isTaskFinished(self.actRewardTaskMO) and not self.actRewardTaskMO.hasFinished)
	gohelper.CreateObjList(self, self.taskRewardProgressShow, actTaskFinishList, self._goactPointContent, self._goactPointItem)
end

function TowerTaskView:taskRewardProgressShow(obj, data, index)
	local light = gohelper.findChild(obj, "go_light")

	gohelper.setActive(light, data == 1)
end

function TowerTaskView:_playGetRewardFinishAnim(index)
	if index then
		self.removeIndexTab = {
			index
		}
	end

	TaskDispatcher.runDelay(self.delayPlayFinishAnim, self, TowerTaskView.TaskGetAnimTime)
end

function TowerTaskView:delayPlayFinishAnim()
	self._taskAnimRemoveItem:removeByIndexs(self.removeIndexTab)
end

function TowerTaskView:endEnterAnimBlock()
	UIBlockMgr.instance:endBlock(TowerTaskView.EnterViewAnimBlock)
end

function TowerTaskView:onClose()
	for _, towerItem in ipairs(self.towerItemList) do
		towerItem.btnClick:RemoveClickListener()
		towerItem.bossTowerUI.simageNormalIcon:UnLoadImage()
		towerItem.bossTowerUI.simageSelectIcon:UnLoadImage()
	end

	UIBlockMgr.instance:endBlock(TowerTaskView.EnterViewAnimBlock)
	TaskDispatcher.cancelTask(self.endEnterAnimBlock, self)
	TaskDispatcher.cancelTask(self.delayPlayFinishAnim, self)
	self._simageRewardIcon:UnLoadImage()
end

function TowerTaskView:onDestroyView()
	return
end

return TowerTaskView
