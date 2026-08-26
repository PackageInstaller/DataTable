-- chunkname: @modules/logic/versionactivity2_5/challenge/view/task/Act183TaskHeadItem.lua

module("modules.logic.versionactivity2_5.challenge.view.task.Act183TaskHeadItem", package.seeall)

local Act183TaskHeadItem = class("Act183TaskHeadItem", Act183TaskBaseItem)

function Act183TaskHeadItem:init(go)
	Act183TaskHeadItem.super.init(self, go)

	self._txtdesc = gohelper.findChildText(self.go, "txt_desc")
end

function Act183TaskHeadItem:onUpdateMO(mo, mixType, param)
	Act183TaskHeadItem.super.onUpdateMO(self, mo, mixType, param)

	self._firstTaskMo = mo.data
	self._firstTaskCo = self._firstTaskMo and self._firstTaskMo.config

	self:refresh()
end

function Act183TaskHeadItem:refresh()
	self._txtdesc.text = self._firstTaskCo and self._firstTaskCo.minType
end

function Act183TaskHeadItem:_getTaskFinishCount(groupTaskCos)
	local finishCount = 0

	if groupTaskCos then
		for _, taskCo in ipairs(groupTaskCos) do
			local isTaskFinish = TaskModel.instance:taskHasFinished(TaskEnum.TaskType.Activity183, taskCo.id)

			if isTaskFinish then
				finishCount = finishCount + 1
			end
		end
	end

	return finishCount
end

return Act183TaskHeadItem
