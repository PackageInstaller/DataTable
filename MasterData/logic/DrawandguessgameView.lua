-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessgameView.lua

module("logic.extensions.drawandguess.view.DrawandguessgameView", package.seeall)

local DrawandguessgameView = class("DrawandguessgameView", ViewComponent)

DrawandguessgameView.DrawTypeValueSplitNum = 10000
DrawandguessgameView.CleanCanvasNum = -1

function DrawandguessgameView:ctor()
	DrawandguessgameView.super.ctor(self)

	self._canvasColor = Color.New(0, 0, 0, 0)
	self._perReqDataCount = 300
	self._perTimeDrawPixelCount = 1200
end

function DrawandguessgameView:unbindEvents()
	DrawandguessgameView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSend:RemoveClickListener()
	self._btnChat:RemoveClickListener()
	self._btnEmoji:RemoveClickListener()
	self._customInputEmoji:RemoveListener()
	self._customInputChat:RemoveListener()
	self._btnClean:RemoveClickListener()
	self._btnJubao:RemoveClickListener()
end

function DrawandguessgameView:bindEvents()
	DrawandguessgameView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSend:AddClickListener(self._onClickbtnSend, self)
	self._btnChat:AddClickListener(self._onClickbtnChat, self)
	self._btnEmoji:AddClickListener(self._onClickbtnEmoji, self)
	self._customInputChat:AddListener(self._onCustomInputCallback, self)
	self._customInputEmoji:AddListener(self._onCustomInputCallback, self)
	self._btnClean:AddClickListener(self._onClickbtnClean, self)
	self._btnJubao:AddClickListener(self._onClickbtnJubao, self)
end

function DrawandguessgameView:buildUI()
	DrawandguessgameView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._imgScatch = self:getGo("canvas")
	self._rawImgScatch = self._imgScatch:GetComponent(ComponentType.RawImage)
	self._scratch = DrawingComponent.New()

	self._scratch:regDragHandler(GameUtil.handler(self._onScratchPointDown, self), nil, GameUtil.handler(self._onScratchPointUp, self))

	self._tableviewcolorGo = self:getGo("right/tableviewcolor")
	self._tablecellsizeGo = self:getGo("right/tablecellsize")
	self._tableviewsizeGo = self:getGo("right/tableviewsize")
	self._tablecellcolorGo = self:getGo("right/tablecellcolor")
	self._tablecelleraserGo = self:getGo("right/tablecelleraser")
	self._tablevieweraserGo = self:getGo("right/tablevieweraser")
	self._tableviewGoEmoji = self:getGo("chatcon/emoji/tableview")
	self._tablecellGoEmoji = self:getGo("chatcon/emoji/tablecell")
	self._tableviewGoChat = self:getGo("chatcon/chat/tableview")
	self._tablecellGoChat = self:getGo("chatcon/chat/tablecell")
	self._scrollerListColor = ScrollerList.create(self._tableviewcolorGo, self._tablecellcolorGo, GameUtil.handler(self._updateColorCell, self), GameUtil.handler(self._clearColorCell, self))
	self._scrollerListSize = ScrollerList.create(self._tableviewsizeGo, self._tablecellsizeGo, GameUtil.handler(self._updateSizeCell, self), GameUtil.handler(self._clearSizeCell, self))
	self._scrollerListEraser = ScrollerList.create(self._tablevieweraserGo, self._tablecelleraserGo, GameUtil.handler(self._updateEraserCell, self), GameUtil.handler(self._clearEraserCell, self))
	self._scrollerListEmoji = ScrollerList.create(self._tableviewGoEmoji, self._tablecellGoEmoji, GameUtil.handler(self._updateEmojiCell, self), GameUtil.handler(self._clearEmojiCell, self))
	self._scrollerListChat = ScrollerList.create(self._tableviewGoChat, self._tablecellGoChat, GameUtil.handler(self._updateChatCell, self), GameUtil.handler(self._clearChatCell, self))
	self._inputCompInputField = self:getInput("chatcon/inputField")
	self._btnSend = self:getBtn("chatcon/btnSend")
	self._btnChat = self:getBtn("chatcon/btnChat")
	self._btnEmoji = self:getBtn("chatcon/btnEmoji")
	self._txtDrawDesc = self:getTxt("txtDrawDesc")
	self._chatconGo = self:getGo("chatcon")

	self:_buildHeads()

	self._emojPanleGo = self:getGo("chatcon/emoji")
	self._chatPanleGo = self:getGo("chatcon/chat")
	self._customInputEmoji = UICustomInput.Get(self._emojPanleGo)
	self._customInputChat = UICustomInput.Get(self._chatPanleGo)
	self._txtQuestionTip = self:getTxt("txtQuestionTip")
	self._btnClean = self:getBtn("btnClean")
	self._txtJubaoUserId = self:getTxt("txtJubaoUserId")
	self._btnJubao = self:getBtn("btnJubao")
