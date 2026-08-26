-- chunkname: @modules/logic/sp02/paomian/marcus/view/Sp02_MarcusView.lua

module("modules.logic.sp02.paomian.marcus.view.Sp02_MarcusView", package.seeall)

local Sp02_MarcusView = class("Sp02_MarcusView", BaseView)

function Sp02_MarcusView:onInitView()
	self._txtTime = gohelper.findChildText(self.viewGO, "root/content/activitytime/#txt_time")
	self._scrollDayList = gohelper.findChildScrollRect(self.viewGO, "root/content/#scroll_taglist")
	self._goDayContent = gohelper.findChild(self.viewGO, "root/content/#scroll_taglist/viewport/content")
	self._goDayItem = gohelper.findChild(self.viewGO, "root/content/#scroll_taglist/viewport/content/#go_tag")
	self._simagePic = gohelper.findChildSingleImage(self.viewGO, "root/Left/#simage_Pic")
	self._txtTitle = gohelper.findChildText(self.viewGO, "root/content/#txt_title")
	self._scrollDesc = gohelper.findChildScrollRect(self.viewGO, "root/content/#scroll_desc")
	self._txtDesc = gohelper.findChildText(self.viewGO, "root/content/#scroll_desc/viewport/content/#txt_desc")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "root/content/#go_Lock/#btn_Play")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "root/content/#scroll_Reward")
	self._goRewardContent = gohelper.findChild(self.viewGO, "root/content/#scroll_Reward/Viewport/#go_RewardContent")
	self._goRewardItem = gohelper.findChild(self.viewGO, "root/content/#scroll_Reward/Viewport/#go_RewardContent/#go_RewardItem")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "root/content/#scroll_Reward/#btn_Claim")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Sp02_MarcusView:addEvents()
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
	self.addEventCb(self, Sp02_PaoMianController.instance, Sp02_MarcusEvent.OnUpdateMarcus, self.refreshUI, self)
	self.addEventCb(self, Sp02_PaoMianController.instance, Sp02_MarcusEvent.OnSelectMarcusDay, self._onSelectMarcusDay, self)
end

function Sp02_MarcusView:removeEvents()
	self._btnClaim:RemoveClickListener()
	self._animEventWrap:RemoveAllEventListener()
end

function Sp02_MarcusView:_btnClaimOnClick()
	if self._status ~= Sp02_MarcusEnum.BonusStatus.CanGet then
		return
	end

	Activity239Rpc.instance:sendAct239BonusRequest(self._activityId, self._selectDayId)
end

function Sp02_MarcusView:_editableInitView()
	self._goSimagePic = self._simagePic.gameObject
	self._viewAnimator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._animEventWrap = gohelper.onceAddComponent(self.viewGO, gohelper.Type_AnimationEventWrap)

	self._animEventWrap:AddEventListener("switch", self._startSwitchMarcusDay, self)

	self._goScrollDesc = self._scrollDesc.gameObject
	self._scrollDescHeight = recthelper.getHeight(self._scrollDesc.transform)
	self._viewPortMask = gohelper.findChildComponent(self.viewGO, "root/content/#scroll_desc/viewport", gohelper.Type_RectMask2D)
	self._maskPadding = Vector4()
	self._hideMaskPaddingBottom = self._scrollDescHeight + 20
	self._isPlayingDesc = false
	self._goDayList = self._scrollDayList.gameObject
	self._tranDayContent = self._goDayContent.transform
end

function Sp02_MarcusView:onOpen()
	self._activityId = self.viewParam and self.viewParam.activityId
	self._activityCo = ActivityConfig.instance:getActivityCo(self._activityId)
	self._dayConfigList = Sp02_MarcusConfig.instance:getBonusList(self._activityId)

	self:initSelectIndex()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum3_10.PaoMian.EnterMarcusView)
end

