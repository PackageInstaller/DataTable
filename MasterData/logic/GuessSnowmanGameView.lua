-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesssnowman/view/GuessSnowmanGameView.lua

module("logic.extensions.guesssnowman.view.GuessSnowmanGameView", package.seeall)

local GuessSnowmanGameView = class("GuessSnowmanGameView", ViewComponent)

GuessSnowmanGameView.GameType = {
	Hard = 2,
	Nomal = 1
}

function GuessSnowmanGameView:ctor()
	GuessSnowmanGameView.super.ctor(self)
end

function GuessSnowmanGameView:buildUI()
	GuessSnowmanGameView.super.buildUI(self)

	self._txtGameTimerGo = goutil.findChild(self.mainGO, "txtGameTimer")
	self._txtGameTimer = goutil.findChildTextComponent(self.mainGO, "txtGameTimer/txt")
	self._txtGameTipsGo = goutil.findChild(self.mainGO, "txtGameTips")
	self._txtGameTips = goutil.findChildTextComponent(self.mainGO, "txtGameTips/txt")
	self._endTitleImg = goutil.findChild(self.mainGO, "endTitleImg")
	self._txtScore = goutil.findChildTextComponent(self.mainGO, "txtScore/txt")
	self._startMask = goutil.findChild(self.mainGO, "startMask")
	self._gameMask = goutil.findChild(self.mainGO, "gameMask")
	self._boxCol = goutil.findChild(self.mainGO, "boxCol")
	self._boxView = goutil.findChild(self.mainGO, "boxCol/boxView")
	self._boxCell = goutil.findChild(self.mainGO, "boxCol/boxCell")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._packBoxEff = {}
	self._openEff = nil
	self._leftTop = goutil.findChild(self.mainGO, "leftTop")

	GameUtil.SetActive(self._leftTop, false)
end

function GuessSnowmanGameView:bindEvents()
	GuessSnowmanGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._startMask, self._onClickStartMask, self)
end

function GuessSnowmanGameView:unbindEvents()
	GuessSnowmanGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._startMask)
end

function GuessSnowmanGameView:destroyUI()
	GuessSnowmanGameView.super.destroyUI(self)
end

function GuessSnowmanGameView:onEnter()
	GuessSnowmanGameView.super.onEnter(self)

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])

		local levelId = checknumber(params[2])

		self._levelCfg = GuessBoxConfig.instance:getLevelInfo(self._activityId, levelId)
		self._gameType = self._levelCfg.type
		self._eternalDragonActivityId = checknumber(params[3])
	else
		self._levelCfg = nil
		self._activityId = 138001
		self._gameType = GuessSnowmanGameView.GameType.Hard
	end

	self._gbCfg = GuessBoxConfig.instance:getGbCfg(self._activityId)
	self._gbBoxCfg = self._levelCfg and GuessBoxConfig.instance:getGbBoxCfgByLevel(self._activityId, self._levelCfg.levelId) or GuessBoxConfig.instance:getGbBoxCfg(self._activityId)
	self._gbFlowerCfg = GuessBoxConfig.instance:getGbFlowerCfg(self._activityId)

	self:_onReset()
	GlobalDispatcher:addListener(GlobalNotify.GuessBoxGameStartGame, self._startTimeLimitedSelection, self)
	GlobalDispatcher:addListener(GlobalNotify.GuessBoxGameEndGame, self._handleEndGameRes, self)
	GlobalDispatcher:addListener(GlobalNotify.SuppressGameToStartGame, self._openStartMask, self)

	local key = self._viewPresentor.viewName .. self._activityId
	local isFirst = GameUtil.getUserData(key)

	if not isFirst then
		UIStateManager.instance:push(ViewName.GuessBoxRuleView, self._activityId)
		GameUtil.saveUserData(key, true)
	else
		self:_openStartMask()
	end
end

