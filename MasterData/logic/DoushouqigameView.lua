-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqigameView.lua

module("logic.extensions.doushouqi.view.DoushouqigameView", package.seeall)

local DoushouqigameView = class("DoushouqigameView", ViewComponent)
local topWidth = 530
local bottomWidth = 650
local height = 397

function DoushouqigameView:ctor()
	DoushouqigameView.super.ctor(self)
end

function DoushouqigameView:unbindEvents()
	DoushouqigameView.super.unbindEvents(self)
	self._btnQiuhe:RemoveClickListener()
	self._btnRenshu:RemoveClickListener()
	self._btnUse:RemoveClickListener()
	self._btnChat:RemoveClickListener()
	self._btnClose:RemoveClickListener()

	for i, v in ipairs(self._playerItems) do
		v.btnSkillIcon:RemoveClickListener()
	end
end

function DoushouqigameView:bindEvents()
	DoushouqigameView.super.bindEvents(self)
	self._btnQiuhe:AddClickListener(self._onClickbtnQiuhe, self)
	self._btnRenshu:AddClickListener(self._onClickbtnRenshu, self)
	self._btnUse:AddClickListener(self._onClickbtnUseSkill, self)
	self._btnChat:AddClickListener(self._onClickbtnChat, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)

	for i, v in ipairs(self._playerItems) do
		v.btnSkillIcon:AddClickListener(self._onClickSkillIcon, self)
	end
end

function DoushouqigameView:buildUI()
	DoushouqigameView.super.buildUI(self)

	self._btnQiuhe = self:getBtn("btnQiuhe")
	self._btnRenshu = self:getBtn("btnRenshu")
	self._txtTime = self:getTxt("time/txtTime")
	self._goTime = self:getGo("time")
	self._toprightGo = self:getGo("topright")
	self._topleftGo = self:getGo("topleft")
	self._goConKezhi = self:getGo("kezhi/con")
	self._goCellKezhi = self:getGo("kezhi/cell")
	self._conKezhiLayout = self:getGo("kezhi/con"):GetComponent(ComponentType.UILayoutSingleLine)
	self._playerItems = {}

	self:_buildHead(self._playerItems, self._topleftGo, 1)
	self:_buildHead(self._playerItems, self._toprightGo, 2)
	self:_buildKezhi()

	self._goSkillStateLeft = self:getGo("topleft/skillState")
	self._txtSkillStateRight = self:getTxt("topright/skillState/Text")
	self._btnUse = self:getBtn("topleft/skill/btnUse")
	self._txtSkillDescRight = self:getTxt("skilluseRight/txtDesc")
	self._txtSkillDescLeft = self:getTxt("skilluseLeft/txtDesc")
	self._skilluseRightGo = self:getGo("skilluseRight")
	self._skilluseLeftGo = self:getGo("skilluseLeft")
	self._btnChat = self:getBtn("btnChat")

	local lbubbleGo = self:getGo("topleft/bubble")
	local rbubbleGo = self:getGo("topright/bubble")

	self._bubbleItems = {}

	self:_buildBubble(self._bubbleItems, lbubbleGo, DoushouqiController.Dir.Left)
	self:_buildBubble(self._bubbleItems, rbubbleGo, DoushouqiController.Dir.Right)

	self._btnClose = self:getBtn("btnClose")
	self._timeGo = self:getGo("time")
end

function DoushouqigameView:_buildBubble(list, root, dir)
	list[dir] = {
		go = root,
		goIcon = goutil.findChild(root, "icon")
	}
end

