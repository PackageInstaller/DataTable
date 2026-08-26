-- chunkname: @modules/logic/versionactivity1_9/fairyland/controller/FairyLandController.lua

module("modules.logic.versionactivity1_9.fairyland.controller.FairyLandController", package.seeall)

local FairyLandController = class("FairyLandController", BaseController)

function FairyLandController:onInit()
	return
end

function FairyLandController:onInitFinish()
	return
end

function FairyLandController:openFairyLandView(param)
	self.viewParam = param

	if FairyLandModel.instance.hasInfo then
		self:_openView()
	else
		FairyLandRpc.instance:sendGetFairylandInfoRequest(self._openView, self)
	end
end

function FairyLandController:_openView()
	if FairyLandModel.instance:isFinishFairyLand() then
		self:checkFinishFairyLandElement()

		return
	end

	ViewMgr.instance:openView(ViewName.FairyLandView, self.viewParam)
end

function FairyLandController:checkFinishFairyLandElement()
	if not DungeonMapModel.instance:elementIsFinished(FairyLandEnum.ElementId) then
		DungeonRpc.instance:sendMapElementRequest(FairyLandEnum.ElementId)
	end
end

function FairyLandController:openDialogView(param)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.ShowDialogView, param)
end

function FairyLandController:closeDialogView()
	FairyLandController.instance:dispatchEvent(FairyLandEvent.CloseDialogView)
end

function FairyLandController:openCompleteView(puzzleId, callback, callbackObj)
	local shapeType = FairyLandEnum.Puzzle2ShapeType[puzzleId]

	if shapeType then
		ViewMgr.instance:openView(ViewName.FairyLandCompleteView, {
			shapeType = shapeType,
			callback = callback,
			callbackObj = callbackObj
		})
	elseif callback then
		callback(callbackObj)
	end
end

function FairyLandController.endFairyLandStory()
	FairyLandController.instance:checkFinishFairyLandElement()
end

FairyLandController.instance = FairyLandController.New()

return FairyLandController
