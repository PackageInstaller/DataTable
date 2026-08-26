-- chunkname: @modules/logic/versionactivity3_6/warmup/view/V3a6_WarmUp_DialogueView.lua

module("modules.logic.versionactivity3_6.warmup.view.V3a6_WarmUp_DialogueView", package.seeall)

local V3a6_WarmUp_DialogueView = class("V3a6_WarmUp_DialogueView", BaseView)

function V3a6_WarmUp_DialogueView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagesmalltalk = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg/Left/node_role/#simage_smalltalk")
	self._gotalking = gohelper.findChild(self.viewGO, "#simage_fullbg/Left/node_role/#go_talking")
	self._txtrolename = gohelper.findChildText(self.viewGO, "#simage_fullbg/Left/node_role/#txt_rolename")
	self._simagesmalicon = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg/Right/go_node1/#simage_smalicon")
	self._simagesmaliconafter = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg/Right/go_node1/#simage_smalicon_after")
	self._btnClickArea = gohelper.findChildButtonWithAudio(self.viewGO, "#simage_fullbg/Right/go_node1/#btn_ClickArea")
	self._godialoguecontainer = gohelper.findChild(self.viewGO, "#simage_fullbg/Right/go_node2/#go_dialoguecontainer")
	self._gocontent = gohelper.findChild(self.viewGO, "#simage_fullbg/Right/go_node2/#go_dialoguecontainer/Scroll View/Viewport/#go_content")
	self._goleftdialogueitem = gohelper.findChild(self.viewGO, "#simage_fullbg/Right/go_node2/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem")
	self._txtcontent = gohelper.findChildText(self.viewGO, "#simage_fullbg/Right/go_node2/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem/content_bg/#txt_content")
	self._goarrow = gohelper.findChild(self.viewGO, "#simage_fullbg/Right/go_node2/#go_dialoguecontainer/#go_arrow")
	self._goreward = gohelper.findChild(self.viewGO, "#simage_fullbg/Right/go_node2/#go_reward")
	self._btnbg = gohelper.findChildButtonWithAudio(self.viewGO, "#simage_fullbg/Right/go_node2/#go_reward/#btn_bg")
	self._gobtnright = gohelper.findChild(self.viewGO, "#go_btnright")
	self._btnauto = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btnright/#btn_auto")
	self._imageautooff = gohelper.findChildImage(self.viewGO, "#go_btnright/#btn_auto/#image_autooff")
	self._imageautoon = gohelper.findChildImage(self.viewGO, "#go_btnright/#btn_auto/#image_autoon")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btnright/#btn_skip")
	self._imageskip = gohelper.findChildImage(self.viewGO, "#go_btnright/#btn_skip/#image_skip")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6_WarmUp_DialogueView:addEvents()
	self._btnClickArea:AddClickListener(self._btnClickAreaOnClick, self)
	self._btnbg:AddClickListener(self._btnbgOnClick, self)
	self._btnauto:AddClickListener(self._btnautoOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
end

function V3a6_WarmUp_DialogueView:removeEvents()
	self._btnClickArea:RemoveClickListener()
	self._btnbg:RemoveClickListener()
	self._btnauto:RemoveClickListener()
	self._btnskip:RemoveClickListener()
end

local ti = table.insert
local sf = string.format
local csTweenHelper = ZProj.TweenHelper
local kBlock_Click = "V3a6_WarmUp_DialogueView:_btnClickAreaOnClick"
local kTimeout = 3
local kUserClickDelaySec = 1.33

function V3a6_WarmUp_DialogueView:_btnClickAreaOnClick()
	UIBlockHelper.instance:startBlock(kBlock_Click, kTimeout, self.viewName)
	self._node1Animator:Play(UIAnimationName.Click, 0, 0)
	AudioMgr.instance:trigger(self.viewContainer:getUserClickAudioId())
	TaskDispatcher.cancelTask(self._onClickAreaDone, self)
	TaskDispatcher.runDelay(self._onClickAreaDone, self, kUserClickDelaySec)
end

function V3a6_WarmUp_DialogueView:_onClickAreaDone()
	TaskDispatcher.cancelTask(self._onClickAreaDone, self)
	UIBlockHelper.instance:endBlock(kBlock_Click)

	local item = self:_getLastItem()

	if self:_bFF() then
		self:onCloseCutScene(item)

		return
	end

	item:doneCutSceen()
end

function V3a6_WarmUp_DialogueView:_btnbgOnClick()
	self:closeThis()
end

function V3a6_WarmUp_DialogueView:_btnautoOnClick()
	if self.viewContainer:isAuto() then
		self.viewContainer:stopAuto()
	else
		self.viewContainer:startAuto()
	end
end

function V3a6_WarmUp_DialogueView:_btnskipOnClick()
	self:_setActive_GlobalClick(false)
	self.viewContainer:doSkip()
end

function V3a6_WarmUp_DialogueView:fastForwardToEnd()
	TaskDispatcher.cancelTask(self._moveStep, self)
	self:onFlush()

	local hasCutSceneItem

	repeat
		local dialogCO = self.viewContainer:pop()
		local isNil = dialogCO == nil

		if not isNil then
			local item = self:_appendDialogueItem(dialogCO)

			if item:hasCutScene() then
				hasCutSceneItem = item
			end
		end
	until isNil or hasCutSceneItem

	if hasCutSceneItem then
		self:_showCutScene(hasCutSceneItem)
	else
		self:_onCompleted()
	end
end

function V3a6_WarmUp_DialogueView:onChangedAuto(bAuto)
	if bAuto then
		local item = self:_getLastItem()

		if not item or item and item:bCompleted() then
			self:_moveStep()
		end
	end

	self:_setActive_autoIcon(bAuto)
end

function V3a6_WarmUp_DialogueView:_setActive_autoIcon(bAuto)
	gohelper.setActive(self._imageautooffGo, not bAuto)
	gohelper.setActive(self._imageautoonGo, bAuto)
end

function V3a6_WarmUp_DialogueView:_editableInitView()
	self._dialogueItemList = {}
	self._contentHeight = 0
	self._modifiledOnceDict = {}
	self._node1Go = gohelper.findChild(self.viewGO, "#simage_fullbg/Right/go_node1")
	self._node2Go = gohelper.findChild(self.viewGO, "#simage_fullbg/Right/go_node2")
	self._scrollcontent = gohelper.findChildScrollRect(self._node2Go, "#go_dialoguecontainer/Scroll View")

	local lTrans = self._goleftdialogueitem.transform
	local lTxtTrans = self._txtcontent.transform
	local lTxtBgGo = gohelper.findChild(self._goleftdialogueitem, "content_bg")
	local lPosY = recthelper.getAnchorY(lTrans)
	local lHeight = recthelper.getHeight(lTrans)

	self._contentMinHeight = recthelper.getHeight(self._godialoguecontainer.transform)
	self._gocontentTrans = self._gocontent.transform
	self._uiInfo = {
		stY = lPosY,
		intervalY = V3a6_WarmUpConfig.instance:getDialogIntervalY(),
		messageTxtMaxWidth = recthelper.getWidth(lTxtTrans)
	}
	self._dummyItem = self:_create_V3a6_WarmUpDialogueItem()

	self._dummyItem:setActive(true)
	self._dummyItem:setActive01(false)

	self._imageautooffGo = self._imageautooff.gameObject
	self._imageautoonGo = self._imageautoon.gameObject
	self._nodeRoleGo = gohelper.findChild(self.viewGO, "#simage_fullbg/Left/node_role")
	self._nodeRoleAnimator = self._nodeRoleGo:GetComponent(gohelper.Type_Animator)
	self._node1Animator = self._node1Go:GetComponent(gohelper.Type_Animator)
	self._txttips = gohelper.findChildText(self._node1Go, "Image/txt_tips")
	self._btnbgGo = self._btnbg.gameObject

	gohelper.setActive(self._goleftdialogueitem, false)
	self:_setActive_GlobalClick(false)
	self:_setActive_goreward(false)
	self:_setActive_nodeGo(false)
	self:_setActive_gobtnright(true)
end

function V3a6_WarmUp_DialogueView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wulu_aizila_forward_paper)
	self:_setActive_autoIcon(self.viewContainer:isAuto())

	self._txttips.text = self.viewContainer:getTipsStr()

	local bPassed, bClaimable, isRecevied = self.viewContainer:getbPassedAndbClaimable()

	gohelper.setActive(self._btnbgGo, not isRecevied)
	self._scrollcontent:AddOnValueChanged(self._onScrollValueChanged, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
end

function V3a6_WarmUp_DialogueView:onOpenFinish()
	self:_moveStep()
	self:_enabledScroll(false)
end

function V3a6_WarmUp_DialogueView:_enabledScroll(bEnabled)
	if not bEnabled then
		self:_setActive_goarrow(false)
	end

	self._scrollcontent.enabled = bEnabled
end

function V3a6_WarmUp_DialogueView:onClose()
	self._scrollcontent:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(self._moveStep, self)
	TaskDispatcher.cancelTask(self._onClickAreaDone, self)
	GameUtil.onDestroyViewMember_TweenId(self, "_upTween")
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)

	self._modifiledOnceDict = {}
