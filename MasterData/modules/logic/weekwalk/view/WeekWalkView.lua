-- chunkname: @modules/logic/weekwalk/view/WeekWalkView.lua

module("modules.logic.weekwalk.view.WeekWalkView", package.seeall)

local WeekWalkView = class("WeekWalkView", BaseView)

function WeekWalkView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._simagefinishbg = gohelper.findChildSingleImage(self.viewGO, "#go_finish/#simage_finishbg")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "GameObject/#btn_reward")
	self._gorewardredpoint = gohelper.findChild(self.viewGO, "GameObject/#btn_reward/#go_rewardredpoint")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "GameObject/#btn_detail")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "GameObject/#btn_reset")
	self._txtcurprogress = gohelper.findChildText(self.viewGO, "levelbg/#txt_curprogress")
	self._simagebgimgnext = gohelper.findChildSingleImage(self.viewGO, "transition/ani/#simage_bgimg_next")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function WeekWalkView:removeEvents()
	self._btnreward:RemoveClickListener()
	self._btndetail:RemoveClickListener()
	self._btnreset:RemoveClickListener()
end

function WeekWalkView:_btnresetOnClick()
	WeekWalkController.instance:openWeekWalkResetView()
end

function WeekWalkView:_btnrewardOnClick()
	WeekWalkController.instance:openWeekWalkLayerRewardView({
		mapId = self._mapInfo.id
	})
end

function WeekWalkView:_btndetailOnClick()
	EnemyInfoController.instance:openWeekWalkEnemyInfoView(self._mapInfo.id)
end

function WeekWalkView:_editableInitView()
	self._mapId = WeekWalkModel.instance:getCurMapId()
	self._mapInfo = WeekWalkModel.instance:getOldOrNewCurMapInfo()
	self._mapConfig = WeekWalkConfig.instance:getMapConfig(self._mapId)
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simagefinishbg:LoadImage(ResUrl.getWeekWalkBg("bg_di.png"))
	self._simagebgimgnext:LoadImage(ResUrl.getWeekWalkBg("bg3.png"))
	self:_showDetail()
	self:_updateReward()
	gohelper.addUIClickAudio(self._btndetail.gameObject, AudioEnum.UI.play_ui_action_explore)
	gohelper.addUIClickAudio(self._btnreward.gameObject, AudioEnum.UI.Play_UI_Mainback)
	gohelper.addUIClickAudio(self._btnreset.gameObject, AudioEnum.UI.UI_checkpoint_detailed_tabs_click)
end

function WeekWalkView:_showDetail()
	local mapInfo = WeekWalkModel.instance:getCurMapInfo()
	local typeConfig = lua_weekwalk_type.configDict[self._mapConfig.type]

	gohelper.setActive(self._btndetail.gameObject, typeConfig.showDetail > 0 or mapInfo.isFinish > 0)
end

function WeekWalkView:_updateReward()
	local mapId = self._mapConfig.id
	local taskType = WeekWalkRewardView.getTaskType(mapId)
	local canGetNum, unFinishNum = WeekWalkTaskListModel.instance:canGetRewardNum(taskType, mapId)
	local canGetReward = canGetNum > 0

	gohelper.setActive(self._gorewardredpoint, canGetReward)
end

function WeekWalkView:onUpdateParam()
	return
end

function WeekWalkView:_showRevive()
	if self._mapInfo.isShowSelectCd then
		WeekWalkController.instance:openWeekWalkReviveView()
	end
end

function WeekWalkView:_showBuff(delayShow)
	local buffId = self._mapInfo.buffId

	if buffId and buffId > 0 and self._mapInfo.isShowBuff then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onSelectTarotViewClose, self)

		if delayShow then
			TaskDispatcher.runDelay(self._delayShowTarotView, self, 0)
		else
			self:_delayShowTarotView()
		end

		return
	end

	self:_onWeekWalkSelectTarotViewClose()
end

function WeekWalkView:_delayShowTarotView()
	local buffId = self._mapInfo.buffId

	ViewMgr.instance:openView(ViewName.WeekWalkSelectTarotView, {
		buffId = buffId
	})
end

function WeekWalkView:_onSelectTarotViewClose(viewName, viewParam)
	if viewName == ViewName.WeekWalkSelectTarotView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onSelectTarotViewClose, self)
		self:_onWeekWalkSelectTarotViewClose()
	end