function Sp02_MarcusView:initSelectIndex()
	local selectIndex = 1

	for i, config in ipairs(self._dayConfigList) do
		local status = Sp02_MarcusModel.instance:getStatus(config.activityId, config.id)

		if status == Sp02_MarcusEnum.BonusStatus.Lock then
			break
		end

		selectIndex = i
	end

	self:initSelectInfo(selectIndex)
end

function Sp02_MarcusView:initSelectInfo(index)
	self._selectIndex = index
	self._selectDayCo = self._dayConfigList and self._dayConfigList[self._selectIndex]
	self._selectDayId = self._selectDayCo and self._selectDayCo.id
	self._rewardList = Sp02_MarcusConfig.instance:getRewardList(self._selectDayCo.activityId, self._selectDayCo.id)
end

function Sp02_MarcusView:refreshUI()
	self._status = Sp02_MarcusModel.instance:getStatus(self._selectDayCo.activityId, self._selectDayCo.id)
	self._isPlayed = Sp02_PaoMianController.instance:isPlayedMarcusDesc(self._activityId, self._selectDayId)

	if self._selectDayCo then
		self._txtTitle.text = self._selectDayCo.title or ""
	end

	if self._selectDayCo then
		local iconName = self._selectDayCo.pic

		self._simagePic:LoadImage(ResUrl.getS02PaoMianSingleBg("photo/" .. iconName))
		self:refreshDesc()
		gohelper.setActive(self._btnClaim.gameObject, self._status == Sp02_MarcusEnum.BonusStatus.CanGet and self._isPlayed)
		gohelper.CreateObjList(self, self._refreshDayItem, self._dayConfigList, self._goDayContent, self._goDayItem, Sp02_MarcusDayListItem)
		gohelper.CreateObjList(self, self._refreshRewardItem, self._rewardList, self._goRewardContent, self._goRewardItem, Sp02_MarcusRewardItem)
		self:tickGetNewActInfo()
		self:tickRefreshRemainTime()
		TaskDispatcher.cancelTask(self._focusSelectDay, self)
		TaskDispatcher.runDelay(self._focusSelectDay, self, 0.01)
	end
end

function Sp02_MarcusView:_focusSelectDay()
	if self._selectDayItem then
		local focusDayGo = self._selectDayItem.go
		local offset = gohelper.fitScrollItemOffset(self._goDayList, self._goDayContent, focusDayGo, ScrollEnum.ScrollDirH)

		if math.abs(offset) <= 0.01 then
			return
		end

		local curPosX = recthelper.getAnchorX(self._tranDayContent)

		recthelper.setAnchorX(self._tranDayContent, curPosX + offset)
	end
end

function Sp02_MarcusView:_refreshDayItem(dayItem, dayCo, index)
	local select = index == self._selectIndex

	dayItem:onUpdateMO(index, dayCo, select)

	if select then
		self._selectDayItem = dayItem
	end
end

function Sp02_MarcusView:_refreshRewardItem(rewardItem, rewardCo, index)
	rewardItem:onUpdateMO(index, rewardCo, self._selectDayCo)
end

function Sp02_MarcusView:_onUpdateGuessMe()
	self:refreshUI()
end

function Sp02_MarcusView:tickRefreshRemainTime()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 10)
end

function Sp02_MarcusView:tickGetNewActInfo()
	local limitOpenTime = Sp02_MarcusModel.instance:getNextOpenBonusTime(self._activityId)

	if not limitOpenTime or limitOpenTime <= 0 then
		return
	end

	TaskDispatcher.cancelTask(self._sendRpc2GetInfo, self)
	TaskDispatcher.runDelay(self._sendRpc2GetInfo, self, limitOpenTime)
end

function Sp02_MarcusView:_sendRpc2GetInfo()
	if not ActivityHelper.isOpen(self._activityId) then
		return
	end

	Activity239Rpc.instance:sendGetAct239InfoRequest(self._activityId)
end

function Sp02_MarcusView:refreshRemainTime()
	self._txtTime.text = Sp02_PaoMianController.instance:getMarcusRemainTimeStr(self._activityId)
end

