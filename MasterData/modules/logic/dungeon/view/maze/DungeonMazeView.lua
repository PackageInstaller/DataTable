-- chunkname: @modules/logic/dungeon/view/maze/DungeonMazeView.lua

module("modules.logic.dungeon.view.maze.DungeonMazeView", package.seeall)

local DungeonMazeView = class("DungeonMazeView", BaseViewExtended)
local ctrl = DungeonMazeController.instance
local LEFT = DungeonMazeEnum.dir.left
local RIGHT = DungeonMazeEnum.dir.right
local DOWN = DungeonMazeEnum.dir.down
local UP = DungeonMazeEnum.dir.up
local chessMoveTarget = {
	[LEFT] = Vector2.New(-500, 0),
	[RIGHT] = Vector2.New(500, 0),
	[UP] = Vector2.New(0, 300),
	[DOWN] = Vector2.New(0, -300)
}
local chessIconAssetLeft = "dialogue_role30_left"
local chessIconAssetRight = "dialogue_role30_right"
local dangerousChaoValue = 70

function DungeonMazeView:onInitView()
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
	self._imageChessIcon = gohelper.findChildSingleImage(self._goChess, "#chess/#image_chess")
	self._goTalk = gohelper.findChild(self.viewGO, "#go_chess/#go_talk")
	self._goArrowTip = gohelper.findChild(self._goTalk, "#go_ArrowTips")
	self._scrollTalk = gohelper.findChildScrollRect(self._goTalk, "Scroll View")
	self._txttalk = gohelper.findChildText(self._goTalk, "Scroll View/Viewport/Content/#txt_talk")
	self.rectTrTalk = self._goTalk:GetComponent(gohelper.Type_RectTransform)
	self.rectTrContent = gohelper.findChildComponent(self._goTalk, "Scroll View/Viewport/Content", gohelper.Type_RectTransform)
	self._transChess = self._goChess.transform
	self._btnEye = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top/#btn_click")
	self._btnRestart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._goBottom = gohelper.findChild(self.viewGO, "#go_bottom")
	self._bottomAnimator = self._goBottom:GetComponent(gohelper.Type_Animator)
	self._viewAnimator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._chessAnimator = self._goChessAni:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMazeView:addEvents()
	self._leftRoadBtn:AddClickListener(self._onClickLeftRoadBtn, self)
	self._rightRoadBtn:AddClickListener(self._onClickRightRoadBtn, self)
	self._upRoadBtn:AddClickListener(self._onClickUpRoadBtn, self)
	self._downRoadBtn:AddClickListener(self._onClickDownRoadBtn, self)
	self._btnEye:AddClickListener(self._onClickEyeBtn, self)
	self._btnRestart:AddClickListener(self._onClickRestartBtn, self)

	self.talkTextClick = gohelper.getClickWithDefaultAudio(self._goTalk)

	self.talkTextClick:AddClickListener(self.onClickText, self)
	self._leftEventBtn:AddClickListener(self._onClickLeftObstacleBtn, self)
	self._rightEventBtn:AddClickListener(self._onClickRightObstacleBtn, self)
	self._upEventBtn:AddClickListener(self._onClickUpObstacleBtn, self)
	self._downEventBtn:AddClickListener(self._onClickDownObstacleBtn, self)
	self.addEventCb(self, DungeonMazeController.instance, DungeonMazeEvent.DungeonMazeCompleted, self.onMazeCompleted, self)
	self.addEventCb(self, DungeonMazeController.instance, DungeonMazeEvent.DungeonMazeExit, self.onMazeExit, self)
	self.addEventCb(self, DungeonMazeController.instance, DungeonMazeEvent.DungeonMazeReStart, self.onMazeRestart, self)
end

function DungeonMazeView:removeEvents()
	self._leftRoadBtn:RemoveClickListener()
	self._rightRoadBtn:RemoveClickListener()
	self._upRoadBtn:RemoveClickListener()
	self._downRoadBtn:RemoveClickListener()
	self._btnEye:RemoveClickListener()
	self._btnRestart:RemoveClickListener()
	self.talkTextClick:RemoveClickListener()
	self._leftEventBtn:RemoveClickListener()
	self._rightEventBtn:RemoveClickListener()
	self._upEventBtn:RemoveClickListener()
	self._downEventBtn:RemoveClickListener()
end

function DungeonMazeView:_onClickLeftRoadBtn()
	if not self._leftCell or not self._leftCell.pass then
		return
	end

	self:_clickToMove(LEFT)
end

