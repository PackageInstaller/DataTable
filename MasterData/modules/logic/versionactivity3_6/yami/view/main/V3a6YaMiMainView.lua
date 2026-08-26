-- chunkname: @modules/logic/versionactivity3_6/yami/view/main/V3a6YaMiMainView.lua

module("modules.logic.versionactivity3_6.yami.view.main.V3a6YaMiMainView", package.seeall)

local V3a6YaMiMainView = class("V3a6YaMiMainView", BaseView)

function V3a6YaMiMainView:onInitView()
	self._simageActivityBg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_ActivityBg")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "root/right/#simage_Title")
	self._txttime = gohelper.findChildText(self.viewGO, "root/right/#txt_time")
	self._btnencyclope = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_encyclope")
	self._goencyclopereddot = gohelper.findChild(self.viewGO, "root/right/#btn_encyclope/#go_reddot")
	self._btnhandbook = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_handbook")
	self._gohandbookreddot = gohelper.findChild(self.viewGO, "root/right/#btn_handbook/#go_reddot")
	self._txtgoal = gohelper.findChildText(self.viewGO, "root/right/#txt_goal")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_start")
	self._btncontinue = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_continue")
	self._txttext = gohelper.findChildText(self.viewGO, "root/desc_declayout/#txt_text")
	self._gogoal = gohelper.findChild(self.viewGO, "root/right/#go_goal")
	self._txtinfo = gohelper.findChildText(self.viewGO, "root/right/#go_goal/#txt_info")
	self._gomask = gohelper.findChild(self.viewGO, "fullbg")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiMainView:addEvents()
	self._btnencyclope:AddClickListener(self._btnencyclopeOnClick, self)
	self._btnhandbook:AddClickListener(self._btnhandbookOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btncontinue:AddClickListener(self._btncontinueOnClick, self)
end

function V3a6YaMiMainView:removeEvents()
	self._btnencyclope:RemoveClickListener()
	self._btnhandbook:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btncontinue:RemoveClickListener()
end

function V3a6YaMiMainView:_btnencyclopeOnClick()
	local param = {
		orginView = self.viewName
	}

	V3a6YaMiController.instance:openProductHandbookView(param)
end

function V3a6YaMiMainView:_btnhandbookOnClick()
	V3a6YaMiController.instance:openHeroHandbookView()
end

function V3a6YaMiMainView:_btnstartOnClick()
	V3a6YaMiModel.instance:refreshSelectInfo()
	V3a6YaMiController.instance:onEnterNextView()
end

function V3a6YaMiMainView:_btncontinueOnClick()
	V3a6YaMiModel.instance:refreshSelectInfo()
	V3a6YaMiController.instance:onContinueResearch()
	self._levelComp:saveTotalExp()
end

function V3a6YaMiMainView:_editableInitView()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._setCamera, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onEnterPerform, self._onEnterPerform, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onReturnMainView, self._onReturnMainView, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onFinishLoadScene, self._onFinishLoadScene, self)

	self._entityMgr = self.viewContainer:getEntityMgr()
	self._root = gohelper.findChild(self.viewGO, "root")

	local golevel = gohelper.findChild(self.viewGO, "root/level")

	self._levelComp = MonoHelper.addNoUpdateLuaComOnceToGo(golevel, V3a6YaMiLevelExpComp)

	local mo = {
		isCanOpenTask = true,
		isAnim = true,
		viewName = self.viewName
	}

	self._levelComp:onUpdateMO(mo)

	local goreddot = gohelper.findChild(self.viewGO, "root/level/#go_reddot")

	RedDotController.instance:addRedDot(goreddot, RedDotEnum.DotNode.V3a6YaMi)
	MainCameraMgr.instance:addView(self.viewName, self._setCamera, nil, self)
	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.V3a6YaMi)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.V3a6YaMi, AudioEnum3_6.bgm.play_moni_main_music_3_6)

	self._goalAnim = SLFramework.AnimatorPlayer.Get(self._gogoal)
end

local IgnoreViewMap = {
	[ViewName.ToastView] = true,
	[ViewName.GMGuideStatusView] = true,
	[ViewName.GMToolView2] = true,
	[ViewName.GMToolView] = true,
	[ViewName.ToastTopView] = true,
	[ViewName.GuideView] = true,
	[ViewName.WaterMarkView] = true
}

function V3a6YaMiMainView:checkIsTopView()
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewList, 1, -1 do
		local viewName = openViewList[i]

		if not IgnoreViewMap[viewName] then
			return viewName == self.viewName
		end
	end
end

function V3a6YaMiMainView:_onOpenView(viewName)
	if not self:checkIsTopView() then
		self:showView(false)
	end