function GuessSnowmanGameView:onExit()
	GuessSnowmanGameView.super.onExit(self)
	removetimer(self._startGameCountDown, self)
	removetimer(self._endGameCountDown, self)
	removetimer(self._endGame, self)
	DG.Tweening.DOTween.KillAll(true)
	GlobalDispatcher:removeListener(GlobalNotify.GuessBoxGameStartGame, self._startTimeLimitedSelection, self)
	GlobalDispatcher:removeListener(GlobalNotify.GuessBoxGameEndGame, self._handleEndGameRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.SuppressGameToStartGame, self._openStartMask, self)

	local childList = GameUtil.getChildren(self._boxView)

	for _, go in ipairs(childList) do
		uGuiUtil.clearImage(go)
	end

	UIEffectManager.instance:stopEffect(self._openEff)

	for _, eff in ipairs(self._packBoxEff) do
		UIEffectManager.instance:stopEffect(eff)
	end
end

function GuessSnowmanGameView:_openStartMask()
	UIStateManager.instance:open(ViewName.SuppressGameStartMask, self._readyStartGame, self)
end

function GuessSnowmanGameView:_onReset()
	GameUtil.SetActive(self._startMask, false)
	GameUtil.SetActive(self._gameMask, true)
	GameUtil.SetActive(self._txtGameTimerGo, false)
	GameUtil.SetActive(self._txtGameTipsGo, false)
	GameUtil.SetActive(self._boxCell, false)
	GameUtil.SetActive(self._endTitleImg, false)

	self._isGameStart = false
	self._curSelectTimes = 0
	self._selectBoxIds = {}

	self:_refreshScore()
	self:_setBoxCells()
end

function GuessSnowmanGameView:_isCorrectBox(boxId)
	local flowerId = self._gbBoxCfg[boxId].flowerId

	return (self:_isCorrectFlower(flowerId))
end

function GuessSnowmanGameView:_isCorrectFlower(flowerId)
	return flowerId >= self._gbCfg.correctFlowerId
end

function GuessSnowmanGameView:_setBoxCells()
	local childList = GameUtil.getChildren(self._boxView)

	for _, go in ipairs(childList) do
		GameUtil.SetActive(go, false)
	end

	self._boxCellList = {}

	for boxId, data in ipairs(self._gbBoxCfg) do
		local cell = {}

		cell._mainGo = childList[boxId] or goutil.cloneAndSetParent(self._boxCell, self._boxView.transform)
		cell._item = goutil.findChild(cell._mainGo, "item")
		cell._itemGo = goutil.findChild(cell._mainGo, "item/itemGo")
		cell._select = goutil.findChild(cell._mainGo, "select")
		cell._txtTipsGo = goutil.findChild(cell._mainGo, "txtTips")
		cell._txtTips = goutil.findChildTextComponent(cell._mainGo, "txtTips/txt")
		cell._txtOrder = goutil.findChildTextComponent(cell._mainGo, "txtOrder")
		cell._imgBox = goutil.findChild(cell._mainGo, "imgBox")
		cell._data = data

		table.insert(self._boxCellList, cell)

		cell._mainGo.name = string.format("boxCell_%d", boxId)

		if not data.pos then
			local pos = {}

			GameUtil.setLocalPos(cell._mainGo, pos[1] or 0, pos[2] or 0, 0)
			GameUtil.setLocalPos(cell._item, 0, 0, 0)
			GameUtil.setLocalScale(cell._item, 1, 1, 1)
			GameUtil.SetActive(cell._item, false)
			GameUtil.SetActive(cell._select, false)
			GameUtil.SetActive(cell._txtTipsGo, false)
			GameUtil.SetActive(cell._txtOrder, false)

			local path = self._gbFlowerCfg[data.flowerId].picturePath
			local bgGo = cell._itemGo

			if not string.nilorempty(path) and bgGo then
				local spriteType = uGuiUtil.SpriteType.BigBg
				local spriteName = string.format("ui/icon/%s.png", path)

				local function func()
					return
				end

				uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
			end

			GameUtil.SetActive(cell._mainGo, true)
			GameUtil.addClickHandler(cell._mainGo, GameUtil.handler(self._onClickBoxCell, self, cell))
		end
	end
end

