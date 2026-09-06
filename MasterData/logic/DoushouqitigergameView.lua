-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqitigergameView.lua

module("logic.extensions.doushouqi.view.DoushouqitigergameView", package.seeall)

local DoushouqitigergameView = class("DoushouqitigergameView", ViewComponent)

DoushouqitigergameView.Dir = {
	Left = 1,
	Right = 2
}

function DoushouqitigergameView:ctor()
	DoushouqitigergameView.super.ctor(self)
end

function DoushouqitigergameView:unbindEvents()
	DoushouqitigergameView.super.unbindEvents(self)
	self._btnQiuhe:RemoveClickListener()
	self._btnRenshu:RemoveClickListener()
	self._btnChat:RemoveClickListener()
	self._btnClose:RemoveClickListener()

	for posId, chessCell in pairs(self._chessMapByPosId) do
		GameUtil.rmClickHandler(chessCell.btn)
		GameUtil.rmClickHandler(chessCell.btnCircle)
	end
end

function DoushouqitigergameView:bindEvents()
	DoushouqitigergameView.super.bindEvents(self)
	self._btnQiuhe:AddClickListener(self._onClickbtnQiuhe, self)
	self._btnRenshu:AddClickListener(self._onClickbtnRenshu, self)
	self._btnChat:AddClickListener(self._onClickbtnChat, self)
	self._btnClose:AddClickListener(self.close, self)

	for posId, chessCell in pairs(self._chessMapByPosId) do
		GameUtil.addClickHandler(chessCell.btn, GameUtil.handler(self._onClickChess, self, posId))
		GameUtil.addClickHandler(chessCell.btnCircle, GameUtil.handler(self._onClickCirle, self, posId))
	end
end

function DoushouqitigergameView:buildUI()
	DoushouqitigergameView.super.buildUI(self)

	self._btnQiuhe = self:getBtn("btnQiuhe")
	self._btnRenshu = self:getBtn("btnRenshu")
	self._btnChat = self:getBtn("btnChat")
	self._txtTime = self:getTxt("time/txtTime")
	self._topleftGo = self:getGo("topleft")
	self._toprightGo = self:getGo("topright")
	self._playerItems = {}

	self:_buildHead(self._playerItems, self._topleftGo, 1)
	self:_buildHead(self._playerItems, self._toprightGo, 2)
	self:_buildChessboard()

	local lbubbleGo = self:getGo("topleft/bubble")
	local rbubbleGo = self:getGo("topright/bubble")

	self._bubbleItems = {}

	self:_buildBubble(self._bubbleItems, lbubbleGo, DoushouqitigergameView.Dir.Left)
	self:_buildBubble(self._bubbleItems, rbubbleGo, DoushouqitigergameView.Dir.Right)

	self._btnClose = self:getBtn("btnClose")
	self._timeGo = self:getGo("time")
end

function DoushouqitigergameView:_buildHead(list, root, index)
	local var_5_0 = {
		roundSide = -1,
		goHead = goutil.findChild(root, "head"),
		goBg_1 = goutil.findChild(root, "bg_1"),
		goBg_2 = goutil.findChild(root, "bg_2"),
		goEffect = goutil.findChild(root, "effect"),
		txtState = goutil.findChildTextComponent(root, "state/txtState")
	}

	var_5_0.txtBgChange = goutil.findChild(root, "state/bg"):GetComponent(ComponentType.UIImageSpriteChange)
	var_5_0.txtNum = goutil.findChildTextComponent(root, "txtNum")
	list[index] = var_5_0
end

function DoushouqitigergameView:_buildBubble(list, root, dir)
	list[dir] = {
		go = root,
		goIcon = goutil.findChild(root, "icon")
	}
end

function DoushouqitigergameView:_buildChessboard()
	self:_buildChessShowParamMap()
	self:_buildChessCellMap()
end

