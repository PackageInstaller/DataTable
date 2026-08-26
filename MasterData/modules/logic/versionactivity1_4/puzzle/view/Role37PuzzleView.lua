-- chunkname: @modules/logic/versionactivity1_4/puzzle/view/Role37PuzzleView.lua

module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleView", package.seeall)

local Role37PuzzleView = class("Role37PuzzleView", BaseView)

Role37PuzzleView.AudioInterval = 0.85
Role37PuzzleView.StartDealy = 1.04
Role37PuzzleView.ResumeWaitDealy = 0.2

function Role37PuzzleView:onInitView()
	self._txtStageName = gohelper.findChildText(self.viewGO, "left/image_StageBG/#txt_StageName")
	self._txtStageEn = gohelper.findChildText(self.viewGO, "left/image_StageBG/#txt_StageEn")
	self._txtround = gohelper.findChildText(self.viewGO, "left/#txt_round")
	self._txtTargetDesc = gohelper.findChildText(self.viewGO, "left/TargetList/Target1/#txt_TargetDesc")
	self._imageTargetFinish = gohelper.findChildImage(self.viewGO, "left/TargetList/Target1/#txt_TargetDesc/#image_TargetFinish")
	self._imageTargetNotFinish = gohelper.findChildImage(self.viewGO, "left/TargetList/Target1/#txt_TargetDesc/#image_TargetNotFinish")
	self._goQuestion = gohelper.findChild(self.viewGO, "QuestionPanelCommon/#go_Question")
	self._txtQuestion = gohelper.findChildText(self.viewGO, "QuestionPanelCommon/#go_Question/#txt_Question")
	self._btnTips = gohelper.findChildButtonWithAudio(self.viewGO, "QuestionPanelCommon/#btn_Tips")
	self._goBaseQuestionPanel = gohelper.findChild(self.viewGO, "#go_BaseQuestionPanel")
	self._scrollAreaList1 = gohelper.findChildScrollRect(self.viewGO, "#go_BaseQuestionPanel/PutArea/put/#scroll_AreaList1")
	self._gostepframes1 = gohelper.findChild(self.viewGO, "#go_BaseQuestionPanel/PutArea/put/#scroll_AreaList1/Viewport/#go_stepframes1")
	self._gosteps1 = gohelper.findChild(self.viewGO, "#go_BaseQuestionPanel/PutArea/put/#scroll_AreaList1/Viewport/#go_steps1")
	self._btnLeftArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_BaseQuestionPanel/PutArea/put/#btn_LeftArrow")
	self._btnRightArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_BaseQuestionPanel/PutArea/put/#btn_RightArrow")
	self._gobaseoper = gohelper.findChild(self.viewGO, "#go_BaseQuestionPanel/OperArea/#go_baseoper")
	self._goFinalQuestionPanel = gohelper.findChild(self.viewGO, "#go_FinalQuestionPanel")
	self._scrollAreaList2 = gohelper.findChildScrollRect(self.viewGO, "#go_FinalQuestionPanel/PutArea/put/#scroll_AreaList2")
	self._gostepframes2 = gohelper.findChild(self.viewGO, "#go_FinalQuestionPanel/PutArea/put/#scroll_AreaList2/Viewport/#go_stepframes2")
	self._gosteps2 = gohelper.findChild(self.viewGO, "#go_FinalQuestionPanel/PutArea/put/#scroll_AreaList2/Viewport/#go_steps2")
	self._btnLeftArrowFinal = gohelper.findChildButtonWithAudio(self.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_LeftArrowFinal")
	self._btnRightArrowFinal = gohelper.findChildButtonWithAudio(self.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_RightArrowFinal")
	self._goprogress = gohelper.findChild(self.viewGO, "#go_FinalQuestionPanel/PutArea/put/#go_progress")
	self._btnStop = gohelper.findChildButtonWithAudio(self.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_Stop")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_Play")
	self._btnpause = gohelper.findChildButtonWithAudio(self.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_pause")
	self._gofinaloper = gohelper.findChild(self.viewGO, "#go_FinalQuestionPanel/OperArea/#go_finaloper")
	self._btnSearch = gohelper.findChildButtonWithAudio(self.viewGO, "Record/Title/#btn_Search")
	self._goRecordEmpty = gohelper.findChild(self.viewGO, "Record/#go_RecordEmpty")
	self._scrollrecord = gohelper.findChildScrollRect(self.viewGO, "Record/#scroll_record")
	self._btnrollback = gohelper.findChildButtonWithAudio(self.viewGO, "top_right/#btn_rollback")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "top_right/#btn_reset")
	self._goprotectArea = gohelper.findChild(self.viewGO, "#go_protectArea")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Role37PuzzleView:addEvents()
	self._btnTips:AddClickListener(self._btnTipsOnClick, self)
	self._btnLeftArrow:AddClickListener(self._btnLeftArrowOnClick, self)
	self._btnRightArrow:AddClickListener(self._btnRightArrowOnClick, self)
	self._btnLeftArrowFinal:AddClickListener(self._btnLeftArrowFinalOnClick, self)
	self._btnRightArrowFinal:AddClickListener(self._btnRightArrowFinalOnClick, self)
	self._btnStop:AddClickListener(self._btnStopOnClick, self)
	self._btnPlay:AddClickListener(self._btnPlayOnClick, self)
	self._btnpause:AddClickListener(self._btnpauseOnClick, self)
	self._btnSearch:AddClickListener(self._btnSearchOnClick, self)
	self._btnrollback:AddClickListener(self._btnrollbackOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function Role37PuzzleView:removeEvents()
	self._btnTips:RemoveClickListener()
	self._btnLeftArrow:RemoveClickListener()
	self._btnRightArrow:RemoveClickListener()
	self._btnLeftArrowFinal:RemoveClickListener()
	self._btnRightArrowFinal:RemoveClickListener()
	self._btnStop:RemoveClickListener()
	self._btnPlay:RemoveClickListener()
	self._btnpause:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
	self._btnrollback:RemoveClickListener()
	self._btnreset:RemoveClickListener()
end

function Role37PuzzleView:_btnTipsOnClick()
	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local decryptId = self.puzzleCfg.puzzleId
	local dialogParam = Activity130Config.instance:getActivity130DecryptCo(actId, decryptId).puzzleTip

	Activity130Controller.instance:dispatchEvent(Activity130Event.ShowTipDialog, dialogParam)
end

function Role37PuzzleView:_btnStopOnClick()
	if self._scrollTweenId then
		ZProj.TweenHelper.KillById(self._scrollTweenId)

		self._scrollTweenId = nil
	end

	gohelper.setActive(self._btnpause, false)
	gohelper.setActive(self._btnPlay, true)
	gohelper.setActive(self._goprotectArea, false)
	self:_stopAudio()
	self._progressAnimation:Play("go_progress_close")
	TaskDispatcher.runDelay(function(self)
		gohelper.setActive(self._goprogress, false)
	end, self, 0.3)
end

function Role37PuzzleView:_btnPlayOnClick()
	self.recordScrollValue = nil
	self.lastStepsX = nil

	if self._goprogress.activeInHierarchy then
		if not self.curKey then
			return
		else
			self:_resumeProgressAnim()
			self:_resumeScrollPos()
			self:_resumeAudio()
		end
	else
		self.maxKey = 0

		for k, _ in pairs(self.operList) do
			if k > self.maxKey then
				self.maxKey = k
			end
		end

		if self.maxKey == 0 then
			return
		else
			gohelper.setActive(self._goprogress, true)

			self._progressAnim.speed = 1

			self:_playAudio()

			self._scrollAreaList2.horizontalNormalizedPosition = 0
		end
	end

	gohelper.setActive(self._btnPlay, false)
	gohelper.setActive(self._btnpause, true)
	gohelper.setActive(self._goprotectArea, true)
end

function Role37PuzzleView:_btnpauseOnClick()
	if self._scrollTweenId then
		ZProj.TweenHelper.KillById(self._scrollTweenId)

		self._scrollTweenId = nil
	end

	gohelper.setActive(self._btnpause, false)
	gohelper.setActive(self._btnPlay, true)
	gohelper.setActive(self._goprotectArea, false)
	self:_pauseAudio()

	self._progressAnim.speed = 0
	self.lastStepsX = recthelper.getAnchorX(self._gosteps.transform)
end

function Role37PuzzleView:_btnLeftArrowOnClick()
	local value = self._scrollAreaList1.horizontalNormalizedPosition

	if value ~= 0 then
		value = value - 0.2

		if value < 0 then
			value = 0
		end

		self._scrollAreaList1.horizontalNormalizedPosition = value
	end
end

function Role37PuzzleView:_btnRightArrowOnClick()
	local value = self._scrollAreaList1.horizontalNormalizedPosition

	if value ~= 1 then
		value = value + 0.2

		if value > 1 then
			value = 1
		end

		self._scrollAreaList1.horizontalNormalizedPosition = value
	end
end

function Role37PuzzleView:_btnLeftArrowFinalOnClick()
	local value = self._scrollAreaList2.horizontalNormalizedPosition

	if value ~= 0 then
		value = value - 0.2

		if value < 0 then
			value = 0
		end

		self._scrollAreaList2.horizontalNormalizedPosition = value
	end
end

function Role37PuzzleView:_btnRightArrowFinalOnClick()
	local value = self._scrollAreaList2.horizontalNormalizedPosition

	if value ~= 1 then
		value = value + 0.2

		if value > 1 then
			value = 1
		end

		self._scrollAreaList2.horizontalNormalizedPosition = value
	end
end

function Role37PuzzleView:_btnSearchOnClick()
	ViewMgr.instance:openView(ViewName.Role37PuzzleRecordView)
end

function Role37PuzzleView:_btnrollbackOnClick()
	Role37PuzzleModel.instance:rollBack()
end

function Role37PuzzleView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130GameRestart, MsgBoxEnum.BoxType.Yes_No, function()
		Activity130Rpc.instance:addGameChallengeNum(Activity130Model.instance:getCurEpisodeId())
		Role37PuzzleModel.instance:reset()
	end)
end

function Role37PuzzleView:_editableInitView()
	self:_editableAddEvents()

	self.transform = self.viewGO.transform

	self:initViewCfg()
	gohelper.setActive(self._btnTips, not self.isFinal)
	self:_playFinalSound()
	self._scrollAreaList:AddOnValueChanged(self._onScrollValueChanged, self)

	self.answerPrefab = gohelper.findChild(self._gosteps, "answeritem")

	gohelper.setActive(self.answerPrefab, false)

	self.dragGo = gohelper.clone(self.answerPrefab, self.viewGO, "dragItem")
	self.dragImgDesc = gohelper.findChildImage(self.dragGo, "img_ItemIcon")
	self.dragImgyyDesc = gohelper.findChildImage(self.dragGo, "img_ItemIcon_yy")
	self.dragAnim = self.dragGo:GetComponent(typeof(UnityEngine.Animator))
	self._goComplete = gohelper.findChild(self.viewGO, "QuestionPanelCommon/anim_Completed")
	self._goVxprogress = gohelper.findChild(self._goprogress, "vx_progress")
	self._progressAnimation = self._goprogress:GetComponent(typeof(UnityEngine.Animation))
	self._progressAnim = self._goVxprogress:GetComponent(typeof(UnityEngine.Animator))
	self.answerList = {}
	self.frameItemList = {}
	self.optionItemList = {}

	self:refreshUI()
end

function Role37PuzzleView:initViewCfg()
	self.puzzleCfg = Role37PuzzleModel.instance:getPuzzleCfg()
	self.puzzleId = self.puzzleCfg.puzzleId
	self.maxOper = self.puzzleCfg.maxOper
	self.operGroupCfg = Role37PuzzleModel.instance:getOperGroupCfg()
	self.operList = Role37PuzzleModel.instance:getOperList()

	if self.puzzleId ~= Role37PuzzleEnum.PuzzleId.Final then
		self.isFinal = false
		self.realOper = self._gobaseoper
		self._gostepframes = self._gostepframes1
		self._gosteps = self._gosteps1
		self._scrollAreaList = self._scrollAreaList1
		self.goLeftArrow = self._btnLeftArrow
		self.goRightArrow = self._btnRightArrow
	else
		self.isFinal = true
		self.realOper = self._gofinaloper
		self._gostepframes = self._gostepframes2
		self._gosteps = self._gosteps2
		self._scrollAreaList = self._scrollAreaList2
		self.goLeftArrow = self._btnLeftArrowFinal
		self.goRightArrow = self._btnRightArrowFinal
	end
end

function Role37PuzzleView:refreshUI()
	local episodeId = Activity130Model.instance:getCurEpisodeId()
	local episodeCfg = Activity130Config.instance:getActivity130EpisodeCo(Activity130Enum.ActivityId.Act130, episodeId)

	if episodeCfg then
		self._txtStageEn.text = episodeCfg.episodetag
		self._txtStageName.text = episodeCfg.name
		self._txtTargetDesc.text = episodeCfg.conditionStr
	end

	self._txtQuestion.text = self.puzzleCfg.puzzleTxt

	gohelper.setActive(self._goBaseQuestionPanel, not self.isFinal)
	gohelper.setActive(self._goFinalQuestionPanel, self.isFinal)

	local cnt = PuzzleRecordListModel.instance:getCount()

	self:onRecordChange(cnt)
	self:_initPutArea()
	self:_initOptionItem()
end

function Role37PuzzleView:_initOptionItem()
	for i = 1, 6 do
		self:_creatOptionItem(i)
	end

	local operGroupList = Role37PuzzleModel.instance:getOperGroupList()

	for i = 1, #operGroupList do
		local operType = operGroupList[i].operType
		local optionItem = self.optionItemList[i]

		if not optionItem then
			optionItem = self:_creatOptionItem(i)

			gohelper.setActive(optionItem.go, true)
		end

		optionItem.button = gohelper.findChildButton(optionItem.go, "")

		optionItem.button:AddClickListener(self._optionClick, self, operType)

		optionItem.uidrag = SLFramework.UGUI.UIDragListener.Get(optionItem.go)

		optionItem.uidrag:AddDragBeginListener(self._optionDragBegin, self, operType)
		optionItem.uidrag:AddDragListener(self._optionDrag, self)
		optionItem.uidrag:AddDragEndListener(self._optionDragEnd, self, operType)

		if not self.isFinal then
			local imgEmpty = gohelper.findChildImage(optionItem.go, "image_Empty")

			gohelper.setActive(imgEmpty, false)

			local imgDesc = gohelper.findChildImage(optionItem.go, "image_Icon")
			local txtDesc = gohelper.findChildText(optionItem.go, "txt_tip")

			UISpriteSetMgr.instance:setV1a4Role37Sprite(imgDesc, operGroupList[i].shapeImg)

			txtDesc.text = operGroupList[i].operDesc

			local nameDesc = gohelper.findChildText(optionItem.go, "txt_Type")

			nameDesc.text = operGroupList[i].name

			gohelper.setActive(imgDesc, true)
			gohelper.setActive(txtDesc, true)
		end
	end
end

function Role37PuzzleView:_creatOptionItem(index)
	local optionItem = self:getUserDataTb_()

	optionItem.go = gohelper.findChild(self.realOper, "option" .. index)
	self.optionItemList[index] = optionItem

	return optionItem
end

function Role37PuzzleView:_initPutArea()
	local stepPrefab = gohelper.findChild(self._gostepframes, "stepframe")

	for i = 1, self.maxOper do
		local frameItem = self:getUserDataTb_()

		frameItem.go = gohelper.cloneInPlace(stepPrefab, "stepframe" .. i)
		frameItem.notPutImage = gohelper.findChildImage(frameItem.go, "noPut")
		frameItem.putImage = gohelper.findChildImage(frameItem.go, "put")
		self.frameItemList[i] = frameItem
	end

	gohelper.setActive(stepPrefab, false)
end

function Role37PuzzleView:_editableAddEvents()
	self.addEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.AddOption, self.onAddOption, self)
	self.addEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.RemoveOption, self.onRemoveOption, self)
	self.addEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.ExchangeOption, self.onExchangeOption, self)
	self.addEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.RepleaceOption, self.onRepleaceOption, self)
	self.addEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.MoveOption, self.onMoveOption, self)
	self.addEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.Reset, self.onReset, self)
	self.addEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.PuzzleResult, self.onPuzzleFinish, self)
	self.addEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.RecordCntChange, self.onRecordChange, self)
	self.addEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.ErrorOperChange, self.onErrorOper, self)