end

function V3a6_WarmUp_DialogueView:onDestroyView()
	TaskDispatcher.cancelTask(self._moveStep, self)
	TaskDispatcher.cancelTask(self._onClickAreaDone, self)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	GameUtil.onDestroyViewMember_TweenId(self, "_upTween")
	GameUtil.onDestroyViewMemberList(self, "_dialogueItemList")
	GameUtil.onDestroyViewMemberList(self, "_dummyItem")
end

function V3a6_WarmUp_DialogueView:_isReachBound()
	local realContentHeight = -self._uiInfo.stY
	local dt = self._contentHeight - realContentHeight
	local isReach = GameUtil.isApproxZero(dt)

	return isReach, dt
end

function V3a6_WarmUp_DialogueView:_moveStep()
	TaskDispatcher.cancelTask(self._moveStep, self)

	local lastItem = self:_getLastItem()

	if lastItem and not lastItem:bCompleted() then
		if lastItem:bCutSceneDone() then
			self:stepEnd(lastItem)

			return
		end

		if lastItem:bWaitingCutScene() then
			self:_showCutScene(lastItem)

			return
		end

		self:onFlush(lastItem)

		return
	end

	local dialogCO = self.viewContainer:pop()

	self:_setActive_goarrow(false)

	if not dialogCO then
		self:_onCompleted()
	else
		self:_appendDialogueItem(dialogCO)
	end
