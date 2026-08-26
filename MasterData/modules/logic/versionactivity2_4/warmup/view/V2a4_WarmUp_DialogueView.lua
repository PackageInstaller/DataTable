-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUp_DialogueView.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueView", package.seeall)

local V2a4_WarmUp_DialogueView = class("V2a4_WarmUp_DialogueView", BaseView)

function V2a4_WarmUp_DialogueView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._gofail = gohelper.findChild(self.viewGO, "Mask/#go_fail")
	self._gosuccess = gohelper.findChild(self.viewGO, "Mask/#go_success")
	self._goaskphoto = gohelper.findChild(self.viewGO, "Left/#go_ask_photo")
	self._simageimage = gohelper.findChildSingleImage(self.viewGO, "Left/#go_ask_photo/#simage_image")
	self._goasktext = gohelper.findChild(self.viewGO, "Left/#go_ask_text")
	self._simageroleicon = gohelper.findChildSingleImage(self.viewGO, "Left/#go_ask_text/cardbg/#simage_roleicon")
	self._goitem = gohelper.findChild(self.viewGO, "Left/#go_ask_text/info/#go_item")
	self._txttitle = gohelper.findChildText(self.viewGO, "Left/#go_ask_text/info/#go_item/bg/#txt_title")
	self._txtdec = gohelper.findChildText(self.viewGO, "Left/#go_ask_text/info/#go_item/#txt_dec")
	self._txtsmalltitle = gohelper.findChildText(self.viewGO, "Right/#txt_smalltitle")
	self._godialoguecontainer = gohelper.findChild(self.viewGO, "Right/#go_dialoguecontainer")
	self._gocontent = gohelper.findChild(self.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content")
	self._goleftdialogueitem = gohelper.findChild(self.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem")
	self._txtcontent = gohelper.findChildText(self.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem/content_bg/#txt_content")
	self._gorightdialogueitem = gohelper.findChild(self.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_rightdialogueitem")
	self._gomiddialogueItem = gohelper.findChild(self.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_middialogueItem")
	self._goarrow = gohelper.findChild(self.viewGO, "Right/#go_dialoguecontainer/#go_arrow")
	self._gotime = gohelper.findChild(self.viewGO, "Right/#go_time")
	self._txttime = gohelper.findChildText(self.viewGO, "Right/#go_time/#txt_time")
	self._gooptionitem = gohelper.findChild(self.viewGO, "Right/#go_optionitem")
	self._goyes = gohelper.findChild(self.viewGO, "Right/#go_optionitem/#go_yes")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_optionitem/#go_yes/#btn_yes")
	self._gono = gohelper.findChild(self.viewGO, "Right/#go_optionitem/#go_no")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_optionitem/#go_no/#btn_no")
	self._gonext = gohelper.findChild(self.viewGO, "Right/#go_optionitem/#go_next")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_optionitem/#go_next/#btn_next")
	self._txtcorrect = gohelper.findChildText(self.viewGO, "Top/#txt_correct")
	self._txtwrong = gohelper.findChildText(self.viewGO, "Top/#txt_wrong")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a4_WarmUp_DialogueView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
end

function V2a4_WarmUp_DialogueView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
	self._btnnext:RemoveClickListener()
end

local sf = string.format
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local kAnimEvt = "switch"

function V2a4_WarmUp_DialogueView:_btnyesOnClick()
	V2a4_WarmUpController.instance:commitAnswer(true)
end

function V2a4_WarmUp_DialogueView:_btnnoOnClick()
	V2a4_WarmUpController.instance:commitAnswer(false)
end

local kBlockNext = "V2a4_WarmUp_DialogueView:_btnnextOnClick()"

function V2a4_WarmUp_DialogueView:_btnnextOnClick()
	UIBlockHelper.instance:startBlock(kBlockNext, 3, self.viewName)
	V2a4_WarmUpController.instance:waveStart(self:_level())
end

function V2a4_WarmUp_DialogueView:_editableInitView_dialogItem()
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "Right/#go_dialoguecontainer/Scroll View")
	self._txtcontentBg = gohelper.findChild(self._scrollcontent.gameObject, "Viewport/#go_content/#go_leftdialogueitem/content_bg")

	local lTrans = self._goleftdialogueitem.transform
	local rTrans = self._gorightdialogueitem.transform
	local lTxtTrans = self._txtcontent.transform

	gohelper.setActive(self._goleftdialogueitem, false)
	gohelper.setActive(self._gorightdialogueitem, false)
	gohelper.setActive(self._gomiddialogueItem, false)

	local lPosY = recthelper.getAnchorY(lTrans)
	local rPosY = recthelper.getAnchorY(rTrans)
	local lHeight = recthelper.getHeight(lTrans)

	self._contentMinHeight = recthelper.getHeight(self._godialoguecontainer.transform)
	self._rectTrContent = self._gocontent.transform
	self._uiInfo = {
		stY = lPosY,
		intervalY = math.max(1, math.abs(rPosY - lPosY) - lHeight),
		messageTxtMaxWidth = recthelper.getWidth(lTxtTrans)
	}

	self:_setTimerText(V2a4_WarmUpConfig.instance:getDurationSec())
end

function V2a4_WarmUp_DialogueView:_editableInitView()
	self._topGo = gohelper.findChild(self.viewGO, "Top")
	self._leftGo = gohelper.findChild(self.viewGO, "Left")
	self._animPlayer_Top = csAnimatorPlayer.Get(self._topGo)
	self._animPlayer_Left = csAnimatorPlayer.Get(self._leftGo)
	self._basicInfoItemList = {}
	self._dialogueItemList = {}
	self._modifiledOnceDict = {}
	self._totRoundCount = 0
	self._totCorrectCount = 0
	self._totWrongCount = 0
	self._contentHeight = 0
	self._lastDialogueIndex = 0
	self._lastWaveMO = nil
	self._lastRoundMO = nil
	self._lastDialogCO = nil

	self:_setActive_GlobalClick(false)
	self:_editableInitView_dialogItem()
	gohelper.setActive(self._goitem, false)
	gohelper.setActive(self._goaskphoto, false)
	gohelper.setActive(self._goasktext, false)
	gohelper.setActive(self._goyes, false)
	gohelper.setActive(self._gono, false)
	gohelper.setActive(self._gonext, false)

	self._leftAnimEvent = gohelper.onceAddComponent(self._leftGo, gohelper.Type_AnimationEventWrap)

	self._leftAnimEvent:AddEventListener(kAnimEvt, self._onAnimSwitch, self)
	self:_refreshScoreboard()
end

function V2a4_WarmUp_DialogueView:onUpdateParam()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function V2a4_WarmUp_DialogueView:_level()
	return self.viewParam.level or 1
end

function V2a4_WarmUp_DialogueView:onOpen()
	self._isFirstWave = true

	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	V2a4_WarmUpController.instance:registerCallback(V2a4_WarmUpEvent.onWaveStart, self._onWaveStart, self)
	V2a4_WarmUpController.instance:registerCallback(V2a4_WarmUpEvent.onRoundStart, self._onRoundStart, self)
	V2a4_WarmUpController.instance:registerCallback(V2a4_WarmUpEvent.onMoveStep, self._onMoveStep, self)
	V2a4_WarmUpController.instance:registerCallback(V2a4_WarmUpEvent.onWaveEnd, self._onWaveEnd, self)
	self:onUpdateParam()
end

function V2a4_WarmUp_DialogueView:onOpenFinish()
	local level = self:_level()

	V2a4_WarmUpController.instance:restart(level)
end

function V2a4_WarmUp_DialogueView:onClose()
	self._modifiledOnceDict = {}

	self._leftAnimEvent:RemoveEventListener(kAnimEvt)
	GameUtil.onDestroyViewMember_TweenId(self, "_upTween")
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.cancelTask(self._onWaitAnsOvertime, self)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	V2a4_WarmUpController.instance:unregisterCallback(V2a4_WarmUpEvent.onWaveStart, self._onWaveStart, self)
	V2a4_WarmUpController.instance:unregisterCallback(V2a4_WarmUpEvent.onRoundStart, self._onRoundStart, self)
	V2a4_WarmUpController.instance:unregisterCallback(V2a4_WarmUpEvent.onMoveStep, self._onMoveStep, self)
	V2a4_WarmUpController.instance:unregisterCallback(V2a4_WarmUpEvent.onWaveEnd, self._onWaveEnd, self)
end

function V2a4_WarmUp_DialogueView:onDestroyView()
	GameUtil.onDestroyViewMember_TweenId(self, "_upTween")
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.cancelTask(self._onWaitAnsOvertime, self)
	GameUtil.onDestroyViewMemberList(self, "_dialogueItemList")
	GameUtil.onDestroyViewMemberList(self, "_basicInfoItemList")
end

function V2a4_WarmUp_DialogueView:_onWaveStart(waveMO)
	if self._isFirstWave then
		self._isFirstWave = false

		self:_onWaveStartInner(waveMO)
	else
		self._lastWaveMO = waveMO

		self._animPlayer_Left:Play(UIAnimationName.Switch, self._onAnimSwitchDone, self)
		self:_moveUpToBlank()
	end
end

function V2a4_WarmUp_DialogueView:_isReachBound()
	local realContentHeight = -self._uiInfo.stY
	local dt = self._contentHeight - realContentHeight
	local isReach = Mathf.Approximately(dt, 0)

	return isReach, dt
end

function V2a4_WarmUp_DialogueView:_moveUpToBlank()
	local st = math.max(1, self._lastDialogueIndex)
	local ed = #self._dialogueItemList
	local pageHeight = self._contentMinHeight

	for i = st, ed do
		local item = self._dialogueItemList[i]

		item:setGray(true)
	end

	local isReach, dt = self:_isReachBound()

	self._contentHeight = self._contentHeight + pageHeight

	if not isReach then
		self._contentHeight = self._contentHeight - dt
	end

	recthelper.setHeight(self._rectTrContent, Mathf.Max(self._contentHeight, self._contentMinHeight))
	self:_playUpAnimation()
end

function V2a4_WarmUp_DialogueView:_onAnimSwitchDone()
	if not self._lastWaveMO then
		return
	end

	self:_onWaveStartInner()
end

function V2a4_WarmUp_DialogueView:_onAnimSwitch()
	local waveMO = self._lastWaveMO

	self._lastWaveMO = nil

	self:_onWaveStartInner(waveMO)
end

function V2a4_WarmUp_DialogueView:_onWaveStartInner(waveMO)
	UIBlockHelper.instance:endBlock(kBlockNext)
	gohelper.setActive(self._gonext, false)
	gohelper.setActive(self._goyes, false)
	gohelper.setActive(self._gono, false)
	gohelper.setActive(self._goasktext, waveMO:isRound_Text())
	gohelper.setActive(self._goaskphoto, waveMO:isRound_Photo())
	V2a4_WarmUpController.instance:postWaveStart(waveMO)
end

function V2a4_WarmUp_DialogueView:_refreshTimeTick()
	local remainTimeSec = V2a4_WarmUpBattleModel.instance:getRemainTime()

	remainTimeSec = math.max(0, remainTimeSec)

	self:_setTimerText(remainTimeSec)

	if remainTimeSec <= 0 then
		TaskDispatcher.cancelTask(self._refreshTimeTick, self)
		V2a4_WarmUpController.instance:timeout()
	end
end

function V2a4_WarmUp_DialogueView:_setTimerText(remainTimeSec)
	self._txttime.text = sf(V2a4_WarmUpConfig.instance:getConstStr(2), remainTimeSec)
end

function V2a4_WarmUp_DialogueView:_onWaitAnsOvertime()
	local roundMO, waveMO = V2a4_WarmUpBattleModel.instance:curRound()

	if not roundMO:isWaitAns() or not self:_isLastWaveAndRound(waveMO, roundMO) then
		TaskDispatcher.cancelTask(self._onWaitAnsOvertime, self)

		return
	end

	if not self._lastDialogCO then
		return
	end

	local dialogCO = self._lastDialogCO

	self._lastDialogCO = nil

	if roundMO:isLastStep() then
		self._lastWaveMO = nil
		self._lastRoundMO = nil
	end

	self:_appendDialogueItem(waveMO, roundMO, dialogCO)
end

function V2a4_WarmUp_DialogueView:_onRoundStart(waveMO, roundMO)
	self:_cleanLast()

	self._totRoundCount = self._totRoundCount + 1

	self:_refreshRoundTitle(waveMO, roundMO)
	self:_refreshNpcIcon(waveMO, roundMO)
	self:_refreshNpcInfoList(waveMO, roundMO)
	self:_refreshPhotoIcon(waveMO, roundMO)
	V2a4_WarmUpController.instance:postRoundStart(waveMO, roundMO)
end

function V2a4_WarmUp_DialogueView:_onMoveStep(waveMO, roundMO, dialogCO)
	TaskDispatcher.cancelTask(self._onWaitAnsOvertime, self)

	local isWaitAns = roundMO:isWaitAns()
	local isReplyResult = roundMO:isReplyResult()

	gohelper.setActive(self._goyes, isWaitAns)
	gohelper.setActive(self._gono, isWaitAns)
	gohelper.setActive(self._gonext, false)

	if isWaitAns then
		self._lastDialogCO = dialogCO

		if self:_isLastWaveAndRound(waveMO, roundMO) then
			self:_onWaitAnsOvertime()
		else
			self._lastWaveMO = waveMO
			self._lastRoundMO = roundMO

			TaskDispatcher.runRepeat(self._onWaitAnsOvertime, self, V2a4_WarmUpConfig.instance:getHangonWaitSec())
		end
	elseif isReplyResult then
		self._animPlayer_Top:Play("refresh", nil, nil)

		if not self:_isLastWaveAndRound(waveMO, roundMO) then
			self._lastWaveMO = waveMO
			self._lastRoundMO = roundMO

			if roundMO:isWin() then
				self._totCorrectCount = self._totCorrectCount + 1
			else
				self._totWrongCount = self._totWrongCount + 1
			end

			self:_refreshScoreboard()
		end

		self:_showDialogItemOrStepEnd(waveMO, roundMO, dialogCO)
	else
		self:_cleanLast()
		self:_showDialogItemOrStepEnd(waveMO, roundMO, dialogCO)
	end
end

function V2a4_WarmUp_DialogueView:_showDialogItemOrStepEnd(waveMO, roundMO, dialogCO)
	if not dialogCO then
		self:onStepEnd(waveMO, roundMO)
	else
		self:_appendDialogueItem(waveMO, roundMO, dialogCO)
	end
end

function V2a4_WarmUp_DialogueView:_onWaveEnd(waveMO)
	gohelper.setActive(self._goyes, false)
	gohelper.setActive(self._gono, false)
	gohelper.setActive(self._gonext, true)
end

function V2a4_WarmUp_DialogueView:_appendDialogueItem(waveMO, roundMO, dialogCO)
	local dialogTypeId = dialogCO.group
	local item = self:_create_V2a4_WarmUp_DialogueView_XXXDialogueItem(dialogTypeId)

	table.insert(self._dialogueItemList, item)

	local mo = {
		waveMO = waveMO,
		roundMO = roundMO,
		dialogCO = dialogCO
	}

	item:onUpdateMO(mo)
	self:_setActive_GlobalClick(true)
end

function V2a4_WarmUp_DialogueView:onAddContentItem(pDialogueItemBase, newItemHeight)
	if not self._modifiledOnceDict[pDialogueItemBase] then
		self._modifiledOnceDict[pDialogueItemBase] = {
			contentHeight = self._contentHeight,
			stY = self._uiInfo.stY
		}
	else
		self._uiInfo.stY = self._modifiledOnceDict[pDialogueItemBase].stY
		self._contentHeight = self._modifiledOnceDict[pDialogueItemBase].contentHeight
	end

	local intervalY = self._uiInfo.intervalY
	local addHeight = newItemHeight + intervalY
	local isReach, delta = self:_isReachBound()

	self._contentHeight = isReach and self._contentHeight + addHeight or self._contentHeight + math.max(0, addHeight - delta)
	self._uiInfo.stY = self._uiInfo.stY - addHeight

	recthelper.setHeight(self._rectTrContent, Mathf.Max(self._contentHeight, self._contentMinHeight))
	self:_playUpAnimation()
end

function V2a4_WarmUp_DialogueView:onStepEnd(waveMO, roundMO)
	V2a4_WarmUpController.instance:stepEnd(waveMO, roundMO)
end

function V2a4_WarmUp_DialogueView:_playUpAnimation()
	if self._contentHeight <= self._contentMinHeight then
		return
	end

	GameUtil.onDestroyViewMember_TweenId(self, "_upTween")

	self._upTween = ZProj.TweenHelper.DOTweenFloat(self._scrollcontent.verticalNormalizedPosition, 0, 0.5, self._frameUpdate, self._frameFinished, self)
end

function V2a4_WarmUp_DialogueView:_frameUpdate(value)
	self._scrollcontent.verticalNormalizedPosition = value
end

function V2a4_WarmUp_DialogueView:_frameFinished()
	gohelper.setActive(self._goArrow, false)
end

function V2a4_WarmUp_DialogueView:_refreshRoundTitle(waveMO, roundMO)
	self._txtsmalltitle.text = sf(V2a4_WarmUpConfig.instance:getConstStr(1), self._totRoundCount)
end

function V2a4_WarmUp_DialogueView:_refreshScoreboard(waveMO, roundMO)
	self._txtcorrect.text = tostring(self._totCorrectCount)
	self._txtwrong.text = tostring(self._totWrongCount)
end

function V2a4_WarmUp_DialogueView:_refreshNpcIcon(waveMO, roundMO)
	if not waveMO:isRound_Text() then
		return
	end

	GameUtil.loadSImage(self._simageroleicon, roundMO:resUrl())
end

function V2a4_WarmUp_DialogueView:_refreshPhotoIcon(waveMO, roundMO)
	if not waveMO:isRound_Photo() then
		return
	end

	GameUtil.loadSImage(self._simageimage, roundMO:resUrl())
end

function V2a4_WarmUp_DialogueView:_getNpcBasicInfoIdList(npcId)
	local CO = V2a4_WarmUpConfig.instance:textItemListCO(npcId)

	return {
		CO.info1,
		CO.info2,
		CO.info3,
		CO.info4,
		CO.info5,
		CO.info6
	}
end

function V2a4_WarmUp_DialogueView:_refreshNpcInfoList(waveMO, roundMO)
	if not waveMO:isRound_Text() then
		return
	end

	local npcId = roundMO:cfgId()
	local npcBasicInfoIdList = self:_getNpcBasicInfoIdList(npcId)

	for i, textInfoId in ipairs(npcBasicInfoIdList) do
		local item

		if i > #self._basicInfoItemList then
			item = self:_create_V2a4_WarmUp_DialogueView_BasicInfoItem(i)

			table.insert(self._basicInfoItemList, item)
		else
			item = self._basicInfoItemList[i]
		end

		local isActive = textInfoId ~= 0

		item:setActive(isActive)

		if isActive then
			item:onUpdateMO(textInfoId)
		end
	end

	for i = #npcBasicInfoIdList + 1, #self._basicInfoItemList do
		local item = self._basicInfoItemList[i]

		item:setActive(false)
	end
end

function V2a4_WarmUp_DialogueView:_create_V2a4_WarmUp_DialogueView_BasicInfoItem(index)
	local go = gohelper.cloneInPlace(self._goitem)
	local item = V2a4_WarmUp_DialogueView_BasicInfoItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function V2a4_WarmUp_DialogueView:_create_V2a4_WarmUp_DialogueView_XXXDialogueItem(dialogTypeId)
	local styleCO = V2a4_WarmUpConfig.instance:getDialogStyleCO(dialogTypeId)
	local classDef = _G[styleCO.className]

	assert(classDef)

	local item = classDef.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})
	local go = gohelper.cloneInPlace(item:getTemplateGo())

	gohelper.setActive(go, true)
	item:init(go)
	item:setFontColor(styleCO.fontColor)

	return item
end

function V2a4_WarmUp_DialogueView:flush()
	local item = self._dialogueItemList[#self._dialogueItemList]

	if not item then
		self:_setActive_GlobalClick(false)

		return
	end

	if not item:isFlushed() then
		item:onFlush()
	else
		self:_setActive_GlobalClick(false)
	end
end

function V2a4_WarmUp_DialogueView:_isLastWaveAndRound(waveMO, roundMO)
	return waveMO ~= nil and self._lastWaveMO == waveMO and self._lastRoundMO == roundMO
end

function V2a4_WarmUp_DialogueView:_setActive_GlobalClick(isActive)
	self._allowGlobalClick = isActive
end

function V2a4_WarmUp_DialogueView:_onTouchScreen()
	if not self._allowGlobalClick then
		return
	end

	self:flush()
end

function V2a4_WarmUp_DialogueView:_cleanLast()
	self._lastWaveMO = nil
	self._lastRoundMO = nil
	self._lastDialogCO = nil
end

function V2a4_WarmUp_DialogueView:uiInfo()
	return self._uiInfo
end

return V2a4_WarmUp_DialogueView
