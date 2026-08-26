-- chunkname: @modules/logic/room/view/RoomViewSceneTask.lua

module("modules.logic.room.view.RoomViewSceneTask", package.seeall)

local RoomViewSceneTask = class("RoomViewSceneTask", BaseView)

function RoomViewSceneTask:onInitView()
	self._gocontainer = gohelper.findChild(self.viewGO, "go_normalroot/go_taskpanel/go_detail/go_taskContent")
	self._gopanel = gohelper.findChild(self.viewGO, "go_normalroot/go_taskpanel")
	self._btnexpand = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/go_taskpanel/btn_expand")
	self._btnfold = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/go_taskpanel/btn_fold")
	self._gosimple = gohelper.findChild(self.viewGO, "go_normalroot/go_taskpanel/go_simple")
	self._godetail = gohelper.findChild(self.viewGO, "go_normalroot/go_taskpanel/go_detail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewSceneTask:addEvents()
	self._btnexpand:AddClickListener(self.onClickExpand, self)
	self._btnfold:AddClickListener(self.onClickExpand, self)
end

function RoomViewSceneTask:removeEvents()
	self._btnexpand:RemoveClickListener()
	self._btnfold:RemoveClickListener()
end

RoomViewSceneTask.AutoHideTime = 3
RoomViewSceneTask.DelayHideToShowTime = 1.5

function RoomViewSceneTask:_editableInitView()
	self._animatorpanel = self._gopanel:GetComponent(typeof(UnityEngine.Animator))
	self._rectpanel = self._gopanel.transform
	self._taskItems = {}
	self._needPlayAnimShow = false
	self._isBreakAutoHide = false
	self._isForceHideArrow = false
	self._firstEnterRefresh = true

	gohelper.setActive(self._gocontainer, true)
	gohelper.setActive(self._godetail, true)
	gohelper.setActive(self._btnfold, false)
end

function RoomViewSceneTask:onDestroyView()
	if self._taskItems then
		for _, itemObj in pairs(self._taskItems) do
			itemObj.btnnormal:RemoveClickListener()
			gohelper.setActive(itemObj.gotask, true)
		end

		self._taskItems = nil
	end
end

function RoomViewSceneTask:onOpen()
	self.addEventCb(self, RoomSceneTaskController.instance, RoomEvent.TaskUpdate, self.refreshUI, self)
	self.addEventCb(self, RoomSceneTaskController.instance, RoomEvent.TaskCanFinish, self.playCanGetRewardVfx, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientPlaceBlock, self.refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientCancelBlock, self.refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientTryBackBlock, self.refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientCancelBackBlock, self.refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TransportPathViewShowChanged, self.refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.GuideShowSceneTask, self._guideShowSceneTask, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BackBlockShowChanged, self.refreshUI, self)
	self.addEventCb(self, RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, self.refreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.handleOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.handleCloseView, self)
	self.addEventCb(self, RoomSceneTaskController.instance, RoomEvent.TaskShowHideAnim, self.handleTaskHideAnim, self)

	self._taskAnimIds = {}
	self._taskAnimIdMap = {}

	RoomSceneTaskController.instance:init()
	RoomSceneTaskController.instance:setTaskCheckFinishFlag(true)

	self._isExpand = true

	self:refreshUI()
end

function RoomViewSceneTask:onClose()
	self:disposeAllAnim()

	if self:isAnimPlaying() then
		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock(UIBlockKey.RoomTaskFinish)
	end

	RoomSceneTaskController.instance:release()
	TaskDispatcher.cancelTask(self.onDelayObAutoHide, self)
	TaskDispatcher.cancelTask(self.startPlayTaskFinish, self)
end

function RoomViewSceneTask:enterObAutoHide()
	self:_stopAutoHideTask()

	if RoomController.instance:isObMode() then
		self._isBreakAutoHide = false
		self._isHasAutoHideTaskRun = true

		TaskDispatcher.runDelay(self.onDelayObAutoHide, self, RoomViewSceneTask.AutoHideTime)
	end
end

function RoomViewSceneTask:_stopAutoHideTask()
	if self._isHasAutoHideTaskRun then
		TaskDispatcher.cancelTask(self.onDelayObAutoHide, self)

		self._isHasAutoHideTaskRun = false
	end
end

function RoomViewSceneTask:onDelayObAutoHide()
	self:_stopAutoHideTask()

	if not self._isBreakAutoHide then
		self:_showHidAnim(true)

		self._isBreakAutoHide = false
	end
end

function RoomViewSceneTask:_showHidAnim(isHide)
	if isHide then
		self._isBreakAutoHide = true

		self:_stopAutoHideTask()
	end

	local tempHide = isHide == true

	if self._lastAnimHide ~= tempHide then
		local animName = tempHide and "close" or UIAnimationName.Open

		self._lastAnimHide = tempHide

		self._animatorpanel:Play(animName)
	end

	self._isExpand = not isHide

	self:refreshExpand()
end

function RoomViewSceneTask:_guideShowSceneTask()
	self._isExpand = true

	self:refreshExpand()
end

function RoomViewSceneTask:onClickExpand()
	self:_showHidAnim(self._isExpand)
	self:enterObAutoHide()
end

function RoomViewSceneTask.onClickNormalOpen(param)
	local self = param.self

	if self:isAnimPlaying() then
		return
	end

	if not self._isExpand then
		self:onClickExpand()

		return
	end

	if not RoomSceneTaskController.instance:checkTaskFinished() then
		ViewMgr.instance:openView(ViewName.RoomSceneTaskDetailView)
	end
end

function RoomViewSceneTask:refreshUI()
	if self:isAnimPlaying() then
		return
	end

	local list = RoomTaskModel.instance:getShowList()

	if #list > 0 then
		if self._firstEnterRefresh then
			self._firstEnterRefresh = false

			self:enterObAutoHide()
		end

		self:refreshExpand()
		self:refreshItems()
	end

	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()
	local isBackMore = RoomMapBlockModel.instance:isBackMore()

	gohelper.setActive(self._gopanel, (RoomController.instance:isEditMode() and (isBackMore or isWaterReform or ViewMgr.instance:isOpen(ViewName.RoomTransportPathView)) or nil) and false)
end

function RoomViewSceneTask:refreshExpand()
	if self._isForceHideArrow then
		gohelper.setActive(self._btnexpand, false)
	else
		gohelper.setActive(self._btnexpand, not self._isExpand)
	end
end

function RoomViewSceneTask:refreshItems()
	local list = RoomTaskModel.instance:getShowList()
	local index = 1
	local item = self:getOrCreateItem(index)
	local mo = RoomTaskModel.instance:tryGetTaskMO(list[1].id)

	self:refreshItemWithTask(item, mo, list[1])
end

function RoomViewSceneTask:refreshItemWithTask(itemObj, taskMO, taskCO)
	if self._needPlayAnimShow then
		itemObj.animator:Play(RoomSceneTaskEnum.AnimName.Show, 0, 0)

		self._needPlayAnimShow = false
	end

	gohelper.setActive(itemObj.go, true)
	gohelper.setActive(itemObj.gotask, true)

	if taskMO then
		local hasFinished, progress = RoomSceneTaskController.getProgressStatus(taskMO)

		itemObj.txtdesc.text = hasFinished and string.format("%s(%s/%s)", taskCO.desc, progress, taskCO.maxProgress) or string.format("%s(<color=#ba6662>%s</color>/%s)", taskCO.desc, progress, taskCO.maxProgress)

		gohelper.setActive(itemObj.gohasreward, hasFinished)
	else
		logNormal("No taskMO with taskID : " .. tostring(taskCO.id))

		itemObj.txtdesc.text = taskCO.desc

		gohelper.setActive(itemObj.gohasreward, false)
	end

	if not string.nilorempty(taskCO.bonus) then
		local bonusArr = string.split(taskCO.bonus, "|")

		if #bonusArr > 0 then
			bonusArr = string.splitToNumber(bonusArr[1], "#")

			itemObj.iconComp:setMOValue(bonusArr[1], bonusArr[2], bonusArr[3])
			itemObj.iconComp:isShowEquipAndItemCount(false)
			gohelper.setActive(itemObj.countbg, true)
			gohelper.setAsLastSibling(itemObj.countbg)

			itemObj.count.text = tostring(GameUtil.numberDisplay(bonusArr[3]))
		end
	end
end

function RoomViewSceneTask:playCanGetRewardVfx(taskIds)
	self._isBreakAutoHide = true

	if RoomMapModel.instance:isRoomLeveling() or ViewMgr.instance:isOpen(ViewName.RoomLevelUpTipsView) then
		return
	end

	logNormal("notify playCanGetRewardVfx")
	self:appendToAnimPipeline(taskIds)
end

function RoomViewSceneTask:appendToAnimPipeline(taskIds)
	local originCount = #self._taskAnimIds
	local count = originCount
	local taskIdSet = {}

	for _, taskId in pairs(taskIds) do
		taskIdSet[taskId] = true

		if not self._taskAnimIdMap[taskId] then
			local mo = RoomTaskModel.instance:tryGetTaskMO(taskId)

			if mo then
				local isFirst = count == 0
				local param = {
					self = self,
					taskCo = mo.config,
					taskMo = mo,
					isFirst = isFirst
				}

				table.insert(self._taskAnimIds, param)

				self._taskAnimIdMap[taskId] = param
				count = count + 1
			end
		end
	end

	for includeId, _ in pairs(self._taskAnimIdMap) do
		if not taskIdSet[includeId] and #self._taskAnimIds > 0 and self._taskAnimIds[1].taskCo.id ~= includeId then
			self:removeAnimParam(includeId, true)
		end
	end

	if originCount == 0 and count ~= 0 then
		self._isAnimPlaying = true

		UIBlockMgr.instance:endAll()
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(UIBlockKey.RoomTaskFinish)
		self:_stopAutoHideTask()
		self:checkIfNodeHidePlay()
	end
end

function RoomViewSceneTask:removeAnimParam(taskId, includeMap)
	if self._taskAnimIdMap[taskId] then
		if includeMap then
			self._taskAnimIdMap[taskId] = nil
		end

		for i, param in ipairs(self._taskAnimIds) do
			if param.taskCo.id == taskId then
				logNormal("delete taskId in array = " .. tostring(taskId))
				table.remove(self._taskAnimIds, i)

				break
			end
		end
	end
end

function RoomViewSceneTask:checkIfNodeHidePlay()
	if self._lastAnimHide then
		self._isBreakAutoHide = true

		self:_showHidAnim(false)
		TaskDispatcher.runDelay(self.startPlayTaskFinish, self, RoomViewSceneTask.DelayHideToShowTime)
	else
		self:startPlayTaskFinish()
	end
end

function RoomViewSceneTask:startPlayTaskFinish()
	local param = self._taskAnimIds[1]
	local itemObj = self:getOrCreateItem(1)
	local isFirst = param.isFirst

	self:disposeAllAnim()
	self:refreshItemWithTask(itemObj, param.taskMo, param.taskCo)

	if not isFirst then
		itemObj.animator:Play(RoomSceneTaskEnum.AnimName.Show, 0, 0)
		itemObj.animatorEvent:AddEventListener(RoomSceneTaskEnum.AnimEventName.ShowFinish, RoomViewSceneTask.onAnimShowFinished, param)
	else
		itemObj.animator:Play(RoomSceneTaskEnum.AnimName.Play, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mission_complete)
		itemObj.animatorEvent:AddEventListener(RoomSceneTaskEnum.AnimEventName.PlayFinish, RoomViewSceneTask.onAnimPlayFinished, param)
	end
end

function RoomViewSceneTask.onAnimShowFinished(param)
	local self = param.self
	local itemObj = self:getOrCreateItem(1)

	itemObj.animatorEvent:AddEventListener(RoomSceneTaskEnum.AnimEventName.PlayFinish, RoomViewSceneTask.onAnimPlayFinished, param)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mission_complete)
	itemObj.animator:Play(RoomSceneTaskEnum.AnimName.Play, 0, 0)
