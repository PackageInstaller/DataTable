-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/candyroom/CandyRoomMainView.lua

module("modules.logic.versionactivity4_0.concertlimit.view.candyroom.CandyRoomMainView", package.seeall)

local CandyRoomMainView = class("CandyRoomMainView", BaseView)

function CandyRoomMainView:onInitView()
	self._goscroll = gohelper.findChild(self.viewGO, "#go_scroll")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/Content")
	self._gosummon = gohelper.findChild(self.viewGO, "#go_summon")
	self._btnsummon = gohelper.findChildButtonWithAudio(self.viewGO, "#go_summon/#btn_summon")
	self._gosummongray = gohelper.findChild(self.viewGO, "#go_summon/#btn_summon/#btn_gray")
	self._gosummonable = gohelper.findChild(self.viewGO, "#go_summon/#btn_summon/#btn_able")
	self._btnsummonMuti = gohelper.findChildButtonWithAudio(self.viewGO, "#go_summon/#btn_summonMuti")
	self._gosummonhasget = gohelper.findChild(self.viewGO, "#go_summon/#go_summonhasget")
	self._gosummontimetips = gohelper.findChild(self.viewGO, "#go_summon/#go_summontimetips")
	self._btnsummonitem = gohelper.findChildButtonWithAudio(self.viewGO, "#go_summon/#go_summontimetips/#btn_summonitem")
	self._txtlimit = gohelper.findChildText(self.viewGO, "#go_summon/#go_summontimetips/#txt_limit")
	self._gosummonhasget = gohelper.findChild(self.viewGO, "#go_summon/#go_summonhasget")
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._btnhelp = gohelper.findChildButtonWithAudio(self.viewGO, "#go_title/#btn_help")
	self._btnoverall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_title/#btn_overall")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_title/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._goskin = gohelper.findChild(self.viewGO, "#go_skin")
	self._goskinlock = gohelper.findChild(self.viewGO, "#go_skin/#go_skinlock")
	self._txtskinlocktime = gohelper.findChildText(self.viewGO, "#go_skin/#go_skinlock/#txt_skinlocktime")
	self._goskincanget = gohelper.findChild(self.viewGO, "#go_skin/#go_skincanget")
	self._goskinhasget = gohelper.findChild(self.viewGO, "#go_skin/#go_skinhasget")
	self._goskinreddot = gohelper.findChild(self.viewGO, "#go_skin/#go_skinreddot")
	self._btnskinclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_skin/#btn_skinclick")
	self._goeffect = gohelper.findChild(self.viewGO, "#go_effect")
	self._gosummontips = gohelper.findChild(self.viewGO, "#go_effect/#go_summontips")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CandyRoomMainView:addEvents()
	self._btnsummon:AddClickListener(self._btnsummonOnClick, self)
	self._btnsummonMuti:AddClickListener(self._btnsummonMutiOnClick, self)
	self._btnsummonitem:AddClickListener(self._btnsummonitemOnClick, self)
	self._btnhelp:AddClickListener(self._btnhelpOnClick, self)
	self._btnoverall:AddClickListener(self._btnoverallOnClick, self)
	self._btnskinclick:AddClickListener(self._btnskinclickOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
end

function CandyRoomMainView:removeEvents()
	self._btnsummon:RemoveClickListener()
	self._btnsummonMuti:RemoveClickListener()
	self._btnsummonitem:RemoveClickListener()
	self._btnhelp:RemoveClickListener()
	self._btnoverall:RemoveClickListener()
	self._btnskinclick:RemoveClickListener()
	self._btnskip:RemoveClickListener()
end

function CandyRoomMainView:_btnskinclickOnClick()
	CandyRoomController.instance:openCandyRoomSkinView()
end

function CandyRoomMainView:_btnsummonitemOnClick()
	local act245Co = CandyRoomConfig.instance:getActivity245Co(self._actId)
	local currencyId = act245Co.ticketId

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, currencyId)
end