end

function V3a6_WarmUp_DialogueView:_appendDialogueItem(dialogCO)
	local item = self:_create_V3a6_WarmUpDialogueItem()
	local resName = "smalltalk/" .. tostring(dialogCO.bg)
	local resUrl = ResUrl.getV3a6WarmUpSingleBg(resName)

	GameUtil.loadSImage(self._simagesmalltalk, resUrl)
	ti(self._dialogueItemList, item)
	item:setActive(true)
	item:onUpdateMO(dialogCO)
	self._nodeRoleAnimator:Play(UIAnimationName.Jump, 0, 0)
	self:_setActive_GlobalClick(true)

	return item
end

function V3a6_WarmUp_DialogueView:_create_V3a6_WarmUpDialogueItem()
	local item = V3a6_WarmUpDialogueItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})
	local go = gohelper.cloneInPlace(self._goleftdialogueitem)

	item:init(go)

	return item
end

function V3a6_WarmUp_DialogueView:onAddContentItem(pDialogueItemBase, newItemHeight)
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

	recthelper.setHeight(self._gocontentTrans, Mathf.Max(self._contentHeight, self._contentMinHeight))
	self:_playUpAnimation()
end

function V3a6_WarmUp_DialogueView:_playUpAnimation()
	if self._contentHeight <= self._contentMinHeight then
		return
	end

	GameUtil.onDestroyViewMember_TweenId(self, "_upTween")

	self._upTween = csTweenHelper.DOTweenFloat(self._scrollcontent.verticalNormalizedPosition, 0, 0.5, self._onFrameUpdate, nil, self)
end

function V3a6_WarmUp_DialogueView:_onFrameUpdate(value)
	self._scrollcontent.verticalNormalizedPosition = value
end

function V3a6_WarmUp_DialogueView:_setActive_GlobalClick(isActive)
	self._allowGlobalClick = isActive
end

function V3a6_WarmUp_DialogueView:onFlush(optItem)
	local item = optItem or self:_getLastItem()

	if not item then
		return
	end

	self:_setActive_GlobalClick(false)
	item:onFlush()
end

function V3a6_WarmUp_DialogueView:onWaitingCutScene(item)
	if self:_bFF() then
		return
	end

	self:_setActive_goarrow(true)

	if self.viewContainer:isAuto() then
		self:_autoResumeOnCutSceneBeginEnd()
	else
		self:_setActive_GlobalClick(true)
	end
end

