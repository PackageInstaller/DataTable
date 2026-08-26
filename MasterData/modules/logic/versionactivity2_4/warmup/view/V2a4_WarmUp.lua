-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUp.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp", package.seeall)

local V2a4_WarmUp = class("V2a4_WarmUp", BaseView)

function V2a4_WarmUp:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simageboxunopen = gohelper.findChildSingleImage(self.viewGO, "Middle/#simage_box_unopen")
	self._simageboxopen = gohelper.findChildSingleImage(self.viewGO, "Middle/#simage_box_open")
	self._simagelight = gohelper.findChildSingleImage(self.viewGO, "Middle/#simage_light")
	self._imageicon = gohelper.findChildImage(self.viewGO, "Middle/#image_icon")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/LimitTime/#txt_LimitTime")
	self._scrollTaskTabList = gohelper.findChildScrollRect(self.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	self._goradiotaskitem = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem/#go_reddot")
	self._scrollTaskDesc = gohelper.findChildScrollRect(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	self._txtTaskContent = gohelper.findChildText(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	self._goWrongChannel = gohelper.findChild(self.viewGO, "Right/TaskPanel/#go_WrongChannel")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "Right/RawardPanel/#scroll_Reward")
	self._gorewarditem = gohelper.findChild(self.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	self._btngetreward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/RawardPanel/#btn_getreward")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_task")
	self._gotask_reddot = gohelper.findChild(self.viewGO, "Right/#btn_task/#go_task_reddot")
	self._btnanswercall = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_answercall")
	self._btnplay = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_play")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a4_WarmUp:addEvents()
	self._btngetreward:AddClickListener(self._btngetrewardOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnanswercall:AddClickListener(self._btnanswercallOnClick, self)
	self._btnplay:AddClickListener(self._btnplaylOnClick, self)
end

function V2a4_WarmUp:removeEvents()
	self._btngetreward:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btnanswercall:RemoveClickListener()
	self._btnplay:RemoveClickListener()
end

local sf = string.format
local ti = table.insert
local tc = table.concat
local Vector4 = _G.Vector4
local splitToNumber = string.splitToNumber
local split = string.split
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local kAnimEvt = "switch"

function V2a4_WarmUp:_btngetrewardOnClick()
	local _, _, _, canGetReward = self.viewContainer:getRLOCCur()

	if not canGetReward then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(true)
	self.viewContainer:sendFinishAct125EpisodeRequest()
end

function V2a4_WarmUp:_btntaskOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	ViewMgr.instance:openView(ViewName.V2a4_WarmUp_TaskView)
end

function V2a4_WarmUp:_btnanswercallOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_diqiu_yure_click_20249044)
	Activity125Controller.instance:sendGetTaskInfoRequest(self._openV2a4_WarmUp_DialogueView, self)
end

local kHttpUrlRoot = "https://re.bluepoch.com/event/ShowdowninChinatown/"

function V2a4_WarmUp:_btnplaylOnClick()
	local strBuf = {}

	ti(strBuf, kHttpUrlRoot .. "?" .. sf("timestamp=%s", ServerTime.now() * 1000))
	ti(strBuf, sf("gameId=%s", SDKMgr.instance:getGameId()))
	ti(strBuf, sf("gameRoleId=%s", PlayerModel.instance:getMyUserId()))
	ti(strBuf, sf("channelUserId=%s", LoginModel.instance.channelUserId))
	ti(strBuf, sf("deviceModel=%s", WebViewController.instance:urlEncode(UnityEngine.SystemInfo.deviceModel)))
	ti(strBuf, sf("deviceId=%s", SDKMgr.instance:getDeviceInfo().deviceId))
	ti(strBuf, sf("os=%s", WebViewController.instance:urlEncode(UnityEngine.SystemInfo.operatingSystem)))
	ti(strBuf, sf("token=%s", SDKMgr.instance:getGameSdkToken()))
	ti(strBuf, sf("channelId=%s", SDKMgr.instance:getChannelId()))
	ti(strBuf, sf("isEmulator=%s", SDKMgr.instance:isEmulator() and 1 or 0))

	local url = tc(strBuf, "&")

	logNormal(url)
	WebViewController.instance:openWebView(url, false, self._onWebViewCb, self)
end

function V2a4_WarmUp:_onWebViewCb(errorType, msg)
	if errorType == WebViewEnum.WebViewCBType.Cb then
		local msgParamList = string.split(msg, "#")
		local eventName = msgParamList[1]

		if eventName == "webClose" then
			ViewMgr.instance:closeView(ViewName.WebView)
		end
	end
end

function V2a4_WarmUp:_openV2a4_WarmUp_DialogueView()
	local level = self.viewContainer:getCurSelectedEpisode()
	local viewParam = {
		level = level
	}

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	ViewMgr.instance:openView(ViewName.V2a4_WarmUp_DialogueView, viewParam)
end

function V2a4_WarmUp:_editableInitView()
	local scroll_TaskDescGo = self._scrollTaskDesc.gameObject
	local scroll_TaskDesc_ViewPort = gohelper.findChild(scroll_TaskDescGo, "Viewport")
	local scroll_TaskTabList = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	local scroll_TaskTabList_Content = gohelper.findChild(scroll_TaskTabList, "Viewport/Content")

	self._btngetrewardGo = self._btngetreward.gameObject
	self._txtTaskContentTran = self._txtTaskContent.transform
	self._scroll_TaskDescGo = scroll_TaskDescGo
	self._descScrollRect = scroll_TaskDescGo:GetComponent(gohelper.Type_ScrollRect)
	self._scrollCanvasGroup = gohelper.onceAddComponent(scroll_TaskDescGo, typeof(UnityEngine.CanvasGroup))
	self._taskDescViewportHeight = math.max(0, recthelper.getHeight(scroll_TaskDescGo.transform))
	self._taskDescMask = scroll_TaskDesc_ViewPort:GetComponent(gohelper.Type_RectMask2D)
	self._goTaskContentTran = scroll_TaskTabList_Content.transform
	self._taskScrollViewportWidth = recthelper.getWidth(scroll_TaskTabList.transform)
	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)
	self._animSelf = self._animatorPlayer.animator
	self._animEvent = gohelper.onceAddComponent(self.viewGO, gohelper.Type_AnimationEventWrap)

	self._animEvent:AddEventListener(kAnimEvt, self._onSwitch, self)
	self:_resetTaskContentPos()
	self:_setActive_goWrongChannel(false)

	self._phoneAnimation = self._btnanswercall.gameObject:GetComponent(gohelper.Type_Animation)
	self._btnplayGo = self._btnplay.gameObject
	self._txtLimitTime.text = ""
	self._descHeight = 0
	self._rewardCount = 0
	self._itemTabList = {}
	self._rewardItemList = {}

	RedDotController.instance:addRedDot(self._gotask_reddot, RedDotEnum.DotNode.Activity125Task, 0)
end

function V2a4_WarmUp:onDataUpdateFirst()
	self:_refreshOnce()
	self:_refreshPhoneAnim()
	self:_refreshActive_btnplay()
end

function V2a4_WarmUp:onDataUpdate()
	self:_refresh()
	self:_refreshPhoneAnim()
end

function V2a4_WarmUp:onSwitchEpisode()
	self._descScrollRect:StopMovement()
	self:_resetTweenDescPos()
	self:_refresh()
	self.viewContainer:tryTweenDesc()
	self:_refreshPhoneAnim()
	self:_refreshActive_btnplay()
end

function V2a4_WarmUp:_refreshPhoneAnim()
	local curEpisodeId = self.viewContainer:getCurSelectedEpisode()
	local isNotShaking = self.viewContainer:isEpisodeFinished(curEpisodeId)
	local animClip = self._phoneAnimation.clip
	local clipName = animClip.name

	if isNotShaking then
		self._phoneAnimation:Stop(clipName)
		self._phoneAnimation:Play(clipName)
		self._phoneAnimation:Sample()
		self._phoneAnimation:Stop(clipName)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	else
		self._phoneAnimation:Play(clipName)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_diqiu_yure_ring_20249041)
	end
end

function V2a4_WarmUp:onUpdateParam()
	self:_refreshOnce()
	self:_refresh()
end

function V2a4_WarmUp:onOpen()
	self._lastSelectedIndex = nil

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
end

function V2a4_WarmUp:onClose()
	GameUtil.onDestroyViewMember_TweenId(self, "_movetweenId")
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")
	self._animEvent:RemoveEventListener(kAnimEvt)
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	GameUtil.onDestroyViewMemberList(self, "_itemTabList")
end

function V2a4_WarmUp:onDestroyView()
	return
end

function V2a4_WarmUp:_refreshOnce()
	self:_showDeadline()
	self:_refreshTabList()
	self:_autoSelectTab()
end

function V2a4_WarmUp:_refresh()
	self:_refreshData()
	self:_refreshTabList()
	self:_refreshRewards()
	self:_refreshRightView()
end

function V2a4_WarmUp:_refreshRightView()
	local isRecevied, localIsPlay, _, canGetReward = self.viewContainer:getRLOCCur()

	gohelper.setActive(self._btngetrewardGo, canGetReward)

	for _, item in ipairs(self._rewardItemList) do
		item:refresh()
	end
end

function V2a4_WarmUp:_setActive_goWrongChannel(isBlockDesc)
	gohelper.setActive(self._goWrongChannel, isBlockDesc)
	gohelper.setActive(self._scroll_TaskDescGo, not isBlockDesc)

	if isBlockDesc then
		self:_setMaskPaddingBottom(self._taskDescViewportHeight)
	else
		self:_setMaskPaddingBottom(0)
	end
end

function V2a4_WarmUp:_refreshData()
	local co = self.viewContainer:getEpisodeConfigCur()

	self.viewContainer:dispatchRedEvent()

	self._txtTaskContent.text = co.text
	self._descHeight = self._txtTaskContent.preferredHeight
end

function V2a4_WarmUp:_showDeadline()
	self:_showLeftTime()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, 60)
