-- chunkname: @modules/logic/partygame/view/puzzle/PuzzleGameView.lua

module("modules.logic.partygame.view.puzzle.PuzzleGameView", package.seeall)

local PuzzleGameView = class("PuzzleGameView", PartyGameCommonView)

function PuzzleGameView:onInitView()
	PuzzleGameView.super.onInitView(self)

	self._goPlayerItem = gohelper.findChild(self.viewGO, "#go_PlayerItem")
	self._goGridLeft = gohelper.findChild(self.viewGO, "#go_GridLeft")
	self._goGridRight = gohelper.findChild(self.viewGO, "#go_GridRight")
	self._goMain = gohelper.findChild(self.viewGO, "#go_Main")
	self._txtPlayerName = gohelper.findChildText(self.viewGO, "#go_Main/playername/#txt_PlayerName")
	self._goHead = gohelper.findChild(self.viewGO, "#go_Main/playername/#txt_PlayerName/#go_Head")
	self._goGrid = gohelper.findChild(self.viewGO, "#go_Main/plate/#go_Grid")
	self._goFinish = gohelper.findChild(self.viewGO, "#go_Main/#go_Finish")
	self._simageFinishIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Main/#go_Finish/#simage_FinishIcon")
	self._txtFinishTime = gohelper.findChildText(self.viewGO, "#go_Main/#go_Finish/txt_finish/#txt_FinishTime")
	self._goFail = gohelper.findChild(self.viewGO, "#go_Main/#go_Fail")
	self._btnCheck = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Check")
	self._simageCheck = gohelper.findChildSingleImage(self.viewGO, "#btn_Check/#simage_Check")
	self._goPattern = gohelper.findChild(self.viewGO, "#go_Pattern")
	self._simagePattern = gohelper.findChildSingleImage(self.viewGO, "#go_Pattern/#simage_Pattern")
	self._btnClosePattern = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Pattern/#btn_ClosePattern")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	gohelper.setActive(self._goMain, false)
	gohelper.setActive(self._goGridLeft, false)
	gohelper.setActive(self._goGridRight, false)

	self.animPattern = gohelper.findChildAnim(self.viewGO, "#go_Pattern")
end

function PuzzleGameView:addEvents()
	PuzzleGameView.super.addEvents(self)
	self._btnCheck:AddClickListener(self._btnCheckOnClick, self)
	self._btnClosePattern:AddClickListener(self._btnClosePatternOnClick, self)
end

function PuzzleGameView:removeEvents()
	self._btnCheck:RemoveClickListener()
	self._btnClosePattern:RemoveClickListener()
end

function PuzzleGameView:_btnClosePatternOnClick()
	if not self.canOperate then
		return
	end

	self:hidePattern()
end

function PuzzleGameView:_btnCheckOnClick()
	if not self.canOperate then
		return
	end

	gohelper.setActive(self._goPattern, true)
end

function PuzzleGameView:onDestroy()
	local pieceItems = self.playerPieceItemsMap[self.mainPlayerIndex]

	for _, item in ipairs(pieceItems) do
		CommonDragHelper.instance:unregisterDragObj(item.go)
	end

	TaskDispatcher.cancelTask(self.delayHide, self)
	TaskDispatcher.cancelTask(self.delayRecover, self)
end

function PuzzleGameView:onCreateCompData()
	self.GameInterface = PartyGameCSDefine.PuzzleGameInterface
	self.curStep = self.GameInterface.GetCurStep()
	self.partyGameCountDownData = {
		getCountDownFunc = self.getCountDownFunc,
		context = self
	}
	self.maxRound = self.GameInterface.GetMaxRound()
end

function PuzzleGameView:onCreate()
	self:initPlayer()
end

