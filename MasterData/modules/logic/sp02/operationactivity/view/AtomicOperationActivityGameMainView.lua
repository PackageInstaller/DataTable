-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityGameMainView.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityGameMainView", package.seeall)

local AtomicOperationActivityGameMainView = class("AtomicOperationActivityGameMainView", BaseView)

function AtomicOperationActivityGameMainView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._txtGameName = gohelper.findChildText(self.viewGO, "Info/#txt_GameName")
	self._txtGameDesc = gohelper.findChildText(self.viewGO, "Info/Scroll View/Viewport/#txt_GameDesc")
	self._simageGamePic = gohelper.findChildSingleImage(self.viewGO, "Info/#simage_GamePic")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Info/timebg/#txt_LimitTime")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Start")
	self._gonormal = gohelper.findChild(self.viewGO, "#btn_Start/#go_normal")
	self._golock = gohelper.findChild(self.viewGO, "#btn_Start/#go_lock")
	self._gogameTimes = gohelper.findChild(self.viewGO, "#btn_Start/#go_gameTimes")
	self._txtgameTimes = gohelper.findChildText(self.viewGO, "#btn_Start/#go_gameTimes/#txt_gameTimes")
	self._imageweapon = gohelper.findChildImage(self.viewGO, "#btn_levelup/#image_weapon")
	self._goup = gohelper.findChild(self.viewGO, "#btn_levelup/#go_up")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicOperationActivityGameMainView:addEvents()
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
	self.addEventCb(self, AtomicOperationActivityController.instance, AtomicOperationActivityEvent.OnPreparationInfoUpdate, self.refreshUI, self)
end

function AtomicOperationActivityGameMainView:removeEvents()
	self._btnStart:RemoveClickListener()
	self.removeEventCb(self, AtomicOperationActivityController.instance, AtomicOperationActivityEvent.OnPreparationInfoUpdate, self.refreshUI, self)
end

function AtomicOperationActivityGameMainView:_btnStartOnClick()
	AtomicOperationActivityGameController.instance:enterGame()
end

function AtomicOperationActivityGameMainView:_btnlevelupOnClick()
	AtomicOperationActivityController.instance:openPreparationView(self.actId)
end

function AtomicOperationActivityGameMainView:_editableInitView()
	return
end

function AtomicOperationActivityGameMainView:onUpdateParam()
	return
end

function AtomicOperationActivityGameMainView:onOpen()
	self:checkParam()
	self:refreshUI()
	self:refreshTime()
	self:checkAutoOpenTipsView()
	AudioMgr.instance:trigger(AudioEnum3_10.OperationActivity.play_ui_main_display)
	TaskDispatcher.runDelay(self.refreshTime, self, TimeUtil.OneSecond)
end

local openTipsKey = "AtomicOperationActivity_Open_Tips"

function AtomicOperationActivityGameMainView:checkAutoOpenTipsView()
	local state = GameUtil.playerPrefsGetNumberByUserId(openTipsKey, AtomicOperationActivityEnum.TipViewReadState.NotRead)

	if state == AtomicOperationActivityEnum.TipViewReadState.NotRead then
		GameUtil.playerPrefsSetNumberByUserId(openTipsKey, AtomicOperationActivityEnum.TipViewReadState.HaveRead)
		self.viewContainer:onClickHelp()
	end
end

function AtomicOperationActivityGameMainView:checkParam()
	local viewParam = self.viewParam

	if not viewParam or not viewParam.actId then
		return
	end

	self.actId = viewParam.actId
	self.infoMo = AtomicOperationActivityModel.instance:getInfoMo(self.actId)
end

function AtomicOperationActivityGameMainView:refreshUI()
	local infoMo = self.infoMo

	if not infoMo then
		return
	end

	local maxRewardTimes = AtomicOperationActivityConfig.instance:getConstNum(AtomicOperationActivityEnum.ConstId.DailyRewardGameCount)
	local remainTimes = math.max(0, maxRewardTimes - infoMo.totalRewardCount)
	local timeDesc

	self._txtgameTimes.text = remainTimes > 0 and GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("sp02_summon_progress_game_time_desc"), remainTimes, maxRewardTimes) or luaLang("sp02_summon_progress_no_game_time_desc")

	local haveCanActivePreparation = infoMo:haveCanActivePreparation()

	gohelper.setActive(self._goup, haveCanActivePreparation)
end

function AtomicOperationActivityGameMainView:refreshRole()
	return
end

function AtomicOperationActivityGameMainView:refreshTime()
	local actId = self.actId
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if not actInfoMo then
		self._txtLimitTime.text = luaLang("ended")

		return
	end

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)
	local isOpen = status ~= ActivityEnum.ActivityStatus.Normal and toastId

	if isOpen then
		self._txtLimitTime.text = status == ActivityEnum.ActivityStatus.Expired and luaLang("ended") or luaLang("notOpen")
	else
		local nowTime = ServerTime.now()
		local offsetTime = actInfoMo.endTime / TimeUtil.OneSecondMilliSecond - nowTime

		self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetTime)
	end

	gohelper.setActive(self._gonormal, isOpen)
	gohelper.setActive(self._golock, not isOpen)

	if status ~= self.status then
		gohelper.setActive(self._golock, not isOpen)
		gohelper.setActive(self._gonormal, isOpen)
	end

	self.status = status
end

function AtomicOperationActivityGameMainView:onClose()
	return
end

function AtomicOperationActivityGameMainView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

return AtomicOperationActivityGameMainView
