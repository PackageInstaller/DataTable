-- chunkname: @modules/logic/turnback/controller/TurnbackReturnTaskController.lua

module("modules.logic.turnback.controller.TurnbackReturnTaskController", package.seeall)

local TurnbackReturnTaskController = class("TurnbackReturnTaskController", BaseController)

function TurnbackReturnTaskController:onInit()
	return
end

function TurnbackReturnTaskController:onInitFinish()
	return
end

function TurnbackReturnTaskController:addConstEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinsh, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnChangeChapterList, self._onChangeChapterList, self)
end

function TurnbackReturnTaskController:_onChangeChapterList(param)
	local curReadTaskId = TurnbackReturnTaskModel.instance:getCurReadTaskId()

	if not curReadTaskId then
		return
	end

	local info = TurnbackReturnTaskModel.instance:getJumpUiInfo(curReadTaskId)

	if not info or tonumber(info[1]) ~= TurnbackEnum.TaskJumpType.DungeopnChapterType or tonumber(info[2]) ~= param then
		return
	end

	TaskRpc.instance:sendFinishReadTaskRequest(curReadTaskId)
end

function TurnbackReturnTaskController:_onOpenViewFinsh(viewName)
	local curReadTaskId = TurnbackReturnTaskModel.instance:getCurReadTaskId()

	if not curReadTaskId then
		return
	end

	local info = TurnbackReturnTaskModel.instance:getJumpUiInfo(curReadTaskId)

	if not info or tonumber(info[1]) ~= TurnbackEnum.TaskJumpType.ViewName or info[2] ~= viewName then
		return
	end

	TaskRpc.instance:sendFinishReadTaskRequest(curReadTaskId)
end

TurnbackReturnTaskController.instance = TurnbackReturnTaskController.New()

return TurnbackReturnTaskController