end

function Role37PuzzleView:_editableRemoveEvents()
	self.removeEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.AddOption, self.onAddOption, self)
	self.removeEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.RemoveOption, self.onRemoveOption, self)
	self.removeEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.ExchangeOption, self.onExchangeOption, self)
	self.removeEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.RepleaceOption, self.onRepleaceOption, self)
	self.removeEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.MoveOption, self.onMoveOption, self)
	self.removeEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.Reset, self.onReset, self)
	self.removeEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.PuzzleResult, self.onPuzzleFinish, self)
	self.removeEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.RecordCntChange, self.onRecordChange, self)
	self.removeEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.ErrorOperChange, self.onErrorOper, self)
end

function Role37PuzzleView:onDestroyView()
	self._scrollAreaList:RemoveOnValueChanged()

	for i = 1, tabletool.len(self.operGroupCfg) do
		local optionItem = self.optionItemList[i]

		optionItem.button:RemoveClickListener()
		optionItem.uidrag:RemoveDragBeginListener()
		optionItem.uidrag:RemoveDragListener()
		optionItem.uidrag:RemoveDragEndListener()
	end

	self:_editableRemoveEvents()
	TaskDispatcher.cancelTask(self._playAudioLoop, self)
	AudioMgr.instance:trigger(AudioEnum.UI.resume_plotmusic_sound)
	self:_closeFinalSound()