function DoushouqigameView:_buildKezhi()
	local t = {
		8,
		7,
		6,
		5,
		4,
		3,
		2,
		1,
		8
	}

	goutil.setActive(self._goCellKezhi, false)

	local cnt = #t

	for i, level in ipairs(t) do
		local go = goutil.cloneAndSetParent(self._goCellKezhi, self._goConKezhi.transform)
		local change = goutil.findChild(go, "bg/icon"):GetComponent(ComponentType.UIImageSpriteChange)
		local resName = DoushouqiConfig.instance:getDoushouqiResName(level)
		local goTag = goutil.findChild(go, "tag")
		local txtTag = goutil.findChildTextComponent(go, "tag/txtTag")
		local cfg = DoushouqiConfig.instance:getDoushouqiResCfg(level)
		local isDescEmpty = string.nilorempty(cfg.tagDesc)

		goutil.setActive(goTag, not isDescEmpty)

		if not isDescEmpty then
			txtTag.text = cfg.tagDesc
		end

		change:ChangeSprite(resName)

		if i == cnt then
			local goFuhao = goutil.findChild(go, "fuhao")

			goutil.setActive(goFuhao, false)
		end

		goutil.setActive(go, true)
	end

	self._conKezhiLayout:Layout()
end

function DoushouqigameView:_buildHead(list, root, index)
	local var_7_0 = {
		goHead = goutil.findChild(root, "head"),
		goState = goutil.findChild(root, "state"),
		txtNum = goutil.findChildTextComponent(root, "txtNum"),
		goSkillIcon = goutil.findChild(root, "skill/skillIcon"),
		txtSkillName = goutil.findChildTextComponent(root, "skill/skillName"),
		txtState = goutil.findChildTextComponent(root, "state/txtState")
	}

	var_7_0.stateBgChange = goutil.findChild(root, "state/bg"):GetComponent(ComponentType.UIImageSpriteChange)
	var_7_0.goEffect = goutil.findChild(root, "effect")
	var_7_0.btnSkillIcon = Framework.ButtonAdapter.Get(goutil.findChild(root, "skill/skillIcon"))
	list[index] = var_7_0
end

function DoushouqigameView:_buildMap()
	self._cellconGo = self:getGo("cellcon")
	self._cellGo = self:getGo("cell")
	self._doushouqiCells = {}

	goutil.setActive(self._cellGo, false)

	local positions = self:_calculateGridPositions(DoushouqiGameController.Row, DoushouqiGameController.Col)

	for i, v in ipairs(positions) do
		local x, y = v.x, v.y
		local scale = v.scale
		local go = goutil.cloneAndSetParent(self._cellGo, self._cellconGo.transform, "cell" .. i)

		Framework.TransformUtil.SetLocalScale(go.transform, scale, scale, 1)
		Framework.TransformUtil.SetAnchoredPos(go.transform, x, y)

		local pointId = DoushouqiGameController.instance:getPointId(v.row, v.col)
		local mo = DoushouqiGameController.instance:getMo(pointId)
		local cell = DoushouqiCell.New(go, self, mo, self._activityId)

		cell:setPointId(pointId)
		cell:setPos(x, y)
		cell:setScale(scale)
		cell:updateUI()
		table.insert(self._doushouqiCells, cell)
		goutil.setActive(go, true)
	end
end

