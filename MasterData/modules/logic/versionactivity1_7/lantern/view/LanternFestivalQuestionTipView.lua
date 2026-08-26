-- chunkname: @modules/logic/versionactivity1_7/lantern/view/LanternFestivalQuestionTipView.lua

module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalQuestionTipView", package.seeall)

local LanternFestivalQuestionTipView = class("LanternFestivalQuestionTipView", BaseView)

function LanternFestivalQuestionTipView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._goanswer = gohelper.findChild(self.viewGO, "Root/#go_answer")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Root/#go_answer/Title/#txt_Title")
	self._txtanswerdescr = gohelper.findChildText(self.viewGO, "Root/#go_answer/Scroll View/Viewport/#txt_answerdescr")
	self._txtAnswer = gohelper.findChildText(self.viewGO, "Root/#go_answer/Anwser/#txt_Answer")
	self._imagePuzzlePic = gohelper.findChildImage(self.viewGO, "Root/#go_answer/#image_PuzzlePic")
	self._goquestion = gohelper.findChild(self.viewGO, "Root/#go_question")
	self._txtquestiontitle = gohelper.findChildText(self.viewGO, "Root/#go_question/Title/#txt_questiontitle")
	self._txtquestiondescr = gohelper.findChildText(self.viewGO, "Root/#go_question/Scroll View/Viewport/#txt_questiondescr")
	self._btnchoice1 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#go_question/Layout/#btn_choice1")
	self._gonormalbg1 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice1/#go_normalbg1")
	self._gofalsebg1 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice1/#go_falsebg1")
	self._gotruebg1 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice1/#go_truebg1")
	self._gofalseicon1 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice1/Layout/#go_falseicon1")
	self._gotrueicon1 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice1/Layout/#go_trueicon1")
	self._txtchoice1 = gohelper.findChildText(self.viewGO, "Root/#go_question/Layout/#btn_choice1/Layout/#txt_choice1")
	self._btnchoice2 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#go_question/Layout/#btn_choice2")
	self._gonormalbg2 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice2/#go_normalbg2")
	self._gofalsebg2 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice2/#go_falsebg2")
	self._gotruebg2 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice2/#go_truebg2")
	self._gofalseicon2 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice2/Layout/#go_falseicon2")
	self._gotrueicon2 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice2/Layout/#go_trueicon2")
	self._txtchoice2 = gohelper.findChildText(self.viewGO, "Root/#go_question/Layout/#btn_choice2/Layout/#txt_choice2")
	self._btnchoice3 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#go_question/Layout/#btn_choice3")
	self._gonormalbg3 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice3/#go_normalbg3")
	self._gofalsebg3 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice3/#go_falsebg3")
	self._gotruebg3 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice3/#go_truebg3")
	self._gofalseicon3 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice3/Layout/#go_falseicon3")
	self._gotrueicon3 = gohelper.findChild(self.viewGO, "Root/#go_question/Layout/#btn_choice3/Layout/#go_trueicon3")
	self._txtchoice3 = gohelper.findChildText(self.viewGO, "Root/#go_question/Layout/#btn_choice3/Layout/#txt_choice3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LanternFestivalQuestionTipView:addEvents()
	self._btnchoice1:AddClickListener(self._btnchoice1OnClick, self)
	self._btnchoice2:AddClickListener(self._btnchoice2OnClick, self)
	self._btnchoice3:AddClickListener(self._btnchoice3OnClick, self)
end

function LanternFestivalQuestionTipView:removeEvents()
	self._btnchoice1:RemoveClickListener()
	self._btnchoice2:RemoveClickListener()
	self._btnchoice3:RemoveClickListener()
end

function LanternFestivalQuestionTipView:_btnchoice1OnClick()
	local state = LanternFestivalModel.instance:getPuzzleOptionState(self._puzzleId, 1)

	if state == LanternFestivalEnum.OptionState.Wrong then
		GameFacade.showToast(ToastEnum.Act1_7LanternFestivalSelectWrongTip)

		return
	elseif state == LanternFestivalEnum.OptionState.Right then
		return
	end

	self:_clickChoice(1)
end

function LanternFestivalQuestionTipView:_btnchoice2OnClick()
	local state = LanternFestivalModel.instance:getPuzzleOptionState(self._puzzleId, 2)

	if state == LanternFestivalEnum.OptionState.Wrong then
		GameFacade.showToast(ToastEnum.Act1_7LanternFestivalSelectWrongTip)

		return
	elseif state == LanternFestivalEnum.OptionState.Right then
		return
	end

	self:_clickChoice(2)
end

function LanternFestivalQuestionTipView:_btnchoice3OnClick()
	local state = LanternFestivalModel.instance:getPuzzleOptionState(self._puzzleId, 3)

	if state == LanternFestivalEnum.OptionState.Wrong then
		GameFacade.showToast(ToastEnum.Act1_7LanternFestivalSelectWrongTip)

		return
	elseif state == LanternFestivalEnum.OptionState.Right then
		return
	end

	self:_clickChoice(3)
end

function LanternFestivalQuestionTipView:_clickChoice(index)
	local actId = ActivityEnum.Activity.LanternFestival
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if actInfoMo and actInfoMo:isExpired() then
		ToastController.instance:showToast(ToastEnum.ActivityEnd)
		self:closeThis()

		return
	end

	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("waitShowResult")
	gohelper.setActive(self["_gonormalbg" .. index], false)

	local isRight = LanternFestivalConfig.instance:getAct154Co(actId, self._day).answerId == index

	gohelper.setActive(self["_gofalseicon" .. index], not isRight)
	gohelper.setActive(self["_gotrueicon" .. index], isRight)
	gohelper.setActive(self["_gofalsebg" .. index], not isRight)
	gohelper.setActive(self["_gotruebg" .. index], isRight)
	self["_aniChoice" .. tostring(index)]:Play("open", 0, 0)

	self._curIndex = index

	AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_checkpoint_continueappear)
	TaskDispatcher.runDelay(self._realSendAnswer, self, 0.5)
