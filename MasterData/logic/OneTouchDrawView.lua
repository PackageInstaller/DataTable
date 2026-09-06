-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/view/OneTouchDrawView.lua

module("logic.extensions.luoshiqiordeal.view.OneTouchDrawView", package.seeall)

local OneTouchDrawView = class("OneTouchDrawView", ViewComponent)

function OneTouchDrawView:ctor()
	OneTouchDrawView.super.ctor(self)

	self._oneTouchDrawMo = OneTouchDrawMo.New()

	self:_initParams()

	self._cellGosList = {}
	self._lineGoCycleList = {}
	self._lineGos = {}
end

function OneTouchDrawView:_initParams()
	self._cellLength = 70
	self._cellHalfLength = self._cellLength / 2
	self._cellSpacing = 5
	self._lineWidth = self._cellLength
	self._lineHeight = self._cellLength
end

function OneTouchDrawView:buildUI()
	OneTouchDrawView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._cellItem = self:getGo("root/cellItem")
	self._lineImgItem = self:getGo("root/lineImgItem")
	self._cellItem:GetComponent(goutil.Type_RectTransform).sizeDelta = Vector2.New(self._cellLength, self._cellLength)

	goutil.setActive(self._cellItem, false)
	goutil.setActive(self._lineImgItem, false)

	self._cellRoot = self:getGo("root/cellRoot")
	self._lineRoot = self:getGo("root/lineRoot")
	self._btnBeginGame = self:getBtn("beginGame")
	self._beginGame = self:getGo("beginGame")
	self._btnGameOver = self:getBtn("gameOver")
	self._gameOver = self:getGo("gameOver")
	self._txtCountdown = self:getTxt("countdown/txtTime")
	self._txtLevel = self:getTxt("txtLevel")
	self._txtGameOver = self:getTxt("gameOver/txt")
	self._headGo = self:getGo("root/head")
	self._headTrans = self._headGo:GetComponent(goutil.Type_RectTransform)

	goutil.setActive(self._headGo, false)
end

function OneTouchDrawView:bindEvents()
	OneTouchDrawView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBeginGame:AddClickListener(self._onClickBeginGame, self)
	self._btnGameOver:AddClickListener(self._onClickGameOver, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function OneTouchDrawView:unbindEvents()
	OneTouchDrawView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBeginGame:RemoveClickListener()
	self._btnGameOver:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function OneTouchDrawView:onEnter()
	OneTouchDrawView.super.onEnter(self)
	self:_addAllMsgListener()
	LuoShiQiOrdealModel.instance:resetTemp()

	local params = self:getOpenParam()

	self._isCrazy = params[1]
	self._activityId = params[2]
	self._diffLv = params[3]
	self._clientKey = self:_getRandomNum()
	self._serverKey = 0

	self:_initGame()
	settimer(1, self._onSecond, self)

	if LuoShiQiOrdealController.instance:isFirstEnterGame() then
		LuoShiQiOrdealController.instance:markFirstEnterGame()
		self:_onClickTip()
	end
end

function OneTouchDrawView:_addAllMsgListener()
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoBirthdayStartNormalGameRes, self._onStartNormalGameRes, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoBirthdayEndNormalGameRes, self._onEndNormalGameRes, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoBirthdayStartCrazyGameRes, self._onStartCrazyGameRes, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoBirthdayEndCrazyGameRes, self._onEndCrazyGameRes, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoBirthdayChangeActivity, self._onChangeActivity, self)
end

function OneTouchDrawView:_removeAllMsgListener()
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoBirthdayStartNormalGameRes, self._onStartNormalGameRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoBirthdayEndNormalGameRes, self._onEndNormalGameRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoBirthdayStartCrazyGameRes, self._onStartCrazyGameRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoBirthdayEndCrazyGameRes, self._onEndCrazyGameRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoBirthdayChangeActivity, self._onChangeActivity, self)
end