function Sp02_MarcusView:_onSelectMarcusDay(index)
	if index == self._selectIndex then
		return
	end

	self._readySelectIndex = index

	self._viewAnimator:Play("switch", 0, 0)
end

function Sp02_MarcusView:_startSwitchMarcusDay()
	if not self._readySelectIndex then
		return
	end

	self:initSelectInfo(self._readySelectIndex)
	self:refreshUI()
end

function Sp02_MarcusView:refreshDesc()
	if self._isPlayingDesc then
		return
	end

	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")

	if self._selectDayCo then
		self._txtDesc.text = self._selectDayCo.text or ""
	end

	local hasGet = self._status == Sp02_MarcusEnum.BonusStatus.Finish
	local showDesc = hasGet or self._status >= Sp02_MarcusEnum.BonusStatus.CanGet and self._isPlayed

	gohelper.setActive(self._goScrollDesc, showDesc)

	if not showDesc then
		if self._status >= Sp02_MarcusEnum.BonusStatus.CanGet then
			self:tweenPlayDesc()
		end

		return
	end

	self:_setMaskPaddingBottom(0)
end

function Sp02_MarcusView:_setMaskPaddingBottom(bottom)
	self._maskPadding:Set(0, bottom, 0, 0)

	self._viewPortMask.padding = self._maskPadding
end

function Sp02_MarcusView:tweenPlayDesc()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")
	GameUtil.setActiveUIBlock(self.viewName, true, false)
	gohelper.setActive(self._goScrollDesc, true)
	ZProj.UGUIHelper.RebuildLayout(self._goScrollDesc.transform)
	self:_setMaskPaddingBottom(self._hideMaskPaddingBottom)
	TaskDispatcher.cancelTask(self._startTweenPlayDesc, self)
	TaskDispatcher.runDelay(self._startTweenPlayDesc, self, 0.01)
end

function Sp02_MarcusView:_startTweenPlayDesc()
	AudioMgr.instance:trigger(AudioEnum3_10.PaoMian.MarcusStartPlayDesc)

	self._descHeight = recthelper.getHeight(self._txtDesc.transform)
	self._viewHeight = recthelper.getHeight(self._scrollDesc.transform)
	self._maskDuration = self._viewHeight / Sp02_MarcusEnum.PlayDescSpeed
	self._descDuration = self._descHeight / Sp02_MarcusEnum.PlayDescSpeed
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, self._descHeight, self._descDuration, self._tweenDescUpdateCb, self._tweenDescUpdateDoneCb, self, self)
	self._isPlayingDesc = true
end

function Sp02_MarcusView:_tweenDescUpdateCb(value)
	local bottom = Mathf.Lerp(self._hideMaskPaddingBottom, 0, value / self._descHeight)
	local scrollValue = 1

	if value >= self._viewHeight then
		local scrollY = Mathf.Lerp(0, 1, (value - self._viewHeight) / (self._descHeight - self._viewHeight))

		scrollValue = 1 - scrollY
	end

	self._scrollDesc.verticalNormalizedPosition = scrollValue

	self:_setMaskPaddingBottom(bottom)
end

function Sp02_MarcusView:_tweenDescUpdateDoneCb()
	AudioMgr.instance:trigger(AudioEnum3_10.PaoMian.MarcusEndPlayDesc)

	self._isPlayingDesc = false

	GameUtil.setActiveUIBlock(self.viewName, false, true)
	Sp02_PaoMianController.instance:setPlayedMarcusDesc(self._activityId, self._selectDayId)
	self:refreshUI()
end

function Sp02_MarcusView:onClose()
	self._simagePic:UnLoadImage()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.cancelTask(self._sendRpc2GetInfo, self)
	TaskDispatcher.cancelTask(self._startTweenPlayDesc, self)
	TaskDispatcher.cancelTask(self._focusSelectDay, self)
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")
	GameUtil.setActiveUIBlock(self.viewName, false, true)
end

function Sp02_MarcusView:onDestroyView()
	return
end

return Sp02_MarcusView
