-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionRoomFixBlockMaskPos.lua

module("modules.logic.guide.controller.action.impl.GuideActionRoomFixBlockMaskPos", package.seeall)

local GuideActionRoomFixBlockMaskPos = class("GuideActionRoomFixBlockMaskPos", BaseGuideAction)

function GuideActionRoomFixBlockMaskPos:onStart(context)
	GuideActionRoomFixBlockMaskPos.super.onStart(self, context)

	local goPath = GuideModel.instance:getStepGOPath(self.guideId, self.stepId)
	local blockGO = gohelper.find(goPath)

	if gohelper.isNil(blockGO) then
		logError(self.guideId .. "_" .. self.stepId .. " blockGO is nil: " .. goPath)
		self:onDone(true)

		return
	end

	if ViewMgr.instance:isOpenFinish(ViewName.GuideView) then
		self:_fixPos()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
	end
end

function GuideActionRoomFixBlockMaskPos:_checkOpenView(viewName)
	if viewName == ViewName.GuideView then
		self:_fixPos()
	end
end

function GuideActionRoomFixBlockMaskPos:_fixPos()
	local goPath = GuideModel.instance:getStepGOPath(self.guideId, self.stepId)
	local blockGO = gohelper.find(goPath)
	local maskView = ViewMgr.instance:getContainer(ViewName.GuideView)
	local maskViewGO = maskView and maskView.viewGO
	local maskViewTr = maskViewGO and maskViewGO.transform
	local worldPos = blockGO.transform.position
	local bendingPos = RoomBendingHelper.worldToBendingSimple(worldPos)
	local origin = recthelper.worldPosToAnchorPos(worldPos, maskViewTr)
	local bending = recthelper.worldPosToAnchorPos(bendingPos, maskViewTr)
	local offset = bending - origin

	GuideController.instance:dispatchEvent(GuideEvent.SetMaskOffset, offset)
	self:onDone(true)
end

function GuideActionRoomFixBlockMaskPos:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
end

function GuideActionRoomFixBlockMaskPos:onDestroy()
	GuideActionRoomFixBlockMaskPos.super.onDestroy(self)
	GuideController.instance:dispatchEvent(GuideEvent.SetMaskOffset, nil)
end

return GuideActionRoomFixBlockMaskPos