function GuessSnowmanGameView:_onClickBoxCell(cell)
	local data = cell._data
	local curBoxId = data.boxId
	local curSelectTimes = self._curSelectTimes
	local canGuessTimes = self._gbCfg.canGuessTimes

	if self._levelCfg then
		canGuessTimes = self._levelCfg.canGuessTimes
	end

	if canGuessTimes <= curSelectTimes then
		return
	end

	local isHasSelected = table.indexof(self._selectBoxIds, curBoxId) ~= false

	if isHasSelected then
		local isCorrectBox = self:_isCorrectBox(curBoxId)

		if isCorrectBox then
			FloatWordMgr.instance:show("该花篮你已选择啦")
		else
			FloatWordMgr.instance:show("选错了哦，不要再点啦~")
		end

		return
	end

	self._curSelectTimes = self._curSelectTimes + 1

	table.insert(self._selectBoxIds, curBoxId)

	if self._txtGameTips then
		local leftTimes = canGuessTimes - self._curSelectTimes

		self._txtGameTips.text = string.format("剩余选择次数：%d", leftTimes)
	end

	local isCorrectBox = self:_isCorrectBox(curBoxId)

	if isCorrectBox then
		if self._gameType == GuessSnowmanGameView.GameType.Hard and self._boxCellList[curBoxId]._data.flowerId == self._needSelectId then
			self._needSelectId = self._needSelectId + 1
		else
			self._currectSelect = false
		end

		self:_openCorrectBoxAnim(curBoxId)
	else
		self._currectSelect = false

		self:_openWrongBoxAnim(curBoxId)
	end

	self:_refreshScore()

	if canGuessTimes <= self._curSelectTimes then
		self._isGameStart = false

		ViewBlockMgr.instance:blockClick(true, self)
		settimer(0, self._endGame, self, false)

		return
	end
end

function GuessSnowmanGameView:_onClickStartMask()
	self:_readyStartGame()
end

function GuessSnowmanGameView:_readyStartGame()
	self._countDown = 2

	GameUtil.SetActive(self._gameMask, true)
	GameUtil.SetActive(self._startMask, false)
	removetimer(self._startGameCountDown, self)
	settimer(1, self._startGameCountDown, self, true)
end

function GuessSnowmanGameView:_startGameCountDown()
	if self._countDown <= 1 then
		removetimer(self._startGameCountDown, self)
		self:_startGame()

		return
	end

	self._countDown = self._countDown - 1
end

function GuessSnowmanGameView:_startGame()
	self:_startPackBoxesAnim()
end

function GuessSnowmanGameView:_startPackBoxesAnim()
	local type = self._gameType
	local openList = {}

	for boxId, cell in ipairs(self._boxCellList) do
		local cell = self._boxCellList[boxId]
		local data = cell._data
		local go = cell._item

		if data.flowerId > 1 then
			GameUtil.SetActive(go, data.flowerId > 1)
			table.insert(openList, cell)
		end
	end

	table.sort(openList, function(a, b)
		return a._data.boxId < b._data.boxId
	end)

	local mySequence = DG.Tweening.DOTween.Sequence()

	for index, cell in ipairs(openList) do
		local go = cell._item
		local tarVec = Vector3.New(90, 90, 0)

		local function startHandle()
			GameUtil.SetActive(go, true)

			if type == GuessSnowmanGameView.GameType.Hard then
				GameUtil.SetActive(cell._txtOrder, true)

				cell._txtOrder.text = index
			end
		end

		if type == GuessSnowmanGameView.GameType.Nomal then
			GameUtil.SetActive(go, true)
			mySequence:Join(go.transform:DOLocalMove(tarVec, 0.7))
		elseif type == GuessSnowmanGameView.GameType.Hard then
			mySequence:AppendCallback(startHandle)
			mySequence:Append(go.transform:DOLocalMove(tarVec, 0.7))
		end
	end

	mySequence:AppendInterval(2)
	mySequence:AppendInterval(0)

	for index, cell in ipairs(openList) do
		local go = cell._item
		local tarVec = Vector3.New(0, 0, 0)

		local function finishHandle()
			GameUtil.SetActive(go, false)
			GameUtil.SetActive(cell._txtOrder, false)
		end

		if type == GuessSnowmanGameView.GameType.Nomal then
			mySequence:Join(go.transform:DOLocalMove(tarVec, 0.7):OnComplete(finishHandle))
		elseif type == GuessSnowmanGameView.GameType.Hard then
			mySequence:Append(go.transform:DOLocalMove(tarVec, 0.7))
			mySequence:AppendCallback(finishHandle)
		end
	end

	mySequence:AppendCallback(function()
		self:_startExchangeBoxAnim()
	end)
end

