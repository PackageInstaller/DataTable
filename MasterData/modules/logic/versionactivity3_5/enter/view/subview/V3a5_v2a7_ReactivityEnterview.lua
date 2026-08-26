-- chunkname: @modules/logic/versionactivity3_5/enter/view/subview/V3a5_v2a7_ReactivityEnterview.lua

module("modules.logic.versionactivity3_5.enter.view.subview.V3a5_v2a7_ReactivityEnterview", package.seeall)

local V3a5_v2a7_ReactivityEnterview = class("V3a5_v2a7_ReactivityEnterview", ReactivityEnterview)

function V3a5_v2a7_ReactivityEnterview:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_task")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtshop = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/txt_shop")
	self._txtNum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_num")
	self._gotime = gohelper.findChild(self.viewGO, "entrance/#btn_store/#go_time")
	self._txtstoretime = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_enter")
	self._goreddot = gohelper.findChild(self.viewGO, "entrance/#btn_enter/#go_reddot")
	self._btnFinished = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Finished")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Locked")
	self._goLockedTips = gohelper.findChild(self.viewGO, "entrance/#btn_Locked/#go_LockedTips")
	self._txtTips = gohelper.findChildText(self.viewGO, "entrance/#btn_Locked/#go_LockedTips/#txt_Tips")
	self._btnExchange = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Exchange")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/actbg/image_TimeBG/#txt_time")
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a5_v2a7_ReactivityEnterview:addEvents()
	self._btnstore:AddClickListener(self._onClickStoreBtn, self)
	self._btnEnter:AddClickListener(self._onClickEnter, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnFinished:AddClickListener(self._onClickEnter, self)
	self._btnLocked:AddClickListener(self._onClickEnter, self)
end

function V3a5_v2a7_ReactivityEnterview:removeEvents()
	self._btnstore:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
end

function V3a5_v2a7_ReactivityEnterview:_onClickEnter()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		return
	end

	VersionActivityFixedDungeonController.instance:openVersionActivityReactivityDungeonMapView(2, 7)
end

function V3a5_v2a7_ReactivityEnterview:initRedDot()
	if self.actId then
		return
	end

	self.actId = VersionActivity3_5Enum.ActivityId.Reactivity

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	RedDotController.instance:addRedDot(self._goreddot, actCo.redDotId)
end

function V3a5_v2a7_ReactivityEnterview:refreshUI()
	V3a5_v2a7_ReactivityEnterview.super.refreshUI(self)

	local storeActCo = ActivityConfig.instance:getActivityCo(VersionActivity3_5Enum.ActivityId.ReactivityStore)

	self._txtshop.text = storeActCo.name
end

function V3a5_v2a7_ReactivityEnterview:refreshEnterBtn()
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(self.actId)

	gohelper.setActive(self._btnEnter, status == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(self._btnFinished, status ~= ActivityEnum.ActivityStatus.Normal and status ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(self._btnLocked, status == ActivityEnum.ActivityStatus.NotUnlock)

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

return V3a5_v2a7_ReactivityEnterview
