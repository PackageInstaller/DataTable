-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesswaken/view/GoddessWakenTaskView.lua

module("logic.extensions.goddesswaken.view.GoddessWakenTaskView", package.seeall)

local GoddessWakenTaskView = class("GoddessWakenTaskView", TableViewComponent)

function GoddessWakenTaskView:buildUI()
	GoddessWakenTaskView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._bg = self:getGo("bg")
end

function GoddessWakenTaskView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function GoddessWakenTaskView:bindEvents()
	GoddessWakenTaskView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function GoddessWakenTaskView:unbindEvents()
	GoddessWakenTaskView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function GoddessWakenTaskView:onEnter()
	GoddessWakenTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessWakenGainTaskPrize, self._onGainTaskPrize, self)

	self._goddessId = self:getFirstParam()
	self._activityId = GoddessWakenModel.instance:getActivityId()
	self._taskPlanId = GoddessWakenModel.instance:getTaskPlanId()
	self._petPlanId = GoddessWakenModel.instance:getPetPlanId()
	self._taskList = GoddessWakenConfig.instance:getTaskTypeList(self._taskPlanId)

	self:_loadBgImage()
	self:_updateTasks()
end

function GoddessWakenTaskView:onExit()
	GoddessWakenTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessWakenGainTaskPrize, self._onGainTaskPrize, self)
end

function GoddessWakenTaskView:onExitFinished()
	self:_clearBgImage()
end

function GoddessWakenTaskView:_onClickClose()
	self:close()
end

function GoddessWakenTaskView:_onGainTaskPrize()
	self:_updateTasks()
end

function GoddessWakenTaskView:_updateCell(view, cell, data)
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local item1 = goutil.findChild(cell, "item1")
	local item2 = goutil.findChild(cell, "item2")
	local geted = goutil.findChild(cell, "geted")
	local btnCanGet = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnCanGet")
	local btnGo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGo")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local txtDuration = goutil.findChildTextComponent(cell, "txtTitle/txtDuration")
	local colorChange = goutil.findChild(cell, "bg"):GetComponent(typeof(UIImageColorChange))
	local spriteChange = goutil.findChild(cell, "bg"):GetComponent(typeof(UIImageSpriteChange))
	local invalid = goutil.findChild(cell, "invalid")
	local activityId = self._activityId
	local taskId = data.cfg.taskId

	btnCanGet:AddClickListener(function()
		GoddessWakenAgent:sendPM_GoddessWakenGainTaskPrizeReq(activityId, taskId)
	end)

	local jumpTo = data.cfg.jumpTo

	btnGo:AddClickListener(function()
		UIStateManager.instance:popByName(ViewName.GoddessWakenTaskView)
		GotoMgr.gotoByString(jumpTo)
	end)

	txtTitle.text = data.cfg.title
	txtDesc.text = data.cfg.desc

	local isTaskFinished = GoddessWakenModel.instance:isTaskFinished(taskId, data.cfg.maxProgress)
	local isGainTaskPrize = GoddessWakenModel.instance:isTaskPrizeGained(taskId)

	if data.isInTime then
		goutil.setActive(geted, isTaskFinished and isGainTaskPrize)
		goutil.setActive(txtNum.gameObject, not isTaskFinished)
		goutil.setActive(btnGo.gameObject, not isTaskFinished)
		goutil.setActive(btnCanGet.gameObject, isTaskFinished and not isGainTaskPrize)
	else
		goutil.setActive(geted, false)
		goutil.setActive(txtNum.gameObject, false)
		goutil.setActive(btnGo.gameObject, false)
		goutil.setActive(btnCanGet.gameObject, false)
	end

	txtNum.text = string.format("%d/%d", GoddessWakenModel.instance:curTaskProgress(taskId), data.cfg.maxProgress)

	MaterialMgr.resetAll(item1)
	MaterialMgr.resetAll(item2)

	if not string.nilorempty(data.cfg.prize) then
		local strList = string.split(data.cfg.prize, "#")

		if strList[1] then
			local proxy = MaterialMgr.setCellByCfg(strList[1], item1)

			if proxy then
				proxy.binder:SetGray(not data.isInTime)
				proxy.binder:setEffStatus(data.isInTime)
			end
		end

		if strList[2] then
			local proxy = MaterialMgr.setCellByCfg(strList[2], item2)

			if proxy then
				proxy.binder:SetGray(not data.isInTime)
				proxy.binder:setEffStatus(data.isInTime)
			end
		end
	end

	local dateStart = GameUtil.string2date(data.cfg.startTime)
	local dateEnd = GameUtil.string2date(data.cfg.endTime)

	txtDuration.text = string.format("(%02d.%02d 5:00 - %02d.%02d 5:00)", dateStart.month, dateStart.day, dateEnd.month, dateEnd.day)

	colorChange:SetState(data.isInTime and 0 or 1)
	spriteChange:SetState(self._goddessId - 1)
	goutil.setActive(invalid, not data.isInTime)
end

function GoddessWakenTaskView:_clearTableview(cell)
	local btnCanGet = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnCanGet")
	local btnGo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGo")
	local item1 = goutil.findChild(cell, "item1")
	local item2 = goutil.findChild(cell, "item2")

	btnCanGet:RemoveClickListener()
	btnGo:RemoveClickListener()
	MaterialMgr.resetAll(item1)
	MaterialMgr.resetAll(item2)
end

function GoddessWakenTaskView:_updateTasks()
	local list = {}

	for i, vlist in ipairs(self._taskList) do
		local count = #vlist

		for index, cfg in ipairs(vlist) do
			local isTaskFinished = GoddessWakenModel.instance:isTaskFinished(cfg.taskId, cfg.maxProgress)

			if not isTaskFinished or index == count then
				table.insert(list, cfg)

				break
			end

			if isTaskFinished then
				local isGainTaskPrize = GoddessWakenModel.instance:isTaskPrizeGained(cfg.taskId)

				if not isGainTaskPrize then
					table.insert(list, cfg)

					break
				end
			end
		end
	end

	list = self:_sortTasks(list)

	self:updateListData(list)
end

function GoddessWakenTaskView:_sortTasks(taskList)
	local list = {}

	for i, v in ipairs(taskList) do
		local element = {}

		element.cfg = v
		element.isInTime = GameUtil.checkIsInTimePeriod(v.startTime, v.endTime)
		element.sortIndex = element.isInTime and 0 or 1

		table.insert(list, element)
	end

	table.sort(list, function(a, b)
		return a.sortIndex < b.sortIndex
	end)

	return list
end

function GoddessWakenTaskView:_loadBgImage()
	local cfg = GoddessWakenConfig.instance:getUICfg(self._petPlanId, self._goddessId)

	if cfg then
		local path = string.format("ui/bigbg/goddesswaken/%s.png", cfg.taskBgName)

		uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, path)
	end
end

function GoddessWakenTaskView:_clearBgImage()
	uGuiUtil.clearImage(self._bg)
end

return GoddessWakenTaskView
