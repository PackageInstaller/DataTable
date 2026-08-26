-- chunkname: @modules/logic/survival/view/shelter/ShelterTaskStoryTaskView.lua

module("modules.logic.survival.view.shelter.ShelterTaskStoryTaskView", package.seeall)

local ShelterTaskStoryTaskView = class("ShelterTaskStoryTaskView", BaseView)

function ShelterTaskStoryTaskView:onInitView()
	self.goStory = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_npc")
	self.itemList = {}
	self.taskType = SurvivalEnum.TaskModule.StoryTask
	self.itemGO = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_npc/#go_npcitem")

	gohelper.setActive(self.itemGO, false)
end

function ShelterTaskStoryTaskView:addEvents()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, self.refreshView, self)
end

function ShelterTaskStoryTaskView:removeEvents()
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, self.refreshView, self)
end

function ShelterTaskStoryTaskView:onOpen()
	return
end

function ShelterTaskStoryTaskView:refreshView(taskType)
	local isShow = taskType == self.taskType

	self:setTaskVisible(isShow)
end

function ShelterTaskStoryTaskView:setTaskVisible(isVisible)
	if self._isVisible == isVisible then
		if isVisible then
			self:refreshTask()
		end

		return
	end

	self._isVisible = isVisible

	if isVisible then
		self:refreshTask()

		self.animComp = self.animComp or MonoHelper.addNoUpdateLuaComOnceToGo(self.goStory, SurvivalItemListAnimComp)

		self.animComp:playListOpenAnim(self.itemList, 0.06)
	else
		gohelper.setActive(self.goStory, false)
	end
end

function ShelterTaskStoryTaskView:refreshTask()
	local list = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.StoryTask)
	local taskCount = #list

	for i = 1, math.max(taskCount, #self.itemList) do
		local item = self:getItem(i)

		self:updateItem(item, list[i])
	end

	gohelper.setActive(self.goStory, taskCount > 0)
end

function ShelterTaskStoryTaskView:getItem(index)
	local item = self.itemList[index]

	if not item then
		item = self:createItem(index, self.goStory)
		self.itemList[index] = item
	end

	return item
end

function ShelterTaskStoryTaskView:createItem(index, parentGO)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.clone(self.itemGO, parentGO, tostring(index))
	item.goFinished = gohelper.findChild(item.go, "finished")
	item.txtFinishedDesc = gohelper.findChildTextMesh(item.goFinished, "#txt_task")
	item.goUnfinish = gohelper.findChild(item.go, "unfinish")
	item.txtUnFinishDesc = gohelper.findChildTextMesh(item.goUnfinish, "#txt_task")
	item.goFinishing = gohelper.findChild(item.go, "finishing")
	item.txtFinishingDesc = gohelper.findChildTextMesh(item.goFinishing, "#txt_task")
	item.anim = item.go:GetComponent(gohelper.Type_Animator)

	return item
end

function ShelterTaskStoryTaskView:updateItem(item, taskMo)
	gohelper.setActive(item.go, taskMo ~= nil)

	if not taskMo then
		return
	end

	local isFinish = not taskMo:isUnFinish()
	local isFail = taskMo:isFail()

	gohelper.setActive(item.goFinished, isFinish and not isFail)
	gohelper.setActive(item.goUnfinish, not isFinish)
	gohelper.setActive(item.goFinishing, isFinish and isFail)

	local config = taskMo.co

	if isFinish then
		if isFail then
			if config then
				item.txtFinishingDesc.text = config.desc3 or ""
			end
		elseif config then
			item.txtFinishedDesc.text = config.desc2 or ""
		end
	elseif config then
		item.txtUnFinishDesc.text = config.desc or ""
	end
end

function ShelterTaskStoryTaskView:onClose()
	return
end

return ShelterTaskStoryTaskView
