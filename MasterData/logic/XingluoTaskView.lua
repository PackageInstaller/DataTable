-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/xingluo/XingluoTaskView.lua

module("logic.extensions.lailisi.view.xingluo.XingluoTaskView", package.seeall)

local XingluoTaskView = class("XingluoTaskView", ViewComponent)

function XingluoTaskView:ctor()
	XingluoTaskView.super.ctor(self)
end

function XingluoTaskView:unbindEvents()
	XingluoTaskView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function XingluoTaskView:bindEvents()
	XingluoTaskView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end, self)
end

function XingluoTaskView:onExit()
	XingluoTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LailisiTask, self._refreshItem, self)
end

function XingluoTaskView:buildUI()
	XingluoTaskView.super.buildUI(self)

	self._tableView = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._closeBtn = self:getBtn("btnClose")
	self._tableScorll = ScrollerList.create(self._tableView, self._cell, GameUtil.handler(self._updateItem, self), GameUtil.handler(self._clearItemCell, self))
end

function XingluoTaskView:onEnter()
	XingluoTaskView.super.onEnter(self)

	self._actId = self:getFirstParam()

	local taskInfo = LailisiModel.instance:getTaskInfo(self._actId)

	self._taskCfg = LailisiConfig.instance:getTaskInfo(taskInfo.taskId)

	local cfg = LailisiModel.instance:getTaskDetailInfo(self._actId)
	local tasks = self:getTaskInfo(cfg)

	self._tableScorll:reloadData(tasks)
	GlobalDispatcher:addListener(GlobalNotify.LailisiTask, self._refreshItem, self)
	LailisiController.instance:setTaskRedPointState()
end

function XingluoTaskView:_refreshItem()
	local taskInfo = LailisiModel.instance:getTaskDetailInfo(self._actId)
	local tasks = self:getTaskInfo(taskInfo)

	self._tableScorll:reloadData(tasks)
end

function XingluoTaskView:_updateItem(view, cell, data)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtProg = goutil.findChildTextComponent(cell, "txtProg")
	local icon = goutil.findChild(cell, "icon")
	local pass = goutil.findChild(cell, "pass")
	local noPass = goutil.findChild(cell, "noPass")
	local btnGet = goutil.findChild(cell, "btnGet")
	local cfg = self._taskCfg[data.taskNum]

	txtDesc.text = cfg.desc
	txtProg.text = string.format("%s/%s", data.progress, cfg.detectorParam)

	goutil.setActive(pass, data.received)
	goutil.setActive(btnGet, not data.received and tonumber(data.progress) >= cfg.detectorParam)
	goutil.setActive(noPass, tonumber(data.progress) < cfg.detectorParam)
	MaterialMgr.resetAll(icon)
	MaterialMgr.setCellByCfg(cfg.prize, icon)
	GameUtil.asBtn(btnGet):RemoveClickListener()
	GameUtil.asBtn(btnGet):AddClickListener(function()
		LailisiController.instance:sendPM_ActorGainGetTaskAwardReq(self._actId, data.taskNum)
	end)
end

function XingluoTaskView:_clearItemCell()
	return
end

function XingluoTaskView:getTaskInfo(taskInfo)
	local list = {}

	for i, v in ipairs(taskInfo) do
		local cfg = self._taskCfg[v.taskNum]

		cfg.received = v.received
		cfg.progress = tonumber(v.progress)
		cfg.state = v.received and 3 or cfg.progress >= cfg.detectorParam and 1 or 2

		if not list[cfg.taskType] then
			list[cfg.taskType] = cfg
		elseif list[cfg.taskType].received and cfg.taskNum > list[cfg.taskType].taskNum then
			list[cfg.taskType] = cfg
		elseif not list[cfg.taskType].received and cfg.taskNum < list[cfg.taskType].taskNum then
			list[cfg.taskType] = cfg
		end
	end

	local tasks = {}

	for i, v in pairs(list) do
		table.insert(tasks, v)
	end

	table.sort(tasks, function(a, b)
		if a.state == b.state then
			return a.taskNum < b.taskNum
		end

		return a.state < b.state
	end)

	return tasks
end

return XingluoTaskView
