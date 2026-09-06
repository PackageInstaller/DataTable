-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/game/guessbox/CopyGuessBoxSceneView.lua

module("logic.extensions.suppressgame.view.game.guessbox.CopyGuessBoxSceneView", package.seeall)

local CopyGuessBoxSceneView = class("CopyGuessBoxSceneView", ViewComponent)

function CopyGuessBoxSceneView:ctor()
	CopyGuessBoxSceneView.super.ctor(self)
end

function CopyGuessBoxSceneView:buildUI()
	CopyGuessBoxSceneView.super.buildUI(self)

	self._txtGameTimerGo = goutil.findChild(self.mainGO, "txtGameTimer")
	self._txtGameTimer = goutil.findChildTextComponent(self.mainGO, "txtGameTimer/txt")
	self._txtGameTipsGo = goutil.findChild(self.mainGO, "txtGameTips")
	self._txtGameTips = goutil.findChildTextComponent(self.mainGO, "txtGameTips/txt")
	self._endTitleImg = goutil.findChild(self.mainGO, "endTitleImg")
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

function CopyGuessBoxSceneView:bindEvents()
	CopyGuessBoxSceneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._startMask, self._onClickStartMask, self)
end

function CopyGuessBoxSceneView:unbindEvents()
	CopyGuessBoxSceneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._startMask)
end

function CopyGuessBoxSceneView:destroyUI()
	CopyGuessBoxSceneView.super.destroyUI(self)
end

function CopyGuessBoxSceneView:onEnter()
	CopyGuessBoxSceneView.super.onEnter(self)

	self._activityId = 138001
	self._gbCfg = GuessBoxConfig.instance:getGbCfg(self._activityId)
	self._gbBoxCfg = GuessBoxConfig.instance:getGbBoxCfg(self._activityId)
	self._gbFlowerCfg = GuessBoxConfig.instance:getGbFlowerCfg(self._activityId)

	self:_onReset()
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

function CopyGuessBoxSceneView:onExit()
	CopyGuessBoxSceneView.super.onExit(self)
	removetimer(self._startGameCountDown, self)
	removetimer(self._endGameCountDown, self)
	removetimer(self._endGame, self)
	DG.Tweening.DOTween.KillAll(true)
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

function CopyGuessBoxSceneView:_openStartMask()
	UIStateManager.instance:open(ViewName.SuppressGameStartMask, self._readyStartGame, self)
end

function CopyGuessBoxSceneView:_onReset()
	GameUtil.SetActive(self._startMask, false)
	GameUtil.SetActive(self._gameMask, true)
	GameUtil.SetActive(self._txtGameTimerGo, false)
	GameUtil.SetActive(self._txtGameTipsGo, false)
	GameUtil.SetActive(self._boxCell, false)
	GameUtil.SetActive(self._endTitleImg, false)

	self._isGameStart = false
	self._curSelectTimes = 0
	self._selectBoxIds = {}

	self:_setBoxCells()
end

function CopyGuessBoxSceneView:_isCorrectBox(boxId)
	local flowerId = self._gbBoxCfg[boxId].flowerId

	return (self:_isCorrectFlower(flowerId))
end

function CopyGuessBoxSceneView:_isCorrectFlower(flowerId)
	return flowerId == self._gbCfg.correctFlowerId
end

function CopyGuessBoxSceneView:_setBoxCells()
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
		cell._data = data

		table.insert(self._boxCellList, cell)

		cell._mainGo.name = string.format("boxCell_%d", boxId)

		if not data.pos then
			local pos = {}

			GameUtil.setLocalPos(cell._mainGo, pos[1] or 0, pos[2] or 0, 0)
			GameUtil.setLocalPos(cell._item, 0, 86.9, 0)
			GameUtil.setLocalScale(cell._item, 1, 1, 1)
			GameUtil.SetActive(cell._item, true)
			GameUtil.SetActive(cell._select, false)
			GameUtil.SetActive(cell._txtTipsGo, false)

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

