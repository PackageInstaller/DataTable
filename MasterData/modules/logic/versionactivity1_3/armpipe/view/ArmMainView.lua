-- chunkname: @modules/logic/versionactivity1_3/armpipe/view/ArmMainView.lua

module("modules.logic.versionactivity1_3.armpipe.view.ArmMainView", package.seeall)

local ArmMainView = class("ArmMainView", BaseView)

function ArmMainView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageCircleDec = gohelper.findChildSingleImage(self.viewGO, "#simage_CircleDec")
	self._simageArmUnFixed = gohelper.findChildSingleImage(self.viewGO, "UnFixed/#simage_ArmUnFixed")
	self._imageAllFixedTxt = gohelper.findChildImage(self.viewGO, "Fixed/image_AllFixedTxt")
	self._txtAllFixed = gohelper.findChildText(self.viewGO, "Fixed/txt_AllFixed")
	self._btnRewardBtn = gohelper.findChildButtonWithAudio(self.viewGO, "LeftBottom/#btn_RewardBtn")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "RightTop/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "RightTop/LimitTime/#txt_LimitTime")
	self._btnInVisibleBtn = gohelper.findChildButtonWithAudio(self.viewGO, "RightBottom/#btn_InVisibleBtn")
	self._btnshowAllUI = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_showAllUI")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArmMainView:addEvents()
	self._btnRewardBtn:AddClickListener(self._btnRewardBtnOnClick, self)
	self._btnInVisibleBtn:AddClickListener(self._btnInVisibleBtnOnClick, self)
	self._btnshowAllUI:AddClickListener(self._btnshowAllUIOnClick, self)
end

function ArmMainView:removeEvents()
	self._btnRewardBtn:RemoveClickListener()
	self._btnInVisibleBtn:RemoveClickListener()
	self._btnshowAllUI:RemoveClickListener()
end

function ArmMainView:_btnRewardBtnOnClick()
	ViewMgr.instance:openView(ViewName.ArmRewardView)
end

function ArmMainView:_btnInVisibleBtnOnClick()
	local lastFlag = self._isTouchInVisibleBtn

	self._isTouchInVisibleBtn = true

	if not lastFlag then
		self:refreshUI()
	end

	self:_setIsHidUI(true)
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_button_display)
end

function ArmMainView:_btnshowAllUIOnClick()
	self:_setIsHidUI(false)
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_repair_complete)
end

function ArmMainView:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_fullbg"))
	self._simageCircleDec:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_bgcircledec3"))
	self._simageArmUnFixed:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_unfixedarm"))
	gohelper.setActive(self._btnshowAllUI, false)

	self._isTouchInVisibleBtn = false
	self._partItemTbList = {}

	local goFixed = gohelper.findChild(self.viewGO, "Fixed")

	self._viewAnimator = self.viewGO:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	self._fixedAnimator = goFixed:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)

	local cfgList = Activity124Config.instance:getEpisodeList(VersionActivity1_3Enum.ActivityId.Act305)

	self._cfgList = cfgList
	self._lockPartEndTime = 0

	for i = 1, 6 do
		local go = gohelper.findChild(self.viewGO, string.format("Part/Part%s", i))
		local partItemTb = self:_createPartItemTb(go, cfgList[i])

		table.insert(self._partItemTbList, partItemTb)
	end
end

