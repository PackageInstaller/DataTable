-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/flip/FlipGameMainCopyOfTourArenaView.lua

module("logic.extensions.tourarena.view.copy.flip.FlipGameMainCopyOfTourArenaView", package.seeall)

local FlipGameMainCopyOfTourArenaView = class("FlipGameMainCopyOfTourArenaView", ViewComponent)
local GameState = {
	Play = 1,
	NoStart = 0,
	End = 4,
	LevelEnd = 3,
	Stop = 2
}

function FlipGameMainCopyOfTourArenaView:ctor()
	self._cellInfos = {}
	self._curState = GameState.NoStart
	self._countDown = 0
end

function FlipGameMainCopyOfTourArenaView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._imgTitle = self:getGo("title/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._txtScore = self:getTxt("score/txtScore")
	self._txtCountDown = self:getTxt("countDown/txtCountDown")
	self._cell = self:getGo("cell")

	self._cell:SetActive(false)

	self._container = self:getGo("container")
	self._gridLayoutGroup = self._container:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._maskGo = self:getGo("mask")
	self._btnClickStart = self:getBtn("btnClickStart")
	self._effectGo1 = self:getGo("effect1")
	self._effectGo2 = self:getGo("effect2")

	self:_resetEffectGo()

	self._closebg = self:getGo("closebg")
	self._txtTitleGo = self:getGo("txtTitle")
	self._titleGo = self:getGo("title")

	GameUtil.SetActive(self._closeButton.gameObject, false)
	GameUtil.SetActive(self._closebg, false)
	GameUtil.SetActive(self._txtTitleGo, false)
	GameUtil.SetActive(self._titleGo, false)
end

function FlipGameMainCopyOfTourArenaView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnClickStart:AddClickListener(self._onClickStart, self)
end

function FlipGameMainCopyOfTourArenaView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnClickStart:RemoveClickListener()
end

function FlipGameMainCopyOfTourArenaView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.FlipGameSelect, self._onFlipGameSelect, self)
	GlobalDispatcher:addListener(GlobalNotify.FlipTouchIncreaseStageTime, self._onIncreaseStageTimeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FlipGameEnd, self.close, self)
	self:_resetEffectGo()
	self:_loadEffect()
	self:_setGameState(GameState.NoStart)

	local params = self:getOpenParam() or {}

	self._planId = checknumber(params[1])
	self._finishCallBack = params[2]

	local key = self._viewPresentor.viewName .. self._planId
	local isFirst = GameUtil.getUserData(key)

	if not isFirst then
		UIStateManager.instance:push(ViewName.FlipGameStart)
		GameUtil.saveUserData(key, true)
	else
		self:_openStartMask()
	end

	self:_readyGame()
end

function FlipGameMainCopyOfTourArenaView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.FlipGameSelect, self._onFlipGameSelect, self)
	GlobalDispatcher:removeListener(GlobalNotify.FlipTouchIncreaseStageTime, self._onIncreaseStageTimeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FlipGameEnd, self.close, self)
	removetimer(self._update, self)
	self:_clearContainer()
	self:_removeEffect()
end

function FlipGameMainCopyOfTourArenaView:_readyGame()
	self._realScore = 0

	FlipGameModel.instance:onInit()
	FlipGameModel.instance:setLevelList(self._planId)

	self._cellInfos = self._cellInfos or {}

	self:_setScore(self._realScore)
	self:_setCountDown(FlipGameModel.instance:getCurLevelDefaultTime())
	self:_initContainer()
	settimer(1, self._update, self)
end

function FlipGameMainCopyOfTourArenaView:_openStartMask()
	UIStateManager.instance:open(ViewName.SuppressGameStartMask, self._onClickStart, self)
end

function FlipGameMainCopyOfTourArenaView:_getRandomNum()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	return math.random(1, 100000000)
end

function FlipGameMainCopyOfTourArenaView:_update()
	if self._curState == GameState.Play then
		self:_reduceTime()
		self:_setCountDown(self:_getCountDown())

		if self:_getCountDown() <= 0 then
			self:_setGameState(GameState.Stop)
			self:_onGameOver()
		end
	end
end

