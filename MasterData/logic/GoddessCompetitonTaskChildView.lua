-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitonTaskChildView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitonTaskChildView", package.seeall)

local GoddessCompetitonTaskChildView = class("GoddessCompetitonTaskChildView", EventTaskTabChildView)

function GoddessCompetitonTaskChildView:_updateTaskCell(view, cell, info, tag)
	GoddessCompetitonTaskChildView.super._updateTaskCell(self, view, cell, info, tag)

	local mainGo = cell.gameObject
	local taskId = info.taskId
	local data = EventTaskSummaryConfig.instance:getTaskData(self._activityId, taskId)
	local txtDesc = MaterialMgr.findGraphicText(mainGo, "txtDesc")

	if goutil.isNil(txtDesc) then
		txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	end

	if txtDesc then
		local curProgress = self._eventTaskMgr:getCurProgressOfTask(taskId)
		local maxProgress = data.maxProgress

		if maxProgress <= curProgress then
			if not GameEnum.ColorConst.Green then
				local colorEnum = GameEnum.ColorConst.Red

				txtDesc.text = string.format("%s(<color=%s>%s</color>/%s)", data.desc, colorEnum, Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)
			end
		end
	end
end

return GoddessCompetitonTaskChildView