function GuessSnowmanGameView:_openCorrectBoxAnim(boxId)
	local cell = self._boxCellList[boxId]
	local data = cell._data
	local flowerData = self._gbFlowerCfg[data.flowerId]

	if self._currectSelect == true then
		cell._txtOrder.text = self._needSelectId - self._gbCfg.correctFlowerId

		GameUtil.SetActive(cell._txtOrder, true)
	else
		GameUtil.SetActive(cell._txtOrder, false)
	end

	local effGo = cell._mainGo
	local path = flowerData.openEffect

	self:_openBoxEff(effGo, path)
	GameUtil.SetActive(cell._item, true)
	self:_openBoxAnim(cell._item)
end

function GuessSnowmanGameView:_openWrongBoxAnim(boxId)
	local cell = self._boxCellList[boxId]
	local data = cell._data
	local flowerData = self._gbFlowerCfg[data.flowerId]
	local effGo = cell._mainGo
	local path = flowerData.openEffect

	self:_openBoxEff(effGo, path)

	local mySequence = DG.Tweening.DOTween.Sequence()

	mySequence:Append(cell._imgBox.transform:DOLocalRotate(Vector3.New(0, 0, 15), 0.1))
	mySequence:Append(cell._imgBox.transform:DOLocalRotate(Vector3.New(0, 0, -15), 0.1))
	mySequence:Append(cell._imgBox.transform:DOLocalRotate(Vector3.New(0, 0, 0), 0.05))
	GameUtil.SetActive(cell._item, false)
	GameUtil.SetActive(cell._txtTipsGo, true)
end

