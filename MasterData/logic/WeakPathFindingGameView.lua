-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/view/WeakPathFindingGameView.lua

module("logic.extensions.weakpathfinding.view.WeakPathFindingGameView", package.seeall)

local WeakPathFindingGameView = class("WeakPathFindingGameView", ViewComponent)

function WeakPathFindingGameView:buildUI()
	WeakPathFindingGameView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnStart = self:getGo("btnStart")
	self._goCountdown = self:getGo("countdown")
	self._txtCountDown = self:getTxt("countdown/txt")
	self._txtPieces = self:getTxt("pieces/txt")
	self._txtCurScore = self:getTxt("curScore/txt")
	self._txtMinScore = self:getTxt("minScore/txt")
	self._txtMaxScore = self:getTxt("maxScore/txt")
	self._goCurScore = self:getGo("curScore")
	self._goMinScore = self:getGo("minScore")
	self._goMaxScore = self:getGo("maxScore")
	self._goPieces = self:getGo("pieces")
	self._btnAddScores = {}

	for i = 1, 6 do
		local cell = {}

		cell.btn = self:getGo("addScore/btn_" .. i)
		cell.txt = goutil.findChildTextComponent(cell.btn, "txtAdd")
		cell.addScore = 0
		cell.isPlayEff = false
		self._btnAddScores[i] = cell
	end

	self._petCon = self:getGo("mid/petcon")
	self._effPos = self:getGo("effPos")
	self._targetPos = self:getGo("mid/effpos").transform
end

function WeakPathFindingGameView:bindEvents()
	WeakPathFindingGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)

	for i = 1, 6 do
		GameUtil.addClickHandler(self._btnAddScores[i].btn, GameUtil.handler(self._onClickAddScore, self, i))
	end
end

function WeakPathFindingGameView:unbindEvents()
	WeakPathFindingGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)

	for i = 1, 6 do
		GameUtil.rmClickHandler(self._btnAddScores[i].btn)
	end
end

function WeakPathFindingGameView:onEnter()
	WeakPathFindingGameView.super.onEnter(self)
	self:resetGameState()
	GlobalDispatcher:addListener(GlobalNotify.WeakPathFindingGameStart, self.startGame, self)
	GlobalDispatcher:addListener(GlobalNotify.WeakPathFindingGameEnd, self._handleResult, self)

	self._curNpcCfg = WeakPathFindingConfig.instance:getNpcCfg(WeakPathFindingModel.instance:getCurSceneId(), WeakPathFindingModel.instance:getCurNpcTemId())

	if self._curNpcCfg then
		self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, self._curNpcCfg.raceId, self._petCon, self._curNpcCfg.scale, nil, false)

		GameUtil.setAnchoredPos(self._petCon, self._curNpcCfg.pos[1] or 0, self._curNpcCfg.pos[2] or 0)
	end

	local userData = checkint(GameUtil.getUserData("weakpathfindingruleview"))

	if userData + 1 < #WeakPathFindingConfig.instance:getRuleCfgs() then
		UIStateManager.instance:push(ViewName.WeakPathFindingRuleView)
	end

	self:_createEff("fx_scene_zhengjiuxuruojingling/fx_ui_jiemianfengwei.prefab", self._effPos, "mainEff", true)
end

function WeakPathFindingGameView:onExit()
	WeakPathFindingGameView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.WeakPathFindingGameStart, self.startGame, self)
	GlobalDispatcher:removeListener(GlobalNotify.WeakPathFindingGameEnd, self._handleResult, self)
	removetimer(self._onCountDown, self)

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	self:_removeAllEffect()
	removetimer(self._removeLastEff, self)
end

function WeakPathFindingGameView:_onClickClose()
	if self._curGameState == 1 then
		FloatWordMgr.instance:show("游戏进行中")

		return
	else
		self:close()

		if self._curResult == 0 then
			UIStateManager.instance:push(ViewName.WeakPathFindingMainView)
		end
	end
end

