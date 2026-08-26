-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/revivaltask/VersionActivity1_5ExploreTaskView.lua

module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5ExploreTaskView", package.seeall)

local VersionActivity1_5ExploreTaskView = class("VersionActivity1_5ExploreTaskView", BaseView)

function VersionActivity1_5ExploreTaskView:onInitView()
	self._goexploretask = gohelper.findChild(self.viewGO, "#go_exploretask")
	self._scrollMap = gohelper.findChildScrollRect(self._goexploretask, "#go_map/Scroll View")
	self._gomapcontent = gohelper.findChild(self._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent")
	self._simagemap1 = gohelper.findChildSingleImage(self._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent/#simage_map1")
	self._simagemap2 = gohelper.findChildSingleImage(self._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent/#simage_map2")
	self._gomapitem = gohelper.findChild(self._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent/Layout/#go_mapitem")
	self._txtnum = gohelper.findChildText(self._goexploretask, "LeftDown/#txt_num")
	self._txttotal = gohelper.findChildText(self._goexploretask, "LeftDown/#txt_total")
	self._gorewarditem = gohelper.findChild(self._goexploretask, "LeftDown/#go_rewarditem")
	self._gohasget = gohelper.findChild(self._goexploretask, "LeftDown/#go_hasget")
	self._gogainreward = gohelper.findChild(self._goexploretask, "LeftDown/#go_gainReward")
	self._sliderprogress = gohelper.findChildSlider(self._goexploretask, "LeftDown/#slider_progress")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5ExploreTaskView:addEvents()
	return
end

function VersionActivity1_5ExploreTaskView:removeEvents()
	return
end

function VersionActivity1_5ExploreTaskView:initReward()
	self.icon = IconMgr.instance:getCommonPropItemIcon(self._gorewarditem)

	local type, id, quantity = VersionActivity1_5DungeonConfig.instance:getExploreReward()

	self.icon:setMOValue(type, id, quantity)
	self.icon:setScale(0.6, 0.6, 0.6)
end

function VersionActivity1_5ExploreTaskView:initLineNodes()
	local goLineParent = gohelper.findChild(self._goexploretask, "#go_map/Scroll View/Viewport/#go_mapcontent/Line")

	self.lineImageList = self:getUserDataTb_()

	for index = 1, goLineParent.transform.childCount do
		local image = gohelper.findChildImage(goLineParent, "line" .. index)

		if not image then
			logError("not found line go, line number : " .. index)
		end

		table.insert(self.lineImageList, image)
	end
end

function VersionActivity1_5ExploreTaskView:_editableInitView()
	self.animator = self._goexploretask:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(self._gomapitem, false)

	self.taskItemList = {}
	self.needRefreshTimeTaskItemList = {}

	for _, taskCo in ipairs(VersionActivity1_5DungeonConfig.instance:getExploreTaskList()) do
		self:createTaskItem(taskCo)
	end

	self:setPosition()

	self.totalCount = #self.taskItemList
	self.rewardClick = gohelper.getClickWithDefaultAudio(self._gogainreward, self)

	self.rewardClick:AddClickListener(self.onClickReward, self)
	self:initReward()
	self:initLineNodes()
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SelectHeroTaskTabChange, self.onSelectHeroTabChange, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnGainedExploreReward, self.onGainedExploreReward, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.HideExploreTip, self.onHideExploreTip, self)
end

function VersionActivity1_5ExploreTaskView:createTaskItem(taskCo)
	local taskItem = self:getUserDataTb_()

	taskItem.go = gohelper.cloneInPlace(self._gomapitem, taskCo.id)
	taskItem.animator = taskItem.go:GetComponent(gohelper.Type_Animator)
	taskItem.rectTr = taskItem.go:GetComponent(typeof(UnityEngine.RectTransform))
	taskItem.goFight = gohelper.findChild(taskItem.go, "btn/fight")
	taskItem.goDispatch = gohelper.findChild(taskItem.go, "btn/dispatch")
	taskItem.goFightImage = taskItem.goFight:GetComponent(gohelper.Type_Image)
	taskItem.goDispatchImage = taskItem.goDispatch:GetComponent(gohelper.Type_Image)
	taskItem.goFinish = gohelper.findChild(taskItem.go, "btn/finish")
	taskItem.goReward = gohelper.findChild(taskItem.go, "btn/finish/reward")
	taskItem.click = gohelper.findChildClickWithDefaultAudio(taskItem.go, "btn/clickarea")

	taskItem.click:AddClickListener(self.onClickTaskItem, self, taskItem)

	taskItem.goTips = gohelper.findChild(taskItem.go, "layout/tips")
	taskItem.goLockTips = gohelper.findChild(taskItem.go, "layout/tips/lockedtips")
	taskItem.txtLockTips = gohelper.findChildText(taskItem.go, "layout/tips/lockedtips/#txt_locked")
	taskItem.goTimeTips = gohelper.findChild(taskItem.go, "layout/tips/timetips")
	taskItem.txtTimeTips = gohelper.findChildText(taskItem.go, "layout/tips/timetips/#txt_time")
	taskItem.goProgressPoint = gohelper.findChild(taskItem.go, "layout/progresspoint")
	taskItem.goProgressPointItem = gohelper.findChild(taskItem.go, "layout/progresspoint/staritem")
	taskItem.taskCo = taskCo
	taskItem.pointDict = {}

	local anchorPos = string.splitToNumber(taskCo.pos, "#")

	recthelper.setAnchor(taskItem.rectTr, anchorPos[1], anchorPos[2])
	gohelper.setActive(taskItem.go, true)
	gohelper.setActive(taskItem.goProgressPointItem, false)
	table.insert(self.taskItemList, taskItem)
end

function VersionActivity1_5ExploreTaskView:onClickTaskItem(taskItem, pos)
	local taskCo = taskItem.taskCo
	local status = VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(taskCo)

	if status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Lock then
		GameFacade.showToastString(taskCo.unlockToastDesc)

		return
	end

	taskItem.animator:Play("open", 0, 0)
	self.viewContainer.exploreTipView:showTip(taskItem, pos)
end

function VersionActivity1_5ExploreTaskView:onHideExploreTip(taskItem)
	taskItem.animator:Play("close", 0, 0)
end

function VersionActivity1_5ExploreTaskView:onClickReward()
	if VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskGainedTotalReward() then
		return
	end

	if self.finishCount < self.totalCount then
		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct139GainExploreRewardRequest()
end

function VersionActivity1_5ExploreTaskView:onSelectHeroTabChange()
	local isShow = VersionActivity1_5RevivalTaskModel.instance:getSelectHeroTaskId() == VersionActivity1_5DungeonEnum.ExploreTaskId

	gohelper.setActive(self._goexploretask, isShow)

	if not isShow then
		self:recordPosition()

		return
	end

	self.animator:Play("open", 0, 0)
	self:setPosition()
	self:refreshUI()
end

function VersionActivity1_5ExploreTaskView:refreshUI()
	self.finishCount = self:getFinishCount()

	self:refreshMap()
	self:refreshLeftDown()
end

function VersionActivity1_5ExploreTaskView:getFinishCount()
	local finishCount = 0

	for _, taskCo in ipairs(VersionActivity1_5DungeonConfig.instance:getExploreTaskList()) do
		if self:checkExploreTaskFinish(taskCo) then
			finishCount = finishCount + 1
		end
	end

	return finishCount
end

function VersionActivity1_5ExploreTaskView:checkExploreTaskFinish(taskCo)
	if #taskCo.elementList == 0 then
		return
	end

	for _, elementId in ipairs(taskCo.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(elementId) then
			return false
		end
	end

	return true
end

function VersionActivity1_5ExploreTaskView:refreshMap()
	self:refreshLines()

	for _, taskItem in ipairs(self.taskItemList) do
		self:refreshItem(taskItem)
	end

	if #self.needRefreshTimeTaskItemList > 0 then
		TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
	end
end

function VersionActivity1_5ExploreTaskView:refreshLines()
	for _, taskCo in ipairs(VersionActivity1_5DungeonConfig.instance:getExploreTaskList()) do
		self:refreshLineByTaskCo(taskCo)
	end
end

function VersionActivity1_5ExploreTaskView:refreshLineByTaskCo(taskCo)
	if taskCo.type ~= VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch then
		return
	end

	local elementId = taskCo.elementList[1]
	local dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(elementId)
	local isShowLine = dispatchMo and dispatchMo:isFinish()
	local lineNumberList = string.splitToNumber(taskCo.unlockLineNumbers, "#")

	for _, lineNumber in ipairs(lineNumberList) do
		local lineImage = self.lineImageList[lineNumber]

		if lineImage then
			ZProj.UGUIHelper.SetColorAlpha(lineImage, isShowLine and 1 or 0.6)
		else
			logError("not found line image : " .. lineNumber)
		end
	end
end

function VersionActivity1_5ExploreTaskView:refreshItem(taskItem)
	local taskCo = taskItem.taskCo
	local status = VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(taskCo)

	self:refreshTaskItemImage(taskItem)
	self:refreshLockTip(taskItem, status)
	self:refreshTimeTip(taskItem, status)
	self:refreshStar(taskItem, status)
end

function VersionActivity1_5ExploreTaskView:refreshTaskItemImage(taskItem)
	local taskCo = taskItem.taskCo
	local isUnlock = VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskUnlock(taskCo)
	local isFightTask = taskCo.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Fight
	local isDispatchTask = taskCo.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch
	local alpha = isUnlock and 1 or 0.55

	ZProj.UGUIHelper.SetColorAlpha(taskItem.goFightImage, alpha)
	ZProj.UGUIHelper.SetColorAlpha(taskItem.goDispatchImage, alpha)

	if not isUnlock then
		gohelper.setActive(taskItem.goFight, isFightTask)
		gohelper.setActive(taskItem.goDispatch, isDispatchTask)
		gohelper.setActive(taskItem.goFinish, false)
		gohelper.setActive(taskItem.goReward, false)

		return
	end

	if VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskRunning(taskCo) then
		gohelper.setActive(taskItem.goFight, false)
		gohelper.setActive(taskItem.goDispatch, true)
		gohelper.setActive(taskItem.goFinish, false)
		gohelper.setActive(taskItem.goReward, false)

		return
	end

	if VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskGainedReward(taskCo) then
		gohelper.setActive(taskItem.goFight, false)
		gohelper.setActive(taskItem.goDispatch, false)
		gohelper.setActive(taskItem.goFinish, true)
		gohelper.setActive(taskItem.goReward, false)

		return
	end

	for index, elementId in ipairs(taskCo.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(elementId) then
			if isDispatchTask and index == 1 then
				local dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(elementId)

				if dispatchMo and dispatchMo:isFinish() then
					gohelper.setActive(taskItem.goFight, false)
					gohelper.setActive(taskItem.goFinish, true)
					gohelper.setActive(taskItem.goDispatch, true)
					gohelper.setActive(taskItem.goReward, true)
				else
					gohelper.setActive(taskItem.goFight, false)
					gohelper.setActive(taskItem.goFinish, false)
					gohelper.setActive(taskItem.goReward, false)
					gohelper.setActive(taskItem.goDispatch, true)
				end

				return
			else
				local elementCo = lua_chapter_map_element.configDict[elementId]

				if elementCo.type == DungeonEnum.ElementType.Fight then
					local episodeId = tonumber(elementCo.param)

					if DungeonModel.instance:hasPassLevel(episodeId) then
						gohelper.setActive(taskItem.goFight, true)
						gohelper.setActive(taskItem.goFinish, true)
						gohelper.setActive(taskItem.goReward, true)
						gohelper.setActive(taskItem.goDispatch, false)
					else
						gohelper.setActive(taskItem.goFight, true)
						gohelper.setActive(taskItem.goFinish, false)
						gohelper.setActive(taskItem.goReward, false)
						gohelper.setActive(taskItem.goDispatch, false)
					end
				else
					local isFinish = false

					if elementCo.type == DungeonEnum.ElementType.EnterDialogue then
						local dialogueId = tonumber(elementCo.param)

						isFinish = DialogueModel.instance:isFinishDialogue(dialogueId)
					end

					if isFinish then
						gohelper.setActive(taskItem.goFight, false)
						gohelper.setActive(taskItem.goFinish, true)
						gohelper.setActive(taskItem.goDispatch, true)
						gohelper.setActive(taskItem.goReward, true)
					else
						gohelper.setActive(taskItem.goFight, false)
						gohelper.setActive(taskItem.goFinish, false)
						gohelper.setActive(taskItem.goReward, false)
						gohelper.setActive(taskItem.goDispatch, true)
					end
				end
			end
		end
	end
end

function VersionActivity1_5ExploreTaskView:refreshLockTip(taskItem, status)
	local taskCo = taskItem.taskCo

	if string.nilorempty(taskCo.unlockDesc) then
		gohelper.setActive(taskItem.goLockTips, false)

		return
	end

	status = status or VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(taskCo)

	local isLock = status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Lock

	if isLock then
		if taskCo.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishElementAndEpisode then
			local paramList = string.splitToNumber(taskCo.unlockParam, "#")
			local elementId = paramList[1]
			local episodeId = paramList[2]

			isLock = DungeonMapModel.instance:elementIsFinished(elementId) and not DungeonModel.instance:hasPassLevel(episodeId)
		elseif taskCo.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishEpisodeAndAnyOneElement then
			local paramList = string.split(taskCo.unlockParam, "#")
			local elementIdList = string.splitToNumber(paramList[2], "|")
			local episodeId = paramList[1]

			isLock = VersionActivity1_5RevivalTaskModel.instance:_checkFinishAnyOneElement(elementIdList) and not DungeonModel.instance:hasPassLevel(episodeId)
		else
			isLock = false
		end
	end

	gohelper.setActive(taskItem.goLockTips, isLock)

	if isLock then
		taskItem.txtLockTips.text = taskCo.unlockDesc
	end
end

function VersionActivity1_5ExploreTaskView:refreshTimeTip(taskItem, status)
	local taskCo = taskItem.taskCo

	status = status or VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(taskCo)

	local isRunning = status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Running

	gohelper.setActive(taskItem.goTimeTips, isRunning)

	if isRunning then
		local elementId = taskCo.elementList[1]
		local dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(elementId)

		if dispatchMo then
			taskItem.txtTimeTips.text = dispatchMo:getRemainTimeStr()

			table.insert(self.needRefreshTimeTaskItemList, taskItem)
		else
			gohelper.setActive(taskItem.goTimeTips, false)
			logError("没拿到对应的派遣信息, elementId : " .. tostring(elementId))
		end
	end
end

function VersionActivity1_5ExploreTaskView:refreshStar(taskItem, status)
	local taskCo = taskItem.taskCo
	local isDispatchTask = taskCo.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch

	gohelper.setActive(taskItem.goProgressPoint, isDispatchTask)

	if not isDispatchTask then
		return
	end

	status = status or VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(taskCo)

	if status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Lock then
		gohelper.setActive(taskItem.goProgressPoint, false)

		return
	end

	gohelper.setActive(taskItem.goProgressPoint, true)

	local elementIdList = taskCo.elementList
	local elementId = elementIdList[1]
	local dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(elementId)
	local pointItem = self:getPointItem(taskItem, elementId)

	if not dispatchMo then
		gohelper.setActive(pointItem.goRunning, false)
		gohelper.setActive(pointItem.goFinish, false)
	elseif dispatchMo:isRunning() then
		gohelper.setActive(pointItem.goRunning, true)
		gohelper.setActive(pointItem.goFinish, false)
	elseif dispatchMo:isFinish() then
		gohelper.setActive(pointItem.goRunning, false)
		gohelper.setActive(pointItem.goFinish, true)
	end

	for i = 2, #elementIdList do
		elementId = elementIdList[i]
		pointItem = self:getPointItem(taskItem, elementIdList[i])

		if DungeonMapModel.instance:elementIsFinished(elementIdList[i]) then
			gohelper.setActive(pointItem.goRunning, false)
			gohelper.setActive(pointItem.goFinish, true)
		else
			gohelper.setActive(pointItem.goRunning, false)
			gohelper.setActive(pointItem.goFinish, false)
		end
	end
end

function VersionActivity1_5ExploreTaskView:getPointItem(taskItem, elementId)
	local pointItem = taskItem.pointDict[elementId]

	if pointItem then
		return pointItem
	end

	pointItem = self:getUserDataTb_()
	pointItem.go = gohelper.cloneInPlace(taskItem.goProgressPointItem, elementId)

	gohelper.setActive(pointItem.go, true)

	pointItem.goRunning = gohelper.findChild(pointItem.go, "running")
	pointItem.goFinish = gohelper.findChild(pointItem.go, "finish")
	taskItem.pointDict[elementId] = pointItem

	return pointItem
end

function VersionActivity1_5ExploreTaskView:refreshLeftDown()
	self:refreshSlider()
	self:refreshReward()
end

function VersionActivity1_5ExploreTaskView:refreshSlider()
	self._txtnum.text = self.finishCount
	self._txttotal.text = self.totalCount

	self._sliderprogress:SetValue(self.finishCount / self.totalCount)
end

function VersionActivity1_5ExploreTaskView:refreshReward()
	if VersionActivity1_5RevivalTaskModel.instance:checkExploreTaskGainedTotalReward() then
		gohelper.setActive(self._gohasget, true)
		gohelper.setActive(self._gogainreward, false)

		return
	end

	gohelper.setActive(self._gohasget, false)
	gohelper.setActive(self._gogainreward, self.finishCount >= self.totalCount)
end

function VersionActivity1_5ExploreTaskView:onGainedExploreReward()
	self:refreshReward()
end

function VersionActivity1_5ExploreTaskView:everySecondCall()
	for index = #self.needRefreshTimeTaskItemList, 1, -1 do
		local taskItem = self.needRefreshTimeTaskItemList[index]
		local taskCo = taskItem.taskCo
		local elementId = taskCo.elementList[1]
		local dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(elementId)

		if dispatchMo then
			if dispatchMo:isFinish() then
				table.remove(self.needRefreshTimeTaskItemList, index)
				self:refreshItem(taskItem)
				self:refreshLineByTaskCo(taskItem.taskCo)
			else
				taskItem.txtTimeTips.text = dispatchMo:getRemainTimeStr()
			end
		else
			table.remove(self.needRefreshTimeTaskItemList, index)
			self:refreshItem(taskItem)
		end
	end

	if #self.needRefreshTimeTaskItemList == 0 then
		TaskDispatcher.cancelTask(self.everySecondCall, self)
	end
end

function VersionActivity1_5ExploreTaskView:setPosition()
	if not self.lastRecordPos then
		local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_5RevivalTaskHorizontalPos)

		self.lastRecordPos = PlayerPrefsHelper.getNumber(key, 0)
	end

	self._scrollMap.horizontalNormalizedPosition = self.lastRecordPos
end

function VersionActivity1_5ExploreTaskView:recordPosition()
	self.lastRecordPos = self._scrollMap.horizontalNormalizedPosition

	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_5RevivalTaskHorizontalPos)

	PlayerPrefsHelper.setNumber(key, self.lastRecordPos)
end

function VersionActivity1_5ExploreTaskView:onClose()
	self:recordPosition()
end

function VersionActivity1_5ExploreTaskView:onDestroyView()
	self.rewardClick:RemoveClickListener()

	for _, taskItem in ipairs(self.taskItemList) do
		taskItem.click:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

return VersionActivity1_5ExploreTaskView
