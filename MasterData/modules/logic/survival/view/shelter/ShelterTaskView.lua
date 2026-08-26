-- chunkname: @modules/logic/survival/view/shelter/ShelterTaskView.lua

module("modules.logic.survival.view.shelter.ShelterTaskView", package.seeall)

local ShelterTaskView = class("ShelterTaskView", BaseView)

function ShelterTaskView:onInitView()
	self.goEmpty = gohelper.findChild(self.viewGO, "#go_empty")
	self.tabList = {}
end

function ShelterTaskView:addEvents()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnTaskDataUpdate, self.onTaskDataUpdate, self)
end

function ShelterTaskView:removeEvents()
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnTaskDataUpdate, self.onTaskDataUpdate, self)
end

function ShelterTaskView:onClickTab(tab)
	if not tab then
		return
	end

	if SurvivalTaskModel.instance:setSelectType(tab.taskType) then
		self:refreshTabList()
	end
end

function ShelterTaskView:onTaskDataUpdate()
	self:refreshView()
end

function ShelterTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_2)
	self:refreshParam()
	self:refreshView()
end

function ShelterTaskView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function ShelterTaskView:refreshParam()
	if not self.viewParam then
		SurvivalTaskModel.instance:initViewParam(self.viewParam.moduleId, self.viewParam.taskId)
	end
end

function ShelterTaskView:refreshView()
	self:refreshTabList()
end

function ShelterTaskView:refreshTabList()
	local list = {
		{
			isShow = true,
			taskType = SurvivalEnum.TaskModule.MainTask
		},
		{
			isShow = true,
			taskType = SurvivalEnum.TaskModule.StoryTask
		}
	}
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	table.insert(list, {
		isShow = false,
		taskType = SurvivalEnum.TaskModule.NormalTask
	})

	for i = 1, #list do
		self:refreshTab(i, list[i])
	end

	TaskDispatcher.cancelTask(self.refreshTaskView, self)

	if self.isNotFirstOpen then
		self:refreshTaskView()
	else
		TaskDispatcher.runDelay(self.refreshTaskView, self, 0.4)

		self.isNotFirstOpen = true
	end
end

function ShelterTaskView:refreshTaskView()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTaskViewUpdate, SurvivalTaskModel.instance:getSelectType())
end

function ShelterTaskView:refreshTab(index, data)
	local taskType = data.taskType
	local isShow = data.isShow
	local selectType = SurvivalTaskModel.instance:getSelectType()
	local isSelect = selectType == taskType
	local tab = self.tabList[index]

	if not tab then
		tab = self:getUserDataTb_()
		tab.go = gohelper.findChild(self.viewGO, string.format("#go_tabcontainer/container/#go_tabitem%s", index))
		tab.goSelect = gohelper.findChild(tab.go, "#go_select")
		tab.goSelectFinished = gohelper.findChild(tab.goSelect, "finished")
		tab.goSelectUnFinish = gohelper.findChild(tab.goSelect, "unfinish")
		tab.txtSelectNum = gohelper.findChildTextMesh(tab.goSelect, "unfinish/#txt_num")
		tab.goUnSelect = gohelper.findChild(tab.go, "#go_unselect")
		tab.goUnSelectFinished = gohelper.findChild(tab.goUnSelect, "finished")
		tab.goUnSelectUnFinish = gohelper.findChild(tab.goUnSelect, "unfinish")
		tab.txtUnSelectNum = gohelper.findChildTextMesh(tab.goUnSelect, "unfinish/#txt_num")
		tab.btn = gohelper.findButtonWithAudio(tab.go)

		tab.btn:AddClickListener(self.onClickTab, self, tab)

		self.tabList[index] = tab
	end

	tab.taskType = taskType

	gohelper.setActive(tab.go, isShow)

	if not isShow then
		return
	end

	gohelper.setActive(tab.goSelect, isSelect)
	gohelper.setActive(tab.goUnSelect, not isSelect)

	local finishedNum, taskNum = SurvivalTaskModel.instance:getTaskFinishedNum(taskType)

	if taskType == SurvivalEnum.TaskModule.MainTask then
		local subfinishedNum, subtaskNum = SurvivalTaskModel.instance:getTaskFinishedNum(SurvivalEnum.TaskModule.SubTask)

		finishedNum = finishedNum + subfinishedNum
		taskNum = taskNum + subtaskNum
	end

	if taskType == SurvivalEnum.TaskModule.NormalTask then
		local mapfinishedNum, maptaskNum = SurvivalTaskModel.instance:getTaskFinishedNum(SurvivalEnum.TaskModule.MapMainTarget)

		finishedNum = finishedNum + mapfinishedNum
		taskNum = taskNum + maptaskNum
	end

	local isEmpty = taskNum == 0
	local isAllFinished = not isEmpty and finishedNum == taskNum

	gohelper.setActive(tab.go, true)

	if isSelect then
		gohelper.setActive(self.goEmpty, isEmpty)
		gohelper.setActive(tab.goSelectFinished, isAllFinished)
		gohelper.setActive(tab.goSelectUnFinish, not isAllFinished)

		tab.txtSelectNum.text = isEmpty and "" or string.format("<size=50>%s</size>/%s", finishedNum, taskNum)
	else
		gohelper.setActive(tab.goUnSelectFinished, isAllFinished)
		gohelper.setActive(tab.goUnSelectUnFinish, not isAllFinished)

		tab.txtUnSelectNum.text = isEmpty and "" or string.format("<color=#FFFFFF><size=50>%s</size></color>/%s", finishedNum, taskNum)
	end
end

function ShelterTaskView:onDestroyView()
	for _, v in pairs(self.tabList) do
		v.btn:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(self.refreshTaskView, self)
end

return ShelterTaskView