end

function Role37PuzzleView:_optionClick(option)
	if self.optionDrag then
		return
	end

	local index = Role37PuzzleModel.instance:getFirstGapIndex()

	Role37PuzzleModel.instance:addOption(option, index)

	local audioId = Role37PuzzleModel.instance:getOperAudioId(option)

	AudioMgr.instance:trigger(audioId)
end

function Role37PuzzleView:_optionDragBegin(option, pointerEventData)
	self.optionDrag = true

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_graph_drag)

	local pos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.transform)

	UISpriteSetMgr.instance:setV1a4Role37Sprite(self.dragImgDesc, self.operGroupCfg[option].shapeImg)
	UISpriteSetMgr.instance:setV1a4Role37Sprite(self.dragImgyyDesc, self.operGroupCfg[option].shapeImg .. "_yy")
	gohelper.setActive(self.dragGo, true)
	self.dragAnim:Play("in", 0, 0)
	recthelper.setAnchor(self.dragGo.transform, pos.x, pos.y)
end

function Role37PuzzleView:_optionDrag(param, pointerEventData)
	local pos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.transform)

	if self.optionDrag then
		recthelper.setAnchor(self.dragGo.transform, pos.x, pos.y)
	end
end

function Role37PuzzleView:_optionDragEnd(option, pointerEventData)
	if not self.optionDrag then
		return
	end

	self.optionDrag = false

	self.dragAnim:Play("put", 0, 0)

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.transform)
	local pos

	for i = 1, self.maxOper do
		local screenPos = recthelper.uiPosToScreenPos(self.frameItemList[i].go.transform)
		local uiPos = recthelper.screenPosToAnchorPos(screenPos, self.transform)

		if math.abs(uiPos.x - anchorPos.x) < 75 and math.abs(uiPos.y - anchorPos.y) < 75 then
			pos = i

			break
		end
	end

	if pos then
		Role37PuzzleModel.instance:addOption(option, pos)
		self:_playDragEndAudio(option)
	end

	gohelper.setActive(self.dragGo, false)