function DoushouqitigergameView:_buildChessShowParamMap()
	local posDataList = DoushouqiTigerGameController.instance:getMapPosDataList()

	self._showParamMapByPosId = {}
	self._showParamMapByRC = {}

	local chessSizes = {
		0.75,
		0.875,
		1,
		1.125,
		1.25
	}
	local midColPosYs = {
		275,
		145,
		0,
		-165,
		-355
	}
	local midRowPosXs = {
		-435,
		-218,
		0,
		218,
		435
	}
	local relScales = {
		0.9,
		0.95,
		1,
		1.075,
		1.15
	}

	for _, posData in ipairs(posDataList) do
		local posId = posData.posId
		local col = posData.col
		local row = posData.row
		local showParam = {
			chessSize = chessSizes[row + 1],
			posX = midRowPosXs[col + 1] * relScales[row + 1],
			posY = midColPosYs[row + 1]
		}

		self._showParamMapByPosId[posId] = showParam
		self._showParamMapByRC[row] = self._showParamMapByRC[row] or {}
		self._showParamMapByRC[row][col] = showParam
	end
end

function DoushouqitigergameView:_buildChessCellMap()
	local chessboardGo = self:getGo("chessboard")
	local chessGo = self:getGo("chessCell")

	self._chessMapByPosId = {}
	self._chessMapByPosRC = {}

	local posDataList = DoushouqiTigerGameController.instance:getMapPosDataList()

	for _, posData in ipairs(posDataList) do
		local posId = posData.posId
		local col = posData.col
		local row = posData.row
		local childPath = string.format("chessCell_%s_%s", row, col)
		local goCell = goutil.findChild(chessboardGo, childPath)

		goCell = goCell or goutil.cloneAndSetParent(chessGo, chessboardGo.transform, childPath)

		self:_resetChessShow(goCell, posId)

		local cell = {}

		cell.go = goCell
		cell.chess = goutil.findChild(goCell, "chess")
		cell.btn = cell.chess
		cell.txtShow = goutil.findChildTextComponent(goCell, "chess/txtShow")
		cell.btnCircle = goutil.findChild(goCell, "btnCircle")
		cell.bottomChange = goutil.findChild(goCell, "chess/bottom"):GetComponent(ComponentType.UIImageSpriteChange)
		cell.iconChange = goutil.findChild(goCell, "chess/bottom/icon"):GetComponent(ComponentType.UIImageSpriteChange)
		cell.txtShow.text = string.format("%s_%s", row, col)
		cell.posEffect = goutil.findChild(goCell, "effect")
		self._chessMapByPosId[posId] = cell
		self._chessMapByPosRC[row] = self._chessMapByPosRC[row] or {}
		self._chessMapByPosRC[row][col] = cell

		goutil.setActive(goCell, false)
		goutil.setActive(cell.posEffect, false)
	end

	goutil.setActive(chessGo, false)
end

function DoushouqitigergameView:_resetChessShow(go, posId)
	local param = self._showParamMapByPosId[posId]

	if go and param then
		Framework.TransformUtil.SetLocalScale(go.transform, param.chessSize, param.chessSize, 1)
		Framework.TransformUtil.SetAnchoredPos(go.transform, param.posX, param.posY)
	end
end

function DoushouqitigergameView:onExit()
	DoushouqitigergameView.super.onExit(self)

	for i, v in ipairs(self._playerItems) do
		HeadItemController.instance:resetHeadCell(v.goHead)
	end

	removetimer(self._tickTime, self)
	removetimer(self._hideOtherBubble, self)
	removetimer(self._hideMyBubble, self)

	if self._tweenMove then
		self._tweenMove:Kill(false)

		self._tweenMove = nil
	end

	if self._tweenAlpha then
		self._tweenAlpha:Kill(false)

		self._tweenAlpha = nil
	end

	self:_clearAllEffects()

	local typeInfo = DoushouqiModel.instance:getTypeInfo(DoushouqiController.ChessType.Weihuqi)
	local finishNewHand = typeInfo.finishNewHand

	if not finishNewHand and DoushouqiTigerGameController.instance:getIsLearnMode() then
		BeastFightingChessAgent.instance:sendBeastFightingChessFinishNewHandReq(self._activityId, DoushouqiController.ChessType.Weihuqi)
	end
