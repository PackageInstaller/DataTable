-- chunkname: @modules/logic/versionactivity3_4/enter/view/subview/V3a4_v2a5_ReactivityEnterview.lua

module("modules.logic.versionactivity3_4.enter.view.subview.V3a4_v2a5_ReactivityEnterview", package.seeall)

local V3a4_v2a5_ReactivityEnterview = class("V3a4_v2a5_ReactivityEnterview", ReactivityEnterview)

function V3a4_v2a5_ReactivityEnterview:onInitView()
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
	self._txttime = gohelper.findChildText(self.viewGO, "logo/time/#txt_time")
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_v2a5_ReactivityEnterview:addEvents()
	self._btnstore:AddClickListener(self._onClickStoreBtn, self)
	self._btnEnter:AddClickListener(self._onClickEnter, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnFinished:AddClickListener(self._onClickEnter, self)
	self._btnLocked:AddClickListener(self._onClickEnter, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self, LuaEventSystem.Low)
end

function V3a4_v2a5_ReactivityEnterview:removeEvents()
	self._btnstore:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
end

function V3a4_v2a5_ReactivityEnterview:_onClickEnter()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		return
	end

	VersionActivity2_5DungeonController.instance:openVersionActivityDungeonMapView()
end

function V3a4_v2a5_ReactivityEnterview:initRedDot()
	if self.actId then
		return
	end

	self.actId = VersionActivity3_4Enum.ActivityId.Reactivity

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	RedDotController.instance:addRedDot(self._goreddot, actCo.redDotId)
end

function V3a4_v2a5_ReactivityEnterview:refreshUI()
	V3a4_v2a5_ReactivityEnterview.super.refreshUI(self)

	local storeActCo = ActivityConfig.instance:getActivityCo(VersionActivity3_4Enum.ActivityId.ReactivityStore)

	self._txtshop.text = storeActCo.name
end

function V3a4_v2a5_ReactivityEnterview:onOpen()
	V3a4_v2a5_ReactivityEnterview.super.onOpen(self)
	self:openBgmLeadSinger()
end

function V3a4_v2a5_ReactivityEnterview:_onOpenView(viewName)
	if viewName == ViewName.VersionActivity2_5DungeonMapView then
		self:closeBgmLeadSinger()
	end
end

function V3a4_v2a5_ReactivityEnterview:_onCloseView(viewName)
	if ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self:openBgmLeadSinger()
	end
end

function V3a4_v2a5_ReactivityEnterview:_setAudioSwitchId()
	self.switchGroupId = self.switchGroupId or AudioMgr.instance:getIdFromString("music_vocal_filter")
	self.originalStateId = self.originalStateId or AudioMgr.instance:getIdFromString("original")
	self.accompanimentStateId = self.accompanimentStateId or AudioMgr.instance:getIdFromString("accompaniment")
end

function V3a4_v2a5_ReactivityEnterview:openBgmLeadSinger()
	self:_setAudioSwitchId()
	AudioMgr.instance:setSwitch(self.switchGroupId, self.originalStateId)
end

function V3a4_v2a5_ReactivityEnterview:closeBgmLeadSinger()
	self:_setAudioSwitchId()
	AudioMgr.instance:setSwitch(self.switchGroupId, self.accompanimentStateId)
end

return V3a4_v2a5_ReactivityEnterview
