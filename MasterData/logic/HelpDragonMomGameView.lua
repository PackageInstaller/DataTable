-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/view/HelpDragonMomGameView.lua

module("logic.extensions.helpdragonmom.view.HelpDragonMomGameView", package.seeall)

local HelpDragonMomGameView = class("HelpDragonMomGameView", ViewComponent)

function HelpDragonMomGameView:ctor()
	HelpDragonMomGameView.super.ctor(self)
end

function HelpDragonMomGameView:buildUI()
	HelpDragonMomGameView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnLeft = self:getBtn("btnLeft")
	self._btnRight = self:getBtn("btnRight")
	self._btnStartGame = self:getBtn("btnStartGame")
	self._leftTop = self:getGo("leftTop")

	goutil.setActive(self._leftTop, false)

	self._txtCountdown = self:getTxt("txtCountdown")
	self._txtNum = self:getTxt("txtNum")
	self._txtDesc = self:getTxt("txtDesc")
	self._showTipGo = self:getGo("showTip")
	self._mainImg = self:getGo("showTip/mainImg")
	self._txtImgDesc = self:getTxt("showTip/txtImgDesc")
	self._btnCloseTip = self:getBtn("showTip/btnCloseTip")
	self._leftChuizi = self:getGo("chuizi/left"):GetComponent(ComponentType.Animator)
	self._rightChuizi = self:getGo("chuizi/right"):GetComponent(ComponentType.Animator)
	self._leftEffect = self:getGo("btnLeft/effect")
	self._rightEffect = self:getGo("btnRight/effect")
	self._effectParent = self:getGo("effect")
	self._randomAreaRectTrans = self:getGo("randomArea"):GetComponent(goutil.Type_RectTransform)

	local width = goutil.getWidth(self._randomAreaRectTrans)
	local height = goutil.getHeight(self._randomAreaRectTrans)

	self._xMax = width * 0.5
	self._xMin = self._xMax * -1
	self._yMax = height * 0.5
	self._yMin = self._yMax * -1
end

function HelpDragonMomGameView:bindEvents()
	HelpDragonMomGameView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnLeft:AddClickListener(self._onClickLeft, self)
	self._btnRight:AddClickListener(self._onClickRight, self)
	self._btnStartGame:AddClickListener(self._onClickStartGame, self)
	self._btnCloseTip:AddClickListener(self._onClickCloseTip, self)
end

function HelpDragonMomGameView:unbindEvents()
	HelpDragonMomGameView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnStartGame:RemoveClickListener()
	self._btnCloseTip:RemoveClickListener()
end

function HelpDragonMomGameView:onEnter()
	HelpDragonMomGameView.super.onEnter(self)

	self._activityId = HelpDragonMomModel.instance:getActivityId()
	self._cfgActivity = HelpDragonMomConfig.instance:getActivityCfg(self._activityId)
	self._scoreCfgs = HelpDragonMomConfig.instance:getScoreCfgList(self._cfgActivity.scoreAddPlanId)
	self._curGameScore = 0
	self._isPlaying = false

	self:_initShowTip()
	self:_initStartGameGo()
	self:_initOthers()
	self:_playBtnEffect()
	settimer(0, self._onUpdate, self)
end

function HelpDragonMomGameView:onExit()
	HelpDragonMomGameView.super.onExit(self)
	removetimer(self._onUpdate, self)
	self:_saveScoreReq()
	self:_removeStoneEffect()
	self:_removeBtnEffect()
end

function HelpDragonMomGameView:_onClickClose()
	self:_endGame()
end

function HelpDragonMomGameView:_onClickLeft()
	self:_setCurGameScore()
	self._leftChuizi:Play("chuiziqiaoji", 0, 0)
end

function HelpDragonMomGameView:_onClickRight()
	self:_setCurGameScore()
	self._rightChuizi:Play("chuiziqiaoji", 0, 0)
end

function HelpDragonMomGameView:_onClickStartGame()
	self:_startGame()
end

function HelpDragonMomGameView:_onClickCloseTip()
	goutil.setActive(self._showTipGo, false)
end

function HelpDragonMomGameView:_onUpdate()
	if self._isPlaying then
		if self._curCountdown > -0.5 then
			self._curCountdown = self._curCountdown - Time.deltaTime
			self._txtCountdown.text = string.format("%d秒", Mathf.Ceil(self._curCountdown))
			self._txtNum.text = string.format("%d", self._curGameScore)
		else
			self:_endGame()
		end
	end
end

function HelpDragonMomGameView:_initShowTip()
	local isShowed = GameUtil.getUserData(ViewName.HelpDragonMomGameView)

	if not isShowed then
		GameUtil.saveUserData(ViewName.HelpDragonMomGameView, true)
		goutil.setActive(self._showTipGo, true)

		local cfg = HelpDragonMomConfig.instance:getRuleCfg(1)

		if cfg then
			self._txtImgDesc.text = cfg.desc
		end
	else
		goutil.setActive(self._showTipGo, false)
	end
end

function HelpDragonMomGameView:_clearShowTipIcon()
	uGuiUtil.clearImage(self._mainImg)
end

function HelpDragonMomGameView:_initStartGameGo()
	goutil.setActive(self._btnStartGame.gameObject, true)
end

