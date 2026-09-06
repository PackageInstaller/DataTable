-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat/view/YearCardPreheatGameView.lua

module("logic.extensions.yearcardpreheat.view.YearCardPreheatGameView", package.seeall)

local YearCardPreheatGameView = class("YearCardPreheatGameView", ViewComponent)

function YearCardPreheatGameView:buildUI()
	YearCardPreheatGameView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnStartGame = self:getBtn("btnStartGame")
	self._txtCountDown = self:getTxt("countDown/txtCountDown")
	self._cell = self:getGo("cell")

	self._cell:SetActive(false)

	self._container = self:getGo("container")
	self._gridLayoutGroup = self._container:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._btnMask = self:getBtn("mask")
	self._result = goutil.findChildComponent(self._btnMask.gameObject, "result", "UIImageSpriteChange")
	self._mask = self:getGo("mask_click")
end

function YearCardPreheatGameView:bindEvents()
	YearCardPreheatGameView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.onClickClose, self)
	self._btnMask:AddClickListener(self.onClickClose, self)
	self._btnStartGame:AddClickListener(self.onClickStart, self)
end

function YearCardPreheatGameView:unbindEvents()
	YearCardPreheatGameView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnMask:RemoveClickListener()
	self._btnStartGame:RemoveClickListener()
end

function YearCardPreheatGameView:onEnter()
	YearCardPreheatGameView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.YearCardPreheatSelectCard, self._onSelectCard, self)
	GlobalDispatcher:addListener(GlobalNotify.YearCardPreheatGameStart, self._onGameStart, self)
	GlobalDispatcher:addListener(GlobalNotify.YearCardPreheatGameEnd, self._onGameEnd, self)
	GlobalDispatcher:addListener(GlobalNotify.YearCardPreheatError, self._onError, self)
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._btnClose.gameObject, true)
	settimer(1, self._timeUpdate, self)

	self._curActId = YearCardPreheatModel.instance:getCurActId()
	self._gameCfg = self:getFirstParam()

	if not self._gameCfg then
		printError("传参错误")

		return
	end

	self:resetGameState()
end

function YearCardPreheatGameView:onExit()
	YearCardPreheatGameView.super.onExit(self)
	removetimer(self._timeUpdate, self)
	removetimer(self._handleSelectCard, self)
	GlobalDispatcher:removeListener(GlobalNotify.YearCardPreheatSelectCard, self._onSelectCard, self)
	GlobalDispatcher:removeListener(GlobalNotify.YearCardPreheatGameStart, self._onGameStart, self)
	GlobalDispatcher:removeListener(GlobalNotify.YearCardPreheatGameEnd, self._onGameEnd, self)
	GlobalDispatcher:removeListener(GlobalNotify.YearCardPreheatError, self._onError, self)
	YearCardPreheatModel.instance:showCI()
	self:_removeAllEffect()
end

function YearCardPreheatGameView:_onError(status)
	self:close()
end

function YearCardPreheatGameView:_createEff(effPath, effParent, effKey, isLoop)
	self._exictEffs = self._exictEffs or {}

	if not effParent then
		return
	end

	local exictEff = self._exictEffs[effKey]

	if exictEff then
		UIEffectManager.instance:stopEffect(exictEff)

		self._exictEffs[effKey] = nil
	end

	self._exictEffs[effKey] = UIEffectManager.instance:playEffect(self, effPath, effParent.transform, 0, 0, isLoop, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
		eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
	end)
end

function YearCardPreheatGameView:_removeAllEffect()
	if self._exictEffs then
		for _, eff in pairs(self._exictEffs) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._exictEffs = nil
	end
end

function YearCardPreheatGameView:_removeEffect(key)
	if self._exictEffs then
		if self._exictEffs then
			UIEffectManager.instance:stopEffect(self._exictEffs)

			self._exictEffs[key] = nil
		end
	end
end