function PuzzleGameView:onViewUpdate()
	local curStep = self.GameInterface.GetCurStep()

	if self.curStep ~= curStep then
		self:onStateChange(curStep)
	end

	if self.curStep == PartyPuzzleEnum.GameState.Answer then
		for i = 1, #self.playerMoList do
			local playerMo = self.playerMoList[i]
			local playerIndex = playerMo.index
			local operateCnt = self.GameInterface.GetOperateCount(playerIndex)

			if self.operateCntMap[playerIndex] ~= operateCnt then
				self.operateCntMap[playerIndex] = operateCnt

				local pieceItems = self.playerPieceItemsMap[playerIndex]

				if playerMo:isMainPlayer() then
					for _, item in ipairs(pieceItems) do
						ZProj.TweenHelper.KillByObj(item.transform)
						recthelper.setAnchor(item.transform, item.initPosX, item.initPosY)
					end
				end

				self:refreshPieceItem(playerIndex)

				local answerTime = self.GameInterface.GetPlayerAnswerTime(playerIndex)

				if answerTime ~= 0 then
					if playerIndex == self.mainPlayerIndex then
						self._txtFinishTime.text = Mathf.Round(answerTime * 10) / 10

						gohelper.setActive(self._goFinish, true)
						gohelper.setActive(self._btnCheck, false)
						AudioMgr.instance:trigger(AudioEnum3_4.PartyGame18.play_ui_yuzhou_level_unlock)

						self.canOperate = false
					else
						local item = self.playerItemMap[playerIndex]

						item.txtFinishTime.text = Mathf.Round(answerTime * 10) / 10

						gohelper.setActive(item.goFinish, true)
						AudioMgr.instance:trigger(AudioEnum3_4.PartyGame18.play_ui_yuzhou_ball_star)
					end
				end
			end
		end
	end
end

function PuzzleGameView:getCountDownFunc()
	if self.curStep == PartyPuzzleEnum.GameState.Answer then
		return self.GameInterface.GetStepLeftTime()
	end
end

function PuzzleGameView:initPlayer()
	self.playerPieceItemsMap = {}
	self.operateCntMap = {}
	self.playerMoList = PartyGameModel.instance:getCurGamePlayerList()
	self.playerItemMap = {}

	local cloneCnt = 0

	for i = 1, #self.playerMoList do
		local playerMo = self.playerMoList[i]
		local playerIndex = playerMo.index

		self.operateCntMap[playerIndex] = self.GameInterface.GetOperateCount(playerIndex)

		if playerMo:isMainPlayer() then
			self.mainPlayerIndex = playerIndex
			self._txtPlayerName.text = playerMo.name

			self:initPieceItem(self.mainPlayerIndex, self._goGrid)

			self.mainHeadItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goHead, PartyGamePlayerHead)

			self.mainHeadItem:setData({
				isAutoShowRank = true,
				uid = playerMo.uid
			})
		elseif cloneCnt < 3 then
			if not self._goGridLeft then
				local parent = self._goGridRight
				local cloneGo = gohelper.clone(self._goPlayerItem, parent)
				local playerItem = self:getUserDataTb_()
				local txtName = gohelper.findChildText(cloneGo, "txt_Name")

				txtName.text = playerMo.name
				playerItem.goFinish = gohelper.findChild(cloneGo, "go_Finish")
				playerItem.txtFinishTime = gohelper.findChildText(cloneGo, "go_Finish/txt_FinishTime")
				playerItem.goFail = gohelper.findChild(cloneGo, "go_Fail")

				local goHead = gohelper.findChild(cloneGo, "go_Head")

				if cloneCnt >= 3 then
					recthelper.setAnchorX(goHead.transform, -150)
				end

				playerItem.headItem = MonoHelper.addNoUpdateLuaComOnceToGo(goHead, PartyGamePlayerHead)

				playerItem.headItem:setData({
					isAutoShowRank = true,
					uid = playerMo.uid
				})

				playerItem.go = cloneGo
				self.playerItemMap[playerIndex] = playerItem

				local goGrid = gohelper.findChild(cloneGo, "plate/grid")

				self:initPieceItem(playerIndex, goGrid)

				cloneCnt = cloneCnt + 1
			end
		end
	end

	gohelper.setActive(self._goPlayerItem, false)