end

function LanternFestivalQuestionTipView:_realSendAnswer()
	UIBlockMgr.instance:endBlock("waitShowResult")

	self._newUnlockPuzzle = self._puzzleId

	local activityId = ActivityEnum.Activity.LanternFestival

	Activity154Rpc.instance:sendAnswer154PuzzleRequest(activityId, self._puzzleId, self._curIndex)
end

function LanternFestivalQuestionTipView:onClickModalMask()
	self:closeThis()
end

function LanternFestivalQuestionTipView:_editableInitView()
	return
end

function LanternFestivalQuestionTipView:onUpdateParam()
	return
end

function LanternFestivalQuestionTipView:onOpen()
	self._puzzleId = self.viewParam.puzzleId
	self._day = self.viewParam.day
	self._curIndex = 0

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)

	self._aniChoice1 = gohelper.findChild(self._btnchoice1.gameObject, "Layout"):GetComponent(typeof(UnityEngine.Animator))
	self._aniChoice2 = gohelper.findChild(self._btnchoice2.gameObject, "Layout"):GetComponent(typeof(UnityEngine.Animator))
	self._aniChoice3 = gohelper.findChild(self._btnchoice3.gameObject, "Layout"):GetComponent(typeof(UnityEngine.Animator))
	self._viewAni = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_taskinterface)
	self:_refreshTip(false)
end

function LanternFestivalQuestionTipView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		self:_refreshTip()
		AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_jinye_answer_correct)
		self._viewAni:Play("open", 0, 0)
		UIBlockMgr.instance:startBlock("waitShowOpen")
		TaskDispatcher.runDelay(self._openFinished, self, 3)
	end
end

function LanternFestivalQuestionTipView:_openFinished()
	UIBlockMgr.instance:endBlock("waitShowOpen")
end

function LanternFestivalQuestionTipView:_refreshTip(waitShow)
	local isUnlock = LanternFestivalModel.instance:isPuzzleUnlock(self._puzzleId)

	if not isUnlock then
		self:closeThis()

		return
	end

	local state = LanternFestivalModel.instance:getPuzzleState(self._puzzleId)
	local showAnswer = state == LanternFestivalEnum.PuzzleState.RewardGet

	if not waitShow then
		showAnswer = showAnswer or state == LanternFestivalEnum.PuzzleState.Solved
	end

	gohelper.setActive(self._goanswer, showAnswer)
	gohelper.setActive(self._goquestion, not showAnswer)

	if showAnswer then
		self:_refreshAnswer()
	else
		self:_refreshQuestion()
	end
end

function LanternFestivalQuestionTipView:_refreshQuestion()
	local activity154Co = LanternFestivalConfig.instance:getAct154Co(nil, self._day)

	self._txtquestiontitle.text = activity154Co.puzzleTitle
	self._txtquestiondescr.text = activity154Co.puzzleDesc

	local puzzleCo = LanternFestivalConfig.instance:getAct154Options(self._puzzleId)

	for i = 1, 3 do
		local state = LanternFestivalModel.instance:getPuzzleOptionState(self._puzzleId, i)

		gohelper.setActive(self["_gofalseicon" .. i], state == LanternFestivalEnum.OptionState.Wrong)
		gohelper.setActive(self["_gotrueicon" .. i], state == LanternFestivalEnum.OptionState.Right)
		gohelper.setActive(self["_gonormalbg" .. i], state == LanternFestivalEnum.OptionState.UnAnswer)
		gohelper.setActive(self["_gofalsebg" .. i], state == LanternFestivalEnum.OptionState.Wrong)
		gohelper.setActive(self["_gotruebg" .. i], state == LanternFestivalEnum.OptionState.Right)

		self["_txtchoice" .. i].text = puzzleCo[i].optionText
	end
end

function LanternFestivalQuestionTipView:_refreshAnswer()
	local activity154Co = LanternFestivalConfig.instance:getAct154Co(nil, self._day)

	self._txtTitle.text = activity154Co.puzzleTitle
	self._txtanswerdescr.text = activity154Co.puzzleDesc

	local answerId = LanternFestivalConfig.instance:getPuzzleCo(self._puzzleId).answerId

	self._txtAnswer.text = LanternFestivalConfig.instance:getAct154Options(self._puzzleId)[answerId].optionText

	local co = LanternFestivalConfig.instance:getPuzzleCo(self._puzzleId)

	UISpriteSetMgr.instance:setV1a7LanternSprite(self._imagePuzzlePic, co.puzzleIcon)
end

function LanternFestivalQuestionTipView:onClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)

	if self._newUnlockPuzzle and self._newUnlockPuzzle > 0 and LanternFestivalModel.instance:isPuzzleGiftGet(self._newUnlockPuzzle) then
		LanternFestivalController.instance:dispatchEvent(LanternFestivalEvent.ShowUnlockNewPuzzle, self._newUnlockPuzzle)
	end
end

function LanternFestivalQuestionTipView:onDestroyView()
	return
end

return LanternFestivalQuestionTipView
