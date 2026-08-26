-- chunkname: @modules/logic/dungeonmazev3a7/view/DungeonMazeV3a7View.lua

module("modules.logic.dungeonmazev3a7.view.DungeonMazeV3a7View", package.seeall)

local DungeonMazeV3a7View = class("DungeonMazeV3a7View", BaseViewExtended)
local ctrl = DungeonMazeV3a7Controller.instance
local LEFT = DungeonMazeV3a7Enum.dir.left
local RIGHT = DungeonMazeV3a7Enum.dir.right
local DOWN = DungeonMazeV3a7Enum.dir.down
local UP = DungeonMazeV3a7Enum.dir.up
local chessMoveTarget = {
	[LEFT] = Vector2.New(-500, 0),
	[RIGHT] = Vector2.New(500, 0),
	[UP] = Vector2.New(0, 300),
	[DOWN] = Vector2.New(0, -300)
}
local offsetPosX = 100
local dangerousChaoValue = 80

function DungeonMazeV3a7View:onInitView()
	self._leftRoadBtn = gohelper.findChildButtonWithAudio(self.viewGO, "Road/road1/#btn_click")
	self._rightRoadBtn = gohelper.findChildButtonWithAudio(self.viewGO, "Road/road2/#btn_click")
	self._upRoadBtn = gohelper.findChildButtonWithAudio(self.viewGO, "Road/road4/#btn_click")
	self._downRoadBtn = gohelper.findChildButtonWithAudio(self.viewGO, "Road/road3/#btn_click")
	self._leftEventBtn = gohelper.findChildButtonWithAudio(self.viewGO, "Road/road1/#btn_event/light")
	self._rightEventBtn = gohelper.findChildButtonWithAudio(self.viewGO, "Road/road2/#btn_event/light")
	self._upEventBtn = gohelper.findChildButtonWithAudio(self.viewGO, "Road/road4/#btn_event/light")
	self._downEventBtn = gohelper.findChildButtonWithAudio(self.viewGO, "Road/road3/#btn_event/light")
	self._goRoadStopLeft = gohelper.findChild(self.viewGO, "Road/road1/stop")
	self._goRoadStopRight = gohelper.findChild(self.viewGO, "Road/road2/stop")
	self._goRoadStopBottom = gohelper.findChild(self.viewGO, "Road/road3/stop")
	self._goRoadStopUp = gohelper.findChild(self.viewGO, "Road/road4/stop")
	self._goRoadEndUp = gohelper.findChild(self.viewGO, "Road/road4/door")
	self._goRoadDirLeft = gohelper.findChild(self.viewGO, "Road/road1/normal")
	self._goRoadDirRight = gohelper.findChild(self.viewGO, "Road/road2/normal")
	self._goRoadDirBottom = gohelper.findChild(self.viewGO, "Road/road3/normal")
	self._goRoadDirUp = gohelper.findChild(self.viewGO, "Road/road4/normal")
	self._goRoadLightLeft = gohelper.findChild(self.viewGO, "Road/road1/light")
	self._goRoadLightRight = gohelper.findChild(self.viewGO, "Road/road2/light")
	self._goRoadLightBottom = gohelper.findChild(self.viewGO, "Road/road3/light")
	self._goRoadLightUp = gohelper.findChild(self.viewGO, "Road/road4/light")
	self._goRoadEventLeft = gohelper.findChild(self.viewGO, "Road/road1/#btn_event")
	self._goRoadEventRight = gohelper.findChild(self.viewGO, "Road/road2/#btn_event")
	self._goRoadEventBottom = gohelper.findChild(self.viewGO, "Road/road3/#btn_event")
	self._goRoadEventUp = gohelper.findChild(self.viewGO, "Road/road4/#btn_event")
	self._goEyeNormal = gohelper.findChild(self.viewGO, "#go_top/normal")
	self._goEyeActive = gohelper.findChild(self.viewGO, "#go_top/active")
	self._goEyeCooling = gohelper.findChild(self.viewGO, "#go_top/cooling")
	self._goSkillCoolingStar1Light = gohelper.findChild(self.viewGO, "#go_top/cooling/star1/light")
	self._goSkillCoolingStar2Light = gohelper.findChild(self.viewGO, "#go_top/cooling/star2/light")
	self._goSkillCoolingStar1Drak = gohelper.findChild(self.viewGO, "#go_top/cooling/star1/dark")
	self._goSkillCoolingStar2Drak = gohelper.findChild(self.viewGO, "#go_top/cooling/star2/dark")
	self._goDestination = gohelper.findChild(self.viewGO, "#go_ending")
	self._textChaosValue = gohelper.findChildText(self.viewGO, "#go_bottom/normal/#txt_value")
	self._textDangerousValue = gohelper.findChildText(self.viewGO, "#go_bottom/dangerous/#txt_value")
	self._goNormalChaoValue = gohelper.findChild(self.viewGO, "#go_bottom/normal")
	self._goDangerousChaoValue = gohelper.findChild(self.viewGO, "#go_bottom/dangerous")
	self._goChaoAdd = gohelper.findChild(self.viewGO, "#go_bottom/#txt_add")
	self._textChaosAdd = gohelper.findChildText(self.viewGO, "#go_bottom/#txt_add")
	self._goChess = gohelper.findChild(self.viewGO, "#go_chess")
	self._goChessAni = gohelper.findChild(self._goChess, "#chess")
	self._imageChessIcon1_1 = gohelper.findChildSingleImage(self._goChess, "#chess/#image_chess1")
	self._imageChessIcon1_2 = gohelper.findChildSingleImage(self._goChess, "#chess/#image_chess2")
	self._imageChessIcon1_3 = gohelper.findChildSingleImage(self._goChess, "#chess/#image_chess3")
	self._imageChessIcon1_4 = gohelper.findChildSingleImage(self._goChess, "#chess/#image_chess4")
	self._chessAnimator = self._goChessAni:GetComponent(gohelper.Type_Animator)
	self._transChess = self._goChess.transform
	self._goChess2 = gohelper.findChild(self.viewGO, "#go_chess2")
	self._goChessAni2 = gohelper.findChild(self._goChess2, "#chess")
	self._imageChessIcon2_1 = gohelper.findChildSingleImage(self._goChess2, "#chess/#image_chess1")
	self._imageChessIcon2_2 = gohelper.findChildSingleImage(self._goChess2, "#chess/#image_chess2")
	self._imageChessIcon2_3 = gohelper.findChildSingleImage(self._goChess2, "#chess/#image_chess3")
	self._imageChessIcon2_4 = gohelper.findChildSingleImage(self._goChess2, "#chess/#image_chess4")
	self._chessAnimator2 = self._goChessAni2:GetComponent(gohelper.Type_Animator)
	self._transChess2 = self._goChess2.transform
	self._goTalk = gohelper.findChild(self.viewGO, "#go_chess/#go_talk")
	self._goArrowTip = gohelper.findChild(self._goTalk, "#go_ArrowTips")
	self._scrollTalk = gohelper.findChildScrollRect(self._goTalk, "Scroll View")
	self._txttalk = gohelper.findChildText(self._goTalk, "Scroll View/Viewport/Content/#txt_talk")
	self.rectTrTalk = self._goTalk:GetComponent(gohelper.Type_RectTransform)
	self.rectTrContent = gohelper.findChildComponent(self._goTalk, "Scroll View/Viewport/Content", gohelper.Type_RectTransform)
	self._btnEye = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top/#btn_click")
	self._btnRestart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._btnSwitch = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottomleft/#btn_change")
	self._goBottom = gohelper.findChild(self.viewGO, "#go_bottom")
	self._bottomAnimator = self._goBottom:GetComponent(gohelper.Type_Animator)
	self._viewAnimator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._goDirEffect = gohelper.findChild(self.viewGO, "#go_direffect")
	self._goResetEffect = gohelper.findChild(self.viewGO, "#go_start")
	self._goDarkMask = gohelper.findChild(self.viewGO, "simage_darkmask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMazeV3a7View:addEvents()
	self._leftRoadBtn:AddClickListener(self._onClickLeftRoadBtn, self)
	self._rightRoadBtn:AddClickListener(self._onClickRightRoadBtn, self)
	self._upRoadBtn:AddClickListener(self._onClickUpRoadBtn, self)
	self._downRoadBtn:AddClickListener(self._onClickDownRoadBtn, self)
	self._btnEye:AddClickListener(self._onClickEyeBtn, self)
	self._btnSwitch:AddClickListener(self._onClickSwitchBtn, self)
	self._btnRestart:AddClickListener(self._onClickRestartBtn, self)

	self.talkTextClick = gohelper.getClickWithDefaultAudio(self._goTalk)

	self.talkTextClick:AddClickListener(self.onClickText, self)
	self._leftEventBtn:AddClickListener(self._onClickLeftObstacleBtn, self)
	self._rightEventBtn:AddClickListener(self._onClickRightObstacleBtn, self)
	self._upEventBtn:AddClickListener(self._onClickUpObstacleBtn, self)
	self._downEventBtn:AddClickListener(self._onClickDownObstacleBtn, self)
	self.addEventCb(self, DungeonMazeV3a7Controller.instance, DungeonMazeV3a7Event.DungeonMazeV3a7Completed, self.onMazeCompleted, self)
	self.addEventCb(self, DungeonMazeV3a7Controller.instance, DungeonMazeV3a7Event.DungeonMazeV3a7Exit, self.onMazeExit, self)
	self.addEventCb(self, DungeonMazeV3a7Controller.instance, DungeonMazeV3a7Event.DungeonMazeV3a7ReStart, self.onMazeRestart, self)
end

function DungeonMazeV3a7View:removeEvents()
	self._leftRoadBtn:RemoveClickListener()
	self._rightRoadBtn:RemoveClickListener()
	self._upRoadBtn:RemoveClickListener()
	self._downRoadBtn:RemoveClickListener()
	self._btnEye:RemoveClickListener()
	self._btnSwitch:RemoveClickListener()
	self._btnRestart:RemoveClickListener()
	self.talkTextClick:RemoveClickListener()
	self._leftEventBtn:RemoveClickListener()
	self._rightEventBtn:RemoveClickListener()
	self._upEventBtn:RemoveClickListener()
	self._downEventBtn:RemoveClickListener()
end

function DungeonMazeV3a7View:_onClickLeftRoadBtn()
	if not self._leftCell or not self._leftCell.pass then
		return
	end

	self:_clickToMove(LEFT)
end

function DungeonMazeV3a7View:_onClickRightRoadBtn()
	if not self._rightCell or not self._rightCell.pass then
		return
	end

	self:_clickToMove(RIGHT)
end

function DungeonMazeV3a7View:_onClickDownRoadBtn()
	if not self._downCell or not self._downCell.pass then
		return
	end

	self:_clickToMove(DOWN)
end

function DungeonMazeV3a7View:_onClickUpRoadBtn()
	if not self._upCell or not self._upCell.pass then
		return
	end

	self:_clickToMove(UP)
end

function DungeonMazeV3a7View:_clickToMove(dir)
	local showNormal = DungeonMazeV3a7Model.instance:getRoleOrder() == DungeonMazeV3a7Enum.RoleOrder.Player14

	if not showNormal then
		return
	end

	if self._moving then
		return
	end

	self._moving = true

	local gameOver, isSuccess = DungeonMazeV3a7Controller.instance:MoveTo(dir)

	self._needRestart = gameOver and not isSuccess

	self:_doMoveTween(dir)
	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.play_ui_fuleyuan_push)
	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.stop_ui_fuleyuan_eyes)
