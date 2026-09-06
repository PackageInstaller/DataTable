-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/game/flip/CopyFlipGameMainView.lua

module("logic.extensions.suppressgame.view.game.flip.CopyFlipGameMainView", package.seeall)

local CopyFlipGameMainView = class("CopyFlipGameMainView", ViewComponent)
local GameState = {
	Play = 1,
	NoStart = 0,
	End = 4,
	LevelEnd = 3,
	Stop = 2
}

function CopyFlipGameMainView:ctor()
	self._cellInfos = {}
	self._curState = GameState.NoStart
	self._countDown = 0
end

function CopyFlipGameMainView:buildUI()
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

function CopyFlipGameMainView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnClickStart:AddClickListener(self._onClickStart, self)
end

function CopyFlipGameMainView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnClickStart:RemoveClickListener()
end

function CopyFlipGameMainView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.FlipGameSelect, self._onFlipGameSelect, self)
	GlobalDispatcher:addListener(GlobalNotify.FlipTouchIncreaseStageTime, self._onIncreaseStageTimeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FlipGameEnd, self.close, self)
	GlobalDispatcher:addListener(GlobalNotify.SuppressGameToStartGame, self._openStartMask, self)
	self:_resetEffectGo()
	self:_loadEffect()

	self._activityId = 24002

	self:_setGameState(GameState.NoStart)

	self._planId = 0

	local cfg = DreamTeamConfig.instance:getActivityCfgById(self._activityId)

	if cfg then
		self._planId = cfg.planId
	end

	settimer(1, self._update, self)
	FlipGameModel.instance:onInit()
	FlipGameModel.instance:setLevelList(self._planId)

	self._cellInfos = {}

	self:_initContainer()

	local key = self._viewPresentor.viewName .. self._activityId
	local isFirst = GameUtil.getUserData(key)

	if not isFirst then
		UIStateManager.instance:push(ViewName.FlipGameStart)
		GameUtil.saveUserData(key, true)
	else
		self:_openStartMask()
	end
end

function CopyFlipGameMainView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.FlipGameSelect, self._onFlipGameSelect, self)
	GlobalDispatcher:removeListener(GlobalNotify.FlipTouchIncreaseStageTime, self._onIncreaseStageTimeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FlipGameEnd, self.close, self)
	GlobalDispatcher:removeListener(GlobalNotify.SuppressGameToStartGame, self._openStartMask, self)
	removetimer(self._update, self)
	self:_clearContainer()
	self:_removeEffect()
end

function CopyFlipGameMainView:_openStartMask()
	UIStateManager.instance:open(ViewName.SuppressGameStartMask, self._onClickStart, self)
end

function CopyFlipGameMainView:_getRandomNum()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	return math.random(1, 100000000)
end

function CopyFlipGameMainView:_update()
	if self._curState == GameState.Play then
		self:_reduceTime()
		self:_setCountDown(self:_getCountDown())

		if self:_getCountDown() <= 0 then
			self:_setGameState(GameState.Stop)
			self:_onGameOver()
		end
	end
end

function CopyFlipGameMainView:_onClickClose()
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

function CopyFlipGameMainView:_onClickStart()
	self:_onStartGameRes()
end

function CopyFlipGameMainView:_onStartGameRes(msg)
	self:_setGameState(GameState.Play)
end

function CopyFlipGameMainView:_onIntoNextStageRes()
	self:_startNextLevel()
end

function CopyFlipGameMainView:_onIncreaseStageTimeRes(isSuccess)
	if isSuccess then
		FlipGameModel.instance:reduceBuyChance()
		self:_addCountDown(FlipGameModel.instance:getCurLevelAddTime())
		self:_setGameState(GameState.Play)
	else
		self:_setGameState(GameState.End)
		self:_onGameOver()
	end
end

function CopyFlipGameMainView:_setGameState(state)
	self._curState = state

	if state == GameState.NoStart then
		self._btnClickStart.gameObject:SetActive(false)
	else
		self._btnClickStart.gameObject:SetActive(false)
	end
end

function CopyFlipGameMainView:_initContainer()
	self:_clearContainer()

	local totalLevelNum = FlipGameModel.instance._totalLevelNum
	local ramStageId = Mathf.Random(1, totalLevelNum)

	FlipGameModel.instance._curLevel = (ramStageId - 1) % totalLevelNum + 1
	FlipGameModel.instance._curStageId = ramStageId + 1

	local row, column = FlipGameModel.instance:getRowAndColumnNum()

	self:_setTxtTitle(FlipGameModel.instance:getCurLevel())
	self:_setScore(0)
	self:_setCountDown(FlipGameModel.instance:getCurLevelDefaultTime())
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

