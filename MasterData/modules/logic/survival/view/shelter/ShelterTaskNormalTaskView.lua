-- chunkname: @modules/logic/survival/view/shelter/ShelterTaskNormalTaskView.lua

module("modules.logic.survival.view.shelter.ShelterTaskNormalTaskView", package.seeall)

local ShelterTaskNormalTaskView = class("ShelterTaskNormalTaskView", BaseView)

function ShelterTaskNormalTaskView:onInitView()
	self.rewardItemGO = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_main/#go_rewarditem")
	self.goNormal = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_normal")
	self.itemList = {}
	self.taskType = SurvivalEnum.TaskModule.NormalTask
	self.itemGO = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_normal/#go_normalitem")

	gohelper.setActive(self.itemGO, false)
end

function ShelterTaskNormalTaskView:addEvents()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, self.refreshView, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnFollowTaskUpdate, self.refreshTask, self)
end

function ShelterTaskNormalTaskView:removeEvents()
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, self.refreshView, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnFollowTaskUpdate, self.refreshTask, self)
end

function ShelterTaskNormalTaskView:onOpen()
	return
end

function ShelterTaskNormalTaskView:refreshView(taskType)
	local isShow = taskType == self.taskType or taskType == SurvivalEnum.TaskModule.MapMainTarget

	self:setTaskVisible(isShow)
end

function ShelterTaskNormalTaskView:setTaskVisible(isVisible)
	if self._isVisible == isVisible then
		if isVisible then
			self:refreshTask()
		end

		return
	end

	self._isVisible = isVisible

	if isVisible then
		self:refreshTask()

		self.animComp = self.animComp or MonoHelper.addNoUpdateLuaComOnceToGo(self.goNormal, SurvivalItemListAnimComp)

		self.animComp:playListOpenAnim(self.itemList, 0.06)
	else
		gohelper.setActive(self.goNormal, false)
	end
end

function ShelterTaskNormalTaskView:refreshTask()
	local list = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.NormalTask)
	local list2 = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.MapMainTarget)
	local taskCount = #list + #list2

	for i = 1, math.max(taskCount, #self.itemList) do
		local var_7_0 = self:getItem(i)

		self:updateItem(item, list[i] or list2[i - #list])
	end

	gohelper.setActive(self.goNormal, taskCount > 0)
end

function ShelterTaskNormalTaskView:getItem(index)
	local item = self.itemList[index]

	if not item then
		item = self:createItem(index, self.goNormal)
		self.itemList[index] = item
	end

	return item
end

function ShelterTaskNormalTaskView:createItem(index, parentGO)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.clone(self.itemGO, parentGO, tostring(index))
	item.goFinished = gohelper.findChild(item.go, "finished")
	item.txtDesc = gohelper.findChildTextMesh(item.go, "scroll_desc/viewport/#txt_desc")
	item.txtTitle = gohelper.findChildTextMesh(item.go, "#txt_title")
	item.simageHero = gohelper.findChildSingleImage(item.go, "role/#simage_hero")
	item.goItem = gohelper.findChild(item.go, "#scroll_Reward/Viewport/Content")
	item.btnSelect = gohelper.findChildButtonWithAudio(item.go, "#btn_select")
	item.goSelect = gohelper.findChild(item.go, "#go_select")
	item.anim = item.go:GetComponent(gohelper.Type_Animator)
	item.rewardList = {}

	return item
end

function ShelterTaskNormalTaskView:updateItem(item, taskMo)
	gohelper.setActive(item.go, taskMo ~= nil)

	if not taskMo then
		return
	end

	local isFinish = not taskMo:isUnFinish()

	gohelper.setActive(item.goFinished, isFinish)

	item.txtTitle.text = taskMo:getName()
	item.txtDesc.text = taskMo:getDesc()

	item.simageHero:LoadImage(ResUrl.getSurvivalNpcIcon(taskMo.co.icon))
	self:removeClickCb(item.btnSelect)
	self.addClickCb(self, item.btnSelect, self.onClickSelect, self, taskMo)
	gohelper.setActive(item.goSelect, self:isFollowTask(taskMo))
	self:refreshItemReward(item, taskMo.co, item.goItem)
end

function ShelterTaskNormalTaskView:refreshItemReward(item, co, parentGO)
	local rewardList = GameUtil.splitString2(co.dropShow, true, "&", ":")

	if rewardList then
		if not #rewardList then
			local rewardCount = 0

			for i = 1, math.max(rewardCount, #item.rewardList) do
				local rewardItem = self:getRewardItem(item, i, parentGO)

				self:refreshRewardItem(rewardItem, rewardList[i])
			end
		end
	end
end

function ShelterTaskNormalTaskView:refreshRewardItem(rewardItem, rewardData)
	gohelper.setActive(rewardItem.go, rewardData ~= nil)

	if not rewardData then
		return
	end

	local rewardId = rewardData[1]
	local rewardNum = rewardData[2]

	gohelper.setActive(rewardItem.goCanget, false)
	gohelper.setActive(rewardItem.goReceive, false)

	if not rewardItem.itemIcon then
		local iconGO = self:getIconInstance(rewardItem.goIcon)

		rewardItem.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(iconGO, SurvivalBagItem)

		rewardItem.itemIcon:setClickCallback(self.onClicRewardItem, self)
	end

	rewardItem.itemIcon._rewardItem = rewardItem

	rewardItem.itemIcon:updateByItemId(rewardId, rewardNum)
	rewardItem.itemIcon:setItemSize(137.6, 137.6)
end

function ShelterTaskNormalTaskView:onClicRewardItem(itemIcon)
	ViewMgr.instance:openView(ViewName.SurvivalItemInfoView, {
		itemMo = itemIcon._mo
	})
end

function ShelterTaskNormalTaskView:getIconInstance(parentGO)
	local resPath = self.viewContainer:getSetting().otherRes.itemRes

	return self.viewContainer:getResInst(resPath, parentGO, "itemIcon")
end

function ShelterTaskNormalTaskView:getRewardItem(item, index, parentGO)
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

function ShelterTaskNormalTaskView:onClickSelect(taskMo)
	if not taskMo:isUnFinish() then
		return
	end

	if taskMo.moduleId == SurvivalEnum.TaskModule.MapMainTarget then
		return
	end

	SurvivalInteriorRpc.instance:sendSurvivalTaskFollowRequest(taskMo.moduleId, taskMo.id, not self:isFollowTask(taskMo))
end

function ShelterTaskNormalTaskView:isFollowTask(taskMo)
	if taskMo.moduleId == SurvivalEnum.TaskModule.MapMainTarget then
		return true
	end

	local weekMo = SurvivalShelterModel.instance:getWeekInfo()
	local isFollowTask = false

	if weekMo.inSurvival then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()

		isFollowTask = sceneMo.followTask.taskId == taskMo.co.id
	end

	return isFollowTask
end

function ShelterTaskNormalTaskView:onClose()
	for k, v in pairs(self.itemList) do
		v.simageHero:UnLoadImage()
	end
end

return ShelterTaskNormalTaskView
