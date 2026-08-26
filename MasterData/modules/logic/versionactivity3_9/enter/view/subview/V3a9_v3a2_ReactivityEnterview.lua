-- chunkname: @modules/logic/versionactivity3_9/enter/view/subview/V3a9_v3a2_ReactivityEnterview.lua

module("modules.logic.versionactivity3_9.enter.view.subview.V3a9_v3a2_ReactivityEnterview", package.seeall)

local V3a9_v3a2_ReactivityEnterview = class("V3a9_v3a2_ReactivityEnterview", ReactivityEnterview)

function V3a9_v3a2_ReactivityEnterview:onInitView()
	self._btnExchange = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Exchange")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtshop = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/txt_shop")
	self._txtNum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_num")
	self._gotime = gohelper.findChild(self.viewGO, "entrance/#btn_store/#go_time")
	self._txtstoretime = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_enter")
	self._goreddot = gohelper.findChild(self.viewGO, "entrance/#btn_enter/#go_reddot")
	self._btnFinished = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Finished")
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/actbg/Layout/#txt_time")
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_v3a2_ReactivityEnterview:addEvents()
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnstore:AddClickListener(self._onClickStoreBtn, self)
	self._btnEnter:AddClickListener(self._btnenterOnClick, self)
	self._btnFinished:AddClickListener(self._btnenterOnClick, self)
	self._btnreplay:AddClickListener(self._onClickReplay, self)
end

function V3a9_v3a2_ReactivityEnterview:removeEvents()
	self._btnExchange:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
	self._btnreplay:RemoveClickListener()
end

function V3a9_v3a2_ReactivityEnterview:_btnenterOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		return
	end

	VersionActivityFixedDungeonController.instance:openVersionActivityReactivityDungeonMapView(3, 2)
end

function V3a9_v3a2_ReactivityEnterview:_editableInitView()
	self._videoPath = VersionActivity3_2Enum.EnterLoopVideoName

	V3a9_v3a2_ReactivityEnterview.super._editableInitView(self)
end

function V3a9_v3a2_ReactivityEnterview:initRedDot()
	if self.actId then
		return
	end

	self.actId = VersionActivity3_9Enum.ActivityId.Reactivity

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	RedDotController.instance:addRedDot(self._goreddot, actCo.redDotId)
end

function V3a9_v3a2_ReactivityEnterview:refreshUI()
	V3a9_v3a2_ReactivityEnterview.super.refreshUI(self)

	local storeActCo = ActivityConfig.instance:getActivityCo(VersionActivity3_9Enum.ActivityId.ReactivityStore)

	self._txtshop.text = storeActCo.name
end

function V3a9_v3a2_ReactivityEnterview:refreshEnterBtn()
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(self.actId)

	gohelper.setActive(self._btnEnter, status == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(self._btnFinished, status ~= ActivityEnum.ActivityStatus.Normal and status ~= ActivityEnum.ActivityStatus.NotUnlock)

	if status == ActivityEnum.ActivityStatus.NotUnlock then
		self._txtlockedtips.text = ToastController.instance:getToastMsgWithTableParam(toastId, toastParamList)
	end

	local define = ReactivityEnum.ActivityDefine[self.actId]
	local storeActId = define and define.storeActId

	self.storeActId = storeActId

	local storeStatus = ActivityHelper.getActivityStatus(storeActId)

	gohelper.setActive(self._btnstore, storeStatus == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(self._btnExchange, storeStatus == ActivityEnum.ActivityStatus.Normal)
end

function V3a9_v3a2_ReactivityEnterview:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txttime.text = offsetSecond > 0 and TimeUtil.SecondToActivityTimeFormat(offsetSecond) or luaLang("ended")

	self:refreshStoreTime()
end

return V3a9_v3a2_ReactivityEnterview