end

function DungeonMazeV3a7View:_doMoveTween(dir)
	TaskDispatcher.cancelTask(self._delayHideDialog, self)
	self:_delayHideDialog()

	local targetPos = chessMoveTarget[dir]

	self:_refreshChessIcon(dir)
	UIBlockHelper.instance:startBlock("DungeonMazeV3a7View_Move", 1.5)

	local posTween2 = ZProj.TweenHelper.DOAnchorPos(self._transChess2, targetPos.x + recthelper.getAnchorX(self._goChess2.transform), targetPos.y, 0.4)

	ZProj.TweenHelper.DOFadeCanvasGroup(self._goChess2, 1, 0, 0.4)

	local posTween = ZProj.TweenHelper.DOAnchorPos(self._transChess, targetPos.x, targetPos.y, 0.4, self._doMoveTweenDone, self)

	ZProj.TweenHelper.DOFadeCanvasGroup(self._goChess, 1, 0, 0.4)
	self._viewAnimator:Play(UIAnimationName.Switch, 0, 0)
end

function DungeonMazeV3a7View:_doMoveTweenDone()
	if self._needRestart then
		self._needRestart = false

		self:_doClickRestartAction()
		self:_showSkipGameTip()
	end

	self:_refreshCurCellView()
	self:_refreshChaosValueView()
	self:_refreshChessView()
	self:_refreshSkillView()
	self:_refreshCurCellDialogView()
	self._chessAnimator:Play("jump", 0, 0)
	self._chessAnimator2:Play("jump", 0, 0)

	self._moving = false

	AudioMgr.instance:trigger(AudioEnum3_7.DungeonMaze.Chaos)
