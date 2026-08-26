-- chunkname: @modules/logic/versionactivity2_1/activity165/view/Activity165StoryEditView.lua

module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryEditView", package.seeall)

local Activity165StoryEditView = class("Activity165StoryEditView", BaseView)

function Activity165StoryEditView:onInitView()
	self._gostory = gohelper.findChild(self.viewGO, "#go_story")
	self._goending = gohelper.findChild(self.viewGO, "#go_ending")
	self._simagepic = gohelper.findChildImage(self.viewGO, "#go_assessment/#simage_pic")
	self._txtstory = gohelper.findChildText(self.viewGO, "#go_ending/scroll_story/Viewport/#txt_story")
	self._goassessment = gohelper.findChild(self.viewGO, "#go_assessment")
	self._imageassessment = gohelper.findChildImage(self.viewGO, "#go_assessment/#image_assessment")
	self._txtdec = gohelper.findChildText(self.viewGO, "#go_assessment/scroll_dec/Viewport/#txt_dec")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_restart")
	self._gotips = gohelper.findChild(self.viewGO, "#go_story/#go_tips")
	self._gokeywordpanel = gohelper.findChild(self.viewGO, "#go_keywordpanel")
	self._btnkeywordpanelclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_keywordpanel/#btn_close")
	self._gokeywords = gohelper.findChild(self.viewGO, "#go_keywordpanel/scroll_keywords/Viewport/Content/#go_keywords")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_keywordpanel/scroll_keywords/Viewport/Content/#go_keywords/#image_icon")
	self._txtkeywords = gohelper.findChildText(self.viewGO, "#go_keywordpanel/scroll_keywords/Viewport/Content/#go_keywords/#txt_keywords")
	self._btnkeywords = gohelper.findChildButtonWithAudio(self.viewGO, "#go_keywordpanel/scroll_keywords/Viewport/Content/#go_keywords/#btn_keywords")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#go_keywordpanel/#btn_ok")
	self._godragContainer = gohelper.findChild(self.viewGO, "#go_dragContainer")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity165StoryEditView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnkeywords:AddClickListener(self._btnkeywordsOnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self._btnkeywordpanelclose:AddClickListener(self._btnkeywordpanelcloseOnClick, self)
	self:_addEvents()
end

function Activity165StoryEditView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnkeywords:RemoveClickListener()
	self._btnok:RemoveClickListener()
	self._btnkeywordpanelclose:RemoveClickListener()
	self:_removeEvents()
end

function Activity165StoryEditView:_btnconfirmOnClick()
	self:beginGenerateEnding()
end

function Activity165StoryEditView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act165ResetEditor, MsgBoxEnum.BoxType.Yes_No, self._restartStory, nil, nil, self, nil)
end

function Activity165StoryEditView:_btnrestartOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act165ResetEditor, MsgBoxEnum.BoxType.Yes_No, self._restartStory, nil, nil, self, nil)
end

function Activity165StoryEditView:_btndialogcontainerOnClick()
	if self.isEndingAnim then
		gohelper.setActive(self._godialogcontainer.gameObject, false)
		self:_showAssessment()
	end
end

function Activity165StoryEditView:_btnkeywordpanelcloseOnClick()
	local curStepIndex = self._storyMo:getSelectStepIndex()

	self:_closeKwPanel(curStepIndex)
end

function Activity165StoryEditView:_btnokOnClick()
	local curStepIndex = self._storyMo:getSelectStepIndex()

	if self._storyMo:isFillingStep() then
		if curStepIndex and self._curStep then
			local isSuccess = self._storyMo:checkIsFinishStep() or self._curStep:isNullKeyword()

			if isSuccess then
				self:_closeKwPanel(curStepIndex)
			end
		end
	else
		self:_closeKwPanel(curStepIndex)
	end
end