end

function WeekWalkView:_onWeekWalkSelectTarotViewClose()
	self.viewContainer:getWeekWalkMap():_playEnterAnim()
end

function WeekWalkView:onOpen()
	GuideModel.instance:setFlag(GuideModel.GuideFlag.MaskUseMainCamera, 1)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnGetBuffReward, self._OnGetBuffReward, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkInfoUpdate, self._onWeekwalkInfoUpdate, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnGetInfo, self._onGetInfo, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnSetEpisodeListVisible, self._setEpisodeListVisible, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self, LuaEventSystem.Low)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkResetLayer, self._onWeekwalkResetLayer, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
	self:_checkExpire()
	self:_showBuff(true)
	self:_showRevive()
end

function WeekWalkView:onOpenFinish()
	local navBtnView = self.viewContainer:getNavBtnView()

	navBtnView:setHelpId(self._mapId <= 105 and 11302 or 11303)
end

function WeekWalkView:_onWeekwalkTaskUpdate()
	self:_updateReward()
end

function WeekWalkView:_onWeekwalkResetLayer()
	self._mapInfo = WeekWalkModel.instance:getMapInfo(self._mapId)
	self._viewAnim.enabled = true

	self._viewAnim:Play("transition", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_mist)
end

function WeekWalkView:_onCloseViewFinish(viewName)
	if viewName == ViewName.WeekWalkResetView then
		self:_showBuff()
	end
end

function WeekWalkView:_onGetInfo()
	self:_checkExpire(true)
end

function WeekWalkView:_checkExpire(force)
	if WeekWalkModel.instance:infoNeedUpdate() or force then
		WeekWalkModel.instance:clearOldInfo()

		if WeekWalkModel.isShallowLayer(self._mapConfig.layer) then
			return
		end

		UIBlockMgr.instance:startBlock("WeekWalkView _checkExpire")
		TaskDispatcher.runDelay(self._exitView, self, 0.5)
	end
end

function WeekWalkView:_exitView()
	UIBlockMgr.instance:endBlock("WeekWalkView _checkExpire")
	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkExpire, MsgBoxEnum.BoxType.Yes, function()
		ViewMgr.instance:closeAllPopupViews({
			ViewName.DungeonView,
			ViewName.WeekWalkLayerView
		})
	end, nil, nil)
end

function WeekWalkView:_setEpisodeListVisible(value)
	gohelper.setActive(self._gofullscreen, value)
end

function WeekWalkView:_onWeekwalkInfoUpdate()
	self:_showDetail()
end

function WeekWalkView._canShowFinishAnim(mapId)
	local mapInfo = WeekWalkModel.instance:getMapInfo(mapId)

	if not mapInfo then
		return true
	end

	local isFinish = mapInfo.isFinish == 1

	if not isFinish then
		return
	end

	if not mapInfo.isShowFinished then
		return
	end

	return true
end

function WeekWalkView:_OnGetBuffReward()
	TaskDispatcher.runDelay(self._showBuff, self, 1.4)
end

function WeekWalkView:_showCurProgress()
	local mapInfo = WeekWalkModel.instance:getCurMapInfo()
	local sceneConfig = lua_weekwalk_scene.configDict[mapInfo.sceneId]

	self._txtcurprogress.text = sceneConfig.name
end

function WeekWalkView:_onCloseFullView(viewName)
	if self._viewAnim and self:isEnterWeekWalkView() then
		self._viewAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function WeekWalkView:isEnterWeekWalkView()
	local viewlist = ViewMgr.instance:getOpenViewNameList()

	for i = #viewlist, 1, -1 do
		local setting = ViewMgr.instance:getSetting(viewlist[i])

		if setting.layer == ViewMgr.instance:getSetting(self.viewName).layer then
			return viewlist[i] == self.viewName
		end
	end

	return false
end

function WeekWalkView:onClose()
	GuideModel.instance:setFlag(GuideModel.GuideFlag.MaskUseMainCamera, nil)
	TaskDispatcher.cancelTask(self._exitView, self)
	TaskDispatcher.cancelTask(self._showBuff, self)
	TaskDispatcher.cancelTask(self._delayShowTarotView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onSelectTarotViewClose, self)
end

function WeekWalkView:onDestroyView()
	self._simagefinishbg:UnLoadImage()
	self._simagebgimgnext:UnLoadImage()
end

return WeekWalkView
