-- chunkname: @modules/logic/versionactivity2_5/challenge/view/task/Act183TaskOneKeyItem.lua

module("modules.logic.versionactivity2_5.challenge.view.task.Act183TaskOneKeyItem", package.seeall)

local Act183TaskOneKeyItem = class("Act183TaskOneKeyItem", Act183TaskBaseItem)

function Act183TaskOneKeyItem:init(go)
	Act183TaskOneKeyItem.super.init(self, go)

	self._btngetall = gohelper.findChildButtonWithAudio(self.go, "#btn_getall")
	self._txtdesc = gohelper.findChildText(self.go, "txt_desc")
end

function Act183TaskOneKeyItem:addEventListeners()
	Act183TaskOneKeyItem.super.addEventListeners(self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function Act183TaskOneKeyItem:removeEventListeners()
	Act183TaskOneKeyItem.super.removeEventListeners(self)
	self._btngetall:RemoveClickListener()
end

function Act183TaskOneKeyItem:onUpdateMO(mo, mixType, param)
	Act183TaskOneKeyItem.super.onUpdateMO(self, mo, mixType, param)

	self._canGetRewardTasks = mo.data
end

function Act183TaskOneKeyItem:_btngetallOnClick()
	if not self._canGetRewardTasks or #self._canGetRewardTasks <= 0 then
		return
	end

	self:setBlock(true)
	self._animatorPlayer:Play("finish", self._sendRpcToFinishTask, self)

	self._canGetRewardTaskIds = {}

	for _, taskMo in ipairs(self._canGetRewardTasks) do
		table.insert(self._canGetRewardTaskIds, taskMo.id)
		Act183Controller.instance:dispatchEvent(Act183Event.ClickToGetReward, taskMo.id)
	end
end

function Act183TaskOneKeyItem:_sendRpcToFinishTask()
	local activityId = Act183Model.instance:getActivityId()

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity183, 0, self._canGetRewardTaskIds, function(__, resultCode)
		if resultCode ~= 0 then
			return
		end

		Act183Helper.showToastWhileGetTaskRewards(self._canGetRewardTaskIds)
	end, nil, activityId)
	self:setBlock(false)
end

return Act183TaskOneKeyItem