function CopyFlipGameMainView:_clearContainer()
	FlipGameModel.instance:clearGameState()
	self:_clearTween()
	self:_setMask(false)

	for i, v in ipairs(self._cellInfos) do
		v:reset()
	end

	table.clear(self._cellInfos)
	goutil.clearChildren(self._container)
end

function CopyFlipGameMainView:_fixRow(num)
	self._gridLayoutGroup.constraintCount = num
end

function CopyFlipGameMainView:_onFlipGameSelect()
	self:_clearTween()
	self:_setMask(true)

	if FlipGameModel.instance:isErase() then
		self:_setGameState(GameState.Stop)

		self._tweener = TweenUtil.DoDelay(0.5, function()
			self:_handleGameErase()
		end)
	elseif FlipGameModel.instance:isArriveMaxSelectCount() then
		self._tweener = TweenUtil.DoDelay(0.5, function()
			self:_handleGameSelect()
		end)
	else
		self:_setMask(false)
	end
end

function CopyFlipGameMainView:_clearTween()
	if self._tweener then
		self._tweener:Kill()

		self._tweener = nil
	end

	if self._tweenerLevelEnd then
		self._tweenerLevelEnd:Kill()

		self._tweenerLevelEnd = nil
	end
end

function CopyFlipGameMainView:_handleGameErase()
	FlipGameModel.instance:addGameScore()
	self:_setScore(FlipGameModel.instance:getGameScore())

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
		self:_onGameOver()
	else
		self:_setGameState(GameState.Play)
	end

	self:_setMask(false)
end

function CopyFlipGameMainView:_handleGameSelect()
	local list = FlipGameModel.instance:getSelectIndexList()

	FlipGameModel.instance:clearSelectState()

	for i, v in ipairs(list) do
		if self._cellInfos[v] then
			self._cellInfos[v]:changeToUnSelectState()
		end
	end

	self:_setMask(false)
end

function CopyFlipGameMainView:_onGameOver()
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

function CopyFlipGameMainView:_startNextLevel()
	self:_resetEffectGo()
	self:_setGameState(GameState.Play)
	self:_initContainer()
end

function CopyFlipGameMainView:_openGameOverView()
	local score = FlipGameModel.instance:getGameScore()
	local level = FlipGameModel.instance:getCurLevel()
	local lvCfg = FlipGameModel.instance:getCurLevelCfg()
	local touchEnergy = lvCfg.touchEnergy
	local totalEnergy = score * touchEnergy

	SuppressGameController.instance:_endGameHandle(totalEnergy)
end

function CopyFlipGameMainView:_setMask(active)
	goutil.setActive(self._maskGo, active)
end

function CopyFlipGameMainView:_setTxtTitle(level)
	printInfo("test 设置关卡标题", level, type(level))
	self._imgTitle:SetNum(level)
end

function CopyFlipGameMainView:_setCountDown(countDown)
	self._countDown = countDown
	self._txtCountDown.text = countDown .. "秒"
end

function CopyFlipGameMainView:_reduceTime()
	self._countDown = self._countDown - 1

	if self._countDown >= 0 then
		self._countDown = self._countDown or 0
	end
end

function CopyFlipGameMainView:_getCountDown()
	return self._countDown
end

function CopyFlipGameMainView:_addCountDown(num)
	self._countDown = num
end

function CopyFlipGameMainView:_setScore(score)
	self._txtScore.text = score .. "对"
end

function CopyFlipGameMainView:_loadEffect()
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

function CopyFlipGameMainView:_removeEffect()
	if self._uiEffects then
		for i, v in ipairs(self._uiEffects) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._uiEffects = nil
	end
end

function CopyFlipGameMainView:_updateEffectPos(posList)
	self._effectGo1.transform.position = posList[1]
	self._effectGo2.transform.position = posList[2]

	self._effectGo1:SetActive(false)
	self._effectGo1:SetActive(true)
	self._effectGo2:SetActive(false)
	self._effectGo2:SetActive(true)
end

function CopyFlipGameMainView:_resetEffectGo()
	self._effectGo1:SetActive(false)
	self._effectGo2:SetActive(false)
end

return CopyFlipGameMainView
