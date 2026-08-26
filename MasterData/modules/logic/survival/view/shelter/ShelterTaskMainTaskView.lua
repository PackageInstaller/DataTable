-- chunkname: @modules/logic/survival/view/shelter/ShelterTaskMainTaskView.lua

module("modules.logic.survival.view.shelter.ShelterTaskMainTaskView", package.seeall)

local ShelterTaskMainTaskView = class("ShelterTaskMainTaskView", BaseView)

function ShelterTaskMainTaskView:onInitView()
	self.mainGO = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_main")
	self.itemGO = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_main/#go_mainitem")
	self.rewardItemGO = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_main/#go_rewarditem")

	gohelper.setActive(self.itemGO, false)
	gohelper.setActive(self.rewardItemGO, false)

	self.mainItemList = {}
	self.subItemList = {}
	self.taskType = SurvivalEnum.TaskModule.MainTask
	self.subGO = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_sub")
	self.collectionGO = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_collection")
	self.txtCollection = gohelper.findChildTextMesh(self.collectionGO, "#txt_collection")
	self.simageCollection = gohelper.findChildSingleImage(self.collectionGO, "layout/collection")
	self.txtChoice = gohelper.findChildTextMesh(self.collectionGO, "layout/#txt_choice")
	self.txtBase = gohelper.findChildTextMesh(self.collectionGO, "#txt_base")
end

function ShelterTaskMainTaskView:addEvents()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, self.refreshView, self)
end

function ShelterTaskMainTaskView:removeEvents()
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, self.refreshView, self)
end

function ShelterTaskMainTaskView:onOpen()
	return
end

function ShelterTaskMainTaskView:refreshView(taskType)
	local isShow = taskType == self.taskType

	self:setTaskVisible(isShow)
end

function ShelterTaskMainTaskView:setTaskVisible(isVisible)
	if self._isVisible == isVisible then
		if isVisible then
			self:refreshMainTask()
			self:refreshSubTask()
			self:refreshTalent()
		end

		return
	end

	self._isVisible = isVisible

	gohelper.setActive(self.mainGO, false)
	gohelper.setActive(self.subGO, false)
	gohelper.setActive(self.collectionGO, false)

	if isVisible then
		if not self.popupFlow then
			self.popupFlow = FlowSequence.New()

			local time = 0.06
			local param1 = {
				time = time,
				callback = self.refreshMainTask,
				callbackObj = self
			}

			self.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(param1))

			local param2 = {
				time = time,
				callback = self.refreshSubTask,
				callbackObj = self
			}

			self.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(param2))

			local param3 = {
				time = time,
				callback = self.refreshTalent,
				callbackObj = self
			}

			self.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(param3))
		end

		self.popupFlow:start()
	elseif self.popupFlow then
		self.popupFlow:stop()
	end
end

function ShelterTaskMainTaskView:refreshMainTask()
	local list = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.MainTask)
	local taskCount = #list

	for i = 1, math.max(taskCount, #self.mainItemList) do
		local item = self:getMainItem(i)

		self:updateItem(item, list[i])
	end

	gohelper.setActive(self.mainGO, taskCount > 0)
end

function ShelterTaskMainTaskView:refreshSubTask()
	local list = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.SubTask)
	local taskCount = #list

	for i = 1, math.max(taskCount, #self.subItemList) do
		local item = self:getSubItem(i)

		self:updateItem(item, list[i])
	end

	gohelper.setActive(self.subGO, taskCount > 0)
end

function ShelterTaskMainTaskView:getMainItem(index)
	local item = self.mainItemList[index]

	if not item then
		item = self:createItem(index, self.mainGO)
		self.mainItemList[index] = item
	end

	return item
end

function ShelterTaskMainTaskView:getSubItem(index)
	local item = self.subItemList[index]

	if not item then
		item = self:createItem(index, self.subGO)
		self.subItemList[index] = item
	end

	return item
end

function ShelterTaskMainTaskView:createItem(index, parentGO)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.clone(self.itemGO, parentGO, tostring(index))
	item.goFinishing = gohelper.findChild(item.go, "finishing")
	item.goFinishingBg = gohelper.findChild(item.goFinishing, "bg")
	item.txtFinishingDesc = gohelper.findChildTextMesh(item.goFinishing, "#txt_task")
	item.goFinishingRewardContent = gohelper.findChild(item.goFinishing, "#scroll_Reward/Viewport/Content")
	item.goFinished = gohelper.findChild(item.go, "finished")
	item.txtFinishedNum = gohelper.findChildTextMesh(item.goFinished, "#txt_num")
	item.txtFinishedDesc = gohelper.findChildTextMesh(item.goFinished, "#txt_task")
	item.goFinishedRewardContent = gohelper.findChild(item.goFinished, "#scroll_Reward/Viewport/Content")
	item.goUnfinish = gohelper.findChild(item.go, "unfinish")
	item.goUnfinishBg = gohelper.findChild(item.goUnfinish, "bg")
	item.txtUnFinishNum = gohelper.findChildTextMesh(item.goUnfinish, "#txt_num")
	item.txtUnFinishDesc = gohelper.findChildTextMesh(item.goUnfinish, "#txt_task")
	item.goUnfinishRewardContent = gohelper.findChild(item.goUnfinish, "#scroll_Reward/Viewport/Content")
	item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))
	item.rewardList = {}

	return item
end

