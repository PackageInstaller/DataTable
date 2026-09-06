-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitejigsaw/view/InfiniteJigsawTaskView.lua

module("logic.extensions.infinitejigsaw.view.InfiniteJigsawTaskView", package.seeall)

local InfiniteJigsawTaskView = class("InfiniteJigsawTaskView", TableViewComponent)

function InfiniteJigsawTaskView:ctor()
	InfiniteJigsawTaskView.super.ctor(self)
end

function InfiniteJigsawTaskView:buildUI()
	InfiniteJigsawTaskView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function InfiniteJigsawTaskView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableView"
	}
end

function InfiniteJigsawTaskView:bindEvents()
	InfiniteJigsawTaskView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function InfiniteJigsawTaskView:unbindEvents()
	InfiniteJigsawTaskView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function InfiniteJigsawTaskView:onEnter()
	InfiniteJigsawTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.JEGetTaskInfoRes, self._onGetTaskInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.JEGainTaskPrizeRes, self._onGainTaskPrizeRes, self)

	self._activityId = InfiniteJigsawModel.instance:getActivityId()
	self._taskPlanId = InfiniteJigsawModel.instance:getTaskPlanId()
	self._taskList = InfiniteJigsawConfig.instance:getTaskTypeList(self._taskPlanId)

	self:_updateTasks()
end

function InfiniteJigsawTaskView:onExit()
	InfiniteJigsawTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.JEGetTaskInfoRes, self._onGetTaskInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.JEGainTaskPrizeRes, self._onGainTaskPrizeRes, self)
end

function InfiniteJigsawTaskView:_onClickClose()
	self:close()
end

function InfiniteJigsawTaskView:_onGetTaskInfoRes()
	self:_updateTasks()
end

function InfiniteJigsawTaskView:_onGainTaskPrizeRes()
	self:_updateTasks()
end

function InfiniteJigsawTaskView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local btnGo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGo")
	local btnGet = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGet")
	local pass = goutil.findChild(cell, "pass")
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtProgress = goutil.findChildTextComponent(cell, "txtProgress")
	local txtShowNum = goutil.findChildTextComponent(cell, "txtShowNum")
	local jumpTo = data.jumpTo

	btnGo:AddClickListener(function()
		UIStateManager.instance:popByName(ViewName.InfiniteJigsawTaskView)
		GotoMgr.gotoByString(jumpTo)
	end)

	local activityId = self._activityId
	local taskId = data.taskId

	btnGet:AddClickListener(function()
		JigsawExchangeAgent.instance:sendPM_JEGainTaskPrizeReq(activityId, taskId)
	end)

	txtTitle.text = data.title
	txtDesc.text = data.desc
	txtProgress.text = string.format("%d/%d", InfiniteJigsawModel.instance:curTaskProgress(taskId), data.maxProgress)

	local isTaskFinished = InfiniteJigsawModel.instance:isTaskFinished(taskId, data.maxProgress)
	local isGainTaskPrize = InfiniteJigsawModel.instance:isTaskPrizeGained(taskId)

	goutil.setActive(pass, isTaskFinished and isGainTaskPrize)
	goutil.setActive(txtProgress.gameObject, not isTaskFinished)
	goutil.setActive(btnGo.gameObject, not isTaskFinished)
	goutil.setActive(btnGet.gameObject, isTaskFinished and not isGainTaskPrize)
	MaterialMgr.setCellByCfg(data.prize, item)
end

function InfiniteJigsawTaskView:_clearTableview(cell)
	local item = goutil.findChild(cell, "item")
	local btnGo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGo")
	local btnGet = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGet")

	btnGo:RemoveClickListener()
	btnGet:RemoveClickListener()
	MaterialMgr.resetAll(item)
end

function InfiniteJigsawTaskView:_updateTasks()
	local list = {}

	for i, vlist in ipairs(self._taskList) do
		local count = #vlist

		for index, cfg in ipairs(vlist) do
			local isTaskFinished = InfiniteJigsawModel.instance:isTaskFinished(cfg.taskId, cfg.maxProgress)

			if not isTaskFinished or index == count then
				table.insert(list, cfg)

				break
			end

			if isTaskFinished then
				local isGainTaskPrize = InfiniteJigsawModel.instance:isTaskPrizeGained(cfg.taskId)

				if not isGainTaskPrize then
					table.insert(list, cfg)

					break
				end
			end
		end
	end

	self:updateListData(list)
end

return InfiniteJigsawTaskView