end

function DungeonMazeV3a7View:_refreshChessIcon(dir)
	self._dir = dir

	self:_refreshRoleState()
end

function DungeonMazeV3a7View:_getDir()
	return self._dir or LEFT
end

function DungeonMazeV3a7View:_onClickLeftObstacleBtn()
	self:_clickObstacle(LEFT, self._leftCell)
end

function DungeonMazeV3a7View:_onClickRightObstacleBtn()
	self:_clickObstacle(RIGHT, self._rightCell)
end

function DungeonMazeV3a7View:_onClickUpObstacleBtn()
	self:_clickObstacle(UP, self._upCell)
end

function DungeonMazeV3a7View:_onClickDownObstacleBtn()
	self:_clickObstacle(DOWN, self._downCell)
end

function DungeonMazeV3a7View:_clickObstacle(dir, cell)
	if not cell or string.nilorempty(cell.obstacleDialog) or cell.obstacleToggled then
		return
	end

	cell.obstacleToggled = true

	self:_doToggleObstacleDone()
end

function DungeonMazeV3a7View:_doToggleObstacleDone()
	self:_refreshCurCellView()
end

function DungeonMazeV3a7View:_onClickSwitchBtn()
	DungeonMazeV3a7Model.instance:switchRoleOrder()
	DungeonMazeV3a7Model.instance:SaveCurProgress()
	self:_refreshCurCellView()
	self:_switchRole()