function FlipGameMainCopyOfTourArenaView:_onClickClose()
	if self._curState ~= GameState.NoStart then
		self:_setGameState(GameState.Stop)
	end

	local text = lang("flipgame_tip2")

	local function okFunc()
		self:_setGameState(GameState.End)
		self:_onGameOver()
	end

	local function cancelFunc()
		if self._curState ~= GameState.NoStart then
			self:_setGameState(GameState.Play)
		end
	end

	TipsFacade.instance:openPopupWindow("提示", text, okFunc, cancelFunc, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
end

function FlipGameMainCopyOfTourArenaView:_onClickStart()
	self:_onStartGameRes()
end

function FlipGameMainCopyOfTourArenaView:_onStartGameRes(msg)
	self:_setGameState(GameState.Play)
end

function FlipGameMainCopyOfTourArenaView:_onIntoNextStageRes()
	self:_startNextLevel()
end

function FlipGameMainCopyOfTourArenaView:_onIncreaseStageTimeRes(isSuccess)
	if isSuccess then
		FlipGameModel.instance:reduceBuyChance()
		self:_addCountDown(FlipGameModel.instance:getCurLevelAddTime())
		self:_setGameState(GameState.Play)
	else
		self:_setGameState(GameState.End)
		self:_onGameOver()
	end
end

function FlipGameMainCopyOfTourArenaView:_setGameState(state)
	self._curState = state

	if state == GameState.NoStart then
		self._btnClickStart.gameObject:SetActive(false)
	else
		self._btnClickStart.gameObject:SetActive(false)
	end
end

function FlipGameMainCopyOfTourArenaView:_initContainer()
	self:_clearContainer()

	local totalLevelNum = FlipGameModel.instance._totalLevelNum
	local ramStageId = Mathf.Random(1, totalLevelNum)

	FlipGameModel.instance._curLevel = (ramStageId - 1) % totalLevelNum + 1
	FlipGameModel.instance._curStageId = ramStageId + 1

	local row, column = FlipGameModel.instance:getRowAndColumnNum()

	self:_setTxtTitle(FlipGameModel.instance:getCurLevel())
	self:_fixRow(row)

	local totalNum = row * column

	table.clear(self._cellInfos)

	local randomList = FlipGameModel.instance:getRandomCardList()

	for i = 1, totalNum do
		local go = goutil.cloneAndSetParent(self._cell, self._container.transform, "cell_" .. tostring(i))

		go:SetActive(true)

		local cellInfo = GameUtil.AddLuaOnce(go, FlipGameItem)
		local id = randomList[i]

		cellInfo:buildUI(go)
		cellInfo:init(id, i)
		table.insert(self._cellInfos, cellInfo)
	end
end

function FlipGameMainCopyOfTourArenaView:_clearContainer()
	FlipGameModel.instance:clearGameState()
	self:_clearTween()
	self:_setMask(false)

	for i, v in ipairs(self._cellInfos) do
		v:reset()
	end

	table.clear(self._cellInfos)
	goutil.clearChildren(self._container)
end

function FlipGameMainCopyOfTourArenaView:_fixRow(num)
	self._gridLayoutGroup.constraintCount = num
end

function FlipGameMainCopyOfTourArenaView:_onFlipGameSelect()
	self:_clearTween()
	self:_setMask(true)

	if FlipGameModel.instance:isErase() then
		self:_setGameState(GameState.Stop)

		self._tweener = TweenUtil.DoDelay(0.25, function()
			self:_handleGameErase()
		end)
	elseif FlipGameModel.instance:isArriveMaxSelectCount() then
		self._tweener = TweenUtil.DoDelay(0.25, function()
			self:_handleGameSelect()
		end)
	else
		self:_setMask(false)
	end
end

function FlipGameMainCopyOfTourArenaView:_clearTween()
	if self._tweener then
		self._tweener:Kill()

		self._tweener = nil
	end

	if self._tweenerLevelEnd then
		self._tweenerLevelEnd:Kill()

		self._tweenerLevelEnd = nil
	end
end

function FlipGameMainCopyOfTourArenaView:_handleGameErase()
	FlipGameModel.instance:addGameScore()

	self._realScore = self._realScore + 1

	self:_setScore(self._realScore)

	local list = FlipGameModel.instance:getSelectIndexList()

	FlipGameModel.instance:clearSelectState()

	local positionList = {}

	for i, v in ipairs(list) do
		if self._cellInfos[v] then
			self._cellInfos[v]:changeToEraseState()
			table.insert(positionList, self._cellInfos[v]:getPosition())
		end
	end

	self:_updateEffectPos(positionList)

	if FlipGameModel.instance:isArrivedMaxEraseCount() then
		self:_setGameState(GameState.LevelEnd)
		self:_startNextLevel()
	else
		self:_setGameState(GameState.Play)
	end

	self:_setMask(false)
end

function FlipGameMainCopyOfTourArenaView:_handleGameSelect()
	local list = FlipGameModel.instance:getSelectIndexList()

	FlipGameModel.instance:clearSelectState()

	for i, v in ipairs(list) do
		if self._cellInfos[v] then
			self._cellInfos[v]:changeToUnSelectState()
		end
	end

	self:_setMask(false)
end

function FlipGameMainCopyOfTourArenaView:_onGameOver()
	if self._curState == GameState.End then
		FlipGameModel.instance:addToTotalGameScore()
		self:_openGameOverView()
	elseif FlipGameModel.instance:isArrivedMaxEraseCount() then
		self:_setGameState(GameState.LevelEnd)
		FlipGameModel.instance:addToTotalGameScore()

		self._tweenerLevelEnd = TweenUtil.DoDelay(0.5, function()
			if FlipGameModel.instance:isHaveNextLevel() then
				self:_openGameOverView()
			else
				self:_openGameOverView()
			end
		end)
	else
		self:_openGameOverView()
	end
end

function FlipGameMainCopyOfTourArenaView:_startNextLevel()
	self:_resetEffectGo()
	self:_setGameState(GameState.Play)
	self:_initContainer()
end

function FlipGameMainCopyOfTourArenaView:_openGameOverView()
	local score = self._realScore
	local isPass = true

	self:_doFinfishCallBack(isPass, score)
	self:close()
end

function FlipGameMainCopyOfTourArenaView:_doFinfishCallBack(isPass, totalEnergy)
	local info = {}

	info.isPass = isPass
	info.gameScore = totalEnergy

	GameUtil.callBack(self._finishCallBack, info)
end

function FlipGameMainCopyOfTourArenaView:_setMask(active)
	goutil.setActive(self._maskGo, active)
end

function FlipGameMainCopyOfTourArenaView:_setTxtTitle(level)
	printInfo("test 设置关卡标题", level, type(level))
	self._imgTitle:SetNum(level)
end

function FlipGameMainCopyOfTourArenaView:_setCountDown(countDown)
	self._countDown = countDown
	self._txtCountDown.text = countDown .. "秒"
end

function FlipGameMainCopyOfTourArenaView:_reduceTime()
	self._countDown = self._countDown - 1

	if self._countDown >= 0 then
		self._countDown = self._countDown or 0
	end
end

function FlipGameMainCopyOfTourArenaView:_getCountDown()
	return self._countDown
end

function FlipGameMainCopyOfTourArenaView:_addCountDown(num)
	self._countDown = num
end

function FlipGameMainCopyOfTourArenaView:_setScore(score)
	self._txtScore.text = score .. "对"
end

function FlipGameMainCopyOfTourArenaView:_loadEffect()
	self._uiEffects = {}

	local path = "fx_ui_dianliangmengzhidui/fx_ui_xiaochu_mzd.prefab"
	local uiEffect1 = UIEffectManager.instance:playEffect(self, path, self._effectGo1.transform, 0, 0, true, false)

	uiEffect1:setParent(self._effectGo1.transform)
	uiEffect1:setScale(1)

	uiEffect1.hideEffWhileNotOnTop = false

	local uiEffect2 = UIEffectManager.instance:playEffect(self, path, self._effectGo2.transform, 0, 0, true, false)

	uiEffect2:setParent(self._effectGo2.transform)
	uiEffect2:setScale(1)

	uiEffect2.hideEffWhileNotOnTop = false

	table.insert(self._uiEffects, uiEffect1)
	table.insert(self._uiEffects, uiEffect2)
end

function FlipGameMainCopyOfTourArenaView:_removeEffect()
	if self._uiEffects then
		for i, v in ipairs(self._uiEffects) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._uiEffects = nil
	end
end

function FlipGameMainCopyOfTourArenaView:_updateEffectPos(posList)
	self._effectGo1.transform.position = posList[1]
	self._effectGo2.transform.position = posList[2]

	self._effectGo1:SetActive(false)
	self._effectGo1:SetActive(true)
	self._effectGo2:SetActive(false)
	self._effectGo2:SetActive(true)
end

function FlipGameMainCopyOfTourArenaView:_resetEffectGo()
	self._effectGo1:SetActive(false)
	self._effectGo2:SetActive(false)
end

return FlipGameMainCopyOfTourArenaView