end

function DoushouqitigergameView:onEnter()
	DoushouqitigergameView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self:_playFixedEffect()
	self:_initGame()
	self.addGEvent(self, GlobalNotify.NotifyBeastFightingChessOpEmoticonRes, self._onNotifyBeastFightingChessOpEmoticonRes, self)
	self.addGEvent(self, GlobalNotify.DoushouqiPlayLocalEmoji, self._onDoushouqiPlayLocalEmoji, self)
	self.addGEvent(self, GlobalNotify.DoushouqiTigerSelectChess, self._onSelectChess, self)
	self.addGEvent(self, GlobalNotify.DoushouqiTigerUpdateChessInfo, self._updateChessBoardShow, self)
	self.addGEvent(self, GlobalNotify.DoushouqiTigerFinishMoveChess, self._onFinishMove, self)
	self.addGEvent(self, GlobalNotify.DoushouqiTigerDoMoveChess, self._doMoveChess, self)
	self.addGEvent(self, GlobalNotify.DoushouqiTigerSwitchRound, self._onSwitchRound, self)
	self.addGEvent(self, GlobalNotify.NotifyBeastFightingChessOpRequestTieRes, self._onNotifyBeastFightingChessOpRequestTieRes, self)
	self.addGEvent(self, GlobalNotify.NotifyBeastFightingChessOpHandleTieRes, self._onNotifyBeastFightingChessOpHandleTieRes, self)
	self.addGEvent(self, GlobalNotify.DoushouqiSetMyOperation, self._onDoushouqiSetMyOperation, self)
end

function DoushouqitigergameView:_initGame()
	self._myOpFlag = true

	self:_initPlayerShow()
	self:_onSwitchRound()
	self:_onSelectChess()
	self:_updateChessBoardShow()
	settimer(1, self._tickTime, self, true)
	self:_hideMyBubble()
	self:_hideOtherBubble()
	self:_hideObjInLearning()
end

function DoushouqitigergameView:_initPlayerShow()
	if DoushouqiTigerGameController.instance:getIsLearnMode() then
		for i, item in ipairs(self._playerItems) do
			HeadItemController.instance:setMyHeadCell(item.goHead)

			item.roundSide = i == DoushouqiController.Dir.Left and DoushouqiTigerGameController.instance:getMyRoundSide() or DoushouqiTigerGameController.instance:getOpRoundSide()

			local players = DoushouqiTigerGameController.instance:getTutorialPlayInfos()

			for _, player in ipairs(players) do
				if player.side == item.roundSide then
					item.txtNum.text = player.leftStep

					break
				end
			end
		end
	else
		local mapInfo = DoushouqiModel.instance:getMapInfo()
		local myUserId = checknumber(RoleModel.instance:getUserId())
		local playerInfos = {}

		for i, v in ipairs(mapInfo.players) do
			if checknumber(v.userId) == myUserId then
				table.insert(playerInfos, DoushouqiController.Dir.Left, v)
			else
				table.insert(playerInfos, v)
			end
		end

		for i, v in ipairs(playerInfos) do
			local userId = checknumber(v.userId)
			local item = self._playerItems[i]

			if i == DoushouqiController.Dir.Left then
				HeadItemController.instance:setMyHeadCell(item.goHead)

				item.roundSide = DoushouqiTigerGameController.instance:getMyRoundSide()
			else
				local headInfo = DoushouqiModel.instance:getOpHeadInfo()

				HeadItemController.instance:setHeadCellByInfo(item.goHead, headInfo)

				item.roundSide = DoushouqiTigerGameController.instance:getOpRoundSide()
			end

			item.txtNum.text = v.leftStep
		end
	end

	for i, item in ipairs(self._playerItems) do
		goutil.setActive(item.goBg_1, DoushouqiTigerGameController.Side.Red == item.roundSide)
		goutil.setActive(item.goBg_2, DoushouqiTigerGameController.Side.Red ~= item.roundSide)
		item.txtBgChange:SetState(item.roundSide - 1)
	end