end

function Role37PuzzleView:_onScrollValueChanged(value)
	local anchorX = recthelper.getAnchorX(self._gostepframes.transform)

	recthelper.setAnchorX(self._gosteps.transform, anchorX)

	if self.lastStepsX then
		self.recordScrollValue = self.recordScrollValue or self._progressAnim:GetCurrentAnimatorStateInfo(0).normalizedTime

		local dis = anchorX - self.lastStepsX
		local disMove = 0.000748 * dis

		self.recordScrollValue = self.recordScrollValue + disMove

		local animTime = self.recordScrollValue

		if animTime > 1 then
			animTime = 1
		elseif animTime < 0 then
			animTime = 0
		end

		self._progressAnim:Play("play", 0, animTime)

		self.lastStepsX = anchorX
	end

	if value <= 0.01 then
		gohelper.setActive(self.goLeftArrow, false)
		gohelper.setActive(self.goRightArrow, true)
	elseif value >= 0.99 then
		gohelper.setActive(self.goLeftArrow, true)
		gohelper.setActive(self.goRightArrow, false)
	else
		gohelper.setActive(self.goLeftArrow, true)
		gohelper.setActive(self.goRightArrow, true)
	end
end

function Role37PuzzleView:onAddOption(pos)
	local go = gohelper.cloneInPlace(self.answerPrefab)

	gohelper.setActive(go, true)

	go.name = "answerItem" .. pos
	self.answerList[pos] = MonoHelper.addNoUpdateLuaComOnceToGo(go, OptionItem)

	self.answerList[pos]:initParam(pos, self.frameItemList, self.viewGO, self.isFinal)
	self:_skipToPos(pos, self.maxOper)
	self:refreshNum()
	self:setFramePut(pos, true)