function CopyGuessBoxSceneView:_onClickBoxCell(cell)
	local data = cell._data
	local curBoxId = data.boxId
	local curSelectTimes = self._curSelectTimes
	local canGuessTimes = self._gbCfg.canGuessTimes

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
		local leftTimes = self._gbCfg.canGuessTimes - self._curSelectTimes

		self._txtGameTips.text = string.format("剩余选择次数：%d", leftTimes)
	end

	local isCorrectBox = self:_isCorrectBox(curBoxId)

	if isCorrectBox then
		self:_openCorrectBoxAnim(curBoxId)
	else
		self:_openWrongBoxAnim(curBoxId)
	end

	if self._curSelectTimes >= self._gbCfg.canGuessTimes then
		self._isGameStart = false

		ViewBlockMgr.instance:blockClick(true, self)
		settimer(0, self._endGame, self, false)

		return
	end
end

function CopyGuessBoxSceneView:_onClickStartMask()
	self:_readyStartGame()
end

function CopyGuessBoxSceneView:_readyStartGame()
	self._countDown = 2

	GameUtil.SetActive(self._gameMask, true)
	GameUtil.SetActive(self._startMask, false)
	removetimer(self._startGameCountDown, self)
	settimer(1, self._startGameCountDown, self, true)
end

function CopyGuessBoxSceneView:_startGameCountDown()
	if self._countDown <= 1 then
		removetimer(self._startGameCountDown, self)
		self:_startGame()

		return
	end

	self._countDown = self._countDown - 1
end

function CopyGuessBoxSceneView:_startGame()
	self:_startPackBoxesAnim()
end

function CopyGuessBoxSceneView:_startPackBoxesAnim()
	local mySequence = DG.Tweening.DOTween.Sequence()

	for boxId, cell in ipairs(self._boxCellList) do
		local cell = self._boxCellList[boxId]
		local go = cell._item
		local tarVec = Vector3.New(0, 0, 0)
		local tarScale = 0.2

		local function finishHandle()
			GameUtil.SetActive(go, false)
		end

		local effGo = cell._mainGo
		local path = "20220318/songhua/fx_ui_songhua_xiru"

		UIEffectManager.instance:stopEffect(self._packBoxEff[boxId])

		local var_19_0

		if effGo and not string.nilorempty(path) then
			do
				local pathName = path .. ".prefab"

				local function func(_, eff)
					eff:setParent(effGo.transform)
					eff:setLocalPos(0, 0, 0)
					eff:setScale(1, 1, 1)
				end

				self._packBoxEff[boxId] = UIEffectManager.instance:playEffect(self, pathName, effGo, 0, 0, false, false, nil, func, nil)
			end

			var_19_0 = go.transform:DOLocalMove(tarVec, 0.7)
		end

		mySequence:Join(var_19_0:SetEase(DG.Tweening.Ease.OutSine))
		mySequence:Join(go.transform:DOScale(tarScale, 0.7):SetEase(DG.Tweening.Ease.InBack):OnComplete(finishHandle))
	end

	mySequence:AppendCallback(function()
		self:_startExchangeBoxAnim()
	end)
end

function CopyGuessBoxSceneView:_openCorrectBoxAnim(boxId)
	local cell = self._boxCellList[boxId]
	local data = cell._data
	local flowerData = self._gbFlowerCfg[data.flowerId]
	local effGo = cell._mainGo
	local path = flowerData.openEffect

	self:_openBoxEff(effGo, path)
	GameUtil.SetActive(cell._item, true)
	self:_openBoxAnim(cell._item)
end

function CopyGuessBoxSceneView:_openWrongBoxAnim(boxId)
	local cell = self._boxCellList[boxId]
	local data = cell._data
	local flowerData = self._gbFlowerCfg[data.flowerId]
	local effGo = cell._mainGo
	local path = flowerData.openEffect

	self:_openBoxEff(effGo, path)
	GameUtil.SetActive(cell._item, true)
	GameUtil.SetActive(cell._txtTipsGo, true)
	self:_openBoxAnim(cell._item)
end

function CopyGuessBoxSceneView:_openBoxEff(effGo, path)
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