function CandyRoomMainView:_btnskipOnClick()
	if self._flow then
		self._flow:stop()

		self._flow = nil
	end

	if self._summonflow then
		self._summonflow:stop()

		self._summonflow = nil
	end

	CandyRoomModel.instance:clearWaitShowRewards()

	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._summonRewardGet, self))
	self._flow:addWork(WaitEventWork.New("CandyRoomController;CandyRoomEvent;OnRewardDetailShowFinished"))
	self._flow:addWork(FunctionWork.New(self._summonFinished, self))
	self._flow:start()
end

function CandyRoomMainView:_btnsummonOnClick()
	local hasCount = CandyRoomModel.instance:getLimitTimeCount(self._actId)

	if hasCount <= 0 then
		return
	end

	self._summonType = CandyRoomEnum.SummonType.Single

	self:_startSummon()
end

function CandyRoomMainView:_btnsummonMutiOnClick()
	local limitCount = tonumber(CandyRoomConfig.instance:getActivity245Const(CandyRoomEnum.ConstId.MultiLimitTime).strValue)
	local hasCount = CandyRoomModel.instance:getLimitTimeCount(self._actId)

	if hasCount < limitCount then
		return
	end

	self._summonType = CandyRoomEnum.SummonType.Multi

	self:_startSummon()
end

function CandyRoomMainView:_startSummon()
	if self._flow then
		self._flow:stop()

		self._flow = nil
	end

	if self._summonflow then
		self._summonflow:stop()

		self._summonflow = nil
	end

	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._initSummon, self))
	self._flow:addWork(WaitEventWork.New("CandyRoomController;CandyRoomEvent;OnSummonResultGet"))
	self._flow:addWork(FunctionWork.New(self._showingSummon, self))
	self._flow:addWork(WaitEventWork.New("CandyRoomController;CandyRoomEvent;OnShowSummonGetRewardFinished"))
	self._flow:addWork(FunctionWork.New(self._summonRewardGet, self))
	self._flow:addWork(WaitEventWork.New("CandyRoomController;CandyRoomEvent;OnRewardDetailShowFinished"))
	self._flow:addWork(FunctionWork.New(self._summonFinished, self))
	self._flow:start()
end

function CandyRoomMainView:_initSummon()
	self._summonCount = self._summonType == CandyRoomEnum.SummonType.Single and 1 or CandyRoomModel.instance:getLimitTimeCount(self._actId)

	Activity245Rpc.instance:sendAct245SummonRequest(self._actId, self._summonCount, self._summonCallback, self)
end

function CandyRoomMainView:_summonCallback(cmd, resultCode, msg)
	if resultCode ~= 0 then
		self:_cancelSummon()

		return
	end

	self._forbidDrag = true

	CandyRoomModel.instance:clearWaitShowRewards()

	self._targetRewards = {}

	for _, rewardId in ipairs(msg.rewardIds) do
		table.insert(self._targetRewards, rewardId)
	end

	CandyRoomModel.instance:setWaitShowRewards(LuaUtil.deepCopy(self._targetRewards))

	if self._summonCount ~= #self._targetRewards then
		self._summonCount = #self._targetRewards
	end

	CandyRoomController.instance:dispatchEvent(CandyRoomEvent.OnSummonResultGet)
end

function CandyRoomMainView:_cancelSummon()
	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	if self._flow then
		self._flow:stop()

		self._flow = nil
	end

	if self._summonflow then
		self._summonflow:stop()

		self._summonflow = nil
	end
end

function CandyRoomMainView:_getRewardList()
	local list = {}

	for _, rewardId in pairs(self._targetRewards) do
		local rewardCo = CandyRoomConfig.instance:getActivity245RewardCo(rewardId)
		local params = GameUtil.splitString2(rewardCo.reward, true)

		for _, param in pairs(params) do
			local mo = MaterialDataMO.New()

			mo:initValue(param[1], param[2], param[3])
			table.insert(list, mo)
		end
	end

	return list
end

