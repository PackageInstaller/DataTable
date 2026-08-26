-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeartLayerPageItem.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeartLayerPageItem", package.seeall)

local WeekWalk_2HeartLayerPageItem = class("WeekWalk_2HeartLayerPageItem", ListScrollCellExtend)

function WeekWalk_2HeartLayerPageItem:onInitView()
	self._gounlock = gohelper.findChild(self.viewGO, "#go_unlock")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_unlock/#btn_click")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_unlock/#btn_click/#simage_icon")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._btnlock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_lock/#btn_lock")
	self._simagelockicon = gohelper.findChildSingleImage(self.viewGO, "#go_lock/#btn_lock/#simage_lockicon")
	self._gochallenge = gohelper.findChild(self.viewGO, "#go_challenge")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._txtname = gohelper.findChildText(self.viewGO, "info/#txt_name")
	self._txtprogress = gohelper.findChildText(self.viewGO, "info/#txt_progress")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reward")
	self._gorewardIcon = gohelper.findChild(self.viewGO, "#btn_reward/#go_rewardIcon")
	self._gonormalIcon = gohelper.findChild(self.viewGO, "#btn_reward/#go_normalIcon")
	self._gorewardfinish = gohelper.findChild(self.viewGO, "#btn_reward/#go_rewardfinish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2HeartLayerPageItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnlock:AddClickListener(self._btnlockOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
end

function WeekWalk_2HeartLayerPageItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnlock:RemoveClickListener()
	self._btnreward:RemoveClickListener()
end

function WeekWalk_2HeartLayerPageItem:_btnclickOnClick()
	WeekWalk_2Controller.instance:openWeekWalk_2HeartView({
		mapId = self._layerInfo.id
	})
end

function WeekWalk_2HeartLayerPageItem:_btnlockOnClick()
	GameFacade.showToast(ToastEnum.WeekWalkLayerPage)
end

function WeekWalk_2HeartLayerPageItem:_btndetailOnClick()
	return
end

function WeekWalk_2HeartLayerPageItem:_btnrewardOnClick()
	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = self._layerInfo.id
	})
end

function WeekWalk_2HeartLayerPageItem:_editableInitView()
	gohelper.setActive(self._gofinish, false)
	gohelper.setActive(self._gochallenge, false)

	self._animator = self.viewGO:GetComponent("Animator")
end

function WeekWalk_2HeartLayerPageItem:_initChildNodes(typeIndex)
	if self._starsList1 then
		return
	end

	local go = gohelper.findChild(self.viewGO, string.format("info/type%s", typeIndex))

	gohelper.setActive(go, true)

	self._txtbattlename = gohelper.findChildText(self.viewGO, string.format("info/type%s/txt_battlename", typeIndex))
	self._txtnameen = gohelper.findChildText(self.viewGO, string.format("info/type%s/txt_nameen", typeIndex))
	self._txtindex = gohelper.findChildText(self.viewGO, string.format("info/type%s/txt_index", typeIndex))
	self._go1 = gohelper.findChild(self.viewGO, string.format("info/type%s/go_star/starlist/go_icons1/go_1", typeIndex))
	self._go2 = gohelper.findChild(self.viewGO, string.format("info/type%s/go_star/starlist/go_icons2/go_2", typeIndex))
	self._starsList1 = self:getUserDataTb_()
	self._starsList2 = self:getUserDataTb_()

	self:_initStarsList(self._starsList1, self._go1)
	self:_initStarsList(self._starsList2, self._go2)
end

function WeekWalk_2HeartLayerPageItem:_initStarsList(list, go)
	gohelper.setActive(go, false)

	for i = 1, WeekWalk_2Enum.MaxStar do
		local starGo = gohelper.cloneInPlace(go)

		gohelper.setActive(starGo, true)

		local icon = gohelper.findChildImage(starGo, "icon")

		icon.enabled = false

		local iconEffect = self._layerView:getResInst(self._layerView.viewContainer._viewSetting.otherRes.weekwalkheart_star, icon.gameObject)

		table.insert(list, iconEffect)
	end
end

function WeekWalk_2HeartLayerPageItem:_editableAddEvents()
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkInfoChange, self._onChangeInfo, self)
end

function WeekWalk_2HeartLayerPageItem:_editableRemoveEvents()
	self.removeEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
	self.removeEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkInfoChange, self._onChangeInfo, self)
end

function WeekWalk_2HeartLayerPageItem:_onChangeInfo()
	self:_updateStatus()
end

function WeekWalk_2HeartLayerPageItem:_onWeekwalkTaskUpdate()
	self:_updateStatus()
end

function WeekWalk_2HeartLayerPageItem:setFakeUnlock(value)
	self._fakeUnlock = value

	self:_updateStatus()
end

function WeekWalk_2HeartLayerPageItem:playUnlockAnim()
	gohelper.setActive(self._gounlock, true)
	gohelper.setActive(self._golock, true)
	self._animator:Play("unlock", 0, 0)
	TaskDispatcher.runDelay(self._unlockAnimDone, self, 1.5)
	AudioMgr.instance:trigger(AudioEnum2_6.WeekWalk_2.play_ui_fight_artificial_unlock)
