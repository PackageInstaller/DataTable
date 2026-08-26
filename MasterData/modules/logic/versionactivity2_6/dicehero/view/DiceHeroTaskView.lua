-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroTaskView.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroTaskView", package.seeall)

local DiceHeroTaskView = class("DiceHeroTaskView", BaseView)

function DiceHeroTaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function DiceHeroTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	DiceHeroTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.DiceHero
	}, self._oneClaimReward, self)
end

function DiceHeroTaskView:_oneClaimReward()
	DiceHeroTaskListModel.instance:init()
end

function DiceHeroTaskView:_onFinishTask(taskId)
	if DiceHeroTaskListModel.instance:getById(taskId) then
		DiceHeroTaskListModel.instance:init()
	end
end

return DiceHeroTaskView