function DungeonMazeView:_onClickRightRoadBtn()
	if not self._rightCell or not self._rightCell.pass then
		return
	end

	self:_clickToMove(RIGHT)
end

function DungeonMazeView:_onClickDownRoadBtn()
	if not self._downCell or not self._downCell.pass then
		return
	end

	self:_clickToMove(DOWN)
end

function DungeonMazeView:_onClickUpRoadBtn()
	if not self._upCell or not self._upCell.pass then
		return
	end

	self:_clickToMove(UP)
end

function DungeonMazeView:_clickToMove(dir)
	if self._moving then
		return
	end

	self._moving = true

	DungeonMazeController.instance:MoveTo(dir)
	self:_doMoveTween(dir)
	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.play_ui_fuleyuan_push)
	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.stop_ui_fuleyuan_eyes)
end

function DungeonMazeView:_doMoveTween(dir)
	TaskDispatcher.cancelTask(self._delayHideDialog, self)
	self:_delayHideDialog()

	local targetPos = chessMoveTarget[dir]

	self:_refreshChessIcon(dir)

	local posTween = ZProj.TweenHelper.DOAnchorPos(self._transChess, targetPos.x, targetPos.y, 1, self._doMoveTweenDone, self)

	ZProj.TweenHelper.DOFadeCanvasGroup(self._goChess, 1, 0, 0.4)
	self._viewAnimator:Play(UIAnimationName.Switch, 0, 0)
end

function DungeonMazeView:_doMoveTweenDone()
	self:_refreshCurCellView()
	self:_refreshChaosValueView()
	self:_refreshChessView()
	self:_refreshSkillView()
	self:_refreshCurCellDialogView()
	self._chessAnimator:Play("jump", 0, 0)

	self._moving = false
end

function DungeonMazeView:_refreshChessIcon(dir)
	if dir == LEFT then
		if not chessIconAssetRight then
			local chessIconName = chessIconAssetLeft

			self._imageChessIcon:UnLoadImage()
			self._imageChessIcon:LoadImage(ResUrl.getChessDialogueSingleBg(chessIconName))
		end
	end
end

function DungeonMazeView:_onClickLeftObstacleBtn()
	self:_clickObstacle(LEFT, self._leftCell)
end

function DungeonMazeView:_onClickRightObstacleBtn()
	self:_clickObstacle(RIGHT, self._rightCell)
end

function DungeonMazeView:_onClickUpObstacleBtn()
	self:_clickObstacle(UP, self._upCell)
end

function DungeonMazeView:_onClickDownObstacleBtn()
	self:_clickObstacle(DOWN, self._downCell)
end

function DungeonMazeView:_clickObstacle(dir, cell)
	if not cell or string.nilorempty(cell.obstacleDialog) or cell.obstacleToggled then
		return
	end

	cell.obstacleToggled = true

	self:_doToggleObstacleDone()
end

function DungeonMazeView:_doToggleObstacleDone()
	self:_refreshCurCellView()
end

function DungeonMazeView:_onClickEyeBtn()
	local curSkillState = DungeonMazeModel.instance:GetSkillState()

	if curSkillState == DungeonMazeEnum.skillState.using then
		if SLFramework.FrameworkSettings.IsEditor then
			self._quickPassCount = self._quickPassCount or 0
			self._quickPassCount = self._quickPassCount + 1

			if self._quickPassCount >= 10 then
				local afterStory = tonumber(self._episodeCfg.story)

				if afterStory ~= 0 then
					DungeonMazeController.instance:playMazeAfterStory(afterStory)

					return
				end
			end
		end

		GameFacade.showToast(ToastEnum.MazeGameEyeSkillUsingToast)
	elseif curSkillState == DungeonMazeEnum.skillState.cooling then
		GameFacade.showToast(ToastEnum.MazeGameEyeSkillCoolingToast)
	else
		DungeonMazeController.instance:UseEyeSkill()
		self:_refreshSkillView()
		DungeonMazeModel.instance:SaveCurProgress()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
	end
end

function DungeonMazeView:_onClickRestartBtn()
	GameFacade.showMessageBox(MessageBoxIdDefine.WarmUpGameReFight, MsgBoxEnum.BoxType.Yes_No, self._doClickRestartAction, nil, nil)
end

function DungeonMazeView:_doClickRestartAction()
	local curCell = DungeonMazeModel.instance:getCurCellData()
	local chaosValue = DungeonMazeModel.instance:getChaosValue()

	DungeonMazeController.instance:sandStatData(DungeonMazeEnum.resultStat[4], curCell.cellId, chaosValue)
	ctrl:dispatchEvent(DungeonMazeEvent.DungeonMazeReStart)
