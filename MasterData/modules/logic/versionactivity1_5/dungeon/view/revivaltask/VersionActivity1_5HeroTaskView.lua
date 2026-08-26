-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/revivaltask/VersionActivity1_5HeroTaskView.lua

module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5HeroTaskView", package.seeall)

local VersionActivity1_5HeroTaskView = class("VersionActivity1_5HeroTaskView", BaseView)

function VersionActivity1_5HeroTaskView:onInitView()
	self._goherotask = gohelper.findChild(self.viewGO, "#go_herotask")
	self._simagebookbg = gohelper.findChildSingleImage(self.viewGO, "#go_herotask/#simage_bookbg")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_herotask/Title/#txt_title")
	self._imageheroPhoto = gohelper.findChildImage(self.viewGO, "#go_herotask/#image_heroPhoto")
	self._txtheroDetail = gohelper.findChildText(self.viewGO, "#go_herotask/#image_heroPhoto/#txt_heroDetail")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_herotask/LeftDown/#txt_total")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_herotask/LeftDown/#txt_total/#txt_num")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_herotask/LeftDown/#go_rewarditem")
	self._gohasget = gohelper.findChild(self.viewGO, "#go_herotask/LeftDown/#go_rewarditem/#go_hasget")
	self._gogainedreward = gohelper.findChild(self.viewGO, "#go_herotask/LeftDown/#go_rewarditem/#go_gainReward")
	self._gopointitem = gohelper.findChild(self.viewGO, "#go_herotask/LeftDown/progresspoint/#go_pointitem")
	self._goTaskList = gohelper.findChild(self.viewGO, "#go_herotask/#scroll_task/Viewport/#go_TaskList")
	self._scrollTask = gohelper.findChildScrollRect(self.viewGO, "#go_herotask/#scroll_task")
	self.goNextIcon = gohelper.findChild(self.viewGO, "nexticon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5HeroTaskView:addEvents()
	return
end

function VersionActivity1_5HeroTaskView:removeEvents()
	return
end

function VersionActivity1_5HeroTaskView:onValueChanged(value)
	gohelper.setActive(self.goNextIcon, self._scrollTask.verticalNormalizedPosition >= 0.01)
end

function VersionActivity1_5HeroTaskView:_editableInitView()
	self.animator = self._goherotask:GetComponent(gohelper.Type_Animator)
	self.goSubHeroTaskItem = self.viewContainer:getRes(self.viewContainer:getSetting().otherRes[1])

	gohelper.setActive(self._gopointitem, false)

	self.gainRewardClick = gohelper.getClickWithAudio(self._gogainedreward, AudioEnum.UI.UI_Common_Click)

	self.gainRewardClick:AddClickListener(self.onClickGainReward, self)
	self._scrollTask:AddOnValueChanged(self.onValueChanged, self)

	self.progressPointList = {}
	self.subHeroTaskItemList = {}

	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SelectHeroTaskTabChange, self.onSelectHeroTabChange, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnGainedHeroTaskReward, self.onGainedHeroTaskReward, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnGainedSubHeroTaskReward, self.onGainedSubHeroTaskReward, self)
end

function VersionActivity1_5HeroTaskView:onClickGainReward()
	if self.taskMo.gainedReward then
		return
	end

	if self.taskMo:isFinish() then
		VersionActivity1_5DungeonRpc.instance:sendAct139GainHeroTaskRewardRequest(self.taskId)
	end
end

function VersionActivity1_5HeroTaskView:onSelectHeroTabChange()
	local isShow = VersionActivity1_5RevivalTaskModel.instance:getSelectHeroTaskId() ~= VersionActivity1_5DungeonEnum.ExploreTaskId

	gohelper.setActive(self._goherotask, isShow)
	gohelper.setActive(self.goNextIcon, isShow)

	if not isShow then
		self.taskId = 0

		return
	end

	VersionActivity1_5RevivalTaskModel.instance:setIsPlayingOpenAnim(true)
	self.animator:Play("open", 0, 0)

	self._scrollTask.verticalNormalizedPosition = 1

	self:refreshUI()
	TaskDispatcher.runDelay(self.onOpenAnimDone, self, 0.667)
end

function VersionActivity1_5HeroTaskView:onOpenAnimDone()
	VersionActivity1_5RevivalTaskModel.instance:setIsPlayingOpenAnim(false)
end

