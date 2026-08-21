-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomBuildTaskView.lua

module("logic.extensions.housemain.view.RoomBuildTaskView", package.seeall)

local M = class("RoomBuildTaskView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._imgIcon = self:getImage("room_build_task_view_370297119")
	self._txtLv = self:getText("room_build_task_view_1109828513")
	self._txtNum = self:getText("room_build_task_view_-262323006")
	self._txtUnlockTitle = self:getText("room_build_task_view_705157062")
	self._txtUnlockHint = self:getText("room_build_task_view_-86110591")
	self._imgLvProcess = self:getImage("room_build_task_view_-1291312611")
	self._rectTrLvProcessBar = self:getUIComponent("room_build_task_view_-91547642", UIComponentType.RectTransform)

	local goBtnGainLvReward = self:getGo("room_build_task_view_-1352094056")

	goutil.setActive(goBtnGainLvReward, false)

	self._goContentDaily = self:getGo("room_build_task_view_-1818661955")
	self._loopListReward = LoopListHelper.New(self:getGo("room_build_task_view_1874190450"))

	self._loopListReward:InitListView(0, self._onCellRewardUpdate, self)

	self._loopListTask = LoopListHelper.New(self:getGo("room_build_task_view_-357679587"))

	self._loopListTask:InitListView(0, self._onCellTaskUpdate, self)

	local toggleDaily = self:getUIComponent("room_build_task_view_1024807982", UIComponentType.SpaceXToggle)
	local toggleAch = self:getUIComponent("room_build_task_view_-512141679", UIComponentType.SpaceXToggle)

	self._toggleGroup = ToggleTabControl.New()

	self._toggleGroup:setViewPager(self)
	self._toggleGroup:addToggleTab(toggleDaily)
	self._toggleGroup:addToggleTab(toggleAch)

	self._redPointDaily = goutil.findChild(toggleDaily.gameObject, "red_point").gameObject
	self._redPointAch = goutil.findChild(toggleAch.gameObject, "red_point").gameObject
end

function M:destroyUI()
	self._imgIcon = nil
	self._txtLv = nil
	self._txtNum = nil
	self._txtUnlockTitle = nil
	self._txtUnlockHint = nil
	self._imgLvProcess = nil
	self._rectTrLvProcessBar = nil
	self._goContentDaily = nil

	self._loopListReward:Dispose()

	self._loopListReward = nil

	self._loopListTask:Dispose()

	self._loopListTask = nil

	self._toggleGroup:destroy()

	self._toggleGroup = nil
	self._redPointDaily = nil
	self._redPointAch = nil

	for key, value in pairs(self._cellItem or {}) do
		value:destroyUI()
	end

	self._cellItem = nil

	self:fakeDestroyUI()
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	for key, value in pairs(self._cellItem or {}) do
		value:unbindEvents()
	end

	self:fakeUnBindEvent()
end

function M:onEnter()
	self._taskCanRewardCountDaily = 0
	self._taskCanRewardCountAch = 0
	self._inSliderAni = false
	self._level = false
	self._exp = false
	self._maxExp = false

	TransformUtils.SetLocalScale(self._imgIcon.transform, 1, 1, 1)
	self:_setEvent(true)
	HouseAgent.instance:sendHouseListTaskRequest()

	self._cellItem = {}
	self._activeIndex = 1

	self._toggleGroup:selectTab(1)
	self:_updateLvInfoShow()
	self:_fakeBtnForTest()
end

function M:onExit()
	self._imgLvProcess:DOKill()
	self._imgIcon.transform:DOKill()
	self:_setEvent(false)

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
		value:unbindEvents()
	end

	self._loopListReward:ClearCells()
	self._loopListTask:ClearCells()

	self._activeIndex = nil
	self._itemDataTaskLst = nil
	self._taskDataLstDaily = nil
	self._taskDataLstBuildAchievement = nil
	self._itemDataRewardLst = nil
end

function M:_setEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.HOUSE_LEVEL_INFO_CHANGE, self.handleHouseLevelInfoChange, self)
		HouseDispatcher:addEventListener(HouseEventType.HOUSE_TASK_INFO_CHANGE, self.handleHouseTaskInfoChange, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.HOUSE_LEVEL_INFO_CHANGE, self.handleHouseLevelInfoChange, self)
		HouseDispatcher:removeEventListener(HouseEventType.HOUSE_TASK_INFO_CHANGE, self.handleHouseTaskInfoChange, self)
	end
end

function M:handleHouseLevelInfoChange(e)
	self:_updateLvInfoShow()
