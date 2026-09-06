-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/FlipGameMainView.lua

module("logic.extensions.dreamteam.view.FlipGameMainView", package.seeall)

local FlipGameMainView = class("FlipGameMainView", ViewComponent)
local GameState = {
	Play = 1,
	NoStart = 0,
	End = 4,
	LevelEnd = 3,
	Stop = 2
}

function FlipGameMainView:ctor()
	self._cellInfos = {}
	self._curState = GameState.NoStart
	self._countDown = 0
end

function FlipGameMainView:buildUI()
	self._closeButton = self:getGo("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._closebg = self:getGo("closebg")
	self._imgTitle = self:getGo("title/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._txtScore = self:getTxt("score/txtScore")
	self._txtCountDown = self:getTxt("countDown/txtCountDown")
	self._bg = self:getGo("bg")
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

function FlipGameMainView:bindEvents()
	GameUtil.addClickHandler(self._closeButton, self._onClickClose, self)
	self._btnClickStart:AddClickListener(self._onClickStart, self)
end

function FlipGameMainView:unbindEvents()
	GameUtil.rmClickHandler(self._closeButton)
	self._btnClickStart:RemoveClickListener()
end

function FlipGameMainView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.FlipGameSelect, self._onFlipGameSelect, self)
	GlobalDispatcher:addListener(GlobalNotify.FlipTouchStartGame, self._onStartGameRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FlipTouchIntoNextStage, self._onIntoNextStageRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FlipTouchIncreaseStageTime, self._onIncreaseStageTimeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FlipGameEnd, self.close, self)
	self:_resetEffectGo()
	self:_loadEffect()

	self._activityId = self:getFirstParam()
	self._clientKey = self:_getRandomNum()
	self._clientEncryptedKey = 0

	self:_setGameState(GameState.NoStart)

	self._actData = DreamTeamConfig.instance:getActivityCfgById(self._activityId)

	if self._actData then
		self._planId = self._actData.planId or 0
	end

	if self._actData then
		self._isHideExit = self._actData.isHideExit or true
	end

	settimer(1, self._update, self)
	FlipGameModel.instance:onInit()
	FlipGameModel.instance:setLevelList(self._planId)

	self._cellInfos = {}

	self:_initContainer()
end

function FlipGameMainView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.FlipGameSelect, self._onFlipGameSelect, self)
	GlobalDispatcher:removeListener(GlobalNotify.FlipTouchStartGame, self._onStartGameRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FlipTouchIntoNextStage, self._onIntoNextStageRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FlipTouchIncreaseStageTime, self._onIncreaseStageTimeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FlipGameEnd, self.close, self)
	removetimer(self._update, self)
	self:_clearContainer()
	self:_removeEffect()
	FlipGameModel.instance:resetFlipExMo()
end

function FlipGameMainView:_getRandomNum()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	return math.random(1, 100000000)
end

function FlipGameMainView:_update()
	if self._curState == GameState.Play then
		self:_reduceTime()
		self:_setCountDown(self:_getCountDown())

		if self:_getCountDown() <= 0 then
			self:_setGameState(GameState.Stop)
			self:_onGameOver()
		end
	end
end

function FlipGameMainView:_onClickClose()
	if self._curState ~= GameState.NoStart then
		self:_setGameState(GameState.Stop)
	end

	local text = self._actData.closeTipsDesc

	if string.nilorempty(text) then
		text = "你确定要现在退出游戏吗？\n\n现在退出将立即进行结算哦"
	end

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

function FlipGameMainView:_onClickStart()
	printInfo("test 随机数", self._clientKey)
	FlipTouchAgent.instance:sendPM_FlipTouchStartGameReq(self._activityId, self._clientKey)
end

function FlipGameMainView:_onStartGameRes(msg)
	self._clientEncryptedKey = msg.encryptedKey

	self:_setGameState(GameState.Play)
end

function FlipGameMainView:_onIntoNextStageRes()
	self:_startNextLevel()
end

