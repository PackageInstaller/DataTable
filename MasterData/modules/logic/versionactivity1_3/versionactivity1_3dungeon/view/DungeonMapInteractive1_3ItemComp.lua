-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/DungeonMapInteractive1_3ItemComp.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.DungeonMapInteractive1_3ItemComp", package.seeall)

local DungeonMapInteractive1_3ItemComp = class("DungeonMapInteractive1_3ItemComp", BaseView)

function DungeonMapInteractive1_3ItemComp:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnfightuiuse = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fight_ui_use")
	self._txtinfo = gohelper.findChildText(self.viewGO, "rotate/bg/#txt_info")
	self._gomask = gohelper.findChild(self.viewGO, "rotate/bg/#go_mask")
	self._goscroll = gohelper.findChild(self.viewGO, "rotate/bg/#go_mask/#go_scroll")
	self._gochatarea = gohelper.findChild(self.viewGO, "rotate/bg/#go_chatarea")
	self._gochatitem = gohelper.findChild(self.viewGO, "rotate/bg/#go_chatarea/#go_chatitem")
	self._goimportanttips = gohelper.findChild(self.viewGO, "rotate/bg/#go_importanttips")
	self._txttipsinfo = gohelper.findChildText(self.viewGO, "rotate/bg/#go_importanttips/bg/#txt_tipsinfo")
	self._goop1 = gohelper.findChild(self.viewGO, "rotate/#go_op1")
	self._txtdoit = gohelper.findChildText(self.viewGO, "rotate/#go_op1/bg/#txt_doit")
	self._btndoit = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op1/bg/#btn_doit")
	self._goop2 = gohelper.findChild(self.viewGO, "rotate/#go_op2")
	self._gofinishFight = gohelper.findChild(self.viewGO, "rotate/#go_op2/#go_finishFight")
	self._txtwin = gohelper.findChildText(self.viewGO, "rotate/#go_op2/#go_finishFight/bg/#txt_win")
	self._btnwin = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op2/#go_finishFight/bg/#btn_win")
	self._gounfinishedFight = gohelper.findChild(self.viewGO, "rotate/#go_op2/#go_unfinishedFight")
	self._txtfight = gohelper.findChildText(self.viewGO, "rotate/#go_op2/#go_unfinishedFight/bg/#txt_fight")
	self._btnfight = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op2/#go_unfinishedFight/bg/#btn_fight")
	self._goop3 = gohelper.findChild(self.viewGO, "rotate/#go_op3")
	self._gounfinishtask = gohelper.findChild(self.viewGO, "rotate/#go_op3/#go_unfinishtask")
	self._txtunfinishtask = gohelper.findChildText(self.viewGO, "rotate/#go_op3/#go_unfinishtask/#txt_unfinishtask")
	self._btnunfinishtask = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op3/#go_unfinishtask/#btn_unfinishtask")
	self._gofinishtask = gohelper.findChild(self.viewGO, "rotate/#go_op3/#go_finishtask")
	self._txtfinishtask = gohelper.findChildText(self.viewGO, "rotate/#go_op3/#go_finishtask/#txt_finishtask")
	self._btnfinishtask = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op3/#go_finishtask/#btn_finishtask")
	self._goop4 = gohelper.findChild(self.viewGO, "rotate/#go_op4")
	self._gonext = gohelper.findChild(self.viewGO, "rotate/#go_op4/#go_next")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op4/#go_next/#btn_next")
	self._gooptions = gohelper.findChild(self.viewGO, "rotate/#go_op4/#go_options")
	self._gotalkitem = gohelper.findChild(self.viewGO, "rotate/#go_op4/#go_options/#go_talkitem")
	self._gofinishtalk = gohelper.findChild(self.viewGO, "rotate/#go_op4/#go_finishtalk")
	self._btnfinishtalk = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op4/#go_finishtalk/#btn_finishtalk")
	self._goop5 = gohelper.findChild(self.viewGO, "rotate/#go_op5")
	self._gosubmit = gohelper.findChild(self.viewGO, "rotate/#go_op5/#go_submit")
	self._btnsubmit = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op5/#go_submit/#btn_submit")
	self._inputanswer = gohelper.findChildTextMeshInputField(self.viewGO, "rotate/#go_op5/#input_answer")
	self._goop8 = gohelper.findChild(self.viewGO, "rotate/#go_op8")
	self._gopuzzlequestion = gohelper.findChild(self.viewGO, "rotate/#go_op8/#go_puzzle_question")
	self._txtpuzzlequestion = gohelper.findChildText(self.viewGO, "rotate/#go_op8/#go_puzzle_question/#txt_puzzle_question")
	self._btnpuzzlequestion = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op8/#go_puzzle_question/#btn_puzzle_question")
	self._gopuzzlequestionfinish = gohelper.findChild(self.viewGO, "rotate/#go_op8/#go_puzzle_question_finish")
	self._btnpuzzlequestionfinish = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op8/#go_puzzle_question_finish/#btn_puzzle_question_finish")
	self._goop9 = gohelper.findChild(self.viewGO, "rotate/#go_op9")
	self._gopipe = gohelper.findChild(self.viewGO, "rotate/#go_op9/#go_pipe")
	self._txtpuzzlepipe = gohelper.findChildText(self.viewGO, "rotate/#go_op9/#go_pipe/#txt_puzzle_pipe")
	self._btnpuzzlepipe = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op9/#go_pipe/#btn_puzzle_pipe")
	self._gopipefinish = gohelper.findChild(self.viewGO, "rotate/#go_op9/#go_pipe_finish")
	self._btnpipefinish = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op9/#go_pipe_finish/#btn_pipe_finish")
	self._goop10 = gohelper.findChild(self.viewGO, "rotate/#go_op10")
	self._gochangecolor = gohelper.findChild(self.viewGO, "rotate/#go_op10/#go_changecolor")
	self._txtpuzzlechangecolor = gohelper.findChildText(self.viewGO, "rotate/#go_op10/#go_changecolor/#txt_changecolor_pipe")
	self._btnpuzzlechangecolor = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op10/#go_changecolor/#btn_puzzle_changecolor")
	self._gochangecolorfinish = gohelper.findChild(self.viewGO, "rotate/#go_op10/#go_changecolor_finish")
	self._btnchangecolorfinish = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op10/#go_changecolor_finish/#btn_changecolor_finish")
	self._goop12 = gohelper.findChild(self.viewGO, "rotate/#go_op12")
	self._gomazedraw = gohelper.findChild(self.viewGO, "rotate/#go_op12/#go_maze_draw")
	self._txtmazedraw = gohelper.findChildText(self.viewGO, "rotate/#go_op12/#go_maze_draw/#txt_maze_draw")
	self._btnmazedraw = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op12/#go_maze_draw/#btn_maze_draw")
	self._gomazedrawfinish = gohelper.findChild(self.viewGO, "rotate/#go_op12/#go_maze_draw_finish")
	self._btnmazedrawfinish = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op12/#go_maze_draw_finish/#btn_maze_draw_finish")
	self._goop13 = gohelper.findChild(self.viewGO, "rotate/#go_op13")
	self._gocubegame = gohelper.findChild(self.viewGO, "rotate/#go_op13/#go_cube_game")
	self._btncubegame = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op13/#go_cube_game/#btn_cube_game")
	self._gocubegamefinish = gohelper.findChild(self.viewGO, "rotate/#go_op13/#go_cube_game_finish")
	self._btncubegamefinish = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op13/#go_cube_game_finish/#btn_cube_game_finish")
	self._goop15 = gohelper.findChild(self.viewGO, "rotate/#go_op15")
	self._goouijagame = gohelper.findChild(self.viewGO, "rotate/#go_op15/#go_ouija_game")
	self._txtouija = gohelper.findChildText(self.viewGO, "rotate/#go_op15/#go_ouija_game/#txt_ouija_game")
	self._btnouijagame = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op15/#go_ouija_game/#btn_ouija_game")
	self._goouijagamefinish = gohelper.findChild(self.viewGO, "rotate/#go_op15/#go_ouija_game_finish")
	self._btnouijagamefinish = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op15/#go_ouija_game_finish/#btn_ouija_game_finish")
	self._goop101 = gohelper.findChild(self.viewGO, "rotate/#go_op101")
	self._goop101puzzle = gohelper.findChild(self.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle")
	self._txt101puzzle = gohelper.findChildText(self.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle/#txt_puzzle")
	self._btn101puzzle = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle/#btn_puzzle")
	self._goop101puzzlefinish = gohelper.findChild(self.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle_finish")
	self._btn101puzzlefinish = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle_finish/#btn_puzzle_finish")
	self._gorewarditem = gohelper.findChild(self.viewGO, "rotate/layout/top/reward/#go_rewarditem")
	self._txttitle = gohelper.findChildText(self.viewGO, "rotate/layout/top/title/#txt_title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapInteractive1_3ItemComp:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnfightuiuse:AddClickListener(self._btnfightuiuseOnClick, self)
	self._btndoit:AddClickListener(self._btndoitOnClick, self)
	self._btnwin:AddClickListener(self._btnwinOnClick, self)
	self._btnfight:AddClickListener(self._btnfightOnClick, self)
	self._btnunfinishtask:AddClickListener(self._btnunfinishtaskOnClick, self)
	self._btnfinishtask:AddClickListener(self._btnfinishtaskOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnfinishtalk:AddClickListener(self._btnfinishtalkOnClick, self)
	self._btnsubmit:AddClickListener(self._btnsubmitOnClick, self)
	self._btnpuzzlequestion:AddClickListener(self._btnpuzzlequestionOnClick, self)
	self._btnpuzzlequestionfinish:AddClickListener(self._btnpuzzlequestionfinishOnClick, self)
	self._btnpuzzlepipe:AddClickListener(self._btnpuzzlepipeOnClick, self)
	self._btnpipefinish:AddClickListener(self._btnpipefinishOnClick, self)
	self._btnpuzzlechangecolor:AddClickListener(self._btnpuzzlechangecolorOnClick, self)
	self._btnchangecolorfinish:AddClickListener(self._btnchangecolorfinishOnClick, self)
	self._btnmazedraw:AddClickListener(self._btnmazedrawOnClick, self)
	self._btnmazedrawfinish:AddClickListener(self._btnmazedrawfinishOnClick, self)
	self._btncubegame:AddClickListener(self._btnputcubegameOnClick, self)
	self._btncubegamefinish:AddClickListener(self._btnPutCubeGameFinishOnClick, self)
	self._btnouijagame:AddClickListener(self._btnOuijagameOnClick, self)
	self._btnouijagamefinish:AddClickListener(self._btnOuijaGameFinishOnClick, self)
	self._inputanswer:AddOnEndEdit(self._onInputAnswerEndEdit, self)
	self._btn101puzzle:AddClickListener(self._btn101PuzzleGameOnClick, self)
	self._btn101puzzlefinish:AddClickListener(self._btn101PuzzleGameFinishOnClick, self)
end

function DungeonMapInteractive1_3ItemComp:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnfightuiuse:RemoveClickListener()
	self._btndoit:RemoveClickListener()
	self._btnwin:RemoveClickListener()
	self._btnfight:RemoveClickListener()
	self._btnunfinishtask:RemoveClickListener()
	self._btnfinishtask:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnfinishtalk:RemoveClickListener()
	self._btnsubmit:RemoveClickListener()
	self._btnpuzzlequestion:RemoveClickListener()
	self._btnpuzzlequestionfinish:RemoveClickListener()
	self._btnpuzzlepipe:RemoveClickListener()
	self._btnpipefinish:RemoveClickListener()
	self._btnpuzzlechangecolor:RemoveClickListener()
	self._btnchangecolorfinish:RemoveClickListener()
	self._btnmazedraw:RemoveClickListener()
	self._btnmazedrawfinish:RemoveClickListener()
	self._btncubegame:RemoveClickListener()
	self._btncubegamefinish:RemoveClickListener()
	self._btnouijagame:RemoveClickListener()
	self._btnouijagamefinish:RemoveClickListener()
	self._inputanswer:RemoveOnEndEdit()
	self._btn101puzzle:RemoveClickListener()
	self._btn101puzzlefinish:RemoveClickListener()
end

function DungeonMapInteractive1_3ItemComp:_btnfightuiuseOnClick()
	self:_btnfightOnClick()
end

function DungeonMapInteractive1_3ItemComp:_btnsubmitOnClick()
	local text = self._inputanswer:GetText()
	local answer = self._config.param

	if not string.nilorempty(self._config.paramLang) then
		answer = self._config.paramLang
	end

	if self._isRecheck then
		self:_onRecheckFinish()
	elseif text == answer then
		self:_onHide()
		DungeonRpc.instance:sendMapElementRequest(self._config.id)
	else
		self._inputanswer:SetText("")
		GameFacade.showToast(ToastEnum.DungeonMapInteractive)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btncloseOnClick()
	if self._playScrollAnim then
		return
	end

	if self._isRecheck then
		DungeonController.instance:onAgainOpenRecheckView(self._config.id)
	end

	self:_onHide()
end

function DungeonMapInteractive1_3ItemComp:_closeMapInteractiveItem()
	self:_onHide()
end

function DungeonMapInteractive1_3ItemComp:_btnfinishtalkOnClick()
	self:_onHide()

	local dialogIds = DungeonMapModel.instance:getDialogId()

	DungeonRpc.instance:sendMapElementRequest(self._config.id, dialogIds)
	DungeonMapModel.instance:clearDialogId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btndoitOnClick()
	self:_onHide()

	if self._isRecheck then
		self:_onRecheckFinish()
	else
		DungeonRpc.instance:sendMapElementRequest(self._config.id)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btnfightOnClick()
	self:_onHide()

	local episodeId = tonumber(self._config.param)

	DungeonModel.instance.curLookEpisodeId = episodeId

	if TeachNoteModel.instance:isTeachNoteEpisode(episodeId) then
		TeachNoteController.instance:enterTeachNoteDetailView(episodeId)
	else
		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btnwinOnClick()
	self:_onHide()

	if self._isRecheck then
		self:_onRecheckFinish()
	else
		DungeonRpc.instance:sendMapElementRequest(self._config.id)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btnunfinishtaskOnClick()
	self:_onHide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btnfinishtaskOnClick()
	self:_onHide()

	if self._isRecheck then
		self:_onRecheckFinish()
	else
		DungeonRpc.instance:sendMapElementRequest(self._config.id)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btnnextOnClick()
	if self._playScrollAnim then
		return
	end

	self:_playNextSectionOrDialog()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btnpuzzlequestionOnClick()
	self:_asynHide(ViewName.DungeonPuzzleQuestionView)
	DungeonPuzzleQuestionModel.instance:initByElementCo(self._config)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleQuestionView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btnpuzzlequestionfinishOnClick()
	self:_onHide()

	if self._isRecheck then
		self:_onRecheckFinish()
	else
		DungeonRpc.instance:sendMapElementRequest(self._config.id)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btnpuzzlepipeOnClick()
	if self._config.type == DungeonEnum.ElementType.CircuitGame then
		self:_asynHide(ViewName.DungeonPuzzleCircuitView)
		DungeonPuzzleCircuitController.instance:openGame(self._config)

		return
	end

	self:_asynHide(ViewName.DungeonPuzzlePipeView)
	DungeonPuzzlePipeController.instance:openGame(self._config)
end

function DungeonMapInteractive1_3ItemComp:_btnpipefinishOnClick()
	self:_onHide()

	if self._isRecheck then
		self:_onRecheckFinish()
	else
		DungeonRpc.instance:sendMapElementRequest(self._config.id)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btnpuzzlechangecolorOnClick()
	self:_asynHide(ViewName.DungeonPuzzleChangeColorView)
	DungeonPuzzleChangeColorController.instance:enterDecryptChangeColor(tonumber(self._config.param))
end

function DungeonMapInteractive1_3ItemComp:_btnmazedrawOnClick()
	self:_asynHide(ViewName.DungeonPuzzleMazeDrawView)
	DungeonPuzzleMazeDrawController.instance:openGame(self._config)
end

function DungeonMapInteractive1_3ItemComp:_btnmazedrawfinishOnClick()
	self:_onHide()

	if self._isRecheck then
		self:_onRecheckFinish()
	else
		DungeonRpc.instance:sendMapElementRequest(self._config.id)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btnputcubegameOnClick()
	self:_asynHide(ViewName.PutCubeGameView)
	DungeonController.instance:openPutCubeGameView(self._config)
end

function DungeonMapInteractive1_3ItemComp:_btnPutCubeGameFinishOnClick()
	self:_onHide()

	if self._isRecheck then
		self:_onRecheckFinish()
	else
		DungeonRpc.instance:sendMapElementRequest(self._config.id)
	end
end

function DungeonMapInteractive1_3ItemComp:_btnOuijagameOnClick()
	self:_asynHide(ViewName.DungeonPuzzleOuijaView)
	AudioMgr.instance:trigger(AudioEnum.PuzzleOuija.play_ui_checkpoint_boat_open)
	DungeonController.instance:openOuijaGameView(self._config)
end

function DungeonMapInteractive1_3ItemComp:_btnOuijaGameFinishOnClick()
	self:_onHide()

	if self._isRecheck then
		self:_onRecheckFinish()
	else
		DungeonRpc.instance:sendMapElementRequest(self._config.id)
	end
end

function DungeonMapInteractive1_3ItemComp:_btnchangecolorfinishOnClick()
	self:_onHide()

	if self._isRecheck then
		self:_onRecheckFinish()
	else
		DungeonRpc.instance:sendMapElementRequest(self._config.id)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btn101PuzzleGameOnClick()
	self:_onHide()
	ViewMgr.instance:openView(ViewName.VersionActivityPuzzleView, {
		elementCo = self._config
	})
end

function DungeonMapInteractive1_3ItemComp:_btn101PuzzleGameFinishOnClick()
	self:_onHide()

	if self._isRecheck then
		self:_onRecheckFinish()
	else
		DungeonRpc.instance:sendMapElementRequest(self._config.id)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_btntalkitemOnClick()
	return
end

function DungeonMapInteractive1_3ItemComp:_editableInitView()
	DungeonMapModel.instance:setMapInteractiveItemVisible(true)

	self._nextAnimator = self._gonext:GetComponent(typeof(UnityEngine.Animator))
	self._imgMask = self._gomask:GetComponent(gohelper.Type_Image)
	self._simagebgimage = gohelper.findChildSingleImage(self.viewGO, "rotate/bg/bgimag")
	self._simageanswerbg = gohelper.findChildSingleImage(self.viewGO, "rotate/#go_op5/#input_answer")

	self:_loadBgImage()
	self._simageanswerbg:LoadImage(ResUrl.getDungeonInteractiveItemBg("zhangjiedatidi_071"))

	self._goplaceholdertext = gohelper.findChild(self.viewGO, "rotate/#go_op5/#input_answer/Text Area/Placeholder")

	SLFramework.UGUI.UIClickListener.Get(self._inputanswer.gameObject):AddClickListener(self._hidePlaceholderText, self)
end

function DungeonMapInteractive1_3ItemComp:_loadBgImage()
	self._simagebgimage:LoadImage("singlebg/v1a3_dungeon_singlebg/v1a3_dungeoninteractive_panelbg.png")
end

function DungeonMapInteractive1_3ItemComp:_onScreenResize()
	DungeonMapModel.instance.directFocusElement = true

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, self._config.id)

	DungeonMapModel.instance.directFocusElement = false
end

function DungeonMapInteractive1_3ItemComp:_hidePlaceholderText()
	gohelper.setActive(self._goplaceholdertext, false)
end

function DungeonMapInteractive1_3ItemComp:_onInputAnswerEndEdit()
	gohelper.setActive(self._goplaceholdertext, true)
end

function DungeonMapInteractive1_3ItemComp:_playAnim(go, name)
	local animator = go:GetComponent(typeof(UnityEngine.Animator))

	animator:Play(name)
end

function DungeonMapInteractive1_3ItemComp:_playBtnsQuitAnim()
	for _, value in pairs(DungeonEnum.ElementType) do
		local go = self["_goop" .. value]

		if go and go.activeInHierarchy then
			local anims = go:GetComponentsInChildren(typeof(UnityEngine.Animator))
			local iter = anims:GetEnumerator()

			while iter:MoveNext() do
				iter.Current:Play("dungeonmap_interactive_btn_out")
			end
		end
	end
end

function DungeonMapInteractive1_3ItemComp:_onShow()
	if self._show then
		return
	end

	self._show = true

	DungeonMapModel.instance:clearDialog()
	DungeonMapModel.instance:clearDialogId()
	gohelper.setActive(self.viewGO, true)
	self._animator:Play("dungeonmap_interactive_in")
	self:_playAnim(self._gonext, "dungeonmap_interactive_in")
	TaskDispatcher.cancelTask(self._showCloseBtn, self)
	TaskDispatcher.runDelay(self._showCloseBtn, self, 0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function DungeonMapInteractive1_3ItemComp:_showCloseBtn()
	gohelper.setActive(self._btnclose.gameObject, true)
end

function DungeonMapInteractive1_3ItemComp:_onOutAnimationFinished()
	gohelper.setActive(self.viewGO, false)
	UIBlockMgr.instance:endBlock("dungeonmap_interactive_out")
	gohelper.destroy(self.viewGO)
end

function DungeonMapInteractive1_3ItemComp:_asynHide(viewName)
	if not viewName then
		logError("_asynHide viewName is nil")

		return
	end

	self._waitCloseViewName = viewName

	if not self._show then
		return
	end

	self:_clearScroll()

	self._show = false

	gohelper.setActive(self.viewGO, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
end

function DungeonMapInteractive1_3ItemComp:_onHide()
	if not self._show then
		return
	end

	self:_clearScroll()

	self._show = false

	gohelper.setActive(self._btnclose.gameObject, false)
	UIBlockMgr.instance:startBlock("dungeonmap_interactive_out")
	self._animator:Play("dungeonmap_interactive_out")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
	self:_playBtnsQuitAnim()
	TaskDispatcher.runDelay(self._onOutAnimationFinished, self, 0.23)

	if SLFramework.FrameworkSettings.IsEditor then
		local x, y = transformhelper.getPos(self.viewGO.transform)
		local deltaX = x - self._elementAddX
		local deltaY = y - self._elementAddY

		if deltaX ~= 0 or deltaY ~= 0 then
			deltaX = x - self._elementX
			deltaY = y - self._elementY

			print(string.format("偏移坐标xy：%s#%s", string.format(x - self._elementX == 0 and "%s" or "%.2f", x - self._elementX), string.format(y - self._elementY == 0 and "%s" or "%.2f", y - self._elementY)))
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

function DungeonMapInteractive1_3ItemComp:_onViewClose(viewName)
	if viewName == self._waitCloseViewName then
		self:_cancelAsynHide()
	end
end

function DungeonMapInteractive1_3ItemComp:_onClickElement()
	self:_cancelAsynHide()
end

function DungeonMapInteractive1_3ItemComp:_cancelAsynHide()
	self._waitCloseViewName = nil

	gohelper.destroy(self.viewGO)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

function DungeonMapInteractive1_3ItemComp:init(go)
	self.viewGO = go
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._optionBtnList = self:getUserDataTb_()
	self._dialogItemList = self:getUserDataTb_()
	self._dialogItemCacheList = self:getUserDataTb_()

	self:onInitView()
	self:addEvents()
	self:_editableAddEvents()
end

function DungeonMapInteractive1_3ItemComp:_editableAddEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.closeMapInteractiveItem, self._closeMapInteractiveItem, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onViewClose, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnClickElement, self._onClickElement, self, LuaEventSystem.High)

	self._handleTypeMap = {}
	self._handleTypeMap[DungeonEnum.ElementType.None] = self._directlyComplete
	self._handleTypeMap[DungeonEnum.ElementType.Fight] = self._showFight
	self._handleTypeMap[DungeonEnum.ElementType.Task] = self._showTask
	self._handleTypeMap[DungeonEnum.ElementType.Story] = self._playStory
	self._handleTypeMap[DungeonEnum.ElementType.Question] = self._playQuestion
	self._handleTypeMap[DungeonEnum.ElementType.FullScreenQuestion] = self._showPuzzleQuestion
	self._handleTypeMap[DungeonEnum.ElementType.PipeGame] = self._showPuzzlePipeGame
	self._handleTypeMap[DungeonEnum.ElementType.ChangeColor] = self._showPuzzleChangeColor
	self._handleTypeMap[DungeonEnum.ElementType.MazeDraw] = self._showPuzzleMazeDraw
	self._handleTypeMap[DungeonEnum.ElementType.PutCubeGame] = self._showPutCubeGame
	self._handleTypeMap[DungeonEnum.ElementType.CircuitGame] = self._showPuzzlePipeGame
	self._handleTypeMap[DungeonEnum.ElementType.OuijaGame] = self._showOuijaGame
	self._handleTypeMap[DungeonEnum.ElementType.PuzzleGame] = self._showPuzzleGame
end

function DungeonMapInteractive1_3ItemComp:_showElementTitle()
	self._txttitle.text = self._config.title
end

function DungeonMapInteractive1_3ItemComp:_OnClickElement(mapElement)
	self._mapElement = mapElement

	if self._show then
		self:_onHide()

		return
	end

	self:_onShow()

	self._isRecheck = nil
	self._config = self._mapElement._config
	self._elementGo = self._mapElement._go

	self:_showElementTitle()

	self._elementX, self._elementY, self._elementZ = transformhelper.getPos(self._elementGo.transform)

	if not string.nilorempty(self._config.offsetPos) then
		local offsetPos = string.splitToNumber(self._config.offsetPos, "#")

		self._elementAddX = self._elementX + (offsetPos[1] or 0)
		self._elementAddY = self._elementY + (offsetPos[2] or 0)
	end

	self.viewGO.transform.position = Vector3(self._elementAddX, self._elementAddY, 0)

	self:_showRewards()

	local showTip = not string.nilorempty(self._config.flagText)

	gohelper.setActive(self._goimportanttips, showTip)

	if showTip then
		self._txttipsinfo.text = self._config.flagText
	end

	local interactType = self._config.type
	local isStoryType = interactType == DungeonEnum.ElementType.Story

	gohelper.setActive(self._txtinfo.gameObject, not isStoryType)
	gohelper.setActive(self._gochatarea, isStoryType)

	for _, value in pairs(DungeonEnum.ElementType) do
		local go = self["_goop" .. value]

		if go then
			gohelper.setActive(go, value == interactType)
		end
	end

	if interactType == DungeonEnum.ElementType.CircuitGame then
		gohelper.setActive(self._goop9, true)
	end

	local handleFunc = self._handleTypeMap[interactType]

	if handleFunc then
		handleFunc(self)
	else
		logError("element type undefined!")
	end
end

function DungeonMapInteractive1_3ItemComp:_onRecheckFinish()
	if not self._config then
		return
	end

	DungeonController.instance:onRecheckFragmentInfoView(self._config)
end

function DungeonMapInteractive1_3ItemComp:onRecheck(elementCo, posX, posY)
	if not elementCo then
		return
	end

	self._isRecheck = true

	self:_onShow()

	self._config = elementCo

	self:_showElementTitle()
	self:_refreshType()

	self._elementX = posX or 0
	self._elementY = posY or 0
	self._elementAddX = self._elementX
	self._elementAddY = self._elementY
	self.viewGO.transform.localPosition = Vector3(posX or 0, posY or 0, 0)

	self:_showRewards()

	local showTip = not string.nilorempty(self._config.flagText)

	gohelper.setActive(self._goimportanttips, showTip)

	if showTip then
		self._txttipsinfo.text = self._config.flagText
	end

	local interactType = self._config.type
	local isStoryType = interactType == DungeonEnum.ElementType.Story

	gohelper.setActive(self._txtinfo.gameObject, not isStoryType)
	gohelper.setActive(self._gochatarea, isStoryType)

	for _, value in pairs(DungeonEnum.ElementType) do
		local go = self["_goop" .. value]

		if go then
			gohelper.setActive(go, value == interactType)
		end
	end

	if interactType == DungeonEnum.ElementType.CircuitGame then
		gohelper.setActive(self._goop9, true)
	end

	local handleFunc = self._handleTypeMap[interactType]

	if handleFunc then
		handleFunc(self)
	else
		self:_btncloseOnClick()
	end
end

function DungeonMapInteractive1_3ItemComp:_showRewards()
	local rewardGo = gohelper.findChild(self.viewGO, "rotate/layout/top/reward")
	local rewardStr = DungeonModel.instance:getMapElementReward(self._config.id)
	local rewardList = GameUtil.splitString2(rewardStr, true, "|", "#")

	if not rewardList then
		gohelper.setActive(rewardGo, false)

		return
	end

	gohelper.setActive(rewardGo, true)

	for i, reward in ipairs(rewardList) do
		local go = gohelper.cloneInPlace(self._gorewarditem)

		gohelper.setActive(go, true)
	end

	self._rewardClick = gohelper.getClick(gohelper.findChild(rewardGo, "click"))

	self._rewardClick:AddClickListener(self._openRewardView, self, rewardList)
end

function DungeonMapInteractive1_3ItemComp:_openRewardView(rewardList)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	DungeonController.instance:openDungeonElementRewardView(rewardList)
end

function DungeonMapInteractive1_3ItemComp:_playQuestion()
	self._txtinfo.text = self._config.desc
end

function DungeonMapInteractive1_3ItemComp:_showFight()
	local episodeId = tonumber(self._config.param)
	local finishedFight = DungeonModel.instance:hasPassLevel(episodeId)

	gohelper.setActive(self._gofinishFight, finishedFight)
	gohelper.setActive(self._gounfinishedFight, not finishedFight)

	if finishedFight then
		self._txtinfo.text = self._config.finishText
	else
		self._txtinfo.text = self._config.desc
		self._txtfight.text = self._config.acceptText
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.MoveFightBtn2MapView) then
		TaskDispatcher.runDelay(self._addToMapView, self, 0.5)
	end
end

function DungeonMapInteractive1_3ItemComp:_addToMapView()
	gohelper.setActive(self._btnfightuiuse.gameObject, true)

	local dungeonMapView = ViewMgr.instance:getContainer(ViewName.DungeonMapView)
	local dungeonMapViewGo = dungeonMapView.viewGO
	local camera = CameraMgr.instance:getMainCamera()
	local worldPos = self._btnfightuiuse.transform.position
	local rectPos = recthelper.worldPosToAnchorPos(worldPos, dungeonMapViewGo.transform, nil, camera)

	self._btnfightuiuse.transform.parent = dungeonMapViewGo.transform

	transformhelper.setLocalPosXY(self._btnfightuiuse.transform, rectPos.x, rectPos.y)
end

function DungeonMapInteractive1_3ItemComp:_showTask()
	self._txtinfo.text = self._config.desc

	local paramStr = self._config.param
	local itemParam = string.splitToNumber(paramStr, "#")
	local needNum = itemParam[3]
	local itemConfig = ItemModel.instance:getItemConfig(itemParam[1], itemParam[2])
	local quantity = ItemModel.instance:getItemQuantity(itemParam[1], itemParam[2])

	self._finishTask = needNum <= quantity

	gohelper.setActive(self._gofinishtask, self._finishTask)
	gohelper.setActive(self._gounfinishtask, not self._finishTask)

	local langTxt = luaLang("dungeon_map_submit_new")

	if self._finishTask then
		self._txtfinishtask.text = GameUtil.getSubPlaceholderLuaLangThreeParam(langTxt, itemConfig.name, quantity, needNum)
	else
		self._txtunfinishtask.text = GameUtil.getSubPlaceholderLuaLangThreeParam(langTxt, itemConfig.name, quantity, needNum)
	end
end

function DungeonMapInteractive1_3ItemComp:_showPuzzleQuestion()
	local isClear = DungeonMapModel.instance:hasMapPuzzleStatus(self._config.id)

	if isClear then
		self._txtinfo.text = self._config.finishText
	else
		self._txtpuzzlequestion.text = self._config.acceptText
		self._txtinfo.text = self._config.desc
	end

	self._gopuzzlequestion:SetActive(not isClear)
	self._gopuzzlequestionfinish.gameObject:SetActive(isClear)
end

function DungeonMapInteractive1_3ItemComp:_showPuzzlePipeGame()
	local isClear = DungeonMapModel.instance:hasMapPuzzleStatus(self._config.id)

	if isClear then
		self._txtinfo.text = self._config.finishText
	else
		self._txtpuzzlepipe.text = self._config.acceptText
		self._txtinfo.text = self._config.desc
	end

	self._gopipe:SetActive(not isClear)
	self._gopipefinish:SetActive(isClear)
end

function DungeonMapInteractive1_3ItemComp:_showPuzzleChangeColor()
	local isClear
end

function DungeonMapInteractive1_3ItemComp:_showPuzzleMazeDraw()
	local isClear = DungeonMapModel.instance:hasMapPuzzleStatus(self._config.id)

	if isClear then
		self._txtinfo.text = self._config.finishText
	else
		self._txtmazedraw.text = self._config.acceptText
		self._txtinfo.text = self._config.desc
	end

	self._gomazedraw:SetActive(not isClear)
	self._gomazedrawfinish:SetActive(isClear)
end

function DungeonMapInteractive1_3ItemComp:_showPutCubeGame()
	return
end

function DungeonMapInteractive1_3ItemComp:_showOuijaGame()
	local isClear = DungeonMapModel.instance:hasMapPuzzleStatus(self._config.id)

	if isClear then
		self._txtinfo.text = self._config.finishText
	else
		self._txtouija.text = self._config.acceptText
		self._txtinfo.text = self._config.desc
	end

	self._goouijagame:SetActive(not isClear)
	self._goouijagamefinish:SetActive(isClear)
end

function DungeonMapInteractive1_3ItemComp:_showPuzzleGame()
	local isFinish = DungeonMapModel.instance:hasMapPuzzleStatus(self._config.id)

	if isFinish then
		self._txtinfo.text = self._config.finishText
	else
		self._txt101puzzle.text = self._config.acceptText
		self._txtinfo.text = self._config.desc
	end

	self._goop101puzzle:SetActive(not isFinish)
	self._goop101puzzlefinish:SetActive(isFinish)
end

function DungeonMapInteractive1_3ItemComp:_directlyComplete()
	self._txtdoit.text = self._config.acceptText
	self._txtinfo.text = self._config.desc
end

function DungeonMapInteractive1_3ItemComp:_playNextSectionOrDialog()
	self:_clearDialog()

	if #self._sectionList >= self._dialogIndex then
		self:_playNextDialog()

		return
	end

	local prevSectionInfo = table.remove(self._sectionStack)

	self:_playSection(prevSectionInfo[1], prevSectionInfo[2])
end

function DungeonMapInteractive1_3ItemComp:_playStory()
	self:_clearDialog()

	self._sectionStack = {}
	self._dialogId = tonumber(self._config.param)

	self:_playSection(0)
end

function DungeonMapInteractive1_3ItemComp:_playSection(sectionId, dialogIndex)
	self:_setSectionData(sectionId, dialogIndex)
	self:_playNextDialog()
end

function DungeonMapInteractive1_3ItemComp:_setSectionData(sectionId, dialogIndex)
	self._sectionList = DungeonConfig.instance:getDialog(self._dialogId, sectionId)
	self._dialogIndex = dialogIndex or 1
	self._sectionId = sectionId
end

function DungeonMapInteractive1_3ItemComp:_playNextDialog()
	local config = self._sectionList[self._dialogIndex]

	self._dialogIndex = self._dialogIndex + 1

	if config.type == "dialog" then
		self:_showDialog("dialog", config.content, config.speaker, config.audio)
	end

	if #self._sectionStack > 0 and #self._sectionList < self._dialogIndex then
		local prevSectionInfo = table.remove(self._sectionStack)

		self:_setSectionData(prevSectionInfo[1], prevSectionInfo[2])
	end

	local showOption = false
	local nextConfig = self._sectionList[self._dialogIndex]

	if nextConfig and nextConfig.type == "options" then
		self._dialogIndex = self._dialogIndex + 1

		local optionList = string.split(nextConfig.content, "#")
		local sectionIdList = string.split(nextConfig.param, "#")

		for k, v in pairs(self._optionBtnList) do
			gohelper.setActive(v[1], false)
		end

		for i, v in ipairs(optionList) do
			self:_addDialogOption(i, sectionIdList[i], v)
		end

		showOption = true
	end

	local hasNext = not nextConfig or nextConfig.type ~= "dialogend"

	self:_refreshDialogBtnState(showOption, hasNext)

	if self._dissolveInfo then
		gohelper.setActive(self._curBtnGo, false)
	end
end

function DungeonMapInteractive1_3ItemComp:_refreshDialogBtnState(showOption, hasNext)
	gohelper.setActive(self._gooptions, showOption)

	if showOption then
		self._nextAnimator:Play("dungeonmap_interactive_btn_out")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
		gohelper.setActive(self._gofinishtalk.gameObject, false)

		self._curBtnGo = self._gooptions

		return
	end

	hasNext = hasNext and (#self._sectionStack > 0 or #self._sectionList >= self._dialogIndex)

	if hasNext then
		self._curBtnGo = self._gonext

		gohelper.setActive(self._gonext.gameObject, hasNext)
		self._nextAnimator:Play("dungeonmap_interactive_btn_in1")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	else
		self._nextAnimator:Play("dungeonmap_interactive_btn_out")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)

		self._curBtnGo = self._gofinishtalk
	end

	gohelper.setActive(self._gofinishtalk.gameObject, not hasNext)
end

function DungeonMapInteractive1_3ItemComp:_addDialogOption(index, sectionId, text)
	if self._optionBtnList[index] then
		if not self._optionBtnList[index][1] then
			local item = gohelper.cloneInPlace(self._gotalkitem)

			self._maxOptionIndex = index

			gohelper.setActive(item, false)

			local txt = gohelper.findChildText(item, "txt_talkitem")

			txt.text = text

			local btn = gohelper.findChildButtonWithAudio(item, "btn_talkitem")

			btn:AddClickListener(self._onOptionClick, self, {
				sectionId,
				text
			})

			self._optionBtnList[index] = self._optionBtnList[index] or {
				item,
				btn
			}
		end
	end
end

function DungeonMapInteractive1_3ItemComp:_onOptionClick(param)
	if self._playScrollAnim then
		return
	end

	local sectionId = param[1]
	local text = string.format("<color=#c95318>\"%s\"</color>", param[2])

	self:_clearDialog()
	self:_showDialog("option", text)

	self._showOption = true

	if #self._sectionList >= self._dialogIndex then
		table.insert(self._sectionStack, {
			self._sectionId,
			self._dialogIndex
		})
	end

	DungeonMapModel.instance:addDialogId(sectionId)
	self:_playSection(sectionId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function DungeonMapInteractive1_3ItemComp:_showDialog(type, text, speaker, audio)
	DungeonMapModel.instance:addDialog(type, text, speaker, audio)

	local item = table.remove(self._dialogItemCacheList) or gohelper.cloneInPlace(self._gochatitem)

	transformhelper.setLocalPos(item.transform, 0, 0, 200)
	gohelper.setActive(item, true)
	gohelper.setAsLastSibling(item)

	local nameText = gohelper.findChildText(item, "name")

	if speaker then
		nameText.text = speaker .. ":" or ""
	end

	local iconGo = gohelper.findChild(item, "usericon")

	gohelper.setActive(iconGo, not speaker)

	local infoText = gohelper.findChildText(item, "info")

	infoText.text = text

	if speaker and audio and audio > 0 then
		self._audioIcon = gohelper.findChild(item, "name/laba")
		self._audioId = audio
	end

	if self._showOption and self._addDialog then
		self._dissolveInfo = {
			item,
			infoText,
			text
		}
	end

	self._showOption = false

	table.insert(self._dialogItemList, item)

	self._addDialog = true
end

function DungeonMapInteractive1_3ItemComp:_clearDialog()
	self._dialogItemList = self:getUserDataTb_()
	self._playScrollAnim = true

	gohelper.setActive(self._gomask, false)
	TaskDispatcher.runDelay(self._delayScroll, self, 0)

	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function DungeonMapInteractive1_3ItemComp:_delayScroll()
	gohelper.setActive(self._gomask, true)

	self._imgMask.enabled = true

	local delay = 0.26
	local oldScrollGo = self._curScrollGo

	if oldScrollGo then
		self._oldScrollGo = oldScrollGo

		ZProj.TweenHelper.DOLocalMoveY(oldScrollGo.transform, 229, delay, self._scrollEnd, self, oldScrollGo)
	else
		delay = 0.1
	end

	local scrollGo = gohelper.cloneInPlace(self._goscroll)

	for i, item in ipairs(self._dialogItemList) do
		local pos = item.transform.position

		gohelper.addChild(scrollGo, item)

		item.transform.position = pos

		local x, y, z = transformhelper.getLocalPos(item.transform)

		transformhelper.setLocalPos(item.transform, x, y, 0)
	end

	gohelper.setActive(scrollGo, true)

	self._curScrollGo = scrollGo

	if scrollGo then
		if self._dissolveInfo then
			local infoText = self._dissolveInfo[2]

			infoText.text = ""
		end

		transformhelper.setLocalPosXY(scrollGo.transform, 0, -229)
		ZProj.TweenHelper.DOLocalMoveY(scrollGo.transform, 0, delay, self._scrollEnd, self, scrollGo)
	end
end

function DungeonMapInteractive1_3ItemComp:_scrollEnd(scrollGo)
	if scrollGo ~= self._curScrollGo then
		gohelper.destroy(scrollGo)
	else
		if self._dissolveInfo then
			TaskDispatcher.runDelay(self._onDissolveStart, self, 0.3)

			return
		end

		self:_onDissolveFinish()
	end
end

function DungeonMapInteractive1_3ItemComp:_onDissolveStart()
	local item = self._dissolveInfo[1]
	local infoText = self._dissolveInfo[2]

	infoText.text = self._dissolveInfo[3]
	self._imgMask.enabled = false

	local anim = item:GetComponent(typeof(UnityEngine.Animation))

	anim:Play("dungeonmap_chatarea")
	TaskDispatcher.runDelay(self._onDissolveFinish, self, 1.3)
end

function DungeonMapInteractive1_3ItemComp:_onDissolveFinish()
	self:_playAudio()
	gohelper.setActive(self._curBtnGo, true)

	self._dissolveInfo = nil
	self._playScrollAnim = false

	if self._curBtnGo == self._gooptions then
		for index = 1, self._maxOptionIndex do
			local time = (index - 1) * 0.03
			local item = self._optionBtnList[index][1]

			if time > 0 then
				gohelper.setActive(item, false)
				TaskDispatcher.runDelay(function()
					if not gohelper.isNil(item) then
						gohelper.setActive(item, true)
					end
				end, nil, time)
			else
				gohelper.setActive(item, true)
			end
		end
	end
end

function DungeonMapInteractive1_3ItemComp:_playAudio()
	if not self._audioId then
		return
	end

	gohelper.setActive(self._audioIcon, true)

	self._audioParam = self._audioParam or AudioParam.New()
	self._audioParam.callback = self._onAudioStop
	self._audioParam.callbackTarget = self

	AudioEffectMgr.instance:playAudio(self._audioId, self._audioParam)
end

function DungeonMapInteractive1_3ItemComp:_onAudioStop(audioId)
	gohelper.setActive(self._audioIcon, false)
end

function DungeonMapInteractive1_3ItemComp:setBtnClosePosZ(posZ)
	local transform = self._btnclose.transform
	local localPosition = transform.localPosition

	transform.localPosition = Vector3(localPosition.x, localPosition.y, posZ)
end

function DungeonMapInteractive1_3ItemComp:setScale(scale)
	transformhelper.setLocalScale(self.viewGO.transform, scale, scale, scale)
end

function DungeonMapInteractive1_3ItemComp:_clearScroll()
	self._showOption = false
	self._dissolveInfo = nil
	self._playScrollAnim = false

	TaskDispatcher.cancelTask(self._delayScroll, self)

	if self._oldScrollGo then
		gohelper.destroy(self._oldScrollGo)

		self._oldScrollGo = nil
	end

	if self._curScrollGo then
		gohelper.destroy(self._curScrollGo)

		self._curScrollGo = nil
	end

	self._dialogItemList = self:getUserDataTb_()
end

function DungeonMapInteractive1_3ItemComp:_editableRemoveEvents()
	for k, v in pairs(self._optionBtnList) do
		v[2]:RemoveClickListener()
	end

	self.removeEventCb(self, DungeonController.instance, DungeonEvent.closeMapInteractiveItem, self._closeMapInteractiveItem, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onViewClose, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnClickElement, self._onClickElement, self)
end

function DungeonMapInteractive1_3ItemComp:onDestroy()
	DungeonMapModel.instance:setMapInteractiveItemVisible(false)
	TaskDispatcher.cancelTask(self._showCloseBtn, self)
	TaskDispatcher.cancelTask(self._delayScroll, self)
	TaskDispatcher.cancelTask(self._onDissolveStart, self)
	TaskDispatcher.cancelTask(self._onDissolveFinish, self)
	self:removeEvents()
	self:_editableRemoveEvents()
	TaskDispatcher.cancelTask(self._addToMapView, self)
	gohelper.destroy(self._btnfightuiuse.gameObject)

	if self._audioParam then
		self._audioParam.callback = nil
		self._audioParam.callbackTarget = nil
		self._audioParam = nil
	end

	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	if self._rewardClick then
		self._rewardClick:RemoveClickListener()
	end

	SLFramework.UGUI.UIClickListener.Get(self._inputanswer.gameObject):RemoveClickListener()
	self._simagebgimage:UnLoadImage()
	self._simageanswerbg:UnLoadImage()
end

return DungeonMapInteractive1_3ItemComp