end

function DungeonMazeV3a7View:_onClickEyeBtn()
	local curSkillState = DungeonMazeV3a7Model.instance:GetSkillState()

	if curSkillState == DungeonMazeV3a7Enum.skillState.using then
		if SLFramework.FrameworkSettings.IsEditor then
			self._quickPassCount = self._quickPassCount or 0
			self._quickPassCount = self._quickPassCount + 1

			if self._quickPassCount >= 10 then
				local afterStory = tonumber(self._episodeCfg.story)

				if afterStory ~= 0 then
					DungeonMazeV3a7Controller.instance:playMazeAfterStory(afterStory)

					return
				end
			end
		end

		GameFacade.showToast(ToastEnum.MazeGameEyeSkillUsingToast)
	elseif curSkillState == DungeonMazeV3a7Enum.skillState.cooling then
		GameFacade.showToast(ToastEnum.MazeGameEyeSkillCoolingToast)
	else
		DungeonMazeV3a7Controller.instance:UseEyeSkill()
		self:_refreshSkillView()
		DungeonMazeV3a7Model.instance:SaveCurProgress()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
	end
end

function DungeonMazeV3a7View:_onClickRestartBtn()
	GameFacade.showMessageBox(MessageBoxIdDefine.WarmUpGameReFight, MsgBoxEnum.BoxType.Yes_No, self._doClickRestartAction, nil, nil)
end

function DungeonMazeV3a7View:_doClickRestartAction()
	local curCell = DungeonMazeV3a7Model.instance:getCurCellData()
	local chaosValue = DungeonMazeV3a7Model.instance:getChaosValue()

	DungeonMazeV3a7Controller.instance:sandStatData(DungeonMazeV3a7Enum.resultStat[4], curCell.cellId, chaosValue)
	ctrl:dispatchEvent(DungeonMazeV3a7Event.DungeonMazeV3a7ReStart)
	GameFacade.showToast(ToastEnum.V3a7MazeResetTip)