function Activity165StoryEditView:_editableInitView()
	self._goassessmentVX_s = gohelper.findChild(self.viewGO, "#go_assessment/#vx_s")
	self._godialogcontainer = gohelper.findChild(self.viewGO, "#go_dialogcontainer")
	self._btndialog = gohelper.getClick(self._godialogcontainer)

	self._btndialog:AddClickListener(self._btndialogcontainerOnClick, self)
	gohelper.setActive(self._godialogcontainer.gameObject, false)

	self._simagedialogicon = gohelper.findChildSingleImage(self._godialogcontainer, "#go_dialog/container/headframe/headicon")
	self._txtdialog = gohelper.findChildText(self._godialogcontainer, "#go_dialog/container/go_normalcontent/txt_contentcn")
	self._simagedialogbg = gohelper.findChildSingleImage(self._godialogcontainer, "#go_dialog/container/simagebg")
	self._keywordPanelAnim = SLFramework.AnimatorPlayer.Get(self._gokeywordpanel.gameObject)
	self._viewAnim = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)
	self._btnconfirmAnim = self._btnconfirm.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._goexcessive = gohelper.findChild(self.viewGO, "excessive")
	self._endAnim = SLFramework.AnimatorPlayer.Get(self._goending.gameObject)
	self._assessmentAnim = SLFramework.AnimatorPlayer.Get(self._goassessment.gameObject)
	self._assessmentAnimEvent = self._goassessment:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._assessmentAnimEvent:AddEventListener("PlayAudio", self._playAssessmentAudio, self)
end

function Activity165StoryEditView:onUpdateParam()
	return
end

function Activity165StoryEditView:_btnclickOnClick()
	if self._isFinishPlayEnding then
		return
	end

	local state = self._storyMo:getState()

	if state == Activity165Enum.StoryStage.Ending then
		if not self._tweenEndingId then
			return
		end

		self:_killEndingTxtAnim()
		self:_showEndingCallBack()
	else
		if not self._playerStepAnimIndex then
			return
		end

		local item = self._stepItemList[self._playerStepAnimIndex]

		if not item or not item._isUnlock then
			self._playerStepAnimIndex = nil

			return
		end

		self._playerStepAnimIndex = nil

		item:finishStoryAnim()
	end
end

function Activity165StoryEditView:_addEvents()
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.Act165GetInfoReply, self._Act165GetInfoReply, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.Act165RestartReply, self._Act165RestartReply, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.Act165GenerateEndingReply, self._Act165GenerateEndingReply, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.Act165ModifyKeywordReply, self._Act165ModifyKeywordReply, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.onClickStepBtn, self._onClickStepBtn, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.OnFinishStep, self._OnFinishStep, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.onClickUsedKeyword, self._onClickUsedKeyword, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.canfinishStory, self._canfinishStory, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.refrshEditView, self.onRefresh, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.finishStepAnim, self._finishStepAnim, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function Activity165StoryEditView:_removeEvents()
	self._btnclick:RemoveClickListener()

	if self._btndialog then
		self._btndialog:RemoveClickListener()
	end

	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.Act165GetInfoReply, self._Act165GetInfoReply, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.Act165RestartReply, self._Act165RestartReply, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.Act165GenerateEndingReply, self._Act165GenerateEndingReply, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.Act165ModifyKeywordReply, self._Act165ModifyKeywordReply, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.onClickStepBtn, self._onClickStepBtn, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.OnFinishStep, self._OnFinishStep, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.onClickUsedKeyword, self._onClickUsedKeyword, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.canfinishStory, self._canfinishStory, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.refrshEditView, self.onRefresh, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.finishStepAnim, self._finishStepAnim, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self._assessmentAnimEvent:RemoveEventListener("PlayAudio")
end

function Activity165StoryEditView:_onClickStepBtn(index)
	if self._storyMo:getSelectStepIndex() then
		return
	end

	for _, item in ipairs(self._stepItemList) do
		if item:isPlayingTxt() then
			return
		end
	end

	local stepItem = self._stepItemList[index]

	self._storyMo:setSelectStepIndex(index)
	stepItem:refreshFillStepState()

	if self._curStep then
		self._curStep:refreshFillStepState()
	end

	self._curStep = stepItem

	self:_refreshKeywordItem()
	self:_activeKeywordPanel(true)

	local anim = Activity165Enum.EditStepMoveAnim[index].Move

	self._viewAnim:Play(anim, nil, self)

	if self._storyMo:getState() == Activity165Enum.StoryStage.isEndFill then
		gohelper.setActive(self._btnconfirm.gameObject, false)
	end
