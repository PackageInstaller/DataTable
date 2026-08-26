-- chunkname: @modules/logic/room/view/record/RoomTradeTaskView.lua

module("modules.logic.room.view.record.RoomTradeTaskView", package.seeall)

local RoomTradeTaskView = class("RoomTradeTaskView", BaseView)

function RoomTradeTaskView:onInitView()
	self._btnlog = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_log")
	self._gologreddot = gohelper.findChild(self.viewGO, "root/#btn_log/#go_logreddot")
	self._btnhandbook = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_handbook")
	self._gohandbookreddot = gohelper.findChild(self.viewGO, "root/#btn_handbook/#go_handbookreddot")
	self._simageidcard = gohelper.findChildSingleImage(self.viewGO, "root/playerInfo/#simage_idcard")
	self._txtplayername = gohelper.findChildText(self.viewGO, "root/playerInfo/#txt_playername")
	self._txtplayerId = gohelper.findChildText(self.viewGO, "root/playerInfo/#txt_playerId")
	self._simageheroIcon = gohelper.findChildSingleImage(self.viewGO, "root/playerInfo/#simage_heroIcon")
	self._txtlevel = gohelper.findChildText(self.viewGO, "root/playerInfo/#txt_level")
	self._txtscale = gohelper.findChildText(self.viewGO, "root/playerInfo/#txt_scale")
	self._golevelUp = gohelper.findChild(self.viewGO, "root/levelup/#go_levelUp")
	self._scrolllevel = gohelper.findChildScrollRect(self.viewGO, "root/levelup/#go_levelUp/#scroll_level")
	self._txtleveluptip = gohelper.findChildText(self.viewGO, "root/levelup/#go_levelUp/#txt_levelup_tip")
	self._btnlevelup = gohelper.findChildButtonWithAudio(self.viewGO, "root/levelup/#go_levelUp/#btn_levelup")
	self._golevelupreddot = gohelper.findChild(self.viewGO, "root/levelup/#go_levelUp/#btn_levelup/#go_levelupreddot")
	self._gomax = gohelper.findChild(self.viewGO, "root/levelup/#go_max")
	self._txttasktitle = gohelper.findChildText(self.viewGO, "root/task/title/txt_task_title")
	self._btntaskleft = gohelper.findChildButtonWithAudio(self.viewGO, "root/task/title/#btn_taskleft")
	self._btntaskright = gohelper.findChildButtonWithAudio(self.viewGO, "root/task/title/#btn_taskright")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "root/task/#scroll_task")
	self._txtrewardtitle = gohelper.findChildText(self.viewGO, "root/reward/#txt_reward_title")
	self._btnrewardleft = gohelper.findChildButtonWithAudio(self.viewGO, "root/reward/#txt_reward_title/#btn_rewardleft")
	self._gorewardleftreddot = gohelper.findChild(self.viewGO, "root/reward/#txt_reward_title/#btn_rewardleft/#go_leftreddot")
	self._btnrewardright = gohelper.findChildButtonWithAudio(self.viewGO, "root/reward/#txt_reward_title/#btn_rewardright")
	self._gorewardrightreddot = gohelper.findChild(self.viewGO, "root/reward/#txt_reward_title/#btn_rewardright/#go_rightreddot")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "root/reward/#scroll_reward")
	self._gotaskrewarditem = gohelper.findChild(self.viewGO, "root/reward/#scroll_reward/Viewport/Content/#go_taskrewarditem")
	self._btngetclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/reward/#scroll_reward/#btn_getclick")
	self._txtprogress = gohelper.findChildText(self.viewGO, "root/reward/progress/#txt_progress")
	self._gopoint = gohelper.findChild(self.viewGO, "root/reward/point/#go_point")
	self._btnachievement = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_achievement")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTradeTaskView:addEvents()
	self._btnlog:AddClickListener(self._btnlogOnClick, self)
	self._btnhandbook:AddClickListener(self._btnhandbookOnClick, self)
	self._btnlevelup:AddClickListener(self._btnlevelupOnClick, self)
	self._btntaskleft:AddClickListener(self._btntaskleftOnClick, self)
	self._btntaskright:AddClickListener(self._btntaskrightOnClick, self)
	self._btnrewardleft:AddClickListener(self._btnrewardleftOnClick, self)
	self._btnrewardright:AddClickListener(self._btnrewardrightOnClick, self)
	self._btngetclick:AddClickListener(self._btngetclickOnClick, self)
	self._btnachievement:AddClickListener(self._btnachievementOnClick, self)