end

function DungeonMazeV3a7View:onClickText()
	return
end

function DungeonMazeV3a7View:onMazeCompleted()
	self:closeThis()
end

function DungeonMazeV3a7View:onMazeExit()
	self:closeThis()
end

function DungeonMazeV3a7View:onMazeRestart()
	DungeonMazeV3a7Controller.instance:initStatData()
	DungeonMazeV3a7Model.instance:initData()
	self:initMap()
	gohelper.setActive(self._goResetEffect, false)
	gohelper.setActive(self._goResetEffect, true)
	AudioMgr.instance:trigger(AudioEnum3_7.DungeonMaze.Reset)
end

function DungeonMazeV3a7View:_showSkipGameTip()
	GameFacade.showMessageBox(MessageBoxIdDefine.DungeonMazeV3a7Exit, MsgBoxEnum.BoxType.Yes_No, self._confirmSkipGame, nil, nil, self)
end

function DungeonMazeV3a7View:_confirmSkipGame()
	DungeonMazeV3a7Controller.instance:gmWin()
end

function DungeonMazeV3a7View:_editableInitView()
	self._roadStopMap = self:getUserDataTb_()
	self._roadStopMap[DungeonMazeV3a7Enum.dir.left] = self._goRoadStopLeft
	self._roadStopMap[DungeonMazeV3a7Enum.dir.right] = self._goRoadStopRight
	self._roadStopMap[DungeonMazeV3a7Enum.dir.down] = self._goRoadStopBottom
	self._roadStopMap[DungeonMazeV3a7Enum.dir.up] = self._goRoadStopUp
	self._roadDirMap = self:getUserDataTb_()
	self._roadDirMap[DungeonMazeV3a7Enum.dir.left] = self._goRoadDirLeft
	self._roadDirMap[DungeonMazeV3a7Enum.dir.right] = self._goRoadDirRight
	self._roadDirMap[DungeonMazeV3a7Enum.dir.down] = self._goRoadDirBottom
	self._roadDirMap[DungeonMazeV3a7Enum.dir.up] = self._goRoadDirUp
	self._roadLightMap = self:getUserDataTb_()
	self._roadLightMap[DungeonMazeV3a7Enum.dir.left] = self._goRoadLightLeft
	self._roadLightMap[DungeonMazeV3a7Enum.dir.right] = self._goRoadLightRight
	self._roadLightMap[DungeonMazeV3a7Enum.dir.down] = self._goRoadLightBottom
	self._roadLightMap[DungeonMazeV3a7Enum.dir.up] = self._goRoadLightUp
	self._roadEventMap = self:getUserDataTb_()
	self._roadEventMap[DungeonMazeV3a7Enum.dir.left] = self._goRoadEventLeft
	self._roadEventMap[DungeonMazeV3a7Enum.dir.right] = self._goRoadEventRight
	self._roadEventMap[DungeonMazeV3a7Enum.dir.down] = self._goRoadEventBottom
	self._roadEventMap[DungeonMazeV3a7Enum.dir.up] = self._goRoadEventUp
	self._roadDirBtnMap = self:getUserDataTb_()
	self._roadDirBtnMap[DungeonMazeV3a7Enum.dir.left] = self._leftRoadBtn
	self._roadDirBtnMap[DungeonMazeV3a7Enum.dir.right] = self._rightRoadBtn
	self._roadDirBtnMap[DungeonMazeV3a7Enum.dir.down] = self._downRoadBtn
	self._roadDirBtnMap[DungeonMazeV3a7Enum.dir.up] = self._upRoadBtn
	self._roadEventBtnMap = self:getUserDataTb_()
	self._roadEventBtnMap[DungeonMazeV3a7Enum.dir.left] = self._leftEventBtn
	self._roadEventBtnMap[DungeonMazeV3a7Enum.dir.right] = self._rightEventBtn
	self._roadEventBtnMap[DungeonMazeV3a7Enum.dir.down] = self._downEventBtn
	self._roadEventBtnMap[DungeonMazeV3a7Enum.dir.up] = self._upEventBtn
	self._roadEndMap = self:getUserDataTb_()
	self._roadEndMap[DungeonMazeV3a7Enum.dir.up] = self._goRoadEndUp

	gohelper.setActive(self._goChaoAdd, false)
	gohelper.setActive(self._goTalk, false)
	TaskDispatcher.runRepeat(self._frameHandler, self, 0)

	self._rootAnimator = self.viewGO:GetComponent("Animator")