function CandyRoomMainView:_summonRewardGet()
	if self._summonType ~= CandyRoomEnum.SummonType.Single then
		AudioMgr.instance:trigger(AudioEnum4_0.CandyRoom.stop_ui_yingmen_tanguowu_rotate)
	end

	gohelper.setActive(self._gotopleft, true)
	gohelper.setActive(self._gomask, false)
	gohelper.setActive(self._btnskip.gameObject, false)

	local list = self:_getRewardList()

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, list)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenViewFinish, self)
end

function CandyRoomMainView:_summonFinished()
	self:_hideRewardsNameAndTip(false)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenViewFinish, self)
	gohelper.setActive(self._gosummon, true)
	gohelper.setActive(self._gotitle, true)
	gohelper.setActive(self._goskin, true)
	gohelper.setActive(self._goeffect, false)
	CandyRoomModel.instance:clearWaitShowRewards()

	self._forbidDrag = false
end

local showRewardAnimTime = 2

function CandyRoomMainView:_showingSummon()
	if self._summonflow then
		self._summonflow:stop()

		self._summonflow = nil
	end

	self._firstSummon = true
	self._summonflow = FlowSequence.New()

	self._summonflow:addWork(FunctionWork.New(self._showSummonTips, self))
	self._summonflow:addWork(WaitEventWork.New("CandyRoomController;CandyRoomEvent;OnShowSummonAnimFinished"))
	self._summonflow:addWork(FunctionWork.New(self._showSummonRewardAnim, self))
	self._summonflow:addWork(TimerWork.New(showRewardAnimTime))
	self._summonflow:addWork(FunctionWork.New(self._showSummonFinished, self))
	self._summonflow:start()
end