end

function RoomTradeTaskView:removeEvents()
	self._btnlog:RemoveClickListener()
	self._btnhandbook:RemoveClickListener()
	self._btnlevelup:RemoveClickListener()
	self._btntaskleft:RemoveClickListener()
	self._btntaskright:RemoveClickListener()
	self._btnrewardleft:RemoveClickListener()
	self._btnrewardright:RemoveClickListener()
	self._btngetclick:RemoveClickListener()
	self._btnachievement:RemoveClickListener()
end

function RoomTradeTaskView:_btnlogOnClick()
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.Task2Log,
		view = RoomRecordEnum.View.Log
	})
end

function RoomTradeTaskView:_btnhandbookOnClick()
	RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
		animName = RoomRecordEnum.AnimName.Task2HandBook,
		view = RoomRecordEnum.View.HandBook
	})
end

function RoomTradeTaskView:_btngetclickOnClick()
	if not self._selectTaskRewardIndex then
		return
	end

	local isCanGet, isGot = RoomTradeTaskModel.instance:isCanLevelBonus(self._selectTaskRewardIndex)

	if isGot then
		return
	end

	if not isCanGet then
		return
	end

	RoomRpc.instance:sendGetTradeSupportBonusRequest(self._selectTaskRewardIndex)
end

function RoomTradeTaskView:_btnlevelupOnClick()
	local isCanLevel = RoomTradeTaskModel.instance:isCanLevelUp()

	if isCanLevel then
		RoomRpc.instance:sendTradeLevelUpRequest()
	end
end

RoomTradeTaskView.SwitchAnimTime = 0.16
RoomTradeTaskView.SwitchAnimTime2 = 0.367

function RoomTradeTaskView:_btntaskleftOnClick()
	if self._isLongPress then
		return
	end

	self:_btntaskleftOnClickCallBack()
end

function RoomTradeTaskView:_btntaskleftOnClickCallBack()
	if self._isPlayingTaskSwitchAnim or self._curShowLevel <= 1 then
		return
	end

	self._isPlayingTaskSwitchAnim = true

	self._taskAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(self._cutLastLevelTask, self, RoomTradeTaskView.SwitchAnimTime)
end

function RoomTradeTaskView:_btntaskrightOnClick()
	if self._isLongPress then
		return
	end

	self:_btntasRighttOnClickCallBack()
end

function RoomTradeTaskView:_btntasRighttOnClickCallBack()
	if self._isPlayingTaskSwitchAnim or self._curShowLevel >= self:_getMaxLevel() then
		return
	end

	self._isPlayingTaskSwitchAnim = true

	self._taskAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(self._cutNextLevelTask, self, RoomTradeTaskView.SwitchAnimTime)
end

function RoomTradeTaskView:_btnrewardleftOnClick()
	if self._isPlayingRewardSwitchAnim or self._selectTaskRewardIndex <= 1 then
		return
	end

	self._isPlayingRewardSwitchAnim = true

	self._rewardAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(self._cutLastTaskReward, self, RoomTradeTaskView.SwitchAnimTime)
end

function RoomTradeTaskView:_btnrewardrightOnClick()
	if self._isPlayingRewardSwitchAnim or self._selectTaskRewardIndex >= self._rewardPointPage then
		return
	end

	self._isPlayingRewardSwitchAnim = true

	self._rewardAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(self._cutNextTaskReward, self, RoomTradeTaskView.SwitchAnimTime)