end

function PuzzleGameView:initPieceItem(playerIndex, parent)
	self.playerPieceItemsMap[playerIndex] = {}

	for i = 1, 9 do
		local pieceItem = self:getUserDataTb_()
		local go = gohelper.findChild(parent, "PieceItem_" .. tostring(i))

		pieceItem.simage = gohelper.findChildSingleImage(go, "image")

		local x, y = recthelper.getAnchor(go.transform)

		pieceItem.initPosX = x
		pieceItem.initPosY = y

		if playerIndex == self.mainPlayerIndex then
			pieceItem.goSelect = gohelper.findChild(go, "select")

			local btnClick = gohelper.findButtonWithAudio(go)

			self.addClickCb(self, btnClick, self.onClickPiece, self, i)
			CommonDragHelper.instance:registerDragObj(go, self._beginDrag, self._onDrag, self._endDrag, self._checkDrag, self, i)
		end

		pieceItem.go = go
		pieceItem.transform = go.transform
		self.playerPieceItemsMap[playerIndex][i] = pieceItem
	end
end

function PuzzleGameView:onClickPiece(index)
	if not self.canOperate or self.dragIndex then
		return
	end

	self.GameInterface.ClickPuzzle(index)
end

function PuzzleGameView:onStateChange(step)
	self.curStep = step

	if step == PartyPuzzleEnum.GameState.Ready then
		local curRound = self.GameInterface.GetCurRound()

		if self.curRound ~= curRound then
			self.partyGameRoundTip:setRoundData(curRound, self.maxRound)

			self.pictureId = self.GameInterface.GetPictureId()

			self._simagePattern:LoadImage(PartyPuzzleHelper.getPieceIcon(self.pictureId))
		end

		self.curRound = curRound
	elseif step == PartyPuzzleEnum.GameState.Show then
		self.partyGameRoundTip:setIsShow(false)
		gohelper.setActive(self._goPattern, true)

		for i = 1, #self.playerMoList do
			local playerIndex = self.playerMoList[i].index

			self:refreshPieceItem(playerIndex)
		end

		if not self._goMain.activeInHierarchy then
			gohelper.setActive(self._goMain, true)
			gohelper.setActive(self._goGridLeft, true)
			gohelper.setActive(self._goGridRight, true)
		end
	elseif step == PartyPuzzleEnum.GameState.Answer then
		gohelper.setActive(self._btnCheck, true)
		self:hidePattern()
	elseif step == PartyPuzzleEnum.GameState.Settle then
		self:onSettleEnter()
	end

	self.canOperate = step == PartyPuzzleEnum.GameState.Answer
end

function PuzzleGameView:refreshPieceItem(playerIndex)
	local pieceItems = self.playerPieceItemsMap[playerIndex]

	for k, item in ipairs(pieceItems) do
		local pieceId = self.GameInterface.GetPieceId(playerIndex, k)
		local iconName = PartyPuzzleHelper.getPieceIcon(self.pictureId, pieceId)

		item.simage:LoadImage(iconName)

		local roatation = self.GameInterface.GetPieceRotation(playerIndex, k)

		transformhelper.setEulerAngles(item.transform, 0, 0, roatation * -90)
	end
end

function PuzzleGameView:onSettleEnter()
	local answerTime = self.GameInterface.GetPlayerAnswerTime(self.mainPlayerIndex)
	local scoreAdd = self.GameInterface.GetPlayerScoreAdd(self.mainPlayerIndex)

	if scoreAdd > 0 then
		self.mainHeadItem:setScoreAddAnim(true, scoreAdd)
	else
		AudioMgr.instance:trigger(AudioEnum3_4.PartyGame18.play_ui_yuzhou_ball_trap)
	end

	gohelper.setActive(self._goFail, answerTime == 0)

	for playerIndex, item in pairs(self.playerItemMap) do
		answerTime = self.GameInterface.GetPlayerAnswerTime(playerIndex)
		scoreAdd = self.GameInterface.GetPlayerScoreAdd(playerIndex)

		if scoreAdd > 0 then
			item.headItem:setScoreAddAnim(true, scoreAdd)
		end

		gohelper.setActive(item.goFail, answerTime == 0)
	end
