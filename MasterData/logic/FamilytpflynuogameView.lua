-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/flynuo/FamilytpflynuogameView.lua

module("logic.extensions.familyteamplay.view.game.flynuo.FamilytpflynuogameView", package.seeall)

local FamilytpflynuogameView = class("FamilytpflynuogameView", ViewComponent)
local fillImgSizeY = 770

function FamilytpflynuogameView:ctor()
	FamilytpflynuogameView.super.ctor(self)

	self._imgFillVector2 = Vector2.New(0, 10)
end

function FamilytpflynuogameView:buildUI()
	FamilytpflynuogameView.super.buildUI(self)

	self._boundBg = self:getGo("boundBg").transform
	self._playerCon = self:getGo("root/playercon/player")
	self._pipeCon = self:getGo("root/pipeCon")
	self._gameStartTip = self:getGo("gameStartTip")
	self._heartChanges = {}

	for i = 1, 3 do
		self._heartChanges[i] = self:getGo("scoreBg/hearts/heart" .. i):GetComponent(ComponentType.UIImageSpriteChange)
	end

	self._fillImgTr = self:getGo("scoreBg/scoreRewardCon/fillBg/fillImg").transform
	self._currScoreText = goutil.findChildTextComponent(self.mainGO, "scoreBg/currScoreText")
	self._pipeParent = self:getGo("root/pipeCon").transform
	self._pipeCellGo = self:getGo("root/pipeCon/cell")
	self._bgComp1 = self:getGo("moveBgCon/bg1"):GetComponent(ComponentType.TweenPosition)
	self._bgComp2 = self:getGo("moveBgCon/bg2"):GetComponent(ComponentType.TweenPosition)
	self._scoreCell = self:getGo("scoreBg/scoreRewardCon/cell")
	self._scoreCellParent = self:getGo("scoreBg/scoreRewardCon/scoreCellParent")
	self._scoreCellGroup = ItemGroup.New(self._scoreCellParent, self._scoreCell, nil, nil, true)

	goutil.setActive(self._pipeCellGo, false)
	goutil.setActive(self._scoreCell, false)
	self:_setImgFill(0)

	self._reduceHpGo = self:getGo("reduceHp")
	self._reduceHpTweenPos = self._reduceHpGo:GetComponent(UnityTweensType.TweenPosition)
	self._reduceHpCanvasGroup = self._reduceHpGo:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._reduceHpCanvasGroup.alpha = 0
	self._effectGo = self:getGo("effect")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
	self._txtLeftTime.text = ""
end

function FamilytpflynuogameView:bindEvents()
	FamilytpflynuogameView.super.bindEvents(self)
end

function FamilytpflynuogameView:unbindEvents()
	FamilytpflynuogameView.super.unbindEvents(self)
end

function FamilytpflynuogameView:destroyUI()
	FamilytpflynuogameView.super.destroyUI(self)
end

function FamilytpflynuogameView:onEnter()
	FamilytpflynuogameView.super.onEnter(self)
	GlobalDispatcher:addListener(FamilytpFlynuoGameController.HpChange, self._updateHp, self)
	GlobalDispatcher:addListener(FamilytpFlynuoGameController.ScoreChange, self._updateScore, self)
	self:_gameInit()
	self:_updateView()
	self:_updateScore()
end

function FamilytpflynuogameView:onEnterFinished()
	FamilytpflynuogameView.super.onEnterFinished(self)

	FamilyteamplayModel.instance.flyNuoPlayViewIsOpen = true

	local moveSpeed = FlyNuoConfig.instance:getBgMoveSpeed()

	if moveSpeed <= 0 then
		self._bgComp1:Stop()
		self._bgComp2:Stop()
	else
		local bgMoveTime = math.ceil(2048 / moveSpeed)

		self._bgComp1.time = bgMoveTime
		self._bgComp2.time = bgMoveTime

		self._bgComp1:Begin()
		self._bgComp2:Begin()
	end
end

function FamilytpflynuogameView:onExit()
	FamilytpflynuogameView.super.onExit(self)
	FamilytpFlynuoGameController.instance:realEngGame()
	self._player:onExit()
	self._reduceHpTweenPos:Stop()
	UIEffectManager.instance:stopEffect(self._guideEffectHandler)

	self._reduceHpCanvasGroup.alpha = 0

	removetimer(self._updateReduceHpAlpha, self)
	removetimer(self._updateTimer, self)
	GlobalDispatcher:removeListener(FamilytpFlynuoGameController.HpChange, self._updateHp, self)
	GlobalDispatcher:removeListener(FamilytpFlynuoGameController.ScoreChange, self._updateScore, self)
end

function FamilytpflynuogameView:onExitFinished()
	FamilytpflynuogameView.super.onExitFinished(self)