end

function Activity165StoryEditView:_OnFinishStep(finishSteps)
	self._curfinishStep = finishSteps

	if LuaUtil.tableNotEmpty(finishSteps) then
		self:_onFinishStepItem(1)
	end
end

function Activity165StoryEditView:_onFinishStepItem(index)
	self._finishStepIndex = index

	if index > #self._curfinishStep then
		return
	end

	local unlockStepCount = self._storyMo:unlockStepCount()
	local itemIndex = unlockStepCount - #self._curfinishStep + index - 1

	self._playerStepAnimIndex = itemIndex

	if itemIndex == 3 then
		gohelper.setActive(self._golocked, true)
		self._lockRightAnim:Play(Activity165Enum.EditViewAnim.Unlock, self._hideLockRight, self)
	end

	local stepId = self._curfinishStep[index]
	local stepMo = self._storyMo:getStepMo(stepId)

	if stepMo and stepMo.isEndingStep then
		return
	end

	self._stepItemList[itemIndex]:onFinishStep(stepId)
	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_fill_win)
end

function Activity165StoryEditView:_hideLockRight()
	gohelper.setActive(self._golocked, false)
end

function Activity165StoryEditView:_canfinishStory()
	self:_activeKeywordPanel(false)
	self:_onRefreshStoryState()
	self:_refreshTip()
end

function Activity165StoryEditView:_finishStepAnim()
	if self._finishStepIndex > #self._curfinishStep then
		self._playerStepAnimIndex = nil

		return
	end

	if self._storyMo:getState() ~= Activity165Enum.StoryStage.Filling then
		return
	end

	local stepId = self._curfinishStep[self._finishStepIndex]
	local stepMo = self._storyMo:getStepMo(stepId)

	if stepMo and stepMo.isEndingStep then
		self._storyMo:finishStroy()

		self._playerStepAnimIndex = nil

		return
	end

	local unlockStepCount = self._storyMo:unlockStepCount()
	local itemIndex = unlockStepCount - #self._curfinishStep + self._finishStepIndex
	local nextItem = self._stepItemList[itemIndex]
	local nextStepId = self._curfinishStep[self._finishStepIndex + 1]
	local nextStepMo = self._storyMo:getStepMo(nextStepId)

	if nextStepMo and nextStepMo.isEndingStep then
		self._storyMo:finishStroy()

		self._playerStepAnimIndex = nil

		return
	end

	nextItem:onUpdateMO(nextStepId)

	if self._finishStepIndex + 1 >= #self._curfinishStep then
		nextItem:showEgLock()
	end

	self:_onFinishStepItem(self._finishStepIndex + 1)
end

function Activity165StoryEditView:_onClickUsedKeyword(kwId)
	if self._isDraging or not self._storyMo.curStepIndex then
		return
	end

	self._clickKwId = kwId

	local mo = self._storyMo:getKeywordMo(kwId)

	self:checkKeyword()

	if self._storyMo:isFillingStep() then
		if mo.isUsed then
			if self._curStep and self._curStep:isKeyword(kwId) then
				self._storyMo:removeUseKeywords(kwId)
				self._curStep:removeKeywordItem(kwId)
			end
		else
			self:_tryFillKeyword(kwId, true)
		end
	elseif mo.isUsed or self._curStep:tryFillKeyword() then
		GameFacade.showMessageBox(MessageBoxIdDefine.Act165ResetStep, MsgBoxEnum.BoxType.Yes_No, self._onclickPreStepYesCallback, nil, nil, self)
	end
end

function Activity165StoryEditView:_Act165GetInfoReply()
	self:_refreshStep()
end

function Activity165StoryEditView:_Act165RestartReply(msg)
	if self._clickKwId then
		self:_onClickUsedKeyword(self._clickKwId)
	end

	self:onRefresh()

	self._clickKwId = nil
end

function Activity165StoryEditView:_Act165GenerateEndingReply(msg)
	return
end

function Activity165StoryEditView:_Act165ModifyKeywordReply(msg)
	self:_refreshKeywordItem()
end