end

function V3a6YaMiMainView:_onCloseView(viewName)
	if self:checkIsTopView() then
		self:showView(true)
	end
end

function V3a6YaMiMainView:showView(isShow)
	gohelper.setActive(self._root, isShow)
	gohelper.setActive(self._gotopleft, isShow)
	gohelper.setActive(self._gomask, (self._isPerforming or nil) and false)

	if isShow then
		self:_showScene()
		self.viewContainer:checkCurrencyViewPlayAddAnim()
		self:_refreshMission()
	end
end

function V3a6YaMiMainView:_onEnterPerform()
	self._isPerforming = true

	gohelper.setActive(self._gomask, false)
end

function V3a6YaMiMainView:_refreshMission()
	if self._isPerforming then
		return
	end

	local preMissionId = GameUtil.playerPrefsGetNumberByUserId(V3a6YaMiEnum.PrefsKey.MissionId, 0)
	local missionMo = V3a6YaMiModel.instance:getCurMissionMo()

	if preMissionId ~= 0 and (missionMo and missionMo.id) ~= preMissionId then
		local preMisionMo = V3a6YaMiModel.instance:getMission(preMissionId)

		if preMisionMo then
			self:_showMission(preMisionMo)
			self._playGoalAnim(self, "open", self._playGoalCloseAnim, self)

			return
		end
	end

	self:_refreshCurMission()
end

function V3a6YaMiMainView:_playGoalCloseAnim()
	self._playGoalAnim(self, "close", self._refreshCurMission, self)
end

function V3a6YaMiMainView:_playGoalAnim(animName, cb, cbobj)
	if not self._gogoal.activeInHierarchy then
		return
	end

	self._goalAnim:Play(animName, cb, cbobj)
end

function V3a6YaMiMainView:_refreshCurMission()
	local missionMo = V3a6YaMiModel.instance:getCurMissionMo()

	if missionMo then
		self:_playGoalAnim("open")
		self:_showMission(missionMo)
	end

	gohelper.setActive(self._gogoal, missionMo ~= nil)
	GameUtil.playerPrefsSetNumberByUserId(V3a6YaMiEnum.PrefsKey.MissionId, (missionMo or nil) and (missionMo.id or 0))
end

function V3a6YaMiMainView:_showMission(missionMo)
	if missionMo then
		local co = missionMo.co

		self._txtinfo.text = co.desc
	end

	gohelper.setActive(self._gogoal, true)
end

function V3a6YaMiMainView:_onFinishLoadScene()
	if self._isFinishLoadScene then
		return
	end

	self._isFinishLoadScene = true

	self:_showScene()
end

function V3a6YaMiMainView:_showScene()
	local scene = V3a6YaMiController.instance:getScene()

	if scene then
		scene:showScene()
	end
end

function V3a6YaMiMainView:_setCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = V3a6YaMiSceneEnum.MapCameraSize * scale
end

function V3a6YaMiMainView:_resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = self._orthographicSize or 5
	camera.orthographic = self._orthographic
end

function V3a6YaMiMainView:_onReturnMainView()
	self._isPerforming = false

	gohelper.setActive(self._gomask, false)
	self:_refreshBtn()
end

function V3a6YaMiMainView:onUpdateParam()
	self:_onCloseView(self:checkIsTopView())
end

function V3a6YaMiMainView:onOpen()
	self._isPerforming = false

	gohelper.setActive(self._gomask, false)

	if not self._orthographicSize then
		local camera = CameraMgr.instance:getMainCamera()

		self._orthographicSize = camera.orthographicSize
		self._orthographic = camera.orthographic
	end

	self:_refreshMission()
	self:_refreshBtn()
	V3a6YaMiStatHelper.instance:InitEnterYaMiMainViewTime()
end

function V3a6YaMiMainView:onOpenFinish()
	self:_onFinishLoadScene()
end

function V3a6YaMiMainView:_refreshBtn()
	local status = V3a6YaMiModel.instance:getResearchStatus()
	local isPause = status ~= V3a6YaMiEnum.ResearchStatus.Idle

	gohelper.setActive(self._btnstart.gameObject, not isPause)
	gohelper.setActive(self._btncontinue.gameObject, isPause)
end

function V3a6YaMiMainView:onClose()
	self:_resetCamera()
	V3a6YaMiStatHelper.instance:ExitYaMiMainView()
end

function V3a6YaMiMainView:onDestroyView()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._setCamera, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onReturnMainView, self._onReturnMainView, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onFinishLoadScene, self._onFinishLoadScene, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onEnterPerform, self._onEnterPerform, self)
end

return V3a6YaMiMainView