end

function RoomTradeTaskView:_btnachievementOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(VersionActivity2_2Enum.ActivityId.RoomCritter)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	if achievementJumpId then
		achievementJumpId = tonumber(achievementJumpId)

		local jumpConfig = JumpConfig.instance:getJumpConfig(achievementJumpId)

		if jumpConfig then
			local jumpParam = jumpConfig.param
			local jumpData = string.split(jumpParam, "#")

			AchievementController.instance:openAchievementGroupPreView(tonumber(jumpData[3]), jumpData[4])
		end
	end
end

function RoomTradeTaskView:_ontaskleftLongPress()
	if self._isPlayingTaskSwitchAnim then
		return
	end

	local level = self:_getNotFinishTaskLevel(true)

	if level and level == self._curShowLevel then
		return
	end

	self._isLongPress = true

	self._taskAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(self._btntaskleftOnClickCallBack, self, RoomTradeTaskView.SwitchAnimTime2)
end

function RoomTradeTaskView:_ontaskrightLongPress()
	if self._isPlayingTaskSwitchAnim then
		return
	end

	local level = self:_getNotFinishTaskLevel(false)

	if level and level == self._curShowLevel then
		return
	end

	self._isLongPress = true

	self._taskAnimator:Play(RoomTradeEnum.TradeTaskAnim.Swicth, 0, 0)
	TaskDispatcher.runDelay(self._btntasRighttOnClickCallBack, self, RoomTradeTaskView.SwitchAnimTime2)
end

function RoomTradeTaskView:_onClicktaskleftDownHandler()
	self._isLongPress = nil
end

function RoomTradeTaskView:_onClicktaskrightDownHandler()
	self._isLongPress = nil
end

function RoomTradeTaskView:_getNotFinishTaskLevel(isPre)
	if isPre then
		if self._curShowLevel <= 1 or not self._curShowLevel then
			return
		end

		for i = self._curShowLevel - 1, 2 do
			if RoomTradeTaskListModel.instance:getFinishOrNotTaskIds(i, false) then
				return i
			end
		end
	else
		if self._curShowLevel >= self:_getCurLevel() or not self._curShowLevel then
			return
		end

		for i = self._curShowLevel + 1, self:_getCurLevel() do
			if RoomTradeTaskListModel.instance:getFinishOrNotTaskIds(i, false) then
				return i
			end
		end
	end
end

local PRESS_TIME = 2
local NEXT_PRESS_TIME = 99999

function RoomTradeTaskView:_editableInitView()
	self._goReward = gohelper.findChild(self.viewGO, "root/reward")
	self._gotask = gohelper.findChild(self.viewGO, "root/task")

	gohelper.setActive(self._gotaskrewarditem, false)
	gohelper.setActive(self._gopoint, false)

	self._rewardAnimator = self._goReward:GetComponent(typeof(UnityEngine.Animator))
	self._taskAnimator = self._gotask:GetComponent(typeof(UnityEngine.Animator))
	self._btntaskleftlongPrees = SLFramework.UGUI.UILongPressListener.Get(self._btntaskleft.gameObject)

	self._btntaskleftlongPrees:SetLongPressTime({
		PRESS_TIME,
		NEXT_PRESS_TIME
	})
	self._btntaskleftlongPrees:AddLongPressListener(self._ontaskleftLongPress, self)

	self._tasklefttouch = SLFramework.UGUI.UIClickListener.Get(self._btntaskleft.gameObject)

	self._tasklefttouch:AddClickDownListener(self._onClicktaskleftDownHandler, self)

	self._btntaskrightlongPrees = SLFramework.UGUI.UILongPressListener.Get(self._btntaskright.gameObject)

	self._btntaskrightlongPrees:SetLongPressTime({
		PRESS_TIME,
		NEXT_PRESS_TIME
	})
	self._btntaskrightlongPrees:AddLongPressListener(self._ontaskrightLongPress, self)

	self._taskrighttouch = SLFramework.UGUI.UIClickListener.Get(self._btntaskright.gameObject)

	self._taskrighttouch:AddClickDownListener(self._onClicktaskrightDownHandler, self)

	self._taskContent = self._scrolltask.content.gameObject
