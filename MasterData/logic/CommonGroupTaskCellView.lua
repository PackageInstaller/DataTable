-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/view/CommonGroupTaskCellView.lua

module("logic.extensions.caiqingdraw.view.CommonGroupTaskCellView", package.seeall)

local CommonGroupTaskCellView = class("CommonGroupTaskCellView", EventTaskGroupChildView)

function CommonGroupTaskCellView:_updateTaskCell(view, cell, info, tag)
	CommonGroupTaskCellView.super._updateTaskCell(self, view, cell, info, tag)

	local mainGo = cell.gameObject
	local taskId = info.taskId
	local data = EventTaskSummaryConfig.instance:getTaskData(self._activityId, taskId)
	local playerTypeTagGo = goutil.findChild(mainGo, "playerTypeTag")
	local txtPlayerTypeTag = goutil.findChildTextComponent(mainGo, "playerTypeTag/txt")
	local playerTypeTag = self._eventTaskMgr:getPlayerTypeTag()
	local isShowPlayerTypeTag = not string.nilorempty(data.playerTypeTag) and data.playerTypeTag == playerTypeTag and not string.nilorempty(data.playerTypeTagName)

	GameUtil.SetActive(playerTypeTagGo, isShowPlayerTypeTag)

	txtPlayerTypeTag.text = data.playerTypeTagName
end

function CommonGroupTaskCellView:_clearTaskCell(cell)
	CommonGroupTaskCellView.super._clearTaskCell(self, cell)

	local mainGo = cell.gameObject
	local playerTypeTagGo = goutil.findChild(mainGo, "playerTypeTag")

	GameUtil.SetActive(playerTypeTagGo, false)
end

return CommonGroupTaskCellView