end

function DoushouqitigergameView:_onClickChess(posId)
	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiSetMyOperation)
	DoushouqiTigerGameController.instance:trySelectChess(posId)
end

function DoushouqitigergameView:_onClickCirle(posId)
	DoushouqiTigerGameController.instance:tryMoveChess(posId)
end

function DoushouqitigergameView:_onClickbtnQiuhe()
	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiSetMyOperation)

	local text = "确定求和？"

	TipsFacade.instance:openPopupWindow("提示", text, function()
		goutil.setActive(self._btnQiuhe.gameObject, false)
		BeastFightingChessAgent.instance:sendBeastFightingChessRequestTieReq(self._activityId)
	end)
end

function DoushouqitigergameView:_onClickbtnRenshu()
	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiSetMyOperation)

	local text = "确定认输？"

	TipsFacade.instance:openPopupWindow("提示", text, function()
		BeastFightingChessAgent.instance:sendBeastFightingChessLeaveRoomReq(self._activityId)
	end)
end

function DoushouqitigergameView:_onClickbtnChat()
	local x, y = Framework.TransformUtil.GetPos(self._btnChat.transform, 0, 0, 0)

	x = x + 1
	y = y + 0.5

	UIStateManager.instance:open(ViewName.DoushouqiemojiView, x, y, self._activityId)
end

function DoushouqitigergameView:_onNotifyBeastFightingChessOpEmoticonRes(id)
	self:_showOtherBubble(id)
end

function DoushouqitigergameView:_onDoushouqiPlayLocalEmoji(id)
	self:_showMyBubble(id)
end

function DoushouqitigergameView:_showOtherBubble(id)
	removetimer(self._hideOtherBubble, self)
	self:_ativeBubble(DoushouqitigergameView.Dir.Right, id)
	settimer(2, self._hideOtherBubble, self, false)
end

function DoushouqitigergameView:_hideOtherBubble()
	local item = self._bubbleItems[DoushouqitigergameView.Dir.Right]

	goutil.setActive(item.go, false)
end

function DoushouqitigergameView:_showMyBubble(id)
	removetimer(self._hideMyBubble, self)
	self:_ativeBubble(DoushouqitigergameView.Dir.Left, id)
	settimer(2, self._hideMyBubble, self, false)
end

function DoushouqitigergameView:_hideMyBubble()
	local item = self._bubbleItems[DoushouqitigergameView.Dir.Left]

	goutil.setActive(item.go, false)
end

function DoushouqitigergameView:_ativeBubble(dir, id)
	local item = self._bubbleItems[dir]
	local data = ChatConfig.instance:getEmojiCfg(id)
	local groupCfg = ChatConfig.instance:getEmojiGroupCfg(data.groupId)
	local path = string.format("ui/emoji/%s/%s.png", groupCfg.groupPrefix, data.icon)

	uGuiUtil.setSpriteToImage(item.goIcon, uGuiUtil.SpriteType.BigBg, path)
	goutil.setActive(item.go, true)
end

function DoushouqitigergameView:_updateChessBoardShow()
	local infoMap = DoushouqiTigerGameController.instance:getCurChessInfoMap()

	for posId, cell in pairs(self._chessMapByPosId) do
		self:_resetChessShow(cell.go, posId)

		local info = infoMap[posId]

		if info then
			local cg = cell.chess:GetComponent("CanvasGroup")

			cg.alpha = 1

			cell.iconChange:SetState(info.chessType - 1)
			goutil.setActive(cell.chess, true)
			goutil.setActive(cell.btnCircle, false)
			goutil.setActive(cell.go, true)
		else
			goutil.setActive(cell.go, false)
			goutil.setActive(cell.posEffect, false)
		end
	end
end