end

function Role37PuzzleView:onRemoveOption(pos)
	gohelper.destroy(self.answerList[pos].go)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_delete)

	self.answerList[pos] = nil

	self:refreshNum()
	self:setFramePut(pos, false)
end

function Role37PuzzleView:onExchangeOption(from, to)
	self.answerList[from] = self.answerList[to]
	self.answerList[to] = self.answerList[from]

	self.answerList[from]:updateIndex(from)
	self.answerList[to]:updateIndex(to)
	self.answerList[from]:calculateDefalutPos()
	self.answerList[to]:calculateDefalutPos()
	self.answerList[from]:_setDefalutPos(true)
	self.answerList[to]:_setDefalutPos(true)
	self:refreshNum()
	self:refreshErrorOper()
end

function Role37PuzzleView:onMoveOption(from, to)
	self.answerList[to] = self.answerList[from]
	self.answerList[from] = nil

	self.answerList[to]:updateIndex(to)
	self.answerList[to]:calculateDefalutPos()
	self.answerList[to]:_setDefalutPos(true)
	self:refreshNum()
	self:setFramePut(from, false)
	self:setFramePut(to, true)
end

function Role37PuzzleView:onRepleaceOption(option, pos)
	self.answerList[pos]:updateIndex(pos)
	self.answerList[pos]:refreshSprite()
	self:refreshNum()
