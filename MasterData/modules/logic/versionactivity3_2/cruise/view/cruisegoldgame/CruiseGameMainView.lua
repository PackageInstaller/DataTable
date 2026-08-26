-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/CruiseGameMainView.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.CruiseGameMainView", package.seeall)

local CruiseGameMainView = class("CruiseGameMainView", BaseView)

function CruiseGameMainView:onInitView()
	self._txttime = gohelper.findChildTextMesh(self.viewGO, "timebg/#txt_time")
	self._txttarget = gohelper.findChildTextMesh(self.viewGO, "image_bg/#txt_target")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "left/namebg/#txt_name")
	self._btnfinished = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_finished")
	self._txtfinished = gohelper.findChildTextMesh(self.viewGO, "#btn_finished/#txt_finished")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_start")
	self.txt_num = gohelper.findChildTextMesh(self.viewGO, "#btn_start/#txt_num")
	self.txt_num2 = gohelper.findChildTextMesh(self.viewGO, "#btn_finished/#txt_num")
	self._txtscore = gohelper.findChildTextMesh(self.viewGO, "#btnreward/#txt_score")
	self._goreddot = gohelper.findChild(self.viewGO, "#btnreward/#go_reddot")
	self.btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "#btnreward")
end

function CruiseGameMainView:addEvents()
	self.addClickCb(self, self._btnfinished, self.onClickBtnFinished, self)
	self.addClickCb(self, self._btnstart, self.onClickBtnStart, self)
	self.addClickCb(self, self.btnreward, self.onClickBtnreward, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnMsgInfoChange, self.onMsgInfoChange, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
end

function CruiseGameMainView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_2.play_ui_shengyan_box_songjin_open)

	local redPoint = RedDotModel.instance:getDotInfoCount(RedDotEnum.DotNode.CruiseGameMainView_PlayTip, 0)

	if redPoint > 0 then
		RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.CruiseGameMainView_PlayTip, false)
	end

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.CruiseGameMainView_Reward)
	self:refresh()
end

function CruiseGameMainView:onClose()
	return
end

function CruiseGameMainView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function CruiseGameMainView:onClickBtnFinished()
	return
end

function CruiseGameMainView:_onCheckActState()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseGame
	local status = ActivityHelper.getActivityStatus(actId)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function CruiseGameMainView:onClickBtnStart()
	ViewMgr.instance:openView(ViewName.CruiseGamePlayView)
end

function CruiseGameMainView:onClickBtnreward()
	ViewMgr.instance:openView(ViewName.CruiseGameTaskView)
end

function CruiseGameMainView:onMsgInfoChange()
	self:refresh()
end

function CruiseGameMainView:refresh()
	self.cfg_activity218_control = Activity218Config.instance:getCfg_activity218_control()
	self.totalCount = self.cfg_activity218_control.times
	self.finishGameCount = Activity218Model.instance:getFinishGameCount()

	local haveCount = self.finishGameCount < self.totalCount

	gohelper.setActive(self._btnstart, haveCount)
	gohelper.setActive(self._btnfinished, not haveCount)

	if haveCount then
		self.txt_num.text = GameUtil.getSubPlaceholderLuaLang(luaLang("CruiseGame_1"), {
			self.totalCount - self.finishGameCount,
			self.totalCount
		})
	else
		self.txt_num2.text = GameUtil.getSubPlaceholderLuaLang(luaLang("CruiseGame_1"), {
			self.totalCount - self.finishGameCount,
			self.totalCount
		})
	end

	local maxCoin = Activity218Config.instance:getMaxCoin()
	local totalCoinNum = Activity218Model.instance:getTotalCoinNum()

	self._txtscore.text = string.format("%s/%s", totalCoinNum, maxCoin)

	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, 1)
end

function CruiseGameMainView:refreshTime()
	local isGameUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_2Enum.ActivityId.CruiseGame)

	if isGameUnlock then
		self._txttime.text = ActivityModel.getRemainTimeStr(VersionActivity3_2Enum.ActivityId.CruiseGame)
	else
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_2Enum.ActivityId.CruiseGame) / 1000 - ServerTime.now()

		self._txttime.text = self:_getLockStr(second)
	end
end

return CruiseGameMainView
