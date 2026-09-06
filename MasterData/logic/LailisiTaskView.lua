-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/LailisiTaskView.lua

module("logic.extensions.lailisi.view.LailisiTaskView", package.seeall)

local LailisiTaskView = class("LailisiTaskView", ViewComponent)

function LailisiTaskView:ctor()
	LailisiTaskView.super.ctor(self)
end

function LailisiTaskView:unbindEvents()
	LailisiTaskView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function LailisiTaskView:bindEvents()
	LailisiTaskView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end, self)
end

function LailisiTaskView:onExit()
	LailisiTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LailisiTask, self._refreshItem, self)
end

function LailisiTaskView:buildUI()
	LailisiTaskView.super.buildUI(self)

	self._tableView = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._closeBtn = self:getBtn("btnClose")
	self._tableScorll = ScrollerList.create(self._tableView, self._cell, GameUtil.handler(self._updateItem, self), GameUtil.handler(self._clearItemCell, self))
end

function LailisiTaskView:onEnter()
	LailisiTaskView.super.onEnter(self)

	self._actId = self:getFirstParam()

	local taskInfo = LailisiModel.instance:getTaskInfo(self._actId)

	self._taskCfg = LailisiConfig.instance:getTaskInfo(taskInfo.taskId)

	local cfg = LailisiModel.instance:getTaskDetailInfo(self._actId)

	self._tableScorll:reloadData(cfg)
	GlobalDispatcher:addListener(GlobalNotify.LailisiTask, self._refreshItem, self)
	LailisiController.instance:setTaskRedPointState()
end

function LailisiTaskView:_refreshItem()
	local taskInfo = LailisiModel.instance:getTaskDetailInfo(self._actId)

	self._tableScorll:reloadData(taskInfo)
end

function LailisiTaskView:_updateItem(view, cell, data)
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

function LailisiTaskView:_clearItemCell()
	return
end

return LailisiTaskView
