-- chunkname: @modules/logic/versionactivity3_4/lusijian/view/LuSiJianMainGameComp.lua

module("modules.logic.versionactivity3_4.lusijian.view.LuSiJianMainGameComp", package.seeall)

local LuSiJianMainGameComp = class("LuSiJianMainGameComp", LuaCompBase)

function LuSiJianMainGameComp:onInitView(go, parent)
	self.viewGO = go
	self.viewTrs = self.viewGO.transform
	self._parent = parent
	self._godraw = gohelper.findChild(self.viewGO, "Draw")
	self._gofinish = gohelper.findChild(self.viewGO, "Finished")
	self._gopoint = gohelper.findChild(self.viewGO, "Draw/pointroot/#go_point")
	self._gonormal = gohelper.findChild(self.viewGO, "Draw/pointroot/#go_point/#go_normal")
	self._godisturb = gohelper.findChild(self.viewGO, "Draw/pointroot/#go_point/#go_disturb")
	self._goconnected = gohelper.findChild(self.viewGO, "Draw/pointroot/#go_point/#go_connected")
	self._gofristpoint = gohelper.findChild(self.viewGO, "Draw/pointroot/#go_point/#go_fristpoint")
	self._godrag = gohelper.findChild(self.viewGO, "Draw/#go_drag")
	self._goCuttingFrame = gohelper.findChild(self.viewGO, "Draw/Image_CuttingFrame")
	self._gopointroot = gohelper.findChild(self.viewGO, "Draw/pointroot")
	self._gopoint = gohelper.findChild(self.viewGO, "Draw/pointroot/#go_point")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Finished/#btn_Close")
	self._goPieces = gohelper.findChild(self.viewGO, "Draw/Pieces")
	self._goDragLight = gohelper.findChild(self.viewGO, "Draw/Light")
	self._trsDragLight = gohelper.findChild(self.viewGO, "Draw/Light").transform
	self._goDragLightClick = gohelper.findChild(self.viewGO, "Draw/Light/click")
	self._trsDragLightClick = gohelper.findChild(self.viewGO, "Draw/Light/click").transform
	self._animator = self._godraw:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LuSiJianMainGameComp:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	CommonDragHelper.instance:registerDragObj(self._godrag, self._onDragBeginPoint, self._onDragPoint, self._onDragEndPoint, nil, self, nil, true)
end

function LuSiJianMainGameComp:removeEvents()
	CommonDragHelper.instance:unregisterDragObj(self._godrag)
	self._btnClose:RemoveClickListener()
end

function LuSiJianMainGameComp:_btnCloseOnClick()
	LuSiJianGameController.instance:dispatchEvent(LuSiJianEvent.CloseGameView)
end

function LuSiJianMainGameComp:_editableInitView()
	self._finishShowTime = 0.5
	self._gameMo = LuSiJianGameModel.instance:getGameMo()

	self:addEvents()
	self:_initPieces()
	self:_initDrag()

	if LuSiJianGameModel.instance:_isShowPoint() then
		self:_initPoint()
	end

	gohelper.setActive(self._godraw, true)
	gohelper.setActive(self._gofinish, false)
	AudioMgr.instance:trigger(AudioEnum3_4.LuSiJian.play_ui_bulaochun_paper1)
end

function LuSiJianMainGameComp:_initDrag()
	gohelper.setActive(self._goDragLight, true)

	self._writingBrush = self._godrag:GetComponent(typeof(ZProj.WritingBrush))

	self:_initMovePoint()
end

function LuSiJianMainGameComp:_initMovePoint()
	local curStartPointIds = LuSiJianGameModel.instance:getStartPointIds()

	if curStartPointIds then
		for _, pointId in ipairs(curStartPointIds) do
			local pointMo = LuSiJianGameModel.instance:getPointById(pointId)
			local posX, posY = pointMo:getPosXY()
			local mo = pointMo

			self._movePointMo = LuSiJianPointMo.New(mo)

			recthelper.setAnchor(self._trsDragLight, posX, posY)

			break
		end
	end
end

