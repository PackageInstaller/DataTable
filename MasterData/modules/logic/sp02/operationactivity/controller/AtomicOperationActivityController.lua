-- chunkname: @modules/logic/sp02/operationactivity/controller/AtomicOperationActivityController.lua

module("modules.logic.sp02.operationactivity.controller.AtomicOperationActivityController", package.seeall)

local AtomicOperationActivityController = class("AtomicOperationActivityController", BaseController)

function AtomicOperationActivityController:onInit()
	return
end

function AtomicOperationActivityController:onInitFinish()
	return
end

function AtomicOperationActivityController:addConstEvents()
	return
end

function AtomicOperationActivityController:reInit()
	return
end

function AtomicOperationActivityController:openMainView(actId, param)
	if not AtomicOperationActivityModel.instance:isActivityOpen(actId) then
		return
	end

	AtomicOperationActivityModel.instance:setCurActId(actId)
	ViewMgr.instance:openView(ViewName.AtomicOperationActivityEnterView, param)
end

function AtomicOperationActivityController:openTaskView(actId)
	if not AtomicOperationActivityModel.instance:isActivityOpen(actId) then
		return
	end

	local param = {}

	param.actId = actId

	AtomicOperationActivityModel.instance:setCurTaskId(actId)
	ViewMgr.instance:openView(ViewName.AtomicOperationActivityTaskView, param)
end

function AtomicOperationActivityController:openPreparationView(actId)
	if not AtomicOperationActivityModel.instance:isActivityOpen(actId) then
		return
	end

	local param = {}

	param.actId = actId

	ViewMgr.instance:openView(ViewName.AtomicOperationActivityPreparationView, param)
end

function AtomicOperationActivityController:openGameMainView(actId)
	if not AtomicOperationActivityModel.instance:isActivityOpen(actId) then
		return
	end

	AtomicOperationActivityModel.instance:setCurGameId(actId)
	self.getActPreparationInfo(self, actId, self.realOpenGameMainView, self)
end

function AtomicOperationActivityController:realOpenGameMainView()
	local param = {}

	param.actId = AtomicOperationActivityModel.instance:getCurGameId()

	ViewMgr.instance:openView(ViewName.AtomicOperationActivityGameMainView, param)
end

function AtomicOperationActivityController:activePreparation(actId, preparationId)
	AtomicOperationActivityRpc.instance:sendActivePreparationRequest(actId, preparationId)
end

function AtomicOperationActivityController:getActPreparationInfo(actId, callback, callbackObj)
	AtomicOperationActivityRpc.instance:sendGetAct235InfoRequest(actId, callback, callbackObj)
end

function AtomicOperationActivityController:finishGame(actId, typeInfoList)
	AtomicOperationActivityRpc.instance:sendFinishMiniGameRequest(actId, typeInfoList)
end

AtomicOperationActivityController.instance = AtomicOperationActivityController.New()

return AtomicOperationActivityController