end

function RoomViewSceneTask.onAnimPlayFinished(param)
	local self = param.self
	local taskId = param.taskCo.id

	self:removeAnimParam(taskId)
	self:disposeAllAnim()

	if #self._taskAnimIds > 0 then
		self:startPlayTaskFinish()
	else
		for k, _ in pairs(self._taskAnimIdMap) do
			self._taskAnimIdMap[k] = nil
		end

		self._needPlayAnimShow = true

		local hasFinish, taskIds = RoomSceneTaskController.instance:isFirstTaskFinished()

		if hasFinish then
			RoomSceneTaskController.instance:setTaskCheckFinishFlag(false)
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Room, nil, taskIds, self.onSendAllTaskCompleted, self)
		end

		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock(UIBlockKey.RoomTaskFinish)

		self._isAnimPlaying = false

		self:enterObAutoHide()
		self:refreshUI()
	end
end

function RoomViewSceneTask:disposeAllAnim()
	local itemObj = self:getOrCreateItem(1)

	if not gohelper.isNil(itemObj.animatorEvent) then
		for _, eventName in pairs(RoomSceneTaskEnum.AnimEventName) do
			itemObj.animatorEvent:RemoveEventListener(eventName)
		end
	end
end

function RoomViewSceneTask:isAnimPlaying()
	return self._isAnimPlaying == true