function WeakPathFindingGameView:_onClickTip()
	if self._curGameState == 1 then
		FloatWordMgr.instance:show("游戏进行中")

		return
	else
		UIStateManager.instance:push(ViewName.WeakPathFindingRuleView)
	end
end

function WeakPathFindingGameView:_onClickStart()
	WeakPathFindingController.instance:startGame()
end

function WeakPathFindingGameView:_onClickAddScore(id)
	if self._curGameState == 1 then
		if self._btnAddScores[id].isPlayEff then
			return
		end

		self._btnAddScores[id].isPlayEff = true

		self:_onAddScore(self._btnAddScores[id].addScore)
		goutil.setActive(self._btnAddScores[id].btn, false)

		self._lastEff = self:_createEff("fx_scene_zhengjiuxuruojingling/fx_ui_tuoweiguiji.prefab", self._btnAddScores[id].btn.gameObject, "moveEff" .. id, false, nil, nil, self._targetPos)

		self:_createEff("fx_scene_zhengjiuxuruojingling/fx_ui_tishi.prefab", self._txtCurScore.gameObject, "addEff", false)
		settimer(0.8, self._removeLastEff, self, false)
	else
		return
	end
end

function WeakPathFindingGameView:_removeLastEff()
	if self._lastEff then
		UIEffectManager.instance:stopEffect(self._lastEff)
	end

	self._lastEff = nil
end

function WeakPathFindingGameView:resetGameState()
	for i = 1, 6 do
		goutil.setActive(self._btnAddScores[i].btn, false)
	end

	goutil.setActive(self._goCurScore, false)
	goutil.setActive(self._goMaxScore, false)
	goutil.setActive(self._goMinScore, false)
	goutil.setActive(self._goPieces, false)
	goutil.setActive(self._goCountdown, false)

	self._txtCountDown.text = langPara("%d秒", 0)
	self._txtCurScore.text = ""
	self._txtMinScore.text = ""
	self._txtMaxScore.text = ""
	self._txtPieces.text = langPara("%d片", 0)

	goutil.setActive(self._btnStart, true)

	self._curGameState = 0
	self._isOverTime = false
	self._curGameId = 0
	self._gameCfg = nil
	self._curScore = 0
	self._scoreList = {}
	self._maxScore = 0
	self._minScore = 0
	self._curPiecesNum = 0
	self._curResult = 1

	removetimer(self._onCountDown, self)
end

function WeakPathFindingGameView:startGame()
	self._actId = WeakPathFindingModel.instance:getCurActId()
	self._curGameState = 1

	goutil.setActive(self._btnStart, false)

	self._curGameStartTime = WeakPathFindingModel.instance:getCurGameStartTime()
	self._curGameId = WeakPathFindingModel.instance:getCurGameId()
	self._gameCfg = WeakPathFindingConfig.instance:getGameCfg(self._actId, self._curGameId)
	self._curGameEndTime = self._curGameStartTime + self._gameCfg.countdown * 1000

	self:setGameData()
	goutil.setActive(self._goCurScore, true)
	goutil.setActive(self._goMaxScore, true)
	goutil.setActive(self._goMinScore, true)
	goutil.setActive(self._goCountdown, true)
	self:_onCountDown()
	settimer(0.5, self._onCountDown, self, true)
end

function WeakPathFindingGameView:endGame()
	self._curGameState = 2

	removetimer(self._onCountDown, self)
	WeakPathFindingController.instance:endGame(self._scoreList, self._curResult == 0)
end

function WeakPathFindingGameView:setGameData()
	self._maxScore = self._gameCfg.targetMax
	self._minScore = self._gameCfg.targetMin
	self._curPiecesNum = self._gameCfg.debrisNum
	self._txtMaxScore.text = self._maxScore
	self._txtMinScore.text = self._minScore

	if not self._gameCfg.debris then
		for i = 1, 6 do
			if self._gameCfg.debris[i] then
				self._btnAddScores[i].addScore = self._gameCfg.debris[i]
				self._btnAddScores[i].txt.text = self._gameCfg.debris[i]
				self._btnAddScores[i].isPlayEff = false

				goutil.setActive(self._btnAddScores[i].btn, true)
			end
		end

		self:refreshGameData()
	end