function HelpDragonMomGameView:_initOthers()
	self._txtDesc.text = string.format("单局最多%d点", self._cfgActivity.maxScore)
	self._txtNum.text = string.format("%d", self._curGameScore)
	self._tempStr = ""
	self._weightCount = 3
	self._totalWeight = self:_getTotalWeight()
	self._oneStageNum = self._scoreCfgs[1].weight
	self._twoStageNum = self._oneStageNum + self._scoreCfgs[2].weight
	self._txtCountdown.text = string.format("%d秒", Mathf.Ceil(self._cfgActivity.countdown))

	self._leftChuizi:Play("chuiziqiaoji", 0, 1)
	self._rightChuizi:Play("chuiziqiaoji", 0, 1)
	goutil.setActive(self._leftEffect, false)
	goutil.setActive(self._rightEffect, false)
end

function HelpDragonMomGameView:_getTotalWeight()
	local num = 0

	for i, v in ipairs(self._scoreCfgs) do
		num = num + v.weight
	end

	return num
end

function HelpDragonMomGameView:_startGame()
	goutil.setActive(self._btnStartGame.gameObject, false)

	self._isPlaying = true
	self._curCountdown = self._cfgActivity.countdown

	self:_playStoneEffect()
	goutil.setActive(self._leftEffect, true)
	goutil.setActive(self._rightEffect, true)
end

function HelpDragonMomGameView:_endGame()
	if not self._isPlaying then
		return
	end

	self._isPlaying = false

	local title = "游戏结束"
	local text = string.format("本次获得能量点:%d", self._curGameScore)

	local function func()
		self:close()
	end

	TipsFacade.instance:openTipWindowValidX(title, text, func, btnText)
end

function HelpDragonMomGameView:_saveScoreReq()
	HelpDragonMomAgent.instance:sendPM_HelpDragonMomChallengeReq(self._activityId, self._curGameScore)
end

function HelpDragonMomGameView:_getRandomScore()
	local randomNum = math.random(1, self._totalWeight)
	local cfg = self._scoreCfgs[1]

	cfg = randomNum <= self._oneStageNum and self._scoreCfgs[1] or randomNum <= self._twoStageNum and self._scoreCfgs[2] or self._scoreCfgs[3]

	return cfg.score, cfg.desc
end

function HelpDragonMomGameView:_setCurGameScore()
	if not self._isPlaying then
		return
	end

	local randomScore, desc = self:_getRandomScore()

	self._curGameScore = self._curGameScore + randomScore

	if self._curGameScore < self._cfgActivity.maxScore then
		self._tempStr = string.nilorempty(self._tempStr) and desc or string.format("%s\n%s", desc, self._tempStr)

		if self._curGameScore > self._cfgActivity.maxScore then
			self._curGameScore = self._cfgActivity.maxScore or self._curGameScore
		end
	else
		self._curGameScore = self._cfgActivity.maxScore
	end

	self:_playScoreEffect(randomScore)
end

function HelpDragonMomGameView:_playStoneEffect()
	local path = HelpDragonMomGameViewPresentor.StonePath
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._effectParent.transform, 0, 0, true, false)

	uiEffect:setParent(self._effectParent.transform)
	uiEffect:setScale(0.7)
	uiEffect:setLocalPos(0, 0, 0)

	self._stoneEffect = uiEffect
end

function HelpDragonMomGameView:_removeStoneEffect()
	if self._stoneEffect then
		UIEffectManager.instance:stopEffect(self._stopEffect)

		self._stoneEffect = nil
	end
end

function HelpDragonMomGameView:_getScorePath(randomScore)
	if randomScore >= 0 and randomScore <= 4 then
		return HelpDragonMomGameViewPresentor.ScorePath1
	elseif randomScore > 4 and randomScore <= 9 then
		return HelpDragonMomGameViewPresentor.ScorePath5
	else
		return HelpDragonMomGameViewPresentor.ScorePath10
	end
end

function HelpDragonMomGameView:_playScoreEffect(randomScore)
	local randomX = math.random(self._xMin, self._xMax)
	local randomY = math.random(self._yMin, self._yMax)
	local bombPath = HelpDragonMomGameViewPresentor.BombPath
	local uiBombEffect = UIEffectManager.instance:playEffect(self, bombPath, self._randomAreaRectTrans.transform, 0, 0, true, false)

	uiBombEffect:setParent(self._randomAreaRectTrans.transform)
	uiBombEffect:setScale(1)
	uiBombEffect:setLocalPos(randomX, randomY, 0)
	uiBombEffect:setSortingOrder(215)

	local path = self:_getScorePath(randomScore)
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._randomAreaRectTrans.transform, 0, 0, true, false)

	uiEffect:setParent(self._randomAreaRectTrans.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(randomX, randomY, 0)
	uiEffect:setSortingOrder(215)
end

function HelpDragonMomGameView:_playBtnEffect()
	local path = "20220602/zhengjiulongyanmq/fx_ui_zjlymqanniu.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._leftEffect.transform, 0, 0, true, false)

	uiEffect:setParent(self._leftEffect.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._leftUIEffect = uiEffect

	local uiRightEffect = UIEffectManager.instance:playEffect(self, path, self._rightEffect.transform, 0, 0, true, false)

	uiRightEffect:setParent(self._rightEffect.transform)
	uiRightEffect:setScale(1)
	uiRightEffect:setLocalPos(0, 0, 0)

	self._rightUIEffect = uiRightEffect
end

function HelpDragonMomGameView:_removeBtnEffect()
	if self._leftUIEffect then
		UIEffectManager.instance:stopEffect(self._leftUIEffect)

		self._leftUIEffect = nil
	end

	if self._rightUIEffect then
		UIEffectManager.instance:stopEffect(self._rightUIEffect)

		self._rightUIEffect = nil
	end
end

return HelpDragonMomGameView
