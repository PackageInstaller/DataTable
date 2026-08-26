-- chunkname: @modules/logic/versionactivity2_5/reactivity/V2a5_v1a6_ReactivityEnterview.lua

module("modules.logic.versionactivity2_5.reactivity.V2a5_v1a6_ReactivityEnterview", package.seeall)

local V2a5_v1a6_ReactivityEnterview = class("V2a5_v1a6_ReactivityEnterview", ReactivityEnterview)

function V2a5_v1a6_ReactivityEnterview:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "img/#simage_bg")
	self._gospine = gohelper.findChild(self.viewGO, "#go_spine")
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/#txt_time")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_enter")
	self._btnEnd = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_End")
	self._btnLock = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Locked")
	self._goreddot = gohelper.findChild(self.viewGO, "entrance/#btn_enter/normal/#go_reddot")
	self._txtlockedtips = gohelper.findChildText(self.viewGO, "entrance/#btn_enter/locked/#txt_lockedtips")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtNum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_num")
	self._gotime = gohelper.findChild(self.viewGO, "entrance/#btn_store/#go_time")
	self._txtstoretime = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	self._btnreplay = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_replay")
	self._btnAchevement = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement_normal")
	self._btnExchange = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Exchange")
	self.rewardItems = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a5_v1a6_ReactivityEnterview:_onClickEnter()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		return
	end

	VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView()
end

function V2a5_v1a6_ReactivityEnterview:onOpen()
	V2a5_v1a6_ReactivityEnterview.super.onOpen(self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6EnterViewMainActTabSelect)
end

return V2a5_v1a6_ReactivityEnterview