function DoushouqigameView:onExit()
	DoushouqigameView.super.onExit(self)
	GameUtil.clickEnabled(true, self)

	for i, v in ipairs(self._doushouqiCells) do
		v:destroy()
	end

	self._doushouqiCells = {}

	for i, v in ipairs(self._playerItems) do
		HeadItemController.instance:resetHeadCell(v.goHead)
		uGuiUtil.clearImage(v.goSkillIcon)
		self:_clearActionEffect(v.goEffect)
	end

	removetimer(self._tickTime, self)
	removetimer(self._hideSkillUse, self)
	removetimer(self._hideOtherBubble, self)
	removetimer(self._hideMyBubble, self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	if DoushouqiGameController.instance:isLearn() then
		local typeInfo = DoushouqiModel.instance:getTypeInfo(DoushouqiController.ChessType.Doushouqi)

		if not typeInfo.finishNewHand then
			BeastFightingChessAgent.instance:sendBeastFightingChessFinishNewHandReq(self._activityId, DoushouqiController.ChessType.Doushouqi)
		end
	end
end

function DoushouqigameView:onEnter()
	DoushouqigameView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.DoushouqiRefreshCell, self._onDoushouqiRefreshCell, self)
	self.addGEvent(self, GlobalNotify.DoushouqiStartMoveTo, self._onDoushouqiStartMoveTo, self)
	self.addGEvent(self, GlobalNotify.DoushouqiStartChangePos, self._onDoushouqiStartMoveChangePos, self)
	self.addGEvent(self, GlobalNotify.DoushouqiShowCanMoveCells, self._onDoushouqiShowCanMoveCells, self)
	self.addGEvent(self, GlobalNotify.NotifyBeastFightingChessOpRequestTieRes, self._onNotifyBeastFightingChessOpRequestTieRes, self)
	self.addGEvent(self, GlobalNotify.NotifyBeastFightingChessOpHandleTieRes, self._onNotifyBeastFightingChessOpHandleTieRes, self)
	self.addGEvent(self, GlobalNotify.DoushouqiRefreshMap, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.DoushouqiSetCurRoundUser, self._updatePlayerOp, self)
	self.addGEvent(self, GlobalNotify.BeastFightingChessReleaseSkillRes, self._updatePlayers, self)
	self.addGEvent(self, GlobalNotify.DoushouqiPlaySkillEffect, self._onDoushouqiPlaySkillEffect, self)
	self.addGEvent(self, GlobalNotify.DoushouqiPlaySkillAction, self._onDoushouqiPlaySkillAction, self)
	self.addGEvent(self, GlobalNotify.NotifyBeastFightingChessOpEmoticonRes, self._onNotifyBeastFightingChessOpEmoticonRes, self)
	self.addGEvent(self, GlobalNotify.DoushouqiPlayLocalEmoji, self._onDoushouqiPlayLocalEmoji, self)
	self.addGEvent(self, GlobalNotify.DoushouqiPlayShanguangEffect, self._onPlayShanguangEffect, self)
	self.addGEvent(self, GlobalNotify.DoushouqiPlayGedangEffect, self._onDoushouqiPlayGedangEffect, self)
	self.addGEvent(self, GlobalNotify.DoushouqiWaitforEndGame, self._onDoushouqiWaitforEndGame, self)
	self.addGEvent(self, GlobalNotify.DoushouqiRealEndGame, self._onDoushouqiRealEndGame, self)
	self.addGEvent(self, GlobalNotify.DoushouqiSetMyOperation, self._onDoushouqiSetMyOperation, self)
	self.addGEvent(self, GlobalNotify.DoushouqiSetCurRoundUser, self._setMyOpFlag, self)

	self._lastUserId = -1
	self._targetTime = 0
	self._nowTime = 0
	self._leftTime = 0
	self._myOpFlag = true
	self._isLearning = DoushouqiGameController.instance:isLearn()

	self:_buildMap()
	self:_updateUI()
	self:_tryTickTime()
	self:_hideSkillUse()
	self:_hideMyBubble()
	self:_hideOtherBubble()
	self:_hideObjInLearning()
	self:_playEffect()
end

function DoushouqigameView:_updateUI()
	GameUtil.clickEnabled(true, self)
	self:_getMapInfo()
	self:_updatePlayers()
	self:_updateMapCells()
	self:_updateTimer()
end

function DoushouqigameView:_onClickbtnQiuhe()
	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiSetMyOperation)

	local text = "确定求和？"

	TipsFacade.instance:openPopupWindow("提示", text, function()
		if DoushouqiGameController.instance:isGameEnding() then
			FloatWordMgr.instance:show("游戏已结束")

			return
		end

		goutil.setActive(self._btnQiuhe.gameObject, false)
		BeastFightingChessAgent.instance:sendBeastFightingChessRequestTieReq(self._activityId)
	end)
end

function DoushouqigameView:_onClickbtnRenshu()
	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiSetMyOperation)

	local text = "确定认输？"

	TipsFacade.instance:openPopupWindow("提示", text, function()
		if DoushouqiGameController.instance:isGameEnding() then
			FloatWordMgr.instance:show("游戏已结束")

			return
		end

		BeastFightingChessAgent.instance:sendBeastFightingChessLeaveRoomReq(self._activityId)
	end)
