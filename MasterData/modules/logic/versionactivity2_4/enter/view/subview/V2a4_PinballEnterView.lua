-- chunkname: @modules/logic/versionactivity2_4/enter/view/subview/V2a4_PinballEnterView.lua

module("modules.logic.versionactivity2_4.enter.view.subview.V2a4_PinballEnterView", package.seeall)

local V2a4_PinballEnterView = class("V2a4_PinballEnterView", VersionActivityEnterBaseSubView)

function V2a4_PinballEnterView:onInitView()
	self._txtLimitTime = gohelper.findChildTextMesh(self.viewGO, "#simage_FullBG/image_LimitTimeBG/#txt_LimitTime")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._gored = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._txtlock = gohelper.findChildTextMesh(self.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_task")
	self._goTaskRed = gohelper.findChild(self.viewGO, "Right/#btn_task/#go_reddotreward")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_reset")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/image_TryBtn")
	self._txtmainlv = gohelper.findChildTextMesh(self.viewGO, "Right/#go_main/#txt_lv")
	self._goslider1 = gohelper.findChildImage(self.viewGO, "Right/#go_main/#go_slider/#go_slider1")
	self._goslider2 = gohelper.findChildImage(self.viewGO, "Right/#go_main/#go_slider/#go_slider2")
	self._goslider3 = gohelper.findChildImage(self.viewGO, "Right/#go_main/#go_slider/#go_slider3")
	self._txtmainnum = gohelper.findChildTextMesh(self.viewGO, "Right/#go_main/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a4_PinballEnterView:addEvents()
	self._btnEnter:AddClickListener(self._enterGame, self)
	self._btnTrial:AddClickListener(self._clickTrial, self)
	self._btnTask:AddClickListener(self._clickTask, self)
	self._btnReset:AddClickListener(self._clickReset, self)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, self._refreshMainLv, self)
	PinballController.instance:registerCallback(PinballEvent.DataInited, self._refreshMainLv, self)
	PinballController.instance:registerCallback(PinballEvent.DataInited, self._refreshResetShow, self)
end

function V2a4_PinballEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, self._refreshMainLv, self)
	PinballController.instance:unregisterCallback(PinballEvent.DataInited, self._refreshMainLv, self)
	PinballController.instance:unregisterCallback(PinballEvent.DataInited, self._refreshResetShow, self)
end

function V2a4_PinballEnterView:_editableInitView()
	self.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_4Enum.ActivityId.Pinball)
end

function V2a4_PinballEnterView:onOpen()
	V2a4_PinballEnterView.super.onOpen(self)
	RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V2a4PinballTaskRed)
	RedDotController.instance:addRedDot(self._goTaskRed, RedDotEnum.DotNode.V2a4PinballTaskRed)

	self._isLock = true

	self:_refreshTime()
	self:_refreshMainLv()
	self:_refreshResetShow()
end

function V2a4_PinballEnterView:_enterGame()
	PinballController.instance:openMainView()
end

function V2a4_PinballEnterView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function V2a4_PinballEnterView:_clickTask()
	ViewMgr.instance:openView(ViewName.PinballTaskView)
end

function V2a4_PinballEnterView:_clickReset()
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PinballReset, MsgBoxEnum.BoxType.Yes_No, self._realReset, nil, nil, self)
end

function V2a4_PinballEnterView:_realReset()
	PinballStatHelper.instance:sendResetCity()
	Activity178Rpc.instance:sendAct178Reset(VersionActivity2_4Enum.ActivityId.Pinball)
end

function V2a4_PinballEnterView:_clickTrial()
	if ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.Pinball) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function V2a4_PinballEnterView:everySecondCall()
	self:_refreshTime()
end

function V2a4_PinballEnterView:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_4Enum.ActivityId.Pinball]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end

		local isLock = ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.Pinball) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
		gohelper.setActive(self._btnTask, false)
		gohelper.setActive(self._btnTrial, not isLock)

		self._isLock = isLock

		self:_refreshResetShow()

		if isLock then
			self._txtlock.text = OpenHelper.getActivityUnlockTxt(self.actCo.openId)
		end
	end
end

function V2a4_PinballEnterView:_refreshMainLv()
	local level, curScore, nextScore = PinballModel.instance:getScoreLevel()
	local score, changeNum = PinballModel.instance:getResNum(PinballEnum.ResType.Score)

	self._txtmainlv.text = level
	self._goslider1.fillAmount = 0
	self._goslider2.fillAmount = nextScore == curScore and 1 or (score - curScore) / (nextScore - curScore)
	self._goslider3.fillAmount = 0
	self._txtmainnum.text = string.format("%d/%d", score, nextScore)
end

function V2a4_PinballEnterView:_refreshResetShow()
	gohelper.setActive(self._btnReset, not self._isLock and PinballModel.instance.day >= PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ResetDay))
end

return V2a4_PinballEnterView
