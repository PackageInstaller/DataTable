-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/MasterTrainingTask/view/MasterTrainingTaskView.lua

module("logic.extensions.MasterTrainingTask.view.MasterTrainingTaskView", package.seeall)

local M = class("MasterTrainingTaskView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtn("0&middle_tips_common_bg_-1205189576")
	self._content = self:getGo("supervisor_training_tips_-874610613")
	self._comps = {}

	for i = 1, 4 do
		local task = {}
		local btnTask = goutil.findChild(self._content, "btn" .. i)

		task.incomplete = goutil.findChild(btnTask, "incomplete")
		task.btnGo = UIComponentType.ButtonAdapter(goutil.findChild(btnTask, "incomplete/btnGo"))
		task.txtDone = goutil.findChild(btnTask, "incomplete/txtDone")
		task.receive = goutil.findChild(btnTask, "receive")
		task.btnReceive = UIComponentType.ButtonAdapter(goutil.findChild(btnTask, "receive/btnReceive"))
		task.txtContent = goutil.findChildTextComponent(btnTask, "txtContent")
		task.completed = goutil.findChild(btnTask, "completed")
		task.item = goutil.findChild(btnTask, "itemList/backpack_item_1")
		self._comps[i] = task
	end
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)

	for i = 1, 4 do
		self._comps[i].btnReceive:AddClickListener(function()
			return self:_onClickReceive(i)
		end, self)
		self._comps[i].btnGo:AddClickListener(function()
			return self:_onClickJump(i)
		end, self)
	end

	GlobalDispatcher:addEventListener(EventType.MASTER_TRAINING_TASK, self._updateTaskList, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()

	for i = 1, 4 do
		self._comps[i].btnReceive:RemoveClickListener()
		self._comps[i].btnGo:RemoveClickListener()
	end

	GlobalDispatcher:removeEventListener(EventType.MASTER_TRAINING_TASK, self._updateTaskList, self)
end

function M:onEnter()
	PlayerAgent.instance:sendGetMasterTrainingTaskListRequest()

	self._taskCfg = MasterTrainingTaskConfig.instance:getOnlineCfg()

	table.sort(self._taskCfg, function(cfgA, cfgB)
		return cfgA.priority > cfgB.priority
	end)

	self._id2Index = {}

	local today = ServerTime.formatNow("%x")
	local record = Astral.LocalStorage.Instance:GetString("training_task_data")

	if today ~= record then
		Astral.LocalStorage.Instance:SetString("training_task_data", today)
	end
end

function M:_onClickJump(index)
	local taskid = self._taskCfg[index].id
	local taskMo = MasterTrainingTaskModel.instance:getTaskMo(taskid)
	local jumpId = taskMo:getJumpId()

	if jumpId <= 0 then
		return
	end

	if not SystemJumpController.instance:canJump(jumpId, true) then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
end

function M:_onClickReceive(index)
	local taskid = self._taskCfg[index].id

	PlayerAgent.instance:sendFinishMasterTrainingTaskRequest(taskid)
	MasterTrainingTaskModel.instance:getTaskMo(taskid):setIsFinish(true)
	self:_refreshStatus(taskid)
end

function M:_updateTaskList()
	for i = 1, 4 do
		self:_updateTask(self._taskCfg[i], i)
	end

	goutil.setActive(self._content, true)
end

function M:_updateTask(cfg, index)
	self._id2Index[cfg.id] = index

	local comp = self._comps[index]

	if not string.nilorempty(cfg.text) then
		comp.txtContent.text = cfg.text
	else
		comp.txtContent.text = TaskUtil.parseContent(cfg.content, cfg.param)
	end

	local itemData = MasterTrainingTaskModel.instance:getTaskMo(cfg.id):getRewardItemData()
	local reward = Astral.LuaComponentContainer.Add(comp.item, ItemCell)

	reward:updateData(itemData)
	reward:setShowSelectedEffect(false)
	self:_refreshStatus(cfg.id)
end

function M:_refreshStatus(id)
	local index = self._id2Index[id]
	local comp = self._comps[index]
	local status = MasterTrainingTaskModel.instance:getStatus(id)

	if status == MasterTrainingTaskConfig.TaskState.IsReceived then
		goutil.setActive(comp.incomplete, true)
		goutil.setActive(comp.receive, false)
		goutil.setActive(comp.completed, true)
		goutil.setActive(comp.txtDone, true)
		goutil.setActive(comp.btnGo.gameObject, false)
	elseif status == MasterTrainingTaskConfig.TaskState.Doing then
		goutil.setActive(comp.incomplete, true)
		goutil.setActive(comp.receive, false)
		goutil.setActive(comp.completed, false)
		goutil.setActive(comp.txtDone, false)
		goutil.setActive(comp.btnGo.gameObject, true)
	elseif status == MasterTrainingTaskConfig.TaskState.CanReceive then
		goutil.setActive(comp.incomplete, false)
		goutil.setActive(comp.receive, true)
		goutil.setActive(comp.completed, false)
	end
end

function M:_onClickClose()
	if MasterTrainingTaskModel.instance:getCanReceive() then
		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
			isActive = true,
			key = RedDotType.ERedDotKey.MASTERTRAINING_TASK
		})
	else
		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
			isActive = false,
			key = RedDotType.ERedDotKey.MASTERTRAINING_TASK
		})
	end

	self:close()
end

return M
