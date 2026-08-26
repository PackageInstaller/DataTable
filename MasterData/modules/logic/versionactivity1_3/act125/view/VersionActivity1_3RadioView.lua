-- chunkname: @modules/logic/versionactivity1_3/act125/view/VersionActivity1_3RadioView.lua

module("modules.logic.versionactivity1_3.act125.view.VersionActivity1_3RadioView", package.seeall)

local VersionActivity1_3RadioView = class("VersionActivity1_3RadioView", BaseView)

function VersionActivity1_3RadioView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._goVoicePrint1 = gohelper.findChild(self.viewGO, "Middle/#go_VoicePrint1")
	self._simageVoicePrint1 = gohelper.findChildSingleImage(self.viewGO, "Middle/#go_VoicePrint1/#simage_VoicePrint1")
	self._goVoicePrint2 = gohelper.findChild(self.viewGO, "Middle/#go_VoicePrint2")
	self._simageVoicePrint2 = gohelper.findChildSingleImage(self.viewGO, "Middle/#go_VoicePrint2/#simage_VoicePrint2")
	self._txtFMChannelNum = gohelper.findChildText(self.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum")
	self._scrollFMChannelList = gohelper.findChildScrollRect(self.viewGO, "Middle/FMSlider/#scroll_FMChannelList")
	self._goradiochannelitem = gohelper.findChild(self.viewGO, "Middle/FMSlider/#scroll_FMChannelList/Viewport/Content/#go_radiochannelitem")
	self._imageFMSliderThumbLine = gohelper.findChildImage(self.viewGO, "Middle/FMSlider/Lower/#image_FMSliderThumbLine")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/LimitTime/#txt_LimitTime")
	self._scrollTaskTabList = gohelper.findChildScrollRect(self.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	self._goradiotaskitem = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	self._txtTaskTitle = gohelper.findChildText(self.viewGO, "Right/TaskPanel/Title/#txt_TaskTitle")
	self._txtTaskFMChannelNum = gohelper.findChildText(self.viewGO, "Right/TaskPanel/Title/#txt_TaskFMChannelNum")
	self._scrollTaskDesc = gohelper.findChildScrollRect(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	self._txtTaskContent = gohelper.findChildText(self.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "Right/RawardPanel/#scroll_Reward")
	self._gospine = gohelper.findChild(self.viewGO, "Middle/spinecontainer/#go_spine")
	self._goWrongChannel = gohelper.findChild(self.viewGO, "Right/TaskPanel/#go_WrongChannel")
	self._goUpper = gohelper.findChild(self.viewGO, "Middle/FMSlider/#go_Upper")
	self._txtFMCHannelTip = gohelper.findChildText(self.viewGO, "Middle/FMSlider/Lower/txt_FMChannelTips")
	self._gorewarditem = gohelper.findChild(self.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	self._btnplayquickly = gohelper.findChildButton(self.viewGO, "#btn_playquickly")
	self._txtNoSignal = gohelper.findChildText(self.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_NoSignal")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3RadioView:addEvents()
	self._drag:AddDragListener(self._onRadioValueChanged, self)
	self._drag:AddDragEndListener(self._onRadioValueChangeEnd, self)
	self._drag:AddDragBeginListener(self._onRadioValueChangeBegin, self)
	self._btnplayquickly:AddClickListener(self._onClickPlayQuickly, self)
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, self.refreshUI, self)
	Activity125Controller.instance:registerCallback(Activity125Event.OnChannelSelected, self.onChannelSelected, self)
	Activity125Controller.instance:registerCallback(Activity125Event.OnChannelItemClick, self.onChannelPing, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onRewardRefresh, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function VersionActivity1_3RadioView:removeEvents()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	self._drag:RemoveDragBeginListener()
	self._btnplayquickly:RemoveClickListener()
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, self.refreshUI, self)
	Activity125Controller.instance:unregisterCallback(Activity125Event.OnChannelSelected, self.onChannelSelected, self)
	Activity125Controller.instance:unregisterCallback(Activity125Event.OnChannelItemClick, self.onChannelPing, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onRewardRefresh, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function VersionActivity1_3RadioView:_editableInitView()
	self._episodeItemTab = self:getUserDataTb_()
	self._rewardItemTab = self:getUserDataTb_()
	self._fmsliderPingPosX = transformhelper.getPos(self._imageFMSliderThumbLine.transform)
	self._channelScrollRect = gohelper.onceAddComponent(self._scrollFMChannelList, typeof(UnityEngine.UI.ScrollRect))
	self._FMChannelCanvasGroup = gohelper.onceAddComponent(self._scrollFMChannelList, typeof(UnityEngine.CanvasGroup))
	self._taskTabCanvasGroup = gohelper.onceAddComponent(self._scrollTaskTabList, typeof(UnityEngine.CanvasGroup))
	self._viewGOCanvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))

	self._simageFullBG:LoadImage(ResUrl.getRadioIcon_1_3("v1a3_radio_fullbg"))
	self._simageVoicePrint1:LoadImage(ResUrl.getRadioIcon_1_3("v1a3_radio_voiceprint_1"))
	self._simageVoicePrint2:LoadImage(ResUrl.getRadioIcon_1_3("v1a3_radio_voiceprint_2"))

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollFMChannelList.gameObject)
	self._goRewardContent = gohelper.findChild(self.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content")
	self._goChannelContent = gohelper.findChild(self.viewGO, "Middle/FMSlider/#scroll_FMChannelList/Viewport/Content")
	self._goTaskContent = gohelper.findChild(self.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	self._goleftwave = gohelper.findChild(self.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum/LeftWave")
	self._gorightwave = gohelper.findChild(self.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum/RightWave")
	self._goleftwaveeffect = gohelper.findChild(self.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum/LWave_effect1")
	self._gorightwaveeffect = gohelper.findChild(self.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum/RWave_effect1")
	self._middleAnim = gohelper.findChild(self.viewGO, "Middle"):GetComponent(typeof(UnityEngine.Animator))
	self._channelTitleAnim = gohelper.findChild(self.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle"):GetComponent(typeof(UnityEngine.Animator))
	self._isFirstInitUI = true
end

function VersionActivity1_3RadioView:onUpdateParam()
	return
end

function VersionActivity1_3RadioView:onOpen()
	local parentGO = self.viewParam.parent

	self._parentViewCanvasGroup = gohelper.onceAddComponent(self.viewParam.root, typeof(UnityEngine.CanvasGroup))

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = self.viewParam.actId
	self._config = Activity125Config.instance:getAct125Config(self._actId)

	Activity125Controller.instance:getAct125InfoFromServer(self._actId)
end

function VersionActivity1_3RadioView:refreshUI(animSwitchMode)
	self:_refreshData()
	self:_showDeadline()
	self:_initChannels()
	self:_refreshSpine()
	self:_initEpisodeList()

	if self._isFirstInitUI and not animSwitchMode then
		animSwitchMode = self._hasFindCorrectFM and VersionActivity1_3RadioView.AnimSwitchMode.Finish or VersionActivity1_3RadioView.AnimSwitchMode.UnFinish
		self._isFirstInitUI = false
	end

	self:_refreshFMUI(self._hasFindCorrectFM, animSwitchMode)
	self:_initRewards()
end

function VersionActivity1_3RadioView:_refreshData()
	self._curChallengeLv = Activity125Model.instance:getCurChallengeEpisodeId()
	self._curSelectedLvId = self._curSelectedLvId or self._curChallengeLv
	self._inintFrequency = self._config[self._curSelectedLvId].initFrequency
	self._targetFrequencyIndex = tonumber(self._config[self._curSelectedLvId].targetFrequency)
	self._hasFindCorrectFM = Activity125Model.instance:isEpisodeFinished(self._curSelectedLvId)

	if self._hasFindCorrectFM then
		self._curSelectChannleIndex = self._targetFrequencyIndex or self._config[self._curSelectedLvId].initFrequency
	end
end

function VersionActivity1_3RadioView:_showDeadline()
	self:_onRefreshDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 60)
end

function VersionActivity1_3RadioView:_onRefreshDeadline()
	local day, hour = ActivityModel.instance:getRemainTime(self._actId)

	self._txtLimitTime.text = string.format(luaLang("verionactivity1_3radioview_remaintime"), day, hour)

	if day <= 0 and hour <= 0 then
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	end
end

function VersionActivity1_3RadioView:_initChannels()
	local targetChannelCfg = Activity125Config.instance:getChannelParseResult(self._actId, self._curSelectedLvId)

	self._targetChannelValue = targetChannelCfg.targetFrequencyValue

	local channelValueList = self:buildChannelListModel(targetChannelCfg)

	V1A3_RadioChannelListModel.instance:setCategoryList(channelValueList)

	local initCellIndex = self._curSelectChannleIndex - targetChannelCfg.wholeStartIndex + 1

	self.viewContainer._channelScrollView:selectCell(initCellIndex, true)
	gohelper.setActive(self._goWrongChannel, not self._hasFindCorrectFM)
	gohelper.setActive(self._scrollTaskDesc.gameObject, self._hasFindCorrectFM)

	self._txtFMChannelNum.text = string.format("FM.%s", self._targetChannelValue)
	self._txtTaskFMChannelNum.text = string.format("FM.%s", self._targetChannelValue)
	self._txtTaskTitle.text = self._config[self._curSelectedLvId].name
end

function VersionActivity1_3RadioView:buildChannelListModel(channelValueCfg)
	local channelValueList = {}

	for _, v in ipairs(channelValueCfg) do
		local cfgType = v.type
		local startIndex, endIndex = v.startIndex, v.endIndex
		local startValue, endValue = v.startValue, v.endValue

		if cfgType == Activity125Config.ChannelCfgType.Point then
			endIndex = startIndex

			for i = v.lastIndex + 1, v.startIndex - 1 do
				table.insert(channelValueList, {
					isEmpty = true,
					id = i
				})
			end
		end

		for i = startIndex, endIndex do
			local value = Activity125Config.instance:getRealFrequencyValue(i, startIndex, startValue, endIndex, endValue)

			table.insert(channelValueList, {
				id = i,
				value = value
			})
		end
	end

	return channelValueList
end

local delayCheckCorrectFMTime = 1

function VersionActivity1_3RadioView:onChannelSelected(channelIndex)
	if channelIndex ~= self._curSelectChannleIndex and not self._hasFindCorrectFM then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_frequency)
	end

	self._curSelectChannleIndex = channelIndex

	TaskDispatcher.cancelTask(self._checkIsFindCorrectFM, self)

	if not self._isDragging then
		TaskDispatcher.runDelay(self._checkIsFindCorrectFM, self, delayCheckCorrectFMTime)
	end
end

function VersionActivity1_3RadioView:_pingScrollContentPos(index)
	local startIndex, endIndex = Activity125Config.instance:getChannelIndexRange(self._actId, self._curSelectedLvId)

	self._scrollFMChannelList.horizontalNormalizedPosition = self:_getScrollTargetValue(startIndex, endIndex, index)
end

function VersionActivity1_3RadioView:_onRadioValueChanged()
	Activity125Controller.instance:dispatchEvent(Activity125Event.OnFMScrollValueChange, self._fmsliderPingPosX)
end

local fmScrollRestCostTime = 0.2

function VersionActivity1_3RadioView:_onRadioValueChangeEnd()
	self._isDragging = false

	local startIndex, endIndex = Activity125Config.instance:getChannelIndexRange(self._actId, self._curSelectedLvId)
	local startScrollValue = self._scrollFMChannelList.horizontalNormalizedPosition
	local dive = 1 / (endIndex - startIndex)

	if Mathf.Abs(self._curSelectChannleIndex - startScrollValue / dive) > 1 then
		self._curSelectChannleIndex = Mathf.Floor(startScrollValue / dive)
	end

	local scrollValue1 = dive * (self._curSelectChannleIndex - startIndex)
	local scrollValue2 = dive * (Mathf.Clamp(self._curSelectChannleIndex + 1, startIndex, endIndex) - startIndex)
	local scrollValue3 = dive * (Mathf.Clamp(self._curSelectChannleIndex - 1, startIndex, endIndex) - startIndex)
	local targetScrollValue = self:_findNearestScrollValue(startScrollValue, scrollValue1, scrollValue2, scrollValue3)

	if self._fmTweenId then
		ZProj.TweenHelper.KillById(self._fmTweenId)

		self._fmTweenId = nil
	end

	self._fmTweenId = ZProj.TweenHelper.DOTweenFloat(startScrollValue, targetScrollValue, fmScrollRestCostTime, self._fmScrollMovingCallBack, self._fmScrollMovedCallBack, self)
end

function VersionActivity1_3RadioView:_findNearestScrollValue(curScrollValue, ...)
	local scrollValues = {
		...
	}
	local minOffset, targetScrollValue

	for _, v in pairs(scrollValues) do
		local offset = Mathf.Abs(v - curScrollValue)

		if not minOffset or offset < minOffset then
			minOffset = offset
			targetScrollValue = v
		end
	end

	return targetScrollValue
end

function VersionActivity1_3RadioView:_onRadioValueChangeBegin()
	self._isDragging = true

	TaskDispatcher.cancelTask(self._checkIsFindCorrectFM, self)
end

function VersionActivity1_3RadioView:_checkIsFindCorrectFM()
	if self._curSelectChannleIndex == self._targetFrequencyIndex and not self._hasFindCorrectFM then
		self:_onEpisodeFinished()
	end
end

function VersionActivity1_3RadioView:_fmScrollMovingCallBack(scrollValue)
	self._scrollFMChannelList.horizontalNormalizedPosition = scrollValue
end

function VersionActivity1_3RadioView:_getScrollTargetValue(startValue, endValue, curValue)
	return 1 / (endValue - startValue) * (curValue - startValue)
end

function VersionActivity1_3RadioView:_fmScrollMovedCallBack()
	Activity125Controller.instance:dispatchEvent(Activity125Event.OnFMScrollValueChange, self._fmsliderPingPosX)
	TaskDispatcher.cancelTask(self._checkIsFindCorrectFM, self)
	TaskDispatcher.runDelay(self._checkIsFindCorrectFM, self, delayCheckCorrectFMTime)
end

local fmTxtPlayDuration = 6
local fmTxtQuicklyPlayDuration = 0.1

VersionActivity1_3RadioView.AnimSwitchMode = {
	UnFinish2Finish = 3,
	Finish = 1,
	Finish2UnFinish = 4,
	UnFinish = 2,
	None = 0
}

function VersionActivity1_3RadioView:_refreshFMUI(hasFindCorrectFM, switchMode)
	gohelper.setActive(self._goWrongChannel, not hasFindCorrectFM)
	gohelper.setActive(self._txtFMCHannelTip.gameObject, not hasFindCorrectFM)
	gohelper.setActive(self._txtNoSignal.gameObject, not hasFindCorrectFM)
	gohelper.setActive(self._scrollTaskDesc.gameObject, hasFindCorrectFM)
	gohelper.setActive(self._txtFMChannelNum.gameObject, hasFindCorrectFM)
	gohelper.setActive(self._btnplayquickly, false)

	self._channelScrollRect.horizontal = not hasFindCorrectFM
	self._FMChannelCanvasGroup.blocksRaycasts = not hasFindCorrectFM
	self._FMChannelCanvasGroup.interactable = not hasFindCorrectFM
	self._txtTaskContent.text = self._config[self._curSelectedLvId].text

	if hasFindCorrectFM then
		if not self._targetFrequencyIndex then
			local index = self._inintFrequency

			self:_pingScrollContentPos(index)

			switchMode = switchMode or VersionActivity1_3RadioView.AnimSwitchMode.None

			self:_playAnimOnRefreshFMUI(switchMode)
			self:_playAnimWhenFindCorrectFM(switchMode)
		end
	end
end

function VersionActivity1_3RadioView:_onEpisodeFinished()
	self._hasFindCorrectFM = true

	self:_refreshFMUI(self._hasFindCorrectFM, VersionActivity1_3RadioView.AnimSwitchMode.UnFinish2Finish)

	local fmTxt = self._config[self._curSelectedLvId].text

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._txtTaskContent.text = ""
	self._fmPlayStartTime = Time.time
	self._taskTabCanvasGroup.blocksRaycasts = false
	self._taskTabCanvasGroup.interactable = false
	self._parentViewCanvasGroup.blocksRaycasts = false
	self._viewGOCanvasGroup.ignoreParentGroups = true

	gohelper.setActive(self._btnplayquickly, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_reach_frequency)

	self._broadcastAudioId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_broadcast)
	self._tweenId = ZProj.TweenHelper.DOText(self._txtTaskContent, fmTxt, fmTxtPlayDuration, self._onPlayFMFinished, self)
end

function VersionActivity1_3RadioView:_playAnimOnRefreshFMUI(switchMode)
	local middleAnimName, channelTitleAnimName

	if switchMode == VersionActivity1_3RadioView.AnimSwitchMode.UnFinish2Finish then
		middleAnimName = "go2"
		channelTitleAnimName = "go2"
	elseif switchMode == VersionActivity1_3RadioView.AnimSwitchMode.Finish2UnFinish then
		middleAnimName = "go1"
	elseif switchMode == VersionActivity1_3RadioView.AnimSwitchMode.Finish then
		channelTitleAnimName = "idle2"
	elseif switchMode == VersionActivity1_3RadioView.AnimSwitchMode.UnFinish then
		middleAnimName = "idle1"
		channelTitleAnimName = "idle1"
	end

	if middleAnimName then
		self._middleAnim:Play(middleAnimName, 0, 0)
	end

	if channelTitleAnimName then
		self._channelTitleAnim:Play(channelTitleAnimName, 0, 0)
	end
end

function VersionActivity1_3RadioView:_playAnimWhenFindCorrectFM(switchMode)
	local UnFinish2Finish = switchMode == VersionActivity1_3RadioView.AnimSwitchMode.UnFinish2Finish

	gohelper.setActive(self._goleftwave, not UnFinish2Finish)
	gohelper.setActive(self._gorightwave, not UnFinish2Finish)
	gohelper.setActive(self._goleftwaveeffect, UnFinish2Finish)
	gohelper.setActive(self._gorightwaveeffect, UnFinish2Finish)
	gohelper.setActive(self._episodeItemTab[self._curSelectedLvId].imagewave, not UnFinish2Finish)
	gohelper.setActive(self._episodeItemTab[self._curSelectedLvId].finishEffectGo, UnFinish2Finish)
end

function VersionActivity1_3RadioView:onChannelPing(index)
	self:_pingScrollContentPos(index)

	self._isDragging = false
end

local heroId = 3027

function VersionActivity1_3RadioView:_refreshSpine()
	if not self._uiSpine then
		self._uiSpine = GuiModelAgent.Create(self._gospine, true)

		local skinId = HeroConfig.instance:getHeroCO(heroId).skinId
		local skinCo = SkinConfig.instance:getSkinCo(skinId)

		self._uiSpine:setResPath(skinCo)

		local offsets = SkinConfig.instance:getSkinOffset(skinCo.characterViewOffset)

		recthelper.setAnchor(self._gospine.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._gospine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))

		self._spineAudioId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_resident_status_loop)
	end
end

function VersionActivity1_3RadioView:_initEpisodeList()
	local maxEpisodeCount = Activity125Config.instance:getEpisodeCount(self._actId)

	for i = 1, maxEpisodeCount do
		local episodeItem = self._episodeItemTab[i]

		if not episodeItem then
			local episodeItemGo = gohelper.cloneInPlace(self._goradiotaskitem, "taskItem" .. i)
			local txtDateUnSelected = gohelper.findChildText(episodeItemGo, "txt_DateUnSelected")
			local goDateSelected = gohelper.findChild(episodeItemGo, "image_Selected")
			local txtDateSelected = gohelper.findChildText(episodeItemGo, "image_Selected/txt_DateSelected")
			local finishEffectGo = gohelper.findChild(episodeItemGo, "image_Selected/Wave_effect2")
			local imagewave = gohelper.findChildImage(episodeItemGo, "image_Selected/image_wave")
			local goDateLocked = gohelper.findChild(episodeItemGo, "image_Locked")
			local click = gohelper.getClick(episodeItemGo)

			click:AddClickListener(self._taskItemOnClick, self, i)

			episodeItem = {
				episodeItemGo = episodeItemGo,
				goDateSelected = goDateSelected,
				txtDateSelected = txtDateSelected,
				imagewave = imagewave,
				finishEffectGo = finishEffectGo,
				goLocked = goDateLocked,
				txtDateUnSelected = txtDateUnSelected,
				click = click
			}
			self._episodeItemTab[i] = episodeItem
		end

		episodeItem.txtDateUnSelected.text = string.format("Day.%s", i)
		episodeItem.txtDateSelected.text = string.format("Day.%s", i)

		gohelper.setActive(episodeItem.episodeItemGo, true)
		gohelper.setActive(episodeItem.goDateSelected, i == self._curSelectedLvId and i <= self._curChallengeLv)
		gohelper.setActive(episodeItem.txtDateUnSelected.gameObject, i ~= self._curSelectedLvId)
		gohelper.setActive(episodeItem.goLocked, i > self._curChallengeLv)
	end

	ZProj.UGUIHelper.RebuildLayout(self._goTaskContent.transform)

	self._scrollTaskTabList.horizontalNormalizedPosition = self:_getScrollTargetValue(1, maxEpisodeCount, self._curSelectedLvId)
end

function VersionActivity1_3RadioView:_taskItemOnClick(index)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_transverse_tabs_click)

	if index == self._curSelectedLvId then
		return
	end

	if index > self._curChallengeLv then
		GameFacade.showToast(ToastEnum.ConditionLock)

		return
	end

	self._curSelectedLvId = index
	self._delayPlayRewardAnim = false

	local isFinished = Activity125Model.instance:isEpisodeFinished(self._curSelectedLvId)

	if isFinished then
		if not VersionActivity1_3RadioView.AnimSwitchMode.Finish then
			local AnimSwitchMode = VersionActivity1_3RadioView.AnimSwitchMode.UnFinish

			self:refreshUI(AnimSwitchMode)
		end
	end
end

function VersionActivity1_3RadioView:_initRewards()
	local rewardBonus = self._config[self._curSelectedLvId].bonus
	local rewards = string.split(rewardBonus, "|")

	self._rewardCount = #rewards

	for i = 1, self._rewardCount do
		local rewardItem = self._rewardItemTab[i]

		if not rewardItem then
			rewardItem = {
				go = gohelper.cloneInPlace(self._gorewarditem, "rewarditem" .. i)
			}

			local iconRoot = gohelper.findChild(rewardItem.go, "go_icon")

			rewardItem.icon = IconMgr.instance:getCommonPropItemIcon(iconRoot)
			rewardItem.goreceive = gohelper.findChild(rewardItem.go, "go_receive")
			rewardItem.hasgetAnim = gohelper.findChild(rewardItem.go, "go_receive/go_hasget"):GetComponent(typeof(UnityEngine.Animator))

			table.insert(self._rewardItemTab, rewardItem)
		end

		gohelper.setActive(self._rewardItemTab[i].go, true)

		local isFinished = Activity125Model.instance:isEpisodeFinished(self._curSelectedLvId)

		gohelper.setActive(self._rewardItemTab[i].goreceive, isFinished and not self._delayPlayRewardAnim)

		local itemCo = string.splitToNumber(rewards[i], "#")

		self._rewardItemTab[i].icon:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		self._rewardItemTab[i].icon:setCountFontSize(42)
		self._rewardItemTab[i].icon:setScale(0.5)
	end

	for i = self._rewardCount + 1, #self._rewardItemTab do
		gohelper.setActive(self._rewardItemTab[i].go, false)
	end
end

function VersionActivity1_3RadioView:_onGetRewardAnim(switchMode)
	local animName = switchMode == VersionActivity1_3RadioView.AnimSwitchMode.UnFinish2Finish and "go_hasget_in" or "go_hasget_idle"

	for i = 1, self._rewardCount do
		gohelper.setActive(self._rewardItemTab[i].goreceive, true)
		self._rewardItemTab[i].hasgetAnim:Play(animName, 0, 0)
	end

	self._delayPlayRewardAnim = false
end

function VersionActivity1_3RadioView:_onRewardRefresh(viewName)
	if viewName == ViewName.CommonPropView and self._hasFindCorrectFM then
		self._spineAudioId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_resident_status_loop)

		self:_onGetRewardAnim(VersionActivity1_3RadioView.AnimSwitchMode.UnFinish2Finish)
	end
end

function VersionActivity1_3RadioView:_onPlayFMFinished()
	if self._hasFindCorrectFM and self._curSelectedLvId == self._curChallengeLv then
		self._delayPlayRewardAnim = true

		Activity125Controller.instance:onFinishActEpisode(self._actId, self._curSelectedLvId, self._targetFrequencyIndex)

		if self._broadcastAudioId then
			AudioMgr.instance:stopPlayingID(self._broadcastAudioId)
		end

		if self._spineAudioId then
			AudioMgr.instance:stopPlayingID(self._spineAudioId)
		end
	end

	gohelper.setActive(self._btnplayquickly, false)

	self._taskTabCanvasGroup.blocksRaycasts = true
	self._taskTabCanvasGroup.interactable = true
	self._parentViewCanvasGroup.blocksRaycasts = true
	self._viewGOCanvasGroup.ignoreParentGroups = false

	self:_playAnimWhenFindCorrectFM(VersionActivity1_3RadioView.AnimSwitchMode.Finish)
	self:_playAnimOnRefreshFMUI(VersionActivity1_3RadioView.AnimSwitchMode.Finish2UnFinish)
end

function VersionActivity1_3RadioView:_onClickPlayQuickly()
	if self._tweenId then
		local fmTxt = self._config[self._curSelectedLvId].text
		local fmTxtFontCount = GameUtil.utf8len(fmTxt)
		local normalPlayRate = fmTxtFontCount / fmTxtPlayDuration
		local costTime = Time.time - self._fmPlayStartTime
		local remain = fmTxtFontCount - normalPlayRate * costTime
		local newNeedPlayTime = remain / fmTxtFontCount * fmTxtQuicklyPlayDuration

		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = ZProj.TweenHelper.DOText(self._txtTaskContent, fmTxt, newNeedPlayTime, self._onPlayFMFinished, self)

		gohelper.setActive(self._btnplayquickly, false)
	end
end

function VersionActivity1_3RadioView:_onDailyRefresh()
	if self._actId then
		Activity125Controller.instance:getAct125InfoFromServer(self._actId)
	end
end

function VersionActivity1_3RadioView:onClose()
	self._parentViewCanvasGroup.blocksRaycasts = true
	self._viewGOCanvasGroup.ignoreParentGroups = false

	if self._broadcastAudioId then
		AudioMgr.instance:stopPlayingID(self._broadcastAudioId)
	end

	if self._spineAudioId then
		AudioMgr.instance:stopPlayingID(self._spineAudioId)
	end
end

function VersionActivity1_3RadioView:onDestroyView()
	TaskDispatcher.cancelTask(self._checkIsFindCorrectFM, self)
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.cancelTask(self._refreshSelectedFMSliderItem, self)
	TaskDispatcher.cancelTask(self._delaySelectCell, self)

	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end

	if self._episodeItemTab then
		for _, v in pairs(self._episodeItemTab) do
			v.click:RemoveClickListener()
		end
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._fmTweenId then
		ZProj.TweenHelper.KillById(self._fmTweenId)

		self._fmTweenId = nil
	end

	self._config = nil

	self._simageFullBG:UnLoadImage()
	self._simageVoicePrint1:UnLoadImage()
	self._simageVoicePrint2:UnLoadImage()
end

return VersionActivity1_3RadioView