end

function DrawandguessgameView:_buildHeads()
	local playercon = self:getGo("playercon")
	local playercell = self:getGo("playercell")

	self._playerconLayout = playercon:GetComponent(ComponentType.UILayoutSingleLine)
	self._itemGroup = ItemGroup.New(playercon, playercell, nil, nil, true, self._clearGroupItem, self)

	goutil.setActive(playercell, false)
end

function DrawandguessgameView:onExit()
	DrawandguessgameView.super.onExit(self)
	removetimer(self._tickTimeSendDrawReq, self)
	removetimer(self._tickTimeToAutoDraw, self)
	removetimer(self._tickDrawTimeDesc, self)
	removetimer(self._tickTimeRefreshAnswershow, self)
	self._scratch:dispose()
	self._scrollerListColor:dispose()
	self._scrollerListSize:dispose()
	self._scrollerListEraser:dispose()
	self._itemGroup:dispose()
	self._scrollerListEmoji:dispose()
	self._scrollerListChat:dispose()
end

function DrawandguessgameView:onEnter()
	DrawandguessgameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DrawAndGuessLeaveGameRes, self._onDrawAndGuessLeaveGameRes, self)
	self.addGEvent(self, GlobalNotify.NotifyDrawAndGuessDrawStartRes, self._onNotifyDrawAndGuessDrawStartRes, self)
	self.addGEvent(self, GlobalNotify.NotifyDrawAndGuessSyncDrawRes, self._onNotifyDrawAndGuessSyncDrawRes, self)
	self.addGEvent(self, GlobalNotify.NotifyDrawAndGuessSelectQuestionStartRes, self._onNotifyDrawAndGuessSelectQuestionStartRes, self)
	self.addGEvent(self, GlobalNotify.NotifyDrawAndGuessGameEndRes, self.close, self)
	self.addGEvent(self, GlobalNotify.NotifyDrawAndGuessAnswerResultRes, self._onNotifyDrawAndGuessAnswerResultRes, self)
	self.addGEvent(self, GlobalNotify.DrawAndGuessAnswerRight, self._onDrawAndGuessAnswerRight, self)
	self.addGEvent(self, GlobalNotify.NotifyDrawAndGuessChatRes, self._onNotifyDrawAndGuessChatRes, self)

	self._activityId = self:getFirstParam()

	self:_initBrush()
	self:_udpateStaticUI()
	self:_startGame()
end

function DrawandguessgameView:_initBrush()
	local colorStrList = DrawandguessConfig.instance:getBrushColorStrList()
	local sizeCfgs = DrawandguessConfig.instance:getBrushSizeCfgs()

	self._scratch:setCanvasColor(self._canvasColor)
	self._scratch:setBrushSize(sizeCfgs[1].size)
	self._scratch:setBrushColorStrList(colorStrList)
	self._scratch:setBrushColor(1)
end

function DrawandguessgameView:_udpateUI()
	local qId = DrawandguessModel.instance:getCurQuestionId()
	local isMeDraw = DrawandguessModel.instance:isMeDraw()
	local canDraw = qId > 0 and isMeDraw

	if self._needRefreshImg == true then
		self:_cleanCanvas()

		self._needRefreshImg = false
	end

	self:_updatePlayers()
	goutil.setActive(self._chatconGo, qId > 0 and not isMeDraw)
	goutil.setActive(self._chatPanleGo, false)
	goutil.setActive(self._emojPanleGo, false)
	goutil.setActive(self._btnClean.gameObject, qId > 0 and isMeDraw)

	self._rawImgScatch.raycastTarget = canDraw