function ArmMainView:_createPartItemTb(go, episodeCo)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb.goState = gohelper.findChild(go, "State")
	tb.goLocked = gohelper.findChild(go, "State/Locked")
	tb.goUnFixed = gohelper.findChild(go, "State/UnFixed")
	tb.goFixed = gohelper.findChild(go, "State/Fixed")
	tb.btnLocked = gohelper.findChildButtonWithAudio(go, "State/Locked/btn_locked")
	tb.btnFixed = gohelper.findChildButtonWithAudio(go, "State/Fixed/btn_fiexd")
	tb.goUnlockTips = gohelper.findChild(go, "State/image_UnlockTips")
	tb.btnUnFixed = gohelper.findChildButtonWithAudio(go, "State/UnFixed")
	tb.txtUnlockTxt = gohelper.findChildText(go, "State/image_UnlockTips/#txt_UnlockTxt")
	tb.txtLockedName = gohelper.findChildText(go, "State/Locked/txt_Fixed")
	tb.txtUnLockedName = gohelper.findChildText(go, "State/UnFixed/txt_Fixed")
	tb.stateAnimator = tb.goState:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	tb.episodeCo = episodeCo

	if episodeCo then
		tb.id = episodeCo.episodeId or 0
	end

	if episodeCo then
		tb.preId = episodeCo.preEpisode or 0
	end

	if episodeCo then
		tb.txtLockedName.text = episodeCo.name
		tb.txtUnLockedName.text = episodeCo.name
	end

	tb.btnFixed:AddClickListener(self._btnPartItemOnClick, self, tb)
	tb.btnUnFixed:AddClickListener(self._btnPartItemOnClick, self, tb)
	tb.btnLocked:AddClickListener(self._btnPartItemOnClick, self, tb)

	return tb
end

function ArmMainView:_updateStatePartItemTb(tb, needPlayAnim)
	local isClear = self:_isEpisodeClear(tb.id)
	local isOpen = true
	local cdTime = 0

	if not isClear then
		isOpen, cdTime = ArmPuzzleHelper.isOpenDay(tb.id)
	end

	tb.isClear = isClear
	tb.isOpen = isOpen
	tb.cdTime = cdTime

	self:_refreshPartItemUIByParams(tb, isClear, isOpen, cdTime, needPlayAnim)

	return tb
end

function ArmMainView:_playStatePartItemTbAnim(tb, animName, needPlayAnim)
	if needPlayAnim or animName ~= tb.lastAnimName then
		tb.lastAnimName = animName

		tb.stateAnimator:Play(animName, 0, needPlayAnim and 0 or 1)
	end
end

function ArmMainView:_refreshPartItemUIByParams(tb, isClear, isOpen, cdTime, needPlayAnim)
	local isShowCdTime = not isClear and cdTime and cdTime > 0

	gohelper.setActive(tb.goLocked, not isOpen)
	gohelper.setActive(tb.goUnlockTips, isShowCdTime)
	gohelper.setActive(tb.goFixed, isOpen and isClear)
	gohelper.setActive(tb.goUnFixed, isOpen and not isClear)

	if isShowCdTime then
		tb.txtUnlockTxt.text = ArmPuzzleHelper.formatCdLock(cdTime)
	end

	local animName = isClear and "fixed" or isOpen and "unfixed" or "locked"

	self:_playStatePartItemTbAnim(tb, animName, needPlayAnim)
end

function ArmMainView:_lockPartItemTb(tb, needPlayAnim)
	self:_refreshPartItemUIByParams(tb, false, false, tb.cdTime, needPlayAnim)
end

function ArmMainView:_unlockPartItemTb(tb, needPlayAnim)
	self:_refreshPartItemUIByParams(tb, false, true, 0, needPlayAnim)
end

function ArmMainView:_isEpisodeClear(id)
	return Activity124Model.instance:isEpisodeClear(VersionActivity1_3Enum.ActivityId.Act305, id)
end

function ArmMainView:_checkAutoReward()
	for _, cfg in ipairs(self._cfgList) do
		if Activity124Model.instance:isHasReard(cfg.activityId, cfg.episodeId) then
			Activity124Rpc.instance:sendReceiveAct124RewardRequest(cfg.activityId, cfg.episodeId)
		end
	end
end

function ArmMainView:_getFixedAnimName()
	local index = 0

	for i = 1, #self._cfgList do
		if self:_isEpisodeClear(self._cfgList[i].episodeId) then
			index = index + 1
		else
			break
		end
	end

	if index > 0 then
		return "unlock" .. index
	end

	return "idle"
end

function ArmMainView:_setIsHidUI(isHidUI)
	self._viewAnimator:Play(isHidUI and "go" or "back")
	gohelper.setActive(self._btnshowAllUI, isHidUI)
end