function YearCardPreheatGameView:onClickClose()
	self:close()
end

function YearCardPreheatGameView:onClickStart()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	local _clinetKey = math.random(1, 100000000)

	AnnualFeePreheatAgent.instance:sendPM_AnnualFeeStartGameReq(self._curActId, _clinetKey)
end

local GameState = {
	Play = 1,
	NoStart = 0,
	End = 3,
	Stop = 2
}

function YearCardPreheatGameView:resetGameState()
	self._curState = GameState.NoStart
	self._countDown = 0
	self._row = self._gameCfg.cardNum[1] or 1
	self._column = self._gameCfg.cardNum[2] or 2
	self._totalCount = self._row * self._column
	self._curCardCount = self._totalCount
	self._lastSelectId = -1
	self._lastSelectCell = nil
	self._curSelectCell = nil
	self._totalCountDown = self._gameCfg.defaultTime
	self._randomCardList = self:getRandomCardList()

	self:initGameView()
end

function YearCardPreheatGameView:getRandomCardList()
	local cardList = {}
	local cfg = self._gameCfg

	if cfg then
		cardList = self:_addToCardList(cfg.iconNum1, cardList)
		cardList = self:_addToCardList(cfg.iconNum2, cardList)
		cardList = self:_addToCardList(cfg.iconNum3, cardList)
		cardList = self:_addToCardList(cfg.iconNum4, cardList)
		cardList = self:_addToCardList(cfg.iconNum5, cardList)
	else
		for i = 1, self._totalCount do
			table.insert(cardList, 0)
		end
	end

	return self:_randomSort(cardList)
end

function YearCardPreheatGameView:_randomSort(cardList)
	local maxCount = #cardList

	math.randomseed(os.time())

	for i = 1, maxCount do
		local randomNum = math.random(i, maxCount)

		cardList[i] = cardList[randomNum]
		cardList[randomNum] = cardList[i]
	end

	return cardList
end

function YearCardPreheatGameView:_addToCardList(params, cardList)
	if not params then
		return cardList
	end

	local iconNum = checkint(params[1])
	local id = checkint(params[2])

	if iconNum <= 0 then
		return cardList
	end

	local iconNum = iconNum % 2 == 0 and iconNum or iconNum + 1

	for i = 1, iconNum do
		table.insert(cardList, id)
	end

	return cardList
end

local ViewParams = {
	{
		scale = 0.55,
		spcY = -110,
		bottom = 0,
		spcX = -30
	},
	{
		scale = 0.42,
		spcY = -200,
		bottom = -20,
		spcX = -80
	},
	{
		scale = 0.3,
		spcY = -240,
		bottom = -20,
		spcX = -100
	}
}

function YearCardPreheatGameView:initGameView()
	local stateId = self._gameCfg.stageId

	self._isAbleToClick = true

	self:_clearViewState()
	self:_setCountDown(self._totalCountDown)
	goutil.setActive(self._btnStartGame.gameObject, true)

	self._gridLayoutGroup.constraintCount = self._row
	self._gridLayoutGroup.padding.bottom = ViewParams[stateId].bottom
	self._gridLayoutGroup.spacing = Vector2.New(ViewParams[stateId].spcX, ViewParams[stateId].spcY)

	local randomList = self:getRandomCardList()

	self._cellInfos = {}

	for i = 1, self._totalCount do
		local go = goutil.cloneAndSetParent(self._cell, self._container.transform, "cell_" .. tostring(i))

		go:SetActive(true)
		GameUtil.setLocalScale(go, ViewParams[stateId].scale, ViewParams[stateId].scale, ViewParams[stateId].scale)

		local cellInfo = GameUtil.AddLuaOnce(go, YearCardPreheatGameItem)
		local id = randomList[i]

		cellInfo:buildUI(go)
		cellInfo:init(id)
		table.insert(self._cellInfos, cellInfo)
	end

	goutil.setActive(self._mask, false)