end

function PuzzleGameView:onSettleExit()
	gohelper.setActive(self._goFinish, false)
	gohelper.setActive(self._goFail, false)

	for _, item in pairs(self.playerItemMap) do
		gohelper.setActive(item.goFinish, false)
		gohelper.setActive(item.goFail, false)
	end
end

function PuzzleGameView:_checkDrag()
	return not self.canOperate or self.dragIndex
end

function PuzzleGameView:_beginDrag(index)
	self.dragIndex = index
end

function PuzzleGameView:_onDrag(index, pointerEventData)
	if not self.dragIndex then
		return
	end

	local pieceItems = self.playerPieceItemsMap[self.mainPlayerIndex]

	for k, item in ipairs(pieceItems) do
		if k ~= index and gohelper.isMouseOverGo(item.go, pointerEventData.position) then
			if self.targetIndex ~= k then
				if self.targetIndex then
					gohelper.setActive(pieceItems[self.targetIndex].goSelect, false)
				end

				gohelper.setActive(pieceItems[k].goSelect, true)

				self.targetIndex = k
			end

			break
		end

		if k == #pieceItems and self.targetIndex then
			gohelper.setActive(pieceItems[self.targetIndex].goSelect, false)

			self.targetIndex = nil
		end
	end
end

function PuzzleGameView:_endDrag(index)
	if not self.dragIndex then
		return
	end

	local pieceItems = self.playerPieceItemsMap[self.mainPlayerIndex]
	local pieceItem = pieceItems[index]

	ZProj.TweenHelper.KillByObj(pieceItem.transform)

	if self.targetIndex then
		local targetItem = pieceItems[self.targetIndex]

		PuzzleGameView.tweenPos(pieceItem.transform, targetItem.initPosX, targetItem.initPosY)
		PuzzleGameView.tweenPos(targetItem.transform, pieceItem.initPosX, pieceItem.initPosY)
		self.GameInterface.DragPuzzle(index, self.targetIndex)
		gohelper.setActive(targetItem.goSelect, false)

		self.targetIndex = nil

		AudioMgr.instance:trigger(AudioEnum3_4.PartyGame18.play_ui_activity_mark_finish)
	else
		PuzzleGameView.tweenPos(pieceItem.transform, pieceItem.initPosX, pieceItem.initPosY)
	end

	TaskDispatcher.runDelay(self.delayRecover, self, 0.2)
end

function PuzzleGameView:delayRecover()
	self.dragIndex = nil
end

function PuzzleGameView.tweenPos(transform, targetX, targetY)
	local x, y = recthelper.getAnchor(transform)

	if math.abs(x - targetX) > 20 or math.abs(y - targetY) > 20 then
		ZProj.TweenHelper.DOAnchorPos(transform, targetX, targetY, 0.2)
	else
		recthelper.setAnchor(transform, targetX, targetY)
	end
end

function PuzzleGameView:hidePattern()
	self:onSettleExit()
	self._simageFinishIcon:LoadImage(PartyPuzzleHelper.getPieceIcon(self.pictureId))
	self._simageCheck:LoadImage(PartyPuzzleHelper.getPieceIcon(self.pictureId))
	self.animPattern:Play("out", 0, 0)
	TaskDispatcher.runDelay(self.delayHide, self, 0.35)
end

function PuzzleGameView:delayHide()
	gohelper.setActive(self._goPattern, false)
end

return PuzzleGameView