function ShelterTaskMainTaskView:getRewardItem(item, index, parentGO)
	local rewardItem = item.rewardList[index]

	if not rewardItem then
		rewardItem = self:getUserDataTb_()
		rewardItem.go = gohelper.clone(self.rewardItemGO, parentGO, tostring(index))
		rewardItem.goIcon = gohelper.findChild(rewardItem.go, "go_icon")
		rewardItem.goCanget = gohelper.findChild(rewardItem.go, "go_canget")
		rewardItem.goReceive = gohelper.findChild(rewardItem.go, "go_receive")
		item.rewardList[index] = rewardItem
	else
		gohelper.addChild(parentGO, rewardItem.go)
	end

	rewardItem.parentItem = item

	return rewardItem
end

function ShelterTaskMainTaskView:updateItem(item, taskMo)
	item.taskMo = taskMo

	gohelper.setActive(item.go, taskMo ~= nil)

	if not taskMo then
		return
	end

	local playFinishTask = self.playRewardTaskId == taskMo.id

	if playFinishTask then
		self.playRewardTaskId = nil

		self:playItemFinishAnim(item)

		return
	end

	local isMainTask = taskMo.moduleId == SurvivalEnum.TaskModule.MainTask
	local isFinish = taskMo:isFinish()

	if isMainTask then
		isFinish = not taskMo:isUnFinish()
	end

	gohelper.setActive(item.goFinished, isFinish)
	gohelper.setActive(item.goFinishing, isMainTask and not isFinish)
	gohelper.setActive(item.goUnfinish, not isMainTask and not isFinish)

	local rewardParentGO

	if isFinish then
		item.txtFinishedNum.text = tostring(item.index)
		item.txtFinishedDesc.text = taskMo:getDesc()
		rewardParentGO = item.goFinishedRewardContent
	elseif isMainTask then
		gohelper.setActive(item.goFinishingBg, item.index == 1)

		item.txtFinishingDesc.text = taskMo:getDesc()
		rewardParentGO = item.goFinishingRewardContent
	else
		gohelper.setActive(item.goUnfinishBg, item.index == 1)

		item.txtUnFinishNum.text = tostring(item.index)
		item.txtUnFinishDesc.text = taskMo:getDesc()
		rewardParentGO = item.goUnfinishRewardContent
	end

	self:refreshItemReward(item, taskMo.co, rewardParentGO, taskMo.status)
end

function ShelterTaskMainTaskView:refreshItemReward(item, co, parentGO, status)
	local rewardList = GameUtil.splitString2(co.dropShow, true, "&", ":")

	if rewardList then
		if not #rewardList then
			local rewardCount = 0

			for i = 1, math.max(rewardCount, #item.rewardList) do
				local rewardItem = self:getRewardItem(item, i, parentGO)

				self:refreshRewardItem(rewardItem, rewardList[i], status)
			end
		end
	end
end

function ShelterTaskMainTaskView:refreshRewardItem(rewardItem, rewardData, status)
	gohelper.setActive(rewardItem.go, rewardData ~= nil)

	if not rewardData then
		return
	end

	local rewardId = rewardData[1]
	local rewardNum = rewardData[2]

	gohelper.setActive(rewardItem.goCanget, status == SurvivalEnum.TaskStatus.Done)
	gohelper.setActive(rewardItem.goReceive, status == SurvivalEnum.TaskStatus.Finish)

	if not rewardItem.itemIcon then
		local iconGO = self:getIconInstance(rewardItem.goIcon)

		rewardItem.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(iconGO, SurvivalBagItem)

		rewardItem.itemIcon:setClickCallback(self.onClicRewardItem, self)
	end

	rewardItem.itemIcon._rewardItem = rewardItem

	rewardItem.itemIcon:updateByItemId(rewardId, rewardNum)
	rewardItem.itemIcon:setItemSize(100, 100)
end

function ShelterTaskMainTaskView:getIconInstance(parentGO)
	local resPath = self.viewContainer:getSetting().otherRes.itemRes

	return self.viewContainer:getResInst(resPath, parentGO, "itemIcon")
end

function ShelterTaskMainTaskView:refreshTalent()
	gohelper.setActive(self.collectionGO, false)
end

function ShelterTaskMainTaskView:onClicRewardItem(itemIcon)
	local rewardItem = itemIcon._rewardItem

	if not rewardItem then
		return
	end

	local parentItem = rewardItem.parentItem

	if not parentItem then
		return
	end

	local taskMo = parentItem.taskMo

	if not taskMo then
		return
	end

	if taskMo:isCangetReward() then
		PopupController.instance:setPause(self.viewName, true)

		self.playRewardTaskId = taskMo.id

		SurvivalWeekRpc.instance:sendSurvivalReceiveTaskRewardRequest(taskMo.moduleId, taskMo.id)
	else
		ViewMgr.instance:openView(ViewName.SurvivalItemInfoView, {
			itemMo = itemIcon._mo
		})
	end
end

function ShelterTaskMainTaskView:refreshAnimItem()
	if self._animItem then
		self:updateItem(self._animItem, self._animItem.taskMo)

		self._animItem = nil
	end

	PopupController.instance:setPause(self.viewName, false)
end

function ShelterTaskMainTaskView:playItemFinishAnim(item)
	item.anim:Play("finished", 0, 0)

	self._animItem = item

	TaskDispatcher.runDelay(self.refreshAnimItem, self, 0.5)
end

function ShelterTaskMainTaskView:onClose()
	PopupController.instance:setPause(self.viewName, false)
	TaskDispatcher.cancelTask(self.refreshAnimItem, self)
	self.simageCollection:UnLoadImage()

	if self.popupFlow then
		self.popupFlow:destroy()

		self.popupFlow = nil
	end
end

return ShelterTaskMainTaskView
