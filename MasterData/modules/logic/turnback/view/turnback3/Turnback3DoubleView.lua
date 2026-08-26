-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3DoubleView.lua

module("modules.logic.turnback.view.turnback3.Turnback3DoubleView", package.seeall)

local Turnback3DoubleView = class("Turnback3DoubleView", BaseView)

function Turnback3DoubleView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_fullbg")
	self._btlichizingo = gohelper.findChildButtonWithAudio(self.viewGO, "root/lichizi/item/#btn_go")
	self._btndongxigo = gohelper.findChildButtonWithAudio(self.viewGO, "root/dongxi/item/#btn_go")
	self._btnweichengo = gohelper.findChildButtonWithAudio(self.viewGO, "root/weichen/item/#btn_go")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "root/right/#simage_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/right/#txt_desc")
	self._txtdouble = gohelper.findChildText(self.viewGO, "root/right/go_info/go_double/#txt_double")
	self._txttimes = gohelper.findChildText(self.viewGO, "root/right/go_info/go_double/#txt_times")
	self._txttotal = gohelper.findChildText(self.viewGO, "root/right/go_info/go_total/#txt_totalday")
	self._txttotalday = gohelper.findChildText(self.viewGO, "root/right/go_info/go_total/#txt_totalday")
	self._txtactiivitytimes = gohelper.findChildText(self.viewGO, "root/right/timebgmask/timebg/#txt_actiivitytimes")
	self._imgfill = gohelper.findChildImage(self.viewGO, "root/right/rewardlist/progressbg/fill")
	self._goitem = gohelper.findChild(self.viewGO, "root/right/rewardlist/item")
	self._btnhelp = gohelper.findChildButton(self.viewGO, "root/#btn_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3DoubleView:addEvents()
	self._btlichizingo:AddClickListener(self._btlichizingoOnClick, self)
	self._btndongxigo:AddClickListener(self._btndongxigoOnClick, self)
	self._btnweichengo:AddClickListener(self._btnweichengoOnClick, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self.refreshUI, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self._btnhelp:AddClickListener(self._onClickHelpBtn, self)
end

function Turnback3DoubleView:removeEvents()
	self._btlichizingo:RemoveClickListener()
	self._btndongxigo:RemoveClickListener()
	self._btnweichengo:RemoveClickListener()
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self.refreshUI, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)

	for index, item in ipairs(self._searchItemList) do
		item.btnclick:RemoveClickListener()
	end

	self._btnhelp:RemoveClickListener()
end

function Turnback3DoubleView:_onClickHelpBtn()
	HelpController.instance:openBpRuleTipsView(luaLang("Turnback3DoubleViewTipTitle"), "Rule Details", luaLang("Turnback3DoubleViewTipContent"))
end

function Turnback3DoubleView:_btlichizingoOnClick()
	GameFacade.jump(JumpEnum.JumpView.ZhuBi)
end

function Turnback3DoubleView:_btndongxigoOnClick()
	GameFacade.jump(JumpEnum.JumpView.Rewind)
end

function Turnback3DoubleView:_btnweichengoOnClick()
	GameFacade.jump(JumpEnum.JumpView.WeiCheng)
end

function Turnback3DoubleView:_onFinishTask()
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
end

function Turnback3DoubleView:_editableInitView()
	self._searchItemList = {}

	for i = 1, 3 do
		local item = self:getUserDataTb_()

		item.index = i

		local parentGO = gohelper.findChild(self.viewGO, "root/right/rewardlist/pos" .. i)

		item.go = gohelper.clone(self._goitem, parentGO, "icon" .. i)

		gohelper.setActive(item.go, true)

		item.golock = gohelper.findChild(item.go, "#golock")
		item.gohasget = gohelper.findChild(item.go, "#goHasGet")
		item.gocanget = gohelper.findChild(item.go, "#go_canget")
		item.btnclick = gohelper.findChildButton(item.go, "#go_canget/#btn_click")
		item.goIcon = gohelper.findChild(item.go, "#go_icon")
		item.txttime = gohelper.findChildText(item.go, "#txt_point")

		table.insert(self._searchItemList, item)
	end
end

function Turnback3DoubleView:_initSearchItem()
	self.coList = TurnbackConfig.instance:getSearchTaskCoList(self._turnbackId)

	for index, co in ipairs(self.coList) do
		local item = self._searchItemList[index]

		item.config = co

		local rewardco = string.splitToNumber(co.bonus, "#")
		local type, id, num = rewardco[1], rewardco[2], rewardco[3]

		item.iconComp = IconMgr.instance:getCommonPropItemIcon(item.goIcon)

		item.iconComp:setMOValue(type, id, num, nil, true)
		item.iconComp:setCountFontSize(48)
		item.btnclick:AddClickListener(self._onClickSearchReward, self, item)

		item.txttime.text = co.maxProgress / 60 .. luaLang("time_minute")
	end

	self._allSearchTime = self.coList[#self.coList].maxProgress
end

function Turnback3DoubleView:_onClickSearchReward(item)
	TaskRpc.instance:sendFinishTaskRequest(item.config.id)
end

function Turnback3DoubleView:_getEndTime()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()
	local additionalDurationDays = TurnbackConfig.instance:getAdditionDurationDays(turnbackId)
	local mo = TurnbackModel.instance:getCurTurnbackMo()

	return mo.startTime + additionalDurationDays * TimeUtil.OneDaySecond
end

function Turnback3DoubleView:_getSeacrhEndTime()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()
	local onlineDurationDays = TurnbackConfig.instance:getOnlineDurationDays(turnbackId)
	local mo = TurnbackModel.instance:getCurTurnbackMo()

	return mo.startTime + onlineDurationDays * TimeUtil.OneDaySecond
end

function Turnback3DoubleView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._turnbackId = TurnbackModel.instance:getCurTurnbackId()
	self.config = TurnbackConfig.instance:getTurnbackSubModuleCo(self.viewParam.actId)

	TurnbackRpc.instance:sendGetTurnbackInfoRequest()

	self.endTime = self:_getEndTime()
	self.searchEndTime = self:_getSeacrhEndTime()

	self:_initSearchItem()
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_02)
end

function Turnback3DoubleView:_onDailyRefresh()
	TurnbackRpc.instance:sendGetTurnbackInfoRequest(self.refreshUI, self)
end

function Turnback3DoubleView:refreshUI()
	local remainCount, totalCount = TurnbackModel.instance:getAdditionCountInfo()
	local remainStr = "#FFB36F"

	self._txttotalday.text = string.format("<color=%s>%s</color>/%s", remainStr, remainCount, totalCount)

	self:_refreshSearchItem()
	self:_refreshRemainTime()
	self:_updateFill()
end

function Turnback3DoubleView:_refreshRemainTime()
	self._txttimes.text = TurnbackController.instance:refreshRemainTime(self.endTime)
	self._txtactiivitytimes.text = TurnbackController.instance:refreshRemainTime(self.searchEndTime)

	local searchday, searchhour, searchminute = TurnbackModel.instance:getRemainTime(self.searchEndTime)
	local day, hour, minute = TurnbackModel.instance:getRemainTime(self.endTime)

	if searchday < 0 then
		self:_onCloseSearch()
	end

	local isPass = day < 0 or not TurnbackModel.instance:isInOpenTime()
end

function Turnback3DoubleView:_refreshSearchItem()
	local needlock = false

	for _, item in ipairs(self._searchItemList) do
		gohelper.setActive(item.btnclick.gameObject, true)

		local taskmo = TurnbackTaskModel.instance:getSearchTaskMoById(item.config.id)

		item.taskmo = taskmo

		if taskmo then
			gohelper.setActive(item.golock, needlock)

			if not needlock then
				if taskmo.finishCount > 0 then
					gohelper.setActive(item.gocanget, false)
					gohelper.setActive(item.gohasget, true)
					gohelper.setActive(item.golock, false)
				elseif self:checkFinishedTask(taskmo) then
					gohelper.setActive(item.gocanget, true)
					gohelper.setActive(item.gohasget, false)
					gohelper.setActive(item.golock, false)
				else
					gohelper.setActive(item.gocanget, false)
					gohelper.setActive(item.gohasget, false)
					gohelper.setActive(item.golock, true)

					self._perMaxTime = taskmo.config.maxProgress
					self.remainsearchtime = taskmo.config.maxProgress - taskmo.progress
					self._currentitem = item

					TaskDispatcher.runRepeat(self._updateSearchRemainTime, self, 1)

					needlock = true
				end
			else
				gohelper.setActive(item.golock, true)
				gohelper.setActive(item.gocanget, false)
				gohelper.setActive(item.gohasget, false)
			end
		else
			local needlock = true

			gohelper.setActive(item.golock, needlock)
			gohelper.setActive(item.btnclick.gameObject, not needlock)
		end
	end
end

function Turnback3DoubleView:checkFinishedTask(taskMo)
	if taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 then
		return true
	end

	return false
end

function Turnback3DoubleView:_updateSearchRemainTime()
	if not self._currentitem or not self.remainsearchtime then
		return
	end

	self.remainsearchtime = self.remainsearchtime - 1

	if self.remainsearchtime > 0 then
		local curTime = self._perMaxTime - self.remainsearchtime

		self._imgfill.fillAmount = curTime / self._allSearchTime
	else
		TurnbackRpc.instance:sendGetTurnbackInfoRequest()
		TaskDispatcher.cancelTask(self._updateSearchRemainTime, self)
	end
end

function Turnback3DoubleView:_onCloseSearch()
	self:_lockAllSearchItem()

	self._imgfill.fillAmount = 0
end

function Turnback3DoubleView:_lockAllSearchItem()
	for _, item in ipairs(self._searchItemList) do
		gohelper.setActive(item.golock, true)
		gohelper.setActive(item.gocanget, false)
		gohelper.setActive(item.gohasget, false)
	end
end

function Turnback3DoubleView:_updateFill()
	local hadTime = 0

	for index, item in ipairs(self._searchItemList) do
		local taskmo = TurnbackTaskModel.instance:getSearchTaskMoById(item.config.id)

		if taskmo and taskmo.progress and taskmo.progress ~= 0 then
			hadTime = taskmo.progress
		end
	end

	local searchday, searchhour, searchminute = TurnbackModel.instance:getRemainTime(self.searchEndTime)

	self._imgfill.fillAmount = hadTime == self._allSearchTime and (searchday < 0 and 0 or 1) or hadTime / self._allSearchTime
end

function Turnback3DoubleView:onClose()
	TaskDispatcher.cancelTask(self._updateSearchRemainTime, self)
end

function Turnback3DoubleView:onDestroyView()
	TaskDispatcher.cancelTask(self._updateSearchRemainTime, self)
end

return Turnback3DoubleView