function ArmMainView:_setLockPartTime(lockTime)
	self._lockPartEndTime = Time.time + math.min(lockTime, 3)
end

function ArmMainView:_btnPartItemOnClick(btItem)
	if self._lockPartEndTime > Time.time then
		return
	end

	local actId = VersionActivity1_3Enum.ActivityId.Act305

	if btItem.isClear or btItem.isOpen then
		local cfgEpisode = Activity124Config.instance:getEpisodeCo(actId, btItem.id)

		ArmPuzzlePipeController.instance:openGame(cfgEpisode)
	else
		local isOpen, cdTime = ArmPuzzleHelper.isOpenDay(btItem.id)

		if cdTime and cdTime > 0 then
			GameFacade.showToast(ToastEnum.Va3Act124EpisodeNotOpenTime, ArmPuzzleHelper.formatCdTime(cdTime))
		else
			local preCfg = Activity124Config.instance:getEpisodeCo(actId, btItem.preId)

			GameFacade.showToast(ToastEnum.Va3Act124PreEpisodeNotOpen, (preCfg or nil) and (preCfg.name or btItem.preId))
		end
	end
end

function ArmMainView:onUpdateParam()
	return
end

function ArmMainView:onOpen()
	self.addEventCb(self, Activity124Controller.instance, ArmPuzzlePipeEvent.RefreshMapData, self.refreshUI, self)
	self.addEventCb(self, Activity124Controller.instance, ArmPuzzlePipeEvent.RefreshEpisode, self._onRefreshEpisode, self)
	self.addEventCb(self, Activity124Controller.instance, ArmPuzzlePipeEvent.EpisodeFiexdAnim, self._onEpisodeFiexdAnim, self)
	self._fixedAnimator:Play(self:_getFixedAnimName())
	self:refreshUI()
	self:_refreshCDTime()
	TaskDispatcher.runRepeat(self._refreshCDTime, self, 60)
	AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_lefthand_open)
	self:_setLockPartTime(ArmPuzzlePipeEnum.AnimatorTime.OpenView)

	local newUnLockItem = self:_fineNewUnLockItem()

	if newUnLockItem then
		self:_lockPartItemTb(newUnLockItem)

		self._delayFiexdEpisodeId = newUnLockItem.id

		self:_setLockPartTime(ArmPuzzlePipeEnum.AnimatorTime.OpenView + ArmPuzzlePipeEnum.AnimatorTime.UnFixedTime)
		TaskDispatcher.runDelay(self._onFiexdAnimAfter, self, ArmPuzzlePipeEnum.AnimatorTime.OpenView)
	end

	TaskDispatcher.runDelay(self._checkAutoReward, self, 1)
end

function ArmMainView:onClose()
	TaskDispatcher.cancelTask(self._refreshCDTime, self)
	TaskDispatcher.cancelTask(self._onFiexdAnimAfter, self)
	TaskDispatcher.cancelTask(self._checkAutoReward, self)
end

function ArmMainView:onDestroyView()
	self._simageFullBG:UnLoadImage()
	self._simageCircleDec:UnLoadImage()
	self._simageArmUnFixed:UnLoadImage()

	if self._partItemTbList then
		for i = 1, #self._partItemTbList do
			local partItemTb = self._partItemTbList[i]

			partItemTb.btnUnFixed:RemoveClickListener()
			partItemTb.btnFixed:RemoveClickListener()
			partItemTb.btnLocked:RemoveClickListener()
		end

		self._partItemTbList = nil
	end
end

function ArmMainView:_onRefreshEpisode()
	self:refreshUI()
end