end

function RoomTradeTaskView:onUpdateParam()
	return
end

function RoomTradeTaskView:_addEvents()
	self.addEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnGetTradeTaskInfo, self._onGetTradeTaskInfo, self)
	self.addEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnReadNewTradeTaskReply, self._onReadNewTradeTaskReply, self)
	self.addEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, self._onTradeLevelUpReply, self)
	self.addEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnGetTradeSupportBonusReply, self._onGetTradeSupportBonusReply, self)
end

function RoomTradeTaskView:_removeEvents()
	self.removeEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnGetTradeTaskInfo, self._onGetTradeTaskInfo, self)
	self.removeEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnReadNewTradeTaskReply, self._onReadNewTradeTaskReply, self)
	self.removeEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, self._onTradeLevelUpReply, self)
	self.removeEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnGetTradeSupportBonusReply, self._onGetTradeSupportBonusReply, self)

	if self._btntaskleftlongPrees then
		self._btntaskleftlongPrees:RemoveLongPressListener()

		self._btntaskleftlongPrees = nil
	end

	if self._btntaskrightlongPrees then
		self._btntaskrightlongPrees:RemoveLongPressListener()

		self._btntaskrightlongPrees = nil
	end

	if self._tasklefttouch then
		self._tasklefttouch:RemoveClickDownListener()

		self._tasklefttouch = nil
	end

	if self._taskrighttouch then
		self._taskrighttouch:RemoveClickDownListener()

		self._taskrighttouch = nil
	end
end

function RoomTradeTaskView:_onGetTradeTaskInfo()
	self._curShowLevel = nil

	local level = self:_getCurLevel()

	self:_cutLevelTask(level)
	self:onRefresh()
end

function RoomTradeTaskView:_onReadNewTradeTaskReply()
	self:_refreshTaskReward()
end

function RoomTradeTaskView:_onTradeLevelUpReply(level)
	self:onRefresh()
	self:_cutLevelTask(level)
	RoomTradeController.instance:openLevelUpTipView(level)
end

function RoomTradeTaskView:_onGetTradeSupportBonusReply()
	self:_refreshSelectTaskReward(self._selectTaskRewardIndex)
	self:_refreshTaskItemList(self._curShowLevel)
end

function RoomTradeTaskView:onOpen()
	self:_addEvents()

	self._rewardPointCount, self._rewardPointPage = RoomTradeTaskModel.instance:getTaskPointMaxCount()

	self:_onGetTradeTaskInfo()
	self:_setPlayerInfo()
	RedDotController.instance:addRedDot(self._golevelupreddot, RedDotEnum.DotNode.TradeTaskLevelUp)
	RedDotController.instance:addRedDot(self._gorewardleftreddot, RedDotEnum.DotNode.TradeTaskGetBonus)
	RedDotController.instance:addRedDot(self._gorewardrightreddot, RedDotEnum.DotNode.TradeTaskGetBonus)
	RedDotController.instance:addRedDot(self._gohandbookreddot, RedDotEnum.DotNode.CritterHandBook)
	RedDotController.instance:addRedDot(self._gologreddot, RedDotEnum.DotNode.CritterLog)
end

function RoomTradeTaskView:_getCanGetTaskPage()
	for i = 1, self._rewardPointPage do
		local isCanGet, isGot = RoomTradeTaskModel.instance:isCanLevelBonus(i)

		if isCanGet then
			if not isGot then
				return i
			end
		else
			return i
		end
	end

	return 1
end