function Activity165StoryEditView:onOpen()
	self._actId = Activity165Model.instance:getActivityId()
	self._storyId = self.viewParam.storyId
	self.reviewEnding = self.viewParam.reviewEnding
	self._storyMo = Activity165Model.instance:getStoryMo(self._actId, self._storyId)

	self._storyMo:setReviewEnding(self.reviewEnding)

	self._clickKwId = nil

	self:_createStoryGo()

	self.isEndingAnim = false
	self._isCloseKePanel = false

	self:_onRefreshStoryState()
	self:_activeKeywordPanel(false)
	gohelper.setActive(self._goexcessive.gameObject, false)
	self:_refreshTip()

	self._isFinishPlayEnding = false

	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_enter)
end

function Activity165StoryEditView:onRefresh()
	self:_onRefreshStoryState()
	self:_refreshStep()
	self:_refreshKeywordItem()
end

function Activity165StoryEditView:_onRefreshStoryState()
	local stage = self._storyMo:getState()
	local isStoryFinish = stage == Activity165Enum.StoryStage.isEndFill
	local isEnding = stage == Activity165Enum.StoryStage.Ending

	if isStoryFinish or isEnding then
		local unlockStepCount = self._storyMo:getUnlockStepIdRemoveEndingCount()
		local index = math.min(#self._stepItemList, unlockStepCount)
		local item = self._stepItemList[index + 1]
		local posX = index > 1 and 324 or -484

		if item then
			if not item.goParent.transform.localPosition.y then
				local posY = -200

				recthelper.setAnchor(self._btnconfirm.transform, posX, posY)
				recthelper.setAnchor(self._goending.transform, posX, posY - 100)
				recthelper.setAnchor(self._goassessment.transform, posX, posY - 240)

				if self._storyMo:getUnlockStepIdRemoveEndingCount() > 1 then
					gohelper.setActive(self._golocked, false)
				end
			end
		end
	end

	gohelper.setActive(self._btnconfirm.gameObject, isStoryFinish)
	gohelper.setActive(self._goending.gameObject, isEnding)
	gohelper.setActive(self._goassessment.gameObject, isEnding)
	gohelper.setActive(self._btnreset.gameObject, not isEnding)
	gohelper.setActive(self._btnrestart.gameObject, isEnding and not self.reviewEnding)

	if isEnding then
		self:_showEnding()
	end
end

function Activity165StoryEditView:_createStoryGo()
	local path = self.viewContainer:getSetting().otherRes[1]
	local storyParent = gohelper.findChild(self._gostory, "story")

	self._storyItem = self:getResInst(path, storyParent, "story_" .. self._storyId)
	self._golocked = gohelper.findChild(self._storyItem, "#go_point/#go_locked")
	self._lockRightAnim = SLFramework.AnimatorPlayer.Get(self._golocked.gameObject)
	self._btnclick = gohelper.findChildButtonWithAudio(self._storyItem, "#btn_click")

	self._btnclick:AddClickListener(self._btnclickOnClick, self)

	self._storyAnim = SLFramework.AnimatorPlayer.Get(self._storyItem.gameObject)

	local _stroyName = gohelper.findChildText(self._storyItem, "#txt_title")
	local _beginTxt = gohelper.findChildText(self._storyItem, "begin/scroll_story/Viewport/#txt_dec")
	local _beginIcon = gohelper.findChildImage(self._storyItem, "begin/icon/#image_icon")
	local _beginscroll = gohelper.findChildScrollRect(self._storyItem, "begin/scroll_story")

	if self._storyMo then
		_stroyName.text = self._storyMo:getStoryName(76)

		local firstStep = self._storyMo:getStoryFirstStepMo()

		_beginTxt.text = firstStep and firstStep.stepCo.text

		local icon = firstStep and firstStep.stepCo.pic

		if not string.nilorempty(icon) then
			UISpriteSetMgr.instance:setV2a1Act165Sprite(_beginIcon, icon, true)
		end

		self:_createStepList()
	end

	_beginscroll.verticalNormalizedPosition = 1
end

function Activity165StoryEditView:_createStepList()
	local _goegeroot = gohelper.findChild(self._storyItem, "#go_point/eg")
	local _goeg = gohelper.findChild(_goegeroot, "#go_eg")

	gohelper.setActive(_goeg.gameObject, false)

	local _ponit = gohelper.findChild(self._storyItem, "#go_point/point")
	local _childCount = _ponit.transform.childCount

	gohelper.setActive(_goegeroot, false)

	self._stepItemList = self:getUserDataTb_()

	for i = 1, _childCount do
		local _goChild = gohelper.findChild(_ponit, i)
		local child = gohelper.clone(_goeg, _goChild)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(child, Activity165StepItem)

		item.goParent = _goChild

		item:onInitItem(self._storyMo, i)
		gohelper.setActive(child.gameObject, true)

		self._stepItemList[i] = item
	end

	self:_refreshStep()
end

function Activity165StoryEditView:_refreshStep()
	local stepIds = self._storyMo:getUnlockStepIdRemoveEnding()

	for index, item in pairs(self._stepItemList) do
		item:onUpdateMO(stepIds[index])
	end

	local unlockStepCount = self._storyMo:getUnlockStepIdRemoveEndingCount()

	gohelper.setActive(self._golocked, unlockStepCount < 3)

	if unlockStepCount < 3 then
		self._lockRightAnim:Play(Activity165Enum.EditViewAnim.Idle, nil, self)
	end
end

function Activity165StoryEditView:_refreshTip()
	return
end

function Activity165StoryEditView:_restartStory()
	TaskDispatcher.cancelTask(self._restartStoryCallback, self)
	TaskDispatcher.cancelTask(self._hideExcessive, self)
	gohelper.setActive(self._goexcessive.gameObject, true)
	TaskDispatcher.runDelay(self._restartStoryCallback, self, 0.5)
	TaskDispatcher.runDelay(self._hideExcessive, self, 1)

	self._isFinishPlayEnding = false
end

function Activity165StoryEditView:_restartStoryCallback()
	gohelper.setActive(self._godialogcontainer.gameObject, false)
	self._storyMo:onRestart()
	Activity165Rpc.instance:sendAct165RestartRequest(self._actId, self._storyId, self._storyMo:getFirstStepId())
end

function Activity165StoryEditView:_hideExcessive()
	gohelper.setActive(self._goexcessive.gameObject, false)
end

function Activity165StoryEditView:_onclickPreStepYesCallback()
	self._storyMo:resetStep()

	if self._storyMo.curStepInde then
		for i = self._storyMo.curStepIndex + 1, #self._stepItemList do
			local item = self._stepItemList[i]

			item:clearStep()
		end
	end

	self._curStep:onRefreshMo()

	local unlockStepCount = self._storyMo:getUnlockStepIdRemoveEndingCount()

	gohelper.setActive(self._golocked, unlockStepCount < 3)
end

function Activity165StoryEditView:playCloseAnim(callback, callbackobj)
	if self._storyAnim then
		self._storyAnim:Play(Activity165Enum.EditViewAnim.Close, callback, callbackobj)

		if self._goending.activeSelf then
			self._endAnim:Play(Activity165Enum.EditViewAnim.Close, nil, self)
		end

		if self._goassessment.activeSelf then
			self._assessmentAnim:Play(Activity165Enum.EditViewAnim.Close, nil, self)
		end

		self._viewAnim:Play(Activity165Enum.EditViewAnim.Close, nil, self)
	elseif callback then
		callback(callbackobj)
	end
end

function Activity165StoryEditView:_refreshKeywordItem()
	if self._storyMo then
		self._keywordItems = self:getUserDataTb_()

		local molist = self._storyMo:getKeywordList()

		gohelper.CreateObjList(self, self._createKeywordCallback, molist, self._gokeywords.transform.parent.gameObject, self._gokeywords, Activity165KeywordItem)
	end

	self:_refreshKeywordPanel()
end

function Activity165StoryEditView:_createKeywordCallback(com, data, index)
	com:onUpdateMO(data)
	com:setDragEvent(self._onDragBegin, self._onDrag, self._onDragEnd, self)

	self._keywordItems[data.keywordId] = com
end

function Activity165StoryEditView:_activeKeywordPanel(isActive)
	if not isActive then
		self._storyMo:setSelectStepIndex()

		for _, item in pairs(self._stepItemList) do
			item:refreshFillStepState()
		end
	end

	if isActive then
		if not Activity165Enum.EditViewAnim.Open then
			local anim = Activity165Enum.EditViewAnim.Close

			local function animFinish()
				if not isActive then
					gohelper.setActive(self._gokeywordpanel, false)
					gohelper.setActive(self._gotopleft, true)
				end
			end

			if isActive then
				gohelper.setActive(self._gokeywordpanel, true)
				gohelper.setActive(self._gotopleft, false)
			end

			if self._gokeywordpanel.activeSelf then
				self._keywordPanelAnim:Play(anim, animFinish, self)
			end
		end
	end
end

function Activity165StoryEditView:_refreshKeywordPanel()
	for _, item in pairs(self._keywordItems) do
		item:onRefresh()
	end
end

function Activity165StoryEditView:_onDragBegin(param, pointerEventData)
	if self._isDraging then
		return
	end

	local _keywordId = param
	local _keywordMo = self._storyMo:getKeywordMo(_keywordId)

	if not _keywordMo or _keywordMo.isUsed then
		return
	end

	if self._curStep and self._curStep:isFullKeyword() then
		return
	end

	self:checkKeyword()
	gohelper.setActive(self._godragContainer.gameObject, true)

	self._isDraging = true

	local _dragItem = self:_getDragKeywordItem()

	if _dragItem then
		_dragItem.id = _keywordId

		local co = Activity165Config.instance:getKeywordCo(self._actId, _keywordId)

		if not string.nilorempty(co.pic) then
			UISpriteSetMgr.instance:setV2a1Act165Sprite(self._dragKeywordItem.icon, co.pic)
		end

		gohelper.setActive(self._dragKeywordItem.go, true)

		local _keywordItem = self._keywordItems[_keywordId]

		_keywordItem:Using()
	end

	self:_setDragItemPos()
end

function Activity165StoryEditView:checkKeyword()
	if not self._curStep then
		return
	end

	local stepKws = self._curStep._keywordIdList

	for _, mo in ipairs(self._storyMo:getKeywordList()) do
		if mo.isUsed then
			local id = mo.keywordId

			if not LuaUtil.tableContains(stepKws, id) then
				self._curStep:addKeywordItem(id)
			end
		end
	end
end

function Activity165StoryEditView:_onDrag(param, pointerEventData)
	if not self._isDraging then
		return
	end

	self:_setDragItemPos()

	if self:_isInCurStep() then
		self._curStep:setBogusKeyword(self._dragKeywordItem.id)
	else
		self._curStep:refreshBogusKeyword()
	end
end

function Activity165StoryEditView:_onDragEndEvent()
	self._isDraging = false

	self._curStep:cancelBogusKeyword()

	local isCanDrag = self:_isInCurStep() and self._dragKeywordItem

	self:_tryFillKeyword(self._dragKeywordItem.id, isCanDrag)
	gohelper.setActive(self._dragKeywordItem.go, false)
end

function Activity165StoryEditView:_onDragEnd(param, pointerEventData)
	if not self._isDraging then
		return
	end

	self:_onDragEndEvent()
end

function Activity165StoryEditView:_setDragItemPos()
	if self._dragKeywordItem then
		local _dragPos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self._godragContainer.transform)

		recthelper.setAnchor(self._dragKeywordItem.go.transform, _dragPos.x, _dragPos.y)
	end