function GuessSnowmanGameView:_openBoxEff(effGo, path)
	UIEffectManager.instance:stopEffect(self._openEff)

	if effGo and not string.nilorempty(path) then
		local pathName = path .. ".prefab"

		local function func(_, eff)
			eff:setParent(effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._openEff = UIEffectManager.instance:playEffect(self, pathName, effGo, 0, 0, false, false, nil, func, nil)
	end
end

function GuessSnowmanGameView:_openBoxAnim(go)
	local tarVec = Vector3.New(90, 90, 0)
	local tarScale = 1

	go.transform:DOLocalMove(tarVec, 1.5):SetEase(DG.Tweening.Ease.OutSine)
	go.transform:DOScale(tarScale, 1):SetEase(DG.Tweening.Ease.OutSine)
end

function GuessSnowmanGameView:_startExchangeBoxAnim()
	local totalExchangeTimes = checknumber(GuessBoxConfig.instance:getGbSettingValue("totalExchangeTimes") * 2)
	local boxList = {}

	for boxId, data in ipairs(self._gbBoxCfg) do
		for i = 1, data.minExchangeTimes do
			table.insert(boxList, boxId)
		end
	end

	if totalExchangeTimes < #boxList then
		printError(string.format("错误: 最小交换次数总和=%d > 总交换次数=%d\n", #boxList, totalExchangeTimes))

		return
	end

	for i = 1, totalExchangeTimes - #boxList do
		local ranBoxId = Mathf.Random(1, #self._gbBoxCfg)

		table.insert(boxList, ranBoxId)
	end

	local queue = {}

	for idx, boxId in ipairs(boxList) do
		local ranBoxId = Mathf.Random(1, #self._gbBoxCfg)

		if ranBoxId == boxId then
			ranBoxId = Mathf.Abs(ranBoxId - boxId) + 1
		end

		queue[idx] = {
			{
				boxId = boxId,
				posKey = boxId
			},
			{
				boxId = ranBoxId,
				posKey = ranBoxId
			}
		}
	end

	for i = 1, #queue do
		local ranIdx = Mathf.Random(i, #queue)

		queue[i] = queue[ranIdx]
		queue[ranIdx] = queue[i]
	end

	local boxDic = {}

	for boxId, data in ipairs(self._gbBoxCfg) do
		boxDic[boxId] = boxId
	end

	for _, box in ipairs(queue) do
		local posKeyA = box[1].posKey
		local posKeyB = box[2].posKey

		box[1].posKey = boxDic[posKeyA]
		box[2].posKey = boxDic[posKeyB]
		boxDic[posKeyA] = boxDic[posKeyB]
		boxDic[posKeyB] = boxDic[posKeyA]
	end

	local posDic = {}

	for boxId, data in ipairs(self._gbBoxCfg) do
		posDic[boxId] = Vector3.New(data.pos[1], data.pos[2], 0)
	end

	local DgDuration = GuessBoxConfig.instance:getGbSettingValue("DgDuration")
	local durArr = string.split(DgDuration, ":")
	local speed = checknumber(durArr[1])
	local minDuration = checknumber(durArr[2])
	local maxDuration = checknumber(durArr[3])
	local DgScaleFactor = GuessBoxConfig.instance:getGbSettingValue("DgScaleFactor")
	local scArr = string.split(DgScaleFactor, ":")
	local scaleP = checknumber(scArr[1])
	local minFactor = checknumber(scArr[2])
	local maxFactor = checknumber(scArr[3])
	local DgInterval = checknumber(GuessBoxConfig.instance:getGbSettingValue("DgInterval"))
	local mySequence = DG.Tweening.DOTween.Sequence()

	for _, box in ipairs(queue) do
		local boxIdA = box[1].boxId
		local boxIdB = box[2].boxId
		local posKeyA = box[1].posKey
		local posKeyB = box[2].posKey
		local cellA = self._boxCellList[boxIdA]
		local cellB = self._boxCellList[boxIdB]
		local goA = cellA._mainGo
		local goB = cellB._mainGo
		local vecA = posDic[posKeyA]
		local vecB = posDic[posKeyB]
		local scaleA, scaleB
		local distance = Vector3.Distance(vecA, vecB)
		local duration = Mathf.Clamp(distance / speed, minDuration, maxDuration)
		local scaleFactor = Mathf.Clamp(scaleP * distance / 100, minFactor, maxFactor)
		local shrink = Vector3.New(1, 1, 1):Mul(1 - scaleFactor)
		local enlarge = Vector3.New(1, 1, 1):Mul(1 + scaleFactor)

		if posKeyB < posKeyA then
			scaleA = shrink
			scaleB = enlarge
		else
			scaleA = enlarge
			scaleB = shrink
		end

		local function startHandle()
			if posKeyA > posKeyB then
				goA.transform:SetAsFirstSibling()
				goB.transform:SetAsLastSibling()
			else
				goA.transform:SetAsLastSibling()
				goB.transform:SetAsFirstSibling()
			end
		end

		mySequence:Append(goA.transform:DOLocalMove(vecB, duration):SetEase(DG.Tweening.Ease.InOutQuad):OnStart(startHandle))
		mySequence:Join(goB.transform:DOLocalMove(vecA, duration):SetEase(DG.Tweening.Ease.InOutQuad))
		mySequence:Join(goA.transform:DOScale(scaleA, duration / 2):SetEase(DG.Tweening.Ease.OutQuad):SetLoops(2, DG.Tweening.LoopType.Yoyo))
		mySequence:Join(goB.transform:DOScale(scaleB, duration / 2):SetEase(DG.Tweening.Ease.OutQuad):SetLoops(2, DG.Tweening.LoopType.Yoyo))
		mySequence:AppendInterval(DgInterval)
	end

	local function finishCallback()
		if self._eternalDragonActivityId > 0 then
			GuessBoxModel.instance:setGameScore(0)
			self:_startTimeLimitedSelection()
		else
			GuessBoxController.instance:onSendGuessBoxGameStartGameReq(self._activityId)
		end
	end

	mySequence:AppendCallback(finishCallback)
end

function GuessSnowmanGameView:_startTimeLimitedSelection()
	self._isGameStart = true
	self._needSelectId = self._gbCfg.correctFlowerId
	self._currectSelect = true
	self._isDouble = false
	self._countDown = checknumber(GuessBoxConfig.instance:getGbSettingValue("selectCountDown"))

	if self._txtGameTimer then
		self._txtGameTimer.text = string.format("倒计时:%02d秒", self._countDown)
	end

	if self._txtGameTips then
		self._txtGameTips.text = string.format("剩余选择次数：%d", (self._levelCfg or nil) and self._levelCfg.canGuessTimes)
	end

	GameUtil.SetActive(self._txtGameTimerGo, true)
	GameUtil.SetActive(self._txtGameTipsGo, true)
	removetimer(self._endGameCountDown, self)
	settimer(1, self._endGameCountDown, self, true)
	GameUtil.SetActive(self._gameMask, false)
end

function GuessSnowmanGameView:_endGameCountDown()
	if self._countDown <= 1 then
		removetimer(self._endGameCountDown, self)
		self:_endGame()

		return
	end

	self._countDown = self._countDown - 1
	self._txtGameTimer.text = string.format("倒计时:%02d秒", self._countDown)
end

function GuessSnowmanGameView:_endGame()
	removetimer(self._endGameCountDown, self)
	removetimer(self._endGame, self)
	GameUtil.SetActive(self._gameMask, true)
	GameUtil.SetActive(self._txtGameTimerGo, false)
	GameUtil.SetActive(self._txtGameTipsGo, false)
	self:_sendEndGameReq()

	self._isGameStart = false
end

function GuessSnowmanGameView:_sendEndGameReq()
	local errorFlowers = {}

	for _, data in ipairs(self._gbFlowerCfg) do
		if data.flowerId < self._gbCfg.correctFlowerId then
			table.insert(errorFlowers, data.flowerId)
		end
	end

	for i = 1, (self._levelCfg or nil) and self._levelCfg.canGuessTimes do
		local boxId = self._selectBoxIds[i]

		if boxId == nil then
			local ranIdx = Mathf.Random(1, #errorFlowers)

			self._selectBoxIds[i] = errorFlowers[ranIdx]
			self._currectSelect = false
		end
	end

	local flowerIds = {}

	for _, boxId in ipairs(self._selectBoxIds) do
		local fId = self._gbBoxCfg[boxId].flowerId

		table.insert(flowerIds, fId)
	end

	local score = 0

	for i, v in ipairs(flowerIds) do
		local flowerCfg = self._gbFlowerCfg[v]

		score = score + checknumber(flowerCfg.score)
	end

	if self._gameType == GuessSnowmanGameView.GameType.Hard and self._currectSelect == true then
		self._isDouble = true
		score = score * 2
	end

	for i, v in ipairs(flowerIds) do
		if v >= self._gbCfg.correctFlowerId then
			v = self._gbCfg.correctFlowerId
		end
	end

	if self._eternalDragonActivityId > 0 then
		GuessBoxModel.instance:setGameScore(score)
		self:_showEndGameTitle(0, {})

		local cfgActivity = EternalDragonConfig.instance:getEdActData(self._eternalDragonActivityId)

		if cfgActivity and cfgActivity.cutViewValidator then
			local targetScore = checknumber(cfgActivity.cutViewValidator.score)

			if targetScore <= score then
				EternalDragonController.instance:sendPM_EternalDragonCuttingReq(self._eternalDragonActivityId)
			end
		end
	else
		GuessBoxController.instance:onSendGuessBoxGameEndGameReq(flowerIds, score)
	end
end

function GuessSnowmanGameView:_handleEndGameRes(changeSetId, prizeStrList)
	self:_showEndGameTitle(changeSetId, prizeStrList)
end

function GuessSnowmanGameView:_showEndGameTitle(changeSetId, prizeStrList)
	local function callback()
		ViewBlockMgr.instance:blockClick(false, self)
		self:_showResult(changeSetId, prizeStrList)
	end

	settimer(1, callback, self, false)
end

function GuessSnowmanGameView:_showResult(changeSetId, prizeStrList)
	UIStateManager.instance:push(ViewName.GuessSnowmanResultView, changeSetId, prizeStrList, self._isDouble)
end

function GuessSnowmanGameView:_onClickClose()
	removetimer(self._endGameCountDown, self)

	if self._isGameStart then
		local tipsContent = "现在退出，剩余的选择次数将判定为错误，并结算本局游戏奖励哦，是否确定退出？"

		local function okFunc()
			self:_endGame()
		end

		local function cencelFunc()
			settimer(1, self._endGameCountDown, self, true)
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
	else
		self:close()
	end
end

function GuessSnowmanGameView:_refreshScore()
	local flowerIds = {}

	for _, boxId in ipairs(self._selectBoxIds) do
		local fId = self._gbBoxCfg[boxId].flowerId

		table.insert(flowerIds, fId)
	end

	local score = 0

	for i, v in ipairs(flowerIds) do
		local flowerCfg = self._gbFlowerCfg[v]

		score = score + checknumber(flowerCfg.score)
	end

	self._txtScore.text = langPara("已获得积分：%d", score)
end

return GuessSnowmanGameView