end

function DungeonMazeView:onClickText()
	return
end

function DungeonMazeView:onMazeCompleted()
	self:closeThis()
end

function DungeonMazeView:onMazeExit()
	self:closeThis()
end

function DungeonMazeView:onMazeRestart()
	DungeonMazeController.instance:initStatData()
	DungeonMazeModel.instance:initData()
	self:initMap()
end

function DungeonMazeView:_editableInitView()
	self._roadStopMap = self:getUserDataTb_()
	self._roadStopMap[DungeonMazeEnum.dir.left] = self._goRoadStopLeft
	self._roadStopMap[DungeonMazeEnum.dir.right] = self._goRoadStopRight
	self._roadStopMap[DungeonMazeEnum.dir.down] = self._goRoadStopBottom
	self._roadStopMap[DungeonMazeEnum.dir.up] = self._goRoadStopUp
	self._roadDirMap = self:getUserDataTb_()
	self._roadDirMap[DungeonMazeEnum.dir.left] = self._goRoadDirLeft
	self._roadDirMap[DungeonMazeEnum.dir.right] = self._goRoadDirRight
	self._roadDirMap[DungeonMazeEnum.dir.down] = self._goRoadDirBottom
	self._roadDirMap[DungeonMazeEnum.dir.up] = self._goRoadDirUp
	self._roadLightMap = self:getUserDataTb_()
	self._roadLightMap[DungeonMazeEnum.dir.left] = self._goRoadLightLeft
	self._roadLightMap[DungeonMazeEnum.dir.right] = self._goRoadLightRight
	self._roadLightMap[DungeonMazeEnum.dir.down] = self._goRoadLightBottom
	self._roadLightMap[DungeonMazeEnum.dir.up] = self._goRoadLightUp
	self._roadEventMap = self:getUserDataTb_()
	self._roadEventMap[DungeonMazeEnum.dir.left] = self._goRoadEventLeft
	self._roadEventMap[DungeonMazeEnum.dir.right] = self._goRoadEventRight
	self._roadEventMap[DungeonMazeEnum.dir.down] = self._goRoadEventBottom
	self._roadEventMap[DungeonMazeEnum.dir.up] = self._goRoadEventUp
	self._roadDirBtnMap = self:getUserDataTb_()
	self._roadDirBtnMap[DungeonMazeEnum.dir.left] = self._leftRoadBtn
	self._roadDirBtnMap[DungeonMazeEnum.dir.right] = self._rightRoadBtn
	self._roadDirBtnMap[DungeonMazeEnum.dir.down] = self._downRoadBtn
	self._roadDirBtnMap[DungeonMazeEnum.dir.up] = self._upRoadBtn
	self._roadEventBtnMap = self:getUserDataTb_()
	self._roadEventBtnMap[DungeonMazeEnum.dir.left] = self._leftEventBtn
	self._roadEventBtnMap[DungeonMazeEnum.dir.right] = self._rightEventBtn
	self._roadEventBtnMap[DungeonMazeEnum.dir.down] = self._downEventBtn
	self._roadEventBtnMap[DungeonMazeEnum.dir.up] = self._upEventBtn

	gohelper.setActive(self._goChaoAdd, false)
	gohelper.setActive(self._goTalk, false)
end

function DungeonMazeView:onUpdateParam()
	return
end

function DungeonMazeView:onOpen()
	self._episodeCfg = self.viewParam.episodeCfg

	local existProgress = self.viewParam.existProgress

	if not existProgress then
		DungeonMazeModel.instance:SaveCurProgress()
	end

	local dialogHideTimeConstCfg = DungeonGameConfig.instance:getMazeGameConst(DungeonMazeEnum.hideDialogTimeConstId)

	self._dialogHideTime = dialogHideTimeConstCfg and tonumber(dialogHideTimeConstCfg.size) or 4

	self:initMap()
end

function DungeonMazeView:onOpenFinish()
	DungeonMazeController.instance:dispatchEvent(DungeonMazeEvent.EnterDungeonMaze)
end

function DungeonMazeView:onClose()
	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.stop_ui_fuleyuan_eyes)
end

function DungeonMazeView:initMap()
	self:_refreshCurCellView()
	self:_refreshChaosValueView()
	gohelper.setActive(self._goChaoAdd, false)
	self:_refreshChessView()
	self:_refreshSkillView()
end