function OneTouchDrawView:onExit()
	OneTouchDrawView.super.onExit(self)
	self:_removeAllMsgListener()
	removetimer(self._onSecond, self)
	self:_clearCells()
	self:_clearLines()

	self._pointerId = nil
end

function OneTouchDrawView:_getRandomNum()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	return math.random(1, 100000000)
end

function OneTouchDrawView:_onClickClose()
	self:_onGameOver(true, true)
end

function OneTouchDrawView:_onClickBeginGame()
	if not self._isCrazy then
		XiaoNuoBirthdayGiftAgent.instance:sendPM_XiaoNuoBirthdayStartNormalGameReq(self._activityId, self._clientKey, self._diffLv)
	else
		XiaoNuoBirthdayGiftAgent.instance:sendPM_XiaoNuoBirthdayStartCrazyGameReq(self._activityId, self._clientKey)
	end
end

function OneTouchDrawView:_onClickGameOver()
	LuoShiQiOrdealController.instance:showRewards()
	UIStateManager.instance:popByName(ViewName.LsqOrdealLevelView)
	self:close()
end

function OneTouchDrawView:_onClickTip()
	local list = {}
	local cfgs = LuoShiQiOrdealConfig.instance:getRuleCfgList()

	for i, v in ipairs(cfgs) do
		local info = {}

		info.url = string.format("ui/bigbg/luoshiqiordeal/%s.png", v.imgName)
		info.desc = v.desc

		table.insert(list, info)
	end

	TipsFacade.instance:openImageRuleView(list)
end

function OneTouchDrawView:_onStartNormalGameRes(serverKey)
	self._serverKey = serverKey

	self:_onBeginGame()
end

function OneTouchDrawView:_onEndNormalGameRes(isSuccess)
	self:_showGameOverPopupView(isSuccess)
end

function OneTouchDrawView:_onStartCrazyGameRes(serverKey)
	self._serverKey = serverKey

	self:_onBeginGame()
end

function OneTouchDrawView:_onEndCrazyGameRes(isSuccess)
	self:_showGameOverPopupView(isSuccess)
end

function OneTouchDrawView:_onChangeActivity()
	self._isPlaying = false
end

function OneTouchDrawView:_onSecond()
	if self._isPlaying then
		if self._totalTime >= 0 then
			self._txtCountdown.text = string.format("%d秒", self._totalTime)
			self._totalTime = self._totalTime - 1
		else
			self:_onGameOver(true, true)
		end
	end
end

function OneTouchDrawView:_startLevel(levelStr)
	self._oneTouchDrawMo:init(levelStr)
	goutil.setActive(self._headGo, true)
	self:_updateTxtLevel()
	self:_updateCells()
	self:_updateLines()
end