function CandyRoomMainView:_showSummonTips()
	gohelper.setActive(self._gosummon, false)
	gohelper.setActive(self._gotitle, false)
	gohelper.setActive(self._goskin, false)
	gohelper.setActive(self._goeffect, true)
	gohelper.setActive(self._gotopleft, false)
	gohelper.setActive(self._gosummontips, true)

	local targetRewardId = self._targetRewards[#self._targetRewards - self._summonCount + 1]

	self:_refreshRewards(self._targetRewardId, targetRewardId)

	self._targetRewardId = targetRewardId

	TaskDispatcher.cancelTask(self._showSummonSelectingAnimFinished, self)
	TaskDispatcher.cancelTask(self._resetRewwards, self)
	gohelper.setActive(self._gomask, true)
	self._maskAnim:Play("open", 0, 0)

	self._contentAnim.speed = 1

	if self._summonType == CandyRoomEnum.SummonType.Single then
		self._viewAnim:Play("lottery_once", 0, 0)
		self._contentAnim:Play("lottery_once", 0, 0)
		AudioMgr.instance:trigger(AudioEnum4_0.CandyRoom.play_ui_yingmen_tanguowu_rotate_single)
		TaskDispatcher.runDelay(self._resetRewwards, self, 1.9)
		TaskDispatcher.runDelay(self._showSummonSelectingAnimFinished, self, 3.84)
	else
		self._viewAnim:Play("lottery_many", 0, 0)
		self._contentAnim:Play("lottery_many", 0, 0)
		AudioMgr.instance:trigger(AudioEnum4_0.CandyRoom.play_ui_yingmen_tanguowu_rotate)
		TaskDispatcher.runDelay(self._resetRewwards, self, 1.12)
		TaskDispatcher.runDelay(self._showSummonSelectingAnimFinished, self, 2.34)
	end

	self:_hideRewardsNameAndTip(true)
end

function CandyRoomMainView:_hideRewardsNameAndTip(hide)
	gohelper.setActive(self._btnskip.gameObject, hide)

	if not self._rewardItems then
		return
	end

	for _, rewardItem in pairs(self._rewardItems) do
		rewardItem:hideNameAndTip(hide)
	end
end

function CandyRoomMainView:_resetRewwards()
	self:_refreshRewards(self._targetRewardId, self._targetRewardId)
end

function CandyRoomMainView:_showSummonSelectingAnimFinished()
	CandyRoomController.instance:dispatchEvent(CandyRoomEvent.OnShowSummonAnimFinished)
end

function CandyRoomMainView:_showSummonRewardAnim()
	self:_hideRewardsNameAndTip(false)
	gohelper.setActive(self._gomask, true)
	self._maskAnim:Play("close", 0, 0)
	AudioMgr.instance:trigger(AudioEnum4_0.CandyRoom.play_ui_yingmen_tanguowu_prize)

	if self._summonType == CandyRoomEnum.SummonType.Single then
		self._viewAnim:Play("get", 0, 0)
	else
		self._viewAnim:Play("manyget", 0, 0)
	end

	gohelper.setActive(self._goeffect, true)
	gohelper.setActive(self._gosummontips, false)

	local rewardId = self._targetRewards[#self._targetRewards - self._summonCount + 1]

	CandyRoomController.instance:dispatchEvent(CandyRoomEvent.OnShowSummonSelectFinished, rewardId, self._summonType)
end

function CandyRoomMainView:_showSummonFinished()
	gohelper.setActive(self._goeffect, false)

	self._summonCount = self._summonCount - 1

	CandyRoomModel.instance:removeOneWaitShowReward()
	self:_refreshRewards(self._targetRewardId, self._targetRewardId)

	if self._summonCount > 0 then
		self:_showingSummon()

		return
	end

	CandyRoomController.instance:dispatchEvent(CandyRoomEvent.OnShowSummonGetRewardFinished)
end

function CandyRoomMainView:_onOpenViewFinish(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	self._viewAnim:Play("open", 0, 1)
	self._contentAnim:Play("open", 0, 1)

	local targetRewardId = self._targetRewards[#self._targetRewards]

	self:_refreshRewards(targetRewardId, targetRewardId)
end

function CandyRoomMainView:_onCloseViewFinish(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	CandyRoomController.instance:dispatchEvent(CandyRoomEvent.OnRewardDetailShowFinished)
end

function CandyRoomMainView:_btnhelpOnClick()
	local title = CandyRoomConfig.instance:getActivity245Const(CandyRoomEnum.ConstId.HelpTitle).strValue
	local desc = CandyRoomConfig.instance:getActivity245Const(CandyRoomEnum.ConstId.HelpDesc).strValue

	HelpController.instance:openStoreTipView(desc, title)
end

function CandyRoomMainView:_btnoverallOnClick()
	CandyRoomController.instance:openCandyRoomRewardDetailView()
end

function CandyRoomMainView:_editableInitView()
	self._actId = VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	self:_initView()
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
	self:_addSelfEvents()
end

function CandyRoomMainView:_initView()
	self._goclick = gohelper.findChild(self.viewGO, "#go_scroll/Viewport")
	self._gomask = gohelper.findChild(self.viewGO, "mask")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._goclick)
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._contentAnim = self._gocontent:GetComponent(typeof(UnityEngine.Animator))
	self._maskAnim = self._gomask:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gomask, false)
	gohelper.setActive(self._btnskip.gameObject, false)

	self._rewardItems = self:getUserDataTb_()

	self:_initRewards()

	if SLFramework.FrameworkSettings.IsEditor then
		TaskDispatcher.runRepeat(self._onFrame, self, 0.01)
	end
end

function CandyRoomMainView:_onFrame()
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.O) then
		CandyRoomController.instance:openCandyRoomPanelView()
	end
end

function CandyRoomMainView:_initRewards()
	local resPath = self.viewContainer:getSetting().otherRes.rewardItemPath

	for i = 1, CandyRoomEnum.CircleRewardItemCount do
		if not self._rewardItems[i] then
			local rootGo = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/Content/#item" .. i)
			local go = self.viewContainer:getResInst(resPath, rootGo)

			self._rewardItems[i] = CandyRoomMainRewardItem.New()

			self._rewardItems[i]:init(go)
		end
	end
end

function CandyRoomMainView:_addSelfEvents()
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshSkin, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
	self.addEventCb(self, CandyRoomController.instance, CandyRoomEvent.OnAct245Summon, self._onAct245Summon, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshItems, self)
end

function CandyRoomMainView:_removeSelfEvents()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
		self._drag:RemoveDragListener()

		self._drag = nil
	end

	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshSkin, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
	self.removeEventCb(self, CandyRoomController.instance, CandyRoomEvent.OnAct245Summon, self._onAct245Summon, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshItems, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function CandyRoomMainView:_onDragBegin(param, pointerEventData)
	if self._forbidDrag then
		return
	end

	self._dragValue = 1
	self._lastDragPosX = pointerEventData.position.x

	if self._slideTweenId then
		ZProj.TweenHelper.KillById(self._slideTweenId)

		self._slideTweenId = nil
	end
end

function CandyRoomMainView:_onDrag(param, pointerEventData)
	if self._forbidDrag then
		return
	end

	local curPosX = pointerEventData.position.x
	local deltaX = self._lastDragPosX - curPosX

	self._lastDragPosX = curPosX

	local progress = 0.25 * deltaX / UnityEngine.Screen.width

	self:_dragUpdate(progress)
end

function CandyRoomMainView:_onDragEnd(param, pointerEventData)
	if self._forbidDrag then
		return
	end

	self:_moveToReward()
end

function CandyRoomMainView:_dragUpdate(value)
	self._dragValue = self._dragValue or 1
	self._dragValue = self._dragValue + value
	self._dragValue = self._dragValue > 0 and self._dragValue - math.floor(self._dragValue) or self._dragValue + math.ceil(math.abs(self._dragValue))
	self._contentAnim.speed = 0

	self._contentAnim:Play("loop", 0, self._dragValue)
end

function CandyRoomMainView:_moveToReward()
	local leftValue = 24 * self._dragValue - math.floor(24 * self._dragValue)
	local rightValue = math.ceil(24 * self._dragValue) - 24 * self._dragValue
	local rewardIndex = rightValue < leftValue and math.ceil(24 * self._dragValue) or math.floor(24 * self._dragValue)
	local endValue = rewardIndex / 24

	if rewardIndex >= 24 or rewardIndex <= 0 then
		rewardIndex = 0
	end

	self._targetRewardId = self._rewardItems[rewardIndex + 1]:getRewardId()

	UIBlockMgr.instance:startBlock("candyRoomMove")

	self._slideTweenId = ZProj.TweenHelper.DOTweenFloat(self._dragValue, endValue, 0.5, self._slideUpdate, self._slideFinished, self, nil, EaseType.Linear)
end

function CandyRoomMainView:_slideUpdate(value)
	self._contentAnim.speed = 0

	self._contentAnim:Play("loop", 0, value)
end

function CandyRoomMainView:_slideFinished()
	UIBlockMgr.instance:endBlock("candyRoomMove")

	self._contentAnim.speed = 1

	self:_refreshRewards(self._targetRewardId, self._targetRewardId)
	self._contentAnim:Play("loop", 0, 1)
end

function CandyRoomMainView:_onCheckActState()
	local status = ActivityHelper.getActivityStatus(self._actId)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end

	self:_refreshUI()
	self:_refreshSkin()
end

function CandyRoomMainView:_onAct245Summon()
	self:_refreshUI()
end

function CandyRoomMainView:_refreshTime()
	self._txtLimitTime.text = ActivityModel.getRemainTimeStr(self._actId)

	local skinActId = CandyRoomModel.instance:getLoginActivityId(self._actId)
	local startTime = ActivityModel.instance:getActStartTime(skinActId)
	local remainTimeSec = startTime / 1000 - ServerTime.now()

	if remainTimeSec > 0 then
		self._txtskinlocktime.text = TimeUtil.SecondToActivityTimeFormat(remainTimeSec)
	end
end

function CandyRoomMainView:_refreshItems()
	self:_refreshRewards(self._targetRewardId, self._targetRewardId)
end

function CandyRoomMainView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_0.CandyRoom.play_ui_yingmen_tanguowu_entry)
	self:_checkShowCandyPanelView()
	self:_playOpenRewardsAnim()
end

function CandyRoomMainView:_playOpenRewardsAnim()
	local sortRewards = CandyRoomModel.instance:getActShowSortRewardCos(self._actId)
	local targetRewardId = sortRewards[math.floor(0.5 * #sortRewards)].id

	self:_refreshUI()
	self:_refreshRewards(targetRewardId, targetRewardId)
	self:_refreshSkin()

	self._targetRewardId = targetRewardId

	UIBlockMgr.instance:startBlock("candyRoomOpen")

	self._contentAnim.speed = 1

	self._contentAnim:Play("open", 0, 0)
	TaskDispatcher.runDelay(self._showOpenFinished, self, 1)
end

function CandyRoomMainView:_showOpenFinished()
	UIBlockMgr.instance:endBlock("candyRoomOpen")
end

function CandyRoomMainView:_checkShowCandyPanelView()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertCandyRoom
	local showStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.CandyRoomPanelShow), "")
	local isFirstShow = string.nilorempty(showStr)

	if not isFirstShow then
		return
	end

	CandyRoomController.instance:openCandyRoomPanelView()
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.CandyRoomPanelShow), actId)
end