end

function M:handleHouseTaskInfoChange(e)
	self:_reflashTaskDataDaily()
	self:_reflashTaskDataBuildAchievement()
end

function M:setPage(tabIndex)
	local needReflash = self._activeIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		self:_updateTaskShow()
	end
end

function M:getPageNum()
	return self._activeIndex
end

function M:onTaskClickGet(taskCell)
	local taskTyp = taskCell:getTaskTyp()
	local taskCellId = taskCell:getId()

	print(string.format("Get typ[%s] id[%s]", taskTyp, taskCellId))

	if HouseTaskModel.instance:canTaskSendServerToReward(taskCellId) then
		local taskIds = {}

		table.insert(taskIds, taskCellId)
		HouseAgent.instance:sendHouseRewardRequest(taskIds)
	end
end

function M:onTaskClickJump(taskCell)
	local taskTyp = taskCell:getTaskTyp()
	local taskCellId = taskCell:getId()
	local jumpId = tonumber(taskCell:getJumpId())

	print(string.format("Get typ[%s] id[%s] jumpId[%s]", taskTyp, taskCellId, jumpId))

	if jumpId > 0 then
		if taskTyp == HouseMainEnum.TaskTyp.Daily then
			-- block empty
		elseif taskTyp == HouseMainEnum.TaskTyp.BuildAchievement then
			-- block empty
		end

		if not SystemJumpController.instance:canJump(jumpId, true) then
			return
		end

		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
	end
end

