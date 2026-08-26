-- chunkname: @modules/logic/abyss/view/AbyssEnterView.lua

module("modules.logic.abyss.view.AbyssEnterView", package.seeall)

local AbyssEnterView = class("AbyssEnterView", BaseView)

function AbyssEnterView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "title/#simage_title")
	self._txttime = gohelper.findChildText(self.viewGO, "title/time/#txt_time")
	self._txtdesc = gohelper.findChildText(self.viewGO, "title/#txt_desc")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")
	self._golockbg = gohelper.findChild(self.viewGO, "#go_lockbg")
	self._txtlock = gohelper.findChildText(self.viewGO, "#go_lockbg/#txt_locked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssEnterView:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnGetActInfo, self.refreshUI, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnAbyssMainViewClose, self.onMainViewClose, self)
end

function AbyssEnterView:removeEvents()
	self._btnjump:RemoveClickListener()
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnGetActInfo, self.refreshUI, self)
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnAbyssMainViewClose, self.onMainViewClose, self)
end

function AbyssEnterView:_btnjumpOnClick()
	if not self.actId then
		return
	end

	if ActivityModel.instance:isActOnLine(self.actId) == false then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = AbyssModel.instance:isFunctionUnlock()

	if not isUnlock then
		local toast, toastParamList = OpenHelper.getToastIdAndParam(AbyssModel.instance:getUnlockId())

		if toast then
			GameFacade.showToastWithTableParam(toast, toastParamList)
		end

		return
	end

	self:onOutAnimPlay()
	self._animator:Play("out", 0, 0)
end

function AbyssEnterView:_editableInitView()
	local rewardGo = gohelper.findChild(self.viewGO, "rewardPreview")

	self.rewardItem = MonoHelper.addNoUpdateLuaComOnceToGo(rewardGo, AbyssRewardItem)
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

function AbyssEnterView:onUpdateParam()
	return
end

function AbyssEnterView:onOpen()
	self:checkParam()
	AbyssController.instance:getActivityInfo(self.actId)
	AbyssController.instance:getTaskInfo()
	self._animator:Play("open", 0, 0)
end

function AbyssEnterView:checkParam()
	local param = self.viewParam

	if not param or not param.actId then
		logError("新深渊 没有页面数据")
	end

	if param.parent then
		local parent = param.parent

		gohelper.addChild(parent, self.viewGO)
	end

	local constConfig = AbyssConfig.instance:getConstConfig(AbyssEnum.ConstId.ActId)

	if not constConfig or string.nilorempty(constConfig.value) then
		logError("新深渊 不存在常量活动id配置")

		return
	end

	self.actId = tonumber(constConfig.value)

	AbyssModel.instance:setCurActId(self.actId)
end

AbyssEnterView.RefreshTimeDuration = 1

function AbyssEnterView:refreshUI()
	self:refreshState()
	self:refreshTime()
	self.rewardItem:setInfo(self.actId)
	TaskDispatcher.runRepeat(self.refreshTime, self, AbyssEnterView.RefreshTimeDuration)
end

function AbyssEnterView:refreshState()
	local isUnlock = AbyssModel.instance:isFunctionUnlock()

	gohelper.setActive(self._golockbg, not isUnlock)

	if isUnlock then
		return
	end

	self._txtlock.text = OpenHelper.getActivityUnlockTxt(AbyssModel.instance:getUnlockId())
end

function AbyssEnterView:refreshTime()
	if not self.actId then
		self._txttime.text = luaLang("ended")

		return
	end

	if not ActivityModel.instance:isActOnLine(self.actId) then
		self._txttime.text = luaLang("ended")

		return
	end

	local endTime = ActivityModel.instance:getActEndTime(self.actId) / TimeUtil.OneSecondMilliSecond
	local nowTime = ServerTime.now()

	self._txttime.text = endTime <= nowTime and luaLang("ended") or TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)
end

function AbyssEnterView:onOutAnimPlay()
	AbyssController.instance:openMainView(self.actId)
end

function AbyssEnterView:onMainViewClose()
	self._animator:Play("in", 0, 0)
end

function AbyssEnterView:onClose()
	return
end

function AbyssEnterView:onDestroyView()
	UIBlockHelper.instance:endBlock(AbyssEnum.UIBlockKey.EnterView)
	TaskDispatcher.cancelTask(self.onOutAnimPlay, self)
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

return AbyssEnterView