end

function Activity165StoryEditView:_getDragKeywordItem()
	if not self._dragKeywordItem then
		local _go = gohelper.findChild(self._gokeywords, "#image_icon")
		local go = gohelper.clone(_go, self._godragContainer, "dragItem")

		self._dragKeywordItem = {}
		self._dragKeywordItem.go = go
		self._dragKeywordItem.icon = go:GetComponent(typeof(UnityEngine.UI.Image))
	end

	return self._dragKeywordItem
end

function Activity165StoryEditView:_tryFillKeyword(kwId, isCanDrag)
	if isCanDrag and self._curStep:tryFillKeyword(kwId) then
		self:_fillKeyword(kwId)
	else
		self:_failFillKeyword(kwId)
	end

	self._clickKwId = nil
end

function Activity165StoryEditView:_fillKeyword(kwId)
	self._curStep:fillKeyword(kwId)
	self._storyMo:fillKeyword(kwId, self._curStep._index)
	self._keywordItems[kwId]:onRefresh()
	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_fill)
end

function Activity165StoryEditView:_failFillKeyword(kwId)
	self._keywordItems[kwId]:clearUsing()
	self._curStep:failFillKeyword(kwId)
end

function Activity165StoryEditView:_isInCurStep()
	if self._curStep then
		local _stepRect = self:_getRectMatrix(self._curStep._btnclick, 500)
		local _dragRect = self:_getRectMatrix(self._dragKeywordItem.go, 0)

		if _stepRect.left > _dragRect.right or _dragRect.left > _stepRect.right or _stepRect.bottom > _dragRect.top or _dragRect.bottom > _stepRect.top then
			return false
		else
			return true
		end
	end