function DoushouqitigergameView:_onSelectChess()
	local curSelectId = DoushouqiTigerGameController.instance:getCurSelectPosId()
	local infoMap = DoushouqiTigerGameController.instance:getCurChessInfoMap()

	for posId, cell in pairs(self._chessMapByPosId) do
		local info = infoMap[posId]

		Framework.TransformUtil.SetLocalScale(cell.btnCircle.transform, 1, 1, 1)

		if info then
			if posId == curSelectId then
				goutil.setActive(cell.posEffect, true)
			else
				goutil.setActive(cell.posEffect, false)
			end
		else
			goutil.setActive(cell.posEffect, false)

			if curSelectId ~= -1 and DoushouqiTigerGameController.instance:checkConnectedBetweenPos(curSelectId, posId) then
				local cg = cell.chess:GetComponent("CanvasGroup")

				cg.alpha = 1

				goutil.setActive(cell.btnCircle, true)
				goutil.setActive(cell.chess, false)
				goutil.setActive(cell.go, true)
			else
				goutil.setActive(cell.go, false)
				goutil.setActive(cell.btnCircle, false)
			end
		end
	end
end

function DoushouqitigergameView:_doMoveChess()
	if self._tweenMove then
		self._tweenMove:Kill(false)

		self._tweenMove = nil
	end

	if self._tweenAlpha then
		self._tweenAlpha:Kill(false)

		self._tweenAlpha = nil
	end

	local moveAction = DoushouqiTigerGameController.instance:getLastMove()

	self:_doMoveChessAni(moveAction.originPointId, moveAction.targetPointId)
end

function DoushouqitigergameView:_doMoveChessAni(orPosId, tarPosId)
	local cell = self._chessMapByPosId[orPosId]
	local orParam = self._showParamMapByPosId[orPosId]
	local tarParm = self._showParamMapByPosId[tarPosId]

	if cell and orParam and tarParm then
		local moveGo = cell.go

		if self._tweenMove then
			self._tweenMove:Kill(false)

			self._tweenMove = nil
		end

		local tweenSize = tarParm.chessSize - orParam.chessSize
		local tweenX = tarParm.posX - orParam.posX
		local tweenY = tarParm.posY - orParam.posY

		self._tweenMove = TweenUtil.ValueTo(0, 1, 1, function(val)
			Framework.TransformUtil.SetLocalScale(moveGo.transform, orParam.chessSize + tweenSize * val, orParam.chessSize + tweenSize * val, 1)
			Framework.TransformUtil.SetAnchoredPos(moveGo.transform, orParam.posX + tweenX * val, orParam.posY + tweenY * val)
		end, function()
			self._tweenMove = nil

			DoushouqiTigerGameController.instance:finishMove()
		end, self, DG.Tweening.Ease.Linear)
	end
end

function DoushouqitigergameView:_onFinishMove()
	if self._tweenMove then
		self._tweenMove:Kill(false)

		self._tweenMove = nil
	end

	if self._tweenAlpha then
		self._tweenAlpha:Kill(false)

		self._tweenAlpha = nil
	end

	local eatChessList = {}
	local moveAction = DoushouqiTigerGameController.instance:getLastMove()
	local infoMap = DoushouqiTigerGameController.instance:getCurChessInfoMap()

	for posId, cell in pairs(self._chessMapByPosId) do
		self:_resetChessShow(cell.go, posId)

		local info = infoMap[posId]

		if info then
			cell.iconChange:SetState(info.chessType - 1)

			local cg = cell.chess:GetComponent("CanvasGroup")

			cg.alpha = 1

			goutil.setActive(cell.chess, true)
			goutil.setActive(cell.btnCircle, false)
			goutil.setActive(cell.go, true)
		elseif GameUtil.GetActive(cell.go) and moveAction.originPointId ~= posId then
			table.insert(eatChessList, cell)
		else
			goutil.setActive(cell.go, false)
		end
	end

	if #eatChessList > 0 then
		self._tweenAlpha = TweenUtil.ValueTo(1, 0, 1, function(val)
			for i, cell in ipairs(eatChessList) do
				local cg = cell.chess:GetComponent("CanvasGroup")

				cg.alpha = val
			end
		end, function()
			self._tweenAlpha = nil

			DoushouqiTigerGameController.instance:switchRound()
		end, self, DG.Tweening.Ease.Linear)
	else
		for i, cell in ipairs(eatChessList) do
			local cg = cell.chess:GetComponent("CanvasGroup")

			cg.alpha = 1

			goutil.setActive(cell.go, false)
		end

		DoushouqiTigerGameController.instance:switchRound()
	end
