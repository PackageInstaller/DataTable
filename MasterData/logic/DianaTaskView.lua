-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/diana/DianaTaskView.lua

module("logic.extensions.lailisi.view.diana.DianaTaskView", package.seeall)

local DianaTaskView = class("DianaTaskView", ViewComponent)

function DianaTaskView:ctor()
	DianaTaskView.super.ctor(self)
end

function DianaTaskView:unbindEvents()
	DianaTaskView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function DianaTaskView:bindEvents()
	DianaTaskView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end, self)
end

function DianaTaskView:onExit()
	DianaTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LailisiTask, self._refreshItem, self)
end

function DianaTaskView:buildUI()
	DianaTaskView.super.buildUI(self)

	self._tableView = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._closeBtn = self:getBtn("btnClose")
	self._tableScorll = ScrollerList.create(self._tableView, self._cell, GameUtil.handler(self._updateItem, self), GameUtil.handler(self._clearItemCell, self))
end

function DianaTaskView:onEnter()
	DianaTaskView.super.onEnter(self)

	self._actId = self:getFirstParam()

	local taskInfo = LailisiModel.instance:getTaskInfo(self._actId)

	self._taskCfg = LailisiConfig.instance:getTaskInfo(taskInfo.taskId)

	self:_refreshItem()
	GlobalDispatcher:addListener(GlobalNotify.LailisiTask, self._refreshItem, self)
	LailisiController.instance:setTaskRedPointState()
end

function DianaTaskView:_refreshItem()
	local taskInfos = LailisiModel.instance:getTaskDetailInfo(self._actId)
	local list = {}

	for i, v in ipairs(taskInfos) do
		local item = {}
		local cfg = self._taskCfg[v.taskNum]

		item.cfg = cfg
		item.taskInfo = v
		item.received = v.received
		item.canGet = not v.received and tonumber(v.progress) >= cfg.detectorParam
		item.noPass = tonumber(v.progress) < cfg.detectorParam

		table.insert(list, item)
	end

	table.sort(list, function(a, b)
		if a.canGet and not b.canGet then
			return true
		elseif not a.canGet and b.canGet then
			return false
		elseif a.noPass and not b.noPass then
			return true
		elseif not a.noPass and b.noPass then
			return false
		else
			return a.cfg.taskNum < b.cfg.taskNum
		end
	end)
	self._tableScorll:reloadData(list)
end

function DianaTaskView:_updateItem(view, cell, data)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtProg = goutil.findChildTextComponent(cell, "txtProg")
	local icon = goutil.findChild(cell, "icon")
	local pass = goutil.findChild(cell, "pass")
	local noPass = goutil.findChild(cell, "noPass")
	local btnGet = goutil.findChild(cell, "btnGet")
	local cfg = data.cfg

	txtDesc.text = cfg.desc

	if checknumber(data.taskInfo.progress) >= cfg.detectorParam then
		if not cfg.detectorParam then
			local curNum = data.taskInfo.progress

			txtProg.text = string.format("%s/%s", curNum, cfg.detectorParam)

			goutil.setActive(pass, data.received)
			goutil.setActive(btnGet, data.canGet)
			goutil.setActive(noPass, data.noPass)
			MaterialMgr.resetAll(icon)
			MaterialMgr.setCellByCfg(cfg.prize, icon)
			GameUtil.asBtn(btnGet):RemoveClickListener()
			GameUtil.asBtn(btnGet):AddClickListener(function()
				LailisiController.instance:sendPM_ActorGainGetTaskAwardReq(self._actId, data.taskInfo.taskNum)
			end)
		end
	end
end

function DianaTaskView:_clearItemCell()
	return
end

return DianaTaskView
