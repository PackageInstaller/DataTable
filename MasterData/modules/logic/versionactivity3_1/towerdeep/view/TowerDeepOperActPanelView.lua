-- chunkname: @modules/logic/versionactivity3_1/towerdeep/view/TowerDeepOperActPanelView.lua

module("modules.logic.versionactivity3_1.towerdeep.view.TowerDeepOperActPanelView", package.seeall)

local TowerDeepOperActPanelView = class("TowerDeepOperActPanelView", BaseView)

function TowerDeepOperActPanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._txttime = gohelper.findChildText(self.viewGO, "root/simage_fullbg/#txt_time")
	self._godeep = gohelper.findChild(self.viewGO, "root/#go_deep")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_deep/title/txt_title/#btn_tips")
	self._gotips = gohelper.findChild(self.viewGO, "root/#go_deep/#go_tips")
	self._txttip = gohelper.findChildText(self.viewGO, "root/#go_deep/#go_tips/txt_tips")
	self._btnclosetips = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_deep/#go_tips/#btn_closetips")
	self._gotask1 = gohelper.findChild(self.viewGO, "root/#go_task1")
	self._gotask2 = gohelper.findChild(self.viewGO, "root/#go_task2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerDeepOperActPanelView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btntips:AddClickListener(self._btntipsOnClick, self)
	self._btnclosetips:AddClickListener(self._btnclosetipsOnClick, self)
end

function TowerDeepOperActPanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btntips:RemoveClickListener()
	self._btnclosetips:RemoveClickListener()
end

function TowerDeepOperActPanelView:_btncloseOnClick()
	self:closeThis()
end

function TowerDeepOperActPanelView:_btntipsOnClick()
	gohelper.setActive(self._gotips, true)
end

function TowerDeepOperActPanelView:_btnclosetipsOnClick()
	gohelper.setActive(self._gotips, false)
end

function TowerDeepOperActPanelView:_editableInitView()
	self._txttime.text = ""

	self:_addSelfEvents()
end

function TowerDeepOperActPanelView:_addSelfEvents()
	self.addEventCb(self, TowerDeepOperActController.instance, TowerDeepOperActEvent.onAct209InfoGet, self._refreshDeep, self)
	self.addEventCb(self, TowerDeepOperActController.instance, TowerDeepOperActEvent.OnAct209InfoUpdate, self._refreshDeep, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._refreshTaskItems, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshTaskItems, self)
end

function TowerDeepOperActPanelView:_removeSelfEvents()
	self.removeEventCb(self, TowerDeepOperActController.instance, TowerDeepOperActEvent.onAct209InfoGet, self._refreshDeep, self)
	self.removeEventCb(self, TowerDeepOperActController.instance, TowerDeepOperActEvent.OnAct209InfoUpdate, self._refreshDeep, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._refreshTaskItems, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshTaskItems, self)
end

function TowerDeepOperActPanelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_ripple_entry)

	self._actId = VersionActivity3_1Enum.ActivityId.TowerDeep
	self._taskItems = {}
	self._deepItems = {}
	self._txttip.text = CommonConfig.instance:getConstStr(ConstEnum.TowerDeepTip)

	self:_refreshTaskItems()
	self:_refreshDeep()
	self:_refreshTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

local lvStages = {
	800,
	1000
}

function TowerDeepOperActPanelView:_refreshDeep()
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

function TowerDeepOperActPanelView:_refreshTaskItems()
	local index = 1
	local taskCos = TowerDeepOperActConfig.instance:getTaskCos()

	for _, taskCo in LuaUtil.pairsByKeys(taskCos) do
		if taskCo.listenerType ~= TaskEnum.ListenerType.Act209GlobalTowerLayer then
			if not self._taskItems[taskCo.id] then
				self._taskItems[taskCo.id] = TowerDeepOperActTaskItem.New()

				self._taskItems[taskCo.id]:init(self["_gotask" .. tostring(index)], taskCo)

				index = index + 1
			end

			self._taskItems[taskCo.id]:refresh()
		end
	end
end

function TowerDeepOperActPanelView:onClose()
	return
end

function TowerDeepOperActPanelView:onDestroyView()
	self:_clearTimeTick()

	if self._taskItems then
		for _, item in pairs(self._taskItems) do
			item:destroy()
		end

		self._taskItems = nil
	end
end

function TowerDeepOperActPanelView:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function TowerDeepOperActPanelView:onRefresh()
	self:_refreshTimeTick()
end

function TowerDeepOperActPanelView:_refreshTimeTick()
	self._txttime.text = self:_getRemainTimeStr()
end

function TowerDeepOperActPanelView:_getRemainTimeStr()
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

return TowerDeepOperActPanelView
