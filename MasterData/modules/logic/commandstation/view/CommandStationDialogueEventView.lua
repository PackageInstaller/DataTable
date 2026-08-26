-- chunkname: @modules/logic/commandstation/view/CommandStationDialogueEventView.lua

module("modules.logic.commandstation.view.CommandStationDialogueEventView", package.seeall)

local CommandStationDialogueEventView = class("CommandStationDialogueEventView", BaseView)

function CommandStationDialogueEventView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goOutsideEvent = gohelper.findChild(self.viewGO, "root/#go_OutsideEvent")
	self._btndialogue = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_OutsideEvent/#btn_dialogue")
	self._txtTitle = gohelper.findChildText(self.viewGO, "root/#go_OutsideEvent/#txt_Title")
	self._txtDescr = gohelper.findChildText(self.viewGO, "root/#go_OutsideEvent/Scroll View/Viewport/#txt_Descr")
	self._btnPrevDisable = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_OutsideEvent/#btn_PrevDisable")
	self._btnPrev = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_OutsideEvent/#btn_Prev")
	self._btnNextDisable = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_OutsideEvent/#btn_NextDisable")
	self._btnNext = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_OutsideEvent/#btn_Next")
	self._goOutsideEventPanel = gohelper.findChild(self.viewGO, "root/#go_OutsideEventPanel")
	self._txtTitle2 = gohelper.findChildText(self.viewGO, "root/#go_OutsideEventPanel/#txt_Title2")
	self._gocontent = gohelper.findChild(self.viewGO, "root/#go_OutsideEventPanel/Scroll View/Viewport/#go_content")
	self._goItem = gohelper.findChild(self.viewGO, "root/#go_OutsideEventPanel/Scroll View/Viewport/#go_content/#go_Item")
	self._btnLeftDisable = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_OutsideEventPanel/#btn_LeftDisable")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_OutsideEventPanel/#btn_Left")
	self._btnRightDisable = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_OutsideEventPanel/#btn_RightDisable")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_OutsideEventPanel/#btn_Right")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationDialogueEventView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btndialogue:AddClickListener(self._btndialogueOnClick, self)
	self._btnPrevDisable:AddClickListener(self._btnPrevDisableOnClick, self)
	self._btnPrev:AddClickListener(self._btnPrevOnClick, self)
	self._btnNextDisable:AddClickListener(self._btnNextDisableOnClick, self)
	self._btnNext:AddClickListener(self._btnNextOnClick, self)
	self._btnLeftDisable:AddClickListener(self._btnLeftDisableOnClick, self)
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRightDisable:AddClickListener(self._btnRightDisableOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
end

function CommandStationDialogueEventView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btndialogue:RemoveClickListener()
	self._btnPrevDisable:RemoveClickListener()
	self._btnPrev:RemoveClickListener()
	self._btnNextDisable:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnLeftDisable:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRightDisable:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function CommandStationDialogueEventView:_btnPrevDisableOnClick()
	return
end

function CommandStationDialogueEventView:_btnNextDisableOnClick()
	return
end

function CommandStationDialogueEventView:_btnLeftDisableOnClick()
	return
end

function CommandStationDialogueEventView:_btnRightDisableOnClick()
	return
end

function CommandStationDialogueEventView:_btndialogueOnClick()
	if self._clickTime and Time.time - self._clickTime < 0.5 then
		return
	end

	self._clickTime = Time.time
	self._dialogueCurIndex = self._dialogueCurIndex + 1

	self:_switch(self._outSideEventAnimator, self._updateDialogue)
end

function CommandStationDialogueEventView:_switch(animator, _callback)
	self._switchCallback = _callback

	animator:Play("switch", 0, 0)
	self:_startDelayUpdateDialogue()
end

function CommandStationDialogueEventView:_startDelayUpdateDialogue()
	TaskDispatcher.cancelTask(self._delayUpdateDialogue, self)
	TaskDispatcher.runDelay(self._delayUpdateDialogue, self, 0.167)
end

function CommandStationDialogueEventView:_FocusEvent()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.FocusEvent, self._eventList[self._curIndex])
	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectedEvent, self._eventList[self._curIndex])
end

function CommandStationDialogueEventView:_delayUpdateDialogue()
	self:_switchCallback()
end

function CommandStationDialogueEventView:_btncloseOnClick()
	if self._isShowDialogue then
		self:_btndialogueOnClick()

		return
	end

	self:closeThis()
end

function CommandStationDialogueEventView:_btnPrevOnClick()
	self._curIndex = self._curIndex - 1

	if self._curIndex < 1 then
		self._curIndex = #self._eventList
	end

	self:_changeEvent()
	self:_updateBtnState()
end

function CommandStationDialogueEventView:_btnNextOnClick()
	self._curIndex = self._curIndex + 1

	self:_changeEvent()
	self:_updateBtnState()
end

function CommandStationDialogueEventView:_btnLeftOnClick()
	self._curIndex = self._curIndex - 1

	if self._curIndex > #self._eventList then
		self._curIndex = 1
	end

	self:_changeEvent()
	self:_updateBtnState()
end

function CommandStationDialogueEventView:_btnRightOnClick()
	self._curIndex = self._curIndex + 1

	self:_changeEvent()
	self:_updateBtnState()
end

function CommandStationDialogueEventView:_editableInitView()
	self._goViewport = gohelper.findChild(self.viewGO, "root/#go_OutsideEvent/Scroll View/Viewport")
	self._outSideEventAnimator = self._goOutsideEvent:GetComponent("Animator")
	self._outSidePanelAnimator = self._goOutsideEventPanel:GetComponent("Animator")
	self._goArrow = gohelper.findChild(self.viewGO, "root/#go_OutsideEvent/image_Arrow")

	gohelper.setActive(self._goArrow, false)
