-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_MapChoiceBaseView.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_MapChoiceBaseView", package.seeall)

local Rouge2_MapChoiceBaseView = class("Rouge2_MapChoiceBaseView", BaseView)

function Rouge2_MapChoiceBaseView:onInitView()
	self._goBG = gohelper.findChild(self.viewGO, "#go_BG")
	self._goFullBG = gohelper.findChild(self.viewGO, "#go_BG/#simage_FullBG")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#go_BG/#simage_FullBG")
	self._goTitle = gohelper.findChild(self.viewGO, "Title")
	self._txtName = gohelper.findChildText(self.viewGO, "Title/#txt_Name")
	self._goDialogueList = gohelper.findChild(self.viewGO, "Right/#go_DialogueList")
	self._scrollDialgoue = gohelper.findChild(self.viewGO, "Right/#go_DialogueList/#scroll_Dialogue")
	self._scrollChoiceList = gohelper.findChild(self.viewGO, "Right/#scroll_choiceList")
	self._gochoicecontainer = gohelper.findChild(self.viewGO, "Right/#scroll_choiceList/Viewport/#go_choicecontainer")
	self._godialogueblock = gohelper.findChild(self.viewGO, "#go_dialogueblock")
	self._goAttribute = gohelper.findChild(self.viewGO, "Left/#go_Attribute")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Skip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapChoiceBaseView:addEvents()
	self.scrollClick = gohelper.getClickWithDefaultAudio(self._scrollDialgoue.gameObject)

	self.scrollClick:AddClickListener(self.onClickDialogueBlock, self)

	self.dialogueBlockClick = gohelper.getClickWithDefaultAudio(self._godialogueblock)

	self.dialogueBlockClick:AddClickListener(self.onClickDialogueBlock, self)
	self._btnSkip:AddClickListener(self._btnSkipOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onPlayDialogueDone, self.onPlayDialogueDone, self, LuaEventSystem.High)
end

function Rouge2_MapChoiceBaseView:removeEvents()
	self.scrollClick:RemoveClickListener()
	self.dialogueBlockClick:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
end

function Rouge2_MapChoiceBaseView:_editableInitView()
	Rouge2_AttributeToolBar.Load(self._goAttribute, Rouge2_Enum.AttributeToolType.Skill_Detail)

	self.goRight = gohelper.findChild(self.viewGO, "Right")
	self.choiceItemList = {}

	self:initChoiceTemplate()
	self:initDialogueList()

	self.animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self.rightAnimator = gohelper.onceAddComponent(self.goRight, gohelper.Type_Animator)
	self.showChoice = false

	gohelper.setActive(self._btnSkip.gameObject, false)
end

function Rouge2_MapChoiceBaseView:initDialogueList()
	self._dialogueListComp = Rouge2_MapDialogueListComp.Get(self._goDialogueList, self.viewName)
end

function Rouge2_MapChoiceBaseView:initChoiceTemplate()
	self.goChoiceItem = self.viewContainer:getResInst(Rouge2_Enum.ResPath.MapChoiceItem, self._gochoicecontainer, "#go_ChoiceItem")

	gohelper.setActive(self.goChoiceItem, false)
end

function Rouge2_MapChoiceBaseView:onChangeMapInfo()
	self:closeThis()
end

function Rouge2_MapChoiceBaseView:onClickDialogueBlock()
	self:_initStateHandle()

	local handle = self._stateHandleDict[self.state]

	if handle then
		handle(self)
	end
end

function Rouge2_MapChoiceBaseView:_initStateHandle()
	if self._stateHandleDict then
		return
	end

	self._stateHandleDict = {
		[Rouge2_MapEnum.ChoiceViewState.PlayingDialogue] = self.onClickBlockOnPlayingState,
		[Rouge2_MapEnum.ChoiceViewState.Finish] = self.onClickBlockOnFinishState
	}
end

function Rouge2_MapChoiceBaseView:onClickBlockOnFinishState()
	return
end

function Rouge2_MapChoiceBaseView:onClickBlockOnPlayingState()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.quickSetDialogueDone)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSwitchNextChoiceDialogue)
end

function Rouge2_MapChoiceBaseView:changeState(state)
	if self.state == state then
		return
	end

	self.state = state

	local isBlock = self.state == Rouge2_MapEnum.ChoiceViewState.PlayingDialogue

	gohelper.setActive(self._godialogueblock, isBlock)
	gohelper.setActive(self._gochoicecontainer, self.state == Rouge2_MapEnum.ChoiceViewState.WaitSelect)

	if state == Rouge2_MapEnum.ChoiceViewState.Finish then
		self.scrollClick:RemoveClickListener()
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onChangeChoiceViewState, self.state)
end

function Rouge2_MapChoiceBaseView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewOpen)
	self:initViewData()
	self:changeState(Rouge2_MapEnum.ChoiceViewState.PlayingDialogue)
end

function Rouge2_MapChoiceBaseView:initViewData()
	return
end

function Rouge2_MapChoiceBaseView:onPlayDialogueDone()
	self:changeState(Rouge2_MapEnum.ChoiceViewState.DialogueDone)
end

function Rouge2_MapChoiceBaseView:playChoiceShowAnim()
	if self.showChoice then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewChoiceOpen)
	self.rightAnimator:Play("tochoice", 0, 0)

	self.showChoice = true
end

function Rouge2_MapChoiceBaseView:playChoiceHideAnim()
	if not self.showChoice then
		return
	end

	self.rightAnimator:Play("todialogue", 0, 0)

	self.showChoice = false
end

function Rouge2_MapChoiceBaseView:_btnSkipOnClick()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnJumpToChoiceState)
end

function Rouge2_MapChoiceBaseView:onClose()
	self.closeed = true
end

function Rouge2_MapChoiceBaseView:onDestroyView()
	Rouge2_MapHelper.destroyItemList(self.choiceItemList)
	self._simageFullBG:UnLoadImage()
end

return Rouge2_MapChoiceBaseView