function DungeonMazeView:_refreshCurCellView()
	self._curCell = DungeonMazeModel.instance:getCurCellData()

	local borderCells = self._curCell.connectSet

	self._leftCell = borderCells[DungeonMazeEnum.dir.left]
	self._rightCell = borderCells[DungeonMazeEnum.dir.right]
	self._upCell = borderCells[DungeonMazeEnum.dir.up]
	self._downCell = borderCells[DungeonMazeEnum.dir.down]

	for dir, roadStop in pairs(self._roadStopMap) do
		local cellData = borderCells[dir]

		gohelper.setActive(roadStop, not cellData and true or not cellData.pass)
		gohelper.setActive(self._roadDirMap[dir], cellData and cellData.pass)

		local showObstacleDialog = false
		local roadObstacleGo = self._roadEventMap[dir]
		local isObstacle = cellData and not string.nilorempty(cellData.obstacleDialog)
		local obstacleToggled = false

		if isObstacle then
			gohelper.setActive(roadObstacleGo, true)

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

		DungeonMazeController.instance:dispatchEvent(DungeonMazeEvent.ShowMazeObstacleDialog, dir, (showObstacleDialog or nil) and (cellData.obstacleDialog or nil), obstacleToggled)
	end

	gohelper.setActive(self._goDestination, false)

	for dir, cellData in pairs(borderCells) do
		if cellData and cellData.value == 2 then
			gohelper.setActive(self._goDestination, true)
		end
	end

	local chaosValue = DungeonMazeModel.instance:getChaosValue()

	if chaosValue and chaosValue < DungeonMazeEnum.MaxChaosValue then
		ctrl:dispatchEvent(DungeonMazeEvent.ArriveMazeGameCell, self._curCell.cellId)
	end
end

function DungeonMazeView:_refreshCurCellDialogView()
	if self._curCell.toggled then
		return
	end

	local eventId = self._curCell.eventId

	if eventId and eventId > 0 then
		local eventCfg = DungeonGameConfig.instance:getMazeEventCfg(eventId)

		if eventCfg then
			gohelper.setActive(self._goTalk, true)

			self._txttalk.text = eventCfg.desc

			TaskDispatcher.runDelay(self._delayHideDialog, self, self._dialogHideTime)

			self._curCell.toggled = true
		end
	end
end

function DungeonMazeView:_delayHideDialog()
	gohelper.setActive(self._goTalk, false)
end

function DungeonMazeView:_refreshChaosValueView()
	gohelper.setActive(self._goChaoAdd, true)
	self._bottomAnimator:Play(UIAnimationName.Open, 0, 0)

	local chaosValue = DungeonMazeModel.instance:getChaosValue()

	if chaosValue >= dangerousChaoValue then
		gohelper.setActive(self._goNormalChaoValue, false)
		gohelper.setActive(self._goDangerousChaoValue, true)
	else
		gohelper.setActive(self._goNormalChaoValue, true)
		gohelper.setActive(self._goDangerousChaoValue, false)
	end

	self._textChaosAdd.text = "+" .. DungeonMazeModel.instance:getAddChaosValue()
	self._textChaosValue.text = chaosValue
	self._textDangerousValue.text = chaosValue
end

function DungeonMazeView:_refreshChessView()
	recthelper.setAnchor(self._transChess, 0, 0)
	ZProj.TweenHelper.DOFadeCanvasGroup(self._goChess, 0, 1, 0.25)
end

function DungeonMazeView:_refreshSkillView()
	local curSkillState, skillCooling = DungeonMazeModel.instance:GetSkillState()

	gohelper.setActive(self._goEyeNormal, curSkillState == DungeonMazeEnum.skillState.usable)
	gohelper.setActive(self._goEyeActive, curSkillState == DungeonMazeEnum.skillState.using)
	gohelper.setActive(self._goEyeCooling, curSkillState == DungeonMazeEnum.skillState.cooling)
	gohelper.setActive(self._goSkillCoolingStar1Light, skillCooling >= 1)
	gohelper.setActive(self._goSkillCoolingStar2Light, skillCooling >= 2)
	gohelper.setActive(self._goSkillCoolingStar1Drak, skillCooling < 1)
	gohelper.setActive(self._goSkillCoolingStar2Drak, skillCooling < 2)

	if curSkillState == DungeonMazeEnum.skillState.using then
		local nextCell = DungeonMazeModel.instance:getNearestCellToDestination()
		local curCell = DungeonMazeModel.instance:getCurCellData()
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

function DungeonMazeView:onDestroyView()
	self._imageChessIcon:UnLoadImage()
end

return DungeonMazeView
