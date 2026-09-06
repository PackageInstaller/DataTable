-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkonguniontaskView.lua

module("logic.extensions.chuangkongunion.view.ChuangkonguniontaskView", package.seeall)

local ChuangkonguniontaskView = class("ChuangkonguniontaskView", ViewComponent)

function ChuangkonguniontaskView:ctor()
	ChuangkonguniontaskView.super.ctor(self)

	self._cfg = ChuangkongunionConfig.instance:getTaskCfg(ChuangkongunionModel.instance:getActId())
end

function ChuangkonguniontaskView:unbindEvents()
	ChuangkonguniontaskView.super.unbindEvents(self)
end

function ChuangkonguniontaskView:bindEvents()
	ChuangkonguniontaskView.super.bindEvents(self)

	for i = 1, #self._cfg do
		GameUtil.addClickHandler(self._cells[i].mainGo, GameUtil.handler(self._onClickCell, self, self._cfg[i]))
	end
end

function ChuangkonguniontaskView:buildUI()
	ChuangkonguniontaskView.super.buildUI(self)

	self._cells = {}

	local cell

	for i = 1, #self._cfg do
		self._cells[i] = {
			mainGo = self:getGo("cell" .. i),
			select = self:getGo("cell" .. i .. "/select"),
			txtName = self:getTxt("cell" .. i .. "/txtName"),
			txtChapter = self:getTxt("cell" .. i .. "/txtChapter"),
			pass = self:getGo("cell" .. i .. "/txtPass"),
			lock = self:getGo("cell" .. i .. "/lock"),
			redPoint = self:getGo("cell" .. i .. "/imgPoint")
		}
	end
end

function ChuangkonguniontaskView:onExit()
	ChuangkongunionController.instance:unregisterNotify(ChuangkongunionController.DATA_CHANGE, self.updateUI, self)
	ChuangkonguniontaskView.super.onExit(self)
end

function ChuangkonguniontaskView:onEnter()
	ChuangkonguniontaskView.super.onEnter(self)
	ChuangkongunionController.instance:registerNotify(ChuangkongunionController.DATA_CHANGE, self.updateUI, self)
	ChuangkongunionController.instance:getTaskInfo()
	self:updateUI()
end

function ChuangkonguniontaskView:_onClickCell(cfg)
	local isFinish = ChuangkongunionModel.instance:isFinishTask(cfg.taskId)
	local isOpen = ChuangkongunionModel.instance:isOpenTask(cfg.taskId)
	local isCanDo = ChuangkongunionModel.instance:isCanDoTask(cfg.taskId)

	if not isOpen then
		FloatWordMgr.instance:show("任务未开启")

		return
	elseif isFinish then
		FloatWordMgr.instance:show("任务已完成")

		return
	elseif not isCanDo then
		FloatWordMgr.instance:show("请先完成上一个关卡")

		return
	end

	UIStateManager.instance:open(ViewName.ChuangkongunionstageView, ChuangkongunionstageView.TYPE_TASK, cfg.taskId)
end

function ChuangkonguniontaskView:updateUI()
	local cell, cfg

	for i = 1, #self._cfg do
		self._cells[i].txtName.text = self._cfg[i].title
		self._cells[i].txtChapter.text = self._cfg[i].taskId

		if ChuangkongunionModel.instance:isFinishTask(self._cfg[i].taskId) then
			goutil.setActive(self._cells[i].lock, false)
			goutil.setActive(self._cells[i].redPoint, false)
			goutil.setActive(self._cells[i].pass, true)
		elseif ChuangkongunionModel.instance:isOpenTask(self._cfg[i].taskId) and ChuangkongunionModel.instance:isCanDoTask(self._cfg[i].taskId) then
			goutil.setActive(self._cells[i].lock, false)
			goutil.setActive(self._cells[i].pass, false)
			goutil.setActive(self._cells[i].redPoint, true)
		else
			goutil.setActive(self._cells[i].lock, true)
			goutil.setActive(self._cells[i].pass, false)
			goutil.setActive(self._cells[i].redPoint, false)
		end
	end
end

return ChuangkonguniontaskView