end

function WeakPathFindingGameView:refreshGameData()
	self._txtCurScore.text = self._curScore
	self._txtPieces.text = langPara("%s", self._curPiecesNum)

	goutil.setActive(self._goPieces, self._curPiecesNum < 10)
end

function WeakPathFindingGameView:_onCountDown()
	local leftTime = self._curGameEndTime - ServerTime.now() * 1000

	if leftTime >= 0 then
		self._txtCountDown.text = langPara("%s秒", checkint(leftTime / 1000))
	else
		self:_onTimeOver()
	end
end

function WeakPathFindingGameView:_onTimeOver()
	self._curResult = 2

	self:endGame()
end

function WeakPathFindingGameView:_onWin()
	self._curResult = 0

	self:endGame()
end

function WeakPathFindingGameView:_onFail()
	self._curResult = 1

	self:endGame()
end

function WeakPathFindingGameView:_checkIsWin()
	return self._curScore <= self._maxScore and self._curScore >= self._minScore
end

function WeakPathFindingGameView:_checkIsUsePiece()
	return self._curPiecesNum <= 0
end

function WeakPathFindingGameView:_checkIsScoreOver()
	return self._curScore > self._maxScore
end

function WeakPathFindingGameView:_onAddScore(score)
	if self._curGameState ~= 1 then
		return
	end

	self._curScore = self._curScore + score
	self._curPiecesNum = self._curPiecesNum - 1

	self:refreshGameData()
	table.insert(self._scoreList, score)

	if self:_checkIsScoreOver() then
		self:_onFail()

		return
	end

	if self:_checkIsWin() then
		self:_onWin()

		return
	end

	if self:_checkIsUsePiece() then
		self:_onFail()
	end
end

function WeakPathFindingGameView:_handleResult()
	self._curResult = WeakPathFindingModel.instance:getCurResult()

	local text = lang("恭喜你成功为这只精灵注入能量，快去拯救下一只精灵吧！")

	if self._curResult == 1 then
		text = lang("为这只精灵注入能量失败，去继续追踪别的精灵，帮助他们吧！")
	elseif self._curResult == 2 then
		text = lang("为这只精灵注入能量失败，去继续追踪别的精灵，帮助他们吧！")
	end

	TipsFacade.instance:openTipWindowNoX("提示", text, function()
		self:close()
		UIStateManager.instance:push(ViewName.WeakPathFindingMainView)
	end)
end

function WeakPathFindingGameView:_createEff(effPath, effParent, effKey, isLoop, clipRect, finishHandler, movePos)
	self._exictEffs = self._exictEffs or {}
	self._tweenList = self._tweenList or {}

	if not effParent then
		return
	end

	local exictEff = self._exictEffs[effKey]

	if exictEff then
		UIEffectManager.instance:stopEffect(exictEff)

		self._exictEffs[effKey] = nil
	end

	local newEff = UIEffectManager.instance:playEffect(self, effPath, effParent.transform, 0, 0, isLoop, false, finishHandler, function(target, eff)
		eff.effGo.transform:SetParent(effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

		if clipRect then
			eff:setClipping(clipRect)
		end

		if movePos then
			eff.effGo.transform:SetParent(movePos)

			local tween = eff.effGo.transform:DOMove(movePos.position, 0.5)

			table.insert(self._tweenList, tween)
		end
	end)

	self._exictEffs[effKey] = newEff

	return newEff
end

function WeakPathFindingGameView:_removeAllEffect()
	if self._exictEffs then
		for _, eff in pairs(self._exictEffs) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._exictEffs = nil
	end

	if self._tweenList then
		for i, v in ipairs(self._tweenList) do
			v:Kill()
		end

		self._tweenList = nil
	end
end

function WeakPathFindingGameView:_removeEffect(key)
	if self._exictEffs then
		if self._exictEffs then
			UIEffectManager.instance:stopEffect(self._exictEffs)

			self._exictEffs[key] = nil
		end
	end
end

return WeakPathFindingGameView