function M:_updateLvInfoShow()
	local level = HouseTaskModel.instance:getHouseLevel()
	local realExp = HouseTaskModel.instance:getHouseExp()

	self:_checkExpUpgradeAni(level, realExp)

	self._itemDataRewardLst = {}

	local previewLevel = HouseTaskModel.instance:getHouseLevelReceive() + 1
	local cfgPreviewLv = HouseConfig.instance:getConfigByKey(ConfigName.HouseLevel, previewLevel)
	local canReceiveLvReward = HouseTaskModel.instance:canReceiveLvReward()
	local strUnlockTitle, strUnlockHint

	if cfgPreviewLv then
		strUnlockTitle = string.format(lang("tip_build_d_unlock"), previewLevel)
		strUnlockHint = cfgPreviewLv and cfgPreviewLv.desc or ""

		local rewardId = cfgPreviewLv.reward
		local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardId)

		if rewardCO and rewardCO.reward then
			for i, v in ipairs(rewardCO.reward) do
				local itemData = ItemUtil.createItemData({
					itemId = v.code
				})

				itemData:setCount(v.num)
				table.insert(self._itemDataRewardLst, itemData)
			end
		end
	else
		strUnlockTitle = lang("tip_reach_max_level")
		strUnlockHint = ""
	end

	self._txtUnlockTitle.text = strUnlockTitle
	self._txtUnlockHint.text = strUnlockHint

	self._loopListReward:SetListItemCount(#self._itemDataRewardLst, true)
	self._loopListReward:RefreshAllShownItem()
end

function M:_checkExpUpgradeAni(level, realExp)
	local offset_lv = 0
	local offset_exp = 0

	if self._exp then
		offset_lv = level - self._level
		offset_exp = realExp - self._exp
	end

	if offset_lv ~= 0 or offset_exp ~= 0 then
		self._targetLv = level
		self._targetExp = realExp

		local process = 0

		if offset_lv ~= 0 then
			process = 1

			local nexLv = self._level + 1
			local cfg = HouseConfig.instance:getConfigByKey(ConfigName.HouseLevel, self._level)

			self:_AniFillSlider(process, nexLv, cfg.exp)
		else
			local point, maxPoint = HouseTaskModel.instance:getExpInfo(level, realExp)

			process = math.floor(point / maxPoint * 100) * 0.01

			self:_AniFillSlider(process, self._targetLv, self._targetExp)
		end
	else
		self:_refreshLvShow(level, realExp)
	end
end

function M:_AniFillSlider(process, lv, exp)
	if not self._inSliderAni then
		self._inSliderAni = true
		self._nowAniLv = lv
		self._nowAniExp = exp

		self._imgLvProcess:DOFillAmount(process, 0.3):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnUpdate(self._sliderAniUpdate, self):OnComplete(self._sliderAniFinish, self)
	end
end

function M:_sliderAniUpdate()
	local val = self._imgLvProcess.fillAmount

	if self._maxExp == 0 then
		-- block empty
	else
		local nowShowVal = math.floor(self._maxExp * val)

		self._txtNum.text = string.format("%d/%d", nowShowVal, self._maxExp)
	end

	local angleZ = 360 * val * -1

	Astral.TransformUtil.SetLocalRotation(self._rectTrLvProcessBar, 0, 0, angleZ)
end

function M:_sliderAniFinish()
	self:_refreshLvShow(self._nowAniLv, self._nowAniExp)

	if self._nowAniLv ~= self._targetLv or self._nowAniExp ~= self._targetExp then
		local offset_lv = self._targetLv - self._nowAniLv
		local offset_exp = self._targetExp - self._nowAniExp
		local process = 0

		if offset_lv ~= 0 then
			process = 1

			local nexLv = self._level + 1
			local cfg = HouseConfig.instance:getConfigByKey(ConfigName.HouseLevel, self._level)

			self._inSliderAni = false

			self:_AniFillSlider(process, nexLv, cfg.exp)
		else
			local point, maxPoint = HouseTaskModel.instance:getExpInfo(self._targetLv, self._targetExp)

			process = math.floor(point / maxPoint * 100) * 0.01
			self._inSliderAni = false

			self:_AniFillSlider(process, self._targetLv, self._targetExp)
		end
	else
		self._inSliderAni = false

		if HouseTaskModel.instance:canReceiveLvReward() then
			HouseAgent.instance:sendReceiveLevelRewardRequest()
		end
	end
end

function M:_refreshLvShow(level, realExp)
	local point, maxPoint = HouseTaskModel.instance:getExpInfo(level, realExp)
	local process = 1

	if maxPoint ~= 0 then
		process = math.floor(point / maxPoint * 100) * 0.01
		self._txtNum.text = string.format("%d/%d", point, maxPoint)
	else
		self._txtNum.text = realExp
	end

	self._imgLvProcess.fillAmount = process
	self._txtLv.text = string.format(lang("tip_build_level_d"), level)

	local angleZ = 360 * process * -1

	Astral.TransformUtil.SetLocalRotation(self._rectTrLvProcessBar, 0, 0, angleZ)

	local cfgLv = HouseConfig.instance:getConfigByKey(ConfigName.HouseLevel, level)

	if cfgLv then
		IconLoader.setSprite(self._imgIcon, IconType.Room, string.format("room_build/%s", cfgLv.icon))

		if self._level and self._lastIconPath and self._lastIconPath ~= cfgLv.icon then
			self._imgIcon.transform:DOKill()
			TransformUtils.SetLocalScale(self._imgIcon.transform, 1.3, 1.3, 1)
			self._imgIcon.transform:DOScale(Vector3.New(1, 1, 1), 0.2):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
		end

		self._lastIconPath = cfgLv.icon
	else
		printError(string.format("无法从[%s]找到[%s]的配置", ConfigName.HouseLevel, level))
	end

	self._level = level
	self._exp = realExp
	self._maxExp = maxPoint
end

function M:_updateTaskShow()
	self._itemDataTaskLst = {}

	local pageNum = self:getPageNum()

	if pageNum == HouseMainEnum.TaskTyp.Daily then
		self._itemDataTaskLst = self:_getTaskDataLstDaily()
	elseif pageNum == HouseMainEnum.TaskTyp.BuildAchievement then
		self._itemDataTaskLst = self:_getTaskDataLstBuildAchievement()
	end

	self._loopListTask:SetListItemCount(#self._itemDataTaskLst, true)
	self._loopListTask:RefreshAllShownItem()
end

function M:_onCellRewardUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local itemData = self._itemDataRewardLst[curIndex]

	if itemData then
		local item = self._loopListReward:NewListViewItem("backpack_item")
		local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, HoldRewardItemCell)

		shower:setCellData(itemData, curIndex)
		shower:setNumBgNodeVisible(false)
		shower:setHandler(self)
		shower:setSignShow(CommEnum.BackPackItemSignTyp.None)
		shower:setIsShowTips(true)
		shower:setCanRewardEff(false)
		shower:setShowSelectedEffect(false)
		shower:setIsShowTipsPassEvent(false)

		self._cellItem[item.gameObject:GetInstanceID()] = shower

		return item
	end
end

function M:_onCellTaskUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local itemData = self._itemDataTaskLst[curIndex]

	if itemData then
		local taskTyp = self:getPageNum()
		local item = self._loopListTask:NewListViewItem("build_task_item")
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, HouseBuildTaskCell)

		shower:setCellData(itemData, taskTyp, curIndex)
		shower:setHandler(self)
		shower:bindEvents()

		self._cellItem[item.gameObject:GetInstanceID()] = shower

		return item
	end