end

function CommandStationDialogueEventView:_showDialogueView(visible, isChange)
	self._isShowDialogue = visible

	gohelper.setActive(self._goOutsideEvent, visible)
	gohelper.setActive(self._goOutsideEventPanel, not visible)

	if not visible then
		if isChange then
			self:_switch(self._outSidePanelAnimator, self._showDialogueList)
			AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_paper)
		else
			self:_showDialogueList()
		end
	elseif isChange then
		self:_switch(self._outSideEventAnimator, self._updateDialogue)
	else
		self:_updateDialogue()
	end
end

function CommandStationDialogueEventView:onOpen()
	self._timeId = self.viewParam.timeId
	self._eventId = self.viewParam.eventId

	local list = {}

	tabletool.addValues(list, CommandStationConfig.instance:getEventList(self._timeId, self._eventId))

	self._eventList = list
	self._minIndex = 1
	self._maxIndex = #self._eventList
	self._curIndex = tabletool.indexOf(self._eventList, self._eventId)

	self:_showDialogue(true)
	self:_updateBtnState()
end

function CommandStationDialogueEventView:_showDialogue(skipChange)
	self._dialogueCurIndex = 1
	self._dialogueMaxIndex = 1

	local eventId = self._eventList[self._curIndex]
	local eventConfig = lua_copost_event.configDict[eventId]

	if eventConfig == nil then
		logError("eventConfig is nil")

		return
	end

	self._eventId = eventId
	self._dialogueList = string.splitToNumber(eventConfig.eventTextId, "#")
	self._dialogueMaxIndex = #self._dialogueList
	self._eventConfig = eventConfig
	self._oldState = self._isShowDialogue
	self._isShowDialogue = CommandStationModel.instance:getEventState(self._eventId) ~= CommandStationEnum.EventState.GetReward

	self:_showDialogueView(self._isShowDialogue, not skipChange and self._oldState == self._isShowDialogue)
end

function CommandStationDialogueEventView:_updateDialogue()
	if self._dialogueCurIndex > self._dialogueMaxIndex then
		self:_showDialogueView(false)

		return
	end

	local eventTextId = self._dialogueList[self._dialogueCurIndex]
	local eventTxtConfig = eventTextId and lua_copost_event_text.configDict[eventTextId]

	if eventTxtConfig then
		if not eventTxtConfig.text then
			local content = ""
			local height = GameUtil.getPreferredHeight(self._txtDescr, content)

			self._txtDescr.text = content

			if self._goViewport then
				local maskableGraphic = self._goViewport:GetComponent(typeof(UnityEngine.UI.MaskableGraphic))
				local viewportHeight = recthelper.getHeight(self._goViewport.transform)

				maskableGraphic.raycastTarget = viewportHeight < height
			end

			local characterConfig = eventTxtConfig and lua_copost_character.configDict[eventTxtConfig.chaId]

			self._txtTitle.text = characterConfig and characterConfig.chaName

			gohelper.setActive(self._goArrow, self._dialogueCurIndex < self._dialogueMaxIndex)
		end
	end
end

function CommandStationDialogueEventView:_updateBtnState()
	local showButton = self._maxIndex ~= 1

	gohelper.setActive(self._btnLeft.gameObject, showButton)
	gohelper.setActive(self._btnRight.gameObject, showButton)
	gohelper.setActive(self._btnPrev.gameObject, showButton)
	gohelper.setActive(self._btnNext.gameObject, showButton)
	gohelper.setActive(self._btnLeftDisable.gameObject, false)
	gohelper.setActive(self._btnRightDisable.gameObject, false)
	gohelper.setActive(self._btnPrevDisable.gameObject, false)
	gohelper.setActive(self._btnNextDisable.gameObject, false)
end

function CommandStationDialogueEventView:_changeEvent()
	self:_showDialogue()
	self:_FocusEvent()
end

function CommandStationDialogueEventView:_showDialogueList()
	if not self._dialogueList then
		gohelper.CreateObjList(self, self._onCreateItem, self._dialogueList, self._gocontent, self._goItem)

		if CommandStationModel.instance:getEventState(self._eventId) ~= CommandStationEnum.EventState.GetReward then
			CommandStationRpc.instance:sendFinishCommandPostEventRequest(self._eventId)
		end

		self._txtTitle2.text = self._eventConfig.eventTitleId
	end
end

function CommandStationDialogueEventView:_onCreateItem(obj, eventTextId, index)
	local descTxt = gohelper.findChildText(obj, "")
	local titleTxt = gohelper.findChildText(obj, "txt_Title")
	local eventTxtConfig = eventTextId and lua_copost_event_text.configDict[eventTextId]

	descTxt.text = eventTxtConfig and eventTxtConfig.text

	local characterConfig = eventTxtConfig and lua_copost_character.configDict[eventTxtConfig.chaId]

	titleTxt.text = characterConfig and characterConfig.chaName
end

function CommandStationDialogueEventView:onClose()
	TaskDispatcher.cancelTask(self._delayUpdateDialogue, self)

	if self._isShowDialogue then
		self._outSideEventAnimator:Play("close", 0, 0)
	else
		self._outSidePanelAnimator:Play("close", 0, 0)
	end
end

function CommandStationDialogueEventView:onDestroyView()
	return
end

return CommandStationDialogueEventView