end

function DoushouqigameView:_onClickbtnUseSkill()
	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiSetMyOperation)

	if not DoushouqiGameController.instance:isMyRound() then
		FloatWordMgr.instance:show("不是你的回合")

		return
	end

	local skillId = DoushouqiModel.instance:getMySkillId()

	if not DoushouqiGameController.instance:checkSelectChessEnough(skillId) then
		FloatWordMgr.instance:show("不满足技能释放条件")

		return
	end

	if DoushouqiGameController.instance:checkSkillNeedSelectChess(skillId) then
		DoushouqiGameController.instance:beforeUseSkill(skillId)
		FloatWordMgr.instance:show("请选择棋子释放技能")
	else
		local actionId = DoushouqiModel.instance:getCurActionId()

		DoushouqiGameController.instance:sendBeastFightingChessReleaseSkillReq(self._activityId, skillId, 0, "", actionId)
	end
end

function DoushouqigameView:_onClickbtnChat()
	local x, y = Framework.TransformUtil.GetPos(self._btnChat.transform, 0, 0, 0)

	x = x + 1
	y = y + 0.5

	UIStateManager.instance:open(ViewName.DoushouqiemojiView, x, y, self._activityId)
end

function DoushouqigameView:_onClickbtnClose()
	self:close()
end

function DoushouqigameView:_calculateRowWidth(row, totalRows)
	local widthDifference = bottomWidth - topWidth

	return topWidth + widthDifference * ((row - 1) / (totalRows - 1))
end

function DoushouqigameView:_calculateScale(row, totalRows)
	local startScale = 0.8
	local endScale = 1

	if row == 1 then
		return startScale
	elseif row == totalRows then
		return endScale
	else
		local scaleDifference = endScale - startScale

		return startScale + scaleDifference * ((row - 1) / (totalRows - 1))
	end
end

function DoushouqigameView:_calculateGridPositions(rows, cols)
	local positions = {}
	local gridHeight = height / (rows - 1)
	local gridWidth = self:_calculateRowWidth(1, rows) / (cols - 1)
	local gridSize = math.min(gridHeight, gridWidth)
	local startX = 0
	local startY = 0

	for row = 1, rows do
		local rowWidth = self:_calculateRowWidth(row, rows)
		local scale = self:_calculateScale(row, rows)
		local rowHeight = height / (rows - 1)

		for col = 1, cols do
			local xOffset = (col - 1 - (cols - 1) / 2) * (rowWidth / (cols - 1))
			local yOffset = (row - 1) * rowHeight
			local x = startX + xOffset
			local y = startY - yOffset

			if row ~= 1 and row ~= rows then
				y = y + 25
			end

			table.insert(positions, {
				x = x,
				y = y,
				row = row,
				col = col,
				scale = scale
			})
		end
	end

	return positions
end

function DoushouqigameView:_onDoushouqiRefreshCell(mo1, mo2)
	for i, cell in ipairs(self._doushouqiCells) do
		if cell:getPointId() == mo1:getPointId() or cell:getPointId() == mo2:getPointId() then
			cell:updateUI()
		end
	end
end

function DoushouqigameView:_onDoushouqiShowCanMoveCells(pointIds)
	local pointIds_kv = {}

	for i, v in ipairs(pointIds) do
		pointIds_kv[v] = v
	end

	for i, cell in ipairs(self._doushouqiCells) do
		if pointIds_kv[cell:getPointId()] then
			cell:lightBottom()
		else
			cell:unlightBottom()
		end
	end
end

function DoushouqigameView:_onDoushouqiStartMoveTo(srcPointId, destPointId)
	local srcCell, destCell, get

	for i, cell in ipairs(self._doushouqiCells) do
		cell:unlightBottom()

		if not srcCell and cell:getPointId() == srcPointId then
			srcCell = cell
		end

		if not destCell and cell:getPointId() == destPointId then
			destCell = cell
		end
	end

	if srcCell and destCell then
		destCell:setAsLastSibling()
		srcCell:setAsLastSibling()

		local x, y = destCell:getPos()
		local scale = destCell:getScale()
		local destMo = destCell:getMo()

		srcCell:moveTo(x, y, scale, destMo and destMo:isEmpty())
	else
		DoushouqiGameController.instance:moveFinish()
	end