end

function M:_reflashTaskDataDaily()
	self._taskDataLstDaily = {}

	local taskCanRewardNum = 0
	local taskLst = HouseTaskModel.instance:getTaskLst()

	for taskId, houseTaskMo in pairs(taskLst or {}) do
		table.insert(self._taskDataLstDaily, houseTaskMo)

		if houseTaskMo:getTaskState() == HouseMainEnum.TaskState.CanReceived then
			taskCanRewardNum = taskCanRewardNum + 1
		end
	end

	self._taskCanRewardCountDaily = taskCanRewardNum

	local len = #self._taskDataLstDaily

	if len > 0 then
		table.sort(self._taskDataLstDaily, HouseTaskModel.sortAchievement)
	end

	print(string.format("<color=#00CC00>建设任务数量 %s,可领取数量 %s</color>", len, self._taskCanRewardCountDaily))

	if self:getPageNum() == HouseMainEnum.TaskTyp.Daily then
		self:_updateTaskShow()
	end

	goutil.setActive(self._redPointDaily, self._taskCanRewardCountDaily > 0)
end

function M:_getTaskDataLstDaily()
	return self._taskDataLstDaily
end

function M:_reflashTaskDataBuildAchievement()
	self._taskDataLstBuildAchievement = {}

	local taskCanRewardNum = 0
	local taskLst = HouseTaskModel.instance:getAchievementLst()

	for taskId, houseTaskMo in pairs(taskLst or {}) do
		table.insert(self._taskDataLstBuildAchievement, houseTaskMo)

		if houseTaskMo:getTaskState() == HouseMainEnum.TaskState.CanReceived then
			taskCanRewardNum = taskCanRewardNum + 1
		end
	end

	self._taskCanRewardCountAch = taskCanRewardNum

	local len = #self._taskDataLstBuildAchievement

	if len > 0 then
		table.sort(self._taskDataLstBuildAchievement, HouseTaskModel.sortAchievement)
	end

	print(string.format("<color=#00CC00>建设成就数量 %s,可领取数量 %s</color>", len, self._taskCanRewardCountAch))

	if self:getPageNum() == HouseMainEnum.TaskTyp.BuildAchievement then
		self:_updateTaskShow()
	end

	goutil.setActive(self._redPointAch, self._taskCanRewardCountAch > 0)
end

function M:_getTaskDataLstBuildAchievement()
	return self._taskDataLstBuildAchievement
end

function M:fakeUnBindEvent()
	if self._btnFakeAddExp then
		self._btnFakeAddExp:RemoveClickListener()
	end
end

function M:fakeDestroyUI()
	self._btnFakeAddExp = nil
end

function M:_fakeBtnForTest()
	if not Astral.OSDef.isEditor then
		return
	end

	self._btnFakeAddExp = goutil.findChild(self.mainGO, "fakeBtnAddEXP")

	if self._btnFakeAddExp == nil then
		self._btnFakeAddExp = goutil.create("fakeBtnAddEXP", true)

		local tempRect = self._btnFakeAddExp:GetComponent(goutil.Type_RectTransform)

		goutil.setHeight(tempRect, 50)
		goutil.addChildToParent(self._btnFakeAddExp, self.mainGO)

		local tmpHeigh = goutil.getHeight(self.mainGO.transform)

		Astral.TransformUtil.SetLocalPos(self._btnFakeAddExp.transform, 0, tmpHeigh * 0.5 - 25, 0)
		self._btnFakeAddExp.transform:SetAsLastSibling()

		local image = self._btnFakeAddExp:AddComponent(goutil.Type_UIImage)

		image.raycastTarget = true
	end

	self._btnFakeAddExp = UIComponentType.ButtonAdapter(self._btnFakeAddExp)

	self._btnFakeAddExp:AddClickListener(self._fakeOnClickAddExp, self)
end

function M:_fakeOnClickAddExp()
	local gmAddEXP = 100
	local point, maxPoint = HouseTaskModel.instance:getExpInfo(HouseTaskModel.instance:getHouseLevel(), HouseTaskModel.instance:getHouseExp())

	if point < 0 then
		gmAddEXP = point * -1
	else
		gmAddEXP = math.max(gmAddEXP, math.floor(maxPoint * 0.2))
	end

	local data = HackToolUtil.createAddHouseExp(gmAddEXP)

	HackToolAgent.instance:sendGmRequest(data)
end

return M