end

function RoomViewSceneTask:onSendAllTaskCompleted(cmd, resultCode)
	RoomSceneTaskController.instance:setTaskCheckFinishFlag(true)
end

function RoomViewSceneTask:handleOpenView(viewName)
	if viewName == ViewName.CommonPropView or viewName == ViewName.RoomLevelUpTipsView then
		RoomSceneTaskController.instance:setTaskCheckFinishFlag(false)
	elseif viewName == ViewName.RoomCharacterPlaceView then
		self:_showHidAnim(true)
	end
end

function RoomViewSceneTask:handleCloseView(viewName)
	if viewName == ViewName.CommonPropView or viewName == ViewName.RoomLevelUpTipsView then
		RoomSceneTaskController.instance:setTaskCheckFinishFlag(true)
		RoomSceneTaskController.instance:checkTaskFinished()
	end
end

function RoomViewSceneTask:getOrCreateItem(index)
	local item = self._taskItems[index]

	if not item then
		item = self:getUserDataTb_()

		local path = self.viewContainer:getSetting().otherRes[4]
		local itemGo = self:getResInst(path, self._gocontainer, "task_item")

		itemGo.name = "task_item" .. index
		item.go = itemGo
		item.txtdesc = gohelper.findChildText(itemGo, "go_task/txt_taskitemdesc")
		item.gotask = gohelper.findChild(itemGo, "go_task")
		item.goicon = gohelper.findChild(itemGo, "go_task/go_icon")
		item.gohasreward = gohelper.findChild(itemGo, "go_task/go_hasreward")
		item.countbg = gohelper.findChild(itemGo, "go_task/go_icon/countbg")
		item.count = gohelper.findChildText(itemGo, "go_task/go_icon/countbg/count")
		item.btnnormal = gohelper.findChildButtonWithAudio(itemGo, "btn_normalclick")

		item.btnnormal:AddClickListener(self.onClickNormalOpen, {
			self = self,
			index = index
		})

		item.iconComp = IconMgr.instance:getCommonPropItemIcon(item.goicon)
		item.animator = itemGo:GetComponent(typeof(UnityEngine.Animator))
		item.animatorEvent = itemGo:GetComponent(typeof(ZProj.AnimationEventWrap))
		self._taskItems[index] = item
	end

	return item
end

function RoomViewSceneTask:handleTaskHideAnim(isHide)
	self._isForceHideArrow = isHide

	self:_showHidAnim(true)
end

return RoomViewSceneTask