end

function DoushouqigameView:_onDoushouqiStartMoveChangePos(srcPointId, destPointId)
	local srcCell, destCell, get

	for i, cell in ipairs(self._doushouqiCells) do
		cell:unlightBottom()

		if not srcCell and cell:getPointId() == srcPointId then
			srcCell = cell
		end

		if not destCell and cell:getPointId() == destPointId then
			destCell = cell
		end
	end

	if srcCell and destCell then
		local finishCount = 0

		local function moveEnd()
			finishCount = finishCount + 1

			if finishCount == 2 then
				GameUtil.clickEnabled(false, self)
				destCell:playHuhuanEffect()
				srcCell:playHuhuanEffect(function()
					GameUtil.clickEnabled(true, self)
					DoushouqiGameController.instance:changePosFinish()
				end)
			end
		end

		local dx, dy = destCell:getPos()
		local dscale = destCell:getScale()
		local sx, sy = srcCell:getPos()
		local sscale = srcCell:getScale()

		srcCell:moveToWithCallBack(dx, dy, dscale, moveEnd)
		destCell:moveToWithCallBack(sx, sy, sscale, moveEnd)
	else
		DoushouqiGameController.instance:changePosFinish()
	end
end

function DoushouqigameView:_getMapInfo()
	self._mapInfo = DoushouqiModel.instance:getMapInfo()
end

function DoushouqigameView:_updatePlayers()
	local myUserId = checknumber(RoleModel.instance:getUserId())
	local playerInfos = {}

	for i, v in ipairs(self._mapInfo.players) do
		if checknumber(v.userId) == myUserId then
			table.insert(playerInfos, DoushouqiController.Dir.Left, v)
		else
			table.insert(playerInfos, v)
		end
	end

	for i, v in ipairs(playerInfos) do
		local userId = checknumber(v.userId)
		local item = self._playerItems[i]
		local skillId = 0

		if i == DoushouqiController.Dir.Left then
			HeadItemController.instance:setMyHeadCell(item.goHead)

			skillId = DoushouqiModel.instance:getMySkillId()

			goutil.setActive(self._goSkillStateLeft, v.usedSkill)
			goutil.setActive(self._btnUse.gameObject, not v.usedSkill)
		elseif DoushouqiGameController.instance:isRobot() then
			skillId = DoushouqiModel.instance:getOpSkillId()

			HeadItemController.instance:setHeadCell(item.goHead, 1, 1, 0)
		else
			skillId = DoushouqiModel.instance:getOpSkillId()

			local headInfo = DoushouqiModel.instance:getOpHeadInfo()

			HeadItemController.instance:setHeadCellByInfo(item.goHead, headInfo)
		end

		if i ~= DoushouqiController.Dir.Left then
			self._txtSkillStateRight.text = v.usedSkill and "已使用" or "未使用"
		end

		local skillCfg = DoushouqiConfig.instance:getSkillCfg(self._activityId, skillId)
		local spriteName = string.format("%s.png", skillCfg.iconPath)
		local inRound = userId == DoushouqiGameController.instance:getCurRoundUserId()

		item.txtState.text = inRound and "行动中..." or "待机中"
		item.txtNum.text = v.leftStep
		item.txtSkillName.text = skillCfg.name

		item.stateBgChange:SetState(inRound and 1 or 0)
		uGuiUtil.setSpriteToImage(item.goSkillIcon, uGuiUtil.SpriteType.BigBg, spriteName)
		self:_clearActionEffect(item.goEffect)

		if inRound then
			self:_playActionEffect(item.goEffect, i)
		end
	end
end

