-- chunkname: @modules/logic/gm/view/GM_TaskView.lua

module("modules.logic.gm.view.GM_TaskView", package.seeall)

local GM_TaskView = class("GM_TaskView")

function GM_TaskView.register()
	GM_TaskView.TaskDailyView_register(TaskDailyView)
	GM_TaskView.TaskWeeklyView_register(TaskWeeklyView)
	GM_TaskView.TaskListCommonItem_register(TaskListCommonItem)
end

local function _gm(cmd, callback, callbackObj)
	local rpc = getGlobal("GMRpc")

	if not rpc then
		logError("are u already login?")

		return
	end

	logNormal(cmd)
	rpc.instance:sendGMRequest(cmd, callback, callbackObj)
end

local function _set_taskfinish(taskIdListOrTaskId, callback, callbackObj)
	if not taskIdListOrTaskId then
		if callback then
			callback(callbackObj)
		end

		return
	end

	local cmd = "set taskfinish "

	if type(taskIdListOrTaskId) == "table" then
		if #taskIdListOrTaskId == 0 then
			return
		end

		cmd = cmd .. table.concat(taskIdListOrTaskId, " ")
	else
		cmd = cmd .. taskIdListOrTaskId
	end

	_gm(cmd, callback, callbackObj)
end

local function _gm_onClickFinishAll(taskType, selfObj)
	local allRewardGet = TaskModel.instance:isAllRewardGet(taskType)

	if allRewardGet then
		return
	end

	local tasks = TaskModel.instance:getAllUnlockTasks(taskType)
	local taskIdList = {}
	local taskMoRefList = {}

	for taskId, mo in pairs(tasks) do
		if not TaskModel.instance:taskHasFinished(taskType, taskId) then
			table.insert(taskMoRefList, mo)
			table.insert(taskIdList, taskId)
		end
	end

	if #taskIdList == 0 then
		return
	end

	_set_taskfinish(taskIdList, function(_)
		for _, mo in ipairs(taskMoRefList) do
			mo.hasFinished = true
		end

		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end, selfObj)
end

function GM_TaskView.TaskDailyView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)

		local btnGM = GMMinusModel.instance:addBtnGM(self)

		UIDockingHelper.setDock(UIDockingHelper.Dock.MR_R, btnGM.transform, self._txtLeftTime.transform, 15)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_TaskDailyViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_TaskDailyViewContainer.removeEvents(self)
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function T._gm_enableFinishOnSelect(selfObj)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function T._gm_onClickFinishAll(selfObj)
		_gm_onClickFinishAll(TaskEnum.TaskType.Daily, selfObj)
	end
end

function GM_TaskView.TaskWeeklyView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)

		local btnGM = GMMinusModel.instance:addBtnGM(self)

		UIDockingHelper.setDock(UIDockingHelper.Dock.MR_R, btnGM.transform, self._txtLeftTime.transform, 15)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_TaskWeeklyViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_TaskWeeklyViewContainer.removeEvents(self)
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function T._gm_enableFinishOnSelect(selfObj)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function T._gm_onClickFinishAll(selfObj)
		_gm_onClickFinishAll(TaskEnum.TaskType.Weekly, selfObj)
	end
end

local k_rTaskType

function GM_TaskView.TaskListCommonItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "init")
	GMMinusModel.instance:saveOriginalFunc(T, "_refreshCommonItem")
	GMMinusModel.instance:saveOriginalFunc(T, "_btnnotfinishbgOnClick")

	if not k_rTaskType then
		k_rTaskType = {}

		for k, v in pairs(TaskEnum.TaskType) do
			k_rTaskType[v] = k
		end
	end

	function T.init(selfObj, go, ...)
		local btnnotFinishBgTextGo = gohelper.findChild(go, "#go_common/#go_notget/#btn_notfinishbg/text")

		selfObj.__btnnotFinishBgText = gohelper.findChildText(btnnotFinishBgTextGo, "")
		selfObj.__btnnotFinishBgTextLangTxtCmp = btnnotFinishBgTextGo:GetComponent(typeof(SLFramework.LangTxt))

		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "init", go, ...)
	end

	function T._refreshCommonItem(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_refreshCommonItem", ...)

		local mo = selfObj._mo

		if not mo then
			return
		end

		T._gm_s_callFunc("_refreshCommonItem", selfObj, ...)
	end

	function T._btnnotfinishbgOnClick(selfObj, ...)
		T._gm_s_callFunc("_btnnotfinishbgOnClick", selfObj, ...)
	end

	local kGmFuncPrefix = "_gm_"
	local kGmStaticFuncPrefix = kGmFuncPrefix .. "s_"

	function T._gm_refreshCommonItem_showAllTabId(selfObj, ...)
		local mo = selfObj._mo
		local co = mo.config
		local taskId = co.id
		local taskIdStr = gohelper.getRichColorText(tostring(taskId), "#FF0000")

		selfObj._txttaskdes.text = taskIdStr .. string.format(co.desc, co.maxProgress)
	end

	function T._gm_refreshCommonItem_enableFinishSelectedTask(selfObj, isActive)
		if not selfObj.__btnnotFinishBgText then
			return
		end

		selfObj.__btnnotFinishBgText.text = isActive and "立即\n完成" or luaLang("p_task_nofinish")
	end

	function T._gm_s_callFunc(kMagicPrefix, selfObj, ...)
		local taskType = selfObj._taskType
		local taskTypeEnumName = k_rTaskType[taskType]
		local specialFuncName = kGmFuncPrefix .. kMagicPrefix .. taskTypeEnumName
		local selfObjFunc = selfObj[specialFuncName]

		if selfObjFunc then
			selfObjFunc(selfObj, ...)

			return
		end

		local GM_ViewName = "GM_Task" .. taskTypeEnumName .. "View"
		local clsPath = _G.getModulePath(GM_ViewName)

		if not clsPath then
			logWarn("[GM_TaskView] lua class not found " .. GM_ViewName)

			return
		end

		local cls = addGlobalModule(clsPath)
		local defaultFuncName = kGmStaticFuncPrefix .. kMagicPrefix
		local staticFunc = T[defaultFuncName]

		assert(staticFunc, "please impl default function: T['" .. defaultFuncName .. "']")
		staticFunc(cls, selfObj, ...)
	end

	function T._gm_s__refreshCommonItem(GM_TaskXXXView, selfObj, ...)
		if GM_TaskXXXView.s_ShowAllTabId then
			selfObj._gm_refreshCommonItem_showAllTabId(selfObj, selfObj, ...)
		end

		local isActive = false
		local mo = selfObj._mo

		if GM_TaskXXXView.s_enableFinishSelectedTask then
			selfObj.__btnnotFinishBgTextLangTxtCmp.enabled = false
			isActive = not mo.hasFinished
		end

		selfObj:_gm_refreshCommonItem_enableFinishSelectedTask(isActive)
	end

	function T._gm_s__btnnotfinishbgOnClick(GM_TaskXXXView, selfObj, ...)
		local mo = selfObj._mo

		if mo then
			::label_28_0::

			local var_28_0 = GM_TaskXXXView.s_enableFinishSelectedTask

			if GM_TaskXXXView.s_enableFinishSelectedTask then
				local isInject = not mo.hasFinished

				if isInject then
					local co = mo.config
					local taskId = co.id

					_set_taskfinish(taskId, function(_)
						mo.hasFinished = true

						TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
					end, selfObj)
				else
					GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_btnnotfinishbgOnClick", ...)
				end
			end
		end
	end
end

return GM_TaskView