end

function Activity165StoryEditView:_getRectMatrix(go, addRange)
	local posX, posY = recthelper.rectToRelativeAnchorPos2(go.transform.position, self.viewGO.transform)

	return {
		left = posX - go.transform.rect.width * 0.5 - addRange,
		right = posX + go.transform.rect.width * 0.5 + addRange,
		top = posY + go.transform.rect.height * 0.5 + addRange,
		bottom = posY - go.transform.rect.height * 0.5 - addRange
	}
end

function Activity165StoryEditView:_closeKwPanel(curStepIndex)
	if self._isCloseKePanel then
		return
	end

	self._isCloseKePanel = true

	self:_activeKeywordPanel(false)
	self._curStep:refreshFillStepState(false)

	local anim = Activity165Enum.EditStepMoveAnim[curStepIndex].Back

	self._viewAnim:Play(anim, self.backKwPanelCB, self)
end

function Activity165StoryEditView:backKwPanelCB()
	if self._storyMo:getState() == Activity165Enum.StoryStage.isEndFill then
		gohelper.setActive(self._btnconfirm.gameObject, true)
		self._btnconfirmAnim:Play(Activity165Enum.EditViewAnim.story_btn_open, 0, 1)
	end

	self._isCloseKePanel = false
end

function Activity165StoryEditView:beginGenerateEnding()
	gohelper.setActive(self._btnconfirm.gameObject, false)
	gohelper.setActive(self._goending.gameObject, true)
	gohelper.setActive(self._btnreset.gameObject, false)

	self.isEndingAnim = true

	self:_showEnding()
	self._storyMo:generateStroy()