end

function DoushouqitigergameView:_onSwitchRound()
	if self._tweenMove then
		self._tweenMove:Kill(false)

		self._tweenMove = nil
	end

	if self._tweenAlpha then
		self._tweenAlpha:Kill(false)

		self._tweenAlpha = nil
	end

	if DoushouqiTigerGameController.instance:getCurRoundSide() == DoushouqiTigerGameController.Side.Red then
		FloatWordMgr.instance:show("红方回合")
	else
		FloatWordMgr.instance:show("蓝方回合")
	end

	self:_setMyOpFlag()

	local infoMap = DoushouqiTigerGameController.instance:getCurChessInfoMap()

	for posId, cell in pairs(self._chessMapByPosId) do
		Framework.TransformUtil.SetLocalScale(cell.btnCircle.transform, 1, 1, 1)

		local info = infoMap[posId]

		if info then
			cell.bottomChange:SetState(info.chessType == DoushouqiTigerGameController.instance:getMyRoundSide() and 1 or 0)
		end
	end

	for i, item in ipairs(self._playerItems) do
		if item.roundSide == DoushouqiTigerGameController.instance:getCurRoundSide() then
			item.txtState.text = "行动中..."

			self:_playActionEffect(item.goEffect, i)
		else
			item.txtState.text = "待 机"
		end

		if DoushouqiTigerGameController.instance:getIsLearnMode() then
			local players = DoushouqiTigerGameController.instance:getTutorialPlayInfos()

			for _, player in ipairs(players) do
				if player.side == item.roundSide then
					item.txtNum.text = player.leftStep

					break
				end
			end
		else
			local players = DoushouqiTigerGameController.instance:getPlayInfos()

			for _, player in ipairs(players) do
				if player.side == item.roundSide then
					item.txtNum.text = player.leftStep

					break
				end
			end
		end
	end

	local hadHangUp = false

	if not DoushouqiTigerGameController.instance:getIsLearnMode() then
		local players = DoushouqiTigerGameController.instance:getPlayInfos() or {}

		for _, player in ipairs(players) do
			if player.side == DoushouqiTigerGameController.instance:getCurRoundSide() then
				hadHangUp = player.hadHangUp

				break
			end
		end
	end

	self._targetTime = hadHangUp and ServerTime.now() + DoushouqiConfig.instance:getRoundSecAfterHangUp(self._activityId) or ServerTime.now() + DoushouqiConfig.instance:getRoundSec(self._activityId)

	self:_tickTime()
end

function DoushouqitigergameView:_tickTime()
	local leftTime = self._targetTime - ServerTime.now()

	if leftTime <= 0 then
		self._txtTime.text = "请等待"
	else
		self._txtTime.text = string.format("倒计时:<color=#FDEB96FF>%s</color>秒", leftTime)

		if leftTime <= 5 then
			self:_playTickTimeEffect()
		end
	end
end

function DoushouqitigergameView:_onNotifyBeastFightingChessOpRequestTieRes()
	local text = "对方请求求和，是否同意？"

	TipsFacade.instance:openPopupWindow("提示", text, function()
		BeastFightingChessAgent.instance:sendBeastFightingChessHandleTieReq(self._activityId, true)
	end, function()
		BeastFightingChessAgent.instance:sendBeastFightingChessHandleTieReq(self._activityId, false)
	end)
end

