-- chunkname: @modules/logic/season/view1_4/Season1_4TaskView.lua

module("modules.logic.season.view1_4.Season1_4TaskView", package.seeall)

local Season1_4TaskView = class("Season1_4TaskView", BaseView)

function Season1_4TaskView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goScroll = gohelper.findChild(self.viewGO, "#scroll_tasklist")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_tasklist/Viewport/Content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_4TaskView:addEvents()
	return
end

function Season1_4TaskView:removeEvents()
	return
end

function Season1_4TaskView:_editableInitView()
	self._simagebg:LoadImage(SeasonViewHelper.getSeasonIcon("full/bg1.png"))

	self._items = {}
end

function Season1_4TaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.updateTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.updateTask, self)
	self:refreshTask(true)
end

function Season1_4TaskView:onClose()
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.updateTask, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.updateTask, self)
end

function Season1_4TaskView:updateTask()
	TaskDispatcher.cancelTask(self.refreshTask, self)
	TaskDispatcher.runDelay(self.refreshTask, self, 0.2)
end

function Season1_4TaskView:refreshTask(open)
	local dataList = Activity104TaskModel.instance:getTaskSeasonList()
	local list = {}
	local finishCount = 0

	for i, v in ipairs(dataList) do
		list[i] = v

		if v.hasFinished then
			finishCount = finishCount + 1
		end
	end

	if finishCount > 1 then
		table.insert(list, 1, {
			isTotalGet = true
		})
	end

	self._dataList = list

	TaskDispatcher.cancelTask(self.showByLine, self)

	if open then
		for i, v in ipairs(self._items) do
			v:hide()
		end

		self._repeatCount = 0

		TaskDispatcher.runRepeat(self.showByLine, self, 0.04, #self._dataList)
	else
		for i = 1, math.max(#self._dataList, #self._items) do
			local item = self:getItem(i)
			local data = self._dataList[i]

			item:onUpdateMO(data)
		end
	end
end

function Season1_4TaskView:showByLine()
	self._repeatCount = self._repeatCount + 1

	local index = self._repeatCount
	local item = self:getItem(index)
	local data = self._dataList[index]

	item:onUpdateMO(data, true)

	if index >= #self._dataList then
		TaskDispatcher.cancelTask(self.showByLine, self)
	end
end

function Season1_4TaskView:getItem(index)
	if self._items[index] then
		return self._items[index]
	end

	local res = self.viewContainer:getSetting().otherRes[1]
	local go = self:getResInst(res, self._goContent, "item" .. index)
	local item = Season1_4TaskItem.New(go, self._goScroll)

	self._items[index] = item

	return item
end

function Season1_4TaskView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTask, self)
	TaskDispatcher.cancelTask(self.showByLine, self)
	self._simagebg:UnLoadImage()

	for k, v in pairs(self._items) do
		v:destroy()
	end

	self._items = nil
end

return Season1_4TaskView
