-- chunkname: @modules/logic/reactivity/controller/ReactivityController.lua

module("modules.logic.reactivity.controller.ReactivityController", package.seeall)

local ReactivityController = class("ReactivityController", BaseController)

function ReactivityController:onInit()
	return
end

function ReactivityController:onInitFinish()
	return
end

function ReactivityController:openReactivityTaskView(actId)
	self._enterActivityView(self, ViewName.ReactivityTaskView, actId, self._openTaskView, self)
end

function ReactivityController:_openTaskView(viewName, actId)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(viewName, {
			actId = actId
		})
	end)
end

function ReactivityController:getCurReactivityId()
	for actId, v in pairs(ReactivityEnum.ActivityDefine) do
		local status = ActivityHelper.getActivityStatus(actId)
		local storeStatus = ActivityHelper.getActivityStatus(v.storeActId)

		if status == ActivityEnum.ActivityStatus.Normal or status == ActivityEnum.ActivityStatus.NotUnlock or storeStatus == ActivityEnum.ActivityStatus.Normal then
			return actId
		end
	end
end

function ReactivityController:openReactivityStoreView(actId, viewName)
	local define = ReactivityEnum.ActivityDefine[actId]

	if not define then
		return
	end

	local storeActId = define.storeActId

	self._enterActivityView(self, viewName or ViewName.ReactivityStoreView, storeActId, self._openStoreView, self)
end

function ReactivityController:_openStoreView(viewName, actId)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, function()
		ViewMgr.instance:openView(viewName, {
			actId = actId
		})
	end)
end

function ReactivityController:_enterActivityView(viewName, actId, callback, callbackObj, viewParam)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, toastParamList)
		end

		return
	end

	if callback then
		callback(callbackObj, viewName, actId, viewParam)

		return
	end

	local param = {
		actId = actId
	}

	if viewParam then
		for k, v in pairs(viewParam) do
			param[k] = v
		end
	end

	ViewMgr.instance:openView(viewName, param)
end

ReactivityController.instance = ReactivityController.New()

return ReactivityController