end

function DungeonMazeV3a7View:_frameHandler()
	if SLFramework.FrameworkSettings.IsEditor and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
		TaskDispatcher.cancelTask(self._frameHandler, self)
		DungeonMazeV3a7Controller.instance:gmWin()
	end
end

function DungeonMazeV3a7View:onUpdateParam()
	return
end

function DungeonMazeV3a7View:onOpen()
	self._episodeCfg = self.viewParam.episodeCfg

	local existProgress = self.viewParam.existProgress

	if not existProgress then
		DungeonMazeV3a7Model.instance:SaveCurProgress()
	end

	local dialogHideTimeConstCfg = DungeonMazeV3a7Config.instance:getMazeGameConst(DungeonMazeV3a7Enum.hideDialogTimeConstId)

	self._dialogHideTime = dialogHideTimeConstCfg and tonumber(dialogHideTimeConstCfg.size) or 4

	self:initMap()
end

function DungeonMazeV3a7View:onOpenFinish()
	DungeonMazeV3a7Controller.instance:dispatchEvent(DungeonMazeV3a7Event.EnterDungeonMazeV3a7)
end

function DungeonMazeV3a7View:onClose()
	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.stop_ui_fuleyuan_eyes)
	TaskDispatcher.cancelTask(self._frameHandler, self)
	TaskDispatcher.cancelTask(self._hideDarkMask, self)
end

function DungeonMazeV3a7View:initMap()
	self:_refreshCurCellView()
	self:_refreshChaosValueView()
	gohelper.setActive(self._goChaoAdd, false)
	self:_refreshChessView()
	self:_refreshSkillView()
	self:_switchRole()
end

function DungeonMazeV3a7View:_switchRole()
	self:_refreshRoleState()
	self:_refreshSwitchRoleState()
	self:_refreshDirEffect()
end

function DungeonMazeV3a7View:_refreshRoleState()
	local isVertin = DungeonMazeV3a7Model.instance:getRoleOrder() == DungeonMazeV3a7Enum.RoleOrder.PlayerVertin
	local isLeft = self:_getDir() == LEFT

	gohelper.setActive(self._imageChessIcon1_1, not isLeft and not isVertin)
	gohelper.setActive(self._imageChessIcon1_2, not isLeft and isVertin)
	gohelper.setActive(self._imageChessIcon1_3, isLeft and not isVertin)
	gohelper.setActive(self._imageChessIcon1_4, isLeft and isVertin)
	gohelper.setActive(self._imageChessIcon2_1, not isLeft and isVertin)
	gohelper.setActive(self._imageChessIcon2_2, not isLeft and not isVertin)
	gohelper.setActive(self._imageChessIcon2_3, isLeft and isVertin)
	gohelper.setActive(self._imageChessIcon2_4, isLeft and not isVertin)
end

function DungeonMazeV3a7View:_refreshSwitchRoleState()
	local isVertin = DungeonMazeV3a7Model.instance:getRoleOrder() == DungeonMazeV3a7Enum.RoleOrder.PlayerVertin
	local head2_1 = gohelper.findChild(self.viewGO, "#go_bottomleft/Head2/#image_Head1")
	local head2_2 = gohelper.findChild(self.viewGO, "#go_bottomleft/Head2/#image_Head2")
	local head1_1 = gohelper.findChild(self.viewGO, "#go_bottomleft/Head1/#image_Head1")
	local head1_2 = gohelper.findChild(self.viewGO, "#go_bottomleft/Head1/#image_Head2")

	gohelper.setActive(head1_1, isVertin)
	gohelper.setActive(head1_2, not isVertin)
	gohelper.setActive(head2_1, not isVertin)
	gohelper.setActive(head2_2, isVertin)
	gohelper.setActive(self._goDarkMask, true)
	self._rootAnimator:Play(isVertin and "mask_in" or "mask_out", 0, 0)
	TaskDispatcher.cancelTask(self._hideDarkMask, self)

	if not isVertin then
		TaskDispatcher.runDelay(self._hideDarkMask, self, 0.4)
	end