function CopyGuessBoxSceneView:_openBoxAnim(go)
	local tarVec = Vector3.New(0, 86.9, 0)
	local tarScale = 1

	go.transform:DOLocalMove(tarVec, 1.5):SetEase(DG.Tweening.Ease.OutSine)
	go.transform:DOScale(tarScale, 1.5):SetEase(DG.Tweening.Ease.OutBounce)
end

function CopyGuessBoxSceneView:_startExchangeBoxAnim()
	local totalExchangeTimes = checknumber(GuessBoxConfig.instance:getGbSettingValue("totalExchangeTimes"))
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
		self:_startTimeLimitedSelection()
	end

	mySequence:AppendCallback(finishCallback)
end

function CopyGuessBoxSceneView:_startTimeLimitedSelection()
	self._isGameStart = true
	self._countDown = checknumber(GuessBoxConfig.instance:getGbSettingValue("selectCountDown"))

	if self._txtGameTimer then
		self._txtGameTimer.text = string.format("倒计时:%02d秒", self._countDown)
	end

	if self._txtGameTips then
		self._txtGameTips.text = string.format("剩余选择次数：%d", self._gbCfg.canGuessTimes)
	end

	GameUtil.SetActive(self._txtGameTimerGo, true)
	GameUtil.SetActive(self._txtGameTipsGo, true)
	removetimer(self._endGameCountDown, self)
	settimer(1, self._endGameCountDown, self, true)
	GameUtil.SetActive(self._gameMask, false)
end

function CopyGuessBoxSceneView:_endGameCountDown()
	if self._countDown <= 1 then
		removetimer(self._endGameCountDown, self)
		self:_endGame()

		return
	end

	self._countDown = self._countDown - 1
	self._txtGameTimer.text = string.format("倒计时:%02d秒", self._countDown)
end

function CopyGuessBoxSceneView:_endGame()
	removetimer(self._endGameCountDown, self)
	removetimer(self._endGame, self)
	GameUtil.SetActive(self._gameMask, true)
	GameUtil.SetActive(self._txtGameTimerGo, false)
	GameUtil.SetActive(self._txtGameTipsGo, false)
	self:_sendEndGameReq()

	self._isGameStart = false
end

function CopyGuessBoxSceneView:_sendEndGameReq()
	local errorFlowers = {}

	for _, data in ipairs(self._gbFlowerCfg) do
		table.insert(errorFlowers, data.flowerId)
	end

	table.removebyvalue(errorFlowers, self._gbCfg.correctFlowerId, true)

	for i = 1, self._gbCfg.canGuessTimes do
		local boxId = self._selectBoxIds[i]

		if boxId == nil then
			local ranIdx = Mathf.Random(1, #errorFlowers)

			self._selectBoxIds[i] = errorFlowers[ranIdx]
		end
	end

	local flowerIds = {}

	for _, boxId in ipairs(self._selectBoxIds) do
		local fId = self._gbBoxCfg[boxId].flowerId

		table.insert(flowerIds, fId)
	end

	self:_showEndGameTitle(flowerIds)
end

function CopyGuessBoxSceneView:_showEndGameTitle(flowerIds)
	GameUtil.setLocalScale(self._endTitleImg, 0.4, 0.4, 0.4)
	GameUtil.SetActive(self._endTitleImg, true)

	local function callback()
		ViewBlockMgr.instance:blockClick(false, self)
		self:_showResult(flowerIds)
	end

	self._endTitleImg.transform:DOScale(1, 2):SetEase(DG.Tweening.Ease.OutBounce):OnComplete(callback)
end

function CopyGuessBoxSceneView:_showResult(flowerIds)
	if #flowerIds ~= 2 then
		printError("错误,现在只允许挑选两朵花")

		return
	end

	local score = 0

	for _, flowerId in ipairs(flowerIds) do
		if flowerId == 1 then
			score = score + 1
		elseif flowerId == 2 then
			score = score + 2
		end
	end

	SuppressGameController.instance:_endGameHandle(score)
end

function CopyGuessBoxSceneView:_onClickClose()
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

return CopyGuessBoxSceneView