function FlipGameMainView:_onIncreaseStageTimeRes(isSuccess)
	if isSuccess then
		FlipGameModel.instance:reduceBuyChance()
		self:_addCountDown(FlipGameModel.instance:getCurLevelAddTime())
		self:_setGameState(GameState.Play)
	else
		self:_setGameState(GameState.End)
		self:_onGameOver()
	end
end

function FlipGameMainView:_setGameState(state)
	self._curState = state

	if state == GameState.NoStart then
		self._btnClickStart.gameObject:SetActive(true)
	else
		self._btnClickStart.gameObject:SetActive(false)
	end
end

function FlipGameMainView:_initContainer()
	self:_clearContainer()
	FlipGameModel.instance:setNextLevel()

	local curLevel = FlipGameModel.instance:getCurLevel()
	local interactionData = DreamTeamConfig.instance:getInteractionCfg(self._planId, curLevel)
	local row, column = FlipGameModel.instance:getRowAndColumnNum()

	self:_setTxtTitle(curLevel)
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

	local path = string.format("ui/bigbg/%s", "operationsummary/bg_nsds")

	self:_loadBigBg(self._bg, (interactionData and not string.nilorempty(interactionData.bgPath) or nil) and string.format("ui/bigbg/%s", interactionData.bgPath), true)
	self:_updateVisualExit(not self._isHideExit)
end

function FlipGameMainView:_clearContainer()
	FlipGameModel.instance:clearGameState()
	self:_clearTween()
	self:_setMask(false)

	for i, v in ipairs(self._cellInfos) do
		v:reset()
	end

	table.clear(self._cellInfos)
	goutil.clearChildren(self._container)
	self:_unLoadBigBg(self._bg)
end

function FlipGameMainView:_fixRow(num)
	self._gridLayoutGroup.constraintCount = num
end

function FlipGameMainView:_onFlipGameSelect()
	self:_clearTween()
	self:_setMask(true)

	if FlipGameModel.instance:isErase() then
		self:_setGameState(GameState.Stop)

		self._tweener = TweenUtil.DoDelay(0.2, function()
			self:_handleGameErase()
		end)
	elseif FlipGameModel.instance:isArriveMaxSelectCount() then
		self._tweener = TweenUtil.DoDelay(0.2, function()
			self:_handleGameSelect()
		end)
	else
		self:_setMask(false)
	end
end

function FlipGameMainView:_clearTween()
	if self._tweener then
		self._tweener:Kill()

		self._tweener = nil
	end

	if self._tweenerLevelEnd then
		self._tweenerLevelEnd:Kill()

		self._tweenerLevelEnd = nil
	end
end

function FlipGameMainView:_handleGameErase()
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

function FlipGameMainView:_handleGameSelect()
	local list = FlipGameModel.instance:getSelectIndexList()

	FlipGameModel.instance:clearSelectState()

	for i, v in ipairs(list) do
		if self._cellInfos[v] then
			self._cellInfos[v]:changeToUnSelectState()
		end
	end

	self:_setMask(false)
end