end

function FamilytpflynuogameView:_gameInit()
	self._gameId = checknumber(self:getFirstParam())

	self:_setScore(0)
	self:_updateHp()
	goutil.setActive(self._gameStartTip, true)

	self._player = GameUtil.AddLuaOnce(self._playerCon, FlynuoPlayer)

	self._player:onEnter(self)
	FamilytpFlynuoGameController.instance:gameInit(self._gameId, self, self._player, self._pipeParent, self._pipeCellGo)

	local cfg = FamilyteamplayConfig.instance:getSmallGameCfg(self._gameId)

	self._leftTime = cfg.gameTime
	self._txtLeftTime.text = self._leftTime > 0 and FamilyteamplayModel.instance:formatLeftTimeStr(self._leftTime) or ""
end

function FamilytpflynuogameView:startGame()
	if self._leftTime > 0 then
		self:_setTimer()
	end

	goutil.setActive(self._gameStartTip, false)
end

function FamilytpflynuogameView:_setTimer()
	settimer(1, self._updateTimer, self, true)
	self:_updateTimer()
end

function FamilytpflynuogameView:_updateTimer()
	self._leftTime = self._leftTime - 1

	if self._leftTime <= 0 then
		removetimer(self._updateTimer, self)
		FloatWordMgr.instance:show("游戏时间耗尽，即将结算")
		FamilytpFlynuoGameController.instance:endGame()
	else
		self._txtLeftTime.text = FamilyteamplayModel.instance:formatLeftTimeStr(self._leftTime)
	end
end

function FamilytpflynuogameView:_updateView()
	local prizeCfgs = FamilyteamplayConfig.instance:getSmallGamePrizeCfgs(self._gameId)
	local newCfgs = {}

	for k, v in pairs(prizeCfgs) do
		table.insert(newCfgs, v)
	end

	table.sort(newCfgs, function(a, b)
		return a.score < b.score
	end)

	self._prizeCfgs = newCfgs
	self._scoreCellSpace = fillImgSizeY / #newCfgs

	self._scoreCellGroup:updateWithMoArray(newCfgs, self._updateScoreCell, self)
end

function FamilytpflynuogameView:_updateScoreCell(item, cfg)
	local txtProgress = goutil.findChildTextComponent(item.mainGO, "txtProgress")

	txtProgress.text = cfg.score

	GameUtil.setLocalPos(item.mainGO, item.index * self._scoreCellSpace - 20, -41.5)
end

function FamilytpflynuogameView:_updateScore()
	local currScore = FamilyteamplayModel.instance:getFlynuoScore()
	local fill = 0
	local len = #self._prizeCfgs

	if self._prizeCfgs and self._prizeCfgs[len] then
		local step = 1 / len

		if currScore >= self._prizeCfgs[len].score then
			fill = 1
		else
			local nextScore = 0
			local lastScore = 0

			for i, v in ipairs(self._prizeCfgs) do
				if currScore >= v.score then
					fill = fill + step
					lastScore = v.score
				else
					nextScore = v.score

					break
				end
			end

			fill = fill + (currScore - lastScore) / (nextScore - lastScore) * step
		end
	end

	self:_setImgFill(fill)
	self:_setScore(currScore)
end

function FamilytpflynuogameView:_setScore(num)
	self._currScoreText.text = "当前积分\n" .. GameUtil.HtmlColorTxt(num, "#fffffff")
end

function FamilytpflynuogameView:_updateHp()
	local hp = FamilyteamplayModel.instance:getFlyNuoHp()

	for i, v in ipairs(self._heartChanges) do
		goutil.setActive(v.gameObject, false)
	end

	for i = 1, hp do
		goutil.setActive(self._heartChanges[i].gameObject, true)
	end
end

function FamilytpflynuogameView:_setImgFill(num)
	self._imgFillVector2.x = fillImgSizeY * (num / 1)
	self._fillImgTr.sizeDelta = self._imgFillVector2
end

function FamilytpflynuogameView:isHit()
	goutil.setActive(self._reduceHpGo, true)
	self._reduceHpTweenPos:Begin()

	self._alphaChangeTime = ServerTime.nowMs()

	settimer(0, self._updateReduceHpAlpha, self, true)
end

function FamilytpflynuogameView:_updateReduceHpAlpha()
	local msTime = 800
	local goTime = ServerTime.nowMs() - self._alphaChangeTime

	if msTime <= goTime then
		removetimer(self._updateReduceHpAlpha, self)

		self._reduceHpCanvasGroup.alpha = 0
	end

	self._reduceHpCanvasGroup.alpha = 1 - goTime / msTime
end

return FamilytpflynuogameView