function LuSiJianMainGameComp:_initPieces()
	self._piecesList = {}
	self._piecesCount = self._goPieces.transform.childCount

	for i = 1, self._piecesCount do
		local piece = self:getUserDataTb_()
		local go = gohelper.findChild(self._goPieces, "Piece" .. i)

		piece.piecesGo = go
		piece.btnclick = gohelper.findChildButton(go, "Click")
		piece.goon = gohelper.findChild(go, "On")
		piece.gooff = gohelper.findChild(go, "Off")

		gohelper.setAsLastSibling(piece.btnclick.gameObject)
		piece.btnclick:AddClickListener(self._onClickPiece, self, piece)

		piece.isClick = false
		piece.animator = piece.gooff:GetComponent(typeof(UnityEngine.Animator))

		gohelper.setActive(piece.gooff, not piece.isClick)
		gohelper.setActive(piece.goon, piece.isClick)
		table.insert(self._piecesList, piece)
	end
end

function LuSiJianMainGameComp:_onClickPiece(piece)
	if not piece or piece.isClick then
		return
	end

	piece.isClick = true

	gohelper.setActive(piece.gooff, not piece.isClick)
	gohelper.setActive(piece.goon, piece.isClick)
	gohelper.setAsFirstSibling(piece.piecesGo)
	AudioMgr.instance:trigger(AudioEnum3_4.LuSiJian.play_ui_bulaochun_dian1)
	self:_checkFinishGame()
end

function LuSiJianMainGameComp:_checkAllPiecesClick()
	if #self._piecesList > 0 then
		for _, piece in ipairs(self._piecesList) do
			if not piece.isClick then
				return false
			end
		end

		return true
	end

	return false
end

function LuSiJianMainGameComp:_initPoint()
	if self._pointItem == nil then
		self._pointItem = self:getUserDataTb_()
	end

	local allPoint = self._gameMo:getAllPoint()

	if allPoint == nil then
		return
	end

	for _, pointmo in pairs(allPoint) do
		local item = self._pointItem[pointmo.id]

		if item == nil then
			local point = self:getUserDataTb_()

			point.go = gohelper.clone(self._gopoint, self._gopointroot, "point" .. pointmo.id)
			point.comp = MonoHelper.addNoUpdateLuaComOnceToGo(point.go, LuSiJianPointItem)
			point.mo = pointmo
			self._pointItem[pointmo.id] = point

			point.comp:updateInfo(pointmo)
		end
	end
end

function LuSiJianMainGameComp:_onDragBeginPoint(_, pointerEventData)
	if self._isReviewing then
		return
	end

	local position = pointerEventData.position
	local mousePosX, mousePosY = recthelper.screenPosToAnchorPos2(position, self.viewGO.transform)

	if LuSiJianGameModel.instance:checkNeedCheckListEmpty() then
		local curStartPointIds = LuSiJianGameModel.instance:getStartPointIds()

		if curStartPointIds then
			for index, pointId in ipairs(curStartPointIds) do
				local pointMo = LuSiJianGameModel.instance:getPointById(pointId)

				if pointMo and pointMo:isInCanConnectionRange(mousePosX, mousePosY) then
					self._canDrag = true

					break
				end
			end
		end
	else
		self._canDrag = not not (self._movePointMo and self._movePointMo:isInCanConnectionRange(mousePosX, mousePosY))
	end
end

function LuSiJianMainGameComp:_onDragPoint(_, pointerEventData)
	if not self._canDrag then
		return
	end

	local screenX = pointerEventData.position.x
	local screenY = pointerEventData.position.y

	self._writingBrush:OnMouseMove(screenX, screenY)

	local mousePosX, mousePosY = recthelper.screenPosToAnchorPos2(pointerEventData.position, self.viewTrs)

	gohelper.setActive(self._goDragLightClick, true)
	AudioMgr.instance:trigger(AudioEnum3_4.LuSiJian.play_ui_bulaochun_lian1)
	self._movePointMo:updatePos(mousePosX, mousePosY)
	recthelper.setAnchor(self._trsDragLight, mousePosX, mousePosY)

	if LuSiJianGameModel.instance:_isShowPoint() then
		if not self._pointItem or self._pointItem == 0 then
			return
		end

		local hasNewValidPoint = LuSiJianGameModel.instance:checkDiffPosAndConnection(mousePosX, mousePosY)

		if hasNewValidPoint then
			local isStart = LuSiJianGameModel.instance:getStartState()
			local pointIdList = LuSiJianGameModel.instance:getNeedCheckPointList()
			local curStartPointIds = LuSiJianGameModel.instance:getConfigStartPointIds()

			if not isStart then
				for _, pointId in ipairs(curStartPointIds) do
					local point = self._pointItem[pointId]

					if point and point.comp then
						point.comp:updateUI()
					end
				end

				LuSiJianGameModel.instance:setStartState(true)
			end

			if pointIdList and #pointIdList > 0 then
				for _, pointId in ipairs(pointIdList) do
					local point = self._pointItem[pointId]

					if point and point.comp then
						point.comp:updateUI()
					end
				end
			end
		end
	else
		LuSiJianGameModel.instance:checkDiffPosAndConnection(mousePosX, mousePosY)
	end