function V3a6_WarmUp_DialogueView:_showCutScene(item)
	self._node1Animator:Play(UIAnimationName.In, 0, 0)
	self:_setActive_GlobalClick(false)
	self:_setActive_nodeGo(true)
	self:_setActive_gobtnright(false)

	local preUrl, postUrl = self.viewContainer:getCutsceneResUrlPrePost(false)

	GameUtil.loadSImage(self._simagesmalicon, preUrl)
	GameUtil.loadSImage(self._simagesmaliconafter, postUrl)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_ui_molu_exit_appear)
end

function V3a6_WarmUp_DialogueView:onCloseCutScene(item)
	self:_setActive_GlobalClick(true)
	self:_setActive_nodeGo(false)
	self:_setActive_gobtnright(true)
	self:_autoResumeOnCutSceneBeginEnd()

	if self:_bFF() then
		self:fastForwardToEnd()
	end
end

function V3a6_WarmUp_DialogueView:_autoResumeOnCutSceneBeginEnd()
	if self:_bFF() then
		return
	end

	self:_setActive_GlobalClick(true)
	TaskDispatcher.cancelTask(self._moveStep, self)
	TaskDispatcher.runDelay(self._moveStep, self, V3a6_WarmUpConfig.instance:getCutSceneWaitSec())
end

function V3a6_WarmUp_DialogueView:_getLastItem()
	return self._dialogueItemList[#self._dialogueItemList]
end

function V3a6_WarmUp_DialogueView:stepEnd(optItem)
	local item = optItem or self:_getLastItem()

	if not item then
		return
	end

	item:onStepEnd()

	if self.viewContainer:isManually() then
		self:_moveStep()
	end
end

function V3a6_WarmUp_DialogueView:onStepEnd(item)
	TaskDispatcher.cancelTask(self._moveStep, self)
	self:_setActive_GlobalClick(true)
	self:_setActive_goarrow(true)

	if self.viewContainer:isAuto() then
		TaskDispatcher.cancelTask(self._moveStep, self)
		TaskDispatcher.runDelay(self._moveStep, self, V3a6_WarmUpConfig.instance:getSentenceInBetweenSec())
	end
end

function V3a6_WarmUp_DialogueView:_onScrollValueChanged()
	if not self._scrollcontent.enabled then
		return
	end

	local pos01 = self._scrollcontent.verticalNormalizedPosition
	local isZero = GameUtil.isApproxZero(pos01)

	self:_setActive_goarrow(not isZero)
end

function V3a6_WarmUp_DialogueView:_onCompleted()
	TaskDispatcher.cancelTask(self._moveStep, self)
	self:_setActive_GlobalClick(false)
	self:_setActive_gobtnright(false)
	self:_setActive_goarrow(false)
	self:_enabledScroll(true)
	self:_setActive_goreward(true)
	self.viewContainer:markDoneSlient()
end

function V3a6_WarmUp_DialogueView:_onTouchScreen()
	if self:_bFF() then
		return
	end

	if not self._allowGlobalClick then
		return
	end

	self.viewContainer:stopAuto()
	self:_moveStep()
end

function V3a6_WarmUp_DialogueView:uiInfo()
	return self._uiInfo
end

function V3a6_WarmUp_DialogueView:_bFF()
	return self.viewContainer:bFastForwarding()
end

function V3a6_WarmUp_DialogueView:_setActive_nodeGo(isShowNode1)
	gohelper.setActive(self._node1Go, isShowNode1)
	gohelper.setActive(self._node2Go, not isShowNode1)
end

function V3a6_WarmUp_DialogueView:_setActive_gobtnright(isActive)
	gohelper.setActive(self._gobtnright, isActive)
end

function V3a6_WarmUp_DialogueView:_setActive_goreward(isActive)
	gohelper.setActive(self._goreward, isActive)
end

function V3a6_WarmUp_DialogueView:_setActive_goarrow(isActive)
	gohelper.setActive(self._goarrow, isActive)
end

function V3a6_WarmUp_DialogueView:_log()
	local refStrBuf = {}
	local depth = 0
	local tab = string.rep("\t", depth)

	ti(refStrBuf, tab .. sf("_allowGlobalClick? = %s", self._allowGlobalClick and "true" or "false"))

	local item = self:_getLastItem()

	if item then
		ti(refStrBuf, tab .. "V3a6_WarmUpDialogueItem:")
		item:dump(refStrBuf, depth + 1)
	end

	ti(refStrBuf, tab .. "viewContainer:")
	self.viewContainer:dump(refStrBuf, depth + 1)
	logError(table.concat(refStrBuf, "\n"))
end

return V3a6_WarmUp_DialogueView