end

function WeekWalk_2HeartLayerPageItem:_unlockAnimDone()
	gohelper.setActive(self._golock, false)
end

function WeekWalk_2HeartLayerPageItem:getIndex()
	return self._index
end

function WeekWalk_2HeartLayerPageItem:getLayerId()
	return self._layerInfo and self._layerInfo.id
end

function WeekWalk_2HeartLayerPageItem:onUpdateMO(mo)
	self._index = mo.index
	self._layerView = mo.layerView
	self._typeIndex = self._index == 4 and 1 or self._index
	self._fakeUnlock = true

	self:_initChildNodes(self._typeIndex)
	self:_updateStatus()
end

function WeekWalk_2HeartLayerPageItem:_updateStatus()
	self._layerInfo = WeekWalk_2Model.instance:getLayerInfoByLayerIndex(self._index)
	self._layerSceneConfig = self._layerInfo.sceneConfig
	self._isUnLock = self._layerInfo.unlock and self._fakeUnlock

	gohelper.setActive(self._golock, not self._isUnLock)
	gohelper.setActive(self._gounlock, self._isUnLock)

	self._txtbattlename.text = self._layerSceneConfig.battleName
	self._txtnameen.text = self._layerSceneConfig.name_en
	self._txtname.text = self._layerSceneConfig.name
	self._txtindex.text = tostring(self._index)

	local iconPath = string.format("weekwalkheart_stage%s", self._layerInfo.config.layer)

	self._simageicon:LoadImage(ResUrl.getWeekWalkLayerIcon(iconPath))
	self._simagelockicon:LoadImage(ResUrl.getWeekWalkLayerIcon(iconPath))
	self:_updateStars()
	self:_updateRewardStatus()
	self:_updateProgress()

	local battleInfo1 = self._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.First)
	local battleInfo2 = self._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second)
	local isFinish = battleInfo1.status == WeekWalk_2Enum.BattleStatus.Finished and battleInfo2.status == WeekWalk_2Enum.BattleStatus.Finished

	gohelper.setActive(self._gofinish, isFinish)
	gohelper.setActive(self._gochallenge, not isFinish and self._isUnLock)
end

function WeekWalk_2HeartLayerPageItem:_updateProgress()
	local rewardList = WeekWalk_2Config.instance:getWeekWalkRewardList(self._layerInfo.config.layer)
	local cur = 0
	local total = 0

	if rewardList then
		for taskId, num in pairs(rewardList) do
			local taskConfig = lua_task_weekwalk_ver2.configDict[taskId]

			if taskConfig and WeekWalk_2TaskListModel.instance:checkPeriods(taskConfig) then
				total = total + num

				local taskMo = WeekWalk_2TaskListModel.instance:getTaskMo(taskId)
				local config = lua_task_weekwalk_ver2.configDict[taskId]
				local isGet = taskMo and taskMo.finishCount >= config.maxFinishCount

				if isGet then
					cur = cur + num
				end
			end
		end
	end

	self._txtprogress.text = string.format("%s/%s", cur, total)
	self._txtprogress.alpha = total <= cur and 0.45 or 1
end

function WeekWalk_2HeartLayerPageItem:_updateRewardStatus()
	gohelper.setActive(self._btnreward, true)

	local mapId = self._layerInfo.id
	local taskType = WeekWalk_2Enum.TaskType.Season
	local canGetNum, unFinishNum = WeekWalk_2TaskListModel.instance:canGetRewardNum(taskType, mapId)
	local canGetReward = canGetNum > 0

	gohelper.setActive(self._gorewardIcon, canGetReward)
	gohelper.setActive(self._gorewardfinish, not canGetReward and unFinishNum <= 0)
	gohelper.setActive(self._gonormalIcon, not canGetReward and unFinishNum > 0)
end

function WeekWalk_2HeartLayerPageItem:_updateStars()
	local battleInfo1 = self._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.First)
	local battleInfo2 = self._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second)

	self:_updateStarList(self._starsList1, battleInfo1)
	self:_updateStarList(self._starsList2, battleInfo2)
end

function WeekWalk_2HeartLayerPageItem:_updateStarList(starList, battleInfo)
	for i, icon in ipairs(starList) do
		local cupInfo = battleInfo:getCupInfo(i)

		if cupInfo then
			if not cupInfo.result then
				local star = 0
				local showStar = star > 0

				gohelper.setActive(icon, showStar)

				if showStar then
					WeekWalk_2Helper.setCupEffect(icon, cupInfo)
				end
			end
		end
	end
end

function WeekWalk_2HeartLayerPageItem:onSelect(isSelect)
	return
end

function WeekWalk_2HeartLayerPageItem:onDestroyView()
	TaskDispatcher.cancelTask(self._unlockAnimDone, self)
end

return WeekWalk_2HeartLayerPageItem