end

function DungeonMazeV3a7View:_hideDarkMask()
	gohelper.setActive(self._goDarkMask, false)
end

function DungeonMazeV3a7View:_refreshDirEffect()
	local curCell = DungeonMazeV3a7Model.instance:getCurCellData()
	local curCellId = curCell.cellId
	local endCellId = DungeonMazeV3a7Config.instance:getEndCellId()
	local showDir = DungeonMazeV3a7Model.instance:getRoleOrder() == DungeonMazeV3a7Enum.RoleOrder.PlayerVertin and curCellId ~= endCellId

	gohelper.setActive(self._goDirEffect, showDir)

	if not showDir then
		return
	end

	local w, h = DungeonMazeV3a7Model.instance:getGameSize()
	local curRow = math.ceil(curCellId / w)
	local curCol = (curCellId - 1) % w + 1
	local endRow = math.ceil(endCellId / w)
	local endCol = (endCellId - 1) % w + 1
	local deltaRow = endRow - curRow
	local deltaCol = endCol - curCol
	local rotation = 0

	if deltaCol == 0 and deltaRow < 0 then
		rotation = 270
	elseif deltaCol == 0 and deltaRow > 0 then
		rotation = 90
	elseif deltaCol > 0 and deltaRow == 0 then
		rotation = 180
	elseif deltaCol < 0 and deltaRow == 0 then
		rotation = 0
	elseif deltaCol > 0 and deltaRow > 0 then
		rotation = 135
	elseif deltaCol < 0 and deltaRow > 0 then
		rotation = 45
	elseif deltaCol > 0 and deltaRow < 0 then
		rotation = 225
	elseif deltaCol < 0 and deltaRow < 0 then
		rotation = 315
	end

	rotation = rotation + 180

	transformhelper.setLocalRotation(self._goDirEffect.transform, 0, 0, rotation)
end

function DungeonMazeV3a7View:_refreshCurCellView()
	self._curCell = DungeonMazeV3a7Model.instance:getCurCellData()

	local borderCells = self._curCell.connectSet

	self._leftCell = borderCells[DungeonMazeV3a7Enum.dir.left]
	self._rightCell = borderCells[DungeonMazeV3a7Enum.dir.right]
	self._upCell = borderCells[DungeonMazeV3a7Enum.dir.up]
	self._downCell = borderCells[DungeonMazeV3a7Enum.dir.down]

	local isEnd = false

	gohelper.setActive(self._goDestination, false)

	for dir, cellData in pairs(borderCells) do
		if cellData and cellData.value == 2 then
			isEnd = true
		end
	end

	local showNormal = DungeonMazeV3a7Model.instance:getRoleOrder() == DungeonMazeV3a7Enum.RoleOrder.Player14

	for dir, roadStop in pairs(self._roadStopMap) do
		local cellData = borderCells[dir]

		gohelper.setActive(roadStop, not cellData and true or not cellData.pass)

		local var_41_0

		if cellData then
			::label_41_0::

			var_41_0 = cellData.pass and showNormal
		end

		gohelper.setActive(self._roadDirMap[dir], var_41_0)

		local endGo = self._roadEndMap[dir]

		if endGo then
			gohelper.setActive(endGo, isEnd)
		end

		local showObstacleDialog = false
		local roadObstacleGo = self._roadEventMap[dir]
		local isObstacle = cellData and not string.nilorempty(cellData.obstacleDialog)
		local obstacleToggled = false

		if isObstacle then
			gohelper.setActive(roadObstacleGo, showNormal)

			obstacleToggled = cellData and cellData.obstacleToggled
			showObstacleDialog = obstacleToggled

			do
				local obstacleGreyGo = gohelper.findChild(roadObstacleGo, "grey")
				local obstacleLightGo = gohelper.findChild(roadObstacleGo, "light")

				gohelper.setActive(obstacleGreyGo, obstacleToggled)
				gohelper.setActive(obstacleLightGo, not obstacleToggled)
			end
		else
			gohelper.setActive(roadObstacleGo, false)
		end

		DungeonMazeV3a7Controller.instance:dispatchEvent(DungeonMazeV3a7Event.ShowMazeObstacleDialog, dir, (showNormal and showObstacleDialog or nil) and (cellData.obstacleDialog or nil), obstacleToggled)
	end

	local chaosValue = DungeonMazeV3a7Model.instance:getChaosValue()

	if chaosValue and chaosValue < DungeonMazeV3a7Enum.MaxChaosValue then
		ctrl:dispatchEvent(DungeonMazeV3a7Event.ArriveMazeGameCell, self._curCell.cellId)
	end
