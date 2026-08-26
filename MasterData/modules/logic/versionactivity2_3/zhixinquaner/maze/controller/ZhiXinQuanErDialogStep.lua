-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/controller/ZhiXinQuanErDialogStep.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.controller.ZhiXinQuanErDialogStep", package.seeall)

local ZhiXinQuanErDialogStep = class("ZhiXinQuanErDialogStep", BaseWork)

function ZhiXinQuanErDialogStep:initData(data)
	self._data = data
	self._dialogueId = tonumber(data.param)
end

function ZhiXinQuanErDialogStep:onStart(context)
	if self._data.param == 0 then
		return self:onDone(true)
	end

	self:beginPlayDialog()
end

function ZhiXinQuanErDialogStep:beginPlayDialog()
	local co = Activity176Config.instance:getBubbleCo(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr, self._dialogueId)

	if not co then
		logError("纸信圈儿对话配置不存在" .. self._dialogueId)
		self:onDone(true)

		return
	end

	PuzzleMazeDrawController.instance:registerCallback(PuzzleEvent.OnFinishDialog, self._onFinishDialog, self)

	local dialogPosX, dialogPosY = self:_getDialogPos()
	local params = {
		co = co,
		dialogPosX = dialogPosX,
		dialogPosY = dialogPosY
	}

	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnStartDialog, params)
end

function ZhiXinQuanErDialogStep:_getDialogPos()
	local pawnPosX, pawnPosY = PuzzleMazeDrawController.instance:getLastPos()
	local pawnAnchorX, pawnAnchorY = PuzzleMazeDrawModel.instance:getObjectAnchor(pawnPosX, pawnPosY)

	return pawnAnchorX, pawnAnchorY + 100
end

function ZhiXinQuanErDialogStep:_onFinishDialog()
	PuzzleMazeDrawController.instance:unregisterAllCallback(PuzzleEvent.OnFinishDialog, self._onFinishDialog, self)
	self:onDone(true)
end

function ZhiXinQuanErDialogStep:clearWork()
	PuzzleMazeDrawController.instance:unregisterCallback(PuzzleEvent.OnFinishDialog, self._onFinishDialog, self)
end

return ZhiXinQuanErDialogStep