end

function Activity165StoryEditView:generateEndingCallback()
	return
end

function Activity165StoryEditView:_showDialog()
	local co = self:_getEndingCo()

	if co then
		local icon = ResUrl.getHeadIconSmall("309901")
		local dialogConfig = co.text

		self._txtdialog.text = dialogConfig

		if not self._tmpFadeIn then
			local container = gohelper.findChild(self._godialogcontainer, "#go_dialog/container")

			self._tmpFadeIn = MonoHelper.addLuaComOnceToGo(container, TMPFadeIn)
		end

		self._tmpFadeIn:playNormalText(dialogConfig)
		self._simagedialogicon:LoadImage(icon)
		self._simagedialogbg:LoadImage(ResUrl.getFightBattleDialogBg("duihuak_002"))
		gohelper.setActive(self._godialogcontainer.gameObject, true)
	else
		self:_showAssessment()
	end
end

function Activity165StoryEditView:_showEnding()
	self:_killEndingTxtAnim()

	self._txtstory.text = ""

	if self.isEndingAnim then
		self._endAnim:Play(Activity165Enum.EditViewAnim.Play, nil, self)
		self:_doEndingText()
	else
		self:_showEndingCallBack()
	end

	local co = self:_getEndingCo()

	if not co then
		return
	end

	if not string.nilorempty(co.pic) then
		UISpriteSetMgr.instance:setV2a1Act165_2Sprite(self._simagepic, co.pic)
	end

	if not string.nilorempty(co.level) then
		local icon = "v2a1_strangetale_assessment_" .. co.level

		UISpriteSetMgr.instance:setV2a1Act165_2Sprite(self._imageassessment, icon)

		local isS = co.level == Activity165Enum.EndingAssessment.S

		gohelper.setActive(self._goassessmentVX_s, isS)
	end

	self._txtdec.text = co.text