end

function DungeonMazeV3a7View:_refreshCurCellDialogView()
	if self._curCell.toggled then
		return
	end

	local eventId = self._curCell.eventId

	if eventId and eventId > 0 then
		local eventCfg = DungeonMazeV3a7Config.instance:getMazeEventCfg(eventId)

		if eventCfg then
			gohelper.setActive(self._goTalk, true)

			self._txttalk.text = eventCfg.desc

			TaskDispatcher.runDelay(self._delayHideDialog, self, self._dialogHideTime)

			self._curCell.toggled = true
		end
	end
end

function DungeonMazeV3a7View:_delayHideDialog()
	gohelper.setActive(self._goTalk, false)
end

function DungeonMazeV3a7View:_refreshChaosValueView()
	gohelper.setActive(self._goChaoAdd, true)
	self._bottomAnimator:Play(UIAnimationName.Open, 0, 0)

	local chaosValue = DungeonMazeV3a7Model.instance:getChaosValue()

	if chaosValue >= dangerousChaoValue then
		gohelper.setActive(self._goNormalChaoValue, false)
		gohelper.setActive(self._goDangerousChaoValue, true)
	else
		gohelper.setActive(self._goNormalChaoValue, true)
		gohelper.setActive(self._goDangerousChaoValue, false)
	end

	self._textChaosAdd.text = "+" .. DungeonMazeV3a7Model.instance:getAddChaosValue()
	self._textChaosValue.text = chaosValue
	self._textDangerousValue.text = chaosValue
end

function DungeonMazeV3a7View:_refreshChessView()
	recthelper.setAnchor(self._transChess, 0, 0)
	ZProj.TweenHelper.DOFadeCanvasGroup(self._goChess, 0, 1, 0.25)
	recthelper.setAnchor(self._transChess2, offsetPosX, 0)
	ZProj.TweenHelper.DOFadeCanvasGroup(self._goChess2, 0, 1, 0.25)
end

function DungeonMazeV3a7View:_refreshSkillView()
	local curSkillState, skillCooling = DungeonMazeV3a7Model.instance:GetSkillState()

	gohelper.setActive(self._goEyeNormal, curSkillState == DungeonMazeV3a7Enum.skillState.usable)
	gohelper.setActive(self._goEyeActive, curSkillState == DungeonMazeV3a7Enum.skillState.using)
	gohelper.setActive(self._goEyeCooling, curSkillState == DungeonMazeV3a7Enum.skillState.cooling)
	gohelper.setActive(self._goSkillCoolingStar1Light, skillCooling >= 1)
	gohelper.setActive(self._goSkillCoolingStar2Light, skillCooling >= 2)
	gohelper.setActive(self._goSkillCoolingStar1Drak, skillCooling < 1)
	gohelper.setActive(self._goSkillCoolingStar2Drak, skillCooling < 2)

	if curSkillState == DungeonMazeV3a7Enum.skillState.using then
		local nextCell = DungeonMazeV3a7Model.instance:getNearestCellToDestination()
		local curCell = DungeonMazeV3a7Model.instance:getCurCellData()
		local nextDir = curCell:getDirectionTo(nextCell)

		for dir, goLightRoad in pairs(self._roadLightMap) do
			gohelper.setActive(goLightRoad, dir == nextDir)
		end

		gohelper.setActive(self._roadDirMap[nextDir], false)
	else
		for dir, goLightRoad in pairs(self._roadLightMap) do
			gohelper.setActive(goLightRoad, false)
		end
	end
end

function DungeonMazeV3a7View:onDestroyView()
	return
end

return DungeonMazeV3a7View