function CandyRoomMainView:_refreshSkin()
	local skinActId = CandyRoomModel.instance:getLoginActivityId(self._actId)
	local rewardGet = ActivityType101Model.instance:isType101RewardGet(skinActId, 1)
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(skinActId, 1)

	gohelper.setActive(self._goskinhasget, rewardGet)
	gohelper.setActive(self._goskinreddot, couldGet)
	gohelper.setActive(self._goskinlock, not rewardGet and not couldGet)
end

function CandyRoomMainView:_refreshUI()
	local limitCount = tonumber(CandyRoomConfig.instance:getActivity245Const(CandyRoomEnum.ConstId.MultiLimitTime).strValue)
	local hasCount = CandyRoomModel.instance:getLimitTimeCount(self._actId)
	local isAllRewardGet = CandyRoomModel.instance:isAllRewardGet(self._actId)

	self._txtlimit.text = hasCount

	gohelper.setActive(self._btnsummonMuti.gameObject, not isAllRewardGet and limitCount <= hasCount)
	gohelper.setActive(self._gosummontimetips, not isAllRewardGet)
	gohelper.setActive(self._btnsummon.gameObject, not isAllRewardGet)
	gohelper.setActive(self._gosummonable, hasCount > 0)
	gohelper.setActive(self._gosummongray, hasCount <= 0)
	gohelper.setActive(self._gosummonhasget, isAllRewardGet)