end

function V2a4_WarmUp:_showLeftTime()
	self._txtLimitTime.text = self.viewContainer:getActivityRemainTimeStr()
end

function V2a4_WarmUp:_refreshTabList()
	local curEpisodeId = self.viewContainer:getCurSelectedEpisode()
	local maxEpisodeCount = self.viewContainer:getEpisodeCount()

	for i = 1, maxEpisodeCount do
		local episodeId = i
		local isSelected = episodeId == curEpisodeId
		local item

		if i > #self._itemTabList then
			item = self:_create_V2a4_WarmUp_radiotaskitem(i)

			table.insert(self._itemTabList, item)
		else
			item = self._itemTabList[i]
		end

		item:onUpdateMO(episodeId)
		item:setActive(true)
		item:setSelected(isSelected)
	end

	for i = maxEpisodeCount + 1, #self._itemTabList do
		local item = self._itemTabList[i]

		item:setActive(false)
	end

	ZProj.UGUIHelper.RebuildLayout(self._goTaskContentTran)
end

function V2a4_WarmUp:_setSelectIndex(index, isFocus)
	if index == self._lastSelectedIndex then
		return
	end

	if isFocus then
		self:_taskScrollToIndex(index)
	else
		self:onClickTab(self:index2EpisodeId(self.viewContainer:getCurSelectedEpisode()) or 1)
	end
