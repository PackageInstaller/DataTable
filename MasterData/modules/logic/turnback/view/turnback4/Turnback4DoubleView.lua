-- chunkname: @modules/logic/turnback/view/turnback4/Turnback4DoubleView.lua

module("modules.logic.turnback.view.turnback4.Turnback4DoubleView", package.seeall)

local Turnback4DoubleView = class("Turnback4DoubleView", BaseView)

function Turnback4DoubleView:onInitView()
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

function Turnback4DoubleView:addEvents()
	self._btlichizingo:AddClickListener(self._btlichizingoOnClick, self)
	self._btndongxigo:AddClickListener(self._btndongxigoOnClick, self)
	self._btnweichengo:AddClickListener(self._btnweichengoOnClick, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self.refreshUI, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self._btnhelp:AddClickListener(self._onClickHelpBtn, self)
end

function Turnback4DoubleView:removeEvents()
	self._btlichizingo:RemoveClickListener()
	self._btndongxigo:RemoveClickListener()
	self._btnweichengo:RemoveClickListener()
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self.refreshUI, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self._btnhelp:RemoveClickListener()
end

function Turnback4DoubleView:_onClickHelpBtn()
	HelpController.instance:openBpRuleTipsView(luaLang("Turnback3DoubleViewTipTitle"), "Rule Details", luaLang("Turnback3DoubleViewTipContent"))
end

function Turnback4DoubleView:_btlichizingoOnClick()
	GameFacade.jump(JumpEnum.JumpView.ZhuBi)
end

function Turnback4DoubleView:_btndongxigoOnClick()
	GameFacade.jump(JumpEnum.JumpView.Rewind)
end

function Turnback4DoubleView:_btnweichengoOnClick()
	GameFacade.jump(JumpEnum.JumpView.WeiCheng)
end

function Turnback4DoubleView:_onFinishTask()
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
end

function Turnback4DoubleView:_editableInitView()
	return
end

function Turnback4DoubleView:_getEndTime()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()
	local additionalDurationDays = TurnbackConfig.instance:getAdditionDurationDays(turnbackId)
	local mo = TurnbackModel.instance:getCurTurnbackMo()

	return mo.startTime + additionalDurationDays * TimeUtil.OneDaySecond
end

function Turnback4DoubleView:_getSeacrhEndTime()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()
	local onlineDurationDays = TurnbackConfig.instance:getOnlineDurationDays(turnbackId)
	local mo = TurnbackModel.instance:getCurTurnbackMo()

	return mo.startTime + onlineDurationDays * TimeUtil.OneDaySecond
end

function Turnback4DoubleView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._turnbackId = TurnbackModel.instance:getCurTurnbackId()
	self.config = TurnbackConfig.instance:getTurnbackSubModuleCo(self.viewParam.actId)

	TurnbackRpc.instance:sendGetTurnbackInfoRequest()

	self.endTime = self:_getEndTime()

	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_02)
end

function Turnback4DoubleView:_onDailyRefresh()
	TurnbackRpc.instance:sendGetTurnbackInfoRequest(self.refreshUI, self)
end

function Turnback4DoubleView:refreshUI()
	local remainCount, totalCount = TurnbackModel.instance:getAdditionCountInfo()
	local remainStr = "#FFB36F"

	self._txttotalday.text = string.format("<color=%s>%s</color>/%s", remainStr, remainCount, totalCount)

	self:_refreshRemainTime()
end

function Turnback4DoubleView:_refreshRemainTime()
	local offsetSecond = self.endTime - ServerTime.now()

	if offsetSecond > 0 then
		self._txttimes.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
	end
end

function Turnback4DoubleView:onClose()
	return
end

function Turnback4DoubleView:onDestroyView()
	return
end

return Turnback4DoubleView