end

function DrawandguessgameView:_cleanCanvas()
	local width = GameUtil.getWidth(self._rawImgScatch)
	local height = GameUtil.getHeight(self._rawImgScatch)

	self._scratch:drawTexOnImg(self._rawImgScatch, width, height, self._canvasColor)
end

function DrawandguessgameView:_udpateStaticUI()
	local colorCfgs = DrawandguessConfig.instance:getBrushColorCfgs()

	self._scrollerListColor:reloadData(colorCfgs)

	local sizeCfgs = DrawandguessConfig.instance:getBrushSizeCfgs()

	self._scrollerListSize:reloadData(sizeCfgs)
	self._scrollerListEraser:reloadData(sizeCfgs)
	self:_updatePlayers()

	local len = DrawandguessConfig.instance:getCommonValue("ANSWER_LEN", true)

	self._inputCompInputField:SetCharacterLimit(len)
end

function DrawandguessgameView:_updatePlayers()
	local players = DrawandguessModel.instance:getPlayers()

	self._itemGroup:updateWithMoArray(players, function(item, data)
		self:_updatePlayerCell(item.mainGO, data)
	end)
	self._playerconLayout:Layout()
end

function DrawandguessgameView:_onClickbtnClose()
	TipsFacade.instance:openPopupWindow("提示", "现在退出，将按照当前已获得积分进行当局最终排名", function()
		UIStateManager.instance:popByName(ViewName.DrawandguesscurteamView)

		if FormTeamModel.instance:getCurTeamInfo() then
			FormTeamController.instance:leaveCurTeam()
		end

		DrawAndGuessAgent.instance:sendPM_DrawAndGuessLeaveGameReq(self._activityId)
	end)
end

function DrawandguessgameView:_onClickbtnSend()
	if DrawandguessModel.instance:getCurQuestionId() <= 0 then
		return
	end

	local text = self._inputCompInputField:GetText()

	if string.nilorempty(text) then
		FloatWordMgr.instance:show("请输入答案")

		return
	end

	self._inputCompInputField:SetText("")
	DrawAndGuessAgent.instance:sendPM_DrawAndGuessAnswerReq(self._activityId, text)
end

function DrawandguessgameView:_onClickbtnChat()
	goutil.setActive(self._chatPanleGo, true)

	local cfgs = DrawandguessConfig.instance:getTalkCfgs(self._activityId)

	self._scrollerListChat:reloadData(cfgs)
end

function DrawandguessgameView:_onClickbtnEmoji()
	goutil.setActive(self._emojPanleGo, true)

	local cfgs = DrawandguessConfig.instance:getEmojiCfgs(self._activityId)

	self._scrollerListEmoji:reloadData(cfgs)
end

function DrawandguessgameView:_onClickbtnClean()
	self:_cleanCanvas()

	local drawData = {
		-1
	}

	table.insert(self._drawDataList, drawData)
end

function DrawandguessgameView:_onClickbtnJubao()
	FloatWordMgr.instance:show("请手动截图需要举报的画面，并联系客服提供证据")
end

function DrawandguessgameView:_onDrawAndGuessLeaveGameRes()
	self:close()
end

function DrawandguessgameView:_onNotifyDrawAndGuessDrawStartRes()
	self:_startGame()
end

function DrawandguessgameView:_onNotifyDrawAndGuessAnswerResultRes()
	self:_checkAnswerShow()
end

function DrawandguessgameView:_checkAnswerShow()
	local players = DrawandguessModel.instance:getPlayers()
	local nowTime = ServerTime.now()
	local nextRefreshTime = nowTime + 99

	for i, v in ipairs(players) do
		local d = DrawandguessModel.instance:getAnswerShowData(v.userId)

		if d and nowTime < d.endTime and nextRefreshTime > d.endTime then
			nextRefreshTime = d.endTime
		end
	end

	local time = nextRefreshTime - nowTime

	if time > 0 then
		self:_updatePlayers()
		settimer(time, self._tickTimeRefreshAnswershow, self, false)
	end
end

function DrawandguessgameView:_tickTimeRefreshAnswershow()
	removetimer(self._tickTimeRefreshAnswershow, self)
	self:_updatePlayers()
	self:_checkAnswerShow()