end

function Role37PuzzleView:onReset()
	for k, v in pairs(self.answerList) do
		gohelper.destroy(v.go)
		self:setFramePut(k, false)
	end

	self.answerList = {}
	self.operList = Role37PuzzleModel.instance:getOperList()
	self._scrollAreaList.horizontalNormalizedPosition = 0
end

function Role37PuzzleView:onPuzzleFinish(isSucess)
	if isSucess then
		StatActivity130Controller.instance:statSuccess()
	else
		StatActivity130Controller.instance:statFail()
	end

	gohelper.setActive(self._imageTargetFinish, isSucess)
	gohelper.setActive(self._imageTargetNotFinish, not isSucess)

	if isSucess then
		UIBlockMgrExtend.setNeedCircleMv(false)
		gohelper.setActive(self._goQuestion, false)
		gohelper.setActive(self._goComplete, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_completed_writing)
		UIBlockMgr.instance:startBlock("puzzleFinish")
		TaskDispatcher.runDelay(self.onAnimFinish, self, 2)
	else
		Role37PuzzleController.instance:openPuzzleResultView()
	end
end

function Role37PuzzleView:onAnimFinish()
	if self.isFinal then
		self:_btnPlayOnClick()
		TaskDispatcher.runDelay(function()
			UIBlockMgr.instance:endBlock("puzzleFinish")
			Role37PuzzleController.instance:openPuzzleResultView()
		end, nil, 10)
	else
		UIBlockMgr.instance:endBlock("puzzleFinish")
		Role37PuzzleController.instance:openPuzzleResultView()
	end