end

local kItemWidth_go_radiotaskitem = 166

function V2a4_WarmUp:_taskScrollToIndex(index)
	local maxScrollPosX = math.max(recthelper.getWidth(self._goTaskContentTran) - self._taskScrollViewportWidth, 0)
	local posX = math.min((index - 1) * kItemWidth_go_radiotaskitem, maxScrollPosX)

	recthelper.setAnchorX(self._goTaskContentTran, -posX)

	self._lastSelectedIndex = index
end

function V2a4_WarmUp:onClickTab(mo)
	local curEpisodeId = mo
	local lastEpisodeId = self.viewContainer:getCurSelectedEpisode()

	if lastEpisodeId == curEpisodeId then
		return
	end

	self._lastSelectedIndex = self:episode2Index(curEpisodeId)

	self.viewContainer:switchTabWithAnim(lastEpisodeId, curEpisodeId)
end

function V2a4_WarmUp:_refreshRewards()
	local co = self.viewContainer:getEpisodeConfigCur()

	if not co.clientbonus then
		local rewardBonus = ""
		local rewards = split(rewardBonus, "|")
		local itemCount = #rewards

		self._rewardCount = itemCount

		for i = 1, itemCount do
			local item
			local itemCo = splitToNumber(rewards[i], "#")

			if i > #self._rewardItemList then
				item = self:_create_V2a4_WarmUp_rewarditem(i)

				table.insert(self._rewardItemList, item)
			else
				item = self._rewardItemList[i]
			end

			item:onUpdateMO(itemCo)
			item:setActive(true)
		end

		for i = itemCount + 1, #self._rewardItemList do
			local item = self._rewardItemList[i]

			item:setActive(false)
		end
	end
end