end

function CandyRoomMainView:_refreshRewards(showTargetRewardId, hideTargetRewardId)
	local hideSortRewards = CandyRoomModel.instance:getActShowRewardCosByMiddleRewardId(hideTargetRewardId)
	local startSortRewards = CandyRoomModel.instance:getActShowRewardCosByMiddleRewardId(showTargetRewardId)
	local allRewards = {}

	for _, rewards in ipairs(startSortRewards) do
		table.insert(allRewards, rewards)
	end

	for _, rewards in ipairs(hideSortRewards) do
		table.insert(allRewards, rewards)
	end

	for i, rewardCo in ipairs(allRewards) do
		self._rewardItems[i]:refresh(rewardCo)
	end
end

function CandyRoomMainView:onClose()
	return
end

function CandyRoomMainView:onDestroyView()
	if self._slideTweenId then
		ZProj.TweenHelper.KillById(self._slideTweenId)

		self._slideTweenId = nil
	end

	TaskDispatcher.cancelTask(self._onFrame, self)
	TaskDispatcher.cancelTask(self._refreshTime, self)
	TaskDispatcher.cancelTask(self._showOpenFinished, self)
	TaskDispatcher.cancelTask(self._showSummonSelectingAnimFinished, self)
	TaskDispatcher.cancelTask(self._resetRewwards, self)
	UIBlockMgr.instance:endBlock("candyRoomOpen")
	UIBlockMgr.instance:endBlock("candyRoomMove")
	self:_cancelSummon()

	if self._rewardItems then
		for _, rewardItem in pairs(self._rewardItems) do
			rewardItem:destroy()
		end

		self._rewardItems = nil
	end

	self:_removeSelfEvents()
end

return CandyRoomMainView