end

function Role37PuzzleView:onRecordChange(cnt)
	self._txtround.text = string.format(luaLang("v1a4_role37_puzzle_round"), cnt)

	gohelper.setActive(self._goRecordEmpty, cnt <= 0)

	self._scrollrecord.verticalNormalizedPosition = 0
end

function Role37PuzzleView:_skipToPos(pos, maxOper)
	local distance, width

	if self.isFinal then
		local difPos = pos - 9

		if difPos < 0 then
			self._scrollAreaList2.horizontalNormalizedPosition = 0

			return
		end

		local base = 0.015
		local dis = 0.01971
		local value = base + difPos * dis

		if value > 1 then
			value = 1
		end

		self._scrollAreaList2.horizontalNormalizedPosition = value
	else
		local difPos = pos - 6

		if difPos < 0 then
			self._scrollAreaList1.horizontalNormalizedPosition = 0

			return
		end

		local percent = (200 * maxOper + 10 * (maxOper - 1) + 5 - 1380) / (200 * maxOper + 10 * (maxOper - 1) + 5) * maxOper
		local x, basePercent = math.modf(percent)
		local perDis = 1 / percent
		local value = perDis * (basePercent + difPos)

		if value > 1 then
			value = 1
		end

		self._scrollAreaList1.horizontalNormalizedPosition = value
	end
end

function Role37PuzzleView:onErrorOper(errorIndex)
	local errorCnt = Role37PuzzleModel.instance:getErrorCnt()

	if errorCnt == 1 and errorIndex ~= 0 then
		local actId = VersionActivity1_4Enum.ActivityId.Role37
		local decryptId = self.puzzleCfg.puzzleId
		local dialogParam = Activity130Config.instance:getActivity130DecryptCo(actId, decryptId).errorTip

		Activity130Controller.instance:dispatchEvent(Activity130Event.ShowTipDialog, dialogParam)
	end

	self:refreshErrorOper()
end

function Role37PuzzleView:refreshErrorOper()
	local errorIndex = Role37PuzzleModel.instance:getCurErrorIndex()

	if errorIndex == 0 then
		errorIndex = 9999
	end

	for pos, optionItem in pairs(self.answerList) do
		optionItem:setError(errorIndex <= pos)
	end
end

function Role37PuzzleView:_playAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.pause_plotmusic_sound)

	self.curKey = 1

	TaskDispatcher.runDelay(self._playAudioLoop, self, Role37PuzzleView.StartDealy)
end

function Role37PuzzleView:_pauseAudio()
	TaskDispatcher.cancelTask(self._playAudioLoop, self)
end

function Role37PuzzleView:_resumeAudio()
	for k, _ in pairs(self.operList) do
		if k > self.maxKey then
			self.maxKey = k
		end
	end

	self:_playAudioLoop()
	TaskDispatcher.runRepeat(self._playAudioLoop, self, Role37PuzzleView.AudioInterval)