end

function DrawandguessgameView:_onDrawAndGuessAnswerRight(userId)
	local name = DrawandguessModel.instance:getPlayerName(userId)
	local decSec = DrawandguessConfig.instance:getCommonValue("RIGHT_DEC_SEC", true)
	local content = string.format("%s 答对了，时间-%s秒", name, decSec)

	FloatWordMgr.instance:show(content)
end

function DrawandguessgameView:_onNotifyDrawAndGuessSelectQuestionStartRes()
	local msg = DrawandguessModel.instance:getSelectQuestionStartMsg()

	if msg and DrawandguessModel.instance:isMeDraw() then
		UIStateManager.instance:push(ViewName.DrawandguessselectView, self._activityId)
	end

	self:_startGame()
end

function DrawandguessgameView:_onNotifyDrawAndGuessSyncDrawRes(msg)
	if DrawandguessModel.instance:isMeDraw() then
		return
	end

	local brush = msg.brush
	local nodes = brush.nodes

	if nodes and #nodes > 0 then
		self:_addAutoDrawNodes(nodes)
		self:_checkCanAutoDraw()
	end
end

function DrawandguessgameView:_onNotifyDrawAndGuessChatRes()
	self:_checkAnswerShow()
end

function DrawandguessgameView:_onScratchPointDown()
	return
end

function DrawandguessgameView:_addAutoDrawNodes(nodes)
	local autoDrawData

	for i, value in ipairs(nodes) do
		local number = checknumber(value)

		if number == DrawandguessgameView.CleanCanvasNum then
			local temp_autoDrawData = {
				cleanCanvas = true
			}

			table.insert(self._autoDrawDataList, temp_autoDrawData)
		elseif number < DrawandguessgameView.DrawTypeValueSplitNum then
			if autoDrawData then
				table.insert(self._autoDrawDataList, autoDrawData)

				autoDrawData = nil
			end

			local brushType, brushSize, brushColorIdx = self:_parseDrawTypeValue(value)

			autoDrawData = {
				brushType = brushType,
				brushSize = brushSize,
				brushColorIdx = brushColorIdx,
				list = {}
			}
		elseif autoDrawData then
			local x, y = self:_parsePosValue(value)

			table.insert(autoDrawData.list, {
				x = x,
				y = y
			})
		end
	end

	if autoDrawData then
		table.insert(self._autoDrawDataList, autoDrawData)
	end
end

function DrawandguessgameView:_checkCanAutoDraw()
	if self._isAutoDrawing then
		return
	end

	if #self._autoDrawDataList > 0 then
		self:_startAutoDraw()
	end
end

function DrawandguessgameView:_startAutoDraw()
	self._isAutoDrawing = true

	if #self._autoDrawDataList > 0 then
		local drawData = self._autoDrawDataList[1]

		table.remove(self._autoDrawDataList, 1)

		if drawData.cleanCanvas then
			self:_cleanCanvas()

			self._isAutoDrawing = false

			self:_checkCanAutoDraw()

			return
		end

		self._autoDrawRealDrawDataList = self._scratch:calFinalDrawList(drawData)
		self._tickTimeToAutoDrawIdx = 0

		settimer(0.06, self._tickTimeToAutoDraw, self, true)
	else
		removetimer(self._tickTimeToAutoDraw, self)

		self._isAutoDrawing = false

		self:_checkCanAutoDraw()
	end
end

function DrawandguessgameView:_tickTimeToAutoDraw()
	local cnt = #self._autoDrawRealDrawDataList

	if cnt > 0 and cnt > self._tickTimeToAutoDrawIdx then
		local startIdx = self._tickTimeToAutoDrawIdx + 1
		local endIdx = startIdx + self._perTimeDrawPixelCount

		self._tickTimeToAutoDrawIdx = self._tickTimeToAutoDrawIdx + self._perTimeDrawPixelCount

		self._scratch:realDrawPointsByStartEnd(self._autoDrawRealDrawDataList, startIdx, endIdx)
	else
		removetimer(self._tickTimeToAutoDraw, self)

		self._isAutoDrawing = false

		self:_checkCanAutoDraw()
	end
end

function DrawandguessgameView:_calDrawTypeValue(brushType, brushSize, brushColorIdx)
	return brushColorIdx + brushType * 10 + brushSize * 100
