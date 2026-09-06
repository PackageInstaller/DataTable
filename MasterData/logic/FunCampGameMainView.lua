-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampgame/FunCampGameMainView.lua

module("logic.extensions.funcamp.view.funcampgame.FunCampGameMainView", package.seeall)

local FunCampGameMainView = class("FunCampGameMainView", ViewComponent)
local GameState = {
	Play = 1,
	NoStart = 0,
	End = 4,
	LevelEnd = 3,
	Stop = 2
}

function FunCampGameMainView:ctor()
	self._cellInfos = {}
	self._curState = GameState.NoStart
	self._countDown = 0
end

function FunCampGameMainView:buildUI()
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
end

function FunCampGameMainView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnClickStart:AddClickListener(self._onClickStart, self)
end

function FunCampGameMainView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnClickStart:RemoveClickListener()
end

function FunCampGameMainView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.FunCampGameSelect, self._onFunCampGameSelect, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampTouchStartGame, self._onStartGameRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampTouchEndGame, self._onEndGameRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampGameEnd, self.close, self)
	self:_resetEffectGo()
	self:_loadEffect()

	self._activityId = self:getFirstParam()
	self._clientKey = self:_getRandomNum()
	self._serverKey = 0

	self:_setGameState(GameState.NoStart)
	settimer(1, self._update, self)
	FunCampGameModel.instance:onInit()
	FunCampGameModel.instance:setLevelList(self._activityId)

	self._cellInfos = {}

	self:_initContainer()
end

function FunCampGameMainView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.FunCampGameSelect, self._onFunCampGameSelect, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampTouchStartGame, self._onStartGameRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampTouchEndGame, self._onEndGameRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampGameEnd, self.close, self)
	removetimer(self._update, self)
	self:_clearContainer()
	self:_removeEffect()
end

function FunCampGameMainView:_getRandomNum()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	return math.random(1, 100000000)
end

function FunCampGameMainView:_update()
	if self._curState == GameState.Play then
		self:_reduceTime()
		self:_setCountDown(self:_getCountDown())

		if self:_getCountDown() <= 0 then
			self:_setGameState(GameState.Stop)
			self:_onGameOver()
		end
	end
end

function FunCampGameMainView:_onClickClose()
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

function FunCampGameMainView:_onClickStart()
	printInfo("test 随机数", self._clientKey)
	FunCampGameController.instance:sendStartGameReq(self._activityId, self._clientKey)
end

function FunCampGameMainView:_onStartGameRes(isSuccessStart, serverKey)
	if isSuccessStart then
		self._serverKey = serverKey

		self:_setGameState(GameState.Play)
	else
		TipsFacade.instance:openTipWindow(lang("tip"), "小游戏不在活动时间", function()
			self:close()
		end, "知道了")
	end
end

function FunCampGameMainView:_onEndGameRes()
	UIStateManager.instance:push(ViewName.FunCampGameOver)
end

function FunCampGameMainView:_setGameState(state)
	self._curState = state

	if state == GameState.NoStart then
		self._btnClickStart.gameObject:SetActive(true)
	else
		self._btnClickStart.gameObject:SetActive(false)
	end
end

function FunCampGameMainView:_initContainer()
	self:_clearContainer()
	FunCampGameModel.instance:setNextLevel()

	local row, column = FunCampGameModel.instance:getRowAndColumnNum()

	self:_setTxtTitle(FunCampGameModel.instance:getCurLevel())
	self:_setScore(0)
	self:_setCountDown(FunCampGameModel.instance:getCurLevelDefaultTime())
	self:_fixRow(row)

	local totalNum = row * column

	table.clear(self._cellInfos)

	local randomList = FunCampGameModel.instance:getRandomCardList()

	for i = 1, totalNum do
		local go = goutil.cloneAndSetParent(self._cell, self._container.transform, "cell_" .. tostring(i))

		go:SetActive(true)

		local cellInfo = GameUtil.AddLuaOnce(go, FunCampGameItem)
		local id = randomList[i]

		cellInfo:buildUI(go)
		cellInfo:init(id, i)
		table.insert(self._cellInfos, cellInfo)
	end
end

function FunCampGameMainView:_clearContainer()
	FunCampGameModel.instance:clearGameState()
	self:_clearTween()
	self:_setMask(false)

	for i, v in ipairs(self._cellInfos) do
		v:reset()
	end

	table.clear(self._cellInfos)
	goutil.clearChildren(self._container)
end

function FunCampGameMainView:_fixRow(num)
	self._gridLayoutGroup.constraintCount = num
end