function DoushouqitigergameView:_onNotifyBeastFightingChessOpHandleTieRes()
	goutil.setActive(self._btnQiuhe.gameObject, true)
end

function DoushouqitigergameView:_hideObjInLearning()
	local isLearning = DoushouqiTigerGameController.instance:getIsLearnMode()

	goutil.setActive(self._btnQiuhe.gameObject, not isLearning)
	goutil.setActive(self._btnRenshu.gameObject, not isLearning)
	goutil.setActive(self._btnChat.gameObject, not isLearning)
	goutil.setActive(self._goTime, not isLearning)
	goutil.setActive(self._btnClose.gameObject, isLearning)
end

function DoushouqitigergameView:_playActionEffect(goEffect, index)
	if self._lastActionEffect then
		UIEffectManager.instance:stopEffect(self._lastActionEffect)

		self._lastActionEffect = nil
	end

	local effName = ""

	effName = DoushouqiTigerGameController.instance:getCurRoundSide() == DoushouqiTigerGameController.Side.Red and "20240927/aoqidoushouqi/fx_ui_aqdsq_paodengzuo.prefab" or "20240927/aoqidoushouqi/fx_ui_aqdsq_paodengblue.prefab"

	local scaleX = 1

	if DoushouqiTigerGameController.instance:getCurRoundSide() == DoushouqiTigerGameController.Side.Red and index == DoushouqiController.Dir.Right then
		scaleX = -1
	elseif DoushouqiTigerGameController.instance:getCurRoundSide() == DoushouqiTigerGameController.Side.Blue and index == DoushouqiController.Dir.Left then
		scaleX = -1
	end

	self._lastActionEffect = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._lastActionEffect:setParent(goEffect.transform)
	self._lastActionEffect:setScaleXYZ(scaleX, 1, 1)
	self._lastActionEffect:setLocalPos(0, 0, 0)
end

function DoushouqitigergameView:_playFixedEffect()
	local effName = "20240927/aoqidoushouqi/fx_ui_aqdsq_fw.prefab"

	self._fixedEffect = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._fixedEffect:setParent(self.mainGO.transform)
	self._fixedEffect:setScale(1)
	self._fixedEffect:setLocalPos(0, 0, 0)

	local selectEffName = "20240927/aoqidoushouqi/fx_ui_aqdsq_geziliang.prefab"

	for _, cell in pairs(self._chessMapByPosId) do
		cell.effect = UIEffectManager.instance:playEffect(self, selectEffName, nil, 0, 0, true)

		cell.effect:setParent(cell.posEffect.transform)
		cell.effect:setScale(1)
		cell.effect:setLocalPos(0, 0, 0)
	end
end

function DoushouqitigergameView:_clearAllEffects()
	if self._lastActionEffect then
		UIEffectManager.instance:stopEffect(self._lastActionEffect)

		self._lastActionEffect = nil
	end

	if self._fixedEffect then
		UIEffectManager.instance:stopEffect(self._fixedEffect)

		self._fixedEffect = nil
	end

	for _, cell in pairs(self._chessMapByPosId) do
		UIEffectManager.instance:stopEffect(cell.effect)

		cell.effect = nil
	end
end

function DoushouqitigergameView:_setMyOpFlag()
	local curRoundSied = DoushouqiTigerGameController.instance:getCurRoundSide()
	local mySide = DoushouqiTigerGameController.instance:getMyRoundSide()

	if curRoundSied == mySide then
		if not self._myOpFlag and not DoushouqiModel.instance:getIsRobot() then
			DoushouqiTigerGameController.instance:openTuoguan()
		end

		self._myOpFlag = false
	end
end

function DoushouqitigergameView:_onDoushouqiSetMyOperation()
	self._myOpFlag = true
end

function DoushouqitigergameView:_playTickTimeEffect()
	local path = "fx_ui_myzuoyuebing/fx_ui_zuoyuebing_shuaxin.prefab"

	self:playViewEffect(path, self._timeGo)
end

return DoushouqitigergameView