function V2a4_WarmUp:openDesc(cb, cbObj)
	local isRecevied, localIsPlay = self.viewContainer:getRLOCCur()

	if isRecevied or localIsPlay then
		if cb then
			cb(cbObj)
		end

		return
	end

	self:_resetTweenDescPos()

	local co = self.viewContainer:getEpisodeConfigCur()
	local duration = math.max(co.time or 0, 1)

	gohelper.setActive(self._goWrongChannel, false)
	gohelper.setActive(self._scroll_TaskDescGo, true)

	local function _tweenDescDoneCallBack()
		if cb then
			cb(cbObj)
		end
	end

	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, duration, self._tweenDescUpdateCb, function()
		self:_tweenDescEndCb(duration, _tweenDescDoneCallBack)
	end, self)
end

local lerp = Mathf.Lerp

function V2a4_WarmUp:_tweenDescUpdateCb(value)
	local bottom = lerp(0, self._taskDescViewportHeight, value)

	self:_setMaskPaddingBottom(bottom)
end

function V2a4_WarmUp:_tweenDescEndCb(maskDurationTime, cb, cbObj)
	local toPosY = self._descHeight - self._taskDescViewportHeight

	if toPosY <= 0 then
		if cb then
			cb(cbObj)
		end

		return
	end

	local duration = toPosY * (maskDurationTime / self._taskDescViewportHeight)

	GameUtil.onDestroyViewMember_TweenId(self, "_movetweenId")

	self._movetweenId = ZProj.TweenHelper.DOLocalMoveY(self._txtTaskContentTran, toPosY, duration, cb, cbObj)
end

function V2a4_WarmUp:_resetTaskContentPos()
	recthelper.setAnchorY(self._txtTaskContentTran, 0)
end

function V2a4_WarmUp:episode2Index(episodeId)
	return episodeId
end

function V2a4_WarmUp:index2EpisodeId(index)
	local item = self._itemTabList[index]

	if not item then
		return
	end

	return item._mo
end

function V2a4_WarmUp:_setMaskPaddingBottom(bottom)
	self._taskDescMask.padding = Vector4(0, bottom, 0, 0)
end

function V2a4_WarmUp:_autoSelectTab()
	local episodeId = self.viewContainer:getCurSelectedEpisode() or self.viewContainer:getFirstRewardEpisode()

	self.viewContainer:setCurSelectEpisodeIdSlient(episodeId)
	self:_setSelectIndex(self:episode2Index(episodeId), true)
end

function V2a4_WarmUp:_create_V2a4_WarmUp_radiotaskitem(index)
	local go = gohelper.cloneInPlace(self._goradiotaskitem)
	local item = V2a4_WarmUp_radiotaskitem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function V2a4_WarmUp:_create_V2a4_WarmUp_rewarditem(index)
	local go = gohelper.cloneInPlace(self._gorewarditem)
	local item = V2a4_WarmUp_rewarditem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function V2a4_WarmUp:_resetTweenDescPos()
	GameUtil.onDestroyViewMember_TweenId(self, "_movetweenId")
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")
	self:_resetTaskContentPos()
end

function V2a4_WarmUp:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb, cbObj)
end

function V2a4_WarmUp:tweenSwitch(cb, cbObj)
	self:_playAnim(UIAnimationName.Switch, cb, cbObj)
end

function V2a4_WarmUp:_onSwitch()
	local lastEpisodeId = self.viewContainer:getCurSelectedEpisode()
	local curEpisodeId

	if self._lastSelectedIndex then
		local item = self._itemTabList[self._lastSelectedIndex]

		curEpisodeId = item._mo
	end

	self.viewContainer:switchTabNoAnim(lastEpisodeId, curEpisodeId)
end

function V2a4_WarmUp:playRewardItemsHasGetAnim()
	for i = 1, self._rewardCount do
		local item = self._rewardItemList[i]

		item:playAnim_hasget()
	end
end

function V2a4_WarmUp:setBlock_scroll(isBlock)
	self._scrollCanvasGroup.blocksRaycasts = not isBlock
end

function V2a4_WarmUp:_refreshActive_btnplay()
	local offtime = CommonConfig.instance:getConstStr(ConstEnum.V2a4_WarmUp_btnplay_openTs)

	if string.nilorempty(offtime) then
		gohelper.setActive(self._btnplayGo, true)

		return
	end

	local isActive = ServerTime.now() >= TimeUtil.stringToTimestamp(offtime)

	gohelper.setActive(self._btnplayGo, isActive)
end

return V2a4_WarmUp