function FunCampGameMainView:_onFunCampGameSelect()
	self:_clearTween()
	self:_setMask(true)

	if FunCampGameModel.instance:isErase() then
		self:_setGameState(GameState.Stop)

		self._tweener = TweenUtil.DoDelay(0.5, function()
			self:_handleGameErase()
		end)
	elseif FunCampGameModel.instance:isArriveMaxSelectCount() then
		self._tweener = TweenUtil.DoDelay(0.5, function()
			self:_handleGameSelect()
		end)
	else
		self:_setMask(false)
	end
end

function FunCampGameMainView:_clearTween()
	if self._tweener then
		self._tweener:Kill()

		self._tweener = nil
	end

	if self._tweenerLevelEnd then
		self._tweenerLevelEnd:Kill()

		self._tweenerLevelEnd = nil
	end
end

function FunCampGameMainView:_handleGameErase()
	FunCampGameModel.instance:addGameScore()
	self:_setScore(FunCampGameModel.instance:getGameScore())

	local list = FunCampGameModel.instance:getSelectIndexList()

	FunCampGameModel.instance:clearSelectState()

	local positionList = {}

	for i, v in ipairs(list) do
		if self._cellInfos[v] then
			self._cellInfos[v]:changeToEraseState()
			table.insert(positionList, self._cellInfos[v]:getPosition())
		end
	end

	self:_updateEffectPos(positionList)

	if FunCampGameModel.instance:isArrivedMaxEraseCount() then
		self:_setGameState(GameState.LevelEnd)
		self:_onGameOver()
	else
		self:_setGameState(GameState.Play)
	end

	self:_setMask(false)
end

function FunCampGameMainView:_handleGameSelect()
	local list = FunCampGameModel.instance:getSelectIndexList()

	FunCampGameModel.instance:clearSelectState()

	for i, v in ipairs(list) do
		if self._cellInfos[v] then
			self._cellInfos[v]:changeToUnSelectState()
		end
	end

	self:_setMask(false)
end

function FunCampGameMainView:_onGameOver()
	if self._curState == GameState.End then
		FunCampGameModel.instance:addToTotalGameScore()
		self:_openGameOverView()
	elseif FunCampGameModel.instance:isArrivedMaxEraseCount() then
		self:_setGameState(GameState.LevelEnd)
		FunCampGameModel.instance:addToTotalGameScore()

		self._tweenerLevelEnd = TweenUtil.DoDelay(0.5, function()
			if FlipGameModel.instance:isHaveNextLevel() then
				self:_startNextLevel()
			else
				self:_openGameOverView()
			end
		end)
	else
		FunCampGameModel.instance:addToTotalGameScore()
		self:_openGameOverView()
	end
end

function FlipGameMainView:_startNextLevel()
	self:_resetEffectGo()
	self:_setGameState(GameState.Play)
	self:_initContainer()
end

function FunCampGameMainView:_openGameOverView()
	local score = FunCampGameModel.instance:getGameScore()
	local encryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		score
	})

	FunCampGameController.instance:openGameOver(self._activityId, score, encryptedKey)
end

function FunCampGameMainView:_setMask(active)
	goutil.setActive(self._maskGo, active)
end

function FunCampGameMainView:_setTxtTitle(level)
	printInfo("test 设置关卡标题", level, type(level))
	self._imgTitle:SetNum(level)
end

function FunCampGameMainView:_setCountDown(countDown)
	self._countDown = countDown
	self._txtCountDown.text = countDown .. "秒"
end

function FunCampGameMainView:_reduceTime()
	self._countDown = self._countDown - 1

	if self._countDown >= 0 then
		self._countDown = self._countDown or 0
	end
end

function FunCampGameMainView:_getCountDown()
	return self._countDown
end

function FunCampGameMainView:_addCountDown(num)
	self._countDown = num
end

function FunCampGameMainView:_setScore(score)
	self._txtScore.text = score .. "对"
end

function FunCampGameMainView:_loadEffect()
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

function FunCampGameMainView:_removeEffect()
	if self._uiEffects then
		for i, v in ipairs(self._uiEffects) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._uiEffects = nil
	end
end

function FunCampGameMainView:_updateEffectPos(posList)
	self._effectGo1.transform.position = posList[1]
	self._effectGo2.transform.position = posList[2]

	self._effectGo1:SetActive(false)
	self._effectGo1:SetActive(true)
	self._effectGo2:SetActive(false)
	self._effectGo2:SetActive(true)
end

function FunCampGameMainView:_resetEffectGo()
	self._effectGo1:SetActive(false)
	self._effectGo2:SetActive(false)
end

return FunCampGameMainView
