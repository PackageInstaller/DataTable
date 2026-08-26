-- chunkname: @modules/logic/sp01/reactivity/view/V2a3_ReactivityEnterview.lua

module("modules.logic.sp01.reactivity.view.V2a3_ReactivityEnterview", package.seeall)

local V2a3_ReactivityEnterview = class("V2a3_ReactivityEnterview", ReactivityEnterview)

function V2a3_ReactivityEnterview:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "img/#simage_bg")
	self._gospine = gohelper.findChild(self.viewGO, "#go_spine")
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/actbg/#txt_time")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_enter")
	self._btnEnd = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Finished")
	self._btnLock = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Locked")
	self._goreddot = gohelper.findChild(self.viewGO, "entrance/#btn_enter/#go_reddot")
	self._txtlockedtips = gohelper.findChildText(self.viewGO, "entrance/#btn_enter/locked/#txt_lockedtips")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtNum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_num")
	self._gotime = gohelper.findChild(self.viewGO, "entrance/#btn_store/#go_time")
	self._txtstoretime = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnAchevement = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self._btnExchange = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store/#btn_Exchange")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_task")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "entrance/#btn_task/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a3_ReactivityEnterview:addEvents()
	self._btnAchevement:AddClickListener(self._onClickAchevementBtn, self)
	self._btnstore:AddClickListener(self._onClickStoreBtn, self)
	self._btnEnter:AddClickListener(self._onClickEnter, self)
	self._btnreplay:AddClickListener(self._onClickReplay, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnEnd:AddClickListener(self._onClickEnter, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
end

function V2a3_ReactivityEnterview:removeEvents()
	self._btnAchevement:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnreplay:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnEnd:RemoveClickListener()
	self._btntask:RemoveClickListener()
end

function V2a3_ReactivityEnterview:_editableInitView()
	self.rewardItems = {}

	V2a3_ReactivityEnterview.super._editableInitView(self)
end

function V2a3_ReactivityEnterview:onOpen()
	local viewParam = self.viewParam

	if viewParam then
		self.actId = viewParam.actId
	end

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	RedDotController.instance:addRedDot(self._goreddot, actCo.redDotId)
	V2a3_ReactivityEnterview.super.onOpen(self)
end

function V2a3_ReactivityEnterview:_onClickEnter()
	if not self:_isOpenOrThrowToast() then
		return
	end

	VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView()
end

function V2a3_ReactivityEnterview:initRedDot()
	return
end

function V2a3_ReactivityEnterview:_btntaskOnClick()
	if not self:_isOpenOrThrowToast() then
		return
	end

	VersionActivity2_3DungeonController.instance:openTaskView()
end

function V2a3_ReactivityEnterview:_onClickStoreBtn()
	VersionActivity2_3DungeonController.instance:openStoreView()
end

function V2a3_ReactivityEnterview:_isOpenOrThrowToast()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		return false
	end

	return true
end

function V2a3_ReactivityEnterview:refreshStoreTime()
	local storeActId = self.storeActId
	local actInfoMo = ActivityModel.instance:getActMO(storeActId)

	if not actInfoMo then
		self._txttime.text = luaLang("ended")

		return
	end

	local endTime = actInfoMo:getRealEndTimeStamp()
	local offsetSecond = endTime - ServerTime.now()

	if offsetSecond > TimeUtil.OneDaySecond then
		local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)

		self._txtstoretime.text = day .. "d"

		return
	end

	if offsetSecond > TimeUtil.OneHourSecond then
		local hour = Mathf.Floor(offsetSecond / TimeUtil.OneHourSecond)

		self._txtstoretime.text = hour .. "h"

		return
	end

	self._txtstoretime.text = "1h"
end

return V2a3_ReactivityEnterview
