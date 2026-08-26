-- chunkname: @modules/logic/versionactivity2_7/enter/view/subview/V2a7_v2a0_ReactivityEnterview.lua

module("modules.logic.versionactivity2_7.enter.view.subview.V2a7_v2a0_ReactivityEnterview", package.seeall)

local V2a7_v2a0_ReactivityEnterview = class("V2a7_v2a0_ReactivityEnterview", ReactivityEnterview)

function V2a7_v2a0_ReactivityEnterview:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "img/#simage_bg")
	self._gospine = gohelper.findChild(self.viewGO, "#go_spine")
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/actbg/Layout/#txt_time")
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
	self._btnExchange = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Exchange")
	self.rewardItems = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a7_v2a0_ReactivityEnterview:addEvents()
	self._btnAchevement:AddClickListener(self._onClickAchevementBtn, self)
	self._btnstore:AddClickListener(self._onClickStoreBtn, self)
	self._btnEnter:AddClickListener(self._onClickEnter, self)
	self._btnreplay:AddClickListener(self._onClickReplay, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnEnd:AddClickListener(self._onClickEnter, self)
end

function V2a7_v2a0_ReactivityEnterview:removeEvents()
	self._btnAchevement:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnreplay:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnEnd:RemoveClickListener()
end

function V2a7_v2a0_ReactivityEnterview:_onClickEnter()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		return
	end

	VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView()
end

function V2a7_v2a0_ReactivityEnterview:initRedDot()
	if self.actId then
		return
	end

	self.actId = VersionActivity2_7Enum.ActivityId.Reactivity

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	RedDotController.instance:addRedDot(self._goreddot, actCo.redDotId)
end

return V2a7_v2a0_ReactivityEnterview