end

function Activity165StoryEditView:_setEndingText()
	self._txtstory.text = self._storyMo:getEndingText()
end

function Activity165StoryEditView:_doEndingText()
	local txt = self._storyMo:getEndingText()

	self._separateChars = Activity165Model.instance:setSeparateChars(txt)
	self._tweenTime = 0
	self._scrollEndingStory = self._scrollEndingStory or gohelper.findChildScrollRect(self.viewGO, "#go_ending/scroll_story")

	local txtLen = #self._separateChars
	local time = txtLen * 0.033

	self._tweenEndingId = ZProj.TweenHelper.DOTweenFloat(1, txtLen, time, self._onTweenFrameCallback, self._showEndingCallBack, self, nil, EaseType.Linear)
end

function Activity165StoryEditView:_onTweenFrameCallback(value)
	if not self.isEndingAnim or value - self._tweenTime < 1 then
		return
	end

	if self._separateChars and value <= #self._separateChars then
		local index = math.floor(value)

		self._txtstory.text = self._separateChars[index]

		if self._scrollEndingStory.verticalNormalizedPosition ~= 0 then
			self._scrollEndingStory.verticalNormalizedPosition = 0
		end
	else
		self:_setEndingText()
	end

	self._tweenTime = value
end

function Activity165StoryEditView:_showEndingCallBack()
	self:_setEndingText()

	if self.isEndingAnim and self._storyMo:isShowDialog() then
		TaskDispatcher.runDelay(self._showDialog, self, 0.3)
	else
		self:_showAssessment()
	end

	self._isFinishPlayEnding = true
end

function Activity165StoryEditView:_getEndingCo()
	return (self._storyMo:getEndingCo())
end

function Activity165StoryEditView:_showAssessment()
	gohelper.setActive(self._btnconfirm.gameObject, false)
	gohelper.setActive(self._goending.gameObject, true)
	gohelper.setActive(self._goassessment.gameObject, true)
	gohelper.setActive(self._btnreset.gameObject, false)
	gohelper.setActive(self._btnrestart.gameObject, not self.reviewEnding)
	gohelper.setActive(self._godragContainer.gameObject, false)
	self._assessmentAnim:Play(Activity165Enum.EditViewAnim.Play, nil, self)

	self.isEndingAnim = false

	if self._storyMo:getUnlockStepIdRemoveEndingCount() > 1 then
		gohelper.setActive(self._golocked, false)
	end
end

function Activity165StoryEditView:_playAssessmentAudio()
	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_generate)
end

function Activity165StoryEditView:onRefreshActivity(actId)
	if actId == Activity165Model.instance:getActivityId() then
		local status = ActivityHelper.getActivityStatusAndToast(actId)
		local isNormal = status == ActivityEnum.ActivityStatus.Normal

		if not isNormal then
			self:closeThis()
			GameFacade.showToast(ToastEnum.ActivityEnd)
		end
	end
end

function Activity165StoryEditView:onClose()
	self._storyMo:setSelectStepIndex()
	self._storyMo:saveStepUseKeywords()
end

function Activity165StoryEditView:onDestroyView()
	TaskDispatcher.cancelTask(self._restartStoryCallback, self)
	TaskDispatcher.cancelTask(self._showEndingCallBack, self)
	TaskDispatcher.cancelTask(self._hideExcessive, self)
	TaskDispatcher.cancelTask(self._showDialog, self)
	self._simagedialogicon:UnLoadImage()
	self._simagedialogbg:UnLoadImage()
	self:_killEndingTxtAnim()
end

function Activity165StoryEditView:_killEndingTxtAnim()
	if self._tweenEndingId then
		ZProj.TweenHelper.KillById(self._tweenEndingId)

		self._tweenEndingId = nil
	end
end

return Activity165StoryEditView