end

function YearCardPreheatGameView:_setCountDown(countDown)
	self._countDown = countDown
	self._txtCountDown.text = countDown .. "秒"
end

function YearCardPreheatGameView:_reduceTime()
	self._countDown = self._countDown - 1

	if self._countDown >= 0 then
		self._countDown = self._countDown or 0
	end
end

function YearCardPreheatGameView:_timeUpdate()
	if self._curState == GameState.Play then
		self:_reduceTime()
		self:_setCountDown(self._countDown)

		if self._countDown <= 0 then
			self:_onGameOver(false)
		end
	end
end

function YearCardPreheatGameView:_clearViewState()
	for i, v in ipairs(self._cellInfos or {}) do
		v:reset()
	end

	table.clear(self._cellInfos)
	goutil.clearChildren(self._container)
end

function YearCardPreheatGameView:_onSelectCard(cellInfo)
	if not self._isAbleToClick or self._curState ~= GameState.Play then
		return
	end

	self._isAbleToClick = false

	goutil.setActive(self._mask, true)

	if self._lastSelectId == -1 then
		self._lastSelectId = cellInfo._id
		self._lastSelectCell = cellInfo
	elseif self._lastSelectId == cellInfo._id then
		self._lastSelectId = -1

		for _, v in ipairs(self._cellInfos) do
			v:updateMatch(true)
		end

		self._curSelectCell = cellInfo
		self._curCardCount = self._curCardCount - 2

		if self._curCardCount <= 0 then
			self:_onGameOver(true)
		end
	else
		self._lastSelectId = -1

		for _, v in ipairs(self._cellInfos) do
			v:updateMatch(false)
		end

		self._lastSelectCell = nil
		self._curSelectCell = nil
	end

	removetimer(self._handleSelectCard, self)
	settimer(0.6, self._handleSelectCard, self, false)
end

function YearCardPreheatGameView:_handleSelectCard()
	for _, v in ipairs(self._cellInfos) do
		v:updateState()
	end

	local path = "fx_ui_dianliangmengzhidui/fx_ui_xiaochu_mzd.prefab"

	if self._lastSelectCell and self._curSelectCell then
		self:_createEff(path, self._lastSelectCell._go, "resultEff1", false)
		self:_createEff(path, self._curSelectCell._go, "resultEff2", false)

		self._lastSelectCell = nil
		self._curSelectCell = nil
	end

	goutil.setActive(self._mask, false)

	self._isAbleToClick = true
end

function YearCardPreheatGameView:_onGameStart()
	for _, v in ipairs(self._cellInfos) do
		v:setGamePlayState(true)
	end

	goutil.setActive(self._btnStartGame.gameObject, false)
	goutil.setActive(self._btnClose.gameObject, false)

	self._curState = GameState.Play

	UIStateManager.instance:popByName(ViewName.YearCardPreheatGameEnterView)
end

function YearCardPreheatGameView:_onGameOver(isWin)
	self._curState = GameState.End

	for _, v in ipairs(self._cellInfos) do
		v:setGamePlayState(false)
	end

	self._isWin = isWin and 1 or 0

	AnnualFeePreheatAgent.instance:sendPM_AnnualFeeEndGameReq(self._curActId, self._isWin, self._gameCfg.stageId, GameUtil.getClientEncryptedKey(YearCardPreheatModel.instance.clientKey, YearCardPreheatModel.instance.serverKey, {
		self._isWin,
		self._gameCfg.stageId
	}))
end

function YearCardPreheatGameView:_onGameEnd()
	self._result:SetState(self._isWin)
	self:_createEff((self._isWin == 0 or nil) and "20211217/nianfei/fx_ui_nfyr_jiemichenggong2.prefab", self._btnMask.gameObject, "resultEff", true)
	goutil.setActive(self._btnMask.gameObject, true)
end

return YearCardPreheatGameView