function DoushouqigameView:_onNotifyBeastFightingChessOpRequestTieRes()
	local text = "对方请求求和，是否同意？"

	TipsFacade.instance:openPopupWindow("提示", text, function()
		BeastFightingChessAgent.instance:sendBeastFightingChessHandleTieReq(self._activityId, true)
	end, function()
		BeastFightingChessAgent.instance:sendBeastFightingChessHandleTieReq(self._activityId, false)
	end)
end

function DoushouqigameView:_onNotifyBeastFightingChessOpHandleTieRes()
	return
end

function DoushouqigameView:_updateMapCells()
	local list = {}

	table.insertto(list, self._doushouqiCells)
	table.sort(list, function(a, b)
		return a:getPointId() < b:getPointId()
	end)

	for i, cell in ipairs(list) do
		cell:setAsLastSibling()
		cell:updateUI()
	end
end

function DoushouqigameView:_updatePlayerOp()
	self:_updateTimer()
	self:_updatePlayers()
end

function DoushouqigameView:_updateTimer()
	local actionId = DoushouqiModel.instance:getCurActionId()

	self._targetTime = DoushouqiGameController.instance:getActionEndTime(actionId)

	self:_tickTime()
end

function DoushouqigameView:_tickTime()
	self._nowTime = ServerTime.now()

	self:_stopTickTimeEffect()

	if self._nowTime >= self._targetTime then
		self._txtTime.text = "请等待"
	else
		self._leftTime = self._targetTime - self._nowTime
		self._txtTime.text = string.format("倒计时:<color=#FDEB96FF>%s</color>秒", self._leftTime)

		if self._leftTime <= 5 then
			self:_playTickTimeEffect()
		end
	end
end

function DoushouqigameView:_onDoushouqiPlaySkillEffect(skillEffect, userId)
	removetimer(self._hideSkillUse, self)
	settimer(2, self._hideSkillUse, self, false)

	local isMe = checknumber(userId) ~= checknumber(RoleModel.instance:getUserId())
	local skillId = skillEffect.skillId

	self:_playSkillUseDesc(isMe, skillId)
end

function DoushouqigameView:_onDoushouqiPlaySkillAction(skillAction, userId)
	removetimer(self._hideSkillUse, self)
	settimer(2, self._hideSkillUse, self, false)

	local isMe = checknumber(userId) == checknumber(RoleModel.instance:getUserId())
	local skillId = skillAction.skillId

	self:_playSkillUseDesc(isMe, skillId)
end

function DoushouqigameView:_playSkillUseDesc(isMe, skillId)
	local skillCfg = DoushouqiConfig.instance:getSkillCfg(self._activityId, skillId)

	goutil.setActive(self._skilluseRightGo, not isMe)
	goutil.setActive(self._skilluseLeftGo, isMe)

	if isMe then
		self._txtSkillDescLeft.text = string.format("技能【%s】已发动！", skillCfg.name)
	else
		self._txtSkillDescRight.text = string.format("技能【%s】已发动！", skillCfg.name)
	end
end

function DoushouqigameView:_hideSkillUse()
	goutil.setActive(self._skilluseRightGo, false)
	goutil.setActive(self._skilluseLeftGo, false)
end

function DoushouqigameView:_onNotifyBeastFightingChessOpEmoticonRes(id)
	self:_showOtherBubble(id)
end

function DoushouqigameView:_onDoushouqiPlayLocalEmoji(id)
	self:_showMyBubble(id)
end

function DoushouqigameView:_showOtherBubble(id)
	removetimer(self._hideOtherBubble, self)
	self:_ativeBubble(DoushouqiController.Dir.Right, id)
	settimer(2, self._hideOtherBubble, self, false)
end

function DoushouqigameView:_hideOtherBubble()
	local item = self._bubbleItems[DoushouqiController.Dir.Right]

	goutil.setActive(item.go, false)
end

function DoushouqigameView:_showMyBubble(id)
	removetimer(self._hideMyBubble, self)
	self:_ativeBubble(DoushouqiController.Dir.Left, id)
	settimer(2, self._hideMyBubble, self, false)
end

