-- chunkname: @modules/logic/patface/controller/PatFaceFlowSequence.lua

module("modules.logic.patface.controller.PatFaceFlowSequence", package.seeall)

local PatFaceFlowSequence = class("PatFaceFlowSequence", FlowSequence)
local PAT_FACE_BLOCK = "PatFaceUIBlock"

function PatFaceFlowSequence:isContinuePopView()
	return self._curIndex < #self._workList
end

function PatFaceFlowSequence:_runNext()
	local tmpNextIndex = self._curIndex + 1

	if tmpNextIndex > #self._workList then
		self._curIndex = tmpNextIndex

		self:onDone(true)

		return
	end

	UIBlockMgr.instance:startBlock(PAT_FACE_BLOCK)
	self:_waitInMainView()
end

function PatFaceFlowSequence:_waitInMainView()
	UIBlockMgr.instance:endBlock(PAT_FACE_BLOCK)

	local isInMainView = MainController.instance:isInMainView()

	if isInMainView then
		PatFaceFlowSequence.super._runNext(self)
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._viewChangeCheckIsInMainView, self)
	end
end

function PatFaceFlowSequence:_removeViewChangeEvent()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._viewChangeCheckIsInMainView, self)
end

function PatFaceFlowSequence:_onOpenViewFinish(viewName)
	if viewName ~= ViewName.MainView then
		return
	end

	self:_viewChangeCheckIsInMainView()
end

function PatFaceFlowSequence:_viewChangeCheckIsInMainView()
	local isInMainView = MainController.instance:isInMainView()

	if not isInMainView then
		return
	end

	self:_removeViewChangeEvent()
	self:_runNext()
end

function PatFaceFlowSequence:clearWork()
	self:_removeViewChangeEvent()
	UIBlockMgr.instance:endBlock(PAT_FACE_BLOCK)
end

return PatFaceFlowSequence