function FlipGameMainView:_onGameOver()
	if self._curState == GameState.End then
		FlipGameModel.instance:addToTotalGameScore()
		self:_endGame()
	elseif FlipGameModel.instance:isArrivedMaxEraseCount() then
		self:_setGameState(GameState.LevelEnd)
		FlipGameModel.instance:addToTotalGameScore()

		self._tweenerLevelEnd = TweenUtil.DoDelay(0.5, function()
			if FlipGameModel.instance:isHaveNextLevel() then
				local score = FlipGameModel.instance:getGameScore()
				local nextLevel = FlipGameModel.instance:getNextLevel()
				local key = bit.bxor(self._clientEncryptedKey, score)

				FlipTouchAgent.instance:sendPM_FlipTouchIntoNextStageReq(self._activityId, score, nextLevel, key)
			else
				self:_endGame()
			end
		end)
	else
		local cfg = FlipGameModel.instance:getCurLevelCfg()
		local isCanBuy = cfg and not string.nilorempty(cfg.cost) or false

		if isCanBuy and FlipGameModel.instance:isHaveBuyChance() then
			local curDiamondNum = RoleModel.instance:getTotalDiamond()
			local needDiamondNum = 0

			if cfg then
				local list = string.split(cfg.cost, ":")

				needDiamondNum = checknumber(list[3])
			end

			local timeNum = FlipGameModel.instance:getCurLevelAddTime()

			if needDiamondNum <= curDiamondNum then
				local content = string.format("是否消耗%d钻石增加%d秒游戏时间？\n每关可增加1次！", needDiamondNum, timeNum)

				local function sureFunc()
					local curLevel = FlipGameModel.instance:getCurLevel()

					FlipTouchAgent.instance:sendPM_FlipTouchIncreaseStageTimeReq(self._activityId, curLevel)
				end

				local function cancelFunc(state)
					if state == TipsFacade.STATE_CANCEL or state == TipsFacade.STATE_FAIL then
						FlipGameModel.instance:addToTotalGameScore()
						self:_endGame()
					end
				end

				TipsFacade.instance:openPopupCostDiamondView(needDiamondNum, content, sureFunc, nil, nil, UnityEngine.TextAnchor.MiddleCenter, cancelFunc)
			else
				FlipGameModel.instance:addToTotalGameScore()
				self:_endGame()
			end
		else
			FlipGameModel.instance:addToTotalGameScore()
			self:_endGame()
		end
	end
end

function FlipGameMainView:_startNextLevel()
	self:_resetEffectGo()
	self:_setGameState(GameState.Play)
	self:_initContainer()
end

function FlipGameMainView:_endGame()
	local score = FlipGameModel.instance:getGameScore()
	local key = bit.bxor(self._clientEncryptedKey, score)

	FlipTouchAgent.instance:sendPM_FlipTouchEndGameReq(self._activityId, score, key)

	local info = {
		handler = self,
		score = FlipGameModel.instance:getGameScore(),
		key = bit.bxor(self._clientEncryptedKey, score)
	}

	FlipGameModel.instance:getFlipExMo():openGameOverOfFlipExMo(info)
end

function FlipGameMainView:_setMask(active)
	goutil.setActive(self._maskGo, active)
end

function FlipGameMainView:_setTxtTitle(level)
	printInfo("test 设置关卡标题", level, type(level))
	self._imgTitle:SetNum(level)
end

function FlipGameMainView:_setCountDown(countDown)
	self._countDown = countDown
	self._txtCountDown.text = countDown .. "秒"
end

function FlipGameMainView:_reduceTime()
	self._countDown = self._countDown - 1

	if self._countDown >= 0 then
		self._countDown = self._countDown or 0
	end
end

function FlipGameMainView:_getCountDown()
	return self._countDown
end

function FlipGameMainView:_addCountDown(num)
	self._countDown = num
end

function FlipGameMainView:_setScore(score)
	self._txtScore.text = score .. "对"
end

function FlipGameMainView:_loadEffect()
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

function FlipGameMainView:_removeEffect()
	if self._uiEffects then
		for i, v in ipairs(self._uiEffects) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._uiEffects = nil
	end
end

function FlipGameMainView:_updateEffectPos(posList)
	self._effectGo1.transform.position = posList[1]
	self._effectGo2.transform.position = posList[2]

	self._effectGo1:SetActive(false)
	self._effectGo1:SetActive(true)
	self._effectGo2:SetActive(false)
	self._effectGo2:SetActive(true)
end

function FlipGameMainView:_resetEffectGo()
	self._effectGo1:SetActive(false)
	self._effectGo2:SetActive(false)
end

function FlipGameMainView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function FlipGameMainView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function FlipGameMainView:_updateVisualExit(isCanExit)
	GameUtil.SetActive(self._closeButton, isCanExit)
	GameUtil.SetActive(self._txtTitle.gameObject, isCanExit)
	GameUtil.SetActive(self._closebg, isCanExit)
end

return FlipGameMainView