function OneTouchDrawView:_updateCells()
	self:_clearCells()
	self:_resetLastCellIndex()

	local levelObj = self._oneTouchDrawMo:getLevelObj()
	local cellList = levelObj.list
	local lastCell = cellList[#cellList]
	local row = lastCell.row + 1
	local column = lastCell.column + 1
	local count = #cellList
	local totalWidth = column * self._cellLength + (column - 1) * self._cellSpacing
	local totalHeight = row * self._cellLength + (row - 1) * self._cellSpacing
	local horizontalStartPos = totalWidth / 2 * -1 + self._cellHalfLength
	local verticalStartPos = totalHeight / 2 - self._cellHalfLength

	for i = 1, count do
		local go = goutil.cloneAndSetParent(self._cellItem, self._cellRoot.transform, "cell" .. i - 1)

		goutil.setActive(go, true)

		local rowX = (i - 1) % column
		local columnY = Mathf.Floor((i - 1) / column)
		local pos = Vector2.New(0, 0)

		pos.x = rowX == 0 and horizontalStartPos or horizontalStartPos + rowX * (self._cellLength + self._cellSpacing)
		pos.y = columnY == 0 and verticalStartPos or verticalStartPos - columnY * (self._cellLength + self._cellSpacing)
		go:GetComponent(goutil.Type_RectTransform).anchoredPosition = pos

		local cellMo = GameUtil.AddLuaOnce(go, OneTouchCellMo)

		cellMo.index = cellList[i].index
		cellMo.row = cellList[i].row
		cellMo.column = cellList[i].column
		cellMo.cellType = cellList[i].cellType

		table.insert(self._cellGosList, go)
		BeginDragHandler.Get(go):AddLuaHandler(function(_go, eventData)
			self:_onBeginDragCell(_go, eventData)
		end)
		EndDragHandler.Get(go):AddLuaHandler(function(_go, eventData)
			self:_onEndDragCell(_go, eventData)
		end)
		PointerEnterHandler.Get(go):AddLuaHandler(function(_go, eventData)
			self:_onEnterCell(_go, eventData)
		end)
		PointerExitHandler.Get(go):AddLuaHandler(function(_go, eventData)
			self:_onExitCell(_go, eventData)
		end)
		self:setTouchCellExt(go, cellMo)
	end
end

function OneTouchDrawView:setTouchCellExt(go, oneTouchCellMo)
	local image = go:GetComponent(goutil.Type_UIImage)

	if oneTouchCellMo.cellType == 2 then
		image.color = Color.New(1, 0, 0, 1)
	elseif oneTouchCellMo.cellType == 1 then
		image.color = Color.New(1, 1, 1, 1)
	else
		image.color = Color.New(0, 0, 0, 1)

		goutil.setActive(go, false)
	end
end

function OneTouchDrawView:_clearCells()
	self._cellGosList = {}

	goutil.clearChildren(self._cellRoot)
end

function OneTouchDrawView:_resetLastCellIndex()
	self._lastEnterCellIndex = nil
	self._lastExitCellIndex = nil
end

function OneTouchDrawView:_getLineGo()
	if #self._lineGoCycleList > 0 then
		local go = table.remove(self._lineGoCycleList)

		goutil.setActive(go, true)

		return go
	else
		return goutil.cloneAndSetParent(self._lineImgItem, self._lineRoot.transform, "lineItem")
	end
end

function OneTouchDrawView:_updateLines()
	local list = self._oneTouchDrawMo:getLineRecordList()
	local lineCount = 0

	for i, v in ipairs(list) do
		lineCount = lineCount + 1

		local go

		if self._lineGos[i] then
			go = self._lineGos[i]
		else
			go = self:_getLineGo()

			table.insert(self._lineGos, go)
		end

		goutil.setActive(go, true)

		local smallIndex, bigIndex = v:getSortIndex()
		local startRectTrans = self._cellGosList[smallIndex + 1]:GetComponent(goutil.Type_RectTransform)
		local endRectTrans = self._cellGosList[bigIndex + 1]:GetComponent(goutil.Type_RectTransform)
		local rectTrans = go:GetComponent(goutil.Type_RectTransform)
		local width = self._lineWidth
		local height = self._lineHeight
		local smallObj = self._oneTouchDrawMo:getCellObjByIndex(smallIndex)
		local bigObj = self._oneTouchDrawMo:getCellObjByIndex(bigIndex)

		rectTrans.anchoredPosition3D = (startRectTrans.anchoredPosition3D + endRectTrans.anchoredPosition3D) * 0.5

		if v:isHorizontal() then
			local spaceNum = Mathf.Abs(smallObj.column - bigObj.column)
			local cellNum = spaceNum + 1

			goutil.setWidth(rectTrans, spaceNum * self._cellSpacing + cellNum * width + spaceNum * (self._cellLength - width))
			goutil.setHeight(rectTrans, height)
		else
			local spaceNum = Mathf.Abs(smallObj.row - bigObj.row)
			local cellNum = spaceNum + 1

			goutil.setWidth(rectTrans, width)
			goutil.setHeight(rectTrans, spaceNum * self._cellSpacing + cellNum * height + spaceNum * (self._cellLength - height))
		end
	end

	local goCount = #self._lineGos

	for i = lineCount + 1, goCount do
		goutil.setActive(self._lineGos[i], false)
	end

	local headIndex = self._oneTouchDrawMo:getCurStepIndex()

	if headIndex then
		local trans = self._cellGosList[headIndex + 1].transform

		self._headTrans.position = trans.position
	end
end

function OneTouchDrawView:_clearLines()
	for i, v in ipairs(self._lineGos) do
		goutil.setActive(v, false)
	end
end

function OneTouchDrawView:_onBeginDragCell(go, eventData)
	if not self._isPlaying then
		return
	end

	if self._pointerId then
		return
	end

	self._pointerId = nil

	local cellMo = GameUtil.AddLuaOnce(go, OneTouchCellMo)
	local levelObj = self._oneTouchDrawMo:getLevelObj()
	local startIndex = levelObj.startPosIndex

	self._pointerId = eventData.pointerId

	if cellMo.index == startIndex then
		self._lastEnterCellIndex = startIndex
	end
end

function OneTouchDrawView:_onEndDragCell(go, eventData)
	if not self._isPlaying then
		return
	end

	local cellMo = GameUtil.AddLuaOnce(go, OneTouchCellMo)

	if self._pointerId == nil or self._pointerId ~= eventData.pointerId then
		return
	end

	self._pointerId = nil

	self:_resetLastCellIndex()

	if self._oneTouchDrawMo:isSuccessPass() then
		self:_onLevelOver()
	else
		self._oneTouchDrawMo:reset()
		self:_updateLines()
	end
end

function OneTouchDrawView:_onEnterCell(go, eventData)
	if not self._isPlaying then
		return
	end

	local cellMo = GameUtil.AddLuaOnce(go, OneTouchCellMo)

	if self._pointerId ~= nil and self._pointerId == eventData.pointerId then
		self._lastEnterCellIndex = cellMo.index

		local isSuccessAdd = self._oneTouchDrawMo:addStep(cellMo.index)

		if isSuccessAdd then
			self:_updateLines()
		elseif self._lastExitCellIndex and self._oneTouchDrawMo:isStepRecorded(cellMo.index) and self._oneTouchDrawMo:isCellNear(self._lastExitCellIndex, cellMo.index) then
			local isSuccessRemove = self._oneTouchDrawMo:removeStep(self._lastExitCellIndex, cellMo.index)

			if isSuccessRemove then
				self:_updateLines()
			end
		end
	end
end

function OneTouchDrawView:_onExitCell(go, eventData)
	if not self._isPlaying then
		return
	end

	local cellMo = GameUtil.AddLuaOnce(go, OneTouchCellMo)

	if self._pointerId ~= nil and self._pointerId == eventData.pointerId then
		self._lastExitCellIndex = cellMo.index
	end
end

function OneTouchDrawView:_initGame()
	self._maxTime = 1
	self._totalTime = 1
	self._cfgStages = {}
	self._curLevelIndex = 1
	self._totalLevelNum = 1

	if not self._isCrazy then
		local cfg = LuoShiQiOrdealConfig.instance:getNormalGameCfg(self._activityId, self._diffLv)

		self._totalTime = cfg.maxSecond
		self._maxTime = self._totalTime
		self._cfgStages = LuoShiQiOrdealConfig.instance:getStageCfgList(cfg.stageGroupId)

		math.randomseed(ServerTime.now())

		self._curLevelIndex = math.random(1, #self._cfgStages)
	else
		local cfg = LuoShiQiOrdealConfig.instance:getCrazyGameCfg(self._activityId)

		self._cfgStages = LuoShiQiOrdealConfig.instance:getStageCfgList(cfg.stageGroupId)
		self._totalTime = cfg.countdown
		self._maxTime = self._totalTime
	end

	self._totalLevelNum = #self._cfgStages

	self:_initGameObject()
end

function OneTouchDrawView:_initGameObject()
	goutil.setActive(self._gameOver, false)
	goutil.setActive(self._beginGame, true)
	goutil.setActive(self._headGo, false)

	self._txtCountdown.text = string.format("%d%s", self._totalTime, lang("tip_second"))

	self:_updateTxtLevel()
end

function OneTouchDrawView:_updateTxtLevel()
	self._txtLevel.text = string.format("关卡：%d/%d", self._curLevelIndex, self._totalLevelNum)
end

function OneTouchDrawView:_onBeginGame()
	goutil.setActive(self._beginGame, false)

	self._isPlaying = true

	self:_startLevel(self._cfgStages[self._curLevelIndex].mapData)
end

function OneTouchDrawView:_onLevelOver()
	if not self._isCrazy then
		self:_onGameOver()
	else
		self._curLevelIndex = self._curLevelIndex + 1

		if self._curLevelIndex <= self._totalLevelNum then
			local nextMapData = self._cfgStages[self._curLevelIndex].mapData

			self:_startLevel(nextMapData)
		else
			self:_onGameOver()
		end
	end
end

function OneTouchDrawView:_onGameOver(isFail, isForceQuit)
	self:_clearCells()
	self:_clearLines()
	goutil.setActive(self._headGo, false)

	self._isPlaying = false
	self._isDouble = false

	if not self._isCrazy then
		local cfg = LuoShiQiOrdealConfig.instance:getNormalGameCfg(self._activityId, self._diffLv)

		if self._totalTime > 0 then
			self._totalTime = self._totalTime or 0
		end

		self._totalTime = self._totalTime + 1

		local useTime = self._maxTime - self._totalTime
		local curScore = 0

		if isFail then
			curScore = 0
		elseif useTime <= cfg.doubleSecond then
			self._isDouble = true
			curScore = cfg.maxScore
		else
			curScore = Mathf.Round(cfg.maxScore / 2)
		end

		if not isForceQuit then
			LuoShiQiOrdealModel.instance:setCurScore(curScore)
			self:_sendNormalEndGame(curScore)
		else
			self:_showGameOverPopupView(false)
		end
	else
		local stageNum = self._curLevelIndex - 1

		if isForceQuit and stageNum < 1 then
			self:_showGameOverPopupView(false)
		else
			LuoShiQiOrdealModel.instance:setPassStage(stageNum)
			self:_sendCrazyEndGame(stageNum)
		end
	end
end

function OneTouchDrawView:_sendNormalEndGame(curScore)
	local encryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		curScore
	})

	XiaoNuoBirthdayGiftAgent.instance:sendPM_XiaoNuoBirthdayEndNormalGameReq(curScore, encryptedKey)
end

function OneTouchDrawView:_sendCrazyEndGame(stageNum)
	local encryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		stageNum
	})

	XiaoNuoBirthdayGiftAgent.instance:sendPM_XiaoNuoBirthdayEndCrazyGameReq(stageNum, encryptedKey)
end

function OneTouchDrawView:_showGameOverPopupView(isSuccess)
	goutil.setActive(self._gameOver, true)

	if self._isCrazy then
		local passNum = LuoShiQiOrdealModel.instance:getCrazyPassLevelNum()
		local score = isSuccess and LuoShiQiOrdealModel.instance:getCurScore() or 0

		self._txtGameOver.text = langPara("lsqordeal_desc19", passNum, score)
	else
		local score = isSuccess and LuoShiQiOrdealModel.instance:getCurScore() or 0

		self._txtGameOver.text = self._isDouble and lang("lsqordeal_desc20") .. score or lang("lsqordeal_desc21") .. score
	end
end

return OneTouchDrawView