end

function DrawandguessgameView:_parseDrawTypeValue(value)
	value = checknumber(value)
	value = math.floor(value / 10)

	local brushType = value % 10

	value = math.floor(value / 10)

	local brushSize = value % 100

	value = math.floor(value / 100)

	return brushType, brushSize, (brushType == DrawingComponent.BrushType.Clear or nil) and 0
end

function DrawandguessgameView:_calPosValue(x, y)
	return x * 10000 + y
end

function DrawandguessgameView:_parsePosValue(value)
	value = checknumber(value)

	local y = value % 10000

	value = math.floor(value / 10000)

	local x = value

	return x, y
end

function DrawandguessgameView:_onScratchPointUp(recordDrawData)
	local drawData = {}

	table.insert(self._drawDataList, drawData)

	local drawTypeValue = self:_calDrawTypeValue(recordDrawData.brushType, recordDrawData.brushSize, recordDrawData.brushColorIdx)

	table.insert(drawData, drawTypeValue)

	if recordDrawData.brushType ~= DrawingComponent.BrushType.Clear then
		local compressList = LineCompression.compressPoints(recordDrawData.list)

		for i, v in ipairs(compressList) do
			local value = self:_calPosValue(v.x, v.y)

			table.insert(drawData, value)
		end

		self._scratch:modifyPixels(recordDrawData.list, compressList, recordDrawData.brushSize, recordDrawData.brushColorIdx)
	else
		for i, v in ipairs(recordDrawData.list) do
			local value = self:_calPosValue(v.x, v.y, recordDrawData.brushType, recordDrawData.brushSize, recordDrawData.brushColorIdx)

			table.insert(drawData, value)
		end
	end
end

