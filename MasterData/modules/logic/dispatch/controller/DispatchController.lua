-- chunkname: @modules/logic/dispatch/controller/DispatchController.lua

module("modules.logic.dispatch.controller.DispatchController", package.seeall)

local DispatchController = class("DispatchController", BaseController)

function DispatchController:onInit()
	return
end

function DispatchController:onInitFinish()
	return
end

function DispatchController:addConstEvents()
	return
end

function DispatchController:reInit()
	return
end

function DispatchController:openDispatchView(actId, elementId, dispatchId)
	local viewName

	if actId then
		viewName = DispatchEnum.ActId2View[actId]
	end

	if not viewName then
		logError(string.format("DispatchController:openDispatchView error,DispatchEnum.ActId2View not have view, actId:%s", actId))

		return
	end

	local status = DispatchModel.instance:getDispatchStatus(elementId, dispatchId)

	if status == DispatchEnum.DispatchStatus.Finished then
		return
	end

	DispatchModel.instance:checkDispatchFinish()
	ViewMgr.instance:openView(viewName, {
		elementId = elementId,
		dispatchId = dispatchId
	})
end

DispatchController.instance = DispatchController.New()

return DispatchController