function RoomTradeTaskView:_isLeftCanGetBonus()
	if not self._selectTaskRewardIndex or self._selectTaskRewardIndex <= 1 then
		return
	end

	for i = 1, self._selectTaskRewardIndex - 1 do
		local isCanGet, isGot = RoomTradeTaskModel.instance:isCanLevelBonus(i)

		if isCanGet and not isGot then
			return true
		end
	end

	return false
end

function RoomTradeTaskView:_isRightCanGetBonus()
	if not self._selectTaskRewardIndex or self._selectTaskRewardIndex >= self._rewardPointPage then
		return
	end

	for i = self._selectTaskRewardIndex + 1, self._rewardPointPage do
		local isCanGet, isGot = RoomTradeTaskModel.instance:isCanLevelBonus(i)

		if isCanGet and not isGot then
			return true
		end
	end

	return false
end

function RoomTradeTaskView:onRefresh()
	self:_refreshLevelReward()
	self:_refreshLevel()

	self._selectTaskRewardIndex = self._selectTaskRewardIndex or self:_getCanGetTaskPage()

	self:_refreshSelectTaskReward(self._selectTaskRewardIndex)
	self:_refreshLevelUnlock()
	self:_newFinishTask()
end

function RoomTradeTaskView:onClose()
	return
end

function RoomTradeTaskView:onDestroyView()
	self._simageheroIcon:UnLoadImage()
	self._simageidcard:UnLoadImage()
	self:_removeEvents()
	TaskDispatcher.cancelTask(self._cutLastLevelTask, self)
	TaskDispatcher.cancelTask(self._cutNextLevelTask, self)
	TaskDispatcher.cancelTask(self._cutLastTaskReward, self)
	TaskDispatcher.cancelTask(self._cutNextTaskReward, self)
	TaskDispatcher.cancelTask(self._btntaskleftOnClickCallBack, self)
	TaskDispatcher.cancelTask(self._btntasRighttOnClickCallBack, self)
end

function RoomTradeTaskView:_setPlayerInfo()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageheroIcon)

	self._liveHeadIcon:setLiveHead(playerInfo.portrait)

	self._txtplayername.text = playerInfo.name
	self._txtplayerId.text = "ID:" .. playerInfo.userId
end

function RoomTradeTaskView:_refreshLevel()
	local level = self:_getCurLevel()
	local co = ManufactureConfig.instance:getTradeLevelCfg(level)

	self._txtlevel.text = co.dimension
	self._txtscale.text = co.job

	local cardRes = ResUrl.getRoomCritterIcon(co.jobCard)

	self._simageidcard:LoadImage(cardRes)

	local openSupportBonusLevel = RoomTradeTaskModel.instance:getOpenSupportLevel()

	gohelper.setActive(self._goReward, openSupportBonusLevel <= level)
end

function RoomTradeTaskView:_getCurLevel()
	return ManufactureModel.instance:getTradeLevel() or 1
end

function RoomTradeTaskView:_cutLastLevelTask()
	self:_cutLevelTask(self._curShowLevel - 1)
end

function RoomTradeTaskView:_cutNextLevelTask()
	self:_cutLevelTask(self._curShowLevel + 1)
end

function RoomTradeTaskView:_cutLevelTask(level)
	self._isPlayingTaskSwitchAnim = false
	level = math.min(RoomTradeTaskModel.instance:getTaskMaxLevel(), level)

	if self._curShowLevel == level then
		return
	end

	self._curShowLevel = level

	self:_refreshTaskItemList(level)

	local co = RoomTradeConfig.instance:getLevelCo(level)

	self._txttasktitle.text = co.taskName

	gohelper.setActive(self._btntaskleft.gameObject, level > 1)
	gohelper.setActive(self._btntaskright.gameObject, level < self:_getMaxLevel())
end

function RoomTradeTaskView:_getMaxLevel()
	return math.min(self:_getCurLevel(), RoomTradeTaskModel.instance:getTaskMaxLevel())
end