function ArmMainView:_onEpisodeFiexdAnim(episodeId)
	local fiexdTb = self:_getItemTbById(episodeId)

	if fiexdTb then
		self:_updateStatePartItemTb(fiexdTb, true)
		self._fixedAnimator:Play(self:_getFixedAnimName(), 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_inking_preference_open)
		AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_molu_arm_repair)

		local unfixedItem = self:_getItemTbById(episodeId, true)

		if unfixedItem then
			self._delayFiexdEpisodeId = unfixedItem.id

			self:_setLockPartTime(ArmPuzzlePipeEnum.AnimatorTime.WaitUnFixedTime + ArmPuzzlePipeEnum.AnimatorTime.UnFixedTime)
			TaskDispatcher.cancelTask(self._onFiexdAnimAfter, self)
			TaskDispatcher.runDelay(self._onFiexdAnimAfter, self, ArmPuzzlePipeEnum.AnimatorTime.WaitUnFixedTime)
		end
	end
end

function ArmMainView:_onFiexdAnimAfter()
	local episodeId = self._delayFiexdEpisodeId

	self._delayFiexdEpisodeId = nil

	self:_refreshFinishAllUI()

	local tb = self:_getItemTbById(episodeId)

	if tb then
		local isOpen, cdTime = ArmPuzzleHelper.isOpenDay(tb.id)

		if isOpen then
			self:_updateStatePartItemTb(tb, true)
			AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_checkpoint_unlock)
			self:_setUnLockAnim(tb.id)
		end
	end
end

function ArmMainView:_getItemTbById(episodeId, isPre)
	for i, tb in ipairs(self._partItemTbList) do
		if isPre then
			if episodeId == tb.preId then
				return tb
			end
		elseif episodeId == tb.id then
			return tb
		end
	end
end

function ArmMainView:_fineNewUnLockItem()
	if not self._partItemTbList then
		return
	end

	for i, tb in ipairs(self._partItemTbList) do
		if not tb.isClear and tb.isOpen and not self:_isPlayedUnLock(tb.id) then
			return tb
		end
	end
end

function ArmMainView:refreshUI()
	if self._partItemTbList then
		for i, tb in ipairs(self._partItemTbList) do
			self:_updateStatePartItemTb(tb)
		end
	end

	self:_refreshFinishAllUI()
end

function ArmMainView:_refreshFinishAllUI()
	local allFinish = self:_isFinishAll()

	gohelper.setActive(self._btnInVisibleBtn, allFinish)
	gohelper.setActive(self._imageAllFixedTxt, allFinish and self._isTouchInVisibleBtn)
	gohelper.setActive(self._txtAllFixed, allFinish and self._isTouchInVisibleBtn)
end

function ArmMainView:_isFinishAll()
	if not self._partItemTbList then
		return false
	end

	for i, tb in ipairs(self._partItemTbList) do
		if not tb.isClear then
			return false
		end
	end

	return true
end

function ArmMainView:_refreshCDTime()
	local actInfoMo = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act305)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtLimitTime.text = string.format(luaLang("remain"), ArmPuzzleHelper.formatCdTime(offsetSecond))

	if self._partItemTbList then
		local hasNewDay = false

		for i, tb in ipairs(self._partItemTbList) do
			if not tb.isClear and not tb.isOpen and self._delayFiexdEpisodeId ~= tb.preId then
				self:_updateStatePartItemTb(tb)

				if tb.isOpen then
					hasNewDay = true

					self:_playStatePartItemTbAnim(tb, true)
					AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_checkpoint_unlock)
					self:_setUnLockAnim(tb.id)
				end
			end
		end

		if hasNewDay then
			Activity124Rpc.instance:sendGetAct124InfosRequest(VersionActivity1_3Enum.ActivityId.Act305)
		end
	end
end

function ArmMainView:_isPlayedUnLock(episodeId)
	local key = self:_getLockAnimKey(episodeId)

	return PlayerPrefsHelper.getNumber(key, 0) == 1
end

function ArmMainView:_getLockAnimKey(episodeId)
	local userId = PlayerModel.instance:getPlayinfo().userId
	local actId = VersionActivity1_3Enum.ActivityId.Act305

	return string.format("ArmMainView_PLAY_UNLOCK_ANIM_KEY_%s_%s_%s", userId, actId, episodeId)
end

function ArmMainView:_setUnLockAnim(episodeId)
	local key = self:_getLockAnimKey(episodeId)

	return PlayerPrefsHelper.setNumber(key, 1)
end

return ArmMainView