function VersionActivity1_5HeroTaskView:refreshUI()
	local selectTaskId = VersionActivity1_5RevivalTaskModel.instance:getSelectHeroTaskId()

	if self.taskId == selectTaskId then
		return
	end

	self.taskId = selectTaskId
	self.taskMo = VersionActivity1_5RevivalTaskModel.instance:getTaskMo(self.taskId)
	self.taskCo = self.taskMo.config

	local rewardList = string.splitToNumber(self.taskCo.reward, "#")

	self.rewardType = rewardList[1]
	self.rewardId = rewardList[2]
	self.rewardQuantity = rewardList[3]

	self:refreshTitle()

	self._txtheroDetail.text = self.taskCo.desc

	UISpriteSetMgr.instance:setV1a5RevivalTaskSprite(self._imageheroPhoto, self.taskCo.heroIcon)
	self:refreshProgress()
	self:refreshReward()
	self:refreshGainedReward()
	self:refreshSubTask()
end

function VersionActivity1_5HeroTaskView:refreshTitle()
	local titleList = string.split(self.taskCo.title, "-")
	local prefix, suffix = titleList[1], titleList[2]

	self._txttitle.text = string.format("%s——<color=#C66030>%s</color>", prefix, suffix)
end

function VersionActivity1_5HeroTaskView:refreshProgress()
	local totalCount = self.taskMo:getSubTaskCount()
	local finishCount = self.taskMo:getSubTaskFinishCount()

	self._txttotal.text = totalCount
	self._txtnum.text = finishCount

	for index = 1, totalCount do
		local pointItem = self:getPointItem(index)

		UISpriteSetMgr.instance:setV1a5RevivalTaskSprite(pointItem.image, index <= finishCount and "v1a5_revival_img_point1_2" or "v1a5_revival_img_point1_1")
	end

	for i = totalCount + 1, #self.progressPointList do
		gohelper.setActive(self.progressPointList[i].go, false)
	end
end

function VersionActivity1_5HeroTaskView:refreshReward()
	self.icon = self.icon or IconMgr.instance:getCommonItemIcon(self._gorewarditem)

	self.icon:setMOValue(self.rewardType, self.rewardId, self.rewardQuantity)
	self.icon:setScale(0.6, 0.6, 0.6)
	gohelper.setAsLastSibling(self._gogainedreward)
	gohelper.setAsLastSibling(self._gohasget)
end

function VersionActivity1_5HeroTaskView:refreshGainedReward()
	gohelper.setActive(self._gohasget, self.taskMo.gainedReward)

	if not self.taskMo:isFinish() then
		gohelper.setActive(self._gogainedreward, false)

		return
	end

	gohelper.setActive(self._gogainedreward, not self.taskMo.gainedReward)
end

function VersionActivity1_5HeroTaskView:refreshSubTask()
	local heroTaskCoList = self.taskMo:getSubTaskCoList()

	for index, taskCo in ipairs(heroTaskCoList) do
		local taskItem = self:getSubHeroTaskItem(index)

		taskItem:updateData(taskCo)
	end

	for i = #heroTaskCoList + 1, #self.subHeroTaskItemList do
		self.subHeroTaskItemList[i]:hide()
	end
end

function VersionActivity1_5HeroTaskView:getPointItem(index)
	local pointItem = self.progressPointList[index]

	if not pointItem then
		pointItem = self:getUserDataTb_()
		pointItem.go = gohelper.cloneInPlace(self._gopointitem)
		pointItem.image = pointItem.go:GetComponent(gohelper.Type_Image)

		table.insert(self.progressPointList, pointItem)
	end

	gohelper.setActive(pointItem.go, true)

	return pointItem
end

function VersionActivity1_5HeroTaskView:getSubHeroTaskItem(index)
	local subHeroItem = self.subHeroTaskItemList[index]

	if not subHeroItem then
		local go = gohelper.clone(self.goSubHeroTaskItem, self._goTaskList)

		subHeroItem = VersionActivity1_5SubHeroTaskItem.createItem(go)

		table.insert(self.subHeroTaskItemList, subHeroItem)
	end

	subHeroItem:show()

	return subHeroItem
end

function VersionActivity1_5HeroTaskView:onGainedHeroTaskReward(heroTaskId)
	if self.taskId ~= heroTaskId then
		return
	end

	self:refreshProgress()
	self:refreshGainedReward()
end

function VersionActivity1_5HeroTaskView:onGainedSubHeroTaskReward(subTaskId)
	self:refreshProgress()
end

function VersionActivity1_5HeroTaskView:onClose()
	TaskDispatcher.cancelTask(self.onOpenAnimDone, self)
end

function VersionActivity1_5HeroTaskView:onDestroyView()
	self.progressPointList = nil

	for _, subHeroTaskItem in ipairs(self.subHeroTaskItemList) do
		subHeroTaskItem:destroy()
	end

	self.gainRewardClick:RemoveClickListener()
	self._scrollTask:RemoveOnValueChanged()

	self.subHeroTaskItemList = nil
end

return VersionActivity1_5HeroTaskView