function RoomTradeTaskView:_refreshTaskItemList(level)
	local dataList = RoomTradeTaskListModel.instance:setMoList(level)

	self._taskItems = self._taskItems or self:getUserDataTb_()

	local y = 0

	if dataList then
		for i, data in ipairs(dataList) do
			local item = self:_getTaskItem(i)

			item:onUpdateMO(data)

			y = item:getNextItemAnchorY(y)
		end

		for i, item in ipairs(self._taskItems) do
			item:activeGo(i <= #dataList)
		end
	end

	recthelper.setHeight(self._taskContent.transform, math.abs(y))
end

function RoomTradeTaskView:_getTaskItem(index)
	local item = self._taskItems[index]

	if not item then
		local path = self.viewContainer:getSetting().otherRes[1]
		local childGO = self:getResInst(path, self._taskContent, "task_item" .. tostring(index))

		item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, RoomTradeTaskItem)
		self._taskItems[index] = item
	end

	return item
end

function RoomTradeTaskView:_refreshLevelReward()
	local level = self:_getCurLevel()
	local co = RoomTradeConfig.instance:getLevelCo(level)
	local curFinishTaskCount, needTaskCount = RoomTradeTaskModel.instance:getLevelTaskCount(level)
	local taskName = co.taskName
	local color = needTaskCount <= curFinishTaskCount and "#000000" or "#b6341a"
	local lang = luaLang("room_finish_tradetask")
	local param = {
		taskName,
		color,
		curFinishTaskCount,
		needTaskCount
	}

	self._txtleveluptip.text = GameUtil.getSubPlaceholderLuaLang(lang, param)
end

function RoomTradeTaskView:_refreshLevelUnlock()
	local isCanLevel, level, isMax = RoomTradeTaskModel.instance:isCanLevelUp()

	gohelper.setActive(self._golevelUp, not isMax)
	gohelper.setActive(self._gomax, isMax)

	if isMax then
		return
	end

	ZProj.UGUIHelper.SetGrayscale(self._btnlevelup.gameObject, not isCanLevel)

	local nextLevelUnlockList = RoomTradeTaskModel.instance:getLevelUnlock(level + 1)

	self._refreshLevelUnlockItem = self._refreshLevelUnlockItem or self:getUserDataTb_()

	if nextLevelUnlockList then
		for i, unlock in ipairs(nextLevelUnlockList) do
			local item = self:_getLevelUnlockItem(i)

			item:onRefreshMo(unlock)
			gohelper.setActive(item.viewGO, true)
		end

		if self._refreshLevelUnlockItem then
			for i = 1, #self._refreshLevelUnlockItem do
				gohelper.setActive(self._refreshLevelUnlockItem[i].viewGO, i <= #nextLevelUnlockList)
			end
		end
	end
end

function RoomTradeTaskView:_getLevelUnlockItem(index)
	local item = self._refreshLevelUnlockItem[index]

	if not item then
		local content = self._scrolllevel.content.gameObject
		local path = self.viewContainer:getSetting().otherRes[2]
		local childGO = self:getResInst(path, content)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, RoomTradeLevelUnlockItem)
		self._refreshLevelUnlockItem[index] = item
	end

	return item
end

function RoomTradeTaskView:_refreshTaskReward()
	local gotCount = RoomTradeTaskModel.instance:getTaskFinishPointCount()
	local lang = luaLang("room_trade_reward_progress")
	local color = "#000000"
	local co = RoomTradeConfig.instance:getSupportBonusById(self._selectTaskRewardIndex)
	local maxCount = co.needTask

	self._txtprogress.text = GameUtil.getSubPlaceholderLuaLangThreeParam(lang, color, gotCount, maxCount)

	if self._rewardPointItem then
		for i, item in ipairs(self._rewardPointItem) do
			gohelper.setActive(item.go, i <= self._rewardPointPage)
		end
	end
end

function RoomTradeTaskView:_cutLastTaskReward()
	self:_refreshSelectTaskReward(self._selectTaskRewardIndex - 1)
end

