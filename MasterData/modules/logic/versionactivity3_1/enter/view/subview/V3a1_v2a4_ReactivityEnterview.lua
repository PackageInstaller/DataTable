-- chunkname: @modules/logic/versionactivity3_1/enter/view/subview/V3a1_v2a4_ReactivityEnterview.lua

module("modules.logic.versionactivity3_1.enter.view.subview.V3a1_v2a4_ReactivityEnterview", package.seeall)

local V3a1_v2a4_ReactivityEnterview = class("V3a1_v2a4_ReactivityEnterview", ReactivityEnterview)

function V3a1_v2a4_ReactivityEnterview:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "img/#simage_bg")
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
	self._btnExchange = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Exchange")
	self.rewardItems = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_v2a4_ReactivityEnterview:addEvents()
	self._btnstore:AddClickListener(self._onClickStoreBtn, self)
	self._btnEnter:AddClickListener(self._onClickEnter, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnEnd:AddClickListener(self._onClickEnter, self)
end

function V3a1_v2a4_ReactivityEnterview:removeEvents()
	self._btnstore:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnEnd:RemoveClickListener()
end

function V3a1_v2a4_ReactivityEnterview:_onClickEnter()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		return
	end

	VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView()
end

function V3a1_v2a4_ReactivityEnterview:initRedDot()
	if self.actId then
		return
	end

	self.actId = VersionActivity3_1Enum.ActivityId.Reactivity

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	RedDotController.instance:addRedDot(self._goreddot, actCo.redDotId)
end

return V3a1_v2a4_ReactivityEnterview