function DoushouqigameView:_hideMyBubble()
	local item = self._bubbleItems[DoushouqiController.Dir.Left]

	goutil.setActive(item.go, false)
end

function DoushouqigameView:_ativeBubble(dir, id)
	local item = self._bubbleItems[dir]
	local data = ChatConfig.instance:getEmojiCfg(id)
	local groupCfg = ChatConfig.instance:getEmojiGroupCfg(data.groupId)
	local path = string.format("ui/emoji/%s/%s.png", groupCfg.groupPrefix, data.icon)

	uGuiUtil.setSpriteToImage(item.goIcon, uGuiUtil.SpriteType.BigBg, path)
	goutil.setActive(item.go, true)
end

function DoushouqigameView:_tryTickTime()
	if self._isLearning then
		return
	end

	settimer(1, self._tickTime, self, true)
	self:_tickTime()
end

function DoushouqigameView:_hideObjInLearning()
	goutil.setActive(self._btnQiuhe.gameObject, not self._isLearning)
	goutil.setActive(self._btnRenshu.gameObject, not self._isLearning)
	goutil.setActive(self._goTime, not self._isLearning)
	goutil.setActive(self._btnClose.gameObject, self._isLearning)
end

function DoushouqigameView:_playEffect()
	local effName = "20240927/aoqidoushouqi/fx_ui_aqdsq_fw.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

function DoushouqigameView:_onPlayShanguangEffect(pointId)
	for i, cell in ipairs(self._doushouqiCells) do
		if cell:getPointId() == pointId then
			cell:playShanguangEffect()

			break
		end
	end
end

function DoushouqigameView:_onDoushouqiPlayGedangEffect(pointId)
	for i, cell in ipairs(self._doushouqiCells) do
		if cell:getPointId() == pointId then
			GameUtil.clickEnabled(false, self)
			cell:playGedangEffect(function()
				GameUtil.clickEnabled(true, self)
			end)

			break
		end
	end
end

function DoushouqigameView:_clearActionEffect(goEffect)
	if self._actionEffects and self._actionEffects[goEffect] then
		UIEffectManager.instance:stopEffect(self._actionEffects[goEffect])

		self._actionEffects[goEffect] = nil
	end
end

function DoushouqigameView:_playActionEffect(goEffect, index)
	self._actionEffects = self._actionEffects or {}

	local effName = ""

	effName = index == DoushouqiController.Dir.Left and "20240927/aoqidoushouqi/fx_ui_aqdsq_paodengzuo.prefab" or "20240927/aoqidoushouqi/fx_ui_aqdsq_paodengblue.prefab"

	local handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	handler:setParent(goEffect.transform)
	handler:setScale(1)
	handler:setLocalPos(0, 0, 0)

	self._actionEffects[goEffect] = handler
end

function DoushouqigameView:_onDoushouqiWaitforEndGame()
	GameUtil.clickEnabled(false, self)
end

function DoushouqigameView:_onDoushouqiRealEndGame()
	GameUtil.clickEnabled(true, self)
end

function DoushouqigameView:_onClickSkillIcon()
	UIStateManager.instance:push(ViewName.DoushouqiselectskillView, self._activityId, true)
end

function DoushouqigameView:_setMyOpFlag()
	local curRoundUserId = DoushouqiGameController.instance:getCurRoundUserId()
	local myUserId = checknumber(RoleModel.instance:getUserId())

	if curRoundUserId == myUserId then
		if not self._myOpFlag and not DoushouqiModel.instance:getIsRobot() then
			DoushouqiGameController.instance:openTuoguan()
		end

		self._myOpFlag = false
	end
end

function DoushouqigameView:_onDoushouqiSetMyOperation()
	self._myOpFlag = true
end

function DoushouqigameView:_playTickTimeEffect()
	local path = "fx_ui_myzuoyuebing/fx_ui_zuoyuebing_shuaxin.prefab"

	self:playViewEffect(path, self._timeGo)
end

function DoushouqigameView:_stopTickTimeEffect()
	return
end

return DoushouqigameView