function DrawandguessgameView:_updateColorCell(view, cell, data, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local colorImg = goutil.findChildImageComponent(cell.gameObject, "color")
	local goSelect = goutil.findChild(cell.gameObject, "select")

	Framework.ColorUtil.SetImageColor(colorImg, data.color)
	goutil.setActive(goSelect, data.id == self._scratch:getColorIdx())
	btn:AddClickListener(function()
		self._scratch:setBrushColor(data.id)
		self._scratch:setBrushType(DrawingComponent.BrushType.Draw)
		self._scrollerListColor:refresh()
		self._scrollerListSize:refresh()
		self._scrollerListEraser:refresh()
	end)
end

function DrawandguessgameView:_clearColorCell(cell)
	return
end

function DrawandguessgameView:_updateSizeCell(view, cell, data, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goColor = goutil.findChild(cell.gameObject, "color")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local size = data.size * 3

	GameUtil.setWidth(goColor, size)
	GameUtil.setHeight(goColor, size)
	GameUtil.setWidth(goSelect, size + 6)
	GameUtil.setHeight(goSelect, size + 6)
	goutil.setActive(goSelect, DrawingComponent.BrushType.Draw == self._scratch:getBrushType() and data.size == self._scratch:getBrushSize())
	btn:AddClickListener(function()
		self._scratch:setBrushType(DrawingComponent.BrushType.Draw)
		self._scratch:setBrushSize(data.size)

		if self._scratch:getColorIdx() <= 0 then
			self._scratch:setBrushColor(1)
		end

		self._scrollerListEraser:refresh()
		self._scrollerListSize:refresh()
	end)
end

function DrawandguessgameView:_clearSizeCell(cell)
	return
end

function DrawandguessgameView:_updateEraserCell(view, cell, data, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goColor = goutil.findChild(cell.gameObject, "color")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local size = data.size * 3

	GameUtil.setWidth(goColor, size)
	GameUtil.setHeight(goColor, size)
	GameUtil.setWidth(goSelect, size + 6)
	GameUtil.setHeight(goSelect, size + 6)
	goutil.setActive(goSelect, DrawingComponent.BrushType.Clear == self._scratch:getBrushType() and data.size == self._scratch:getBrushSize())
	btn:AddClickListener(function()
		self._scratch:setBrushType(DrawingComponent.BrushType.Clear)
		self._scratch:setBrushSize(data.size)
		self._scrollerListEraser:refresh()
		self._scrollerListSize:refresh()
	end)
end

function DrawandguessgameView:_clearEraserCell(cell)
	return
end

function DrawandguessgameView:_tickTimeSendDrawReq()
	if not DrawandguessModel.instance:isMeDraw() then
		removetimer(self._tickTimeSendDrawReq, self)

		return
	end

	local nodes = {}
	local totalCnt = 0

	while #self._drawDataList > 0 do
		local drawData = self._drawDataList[1]

		table.remove(self._drawDataList, 1)

		for j, value in ipairs(drawData) do
			table.insert(nodes, value)

			totalCnt = totalCnt + 1
		end

		if totalCnt >= self._perReqDataCount then
			break
		end
	end

	if #nodes > 0 then
		DrawAndGuessAgent.instance:sendPM_DrawAndGuessDrawReq(self._activityId, nodes)
	end
end

function DrawandguessgameView:_tickDrawTimeDesc()
	local cnt, total = DrawandguessModel.instance:getPlayerDrawCount()
	local leftTime = DrawandguessModel.instance:getEndTime() - ServerTime.now()

	if leftTime < 0 then
		leftTime = 0

		removetimer(self._tickTimeSendDrawReq, self)
	end

	self._txtDrawDesc.text = string.format("当前第%s/%s人绘制中...剩余<color=red>%s</color>秒", cnt, total, leftTime)
end

function DrawandguessgameView:_startGame()
	local interval = DrawandguessConfig.instance:getCommonValue("DRAW_SYNC_TIME", true)

	removetimer(self._tickTimeToAutoDraw, self)
	removetimer(self._tickTimeSendDrawReq, self)
	removetimer(self._tickDrawTimeDesc, self)
	self:_initGameData()
	self:_udpateUI()

	local qId = DrawandguessModel.instance:getCurQuestionId()

	if qId > 0 then
		local qCfg = DrawandguessConfig.instance:getQuestionCfg(self._activityId, qId)
		local tCfg = DrawandguessConfig.instance:getQuestionTypeCfg(qCfg.typeId)
		local roundTime = DrawandguessConfig.instance:getCommonValue("ANSWER_SEC", true)
		local endTime = DrawandguessModel.instance:getStartTime() + roundTime

		DrawandguessModel.instance:_setEndTime(endTime)
		settimer(interval, self._tickTimeSendDrawReq, self, true)
		settimer(1, self._tickDrawTimeDesc, self, true)

		self._txtQuestionTip.text = DrawandguessModel.instance:isMeDraw() and string.format("题库类型：%s 题目：%s", tCfg.desc, qCfg.question) or string.format("%s个字，类型：%s", string.utf8len(qCfg.question), tCfg.desc)

		local uId = DrawandguessModel.instance:getCurDrawUserId()

		self._txtJubaoUserId.text = string.format("当前绘画人ID\n%s", uId)
	else
		self._txtDrawDesc.text = "选择题目中..."
		self._txtQuestionTip.text = ""

		local uId = DrawandguessModel.instance:getCurDrawUserId()

		self._txtJubaoUserId.text = string.format("当前绘画人ID\n%s", "无")
	end
end

function DrawandguessgameView:_initGameData()
	self._needRefreshImg = true
	self._isAutoDrawing = false

	self._scratch:setBrushType(DrawingComponent.BrushType.Draw)

	self._drawDataList = {}
	self._autoDrawDataList = {}
	self._sendChatMsTime = 0
	self._txtJubaoUserId.text = ""
end

function DrawandguessgameView:_updatePlayerCell(cell, player)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local goDrawTag = goutil.findChild(cell.gameObject, "drawTag")
	local goMeTag = goutil.findChild(cell.gameObject, "meTag")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local goBubbleWord = goutil.findChild(cell, "bubbleWord")
	local goBubbleEmoji = goutil.findChild(cell, "bubbleEmoji")
	local txtDescWord = goutil.findChildTextComponent(cell, "bubbleWord/txtDesc")
	local goIconEmoji = goutil.findChild(cell, "bubbleEmoji/icon")
	local isDraw = DrawandguessModel.instance:isDrawPlayer(player.userId)
	local isMe = checknumber(player.userId) == checknumber(RoleModel.instance:getUserId())
	local answerShowData = DrawandguessModel.instance:getAnswerShowData(player.userId)
	local hasShow = answerShowData and answerShowData.endTime > ServerTime.now()
	local isTalk = false
	local isEmoji = false
	local isAnswer = false

	if hasShow then
		isTalk = answerShowData.chatType == DrawandguessController.ChatType.Talk
		isEmoji = answerShowData.chatType == DrawandguessController.ChatType.Emoji
		isAnswer = answerShowData.chatType == DrawandguessController.ChatType.Answer
	end

	if isTalk then
		local cfg = DrawandguessConfig.instance:getTalkCfg(self._activityId, answerShowData.talkId)

		txtDescWord.text = cfg.desc
	elseif isAnswer then
		txtDescWord.text = answerShowData.answer
	elseif isEmoji then
		local cfg = DrawandguessConfig.instance:getEmojiCfg(self._activityId, answerShowData.emojiId)
		local url = string.format("%s.png", cfg.iconUrl)

		uGuiUtil.setSpriteToImage(goIconEmoji, uGuiUtil.SpriteType.BigBg, url)
	end

	goutil.setActive(goBubbleWord, isTalk or isAnswer)
	goutil.setActive(goBubbleEmoji, isEmoji)
	HeadItemController.instance:setHeadCellByInfo(goCon, player.headInfo)

	txtName.text = player.headInfo.userName

	goutil.setActive(goDrawTag, isDraw)
	goutil.setActive(goMeTag, isMe)
end

function DrawandguessgameView:_clearGroupItem(item)
	local goCon = goutil.findChild(item.mainGO, "con")
	local goIconEmoji = goutil.findChild(item.mainGO, "bubbleEmoji/icon")

	uGuiUtil.clearImage(goIconEmoji)
	HeadItemController.instance:resetHeadCell(goCon)
end

function DrawandguessgameView:_updateEmojiCell(view, cell, data, tag)
	local iconGo = goutil.findChild(cell.gameObject, "icon")
	local btn = Framework.ButtonAdapter.Get(iconGo)
	local url = string.format("%s.png", data.iconUrl)

	uGuiUtil.setSpriteToImage(iconGo, uGuiUtil.SpriteType.BigBg, url)
	btn:AddClickListener(function()
		if ServerTime.nowMs() - self._sendChatMsTime < 1000 then
			FloatWordMgr.instance:show("频繁操作，请稍后再试")

			return
		end

		self._sendChatMsTime = ServerTime.nowMs()

		DrawAndGuessAgent.instance:sendPM_DrawAndGuessChatReq(self._activityId, data.id, 0)
	end)
end

function DrawandguessgameView:_clearEmojiCell(cell)
	local iconGo = goutil.findChild(cell.gameObject, "icon")

	uGuiUtil.clearImage(iconGo)
end

function DrawandguessgameView:_updateChatCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local btnGo = goutil.findChild(cell.gameObject, "btn")
	local btn = Framework.ButtonAdapter.Get(btnGo)

	txtDesc.text = data.desc

	btn:AddClickListener(function()
		if ServerTime.nowMs() - self._sendChatMsTime < 1000 then
			FloatWordMgr.instance:show("频繁操作，请稍后再试")

			return
		end

		self._sendChatMsTime = ServerTime.nowMs()

		DrawAndGuessAgent.instance:sendPM_DrawAndGuessChatReq(self._activityId, 0, data.id)
	end)
end

function DrawandguessgameView:_clearChatCell(cell)
	return
end

function DrawandguessgameView:_onCustomInputCallback(hover)
	if not hover then
		goutil.setActive(self._chatPanleGo, false)
		goutil.setActive(self._emojPanleGo, false)
	end
end

function DrawandguessgameView:_onGetTexture2D(texture2d)
	local path = string.format("%s/drawandguessgame_%s.png", UnityEngine.Application.persistentDataPath, ServerTime.now())

	if texture2d then
		print("保存到", path)
		Framework.TextureUtil.SaveTextureToPath(texture2d, path)

		if not Framework.OSDef.isEditor then
			PhotoPicker.saveImageToAlbum("aqsy_mima", "aqsy", path)
		end

		FloatWordMgr.instance:show("已为您保存当前画面及玩家ID，请联系客服提供证据举报")
	end
end

return DrawandguessgameView