end

function Role37PuzzleView:_stopAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.resume_plotmusic_sound)
	TaskDispatcher.cancelTask(self._playAudioLoop, self)

	self.curAudioId = nil
	self.curKey = nil
end

function Role37PuzzleView:_playAudioLoop()
	if self.curKey then
		if self.curKey == 1 then
			TaskDispatcher.runRepeat(self._playAudioLoop, self, Role37PuzzleView.AudioInterval)
		end

		if self.curKey >= 8 then
			self._progressAnim.speed = 0
		end

		self:_tweenToScrollPos(self.curKey)

		local operType = self.operList[self.curKey]

		if operType then
			self.curAudioId = self.operGroupCfg[operType].audioId

			AudioMgr.instance:trigger(self.curAudioId)
		else
			self:_playEmptyAudio()
		end

		self.curKey = self.curKey + 1

		if self.curKey > self.maxKey then
			TaskDispatcher.runDelay(self._btnStopOnClick, self, Role37PuzzleView.AudioInterval / 2 - 0.1)
		end
	end
end

function Role37PuzzleView:_playEmptyAudio()
	return
end

function Role37PuzzleView:_resumeProgressAnim()
	if self.curKey > 8 then
		self._progressAnim:Play("play", 0, 0.82188)

		self._progressAnim.speed = 1
	else
		local base = 0.9
		local dis = 0.867
		local time = base + (self.curKey - 1) * dis

		self._progressAnim:CrossFadeInFixedTime("play", 0, 0, time)

		self._progressAnim.speed = 1
	end
end

function Role37PuzzleView:_resumeScrollPos()
	if self.curKey > 8 then
		local dis = 0.01971

		self._scrollAreaList2.horizontalNormalizedPosition = (self.curKey - 8) * dis
	else
		self._scrollAreaList2.horizontalNormalizedPosition = 0
	end
end

function Role37PuzzleView:_tweenToScrollPos(pos)
	local difPos = pos - 8

	if difPos < 0 then
		return
	end

	local fromValue = self._scrollAreaList2.horizontalNormalizedPosition
	local dis = 0.01971
	local toValue = fromValue + dis

	if toValue > 1 then
		toValue = 1
	end

	self._scrollTweenId = ZProj.TweenHelper.DOTweenFloat(fromValue, toValue, Role37PuzzleView.AudioInterval, self.setScrollValue, nil, self, nil, EaseType.Linear)
end

function Role37PuzzleView:setScrollValue(value)
	self._scrollAreaList2.horizontalNormalizedPosition = value
end

function Role37PuzzleView:refreshNum()
	local offset = 0

	for i = 1, tabletool.len(self.answerList) do
		local optionItem = self.answerList[i + offset]

		while optionItem == nil do
			offset = offset + 1
			optionItem = self.answerList[i + offset]
		end

		optionItem:setNum(i)
	end
end

function Role37PuzzleView:setFramePut(pos, isPut)
	gohelper.setActive(self.frameItemList[pos].notPutImage, not isPut)
	gohelper.setActive(self.frameItemList[pos].putImage, isPut)
end

function Role37PuzzleView:_playFinalSound()
	if self.isFinal then
		self:_closeFinalSound()

		self._finalSoundId = AudioMgr.instance:trigger(AudioEnum.UI.set_activityvolume_on)
	end
end

function Role37PuzzleView:_closeFinalSound()
	if self._finalSoundId then
		AudioMgr.instance:trigger(AudioEnum.UI.set_activityvolume_off)

		self._finalSoundId = nil
	end
end

function Role37PuzzleView:_playDragEndAudio(operType)
	local curLevelId = Activity130Model.instance:getCurEpisodeId()

	if curLevelId == 7 then
		local audioId = Role37PuzzleModel.instance:getOperAudioId(operType)

		AudioMgr.instance:trigger(audioId)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_graph_put)
	end
end

return Role37PuzzleView
