-- chunkname: @modules/logic/versionactivity3_1/towerdeep/view/TowerDeepOperActFullView.lua

module("modules.logic.versionactivity3_1.towerdeep.view.TowerDeepOperActFullView", package.seeall)

local TowerDeepOperActFullView = class("TowerDeepOperActFullView", BaseView)

function TowerDeepOperActFullView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "root/simage_fullbg/#txt_time")
	self._godeep = gohelper.findChild(self.viewGO, "root/#go_deep")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_deep/title/txt_title/#btn_tips")
	self._gotips = gohelper.findChild(self.viewGO, "root/#go_deep/#go_tips")
	self._txttip = gohelper.findChildText(self.viewGO, "root/#go_deep/#go_tips/txt_tips")
	self._btnclosetips = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_deep/#go_tips/#btn_closetips")
	self._gotask1 = gohelper.findChild(self.viewGO, "root/#go_task1")
	self._gotask2 = gohelper.findChild(self.viewGO, "root/#go_task2")
	self._gotask3 = gohelper.findChild(self.viewGO, "root/#go_task3")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_goto")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerDeepOperActFullView:addEvents()
	self._btntips:AddClickListener(self._btntipsOnClick, self)
	self._btnclosetips:AddClickListener(self._btnclosetipsOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
end

function TowerDeepOperActFullView:removeEvents()
	self._btntips:RemoveClickListener()
	self._btnclosetips:RemoveClickListener()
	self._btngoto:RemoveClickListener()
end

function TowerDeepOperActFullView:_btntipsOnClick()
	gohelper.setActive(self._gotips, true)
end

function TowerDeepOperActFullView:_btnclosetipsOnClick()
	gohelper.setActive(self._gotips, false)
end

function TowerDeepOperActFullView:_btngotoOnClick()
	GameFacade.jump(JumpEnum.JumpView.TowerDeepOperAct)
end

function TowerDeepOperActFullView:_editableInitView()
	self._txttime.text = ""

	self:_addSelfEvents()
end

function TowerDeepOperActFullView:_addSelfEvents()
	self.addEventCb(self, TowerDeepOperActController.instance, TowerDeepOperActEvent.onAct209InfoGet, self._refreshDeep, self)
	self.addEventCb(self, TowerDeepOperActController.instance, TowerDeepOperActEvent.OnAct209InfoUpdate, self._refreshDeep, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._refreshTaskItems, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshTaskItems, self)
end

function TowerDeepOperActFullView:_removeSelfEvents()
	self.removeEventCb(self, TowerDeepOperActController.instance, TowerDeepOperActEvent.onAct209InfoGet, self._refreshDeep, self)
	self.removeEventCb(self, TowerDeepOperActController.instance, TowerDeepOperActEvent.OnAct209InfoUpdate, self._refreshDeep, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._refreshTaskItems, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshTaskItems, self)
end

function TowerDeepOperActFullView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_ripple_entry)

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = VersionActivity3_1Enum.ActivityId.TowerDeep
	self._taskItems = {}
	self._deepItems = {}
	self._txttip.text = CommonConfig.instance:getConstStr(ConstEnum.TowerDeepTip)

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TowerDeep
	}, self._onGetTaskInfo, self)
	self:_refreshDeep()
	self:_refreshTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

local lvStages = {
	800,
	1000
}

function TowerDeepOperActFullView:_refreshDeep()
	local maxLayer = TowerDeepOperActModel.instance:getMaxLayer()
	local stage = 1

	for i = 1, 2 do
		if maxLayer >= lvStages[i] then
			stage = i + 1
		end
	end

	for i = 1, 3 do
		if not self._deepItems[i] then
			self._deepItems[i] = {}
			self._deepItems[i].go = gohelper.findChild(self.viewGO, "root/#go_deep/deep" .. tostring(i))
			self._deepItems[i].txt = gohelper.findChildText(self.viewGO, string.format("root/#go_deep/deep%s/#txt_deep_%s", tostring(i), tostring(i)))
		end

		gohelper.setActive(self._deepItems[i].go, stage == i)

		if stage == i then
			self._deepItems[i].txt.text = maxLayer
		end
	end
end

function TowerDeepOperActFullView:_onGetTaskInfo(cmd, resultCode, msg)
	Activity209Rpc.instance:sendGetAct209InfoRequest(self._actId, self._refreshTaskItems, self)
end

function TowerDeepOperActFullView:_refreshTaskItems()
	self._taskIndex = 1

	local taskCos = TowerDeepOperActConfig.instance:getTaskCos()

	if self._taskItems then
		for _, item in pairs(self._taskItems) do
			item:destroy()
		end

		self._taskItems = {}
	end

	for _, taskCo in LuaUtil.pairsByKeys(taskCos) do
		local isFinished = TowerDeepOperActModel.instance:isTaskFinished(taskCo.id)
		local nextTask = TowerDeepOperActModel.instance:getNextTaskId(taskCo.id)

		if nextTask and nextTask ~= 0 then
			if not isFinished then
				self:_createOrResetTaskItem(taskCo.id, self._taskIndex)
			end
		elseif LuaUtil.isEmptyStr(taskCo.prepose) then
			self:_createOrResetTaskItem(taskCo.id, self._taskIndex)
		else
			local isPreFinished = TowerDeepOperActModel.instance:isTaskFinished(tonumber(taskCo.prepose))

			if isPreFinished then
				self:_createOrResetTaskItem(taskCo.id, self._taskIndex)
			end
		end
	end
end

function TowerDeepOperActFullView:_createOrResetTaskItem(taskId, index)
	if not self._taskItems[taskId] then
		self._taskItems[taskId] = TowerDeepOperActTaskItem.New()

		local taskCo = TowerDeepOperActConfig.instance:getTaskCO(taskId)

		self._taskItems[taskCo.id]:init(self["_gotask" .. tostring(index)], taskCo)

		self._taskIndex = index + 1
	end

	self._taskItems[taskId]:refresh()
end

function TowerDeepOperActFullView:onClose()
	return
end

function TowerDeepOperActFullView:onDestroyView()
	self:_removeSelfEvents()
	self:_clearTimeTick()

	if self._taskItems then
		for _, item in pairs(self._taskItems) do
			item:destroy()
		end

		self._taskItems = nil
	end
end

function TowerDeepOperActFullView:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function TowerDeepOperActFullView:onRefresh()
	self:_refreshTimeTick()
end

function TowerDeepOperActFullView:_refreshTimeTick()
	self._txttime.text = self:_getRemainTimeStr()
end

function TowerDeepOperActFullView:_getRemainTimeStr()
	local remainTimeSec = ActivityModel.instance:getRemainTimeSec(self._actId) or 0

	if remainTimeSec <= 0 then
		return luaLang("turnback_end")
	end

	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(remainTimeSec)

	if day > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			day,
			hour
		})
	elseif hour > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			hour,
			min
		})
	elseif min > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			min
		})
	elseif sec > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

return TowerDeepOperActFullView