function RoomTradeTaskView:_cutNextTaskReward()
	self:_refreshSelectTaskReward(self._selectTaskRewardIndex + 1)
end

function RoomTradeTaskView:_refreshSelectTaskReward(index)
	self._isPlayingRewardSwitchAnim = false
	self._taskRewards = self._taskRewards or RoomTradeTaskModel.instance:getAllTaskRewards()
	self._taskRewardItemList = self._taskRewardItemList or self:getUserDataTb_()
	self._selectTaskRewardIndex = index

	self:_refreshTaskReward()

	local rewardList = self._taskRewards[index]
	local isCanGet, isGot = RoomTradeTaskModel.instance:isCanLevelBonus(index)

	isCanGet = not isGot and isCanGet

	gohelper.setActive(self._btngetclick.gameObject, isCanGet)

	for index, rewardArr in ipairs(rewardList) do
		local type, id, quantity = rewardArr[1], rewardArr[2], rewardArr[3]
		local rewardItem, isFirst = self:_getRewardItem(index)

		if rewardItem then
			local item = rewardItem.item

			if item then
				item:setMOValue(type, id, quantity, nil, true)

				if isFirst then
					item:setCountFontSize(40)
					item:showStackableNum2()
					item:isShowEffect(true)
				end
			end

			gohelper.setActive(rewardItem.goGot, isGot)
			gohelper.setActive(rewardItem.goCanGet, isCanGet)
		end
	end

	for i = 1, #self._taskRewardItemList do
		gohelper.setActive(self._taskRewardItemList[i].go, i <= #rewardList)
	end

	self._leftDark = self._leftDark or gohelper.findChild(self._btnrewardleft.gameObject, "dark")
	self._rightDark = self._rightDark or gohelper.findChild(self._btnrewardright.gameObject, "dark")

	gohelper.setActive(self._leftDark, index <= 1)
	gohelper.setActive(self._rightDark, index >= self._rewardPointPage)

	for i = 1, self._rewardPointPage do
		local item = self:_getRewardPointItem(i)

		gohelper.setActive(item.normal, i ~= index)
		gohelper.setActive(item.select, i == index)
	end

	for i = 1, #self._rewardPointItem do
		gohelper.setActive(self._rewardPointItem[i].go, i <= self._rewardPointPage)
	end

	gohelper.setActive(self._gorewardleftreddot, self:_isLeftCanGetBonus())
	gohelper.setActive(self._gorewardrightreddot, self:_isRightCanGetBonus())
end

function RoomTradeTaskView:_getRewardItem(index)
	self._taskRewardItemList = self._taskRewardItemList or self:getUserDataTb_()

	local item = self._taskRewardItemList[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gotaskrewarditem)
		local root = gohelper.findChild(go, "item")
		local _item = IconMgr.instance:getCommonPropItemIcon(root)

		item = {
			item = _item,
			go = go,
			goGot = gohelper.findChild(go, "#goHasGet"),
			goCanGet = gohelper.findChild(go, "#goCanGet")
		}

		transformhelper.setLocalScale(_item.go.transform, 0.62, 0.62, 1)

		self._taskRewardItemList[index] = item

		return item, true
	end

	return item, false
end

function RoomTradeTaskView:_getRewardPointItem(index)
	self._rewardPointItem = self._rewardPointItem or self:getUserDataTb_()

	local item = self._rewardPointItem[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gopoint, "point_" .. index)
		local normal = gohelper.findChild(go, "normal")
		local select = gohelper.findChild(go, "select")

		item = {
			go = go,
			normal = normal,
			select = select
		}
		self._rewardPointItem[index] = item
	end

	return item
end

function RoomTradeTaskView:_newFinishTask()
	local ids = RoomTradeTaskListModel.instance:getNewFinishTaskIds(self._curShowLevel)

	if LuaUtil.tableNotEmpty(ids) then
		RoomRpc.instance:sendReadNewTradeTaskRequest(ids)
	end
end

return RoomTradeTaskView