end

function LuSiJianMainGameComp:_onDragEndPoint(_, pointerEventData)
	self._writingBrush:OnMouseUp()

	if LuSiJianGameModel.instance:getWrong() then
		self._writingBrush:Clear()
		LuSiJianGameModel.instance:clearCheckPointList()
		self:_initMovePoint()
		GameFacade.showToast(ToastEnum.LuSiJianReset)
		LuSiJianStatHelper.instance:sendGameReset()

		if LuSiJianGameModel.instance:_isShowPoint() then
			self:resetPoint()
		end
	elseif LuSiJianGameModel.instance:checkPointFinish() then
		self:_connectFinish()
	end

	gohelper.setActive(self._goDragLightClick, false)
	AudioMgr.instance:trigger(AudioEnum3_4.LuSiJian.stop_ui_bulaochun_lian1)

	self._canDrag = false
end

function LuSiJianMainGameComp:resetPoint()
	local pointMoList = LuSiJianGameModel.instance:getAllPoint()

	for _, pointMo in ipairs(pointMoList) do
		pointMo:clearPoint()

		local point = self._pointItem[pointMo.id]

		point.comp:updateUI()
	end
end

function LuSiJianMainGameComp:_finishGame()
	self._animator:Play("close", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_4.LuSiJian.play_ui_bulaochun_paper1)
	TaskDispatcher.runDelay(self._gameFinish, self, self._finishShowTime)
end

function LuSiJianMainGameComp:_gameFinish()
	TaskDispatcher.cancelTask(self._gameFinish, self)
	gohelper.setActive(self._godraw, false)
	gohelper.setActive(self._gofinish, true)
	LuSiJianStatHelper.instance:sendGameFinish()
	AudioMgr.instance:trigger(AudioEnum3_4.LuSiJian.play_ui_bulaochun_win2)
	LuSiJianGameController.instance:dispatchEvent(LuSiJianEvent.GameFinished)
end

function LuSiJianMainGameComp:_connectFinish()
	gohelper.setActive(self._goCuttingFrame, true)
	gohelper.setActive(self._godrag, false)
	gohelper.setActive(self._gopointroot, false)
	gohelper.setActive(self._goDragLight, false)
	AudioMgr.instance:trigger(AudioEnum3_4.LuSiJian.play_ui_bulaochun_win1)
	gohelper.setAsLastSibling(self._goPieces)
	self:_switchPiecesAni()
	LuSiJianGameController.instance:dispatchEvent(LuSiJianEvent.OnConnectGuideFinish)
	LuSiJianGameController.instance:dispatchEvent(LuSiJianEvent.CompleteLine)
end

function LuSiJianMainGameComp:_checkFinishGame()
	if self:_checkAllPiecesClick() and LuSiJianGameModel.instance:checkPointFinish() then
		self:_finishGame()
	end
end

function LuSiJianMainGameComp:_switchPiecesAni()
	for _, piece in ipairs(self._piecesList) do
		if piece and piece.animator then
			piece.animator:Play("light", 0, 0)
		end
	end
end

function LuSiJianMainGameComp:onDestroy()
	self:removeEvents()
	AudioMgr.instance:trigger(AudioEnum3_4.LuSiJian.stop_ui_bulaochun_lian1)

	for _, piece in ipairs(self._piecesList) do
		if piece and piece.btnclick then
			piece.btnclick:RemoveClickListener()
		end
	end
end

return LuSiJianMainGameComp
