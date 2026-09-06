-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskTestView.lua

module("logic.extensions.task.view.TaskTestView", package.seeall)

local TaskTestView = class("TaskTestView", ViewComponent)

function TaskTestView:buildUI()
	self._tableView = self:getGo("ScrollView"):GetComponent("UITableview")
	self._tableCell = self:getGo("Cell")
	self._closeButton = self:getBtn("Close")

	self._tableCell:SetActive(false)

	self._inputField = Framework.InputFieldAdapter.GetFrom(self.mainGO, "InputField")
	self._input = self._inputField.input
end

function TaskTestView:destroyUI()
	return
end

function TaskTestView:onEnter()
	self._tableView:RegisterCallback(self._numTasksInView, self._taskCellSizeInView, self._taskCellAtIndex, self)
	self._tableView:SetOffsetWithoutRefresh(0)

	self._taskConfigs = TaskConfig.instance:getAllTaskCoes()
	self._currTaskes = self._taskConfigs

	self._closeButton:AddClickListener(self._onClickCloseButton, self)
	self._inputField:AddOnValueChanged(self._onInputValueChange, self)
	self._tableView:ReloadData()
end

function TaskTestView:onExit()
	self._closeButton:RemoveClickListener()
	self._tableView:UnRegisterAllCallbacks()
	self._inputField:RemoveOnValueChanged()
	self._tableView:Travel(self._clearButtons, self)
end

function TaskTestView:_numTasksInView()
	if self._currTaskes then
		return #self._currTaskes
	end

	return 0
end

function TaskTestView:_taskCellSizeInView()
	return 580, 100
end

function TaskTestView:_taskCellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local taskCo = self._currTaskes[idx + 1]
	local name = goutil.findChild(cell, "Text"):GetComponent("Text")
	local gotoBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Button")

	gotoBtn:AddClickListener(function()
		TaskController.instance:startTestTask(taskCo.taskId)
	end)

	name.text = "[" .. taskCo.name .. "]" .. "   ID:" .. taskCo.taskId

	return cell
end

function TaskTestView:_onClickCloseButton()
	self:close()
end

function TaskTestView:_onInputValueChange()
	if not self._taskConfigs then
		return
	end

	if not self._input.text or #self._input.text == 0 then
		self._currTaskes = self._taskConfigs
	else
		self._currTaskes = {}

		local taskId

		if pcall(tonumber, self._input.text) then
			taskId = tonumber(self._input.text)
		end

		for i = 1, #self._taskConfigs do
			if taskId then
				if self._taskConfigs[i].taskId == taskId then
					self._currTaskes[#self._currTaskes + 1] = self._taskConfigs[i]
				end
			elseif self._taskConfigs[i].name and string.find(self._taskConfigs[i].name, self._input.text) then
				self._currTaskes[#self._currTaskes + 1] = self._taskConfigs[i]
			end
		end
	end

	self._tableView:ReloadData()
end

function TaskTestView:_clearButtons(cell)
	local btnGoto = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Button")

	btnGoto:RemoveClickListener()
end

return TaskTestView
